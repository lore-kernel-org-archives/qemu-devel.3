Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6C5D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6UI-00038O-Sx; Fri, 09 Jan 2026 02:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1ve6Te-0002Mu-S7
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:00:09 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1ve6Tc-0003EV-Qx
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:00:06 -0500
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-c2dd0c24e5cso1859592a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767942003; x=1768546803; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UX0F9wolq2qlTsJ7DjQBEqwZDNKepaas6gp86hYQm4c=;
 b=EAn9g/BaFOhyknKKS16zRlfJMXfRmKqiD0cFVUoYj2QkLMcSpgFZ8qeif0V53yeyqY
 GKXZ8QqK3kJLzy/9xrilj5Sxh1xemsCII/DPGJgLZ2SqIk12U74IgA81oDpRvOjiLosi
 tSaay1iIwIZfFBrsxpjQishctd2chqNTJB+VcExU5RhgWW62HWRIyHmeMxie2c+7G/70
 ewynxOfgQsyAH5YKpWB52f8xTeYJKEBQ+aPIl+9XuwxnDO8Hs/LSnStFzb5AUg4f4mMG
 1NrAir3Whc559HeixrzYIX++cEdljjkki1DePOYDYmoRkwEqGOBsAXlWy/QRVc8DaMmV
 K12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767942003; x=1768546803;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UX0F9wolq2qlTsJ7DjQBEqwZDNKepaas6gp86hYQm4c=;
 b=gd/1DTGKzdcBfzZ7J8hzhLiq+baKP1Vq/5eRYydqVZwrps6WTA/zTA9pXmv8x6Ggdy
 K6GwyCS+bDrv56Ogfy9QJzdNol2ywPD8X6gJFDtUXU1k01xtMdxkBymc7/ZmeoyaBjpq
 Udt45kb4uSSQ4lmYotKZdj/YZW/y5/qh7m+XEmHAjyXO2hFc29JzGM6eWsaUFkPxNHQ4
 sBV+puJvkNpQ9McLxGEGZZ82jK2IJv7Y3SWRYPwQx3mJ02Paa6LteTaajXU2+/hA9Kei
 1wCdKZm5eM83kEWhhrqQkKxNr4ORxGnejJ0AieZ3XzxN5cn1BvCWP/Cu00FUjdKaUNi8
 QLSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrLEufiXcXfQ7Ajk60KCbK2pAL/Ll9CAI0fTLgMhWvZrRRk1rJ7UJtI40opSRJrONRVbK6CS2tNe2U@nongnu.org
X-Gm-Message-State: AOJu0YxS0NIzCyQS2VpcCPeZxyVRZFAMGleOsZyaZHyUzXTOeHEarHtg
 uERG0XDrOz0WvTfW2fUlwot6QynUAeBn831Y+2E09h+kZ1MxGGrIR0Bv
X-Gm-Gg: AY/fxX6b558cjTXFVN/e4SFP4esC9a+atXl9QdEBzUlVS0jl20LpvhY2TDY6F7vE4op
 rP/wCoqOCUAlWZyno6FOxDfn95N682ZtNzWm8h01I75RTqtpAdP2A4zSIC554E2uXZexXQbbY4g
 03cYzlXswv4XjUFhSn3YoURxbthl0ARGQSlfPaxXM/ZLx9x47UHNqb21KMD1nhUSYMAgUbUxRIN
 MBjR7PMXCiSCsvXMBB0Afo/1zlPVIrde3VUlc6dLeUThAc00o8GRSKsdxVdadNgZ9kjwrnaENM8
 hifkKJ75LRgjFK//164Vx3l406HrJzV+sYD1LdOXEi32Kw9nYli97NnHVF6rswt6zqI0L0CHNM8
 7VD++VXP5stXW7A10nhlKXLU0A/mKrwGSFRszIhof90KE8aReDiObehlyGdNLH5xnHBgK7eVR+9
 o5h0H31Hzy+AcpC/zN98Bfksd49OC9bWHY3dIX7FB6G59eGeGfmlzqE65wVq4=
X-Google-Smtp-Source: AGHT+IHPpHELb1Gb0EWXea48XDf1pRP1Ism0vJoQ/Gdhkd1sKm9HH2eS95cxokqN1kylrBGAC9Piug==
X-Received: by 2002:a05:6a20:1582:b0:351:118a:62b0 with SMTP id
 adf61e73a8af0-3898f94c264mr8909629637.17.1767942002990; 
 Thu, 08 Jan 2026 23:00:02 -0800 (PST)
Received: from [127.0.0.1] ([218.81.29.112]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc88e3sm95244725ad.75.2026.01.08.22.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 23:00:02 -0800 (PST)
Message-ID: <d235db23-1c03-4adc-bcb9-e190205f2c74@gmail.com>
Date: Fri, 9 Jan 2026 14:59:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] target/riscv: Add cfg properity for Zvfofp4min
 extension
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
 <20260108151650.16329-15-max.chou@sifive.com>
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <20260108151650.16329-15-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pg1-x544.google.com
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

Hi, Max:

On 1/8/2026 11:16 PM, Max Chou wrote:
> According to the ISA spec of Zvfofp4min extension,
> "The Zvfofp4min extension requires on the Zve32f extension."
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/cpu.c                |  1 +
>  target/riscv/cpu_cfg_fields.h.inc |  1 +
>  target/riscv/tcg/tcg-cpu.c        | 10 ++++++++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 081891c97a..9d4fc3ab6b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -193,6 +193,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
>      ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
>      ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
> +    ISA_EXT_DATA_ENTRY(zvfofp4min, PRIV_VERSION_1_12_0, ext_zvfofp4min),
>      ISA_EXT_DATA_ENTRY(zvfofp8min, PRIV_VERSION_1_12_0, ext_zvfofp8min),
>      ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
>      ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 59302894af..353a932c36 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -104,6 +104,7 @@ BOOL_FIELD(ext_zvfbfmin)
>  BOOL_FIELD(ext_zvfbfwma)
>  BOOL_FIELD(ext_zvfh)
>  BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_zvfofp4min)
>  BOOL_FIELD(ext_zvfofp8min)
>  BOOL_FIELD(ext_smaia)
>  BOOL_FIELD(ext_ssaia)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index ba89436f13..c095bc9efd 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -715,6 +715,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    if (cpu->cfg.ext_zvfofp4min && !cpu->cfg.ext_zve32f) {
> +        error_setg(errp, "Zvfofp4min extension depends on Zve32f extension");
> +        return;
> +    }
> +
First check.

>      if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
>          error_setg(errp, "Zvfh extensions requires Zfhmin extension");
>          return;
> @@ -738,6 +743,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          }
>      }
>  
> +    if (cpu->cfg.ext_zvfofp4min && !cpu->cfg.ext_zve32f) {
> +        error_setg(errp, "Zvfofp4min extension depends on Zve32f extension");
> +        return;
> +    }
> +
Re-verified Zvfofp4min -> Zve32f.

Thanks,
Chao
>      if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>          error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>          return;


