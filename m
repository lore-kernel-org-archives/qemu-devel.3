Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C4DCD98F0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 04:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbsYL-0001rL-Bg; Tue, 23 Jun 2026 00:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wbsYF-0001qp-LQ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 00:15:56 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wbsYD-00054Y-7Y
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 00:15:54 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-30bc871ecdfso6112957eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782188152; x=1782792952; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MLGLvtRnVcxBxBbGHEo0MK87nSnrcvBtXArVRINExhY=;
 b=LhnEHTQq+yixLfphBVK8xOzR12AaCjF/b7UOy7kagBOvry9VshuK7UQHNX+QPxkNJb
 MggzuAJgH+TKcSIZLk2isy86ti+XTBMRyNGwgntGlJCzglLDA1qcoHsHVY5I/N4yDuVd
 vywbdYTT2s3uhiDRDW6WR+6a1yVnGFRmK84FFb2DJrQjhk92JOZLKoAaJVDAnaYt7Zf4
 XD/iMgKACIc5kl9KguRcRBN7AYkuVpEnARpgDogY475a5ZWIEOx3qxc6+o1+Rs0rUW8K
 ipAlB9v9PwKPmzlcS0DTwXIQZQzP7UoEhKUzirhzsJAKbvUvUAgheKaGKe2T68MYYX4J
 Ob6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782188152; x=1782792952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MLGLvtRnVcxBxBbGHEo0MK87nSnrcvBtXArVRINExhY=;
 b=ZufRmTNzuq7sV++1VTCIYlweKFP+fOI+V2blwCMbk3+mpg36oLAlScm6gToofCOveI
 s5VWomw6CdVSwFEiXAxSf1sq88YE8xuhDiySPrKzXzJ98zY6JufDGfsXQuH1227pcwiZ
 AiTyMw0k18y8VQLgK6qViETg5ZOtp4Cwyr2yYkg7a18XBAZNWSdUlv/Wki8ni3jGR7uj
 aGvea5RuQ/BQd7p/Oo/RSkQNdvGBtL+yV+4CjTsu9gS8PZD89VqhYWA4KX51zEMMKcxb
 wZU1o6FSjfoR4vLdW8hlgT3f3KSnh1AUMFXe4uQjoDJO8haZSyV8Bn/1iSEKzIRORwbX
 Xgfw==
X-Gm-Message-State: AOJu0YxPaZbudxHN560iRwFIQc3ADcxpWW8z5ap+SIjE5JwgMOHMaqEP
 CsRFS35XvMBh+muYixfC8sYh5yKq1P7MMIuO/HwkvAl1BUsfw1yXtwEt
X-Gm-Gg: AfdE7cmuXWiPd72X5XU9KtztIS82U+OB5VgKqOWgxJbPXT7n+iadMczmXJVP8WOZM0t
 Oj+pSa0/+76RUHWhcjUElscAhzoTUE6f0QTW93+dvdRp/xzPvdM6YOJK298njgChXu5qoIawzXT
 zxAN+yFHYmdIjIqKvuzPxINwEnoGYZ4mf9T9WhwaB+k7p7ZttzWvrIy4ITorysXPhSsVsn5nIPe
 wsLsY4jtlslbqKWuTJ2kgK5KjCeuGyqIokQ5zp0BiWg7nYshQhEksr8omNj1l6nh2i3P0k5AGQz
 sN0/4yZdvQ1GXc3PjI6u3lPCWah+RgJJ/LuhtcU5Uar2es9tXBilklhbOtG4YatWvX/Xi3sEg23
 fhz9FstsTT8nA/i9381IU+jpspIqjNfO21dDh6J6JEbWcaYvysfD52gV1xPHoerybJXrhHDMiSe
 WpOWlkWOBhJNmuU1tYbgP1RJKU8NBSK67rXhkVeud/Dzk4PoWI
X-Received: by 2002:a05:7301:9c90:b0:304:e2a5:689c with SMTP id
 5a478bee46e88-30c07001961mr12983331eec.21.1782188151730; 
 Mon, 22 Jun 2026 21:15:51 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba91120sm13506241eec.13.2026.06.22.21.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 21:15:50 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:15:47 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 4/5] hw/riscv/virt.c: change 'plic' nodename to
 'interrupt-controller'
Message-ID: <ajoIYVXCylVjKQGK@ChaodeMacBook-Pro.local>
References: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
 <20260616235939.1358663-5-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616235939.1358663-5-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 16, 2026 at 08:59:38PM +0800, Daniel Henrique Barboza wrote:
> We're still using "/soc/plic@..." as FDT nodename in virt.c.  This is
> not the right nodename per the DT docs:
> 
> https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-controller/sifive%2Cplic-1.0.0.txt
> 
> The nodename must be 'interrupt-controller@...' since the node inherits
> the 'interrupt-controller' type.  In fact, ever since at least the 2020
> Linux kernel commit c825a081c169cc7f ("dt-bindings: riscv: convert plic
> bindings to json-schema") the correct nodename has been
> 'interrupt-controller' for the sifive PLIC controller.
> 
> There's no deprecation needed for bug fixes so we're just fixing the
> name.  This was the policy we dud when fixing the aplic [1] and the
> imsic [2] nodenames to 'interrupt-controller@...' as well.
> 
> The sifive_u PLIC FDT already uses the correct nodename for PLIC, so it
> is safe to assume that available SW is already aware of the correct
> nodename and this change won't affect well-behaved SW.
> 
> [1] commit 29390fd ("hw/riscv/virt.c: rename aplic nodename to 'interrupt-controller'")
> [2] commit e8ad581 ("hw/riscv/virt.c: change imsic nodename to 'interrupt-controller'")
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

> ---
>  hw/riscv/virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 33775a61fd..fa464e644f 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -335,7 +335,7 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
>      plic_phandles[socket] = (*phandle)++;
>      plic_addr = s->memmap[VIRT_PLIC].base +
>                  (s->memmap[VIRT_PLIC].size * socket);
> -    plic_name = g_strdup_printf("/soc/plic@%lx", plic_addr);
> +    plic_name = g_strdup_printf("/soc/interrupt-controller@%lx", plic_addr);
>      qemu_fdt_add_subnode(ms->fdt, plic_name);
>      qemu_fdt_setprop_cell(ms->fdt, plic_name,
>          "#interrupt-cells", FDT_PLIC_INT_CELLS);
> -- 
> 2.43.0
> 

