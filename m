Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F84C19F2E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 17:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnL2X-0008Ui-Uc; Wed, 26 Feb 2025 12:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnL1u-0008IF-H8
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:17:08 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnL1r-0007Tj-S1
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:17:05 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6e6621960eeso11399936d6.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 09:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740590220; x=1741195020; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7CqkQ+0lPid/TmZ9PIusP2t2YhjjICdWsFKaBMFPXRg=;
 b=hwN1uM7oTWgEc/Kp6u0yFuSB22ckhCqHpqrlPuEb0xfpGPQ4N+g5Ja4KikHGfYHb5B
 GXlNj9Y8TDs4qwQyed2A3bv/5jhe+nHpFyUXPRlMFJKMUqOoLdtAKaT/O3uvq/353T1Y
 XZ/pV49uQZ0vUCDLsjFZyCVVRFy7NldTfZSO91gKvzGtv7D43N5fPwUCY1N3nCBK5CtP
 Wk0tHEyMJLKgSiescntkTm3T4Nljz0bcbGpWGCBzYjExQvy9OC6TWwQUZgdwdKVfax8W
 EzlM/Ne7w3LGJa5adNXtg85d0K/ln7m8gJBgcH+oQKDQzei8BwEbWhenccKN7K1NbXR+
 gqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740590220; x=1741195020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7CqkQ+0lPid/TmZ9PIusP2t2YhjjICdWsFKaBMFPXRg=;
 b=CUtU6GUXsd11V4h/DlTR3KEZE//IZFxfTzlJQfNZ/ht1cHSIudMSPpcII9rH80u0Es
 qyz52fxIBfEOlLd3XRPE7Pv/VRcqd6jVnrRvt6l7GIbrqHdL/TaoMV9HnW80AQqu1RLY
 fbgKPXf1KtNvmuc+JtdAX8x/7r/v1fkjHEEMjjXKK3NPe4hithx2zsaUW1mosqGZ/jnA
 f/2W1mLyWuKnRI6entArAhtnTUFBCmFEXKHBPg323N0kd9+mI+cJZdcI/TZkxkppZMX0
 aZhzxzjzsITgketvaMrZ56/yP0EzsQwy53eNLV+lktn7keU1orGvnFEgCKzc+J68HAMb
 1+DQ==
X-Gm-Message-State: AOJu0Yxy79EuTjrur4W2CtFKIYYY3VaMjBywneXvmjfLo0ovm6vnQvwb
 hJn8WKO9dpogdbtetTcaSe1bfEN5x6XrP6HxBTnXDgcXgR7NsR4Qufx/wV7iUS2MjoNHNvqDssV
 P
X-Gm-Gg: ASbGnctWtNypo0A7c7/7GTy8p5dnyJR49vD4BZRIdISt+iWZ172whzIjx8L9nfV6Vfl
 3nAO8h4I4YWU++Qu7JkbNd1CmbcHPFXURgdFYTOfX3xbHtZv69i6rIyA1pStOuT1UTgZVzaM99C
 xsO4LlXeTS8kEeubHTkwPq+KqRwnuzEn0kp6vALT9EiA1ZiRgNixaowhG9V091i1BbUMZsrZVdR
 KgQWZJIqFavvgfwsogC47j7Bz1jLw/3nZh1brHV05hHVj9yCiAP+NMf9Se3SdLOkEeJS9SviEKj
 oebYaDzxo10YDhdn86MxUSIglvj6htcVQv+wgoh0/xtSou/Q
X-Google-Smtp-Source: AGHT+IGPtHeUjuEskRbHHKxbNYDzSKT/fZVwUFQY8jgrIn2CyBj+lmV8GikZ0NxwKD42kv3QmRQqbQ==
X-Received: by 2002:a05:6214:2aa7:b0:6e8:8934:338c with SMTP id
 6a1803df08f44-6e8959ea03bmr2209196d6.10.1740590220450; 
 Wed, 26 Feb 2025 09:17:00 -0800 (PST)
Received: from [10.254.143.227] ([172.56.201.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e88b529365sm8627106d6.42.2025.02.26.09.16.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 09:17:00 -0800 (PST)
Message-ID: <e9bf0606-c031-4e4e-89d9-a65a9f6171a4@linaro.org>
Date: Wed, 26 Feb 2025 09:16:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] target/mips: Enable MSA ASE using a CLI flag
To: qemu-devel@nongnu.org
References: <20250226170246.1971355-1-aleksandar.rakic@htecgroup.com>
 <20250226170246.1971355-5-aleksandar.rakic@htecgroup.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250226170246.1971355-5-aleksandar.rakic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2d.google.com
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

On 2/26/25 09:03, Aleksandar Rakic wrote:
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -399,7 +399,7 @@ static inline void compute_hflags(CPUMIPSState *env)
>           }
>       }
>       if (ase_msa_available(env)) {
> -        if (env->CP0_Config5 & (1 << CP0C5_MSAEn)) {
> +        if ((env->CP0_Config5 & (1 << CP0C5_MSAEn)) || (env->msa_on)) {
>               env->hflags |= MIPS_HFLAG_MSA;
>           }
>       }

This is the wrong place to force-enable msa.
You should be enabling the bit in Config5 during cpu realize.


r~

