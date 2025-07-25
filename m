Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14887C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 01:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf71D-0007Id-TO; Thu, 24 Jul 2025 21:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uf716-0007GG-To
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:14:34 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uf714-0004AS-SA
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:14:32 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-748e378ba4fso2106026b3a.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 18:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753406069; x=1754010869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LCuAMWKJAWTYGfdzp8KbLWq13FriRFVk9n3WfTj7UWg=;
 b=kQVC8MlIKZUvXdqDTbfndnbQrX3RjHg5pfpgfXPxYrJv80YbAs8C9w1ZAyRWO8y8k2
 5HVrQQ+zva7O2amlnohVb98v7BxrH99QBoQ3BUIcnPoVhvU4YmbmXVL98okKjaH3NSbk
 6cYoMqRQ/Qhdl5VzEllpX7zapZC0/zK3ED1cn8huHKOceVLcK1d/x9dIyxakRpi+yrFA
 ECwpyHnctM+SE6XCebjYU8tNAohjj8KigO8y0OSnhBmciW8YoouAmxO0c4CsSIqbpEH2
 qNQcqrtXNt9lSHibEvrvkZeaMKhFD7YpklX4/QQa4Lj0PGGnxETtq3gUCVu46sQQNW/t
 LdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753406069; x=1754010869;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LCuAMWKJAWTYGfdzp8KbLWq13FriRFVk9n3WfTj7UWg=;
 b=O+j9hXPb6Ahu3doiYMOuXMfCkOSKLqqsg80rJliUch5MJFQ8rwBVVgtF8ihUtPe833
 vn2mTzFa6d1rjWc1LMiOO6BC2+QcTgzrf24G5+Qg7igbJN1DuqmV2YQ0q8OHu+HAygTn
 C0QuOiGtOLup6LN1OIQ8ZyJRTzJQ0DVXuyr+3eKC24Pw/g+9TJ1jLbWJzetx1jKJCrZS
 hmg/lISBOlsn5daI70gZ7IuUYrUBLdafUV/6lLspmZljbBh489feahmFxMsfhwtYak4D
 TJVniunBNoBfsyv5ySHJF6sGYy2erBNtU41tQnRBXPvdlFZaWxToaJ8F76pJv4gPR8Ig
 YCkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVStEs3oIxvh2LEs74zgBdxla8AAK4zP++JmB2P11iVTgIErn6PGvX7BpqR38JH9T2wSELKYRbrA+ME@nongnu.org
X-Gm-Message-State: AOJu0YyLR//DjJez/EeoPG4ZGFSCfavHkjNEGicGnJ5QnTe8yoTCqIaC
 QVcrxA1aYBHI46aqHis6TVzDaORFELPF0qVqJUB88mAOi8zlqEjXwEpW7t2wmvlhXSk=
X-Gm-Gg: ASbGncv5fblzAvp+OlebYM6YGEi0OvzlzxBa6a9wVh356halHVrm2Luj7EoxXhJpQai
 YXRMM0yTxJCj51utgrtzjKkz+0DiCDrO8O14XnSfLJQOQqysioGJJio4/U6za1d9D4g5YeTEwWA
 kIpLscGdqkHkVXinmOHrcjkvt6eeh8kyxTXv2y32WKS30H3jsIW/ioLN6+nuK1+qJ0IiFVfUPdI
 x3TodK1Ksgv9u7ZkgjnGPKQUbRqKfQyw2mtRHeya0yVTTBM3u+2YlnTBkLetDXw49TjAUI3iY8N
 mtrxhfQyitGsNlR6sYFF3cHbvfuLaGq9vdZJEdMwXKagMeOaNhQicghACp80fHK6NP6HV2rT7ar
 FHEyR6IByCOmiG6SWc40vcxn1OQ/GGTncNWjCwWQUpCXtmk3oD8AU+HPnLR/iYpPvIYTj7LX0QN
 Y3Mw==
X-Google-Smtp-Source: AGHT+IHVb0fYtXZpqBNQTDihJ/FN+fhntoP5XYOImyJ+zuRVA7+wNCOPEFSD1voIe28zdd/bsgOT5w==
X-Received: by 2002:a05:6a20:cd91:b0:21f:5598:4c2c with SMTP id
 adf61e73a8af0-23d49032907mr15625978637.13.1753406069013; 
 Thu, 24 Jul 2025 18:14:29 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f6c09a1absm2253655a12.23.2025.07.24.18.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 18:14:28 -0700 (PDT)
Message-ID: <23e19896-f28b-4a90-b9c7-95ba9489e4ca@linaro.org>
Date: Thu, 24 Jul 2025 15:14:25 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 10.1 03/13] docs/user: clean up headings
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-4-alex.bennee@linaro.org>
 <0d977125-473e-49f1-be25-c8221a3601bb@linaro.org>
Content-Language: en-US
In-Reply-To: <0d977125-473e-49f1-be25-c8221a3601bb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 7/24/25 15:13, Richard Henderson wrote:
> On 7/24/25 00:59, Alex Bennée wrote:
>> +Threading
>> +~~~~~~~~~
>> +
>> +On Linux, QEMU can emulate the ``clone`` syscall and create a real
>> +host thread (with a separate virtual CPU) for each emulated thread.
> 
> 
> We might say something here about limited emulation of clone.
> See CLONE_INVALID_THREAD_FLAGS.
> 
>> +Note that not all targets currently emulate atomic operations
>> +correctly. x86 and Arm use a global lock in order to preserve their
>> +semantics.
> 
> Wow, that's out of date.

I should have waited until patch 5.  :-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

