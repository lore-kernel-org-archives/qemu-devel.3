Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD16AD3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 01:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va1qK-0003Ru-6C; Sun, 28 Dec 2025 20:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1qE-0003RP-0E
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:14:34 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1qB-0000dL-FT
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:14:33 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8035e31d834so6040015b3a.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 17:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766970869; x=1767575669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q/J0NNQw9k91su4BdDMewYU4/rZFORdaK/0Mfoe/GSE=;
 b=VQG2HuZVZ9ikQB1aiVDoxYd4Qd5nettEG859pKIeApUHrWZW/ny9+L1iztXhq//B8m
 bjmwmP2TVdnWmTPb96WZt9ZKKxN+nrjXMq1o8dlhg1Q2hg0UsAjeFBJOuPhOLq5DAeh6
 E6tqRGgzwcbcCd+E5JdEaMQncJq+nABWWc+Pkf5+y2MaatiNkuj14PlDZgzI04q0+eL6
 LbbXAYTBE/z0aC2VunlypOMay1m/R7SIzZ91UMAWXc02JArLreSzSotGCm2gWCw7H2PH
 N9dIZeXGSgHdZxbSG7a3F/qV0rp92FhyLCYTQ8WGqRvnkCdnZhiTXJTAvaDyUOAYJXom
 CIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766970869; x=1767575669;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q/J0NNQw9k91su4BdDMewYU4/rZFORdaK/0Mfoe/GSE=;
 b=EHoZH2MeLnfRhzViSPpryoU4FmQ86JEgty8dS3QCUklnkruC8tDiYbysHaM5AwC0MN
 TW+drsTqL8yS/uuRp959LAA8R8hCdhUhMZVDU/1zeoAKJB+3IUe06nuwYfqDTsidZESI
 q3aEcyP2WH6sJ6fOn+/sM4F9tCUnuYrBrcJxmykpu9ibKj6kpkfbcnXvbHdNJwXtII2W
 kM4B6j+MoNLSEvCs32GitwldCVVCEoqhOXZO1HfAXdAGgDEwKWgFsPbYL0fO1X8H2zvJ
 eofIta+gaaO2zUp9msTOP5y04LbwhvgO9u2ZQcBGD/LLLHz445DU2jo1RCJsik1fqRaA
 ZEiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEgXps7TmX4SK0M6Pcu7wzn+th1qVg0KqN9Bei4xVepir+aD/SoqbEF0dCH7ag+31gPwNvIdXthcN6@nongnu.org
X-Gm-Message-State: AOJu0Yyc8T83R7XaSKG6Tov5Ab6vxhlx4Dgsrqbsvqu8NaLyniTwxkip
 Kf0bZbVwob2tjDD94EGJubOxHfJv+FOy8kKLALy1H1FzL+fVEcAh2xbLEAnCcqmEbjw=
X-Gm-Gg: AY/fxX5O02+Gjk6E/l+c4HBVmHq5U2k81uzd4yF/ZQkHFbtPO32RdpKS1OL2THeQQnU
 go0/KerjaATtISkKOah3VJklCZbgY09H68/h3tWpIVQg9Fg5t1+h/VZRQ4/1ebGj3NcovjrhtG+
 upxBpjIQ0eCFjR7MEDVk7ojV+Ooe6BfGWR2fV18vRPmChn2e+XQ8WPtbz/kYQkBseLJO4fcxNMm
 0MpMpzv472lf6tsxrtfUXPu2QjOZP3Gcp45ENqBpzOJiUCDvjOKWbDX3tOl5bqVXHz3kaDQwmEO
 Iwv4KA4l3tZCC9XlFGXfTmVSBkA1dEZDo8mj1oLXL7TzJkepG7zis/a0FxtYbL5l+JPpkECg+PZ
 Xa0whKkdzEMe7umT2WnnDZtbHiVpsT7/F93msXjwtnRYSeJmmVfvvrKHd9uuAac17zfcSJJQBGo
 xKr/WPrndlFNX4mw51CADF7mUS8dSzrLVeNCZo7EQ2Wl0BDKwgFRtvuRFsidYn3stb7QLt1w==
X-Google-Smtp-Source: AGHT+IHG8TC+Yx2A5HDnKIHX0r8KxwAfxnMkTFVm7VMD+wKnzF7mH/mfOHw00KP/riYyfZ+ptYyHwg==
X-Received: by 2002:a05:6a00:440f:b0:7f7:3c4f:9407 with SMTP id
 d2e1a72fcca58-7ff657a4b27mr26148440b3a.26.1766970869495; 
 Sun, 28 Dec 2025 17:14:29 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48cd07sm27635116b3a.46.2025.12.28.17.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 17:14:29 -0800 (PST)
Message-ID: <0d46e0e4-3bbd-44ab-a26d-cc2c79e6fb05@linaro.org>
Date: Mon, 29 Dec 2025 12:14:13 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/25] system: Allow restricting the legacy
 DEVICE_NATIVE_ENDIAN definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-23-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224152210.87880-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 12/25/25 02:22, Philippe Mathieu-Daudé wrote:
> Guard the native endian definition we want to remove by surrounding
> it with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.
> 
> Once a target gets cleaned we'll set the definition in the target
> config, then the target won't be able to use the legacy API anymore.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu-common.h | 2 ++
>   system/memory-internal.h  | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index e0be4ee2b8f..f4961a20911 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -39,7 +39,9 @@ void tcg_iommu_init_notifier_list(CPUState *cpu);
>   void tcg_iommu_free_notifier_list(CPUState *cpu);
>   
>   enum device_endian {
> +#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
>       DEVICE_NATIVE_ENDIAN,
> +#endif
>       DEVICE_BIG_ENDIAN,
>       DEVICE_LITTLE_ENDIAN,
>   };

For cross-target compatibility, you surely need the enumerators to stay unchanged.
Add "= 1" to DEVICE_BIG_ENDIAN?


r~

