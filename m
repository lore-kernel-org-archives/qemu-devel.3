Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2262C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdbR-0001yL-83; Thu, 30 May 2024 07:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sCdbO-0001xc-C4
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:05:46 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sCdbL-0007j5-QX
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:05:46 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52b7ca4ad02so770835e87.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 04:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717067141; x=1717671941; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zT+LYfu4WJnktr3rJHBVcHdzxYjcteKVK/qmUJRP9t8=;
 b=hxBDoJaXjvKAM1CIwLiQeXXC/tzYoPxKtxXFFALz25d7DwQn5KCplJ2HNSWLoEnd9h
 Af+rkCloTU34VoqWIoV2WqB1oawnbx4MTAjOJrljgv2iTGWNIvNYEN8O6lMrFF0OBAwn
 HBsZtsqh6vqeVFMaQfCtPc3TmKxYwe5Wa+TkY+dNY0dz3wlYflJAaA77zsCLP5gkk4fH
 LPOJ6MpXV5WLjteAZeCEL7ew5CEdnF6VO7Nvt0Fh0HQ/mJgC/oqefvasM+Pb9T9/6l23
 RKRVkXkRgdqej7Qu7nXzZgXABvsBeXzXA3RD3Ei1wm0mbah9qwWIb5AHoxh89TYlqS9A
 7V5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717067141; x=1717671941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zT+LYfu4WJnktr3rJHBVcHdzxYjcteKVK/qmUJRP9t8=;
 b=NfWhHy0DVmMcJjxBTRkz3H8YQzWbebuCI+YM49XlGQiewora4+3MJJ2KxWCFBSzHgl
 EdppD0rKwsfLamZGNPUtc2RqpuNVQBS5xRJsiSRgv4mpgs7tKE4xdepT1V7QZ4xKI1VM
 YslUTujqpjpQogfRsqyzVTanXOBIo9n6iGCBeDhBEEaElUHuuwM5/3tMzjSYufpStkgG
 MHSiLfSJymEWc4KRkAnlpVTygqLg0D/bARR0vjCx6THWI+iBoslFfHsT3p49vi0WHcAO
 DKAT7Zgh0sYEOeeZanGWYFvvolRiZXFI8z/iUqnK5/mCzdAbIgBqE0IJJLCA44r03iGR
 SYWQ==
X-Gm-Message-State: AOJu0YwUNUm6DFPhBeOtrAgbZMwTVHTVOR0e9WKI5Cvo+jVcLPy5Yabn
 Qz+32QO/ShrWTUThz43W40Fq+xaZ1Sn+BGZzjJldBhkfy4doKaegb9wVH1PwYrw=
X-Google-Smtp-Source: AGHT+IE3UngvJ6E8dCACH+vUW/R6dsn+ed2P25KAwjw3tFKNMp2iOR08P+kp69cXPhnDKQr1ltWh6g==
X-Received: by 2002:a05:6512:4883:b0:526:81ab:191 with SMTP id
 2adb3069b0e04-52b7d48c5eemr1137293e87.60.1717067140869; 
 Thu, 30 May 2024 04:05:40 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a66d627a25csm11160166b.96.2024.05.30.04.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 04:05:40 -0700 (PDT)
Date: Thu, 30 May 2024 13:05:39 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH] hw/riscv/virt.c: add address-cells in
 create_fdt_one_aplic()
Message-ID: <20240530-45111cf8b1ee719f055d234f@orel>
References: <20240530084949.761034-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530084949.761034-1-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=ajones@ventanamicro.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 30, 2024 at 05:49:49AM GMT, Daniel Henrique Barboza wrote:
> We need #address-cells properties in all interrupt controllers that are
> referred by an interrupt-map [1]. For the RISC-V machine, both PLIC and
> APLIC controllers must have this property.
> 
> PLIC already sets it in create_fdt_socket_plic(). Set the property for
> APLIC in create_fdt_one_aplic().
> 
> [1] https://lore.kernel.org/linux-arm-kernel/CAL_JsqJE15D-xXxmELsmuD+JQHZzxGzdXvikChn6KFWqk6NzPw@mail.gmail.com/

There are other issues[2] with the DT nodes that we should address at the
same time.

[2] https://lore.kernel.org/all/20240529-rust-tile-a05517a6260f@spud/

Thanks,
drew

> 
> Suggested-by: Anup Patel <apatel@ventanamicro.com>
> Fixes: e6faee65855b ("hw/riscv: virt: Add optional AIA APLIC support to virt machine")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/virt.c         | 2 ++
>  include/hw/riscv/virt.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 4fdb660525..1a7e1e73c5 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -609,6 +609,8 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
>      aplic_name = g_strdup_printf("/soc/aplic@%lx", aplic_addr);
>      qemu_fdt_add_subnode(ms->fdt, aplic_name);
>      qemu_fdt_setprop_string(ms->fdt, aplic_name, "compatible", "riscv,aplic");
> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
> +                          FDT_APLIC_ADDR_CELLS);
>      qemu_fdt_setprop_cell(ms->fdt, aplic_name,
>                            "#interrupt-cells", FDT_APLIC_INT_CELLS);
>      qemu_fdt_setprop(ms->fdt, aplic_name, "interrupt-controller", NULL, 0);
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 3db839160f..c0dc41ff9a 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -118,6 +118,7 @@ enum {
>  #define FDT_PLIC_ADDR_CELLS   0
>  #define FDT_PLIC_INT_CELLS    1
>  #define FDT_APLIC_INT_CELLS   2
> +#define FDT_APLIC_ADDR_CELLS  0
>  #define FDT_IMSIC_INT_CELLS   0
>  #define FDT_MAX_INT_CELLS     2
>  #define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
> -- 
> 2.45.1
> 
> 

