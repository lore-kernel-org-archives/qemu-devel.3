Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A655C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkjAl-0003Pl-3F; Fri, 17 Jul 2026 10:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wkjAi-0003Or-Id
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:04:12 -0400
Received: from mail-pj2-x03.google.com ([2607:f8b0:4864:39::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wkjAg-0003tU-Ex
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:04:12 -0400
Received: by mail-pj2-x03.google.com with SMTP id
 98e67ed59e1d1-381072761d4so4595880a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784297049; x=1784901849; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9Tlh1p+0MpBUPZUeJtfhE0GG60qOpcOT+2efT1WP/J4=;
 b=ODjOJlDfm5jlv2z5AEOlb2nDJtnBemGiMPkEHA/Y7GtJqrcEA1eErIFDEOGwxWVzUv
 MbXnXrNgo78NYLsi4+OUsBl2ceSmOxSbQsABIdNgN3BdGxqitqp8iB++tqvkmd4RfPzJ
 kl9rNtWvgj0lYU7zAmEU/5yTEQwjDUIPuQakshe4YU0J10HesQx90nhYcu7a6H9L2AKm
 JKtfhzpVUvlV2+AXpx1BKYYMWOrnchUOtjOU3SDGZp9fYW76A/qOSWnx45SDqm09TzRv
 6iw0Q/z+foSq8jIWqJLUWzrQzgI1VTHc9pqqXAJlJuGuc4zXcqb4DaVUAVMalT29z2sF
 EKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784297049; x=1784901849;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9Tlh1p+0MpBUPZUeJtfhE0GG60qOpcOT+2efT1WP/J4=;
 b=Xy3nZdCbDezSIfF2QqtRnB6rGudgVmI8GDEKkTh2LoB0i7Y1Zj6hYTIclynjhS/K/K
 AmVXCAKZwwo5Fdyr3uJ5A+xsnbv5z3jsJE7qunAg1Txe2/QLu0opeaqdz6K8s6NggmbF
 hCKswsEkMi4WebK7T4kY9wvMRagtDCKYrN5ZuM1jZVX7V+JXOoVckLiCjuMpcpk7Rcv5
 AyLawI9aN9a4Qd5s4N0auA5A4uuAXVxYY66dQBuZ7KSrKb8E7NHLM35ZkGPKOcAxsdEs
 AvitbH1WrOgqKvKAn5DDzzugM95NbT6y5jJ4XGjrMbimrxd+uJ80DMudWx4slFXd7CS/
 X8/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGOJxuvbd3ux0apzZlUr1Lt+2VMyi//7QG1bSHf13LZvoxdJiODbgFmEf6rKO0f00nrmL/DCPRddxv@nongnu.org
X-Gm-Message-State: AOJu0YwCjKTcX4ttabCm1yQiMOK8W4e2+EP/mvnR7HvBilTHn+RmxDG6
 vrM4r2VwhaFi3RBDwQLizRcPKPivn8Z3ueD09Ue8HfrKv8J6/eEKTDDE
X-Gm-Gg: AfdE7cn1FGK3gE55uz/7orG6XmQl5WVdejJZVSeSkS7QDB1eUbjoxx7QMS0+3aEpUUg
 PwxbXismhUamgzuWK1WuZCk01AoFLBDRgi2ZI6hTp1mqsbOXvXgV4shXkXXfwp+6I2xAbb8BjtK
 Y4OBHXNtP/njqXtA4gDFNE4Pt56Mv9UCARCXzu6O7jhkdEr7kTcnhOQDhdk0YQWd6Pm7sHinRi6
 1cxhFklDYl/3psASVpqOOZCOScoo+1YvIl2FhLeeNIvQ0KS5QskTeMSi9lHv+tH3nXqRVWW+mtA
 21N8KLiqyVkVA6mSKxRjRykLQT83PVpZ6X6l3x2F4yTfNnJ7qmOPfKWd1Mxnmwwl2FQzTKj4Fmv
 9VFH5At4vMcUF8l29yUbbxBCYBA5WF6HvtqyUn2r9tWbYdJ6VSf35VvpTFP+GQNiseQCE76kwO4
 llpqFbEIsPJqkiN4CDJH74dDd1V7NO7G6ts0eaawZK
X-Received: by 2002:a17:90b:5606:b0:36a:a16b:5f6d with SMTP id
 98e67ed59e1d1-38e4b41f4ffmr2816230a91.7.1784297048650; 
 Fri, 17 Jul 2026 07:04:08 -0700 (PDT)
Received: from localhost ([179.255.148.148]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1bb77csm8316828eec.18.2026.07.17.07.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 07:04:08 -0700 (PDT)
Date: Fri, 17 Jul 2026 22:04:05 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: jack wang <163wangjack@gmail.com>, qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:K230 Machines" <qemu-riscv@nongnu.org>
Subject: Re: [RFC PATCH 2/2] hw/riscv/k230: wire up the RMU device
Message-ID: <alo1wgC0ExaLLznS@ChaodeMacBook-Pro.local>
References: <20260709031237.21284-1-163wangjack@gmail.com>
 <20260709031237.21284-3-163wangjack@gmail.com>
 <9e600f36-96ac-4eb9-a901-47d4ea6cc748@oss.qualcomm.com>
 <aloupwOnk4bggOy5@ChaodeMacBook-Pro.local>
 <6225b3ef-461f-458e-9275-ec471d6fd2d6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6225b3ef-461f-458e-9275-ec471d6fd2d6@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:39::3;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj2-x03.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, Jul 17, 2026 at 10:56:17AM +0800, Daniel Henrique Barboza wrote:
> 
> 
> On 7/17/2026 10:41 AM, Chao Liu wrote:
> > On Thu, Jul 16, 2026 at 02:56:30PM +0800, Daniel Henrique Barboza wrote:
> > 
> > Hi Daniel,
> > > Hi,
> > > 
> > > On 7/9/2026 12:12 AM, jack wang wrote:
> > > > From: Jack Wang <163wangjack@gmail.com>
> > > > 
> > > > Replace the "rmu" create_unimplemented_device() stub with a real
> > > > K230RmuState instance mapped at the K230_DEV_RMU memmap entry, select
> > > > K230_RMU from the K230 Kconfig, and document the device.
> > > 
> > > So, as I said in patch 1, applying this patch will fix the qtest that you
> > > introduced there.  I believe we want to either squash this patch in patch
> > > 1 or move the qtest creation to this patch.  Both are fine to me.
> > > 
> > > > 
> > > > Closes: gevico/qemu-camp-2026-k230#11
> > > 
> > > Not sure what gevico is (seems like a bootcamp, according to Google at least)  but
> > > the "Closes" tag usually contains a gitlab bug or any other link that is publicly
> > > available.  It's better to remove it.
> > > 
> > I believe this link refers to:
> > https://github.com/gevico/qemu-camp-2026-k230/issues/11
> > 
> > However, according to the QEMU development collaboration workflow,
> > we don't need to add it.
> > 
> > Gevico, here is the English transliteration for the Chinese "格维". This
> > is a major open-source community in China focused on technical software,
> > which I currently organize and own.
> > 
> > Within our community, we run a QEMU technical training camp primarily
> > centered on the RISC-V architecture and exploratory work regarding
> > GPGPU microarchitecture.
> > 
> > One of our key projects involves hardware modeling for the K230, where
> > we are implementing a digital satellite-borne computer. The recent
> > contributions seen upstream were primarily patches sent by participants
> > of this project. We are currently in the process of contributing our
> > results from this stage to the QEMU upstream.
> 
> Thanks for the info.  This seems very interesting indeed, and please keep
> the QEMU contributions flowing :D
> 
Yes, sir. :)

Thanks,
Chao

> Cheers,
> Daniel
> 
> > 
> > If you are interested in this, you can visit the link below.
> > https://qemu.gevico.online/tutorial/2026/ch3/qemu-k230/
> > 
> > Thanks,
> > Chao
> > > 
> > > Thanks,
> > > Daniel
> > > 
> > > 
> > > > Signed-off-by: Jack Wang <163wangjack@gmail.com>
> > > > ---
> > > >    docs/system/riscv/k230.rst |  1 +
> > > >    hw/riscv/Kconfig           |  1 +
> > > >    hw/riscv/k230.c            | 10 +++++++---
> > > >    include/hw/riscv/k230.h    |  2 ++
> > > >    4 files changed, 11 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
> > > > index cea8202e55..3f2313a127 100644
> > > > --- a/docs/system/riscv/k230.rst
> > > > +++ b/docs/system/riscv/k230.rst
> > > > @@ -19,6 +19,7 @@ The ``k230`` machine supports the following devices:
> > > >    * Core Local Interruptor (CLINT)
> > > >    * Platform-Level Interrupt Controller (PLIC)
> > > >    * 2 K230 Watchdog Timer
> > > > +* K230 Reset Management Unit (RMU)
> > > >    * 5 UART
> > > >    Boot options
> > > > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > > > index 54e41a6afc..bffa4e69c8 100644
> > > > --- a/hw/riscv/Kconfig
> > > > +++ b/hw/riscv/Kconfig
> > > > @@ -149,3 +149,4 @@ config K230
> > > >        select SERIAL_MM
> > > >        select UNIMP
> > > >        select K230_WDT
> > > > +    select K230_RMU
> > > > diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> > > > index 502281c52c..b55e90c0d2 100644
> > > > --- a/hw/riscv/k230.c
> > > > +++ b/hw/riscv/k230.c
> > > > @@ -110,6 +110,7 @@ static void k230_soc_init(Object *obj)
> > > >        object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
> > > >        object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
> > > >        object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
> > > > +    object_initialize_child(obj, "k230-rmu",  &s->rmu,    TYPE_K230_RMU);
> > > >        qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
> > > >        qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
> > > > @@ -206,6 +207,12 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
> > > >        sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
> > > >                           qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
> > > > +    /* RMU (reset management unit) */
> > > > +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rmu), errp)) {
> > > > +        return;
> > > > +    }
> > > > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rmu), 0, memmap[K230_DEV_RMU].base);
> > > > +
> > > >        /* unimplemented devices */
> > > >        create_unimplemented_device("kpu.l2-cache",
> > > >                                    memmap[K230_DEV_KPU_L2_CACHE].base,
> > > > @@ -268,9 +275,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
> > > >        create_unimplemented_device("cmu", memmap[K230_DEV_CMU].base,
> > > >                                    memmap[K230_DEV_CMU].size);
> > > > -    create_unimplemented_device("rmu", memmap[K230_DEV_RMU].base,
> > > > -                                memmap[K230_DEV_RMU].size);
> > > > -
> > > >        create_unimplemented_device("boot", memmap[K230_DEV_BOOT].base,
> > > >                                    memmap[K230_DEV_BOOT].size);
> > > > diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> > > > index 592e1c26bf..13f2a1ab0b 100644
> > > > --- a/include/hw/riscv/k230.h
> > > > +++ b/include/hw/riscv/k230.h
> > > > @@ -18,6 +18,7 @@
> > > >    #include "hw/core/boards.h"
> > > >    #include "hw/riscv/riscv_hart.h"
> > > >    #include "hw/watchdog/k230_wdt.h"
> > > > +#include "hw/misc/k230_rmu.h"
> > > >    #define C908_CPU_HARTID   (0)
> > > > @@ -33,6 +34,7 @@ typedef struct K230SoCState {
> > > >        RISCVHartArrayState c908_cpu; /* Small core */
> > > >        K230WdtState wdt[2];
> > > > +    K230RmuState rmu;
> > > >        MemoryRegion sram;
> > > >        MemoryRegion bootrom;
> > > 
> 

