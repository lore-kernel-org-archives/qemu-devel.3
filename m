Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A8FC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 15:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlUh3-0004NQ-Qq; Fri, 21 Feb 2025 10:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tlUh1-0004N5-Ps
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:11:56 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tlUgz-0003Rr-VI
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:11:55 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4394a823036so21882585e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 07:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740150712; x=1740755512; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yciegiRd+LvbEwQ5vXC+IuEx9Zab5j6SC3x5a/DKyr8=;
 b=SUig5Tx0knjCkixrzPaKPlDiTcfCt5shrqAI7oXb3EG8lWOMaNjh5zGR1+Q+JX/TY1
 BV+31KmD5euR5MleoYLt1ynvK+wCuJpzP9Hg9OPITH07FIFvPyVJ8j4pa0gRcvq3M/7h
 /iETv+NXQMTMlkoZ+HENVtBD6IFxcYNkpzTdoRtbIzU+A0mgHSpYP9qDKXL0yhnkP/Dc
 5iHUIp7+E3SIMJbfqHSpr2NJiAZwrCKw7RPXp7Tm7bMNK1HlmSskwfE3Lmpms6u8RVR6
 7tUbiI/5z0d4ftBeuEJEn0YZ6JFWzUrIW9LF/nB/tjO2eqjntWhBG74aaOhU79NK9dMp
 +w3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740150712; x=1740755512;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yciegiRd+LvbEwQ5vXC+IuEx9Zab5j6SC3x5a/DKyr8=;
 b=DHdI2w5QIQyVjuI983pdQDHZJCc/g+NQcgJE4GnyB1TPCOsvFITWcqxLFcqbzNqA2a
 03di7aslO8H50q/mOMPiTVi7SFIwXZjBXoAJjayaqRKeSJyEQq0NZ/wVPakRxXLdOxdt
 dSAiENo9pVnNJsP8f5hOifW8SsBJL1oBJms9ZpHawgq9+qs+v84WkEo/PinV/zAOEz5b
 RX3yIVH5+3aoeb+MRytcX1Bh04qNUECXzEu2dzP4wfhzegx8nOFGWaxWoRNoU37PfbSQ
 OIljTd10zYviKq04nk1b5ryq7kLzo5qQcS6g90fywuTKmgYEwWlxxfZiJ6p1TPpCmhzE
 zURw==
X-Gm-Message-State: AOJu0YyINDvK8zBN2HjCJ6FG/4WCogBtNjigwPZvxUiq3W8pFvD5EWv5
 NQQXv8qGSldsnbg3BulCDT/qAAHhTud72gVIE8bzQ5ENZL9mqPUKtuO88EoJiA4=
X-Gm-Gg: ASbGncs21H+SbMhmSz0h8y8A+RTRswQsKpiDLRkMaNmbk5NaJEmpXShJF5AV1P2T4p3
 1gSEbGygyay87wwezYLzRqWVzrG9gzd0UFi9lLJIhCo7uCA7vvvfHUtVeifz3X2BfcrCXPApDvK
 L9eUAAFS57BiFxLfmWt26PZL9/ec0QQme3uOP2VJ9ZGrr4yoA+j2cmRAqs1KvdBWIqY3WnG5gFE
 9//C2kBrMbw1eDlUA8ccVVYa1s7PSAyzxTifiZiiDEIsjdr7H0Keo2vMBgbPUuKdwZB3ELiFiYS
 VB2TvOcqhKaagA==
X-Google-Smtp-Source: AGHT+IGFMc7EncM2bla39QtrC0GfMHh0z9w4a3HUhL5HqrENYI4DwJfPM7ygIE1goaiKhtdkWF4AUA==
X-Received: by 2002:a05:600c:5489:b0:439:86fb:7326 with SMTP id
 5b1f17b1804b1-439aebb5558mr23136145e9.22.1740150711748; 
 Fri, 21 Feb 2025 07:11:51 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b030be5esm19965505e9.30.2025.02.21.07.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 07:11:51 -0800 (PST)
Date: Fri, 21 Feb 2025 16:11:50 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v2 2/3] target/riscv/cpu.c: create flag for ziccrse
Message-ID: <20250221-679a2e65bfea6314820981df@orel>
References: <20250221141834.626722-1-dbarboza@ventanamicro.com>
 <20250221141834.626722-3-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221141834.626722-3-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Feb 21, 2025 at 11:18:33AM -0300, Daniel Henrique Barboza wrote:
> At this moment ziccrse is a TCG always enabled named feature for
> priv_ver > 1.11 that has no exclusive flag. In the next patch we'll make
> the KVM driver update ziccrse as well, turning it on/off depending on
> host settings, but for that we'll need an ext_ziccrse flag in the CPU
> state.
> 
> Create an exclusive flag for it like we do with other named features.
> As with any named features we already have, it won't be exposed to
> users. TCG will keep the same restiction for it (always enabled if
> has_priv_1_11 is true) and KVM will be free to turn it on/off as
> required.

Reading this as "KVM can choose" makes it sound wrong, since KVM can't
choose. However, KVM will turn it on/off depending on whether this
extension is/isn't present. So reading it as "TCG always has it on, but
KVM will turn it off when the extension isn't available", makes more
sense.

> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c         | 3 ++-
>  target/riscv/cpu_cfg.h     | 3 +++
>  target/riscv/tcg/tcg-cpu.c | 2 ++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 522d6584e4..fc4632ce36 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -105,7 +105,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
> -    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
> +    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
>      ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
>      ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
>      ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
> @@ -1749,6 +1749,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
>      MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
>      MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
>      MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
> +    MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
>  
>      { },
>  };
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 3f3c1118c0..8a843482cc 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -166,6 +166,9 @@ struct RISCVCPUConfig {
>      bool has_priv_1_12;
>      bool has_priv_1_11;
>  
> +    /* Always enabled for TCG if has_priv_1_11 */
> +    bool ext_ziccrse;
> +
>      /* Vendor-specific custom extensions */
>      bool ext_xtheadba;
>      bool ext_xtheadbb;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index ea8d77d06a..c93612b1da 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -360,6 +360,8 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
>  
>      cpu->cfg.ext_sha = riscv_has_ext(&cpu->env, RVH) &&
>                         cpu->cfg.ext_ssstateen;
> +
> +    cpu->cfg.ext_ziccrse = cpu->cfg.has_priv_1_11;
>  }
>  
>  static void riscv_cpu_validate_g(RISCVCPU *cpu)
> -- 
> 2.48.1
>

Other than my hangup on the commit message,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

