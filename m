Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8A9CA0EE0
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 05:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sju3Z-0000gb-2A; Fri, 30 Aug 2024 01:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sju3W-0000fV-Lt
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 01:20:18 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sju3U-0002el-85
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 01:20:18 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7141feed424so1221530b3a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 22:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724995215; x=1725600015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dvj+Jkf9UOIs1rtRDSsJ2H7qrxcydtnGfDt2mhRQays=;
 b=mkGdWCoaA5wt47wEAtjivMSaXO+CDqd+w3EFLySY/sfw+6Ssn60I9qlJlPYovIXxRj
 cA90nLy8oZmFc6Lz9r7jrQwIx6HJrHGEV8U+LSU90BpjMjwCohSy+MUHYWLpz4kUTBNR
 o8RTqrp8U+vSXViqKDwGSBL4SOCepC/KJz+oSfog4EOn+tpBpzrJmMCBXon6wOLNitjb
 69ui/DX31Wz46MCuHtmaVNgxF01Z78GGxC2AdCKs8CnGf4gYZvF7nOr4SDYl0BFYPBlj
 Bl+9bJG5MUhZTUC4r1XOKnOa4VQmWUxh+eb6fT4TF+ip7KXjQj3Zw0fePz2sdmdOieTl
 rPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724995215; x=1725600015;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dvj+Jkf9UOIs1rtRDSsJ2H7qrxcydtnGfDt2mhRQays=;
 b=q1P2XIdtuJqMbKecVBOj6lskjrtJ8AxcQ6Hx/1EAb0jhmFD+IC57EFlv21nBS3JVQa
 2qeyvVTfmN72M7zVAVRt3whxTjSgiRd6fztu7HON8GK0iyMgaEy6y3dzvuCNIqpowhOe
 WhhQS93E5fT7dOAGIzbYRzHn5sY8kdSC6d677PVGLqQIAH9goUE1Vi/c+vyP4SLbQCnW
 y5o75rONYMsbMud14jGNro+qG9lr7FpuP3sUkG1anj4BB/4ozrTvOOGXEn5ltFQlRl+I
 HQQ7ZqD1wQtdAdO7AnUyMkPcoMSqgTjcKX5a3v4nhQLroBL92JcvsNS9gO7dUEdHBgMS
 /3ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE3T2QVIAkWWDKRK7c1ODQUrzPNAZ6yVXFmDRhl5Q5ilWVSi88Cn6ZvmchsiQqnJBvmEkpBCqhxlRx@nongnu.org
X-Gm-Message-State: AOJu0YwizxSWD/pES9uKOtW+YsqWQGi4pypsPrSL+o/6MaFdhEHlPPMd
 IHOG7Ub97Pg4N2+pPcZfaqyPrL7nrPSwFLSCAL5i4b2HC6mSbYIHDVYOO1Fqaec=
X-Google-Smtp-Source: AGHT+IGXbkhjwVhxmWlZ68NL6Cf5rdiHMnnpGnfd5onrCvLYMC6+5k1+n9Tp9OOzKVFbIma7yifFSw==
X-Received: by 2002:a05:6a20:e196:b0:1cc:cdb6:c11a with SMTP id
 adf61e73a8af0-1cce1015a21mr5335893637.24.1724995214538; 
 Thu, 29 Aug 2024 22:20:14 -0700 (PDT)
Received: from ?IPV6:2001:8004:5100:1c02:35b7:18d3:3fc5:9f02?
 ([2001:8004:5100:1c02:35b7:18d3:3fc5:9f02])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8446f3bd4sm5229210a91.53.2024.08.29.22.20.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 22:20:14 -0700 (PDT)
Message-ID: <abc033ff-7638-4d2d-b2d7-65b3c88311e8@linaro.org>
Date: Fri, 30 Aug 2024 15:20:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 11/20] target/riscv: introduce ssp and enabling
 controls for zicfiss
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
References: <20240829233425.1005029-1-debug@rivosinc.com>
 <20240829233425.1005029-12-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240829233425.1005029-12-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 8/30/24 09:34, Deepak Gupta wrote:
> +bool cpu_get_bcfien(CPURISCVState *env)

It occurs to me that a better name would be "cpu_get_sspen".
The backward cfi is merely a consequence of the shadow stack.

> +{
> +    /* no cfi extension, return false */
> +    if (!env_archcpu(env)->cfg.ext_zicfiss) {
> +        return false;
> +    }
> +
> +    switch (env->priv) {
> +    case PRV_U:
> +        if (riscv_has_ext(env, RVS)) {
> +            return env->senvcfg & SENVCFG_SSE;
> +        }
> +        return env->menvcfg & MENVCFG_SSE;
> +#ifndef CONFIG_USER_ONLY
> +    case PRV_S:
> +        if (env->virt_enabled) {
> +            return env->henvcfg & HENVCFG_SSE;
> +        }
> +        return env->menvcfg & MENVCFG_SSE;
> +    case PRV_M: /* M-mode shadow stack is always on if hart implements */
> +        return true;

 From the manual:

Activating Zicfiss in M-mode is currently not supported. Additionally, when S-mode is not
implemented, activation in U-mode is also not supported.

So two of the cases above are wrong.


r~

