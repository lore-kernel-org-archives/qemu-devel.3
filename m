Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C85E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 19:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNGk2-0005sz-GS; Mon, 16 Dec 2024 14:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNGjz-0005sT-UN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:26:53 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNGjy-0004rY-AE
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:26:51 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-728eedfca37so4645970b3a.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 11:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734377209; x=1734982009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qTRDbo5NpLlD5vf8powKzsACaBP/3Ac3gGuvhpr+4Us=;
 b=qC6O8VcCeJR+jms+4n16as75nyxhZ80085p5n68lPOT3fbIO4kNh2lRd3ZK+m/h9se
 a0CgqssvZITU+/Nltm3HyKd8nm33/kGa6x5tf7FKWlTEOMJj2Y7byqPZo2VHD6IBgQCW
 9nX6wLV79PinqgGpDScwi9qIC90w630pLkcNu90YabhRsH8K8IiUfp1eHaEfBHELfaaq
 UePbkiHE2zTjaXyNOvlPBaYm7vZfJHSQwjwSlUG76FmjaMFrCWJYMN6tFf98pNdamkxA
 mwEyvxIdREAp1vDXCXBrask1J/n++9vfpafYF5HuP4y8IlX+iF9dtNvwaLTEHixuhWM3
 77GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734377209; x=1734982009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qTRDbo5NpLlD5vf8powKzsACaBP/3Ac3gGuvhpr+4Us=;
 b=ksock7xYrJDMhUlE6vuCovrPD8oNFL4PY9COW1sFbzLYu2/664byTN5EHhS9CtaXYF
 aV1eDJSqlb7LtPH3/ddtAtH7nB3xQXTPi2bpBLFk4cgvo/uPBaUf+ZVLwXbsEU/HBjR5
 Z7UuiMZ9k45Zw8gQExvIRKWyKMyI6/eh1Q3SswzW5CAPPxFpFizW/XE+eiERfWFSlT5h
 qukIQ5xa7g355+/qkHHsl30L9U1ZP64zIWC/bL7mWeHuHk2Uu6zAG2V3T+LZvoGOeH8Z
 HY/4Z/4AYZJRLJ6pRe8FMQBhbSLzhqECLtakxSfBOOg86ACox0bhuwID9zW/RAFGPrkm
 0QlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE8VMbsrQOJJIWrPA5o/YfF7bQC7zrG1itGPnLYB3U4VUQIDWY4/dKy1wzAFCZcGGrJP+QHq6Z+f/y@nongnu.org
X-Gm-Message-State: AOJu0YwTkhQyFvC4ax7LRRNPSpmrMFwBzp0z355wsWwOZTU24fCRObD3
 60ZOxBn4ufugN0x49zwAgS5jLI+dKelj6B6z0GJqSsjYiX0kCp2lwyUMEc3HzWQ=
X-Gm-Gg: ASbGncuwZT1XPOXsirZ0vCWSl8bYHmAp9jDMfs8NJWLvfY7iqvHzZeWy93FNlfCGPzf
 Fq2wzxIa5wHgIa8ibzEEK25FulRrI0PvKocAy+SZ7LqzZeAw+Mx3Ee0k1xMKWnxP10Y2n4rUGPQ
 H/73opDq6iNqtJpxglrOiNjy9i2pugsmTJ00oXf2jNpWZWWk1mKAQIwRANxsS1t4gHux0H5n7WE
 J9OlNREOv0a9aC26Keq+QQYPlO0UBM1p3GTzUtES4WO+2hv3l+6lEEZFWxbO5ik4jUBmoQDjMA9
 I2tidqqP2x7vIinjZK7jv959mFfy
X-Google-Smtp-Source: AGHT+IEyPazkjfNyeI2imd6J9UaE+ql/1VPFYx9D6LjH3C0nisZ/veb3eVFM03aNvbbjTCpqe3/DdA==
X-Received: by 2002:a05:6a21:1796:b0:1e0:e000:ca60 with SMTP id
 adf61e73a8af0-1e1dfdec9b9mr21193943637.28.1734377208849; 
 Mon, 16 Dec 2024 11:26:48 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ad5c07sm5303498b3a.60.2024.12.16.11.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 11:26:48 -0800 (PST)
Message-ID: <b0962854-65c3-47d0-8f0a-072fdf51e7b6@linaro.org>
Date: Mon, 16 Dec 2024 11:26:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Change default pointer authentication algorithm on
 aarch64 to impdef
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 alex.bennee@linaro.org, Fabiano Rosas <farosas@suse.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
 <7cd98960-0c0d-481f-96ea-08e0578d5cad@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <7cd98960-0c0d-481f-96ea-08e0578d5cad@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 12/16/24 11:10, Richard Henderson wrote:
> On 12/4/24 15:12, Pierrick Bouvier wrote:
>> qemu-system-aarch64 default pointer authentication (QARMA5) is expensive, we
>> spent up to 50% of the emulation time running it (when using TCG).
>>
>> Switching to pauth-impdef=on is often given as a solution to speed up execution.
>> Thus we talked about making it the new default.
>>
>> The first patch introduce a new property (pauth-qarma5) to allow to select
>> current default algorithm.
>> The second one change the default.
>>
>> Pierrick Bouvier (2):
>>     target/arm: add new property to select pauth-qarma5
>>     target/arm: change default pauth algorithm to impdef
>>
>>    docs/system/arm/cpu-features.rst |  7 +++++--
>>    docs/system/introduction.rst     |  2 +-
>>    target/arm/cpu.h                 |  1 +
>>    target/arm/arm-qmp-cmds.c        |  2 +-
>>    target/arm/cpu64.c               | 30 +++++++++++++++++++-----------
>>    tests/qtest/arm-cpu-features.c   | 15 +++++++++++----
>>    6 files changed, 38 insertions(+), 19 deletions(-)
>>
> 
> I understand the motivation, but as-is this will break migration.
> 
> I think this will need to be versioned somehow, but the only thing that really gets
> versioned are the boards, and I'm not sure how to link that to the instantiated cpu.
>

 From what I understood, and I may be wrong, the use case to migrate 
(tcg) vm with cpu max between QEMU versions is *not* supported, as we 
can't guarantee which features are present or not.

And I'm not sure we want to introduce the notion of "versioned" cpu just 
for this. Maybe we could simply restrict migration between major QEMU 
versions in this scenario.

> 
> r~


