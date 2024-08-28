Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4129C54EDA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 11:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjGz5-0003YO-4I; Wed, 28 Aug 2024 07:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjGz3-0003Xk-9I
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:37:05 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjGz1-00049R-B6
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:37:04 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3df02c407e9so47282b6e.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 04:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724845020; x=1725449820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9fmPpDP8OWtQl6IAijiDcovfaipJncig+XTtKXTxvLE=;
 b=bjKm05yEENdthpXa4tx9rvninPB2OFrld2xQvLPhhslZdrSZO9JZsICiPsCFkWzY4G
 fuxDbFIJ9+1vKOA84+w6FjtPWMOa3x2YCbRJDR6ZcQiE6TN8qeNr7iJIYI1kDxvUQWrA
 rbNt7SJE7bqtIiUA9EGaRW7cCIx6r80OCk2oTS5Z32cZsLg1dRYjKXVTVPB9WktDXaNw
 s5Zr3OVleFRtnIQXhmh6H5wY54pjAyfAN6qh825oUc0b6aOdAqBMPwh6BpUVRduVLLAC
 SQRYNOd3gDuj3RWJ8M/pnkmqR5hWFxC26v9Kv8CUwQ8YRCrArY5/uFobKibs4VoSkyKR
 B3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724845020; x=1725449820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9fmPpDP8OWtQl6IAijiDcovfaipJncig+XTtKXTxvLE=;
 b=uqICka/uSPbyHqFTlQadOeH+HhGMrwMKFT3ZBYpnhOXQ0E4zo7vBDIK6wT6a/K+B+P
 SViOtn+qVQSHKTPMjULteGXTJ/WZ50DBZcAa2Cew1ioNXeQVPjfQhjuaXQvZELRZyouF
 YEQItJoMKKm0A7/nnozm9yDEf79Mf49WkWk8xk20Sx8y2ghrXyGIof+EF/fBVLMURgep
 XtvAJY7Kq0aFIQ4kPNmjvwe/vq3RfUL/CPG6APh2IFNX37JGUW8SYZFMKMUO4ou/Wiqy
 AtOA7WUocyljoQo1+UZoTQcQbuMovLNXvlVlmKG+sGKrrcWBZNG+IeOEQqX6uJY3nCuL
 yFZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9beSq6YLIqYRWhODPSDwWqXhahlx3FUPjxT0waY35mNbednYXNKeE22mPmvUQzDw8AbZAWdxakEz8@nongnu.org
X-Gm-Message-State: AOJu0YzTOwgqP/fYjAPXUtBfQ+ZAFx4KGxDKf/LzFvFBXYEu6E7nV6dQ
 DKWlShpQnynughmtiIc1VAAHDjn1InW5q63QzwMcGswC+wRAHwX0sUlGyCnb5MQ=
X-Google-Smtp-Source: AGHT+IFoCPBG93lcSRbTzREFz80UspVwu6xBCPl31a19d2Ho7NLp4qF5p24Lnt9bsVz+/GL0cpuqYA==
X-Received: by 2002:a05:6808:30a8:b0:3d9:dbe9:7cee with SMTP id
 5614622812f47-3deff9e7809mr567005b6e.14.1724845020476; 
 Wed, 28 Aug 2024 04:37:00 -0700 (PDT)
Received: from [192.168.98.227] ([172.58.111.246])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3de2258173fsm3075572b6e.33.2024.08.28.04.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 04:36:59 -0700 (PDT)
Message-ID: <207fe6f1-e7cb-49c1-9b98-169af456c941@linaro.org>
Date: Wed, 28 Aug 2024 21:36:48 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/21] linux-user/riscv: set priv for qemu-user and
 defaults for *envcfg
To: Deepak Gupta <debug@rivosinc.com>, Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
References: <20240827231906.553327-1-debug@rivosinc.com>
 <20240827231906.553327-3-debug@rivosinc.com>
 <CAKmqyKO2gaVNsSCuvSjTSOjKBOEBJOQC91BK0VDRscJbM-hx7A@mail.gmail.com>
 <Zs5sQ1FYN1JwfolP@debug.ba.rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Zs5sQ1FYN1JwfolP@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

On 8/28/24 10:16, Deepak Gupta wrote:
>> This should be handled by a CPU reset, which is still called for linux
>> user mode.
> 
> It is the right place for setting priv to PRV_U?
> or you want me to place it elsewhere ?
> 
> 
> Sure
> for reset values of *envcfg, I can rely on `riscv_cpu_reset_hold`

Doing this in reset_hold seems correct to me.

Compare target/arm/cpu.c, arm_cpu_reset_hold:

>     if (arm_feature(env, ARM_FEATURE_AARCH64)) {
>         /* 64 bit CPUs always start in 64 bit mode */
>         env->aarch64 = true;
> #if defined(CONFIG_USER_ONLY)
>         env->pstate = PSTATE_MODE_EL0t;
>         /* Userspace expects access to DC ZVA, CTL_EL0 and the cache ops */
>         env->cp15.sctlr_el[1] |= SCTLR_UCT | SCTLR_UCI | SCTLR_DZE;
>         /* Enable all PAC keys.  */
>         env->cp15.sctlr_el[1] |= (SCTLR_EnIA | SCTLR_EnIB |
>                                   SCTLR_EnDA | SCTLR_EnDB);
...

That assignment to pstate is equivalent to "priv = PRV_U", and sctlr_el[] fills roughly 
the same role as [ms]envcfg.


r~

