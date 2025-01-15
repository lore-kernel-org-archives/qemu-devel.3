Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F317C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 20:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY9oe-0007oF-KA; Wed, 15 Jan 2025 15:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9oc-0007lt-Bm
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:16:38 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9oY-0007Rr-GX
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:16:37 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38634c35129so161076f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 12:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736972191; x=1737576991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bQGoVSRu7B9mSfoUyvX2BU0XdN1zdi8Bd9nHTAZ6ebc=;
 b=Z5xuPUTPICQB4tVFElxnUBTWLmMk7D2aA4+6l1XepLMqii48N1pN6O70F2H+Fdm3Dz
 nF6GMDOIosnkLpyhArV9OiI9ylHsQX6A4qCTojzGzmoWhZrjaIAz4ijWIqB8REN+Bswa
 gmjeyPFtdRqsPO4UWNJtEgnGabdaQoj7J7we9+gH7Pw4KRg54mlXBg56/oc+e8PMufo6
 T0uKuMDXPTYx1qfPJTE703xZ/XIiZVkR9F+qcTIT5xQGU2XocOjPUskLvEIU6FKgDPU/
 SdZkZt1L9iNCOCEDx+v7e1Wu8woWWTh/qx4rhRsRsJdJAnU64NE0A2M8AcDumdkVMHtW
 beCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736972191; x=1737576991;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bQGoVSRu7B9mSfoUyvX2BU0XdN1zdi8Bd9nHTAZ6ebc=;
 b=KpbZaSva+aOXOoFTF5atfaWa3+OXFRIwG5QFHy8rRZjSXA27slCsdbHrHDskMqtMnD
 NVn2TAfDbwlt0xlyxrsyYkg3GHjqA4bykz3kuNz+GSjGmTrtN93QhiP8IiHKlHgKnymt
 i+k/lJDhVpLwxaRLy/iEZyE1eZ3IzRLhgAI2Vwo8pkL1TNL+WusW6PBknkrXI5kznIYF
 VtOWc7v9/H0D3B60M9d6mXzupq+wT4gwRdbq8jU58UjPUzgSfE0iDDK36YhgLew7Ng9s
 VESP97IY2rHUM8WNw0pBileCH0PvK0l8TbqS1tltjjFLJqYNtzHRkz55iuhFrj3sikh/
 ZJ+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4DB61zrXikDgjJR1F8pw7gMLN4Nz7N6MY8fPC92HAYpHlFRno8iHAfpBJQrjPbCu6BxsdZL7EqJWS@nongnu.org
X-Gm-Message-State: AOJu0YwKqlmkUhYTWhVYT7ARQm0xYiiGUkhaNGKnJlOT4U0UNLRXheuY
 Ix9vyPmU55Jl5ZTxjMiQcT3i+9cFNbAYyY4HDGFa56a83Y0gLM0H3NnZB5bALNI=
X-Gm-Gg: ASbGnctyZh9RWNiIylBFwj2tkPBTCDdczelW0y1nPlTxnccT25uCab6jLfZPUYnB7Xf
 Pm9hkxYcvs2pA94Z8EEmEdbZ5r6H45bOgkcmMD3DrXYbadi1IzkwDXJCzqDBPNHrCBt8ezpOJuk
 QPTfkjTUEu/iEbQvyN8QvPQtXmyBZxoqPku6HrTGtPTYxB5oEaGU2/uNxK7ojQQHuYwnsItkcz1
 7LUQboF6svp23+0kUeP+tH50Xab3kbf53RoQqWWIogX0vXqlrYoNOK51FUvCrdbV5ql9BIk8jUT
 UHKKVzcqxhkUPmCjlDIbJSu9
X-Google-Smtp-Source: AGHT+IGKvl28qMDRhJgUmhTVQxm9wlY+FI8QSgbhR3HbtNtNJrTf9Fu6SR21hggZLf492ShNuf4Grw==
X-Received: by 2002:a05:6000:1884:b0:385:f1d9:4b90 with SMTP id
 ffacd0b85a97d-38a8730531cmr26072711f8f.13.1736972191342; 
 Wed, 15 Jan 2025 12:16:31 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d111sm18948012f8f.18.2025.01.15.12.16.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 12:16:30 -0800 (PST)
Message-ID: <68565122-d62e-47e7-87f9-c51c44273d4f@linaro.org>
Date: Wed, 15 Jan 2025 21:16:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 47/81] tcg: Remove TCG_TARGET_HAS_{s}extract_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-48-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-48-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Make extract and sextract "unconditional" in the sense
> that the opcodes are always present.  Rely instead on
> TCG_TARGET_HAS_{s}extract_valid, now always defined.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-has.h     |  4 ----
>   tcg/arm/tcg-target-has.h         |  2 --
>   tcg/i386/tcg-target-has.h        |  4 ----
>   tcg/loongarch64/tcg-target-has.h |  4 ----
>   tcg/mips/tcg-target-has.h        |  4 ----
>   tcg/ppc/tcg-target-has.h         |  4 ----
>   tcg/riscv/tcg-target-has.h       |  4 ----
>   tcg/s390x/tcg-target-has.h       |  4 ----
>   tcg/sparc64/tcg-target-has.h     |  4 ----
>   tcg/tcg-has.h                    | 12 ------------
>   tcg/tci/tcg-target-has.h         |  4 ----
>   tcg/optimize.c                   |  8 ++++----
>   tcg/tcg.c                        | 12 ++++--------
>   tcg/tci.c                        |  8 --------
>   14 files changed, 8 insertions(+), 70 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


