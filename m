Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF68ECA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 02:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjr8Y-0005Ff-PG; Thu, 29 Aug 2024 22:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjr8X-0005BG-UB
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 22:13:17 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjr8V-0003WD-Tn
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 22:13:17 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7cd9cfe4748so1051572a12.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 19:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724983994; x=1725588794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aegJ28C2nNo+uc5Dpi8nFxpc0ECb2HMRQvxoRb4LCF8=;
 b=NlPWqyajxhdJVu4lMk1Wwtjwv2/PQ2UiHN/CUkpT+SXuWTij+/SEo8fIbM3NtTCou7
 Q7IVHGgIs6NSA+Kz1U2nNxUvMfyQFFngIxbvdvotO2FsCev9VTNAN5cpRnmaY2U+3h/x
 GspJgOINNGNjCu1vF+kWLeiqshZfAMoPoESsz6awaqQk3AtWOr74dv3BBBkmdicQ6z5w
 HOG2dU5SVMAIBqV/LNGbXKN+Yg2qIujmWgyhgAQyPyg/749dzLUaJgspwpGCLEhtngUY
 4q+lEV0vMtSaGTTrt2n2PJ/WHgO/rjIp6Yxz5t1DHx5RYQqD5d9saQsQ/49tM40aj7mb
 40/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724983994; x=1725588794;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aegJ28C2nNo+uc5Dpi8nFxpc0ECb2HMRQvxoRb4LCF8=;
 b=tUH2JOuqrgXE8MKkC5TvMRb4H54RZ9o15Isg0rYcRVFagF4gilc7/eI0ZIhdUTsRFu
 ilYvX+s3Y0hKqXWzyztIRv1N/9qyuaGoX9yllpqgAgep7wepLujc4B1ROsIuX0U8+wj/
 tmVc2wk7LQnEdb2JTQCbc3IKVQDtIepHbrl/UWpDXknR4Y13tijbo9Mu28bkHJGdqsBD
 tv9mry9ebjWr2hSWZ4j96YdDJWi5nU5Lxzjb1CJfCx43Su1WH5ThTiysZoLtW3qpMwVF
 k7lcy2J+ZZvEXjdMUT8XT6G5hSk+H+f3fMH6P133jLvnIYj8gfTF5w4kNJB5wRM84KnD
 ev6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvt+F0l0QmViF4f/bIq3mXWj8cjTnyhGLAaiX2Rh9r/Gvgk224x2/zL4IpwP5IGyXdEdFnrTz7AijT@nongnu.org
X-Gm-Message-State: AOJu0YwP7BY3TvrGRMFClkGWudym0O9f8VM8S8cxMtL3rRUPoH4aVlp3
 eXaunNTJxtl8Wh2qq4zzdeNYZBKUvKK7YZ3+gBwcb+fLYb/laCn00R+QrSzDtCg=
X-Google-Smtp-Source: AGHT+IFhJkTOjrZU0KosEhQf85qhQEbmZfz8ORVMcsARmNVA5SWp6L6Im8XCojL0AowutZeXm+ZhbA==
X-Received: by 2002:a05:6a20:2d07:b0:1cc:be79:92ca with SMTP id
 adf61e73a8af0-1cce0fed498mr4512042637.5.1724983994251; 
 Thu, 29 Aug 2024 19:13:14 -0700 (PDT)
Received: from ?IPV6:2001:8004:5100:1c02:35b7:18d3:3fc5:9f02?
 ([2001:8004:5100:1c02:35b7:18d3:3fc5:9f02])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-205152b12d3sm17627705ad.41.2024.08.29.19.13.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 19:13:13 -0700 (PDT)
Message-ID: <84dfd92a-cf4d-48d3-93c0-a030eb198bcb@linaro.org>
Date: Fri, 30 Aug 2024 12:13:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/20] target/riscv: save and restore elp state on
 priv transitions
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
References: <20240829233425.1005029-1-debug@rivosinc.com>
 <20240829233425.1005029-5-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240829233425.1005029-5-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> elp state is recorded in *status on trap entry (less privilege to higher
> privilege) and restored in elp from *status on trap exit (higher to less
> privilege).
> 
> Additionally this patch introduces a forward cfi helper function to
> determine if current privilege has forward cfi is enabled or not based on
> *envcfg (for U, VU, S, VU, HS) or mseccfg csr (for M). For qemu-user, a
> new field `ufcfien` is introduced which is by default set to false and
> helper function returns value deposited in `ufcfien` for qemu-user.

Patch description needs updating to remove ufcfien.

> +bool cpu_get_fcfien(CPURISCVState *env)
> +{
> +    /* no cfi extension, return false */
> +    if (!env_archcpu(env)->cfg.ext_zicfilp) {
> +        return false;
> +    }
> +
> +    switch (env->priv) {
> +    case PRV_U:
> +        if (riscv_has_ext(env, RVS)) {
> +            return env->senvcfg & SENVCFG_LPE;
> +        }
> +        return env->menvcfg & MENVCFG_LPE;
> +#ifndef CONFIG_USER_ONLY
> +    case PRV_S:
> +        if (env->virt_enabled) {
> +            return env->henvcfg & HENVCFG_LPE;
> +        }
> +        return env->menvcfg & MENVCFG_LPE;
> +    case PRV_M:
> +        return env->mseccfg & MSECCFG_MLPE;
> +#endif
> +    default:
> +        g_assert_not_reached();
> +    }
> +}

Excellent, thanks.


r~

