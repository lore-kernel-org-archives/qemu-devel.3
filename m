Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89305E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 22:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL8WO-0007tc-He; Tue, 10 Dec 2024 17:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL8WM-0007tO-1Z
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 17:15:58 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL8WK-00034g-BW
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 17:15:57 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-71e10e6a1ceso223401a34.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 14:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733868954; x=1734473754; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bCev6wLxGvq7FDFIAO3zGHd/R/JM3tAOqOhBoBXBpLg=;
 b=U+bLTsPkc52XQKOlZCBPxo1Ttzp70qc/8Fq8P/+r3KUTYZpRInz6pEVFmp3tEwtGAZ
 B9ANrj6PsoSY9K+maseBdYPq1bpciDgwjxy5NNu9yUhCifSVHJbga9KNF2OQ3abcGs30
 yOgH+Z/OrAfpQCD65OHe/+6lCUhrGlEnVeDG9C0DqdMFz+LuAT/K41bmLEYqxdnUiFvr
 oTd/JyEj8pr4+fNpFkrHtjCvcagXUAYEvdR/4dXLEXNQOUBf7TjRkJMy1tA9dPZVho/L
 GhGyPJ5HWPXbMqb8j+5NfPxwemh2+Nj0UqyDRtTMjt8SMT6+xQZ4zvmEVzJ8l+Jx5Agh
 JpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733868954; x=1734473754;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bCev6wLxGvq7FDFIAO3zGHd/R/JM3tAOqOhBoBXBpLg=;
 b=vMA+caK+KBt2751G1Kuwt1tskWoulVVcSx1Nz7y0zmHl6uShhDg55gayxx7MOeYi9R
 GCdnno97OOuDsHySd6fM3NrGhxXRlBowibI95+I7aOGjhQOy3eqFX2e4H1b9HZfFaJI2
 Vo+CKIaHv6u0gTge1z9bpXtIVI7MqMAmo/LSOZbs4I9eRIJRpmgmThNJkUBaLcWGLN57
 LvWEbSHbikCNsRJjXKbiGLotItNH6zW23r4NIGaLM+grWt4jMbzEMS088f6opIUcXFcs
 pE8abHKj9ggMiq9luANGBGbkGaM+ibhlgIchp7VJDF5ipPwQwElE+JjjS4akV+92385L
 2WnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQnOqwNBm00V5eOUbT3H7h3tlcv5qWMwb9vRz7a5zn/zLDdUrmZ+gwzg2W5xh43wTuk1r68++9XJOG@nongnu.org
X-Gm-Message-State: AOJu0YwJeAGqcRyNgCmIgHC/uNCv1VL87fJtKXcAbzD7xVOkjhxMUE6O
 Yho5Ekdvsk+9Y9XyGst4sS4IA3fjEZadq2MsvTOJCmjfciFd57TBS11+gGV2Gso=
X-Gm-Gg: ASbGncseRM2MhlmFUhFqztJXjxcP3yWBZQ5Nr86VSSVc4R5EoD7rEuZ4gz7RDmOKIqb
 T1hXx72Z4gF16c9LBF3MCwLMPxMpdhZ9iqGrhju5GKaV1lQW2yqaPUwj1WxepyYIhU3KxVJTjo4
 /15yxDLimrTda+tX+SKO9fHsUwpUixmQhFG3COXwgB99JyLCNDpE42wpB1wcXIhKb2FPdDCyBdK
 IwlpBiYyW8Ckqt3GVWpl+nS5XiIbbwCtZgzr2RjtsrqSHyN/HV26dIxQKxWSmDb1JaSOKG1ecGS
 i3yrE4m/l7SSN9b0ENqbDMqwe39733kP
X-Google-Smtp-Source: AGHT+IEpSwEJ9+g3gHqtC1mfXPhKrborDzVbl82zR0eSVFzMwyQA4I57yuQzDBlDRw//dZmKUHFepA==
X-Received: by 2002:a05:6830:650b:b0:718:1163:ef8f with SMTP id
 46e09a7af769-71e1979c23amr296022a34.2.1733868954154; 
 Tue, 10 Dec 2024 14:15:54 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e0303ada2sm799710a34.11.2024.12.10.14.15.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 14:15:53 -0800 (PST)
Message-ID: <5d3c9f41-a6cd-4129-a08c-fdd1181e299d@linaro.org>
Date: Tue, 10 Dec 2024 16:15:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/20] tests/functional/aarch64: add tests for FEAT_RME
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20241210204349.723590-1-alex.bennee@linaro.org>
 <20241210204349.723590-16-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241210204349.723590-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 12/10/24 14:43, Alex Bennée wrote:
> From: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> 
> This boot an OP-TEE environment, and launch a nested guest VM inside it
> using the Realms feature. We do it for virt and sbsa-ref platforms.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> 
> -----
> 
> v2:
> - move test to its own file
> - add sbsa test
> - check output of `cca-workload-attestation report`
> 
> v3:
> - build and run test with cca-v4 images
> - factorize nested guest test between both tests
> - remove accel tcg option as it is the default when running tests
> Note: It's a long test and there is a work in progress to understand why
> debug build is so slow (x12 vs optimized).
> 
> v4:
> - use pauth-impdef=on to speed up build time execution (x2.5 faster)
> - increase timeout value
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Message-Id:<20241203213629.2482806-1-pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   tests/functional/meson.build                 |   4 +
>   tests/functional/test_aarch64_rme_sbsaref.py |  70 +++++++++++++
>   tests/functional/test_aarch64_rme_virt.py    | 100 +++++++++++++++++++
>   3 files changed, 174 insertions(+)
>   create mode 100755 tests/functional/test_aarch64_rme_sbsaref.py
>   create mode 100755 tests/functional/test_aarch64_rme_virt.py

Pierrick's changelog didn't get cut while applying.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

