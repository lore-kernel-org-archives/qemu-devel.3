Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDFCC369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPr5-0006ud-7f; Wed, 25 Sep 2024 07:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1stPr1-0006fL-W9
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:06:44 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1stPqx-0002SX-Hv
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:06:42 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c2561e8041so9068950a12.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 04:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727262398; x=1727867198; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EpP9i6Ze28i/FcZPUtLsXoDLmCcB9DyU1kqM8nyyiuM=;
 b=CcKm2mF+dsRrdGZhCuB1NpO7OXv+UZiqg+DlEU+yHsSAR0GHwg1khjN6A50peck8xp
 S2nX9XG2v5jZEnTOrkohon7LF+VGcxcbgqzWlmLV0uqwJNzQtWahZPKQZD1iK3EPOsjY
 TMfwN1wBhWPDVfmmzWugIHXsvGLdc/b0i+9i4FXe9h+Nqc4WTNxG1ymKNPYHY8ilZi55
 5Zr/UIVxp7Kve2kQqm2sLUg6XjJXCjBydmdBaLB8dsZ2z42/QmZRKgGH7JPkopFzl00T
 4znnz4dTZePUV84vG3o6SSciW7BLE3QhKLsYfjzOaBevfsnsgOUjecB870pfIJshYAVe
 FyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727262398; x=1727867198;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EpP9i6Ze28i/FcZPUtLsXoDLmCcB9DyU1kqM8nyyiuM=;
 b=oLwes6lJyaUiLl6SX1wGBzYTvxSYpgIGGDkzTaMS0zvlwvxU7NYGQgFUdpjuJYsAvY
 KWa6BdMYnpnf+ZHpFaS24/5pJw1OY8e0lfAEVVONNQOvyQzzrY/L6QmdfSnlbsTU77zg
 Vn3qfZZjMXquIGrk0nZecQVAM2TCdxOeRDUox3eEF1FGRXakSPJzgoZpvJhNr7saNMjp
 7f0UFlRo4cNgnTUokVQY5Anig9+7BNas2BLoO6vs8/wtKYT6E9okr6fMKQqK8SaqPSpL
 e60Lg/XmpbmN061WUe1Ihma8mhDVKscRzRVCNg1657HH+3UgYcwmcNQOrD2igQHmrNKu
 UHEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+XuLEPML9U6CP1iSScquvJv2/VN/PjzXufrtoL3aQa48LlYMCBVB19wnXfW7rMgCfL8LRfSsl8lqA@nongnu.org
X-Gm-Message-State: AOJu0Yxp9ST3lAGri/SnI/CM8wuaTbdfwdogv0PwhA97drwWO2loGzF7
 QJhAUmrjkgZKIXx3kv7HH9DeZPF1cdRgoJ6Vrp4HOYCCFXm+d3wJ/Wxtm7Xy1KY=
X-Google-Smtp-Source: AGHT+IGOSh7usdh1irl41mb99BZBIwQ8EjjvywrZj8cikVL7e+xqVeujioddWG+CPmJQcrq67qiMSA==
X-Received: by 2002:a05:6402:5d3:b0:5c2:4a98:7520 with SMTP id
 4fb4d7f45d1cf-5c720750dc8mr2058748a12.31.1727262397457; 
 Wed, 25 Sep 2024 04:06:37 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4ff7sm1740811a12.71.2024.09.25.04.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 04:06:36 -0700 (PDT)
Date: Wed, 25 Sep 2024 13:06:35 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/1] target/riscv: enable floating point unit
Message-ID: <20240925-27610830c7f6c0235bc8b1a1@orel>
References: <20240925061704.12440-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925061704.12440-1-heinrich.schuchardt@canonical.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 25, 2024 at 08:17:04AM GMT, Heinrich Schuchardt wrote:
> The status and mstatus CSRs contain bit field FS, which control if the
> floating point unit of RISC-V hart is enabled.
> 
> There seems to be no specification prescribing the value of the field when
> entering S-mode from M-mode. But OpenSBI, as the leading SBI M-mode
> firmware, has set a precedent by enabling the FPU by setting the value of
> FS to 3 (dirty).
> 
> In TCG mode, QEMU uses OpenSBI by default. Users can reasonably expect that
> software running QEMU in TCG mode and in KVM mode behaves similarly.
> 
> When QEMU in KVM mode creates a vCPU, Linux' KVM code sets FS=1 (initial)
> in kvm_riscv_vcpu_fp_reset(). However, QEMU internally keeps a value of
> FS=0 (off) and then synchronizes this value into KVM. Thus VS-mode software
> is invoked with a disabled floating point unit.
> 
> One example of software being impacted is EDK II with TLS enabled. It
> crashes when hitting the first floating point instruction while running
> QEMU with --accel kvm, and runs fine with --accel tcg.
> 
> With this patch the FPU will be enabled when entering S-mode in KVM mode
> and when entering M-mode in TCG mode.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	Rewrite the commit message as suggested in the v1 thread
> 	https://lore.kernel.org/qemu-riscv/20240916181633.366449-1-heinrich.schuchardt@canonical.com/
> ---
>  target/riscv/cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4bda754b01..c32e2721d4 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -923,6 +923,13 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>      if (mcc->parent_phases.hold) {
>          mcc->parent_phases.hold(obj, type);
>      }
> +    if (riscv_has_ext(env, RVF) || riscv_has_ext(env, RVD)) {
> +        env->mstatus = set_field(env->mstatus, MSTATUS_FS, env->misa_mxl);
> +        for (int regnr = 0; regnr < 32; ++regnr) {
> +            env->fpr[regnr] = 0;
> +        }
> +        riscv_csrrw(env, CSR_FCSR, NULL, 0, -1);
> +    }
>  #ifndef CONFIG_USER_ONLY
>      env->misa_mxl = mcc->misa_mxl_max;
>      env->priv = PRV_M;
> -- 
> 2.45.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

