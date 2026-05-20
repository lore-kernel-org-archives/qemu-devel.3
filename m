Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA602CD4F5B
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 02:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPWQr-0001Bt-7A; Tue, 19 May 2026 22:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPWQp-0001BX-Pd
 for qemu-devel@nongnu.org; Tue, 19 May 2026 22:13:11 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPWQm-00048A-HR
 for qemu-devel@nongnu.org; Tue, 19 May 2026 22:13:11 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2f7020a928eso6227078eec.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 19:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779243186; x=1779847986; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XAkPYkid9ikq/b6KKuz/E3H8dCMEkrvqVZhA62nrtLQ=;
 b=cy9hfW/0G0Z63w+B5S7x5N+d3i7CC333epjq2I/FkDMVQNH6qbsLIyWvSGRXNAnzPJ
 X8ToRdBG0v7RCqTwYizJ7pYo4Eup5ino67PuNsF5shS50TOgMWIM7xymUTHG16qE1m6V
 dQgvKB8D3VsCMC/X0qMK/AYKru0nmlBbiUx7Ab/HCCxUPvJMKJgueo+B9zaYr4XK/yTO
 rX7f/d3o/35mBJEu4SnMIw7v9rGxSWIR6Gxr6Ylw23bzkXyNtrcBoSITXhLU4xw2okdu
 ZNtaizmSyC6l+B0CBz8IcnkTQwGO+bnxvEz7J298kR+yclXDXHSTMZnGP92uyW4Pmvl9
 7o6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779243186; x=1779847986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAkPYkid9ikq/b6KKuz/E3H8dCMEkrvqVZhA62nrtLQ=;
 b=byhvM9vr9IOQ9EtSb+rO6LAl1usepQhhb3Gli+EEX8MMvTT57giMU3IoX2G2ZZRsai
 6/y9yNePh/oOwndPYNP0RLSHwUY3uF+8Zdpp4rTzxHG/7vGjuo8XgTp7/Q278jOq+C15
 FvuKIWhtAcguLKnfval1oaspz8ADLwpgQJTzQyB0Q0MVOTZUIHQenkbML36jJwugQv+j
 P8iMhT0Xky7qi0xQOFG9ZtmZHAsRcnDmLqD4Crn+4gk4+BnJyJPCK6INwc7y1ElgbJ/w
 6qD+FeEWnBCGyNqcxxuZ+dDUKLUjVtwh4LDFmwU4670sOwhsb7FUhgAWcpKuFnx5wedU
 TqDA==
X-Gm-Message-State: AOJu0YywESGVCToWOoSr/yEr8seG+CrWmCwHPxel33sW1+Bm9STOvjDI
 jVQtuQB3IciQ9PdtSJTQNJz0GmkW24KEVJg9yb1IDvvFd9SV9LKUEbEE
X-Gm-Gg: Acq92OG6Fs4MfFZVlFvaLS/mGDLK3yYAgYcNVTbxyzdEzhp29wMXRu+SBsV+Nt6C91U
 K2FWLU3J2ddMzsgyIayEOZL1V8SOUcWMyJ7UdTJf0GZYz0zIyVYc199fFgtSG46sJL9Xq8KB2mL
 whES5yO13DRQGS8QOkuMtx1+ocQqrwU8qajpnGVXYHVHf9mXt9iOpCs1xCqbNsdzavEDXBzdlDn
 4MUKTlCg/bQ3+volhGtas2rQNFsQtaswOP0yjyVxARndQuDIZNuG2ovUzUMcA03bt+SB0D/5WRh
 wb8I0hL6ayOAF/70IjTluz6zwZCnYwaT/5MGpsl5LWyHAvRa1pChIgEfItpZNC1BbZM+pE8Ang7
 CPG4JBLW0kpuhPWj9A+CKq3KhKpz6PGbhAYtAL6h5idp5wJb5+B8kQiGcb463/X41cQOLU8APvv
 Gz+lmfwfTGlLTysr5xY0H0D0xSm9DvAdBMwrq3GyIClI/FMCtfu2DSZCQcI00=
X-Received: by 2002:a05:7300:8187:b0:2d9:5cd9:b8ff with SMTP id
 5a478bee46e88-3039818af3amr9875459eec.6.1779243185844; 
 Tue, 19 May 2026 19:13:05 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3041ab8282bsm222561eec.31.2026.05.19.19.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 19:13:05 -0700 (PDT)
Date: Wed, 20 May 2026 10:13:02 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH] target/riscv/tcg: disable svpbmt if satp_mode < sv39
Message-ID: <ag0Yn6otrO3_3N0h@ChaodeMacBook-Pro.local>
References: <20260519114858.316532-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519114858.316532-1-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
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

On Tue, May 19, 2026 at 08:48:58AM +0800, Daniel Henrique Barboza wrote:
> Priv spec chapter "Svpbmt Extension for Page-Based Memory Types, Version
> 1.0" mentions that "The Svpbmt extension depends on the Sv39
> extension.".
> 
> We're not doing any satp checks when enabling svpbmt.  This causes
> problems with the riscv32 'max' CPU that happens to be enabling svpbmt
> even though it doesn't support the required satp mode.  In fact all rv32
> CPUs are allowing menvcfg.PBMTE writes, which doesn't make sense for
> them in any circunstance since svpbmt is not possible for rv32 at this
> moment [1].
> 
> This also impacts rv64 CPUs that are running in satp 'bare' mode and are
> reporting svpbmt in the riscv,isa.
> 
> All these problems can be solved by disabling svpbmt if satp_mode is not
> at least sv39.  The problem reported in [1] goes away because we'll
> never enable MENVCFG_PBMTE write mask in write_menvcfgh().  We're also
> become consistent with how svpbmt is enabled for rv64.
> 
> In case the user enables svpbmt in the command line using an invalid setup,
> not just disable svpbmt but also throw a warning:
> 
> $ ./build/qemu-system-riscv64 -M virt,dumpdtb=fdt.dtb \
>     -cpu max,sv39=off,sv48=off,sv57=off,sv64=off,svpbmt=on
> qemu-system-riscv64: warning: svpbmt requires at least satp sv39, current satp mode: none
> 
> [1] https://gitlab.com/qemu-project/qemu/-/work_items/3473
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3473
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  target/riscv/tcg/tcg-cpu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index a358d91ca5..5b3e36d9ab 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -887,6 +887,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +#ifndef CONFIG_USER_ONLY
> +    if (cpu->cfg.ext_svpbmt && cpu->cfg.max_satp_mode < VM_1_10_SV39) {
> +        cpu->cfg.ext_svpbmt = false;
> +        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_svpbmt))) {
> +            warn_report("svpbmt requires at least satp sv39, "
> +                        "current satp mode: %s",
> +                        satp_mode_str(cpu->cfg.max_satp_mode,
> +                                     riscv_cpu_is_32bit(cpu)));
> +        }
> +    }
> +#endif
>      /*
>       * Disable isa extensions based on priv spec after we
>       * validated and set everything we need.
> -- 
> 2.43.0
> 

