Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CC2C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weV8D-00011N-7F; Tue, 30 Jun 2026 05:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1weV8A-000113-9y
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 05:51:50 -0400
Received: from mail-dy2-x01.google.com ([2607:f8b0:4864:36::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1weV88-00082K-Qz
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 05:51:50 -0400
Received: by mail-dy2-x01.google.com with SMTP id
 5a478bee46e88-30caba1e09dso1836460eec.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 02:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782813107; x=1783417907; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZKli9fd5aKbsYS0I35YrO24NBNDjbi4f8Vgq1+cX8xs=;
 b=fn1WorIAmJak8dZV/DDvM+VX6smzLnF4oZLljocWL1G9lhomHxq550YIM8sckARMfn
 M0fW0CzA1uyZJclHcb0BYGx3X7Pb7VZ078/BTJNzbAZe7hmbhb0NpmPY3eqVqMqcPZeh
 K96TkfTMvPFtBNda127OpMxXaJcsUk2bbthf9e5tdMDXh9V8kfzGzIrrsIcT86RNJHbD
 3oV59Ih3oclisxywtEnvItSKb6r/wl7KZ+GJOvoRr/RvPG6wb+aNCQzR5uNcNSjekqf6
 5E921NjGCMG4Xl/+ez5cJplhklHe7rmBlRkgFhfhmC7+kIriJTpzzZ4Xznwc8yqhmfnW
 Y4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782813107; x=1783417907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKli9fd5aKbsYS0I35YrO24NBNDjbi4f8Vgq1+cX8xs=;
 b=tExTP3jWrGIUOk6Qh8IDkQzOBMzj60D0/gd8Ohar+xZk+yhaRCq/bTMEjkt0ohbXnL
 0SJw/FCoOAkM+bkBE8j9giLEr/KhFe2Bgv4bCGyupPnVCMK6agpEPY8btx94hjo8hXCw
 udzHFme9ZQ//ijEsM8RDP8x+j+pjEO/TbdlsiXLRHWPGGgY5ZoLsaAnyNpUogvEOOsoI
 wd/F8N402cL4gI6Qk+z/Ka45eVxx16dleXlWhzartsUWLzi9hzwfNizhIKs4Kv91evX3
 0zhhHzfJXpzEQWfeun3PgkXvvast/YBTa1ZeuFfUTMaoSAoz/ickvcaDh6ORLl6L6YFq
 qsVA==
X-Gm-Message-State: AOJu0YynUDMUT1xeR0Se8iU5v7NRl8aRmGrN4kBqdlsmrItk/ulj9LCT
 01mR12Xz3DPI2tf5mHIZ+sKXwcaTquQrZ0PSa8E8hhXnOQoaLXdbYEnr
X-Gm-Gg: AfdE7clGKcUX7I+c5ZaeUGXnhibFXe1WudNmSF9bxNACz2wM2tb5OYmbK4EWGIiqUj1
 0hSnGW9l4AmwbSEqF7tU90N0MrvIYa9DLH/WmNPn4HXjOoe0L5/IUjIZlNJZ8yV8ygLzHX8fArW
 Wm5+mzMU2dkDTqDImQH0f+9nvXIdwIQcq2DZasukTIfTk8OvJyeW8bzxVuba8lM6iadbSVWMI4H
 IlTlA6+9elqWjx9BAj7dl1J1rs+y+zWAAEMUIGhIHh5PxRRnxmM1z/wa9NX6Q/n5e1YS1v22Xy3
 D29TyJyvL7foKq/mWUUSoX7e79HqIKBY2IzbCTVpDUq1gM1VVMe1R+4DB0KKWdAETXhx1tuEOSr
 LvYJW2L/OSaJhjxHxReJ/6HCgQA0KYoQ4MGkwGJK32aPHuAIIXak4NxdVHkvJyb30Sik4JQ1ORD
 NOdBg7taTLHvEY1Khby7aXJhRT2hWwURMrlWz6ZtazL2wv8XNz
X-Received: by 2002:a05:7300:8626:b0:30c:ab97:d7ab with SMTP id
 5a478bee46e88-30ee13cbc48mr2209528eec.37.1782813106842; 
 Tue, 30 Jun 2026 02:51:46 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee326c7a7sm6712247eec.29.2026.06.30.02.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 02:51:46 -0700 (PDT)
Date: Tue, 30 Jun 2026 17:51:43 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 1/2] hw/riscv/riscv-iommu.c: check for reserved PTE bits
Message-ID: <akORpVVQ-C3FeSAH@ChaodeMacBook-Pro.local>
References: <20260629121334.567587-1-daniel.barboza@oss.qualcomm.com>
 <20260629121334.567587-2-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629121334.567587-2-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:36::1;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy2-x01.google.com
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

On Mon, Jun 29, 2026 at 09:13:33AM +0800, Daniel Henrique Barboza wrote:
> We need to fault if reserved PTE bits (60:54) are set.
> 
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3554
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  hw/riscv/riscv-iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index c9687e01a8..453601d7a5 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -468,6 +468,8 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>  
>          if (!(pte & PTE_V)) {
>              break;                /* Invalid PTE */
> +        } else if (pte & PTE_RESERVED(false)) {
> +            break;                /* Reserved PTE bits set */
>          } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
>              base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
>          } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
> -- 
> 2.43.0
> 

