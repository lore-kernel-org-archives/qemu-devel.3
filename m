Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F60C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 16:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufLZM-0001OT-LU; Fri, 25 Jul 2025 12:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufLZJ-0001Mu-WD
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:46:50 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufLZI-0007ma-8v
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:46:49 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-74b54cead6cso1656159b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753462006; x=1754066806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BAxqerVC4EqnCfTP/KWr8tsu58fPn536wCloR/aHCng=;
 b=Ld5cJ4S1ekC08ND3r+xShVFnAdbH00+EzXWK7x2aWzOziUy1aaR8VZ1KXc5ZzYlep8
 JkCoPjVH++IXyNebWLK0Q1N5jIHoJcB/GEKMKC0Bwuesu8v3ebdsD9qd6wnRRGb1rHeE
 0wrU+IAH+a5veLHIeQXbtSoVGZDio8Rg8FeXqWMZfyVPlv7wk0/6rGqUl9jJmN1fW38s
 cuNrXR+reDDMa4wjNDOJkA7Wa6lYJhPeJ1IeajFy1ImYeBTQftKvChopYh2NVj9K2Nvf
 uDmAth/rxV+M9Sx4YIFT55e0Av4+CPVuwYgFKYuHAOI3hZnoBQXiCqrlbC5Z0WceV9wp
 PG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753462006; x=1754066806;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BAxqerVC4EqnCfTP/KWr8tsu58fPn536wCloR/aHCng=;
 b=dKQMHgWVJ0G6ERoEtJU5iE9BGPrhjarFaslpu6v9E95u/6Y4icKulfJ/7dn81TdYgf
 uxkSvXwfh3Frnr/q5yYjJZXGenhxEGGziMK6xYK9AGeWDHnNogDsNL65RQ0vZaLuomlz
 RnPEAE4CnzcecCwyEM1aBFEcYBAad1rgCv1dT2V0+neodW8uYdmkIKh8mT12oudd+00g
 V8uJtBrZGJyd2iQmpsrkor13bNR0FKg9Jmdex0O0dIQM1iuQmGPlZIq08uS2zEGCVVRQ
 lmwhE83hW5Et0jMbRlDrg3xNEYld+ESEA1ha+RFAy3akF47l47kvVxhNNacaTkQHku/m
 YgjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWddrfFmruIE0MtFZv3w38p/uNuFTsKsO1vHS85AP/93CWRatK5vlbgNhItvMBJfobhZyen0Dsq/kpG@nongnu.org
X-Gm-Message-State: AOJu0Yy4h9s5I+4nCTX1KRQz4Bf09aRRX1s7Fr3ydRBlREFLVlNUj5Dq
 xq/xGTFkcrCTFTPRqf3wJVOpaRtKZU+T2oq4oirOyWrdQh6vFPKODQEzoCSFk9/3l4Y=
X-Gm-Gg: ASbGncsrAJOGDRRBMj6qpac9/sJvg5na/Hf+TguLIpwPjhf2DsFTteymegLq5OLmMbt
 MhivwJtV3d3yOZ1+3E6+FVnppDha9XjDfjkU6jY9q7G+qJN8VwB6KCYhgr/qUpG0gMUdrFoZCT+
 o0zt/7AapE2BQjX9GNYTzPEgcKhc0xgoPyOQSBBZ4NLmHdSZlx/Tfk+2laycdF+ay3fU1NIh+r2
 LF+as7W1uBQn7c2zAO7NTQkEcTNBko6altl1G8XZNTa7dCtbmss3eBOFGyHzgesFeiJkJZ5p8Cf
 N3ixzzuoToQ3l6UZWn3OckHmzp3BhDAR0n88z7DF6YJqMYf2Z/07Sgse80FQh3h9W1vd4+AIjai
 jagwK1Z49zGAkj4nNXqtFgMxNsUDfn8KJTte4P/iMGQHvqHgL6o4Zu4BdO6mpBjGQZfpufg/17H
 7f4Q==
X-Google-Smtp-Source: AGHT+IHsB4gST/hazShvbATqvfVKOxqQO5Sx5qIX2L/eohoa/VwQhtI7CfbhLFedNmFK7n9JpNoXTQ==
X-Received: by 2002:a05:6a20:7285:b0:215:df90:b298 with SMTP id
 adf61e73a8af0-23d7015a371mr4381918637.26.1753462006465; 
 Fri, 25 Jul 2025 09:46:46 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f67d84esm190985a12.42.2025.07.25.09.46.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 09:46:45 -0700 (PDT)
Message-ID: <0b0882e6-906e-4a76-98cf-91c9284c4a52@linaro.org>
Date: Fri, 25 Jul 2025 06:46:42 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 1/3] linux-user/aarch64: Clear TPIDR2_EL0 when
 delivering signals
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20250725142240.3760452-1-peter.maydell@linaro.org>
 <20250725142240.3760452-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725142240.3760452-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 7/25/25 04:22, Peter Maydell wrote:
> A recent change to the kernel (Linux commit b376108e1f88
> "arm64/fpsimd: signal: Clear TPIDR2 when delivering signals") updated
> the signal-handler entry code to always clear TPIDR2_EL0.

Ah, I missed seeing that.

>       /* Invoke the signal handler with both SM and ZA disabled. */
>       aarch64_set_svcr(env, 0, R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
> +    if (cpu_isar_feature(aa64_sme, env_archcpu(env))) {
> +        env->cp15.tpidr2_el0 = 0;
> +    }

You can omit the IF and unconditionally clear the memory.


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

