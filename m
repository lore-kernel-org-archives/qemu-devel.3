Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F37C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkiol-0000w1-S4; Fri, 17 Jul 2026 09:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wkiok-0000vd-Ik
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:41:30 -0400
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wkioh-0000QC-Po
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:41:30 -0400
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-38de693676dso4725838a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784295683; x=1784900483; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hgO7+jfPuZxSGxRCtbImJK+jv0yfYEiTJY18hsEYvH0=;
 b=kSpgFMsm5cV+MWqsw8xOonJqBwKfpqldgodAVfzSpc7/fBNVMBG7wTbEGFdalX6p6R
 Pc5G7ITubMUDAAC7WDryd1BrDI1KTzuJX4C/6ZwmUHBSeeheTjoDcqLg9t41tNYcXIht
 7HqRBCP63U0Pxhy28wkTBRNuEdzR9jVNoNzi4lXFo+utKpcZYtlQXPvukqTPgYlULopU
 jISYOt9DI7UZP5G2WoczJrkAf5qT0RDDFcAhXcUpZlqcn4DT/tD4qaxVOfRBcIHawFlv
 dZOS8Ns+7wgnQJ2AycX0z0JYDH9MOKZhYGgvrjZ8+uldP+JZs+XQ/DRL5w7j4nmaT3bq
 VgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784295683; x=1784900483;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hgO7+jfPuZxSGxRCtbImJK+jv0yfYEiTJY18hsEYvH0=;
 b=NOcDeQz2kSEmdy5PMU7Xv+fWHwo1wvOcno0eHpUJvE3PAYTI3uGse6Rygh6jYqVF+x
 zFtaZjFp2eMP4Ls1LmsstByllzYQhsc982oFc20BH+RxoBrWqFPrLQw0GghOt4Kkr7Mq
 CkT1ZqquefK6uss0BZLj2V8QdSovazuqRAXdzHH9KmirH0zB7RdUsgbafTBt2eKW1je0
 Z+laE3mTWhckBZb9dvyyT2GPaiBkYnKSOWAPn7TNpxfMt+wSDyoFp4/vh4ndEpqg0La3
 /NVnEyfjgYXK10Vo1603uuyM6+8Ui+pCeaEbEXC6oE7guW0PZpim4vGgjw6SgA9OCbN1
 rJ6w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+FxbNha7GwMfcWi7vuMbbPA2/yT4AkgIJI7mTzjVnG3nLfVxngEcc0I4PxxoUg+SMKHSeeabr+S0w@nongnu.org
X-Gm-Message-State: AOJu0YwAM4ijWa+4VGt8nwMyUhy+Mg6/xrMQy/7viqMktwffjNoZKIl0
 Roa5vF5eJl/uduZQEhc0OBRPHxr/O07l5oxUGLjyCokPQP5Q6AhuEU1F
X-Gm-Gg: AfdE7cn1wAaw5SVwjwhcKCcg3IsvvOiU5e0CzNFTQNFpndFFTiIf0SncV7Zk8r5epXu
 XSS6H7P4js5Re73TWExnBh7SZcdFB93BfObALxOrwj4YqUsDlnSYTkiRskgV6Abk27/XJQPaYKY
 ULAtHP//12a9xaj4HqtB4uxd7dBOEcnLF+OisKJmMkHPofr1MZ9CteaaFVmRhiEDwKDwppO8zKX
 DMBdwiOEkttcEijlaqj111otntQOr2jEjt19n5ln5BlxWgZHffu3XRyxPS3Z8P0+74hKNx4CI6x
 cyF/gxiHd+4urbtgqaVJmW74coHVEOAFa9QHRPKMYg0nxdmtU1+UwgtPy3bgua7GksF0ikW6qwv
 +X8BL7QSduzgNyj6ydzvN+A8YtvFkPOXbBT6ipw128D/YHfvvyaiHIK/p3x7vFz2cct5g5WfHtc
 vHNDCcw2/GW43MIZlOKP9CX/7JsvsHUwzjNF66fUy9yyqKlMmOct8=
X-Received: by 2002:a17:90b:4a08:b0:380:9157:d6c with SMTP id
 98e67ed59e1d1-38e4b41043cmr2924481a91.10.1784295682612; 
 Fri, 17 Jul 2026 06:41:22 -0700 (PDT)
