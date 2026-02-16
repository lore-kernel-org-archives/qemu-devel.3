Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71979E63F15
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 17:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs2Ed-00029g-Tv; Mon, 16 Feb 2026 12:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs2Eb-00028l-VY
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 12:18:10 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs2EW-0007Dj-Ab
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 12:18:09 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43590777e22so2071532f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 09:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771262280; x=1771867080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/XSfkd4pm0tGCK8igsw8VhUbObd1DQSw2FgsNG/TphM=;
 b=x5dVnvW+YnkjzWn3A0yFLNGJA3sYd4Pa9KMNulNmK4Ngqqn9gH7rlHBV7zujm980H6
 9y+pXkM8vRXLUqAdcgWElu2RftYb1pL4aj5lrLs3CxnmLfeDxX7ZICVj8H9RCwg/cOFN
 3zAD2AYIfqzwJLYaBpZOqpUpbaRdFV40iLA0pDMWXPEVb6jU16Ae3evBeIl4SSJJpsS/
 DkduG5WrmyGyDjpggLjUe+Ve+/BsRm0p7wfzxexWRuTYyYo7HKhecd0LnxkVXFlK5flu
 zr/1yEGi+ZASYHK6I1WdFpC1GCUaCaPS6D++32/NIDjigS0jb4XJtkJ8Xm1Gsydm+yl9
 Ivng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771262280; x=1771867080;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/XSfkd4pm0tGCK8igsw8VhUbObd1DQSw2FgsNG/TphM=;
 b=pCFGV2JkVhHnlKj3b2x3u45VqJFQVX5HN263qi1p6XqFjltCskyfWbg5TczQLRjf+k
 2rWf9G+NIJ/B6iwgiJMYQGtMcj0GCLKiP0QgabZXxcjud/EgY44HqqOSAPCUgEMtLRmL
 10PTvjdWQxoqAV9Mp/PgU4AchSt79/1FP6TaTEPi67MmZLWGdcY0sr5V3EwKoj6TzVoA
 2JlxdLJG+3MtKpq8AyEp2THyZcHmX67WBIrXt/deypAxSAxvtQLuW+EOR7pcagTJVeFN
 UZAaVeh/Ua2tRaIQgWGlZs9XftqJf7rMk8I3Gr9wZjKbNiuzh9Wilvlb5ndvLT59DkZG
 hqQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcWY/Qr37bGfwpa6OXoBAOxbtyKhrZZbEtHNkyyxxFIZb3/WXG9toybzYocfBmF4SYByY6JDcAbsYE@nongnu.org
X-Gm-Message-State: AOJu0YwfB8eaLE9N69mAkjQps34c/iAXmZBfN2KO6B2EWB9Lui9AtxWE
 j6roZeD40SQ5fgiYUIbp4UdamLNO8w08+xm7uSAmeS3A9sFSCe+Ad1YvFm3LPl1UHEw=
X-Gm-Gg: AZuq6aKMasaRom4KPoNdoX7MfvYZjQakES5/kVBW5oXSKwnXgKGpjT31D0B0LgzVAzH
 H1+kqCs4pmu35DShjdEezj+SEC6+WeSiPTUUWy6BJUZ+EZMZAwGFzdyiS9bgbhjxzNzJqxB+KPK
 2pYVzmd5yhBrqeUvskc0Wbv+d1rI6Ix7OqTblV7/ZuUlRSvm/keCbaeoZr+qyvgLot7vDRARQX/
 XhHuVAZDrUWlMPhtvdq3z49nzZTeP2AtpltG/FaIaFJNRHt/3DjrR9SKQzG6Mjom2Sk8Ixh3Usj
 390aag+s7LhZj5okUOi6R9/yYEr3RXxgpXjyHR/9dKskV8SoOVEWBoOd6/pHgypIOM5S40JpU2o
 uH5FScaC8n0jhd5nUCSl5MxCbGcX0xWeWHKufoWDBFvq8Siz486O2puL9W1we8q3ZiGod3p7eAR
 p9JweaWgRDf0GhavXLeoks4XrAzqCTMCY5BZ3aRzWER/Bd+MYOs5LIqO3zG2VUC5m5QA==
X-Received: by 2002:a05:6000:402b:b0:437:6629:9b82 with SMTP id
 ffacd0b85a97d-4379db9892emr15796428f8f.52.1771262280090; 
 Mon, 16 Feb 2026 09:18:00 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abc9b2sm26274886f8f.21.2026.02.16.09.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 09:17:59 -0800 (PST)
Message-ID: <04284ddd-d606-4248-933b-8352b4ee3c52@linaro.org>
Date: Mon, 16 Feb 2026 18:17:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] page-vary: Build set_preferred_target_page_bits() as
 common code
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260213182713.44924-1-philmd@linaro.org>
 <600adf7c-2c6a-43df-9214-144ed03f8f11@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <600adf7c-2c6a-43df-9214-144ed03f8f11@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/2/26 08:27, Richard Henderson wrote:
> On 2/14/26 04:27, Philippe Mathieu-Daudé wrote:
>> Allow common code check TARGET_PAGE_BITS_VARY at runtime
>> via the target_page_bits_vary() helper, then use that
>> in set_preferred_target_page_bits() in order to build this
>> method once as common code.
>>
>> Philippe Mathieu-Daudé (5):
>>    qemu/target_info: Add target_page_bits_vary() helper
>>    page-vary: Expose TARGET_PAGE_BITS_MIN definition
>>    page-vary: Use target_page_bits_vary in set_preferred_target_page_bits
>>    page-vary: Build set_preferred_target_page_bits() as common code
>>    page-vary: Inline set_preferred_target_page_bits_common()
>>
>>   include/exec/page-vary.h          | 15 ++++++++++++++-
>>   include/qemu/target-info-impl.h   |  2 ++
>>   include/qemu/target-info.h        |  7 +++++++
>>   configs/targets/aarch64-softmmu.c |  1 +
>>   configs/targets/arm-softmmu.c     |  1 +
>>   page-vary-common.c                | 29 ++++++++++++++++++-----------
>>   page-vary-target.c                | 25 -------------------------
>>   target-info-stub.c                |  5 +++++
>>   target-info.c                     |  5 +++++
>>   9 files changed, 53 insertions(+), 37 deletions(-)
>>
> 
> This patch set moves code from page-vary-target.c to page-vary-common.c, 
> based on the new target_info hook.  But since TARGET_PAGE_BITS_VARY is 
> still used, I don't see the point.

The set_preferred_target_page_bits() symbol is removed from the
per-target clash symbol list. One step at a time?

I followed removing TARGET_PAGE_BITS_LEGACY, removing the use of
TARGET_PAGE_BITS_VARY in common code, but I still haven't fully
understood Peter's comments on my previous question, and am still
processing it before posting the rest:
https://lore.kernel.org/qemu-devel/CAFEAcA9D3Wx2w7i2X93uX1H3GtrqdVKtGidG309XLb=AdGVOOA@mail.gmail.com/


