Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EEDCE8D4D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 16:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJwP0-0007y7-Jr; Fri, 14 Nov 2025 11:11:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vJwOD-00079t-E1
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 11:11:12 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vJwO8-0005zc-Jw
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 11:11:09 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso12136175e9.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 08:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763136662; x=1763741462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=my1m5mtIWjflG3lRJsudz2+b8KHn/FTs7kZCH7HO+Yc=;
 b=MZVGy+fnmPSLD2hd8GBPUNiYv/LSqGxsDVCFgBz12SNI5kDv2oNHCCNl1mHm7mQGhe
 HgX/cJj+YXHkF2IEtbkoWb+r54c236nu//U3XbU0NvQaT8XEmbnT2vn3Utt8kS1LXhHn
 4kC4XKmB7A6DzkoMxnr/xs80bzY+9tlDcOUg3YUVs+HYcmv8LFv8hif4JepsmxXQ+JVg
 iX4FLy78f2Xq8qjkWcFXpjdcICSkVy+SeXEwknJHX3QU83nfKF+1PYQso9+8/Vp3H5LY
 Tr9m5K9/8PZyqqIl9bMjynaqPuSCtCWjfnBza9LIsKCehN3EfAoF8XolflD3XC6ZCrRa
 6DOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763136662; x=1763741462;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=my1m5mtIWjflG3lRJsudz2+b8KHn/FTs7kZCH7HO+Yc=;
 b=fsMz0t2CgcCiXrr+bCYr57E0iYdUl+LipxxZTKw8kBSzAZOufWvhia++7ttCcO1gf/
 a+h4asNVzkk5blWYQnNCMU7E8l9RX7zg1I1xZauh2muBLet+0ytwuAX07gjdaOoQ6WlV
 Z3pEv2XcNRZYqTl3fgHMJjlVVFiXgUzManjzdO9+9Wr62ZWLic2uAdMwsXLTPQFXRgp0
 avH0zBvUrErGdyJ3vvbM14gOSzfMxPXLbkgLx3fyc5mIvWe9GgOHjvXpKPxodwCe+9pS
 OIBzg1mO+w+5s+LvJYgsECWgswwzuSxAbWuFGOBrYh3mITbYriZx471mRvHUbhZlXQXW
 4UcA==
X-Gm-Message-State: AOJu0YzJL7S0g7jKTUOlmFFu0r7v4a77CfSidHypGJAbBCxltrxJ+UF3
 bsUQip7ttyV67CMIGt/S5aTBTd/X9gS5zzpPdvoX88EHsE5SP/G6gwvSvQFUzIoIZ8c=
X-Gm-Gg: ASbGncsWUOxp9cF1CVuRqO/YGWCpu3bS+e7Sp1X7zpX5z1DXT5+3w7yHO2l8VUsdN1N
 0QYrLAUpGLXd9qvUKK3H9DdHlb6sJ1b/kgD1I3N9lD/gfvB9foKcsUl6EIPMrulHzGqFoDlW44X
 vPQAjsRQC8Nbadj2XLXBe1jbGxQX6tRf9klLoZCLqdOOHjpd/5D4ofc3RUa3TwzE3Me+5CZOyrP
 PteXhuIg3lNJoScJ5eX1ND+Du0XxSNbd7a+VkJIV1eQvFUsGuGYFjS86dv93mBEMU04GN6vrj8Q
 CW+/cKOzQeCG1is6oy48ApZZsNrB2zjP+d5IF71mmaqAYB/ODYg4imsDE+3dCdecC5LDVhSC5ZN
 7F9fPjm2OQUsA56ZU6OLOo1mJOYfHdg4BoOEaeaynVGGvro02Zv1N0hE3IR0fgmFowoc0mzpJwI
 jtmu/A6hwh+yAG/EcWdgz/ZpshOi5QIVM5M3ZHfg1OzQKQrfrDkfjlq0zHZA==
X-Google-Smtp-Source: AGHT+IGU1Jf5JmbTX0DVU2ZXpR3O43CAEmN/IerqZjVzEPfi8oO6zD+9X/yukzsRHv+28WVC+FmAAQ==
X-Received: by 2002:a05:600c:4505:b0:45d:e28c:875a with SMTP id
 5b1f17b1804b1-4778feb255emr37502065e9.31.1763136662424; 
 Fri, 14 Nov 2025 08:11:02 -0800 (PST)
Received: from [192.168.8.105] (86.red-80-27-231.dynamicip.rima-tde.net.
 [80.27.231.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47795283656sm14957935e9.12.2025.11.14.08.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 08:11:02 -0800 (PST)
Message-ID: <4ff27fb1-2940-43f9-b9eb-96837497d537@linaro.org>
Date: Fri, 14 Nov 2025 17:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Make sure fetch_instruction exist before calling it
To: phind.uet@gmail.com, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>
Cc: qemu-devel@nongnu.org
References: <20251114082915.71884-2-phind.uet@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251114082915.71884-2-phind.uet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

On 11/14/25 09:29, phind.uet@gmail.com wrote:
> From: Nguyen Dinh Phi <phind.uet@gmail.com>
> 
> Currently, this function is only available in MSHV. If a different accelerator
> is used, and the code jumps to this section, a segfault will occur.
> (I ran into this with HVF)
> 
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>   target/i386/emulate/x86_decode.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
> index 97bd6f1a3b..d037ed1142 100644
> --- a/target/i386/emulate/x86_decode.c
> +++ b/target/i386/emulate/x86_decode.c
> @@ -77,7 +77,11 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
>           memcpy(&val, decode->stream->bytes + decode->len, size);
>       } else {
>           target_ulong va = linear_rip(env_cpu(env), env->eip) + decode->len;
> -        emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
> +        if (emul_ops->fetch_instruction) {
> +            emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
> +        } else {
> +            emul_ops->read_mem(env_cpu(env), &val, va, size);
> +        }
>       }
>       decode->len += size;
>   

We should instead have fetch_instruction == read_mem for the cases that do not require a 
specialized version.


r~