Received: from localhost ([179.255.148.148]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429fe4677sm6704123eec.11.2026.07.17.06.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 06:41:21 -0700 (PDT)
Date: Fri, 17 Jul 2026 21:41:18 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: jack wang <163wangjack@gmail.com>, qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:K230 Machines" <qemu-riscv@nongnu.org>
Subject: Re: [RFC PATCH 2/2] hw/riscv/k230: wire up the RMU device
Message-ID: <aloupwOnk4bggOy5@ChaodeMacBook-Pro.local>
References: <20260709031237.21284-1-163wangjack@gmail.com>
 <20260709031237.21284-3-163wangjack@gmail.com>
 <9e600f36-96ac-4eb9-a901-47d4ea6cc748@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e600f36-96ac-4eb9-a901-47d4ea6cc748@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:39::b;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj2-x0b.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PDS_OTHER_BAD_TLD=2, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 16, 2026 at 02:56:30PM +0800, Daniel Henrique Barboza wrote:

Hi Daniel,
> Hi,
> 
> On 7/9/2026 12:12 AM, jack wang wrote:
> > From: Jack Wang <163wangjack@gmail.com>
> > 
> > Replace the "rmu" create_unimplemented_device() stub with a real
> > K230RmuState instance mapped at the K230_DEV_RMU memmap entry, select
> > K230_RMU from the K230 Kconfig, and document the device.
> 
> So, as I said in patch 1, applying this patch will fix the qtest that you
> introduced there.  I believe we want to either squash this patch in patch
> 1 or move the qtest creation to this patch.  Both are fine to me.
> 
> > 
> > Closes: gevico/qemu-camp-2026-k230#11
> 
> Not sure what gevico is (seems like a bootcamp, according to Google at least)  but
> the "Closes" tag usually contains a gitlab bug or any other link that is publicly
> available.  It's better to remove it.
> 
I believe this link refers to:
https://github.com/gevico/qemu-camp-2026-k230/issues/11

However, according to the QEMU development collaboration workflow,
we don't need to add it.

Gevico, here is the English transliteration for the Chinese "格维". This
is a major open-source community in China focused on technical software,
which I currently organize and own.

Within our community, we run a QEMU technical training camp primarily
centered on the RISC-V architecture and exploratory work regarding
GPGPU microarchitecture.

One of our key projects involves hardware modeling for the K230, where
we are implementing a digital satellite-borne computer. The recent
contributions seen upstream were primarily patches sent by participants
of this project. We are currently in the process of contributing our
results from this stage to the QEMU upstream.

If you are interested in this, you can visit the link below.
https://qemu.gevico.online/tutorial/2026/ch3/qemu-k230/

Thanks,
Chao
> 
> Thanks,
> Daniel
> 
> 
> > Signed-off-by: Jack Wang <163wangjack@gmail.com>
> > ---
> >   docs/system/riscv/k230.rst |  1 +
> >   hw/riscv/Kconfig           |  1 +
> >   hw/riscv/k230.c            | 10 +++++++---
> >   include/hw/riscv/k230.h    |  2 ++
> >   4 files changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
> > index cea8202e55..3f2313a127 100644
> > --- a/docs/system/riscv/k230.rst
> > +++ b/docs/system/riscv/k230.rst
> > @@ -19,6 +19,7 @@ The ``k230`` machine supports the following devices:
> >   * Core Local Interruptor (CLINT)
> >   * Platform-Level Interrupt Controller (PLIC)
> >   * 2 K230 Watchdog Timer
> > +* K230 Reset Management Unit (RMU)
> >   * 5 UART
> >   Boot options
> > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > index 54e41a6afc..bffa4e69c8 100644
> > --- a/hw/riscv/Kconfig
> > +++ b/hw/riscv/Kconfig
> > @@ -149,3 +149,4 @@ config K230
> >       select SERIAL_MM
> >       select UNIMP
> >       select K230_WDT
> > +    select K230_RMU
> > diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> > index 502281c52c..b55e90c0d2 100644
> > --- a/hw/riscv/k230.c
> > +++ b/hw/riscv/k230.c
> > @@ -110,6 +110,7 @@ static void k230_soc_init(Object *obj)
> >       object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
> >       object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
> >       object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
> > +    object_initialize_child(obj, "k230-rmu",  &s->rmu,    TYPE_K230_RMU);
> >       qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
> >       qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
> > @@ -206,6 +207,12 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
> >       sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
> >                          qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
> > +    /* RMU (reset management unit) */
> > +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rmu), errp)) {
> > +        return;
> > +    }
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rmu), 0, memmap[K230_DEV_RMU].base);
> > +
> >       /* unimplemented devices */
> >       create_unimplemented_device("kpu.l2-cache",
> >                                   memmap[K230_DEV_KPU_L2_CACHE].base,
> > @@ -268,9 +275,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
> >       create_unimplemented_device("cmu", memmap[K230_DEV_CMU].base,
> >                                   memmap[K230_DEV_CMU].size);
> > -    create_unimplemented_device("rmu", memmap[K230_DEV_RMU].base,
> > -                                memmap[K230_DEV_RMU].size);
> > -
> >       create_unimplemented_device("boot", memmap[K230_DEV_BOOT].base,
> >                                   memmap[K230_DEV_BOOT].size);
> > diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> > index 592e1c26bf..13f2a1ab0b 100644
> > --- a/include/hw/riscv/k230.h
> > +++ b/include/hw/riscv/k230.h
> > @@ -18,6 +18,7 @@
> >   #include "hw/core/boards.h"
> >   #include "hw/riscv/riscv_hart.h"
> >   #include "hw/watchdog/k230_wdt.h"
> > +#include "hw/misc/k230_rmu.h"
> >   #define C908_CPU_HARTID   (0)
> > @@ -33,6 +34,7 @@ typedef struct K230SoCState {
> >       RISCVHartArrayState c908_cpu; /* Small core */
> >       K230WdtState wdt[2];
> > +    K230RmuState rmu;
> >       MemoryRegion sram;
> >       MemoryRegion bootrom;
> 

