Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6204C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uliPx-0007PZ-UQ; Tue, 12 Aug 2025 02:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliPn-0007AF-KD
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:23:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliPk-0006hO-19
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:23:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-459d44d286eso25977895e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754979791; x=1755584591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H7Ojc/JWGyzuIMBoj+pXveycxEURggfRtQJ21MWqBic=;
 b=e9WSaPhp8bOr638+BATr7mvCFEFBqKdmvsU0c2SPiLUEjpFcz7p73QkYcKbWQviTeY
 t0hC6+JfqX3URvsO7VIGGxe1xd5N1nABtbFivKDscuMyz7cCMx8RIvC5+yBJktOJLiD1
 /3HlTMJLrlCliQyHlfgaa+nHNmbrzGikX9EByIfPPlBbH9EzGw+MotoyTbGJjOJH8jDv
 zokONgoD0g8wzpN+ovuowqCbg1rSQ6SAH29tkOGe7juRghRJ7gYW7l+1jaZMO8r4b+lx
 KmmgQSDp7j3fZGVzXmrIG+lKyB1THC8rRYirGpIScIKasPLOHt+9GjGDi/oDDXrHKlpd
 ayhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754979791; x=1755584591;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H7Ojc/JWGyzuIMBoj+pXveycxEURggfRtQJ21MWqBic=;
 b=ceZ+cj1PRGEPHqwBYqED/2YcwJxE5N5WLKasZMHfaTrAGSxfJLiToEzEvqhd5LRyoA
 44bXnoOnjn06vZwwv1Kx4uN4gjbPw/pjoPWw6xrugU4A7WMjhbGtit7bXLF0h1DkmohB
 6quC/IsLr6zL74mnZaSA0r9Wqk29pZXbOkPEg62IDwKvDqsvQVzr4PBYiYl1NFuJwSQ3
 TuDp/lI55mxKB+QuoGMluMEoim044sOZWZ0j+SY7F+oAMvzlaaQpW2LMabrTKCWJ4nX2
 yc52WQYhLlJ+HIkERMw2zAyB9hIRVqne7dBfao7P8oQCqvEWWt/49Jq/kpF/GEppqIeT
 +eWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcV/mNowvhK2NwAOIwwaP8TLBlVK3Zw4PV9l5jXChq7E8PqIaG0QgLoyx22zzGi41KNxm2m2qRVyO2@nongnu.org
X-Gm-Message-State: AOJu0Yy3ZZIqeumnk0/Rf6szB2BwGd6mnv8cD0LzbEdeAdm3dz9sJHEJ
 4Kj3VM28uqiMduzxei6qytnVevK94RGwYxJiogPi0enj7yUnmcxNvNGxjyLpGcAVea8=
X-Gm-Gg: ASbGncuWCEAGPLgzNGlXbJ/LAHx1V38NGUNrYaMguOSsBI9HZm4fURCfLjuguTxU1Lq
 uM7xucMI1+Tsl9oFi0nDAbRUGROPrXzyI1yFPoPw7HekuoKo/fYR9HerdM7AA6wPyqblJpdGIWn
 /aId7wlqG6E97QwenQ2dJCmskA00IjaLKlwiDaQuh110f/riHkAQZ9Qb+XM/fpac2isBjBq3rtd
 atjj0G9ZQU9Q3U168BajWU2/OWQUk30z3sY/acTG/f+8zjMs3qsxHyoZOK2gPX/Nh2YzFmvPBsm
 h05059CHHXzh9D8VRjuhhJ9JWFguFfFMYcldyHl6EPMXLNTAvOPusSqUlxJ/gAWAMWM42zL1zGH
 T/Qtf0VSbv302hB9Ss8o9rYSDYMREatcHhL8s5dchTZK1vGtdhohAz0HtxzCjwFldfg==
X-Google-Smtp-Source: AGHT+IFseucO4iV9CSDNs1VGC6v94KWoTqs6Nck27Gx7AxyvdqI6+ucxA505SiqIz4ik90yijpg4zg==
X-Received: by 2002:a05:6000:400d:b0:3b7:590d:ac7d with SMTP id
 ffacd0b85a97d-3b911148b2amr1820464f8f.1.1754979791344; 
 Mon, 11 Aug 2025 23:23:11 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0846777sm33280954f8f.48.2025.08.11.23.23.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:23:10 -0700 (PDT)
Message-ID: <882e4862-058b-447b-b38c-c9dc4c92270a@linaro.org>
Date: Tue, 12 Aug 2025 08:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/85] include/hw/core/cpu: Invert the indexing into
 CPUTLBDescFast
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-29-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250802232953.413294-29-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 3/8/25 01:28, Richard Henderson wrote:
> This array is within CPUNegativeOffsetState, which means the
> last element of the array has an offset from env with the
> smallest magnitude.  This can be encoded into fewer bits
> when generating TCG fast path memory references.
> 
> When we changed the NB_MMU_MODES to be a global constant,
> rather than a per-target value, we pessimized the code
> generated for targets which use only a few mmu indexes.
> By inverting the array index, we counteract that.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h | 11 ++++++++++-
>   tcg/tcg.c             |  3 ++-
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index bd835b07d5..23eb849a9b 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -594,9 +594,18 @@ static inline CPUArchState *cpu_env(CPUState *cpu)
>   }
>   
>   #ifdef CONFIG_TCG
> +/*
> + * Invert the index order of the CPUTLBDescFast array so that lower
> + * mmu_idx have offsets from env with smaller magnitude.
> + */
> +static inline int mmuidx_to_fast_index(int mmu_idx)

(unsigned?)

> +{
> +    return NB_MMU_MODES - 1 - mmu_idx;
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


