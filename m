Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63463EF9002
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxouu-0008Vn-8Q; Wed, 04 Mar 2026 11:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxous-0008V8-6b
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:17:42 -0500
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxoup-0002fg-Gr
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:17:41 -0500
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-12776bebe9fso4871634c88.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772641058; x=1773245858; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lk0ZsDovUxZ+4dPsHMdQXY9PLTJTQ1RsLfc1yEMM6Yc=;
 b=ZgVtlqp6vL/RvTFX6uDsEC3FWPYX7mSgkImPBjPel2jkVGTYNBqQxgAUapNTwTOGh8
 MaxGq2cP5aTL9zT7vLTlO1FXfZ0z6Lfkxuwij3r7uTzV1nTVtJ21gDYdRTPfWxQW11Gm
 k4QXw59XTmMlXL2fDWQVOLA193XUwV7atSfHCPfiMU5HBFa0B781y/bp83lFJaEDXhS3
 pr3mrPtE5e4hrKMt7TxiPOSJv6281MnO0SaQPr0pMkBaaqrkuHdhcjPWWLbBROchN63L
 8v5LkbKMUL9m6zok+miOgpLTVF/cqNwowFggNPoCshKTGAWvzLb7qmCzAIitdi0RMvLp
 1gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772641058; x=1773245858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lk0ZsDovUxZ+4dPsHMdQXY9PLTJTQ1RsLfc1yEMM6Yc=;
 b=WHv8fzWK73c5Oc+vVpQbOOLBX9+1swibG1qHMVVemEMV54PrBtECFmP5OivuTTb2Bl
 SR47NtPZmZ3caDZdycM0rmIw8mlTX4FFsMq4zbta1b3gZDRZ9D/QKTPV+lE6H7YjbC0z
 WT17hudZknZrqBk2tzPPLLLbNSgLxsYDp5UmM9vsge13pO5NAbh+FvVvo2MU0eX//7GE
 /VisJkjuDKPpl00gm0NlKPcHK6lFY6X8DuqX4bnuqhlwJPOOsZyyvi/zYl/e6i60GQWn
 kI2pbGcnQcc2Wrt4ROp77gMuaEadN6Yll7aQhbAtK38gwyfdnbMWvyaP69atUrpf0oF8
 BFcw==
X-Gm-Message-State: AOJu0Yy4xAUkMq8suDZtGlLsaeZg7v+EM855IFeiTcGngx+DNY015ySl
 ZJWzAvFnJHX9mw/AO16rXmAVTPUicRCZ6vZcJFOPjWURIGAhqFzqghTE
X-Gm-Gg: ATEYQzzy4c5tpbGkxAbMEEv1FDm06BHeoUhbtoeC3xXlwtL1ZycbVYVU0xrccYCpahk
 sfhX8+3VmpmXswT4W6a3Kl3pCqjbLFeumimIPf8KpaMcIvnhi85cxjqGu1N+/togBeksfRhGlGC
 Rq63HhiR2ibj+gxyn8qGsaEfGewDtfHxiFcpM/h+G/meNAVE9GVVQWJwd7MIWe4UNm5dGLwNfCF
 qkCeAGoH/hSMmRUNFZ+a0bQm5IX3HQwjLqFYd0y5xsZWAQNCYF1fk8LCUrcgqgXLE0/VmJLTJHz
 NXXi6EjgcyFz2t3h2rjpwep/C+qn/7b3bm3xXYLiGphgj1bqDVaYbsDflTfBoWuXN1cU6Mn8Tui
 ulXGDTgTc1goGvjpFwxiMYR9z0XcYzPWgt/s/MN4PxsEcsoTAXYGZ7TVBLF28hQ0b08AThUdn+H
 O/GRrDN1PevWwAB2wjj+rKyyGH0FDI4Nx4H30wBtUjw67B2xZIgeBxXDMfnMazcDani3UKohgK4
 a/zFtZd9bXlgWv8N0Hp/HZbmAMHUak=
X-Received: by 2002:a05:7022:250f:b0:11b:9386:a3bf with SMTP id
 a92af1059eb24-128b70eeb71mr1188122c88.42.1772641057695; 
 Wed, 04 Mar 2026 08:17:37 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be220eb5e5sm3590401eec.17.2026.03.04.08.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:17:37 -0800 (PST)
Date: Thu, 5 Mar 2026 00:17:10 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Nutty Liu <nutty.liu@hotmail.com>
Subject: Re: [PATCH v4 1/9] target/riscv: Add cfg properities for Zvfbfa
 extensions
Message-ID: <aahZwehF3x3e0-Er@ZEVORN-PC.localdomain>
References: <20260304132514.2889449-1-max.chou@sifive.com>
 <20260304132514.2889449-2-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304132514.2889449-2-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1244.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Mar 04, 2026 at 09:25:05PM +0800, Max Chou wrote:
> The Zvfbfa extension adds more complete BF16 vector compute support
> and requires the Zve32f and Zfbfmin extensions.
> 
typo in commit subject -- "properities" should
be "properties".

Otherwise looks good.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/cpu.c                | 1 +
>  target/riscv/cpu_cfg_fields.h.inc | 1 +
>  target/riscv/tcg/tcg-cpu.c        | 8 ++++++++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 9be79622f4..2ddc26c837 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -189,6 +189,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
>      ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
>      ISA_EXT_DATA_ENTRY(zve64x, PRIV_VERSION_1_10_0, ext_zve64x),
> +    ISA_EXT_DATA_ENTRY(zvfbfa, PRIV_VERSION_1_13_0, ext_zvfbfa),
>      ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
>      ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
>      ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 70ec650abf..3696f02ee0 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -99,6 +99,7 @@ BOOL_FIELD(ext_zvks)
>  BOOL_FIELD(ext_zvksc)
>  BOOL_FIELD(ext_zvksg)
>  BOOL_FIELD(ext_zmmul)
> +BOOL_FIELD(ext_zvfbfa)
>  BOOL_FIELD(ext_zvfbfmin)
>  BOOL_FIELD(ext_zvfbfwma)
>  BOOL_FIELD(ext_zvfh)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 988b2d905f..720ff0c2a3 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -720,6 +720,14 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    if (cpu->cfg.ext_zvfbfa) {
> +        if (!cpu->cfg.ext_zve32f || !cpu->cfg.ext_zfbfmin) {
> +            error_setg(errp, "Zvfbfa extension requires Zve32f extension "
> +                             "and Zfbfmin extension");
> +            return;
> +        }
> +    }
> +
>      if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>          error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>          return;
> -- 
> 2.52.0
> 

