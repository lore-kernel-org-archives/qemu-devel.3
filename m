Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9680AC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 22:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqK6M-0005PX-3g; Thu, 06 Mar 2025 17:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqK6J-0005PD-J0
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:53:59 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqK6H-0005xy-B5
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:53:58 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223378e2b0dso18322995ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 14:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741301635; x=1741906435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nl/jhMzmVZEo9pU7yMQkkOyBLUor62rSygjZp4bu5bA=;
 b=AxqJhn8BnsbF2ybZFjYqi8tEZYvYO8ICHDVJV9Akgk0wBfM4pZXCnykaspxfcYMAEj
 IGvYnVlHAhZnbua4p6I62qv6RfaONLzFao/w7B4RwrHB7fu1eo4hJh/MbwcUqGHqoZHq
 LwGLhWCbFXv3ufn5pph9pjwP50NIozh19VeZIUxFAuCp5HDChx9A/SBTxHWSyQLTHxrW
 RzQIMcYcMdCyVZkXrXFIflAUVA76SxqjggAQPAOxVA6m5pYb3YUtSTQgjbcw/CEOHOD3
 DlvWQPhu8+rkELspFTJ1QVjUTl+ri6XjWQNHCwkXeHfZAO28Xvyo7EtX8A7WSvcunrOP
 LSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741301635; x=1741906435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nl/jhMzmVZEo9pU7yMQkkOyBLUor62rSygjZp4bu5bA=;
 b=Jw0ifJPbA9vXuGhVheYQKOw94JtsZHyFH9SQ8J5hhd5gz3XcDJgOLxDbLJZDI6i3Hy
 YZF1TJUCF7p6Qc3j6qbe0yIAOb9HudVSZ8xUyFprkjPWDALJy9eeJko3MIiaEMoKrMtV
 SYPuStSLouY6wablH9RIh4mihAK1jD3nLVXOoPDhr25AwzrA37CVipvVDy+JDUd/Z9No
 E7a4xbS/I8KOq/R2/zh93RjtdhzFkNUnvOG5ddlBD2Gq2QDz5IJYLslJZswk+W8r41Cf
 AZgEPpMhOFZ1sFiik0odtDPLZ/7SbV4p+2CFDWzHxuME+tzJdOZDDHk4IvIqZTp4SAV+
 mK6g==
X-Gm-Message-State: AOJu0Yx/Zr0Bz7NgnJQ++zVAoMKOqzxwpNb7jiZaoN8Rf/XZojsIuD3+
 bzvvjJ4/NNDYKTnbV8jqD35d0Lph4wO8xL0yZIm82lH0owSg51oDrEBOG9B+gAld0pYsp5l2BbU
 K
X-Gm-Gg: ASbGncuGYXRwTDHtdOpdq3u2Hw8rdxy0XgTl4p081yLITXC8yyofTJG9BKeDGGP82Cl
 HBo8aJZz2ulKYl8K6Fwx53DPo9+qeaMSZ3MfUMBZCDCFXsT7cOSsQur9fmzze0NNFItvFr9co07
 hUw4uoSL6xhOD5isq9m42dx0G6TRb9IlI5+H6zoLCWFx5CsDfQjxIkzpfrdh1BR6bCrMcBZyG2v
 ANWXIiRC25I3sorsD3Ur3v04Pdnzn0ZgyACvf8rp11PpoxTg/+mQt6FT2oDORH8QMPuFjIjSh1U
 X7+Riz2RIVyNFwUdL2cgOJ5I4v9Z3umzGZ8ZTMP6lsztz89hUfgxhVkZqMasFdb8qBm1+h7M3j5
 DC1J6nbuU
X-Google-Smtp-Source: AGHT+IGeU40AWz4W+RQD6osP2G1g81PWzQwT8TtMZkPKM5hHVyUGAHP+BCpsW52lBlI2+LsQ0OK6PA==
X-Received: by 2002:a05:6a00:8d0:b0:736:7960:981f with SMTP id
 d2e1a72fcca58-736aa9e55aamr1970716b3a.8.1741301635508; 
 Thu, 06 Mar 2025 14:53:55 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73698450244sm1917873b3a.80.2025.03.06.14.53.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 14:53:55 -0800 (PST)
Message-ID: <54de9ed5-6314-4a49-a1ed-cc9d6225897d@linaro.org>
Date: Thu, 6 Mar 2025 14:53:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] target/arm: SCR_EL3.RW should be treated as 1 if
 EL2 doesn't support AArch32
To: qemu-devel@nongnu.org
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
 <20250306163925.2940297-8-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250306163925.2940297-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 3/6/25 08:39, Peter Maydell wrote:
> +/* Return the effective value of SCR_EL3.RW */
> +static inline bool arm_scr_rw_eff(CPUARMState *env)
> +{
> +    /*
> +     * SCR_EL3.RW has an effective value of 1 if:
> +     *  - we are NS and EL2 is implemented but doesn't support AArch32
> +     *  - we are S and EL2 is enabled (in which case it must be AArch64)
> +     */
> +    ARMCPU *cpu = env_archcpu(env);
> +    bool ns_and_no_aarch32_el2 = arm_feature(env, ARM_FEATURE_EL2) &&
> +        (env->cp15.scr_el3 & SCR_NS) &&
> +        !cpu_isar_feature(aa64_aa32_el1, cpu);
> +    bool s_and_el2_enabled =
> +        (env->cp15.scr_el3 & (SCR_NS | SCR_EEL2)) == SCR_EEL2;
> +
> +    return ns_and_no_aarch32_el2 || s_and_el2_enabled ||
> +        (env->cp15.scr_el3 & SCR_RW);
> +}

The computation here can be simplified.

     if (env->cp15.scr_el3 & SCR_RW) {
         return true;
     }
     if (env->cp15.scr_el3 & SCR_NS) {
         return arm_feature(env, ARM_FEATURE_EL2) &&
                !cpu_isar_feature(aa64_aa32_el1, cpu);
     } else {
         return env->cp15.scr_el3 & SCR_EEL2;
     }

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

