Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE90C5B543
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 13:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNte9-0007YT-Rd; Sat, 07 Jun 2025 09:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uNte7-0007YA-EB
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 09:31:39 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uNte5-0003Vr-Td
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 09:31:39 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a522224582so1821726f8f.3
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 06:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749303096; x=1749907896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vxtL87VtW2DLMTiqjgdhgQWLW2xyK9nlnwQnTjoRGCU=;
 b=Guke7zdlJUzMV7vld/dkkE1xjotgaIskt7vWDoTNDrmL3SiDSDkypuMJLRdD1ac23E
 kdESp4ffqxd4GEr/Ji/UpIWFUmiSFLCMyEwL/ykAZ1a4lq0o/J4roT9xK1xYz6xAk6En
 aBcTe88b/nENZGYjupey9HuxiPPLNZLFbMT8fvytUmkNhoMoJSL6KJoVh5fjw4/CN8Il
 DOwgjG+pevkZAruTGTmwZBIaMJsReYxGn/nEl9/M79jKXABOxi3e3jNiCBPCwniyPzqq
 vy+rTZGupD2vqanhcOSVj+xLRVYsOqk/6OJFGeD6IcOP5sQmfkm5WYwkbc26noo+kjnC
 Cy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749303096; x=1749907896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vxtL87VtW2DLMTiqjgdhgQWLW2xyK9nlnwQnTjoRGCU=;
 b=YL9uJ/5OCy3ALCk95O6eqPC/FzekgqVxFNIrFlBeL0tbE9l9UjlJbDhQ+SPJPPr54f
 z6SD7Sq/Bi7yAoQOBf2vSRLUgGUAHb1SfqW5paMaXV29GRSGpqdDS93kByuDsyLDCJYX
 X2G8Jrvu6qhStbFN7BIHs4+l5Sr+4AtS9/i2SW3u9N8oYD5d9OtNv4WzZjNF5ru2MwMt
 h48XYN6WQBctpa5B+KIi5MNDikHrAQUsDi6RaJG62D0KEg/8ENxxsoHGtecuF5sJA+fH
 bSqlZzrxRS9aQ/frbYE4tB3cIuZYl2Lrr+Q4S6kRxvYmHdXUPKiEIjDLmKaKp6u9T7J7
 qR9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNnWj3/giOWhLNQ0P3kJ/Xpn27bi04pGFe//cyi/pTohMGR12Pord3mP3V1xSah/1ICqGuDvqsegfh@nongnu.org
X-Gm-Message-State: AOJu0YyUsPPGbhXNkbqb4/30c61xWxMF/e49qrcGi0nrBh7B0Ro9MRjh
 LQfUWYp5WxKU2qT3QEJ0bUh8yZmdsZJpqfmNUDa6e5k4wXS1nLmXVOlmrqZFx6nM4Rk=
X-Gm-Gg: ASbGncstMeZUPo0YJRI7SLE7tbwS5eHzpdcKxUPrYbkMgwGQXsf8RR07Ht+7zgdLwe2
 UAMChYpp1M2JD4+BzxP4WOFQQoYpNaBL3Qvoj3gQGmfCwyltF9mbT8F0IYNbgQA/mZ4o4f7Eq4X
 TKlftXZMvjdvv9SL2xHqgmw6FZAJsNLQoLUwsiqa/2cF7foEhu7kdvS3Bpemsq1KvjYsc7b4mkK
 /X4PbZoFTMqtaTt0v55FgtUJBM87plGMCu6xnGnSQYGxJbxvJ1oF8c+SekV5DYNkL7d6D2YVCyN
 XgTt4BGzENOr8PdGmOYUWTyHBIV2kQQVzbaWdWHwQ2a26iWSD/+7YoG9c8QpcH+4fO1yE2NGldM
 K4LjdXftHDOqhWc4V0cVUvk4YaJjN1jJv2inBgSmFmLIlp6F1rw==
X-Google-Smtp-Source: AGHT+IGzKBcgyBwNKAR3mUUK4CNcJKAOhhiSKxCYFoxmqh47l5cKzqG9nNVCtuJ5czkQ2gfe2kllXg==
X-Received: by 2002:a05:6000:1a8f:b0:3a4:cfbf:51a0 with SMTP id
 ffacd0b85a97d-3a53189bc76mr6773956f8f.21.1749303096502; 
 Sat, 07 Jun 2025 06:31:36 -0700 (PDT)
Received: from [10.10.12.33] (cust-west-lon-46-193-226-34.cust.wifirst.net.
 [46.193.226.34]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d15asm4744661f8f.66.2025.06.07.06.31.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Jun 2025 06:31:36 -0700 (PDT)
Message-ID: <314a3a1c-ee78-45f4-9e24-17196f5a3185@linaro.org>
Date: Sat, 7 Jun 2025 14:31:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/19] accel: Propagate AccelState to
 AccelClass::init_machine()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250606164418.98655-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

On 6/6/25 17:44, Philippe Mathieu-Daudé wrote:
> In order to avoid init_machine() to call current_accel(),
> pass AccelState along.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/accel.h        | 2 +-
>   accel/accel-system.c        | 2 +-
>   accel/hvf/hvf-accel-ops.c   | 2 +-
>   accel/kvm/kvm-all.c         | 2 +-
>   accel/qtest/qtest.c         | 2 +-
>   accel/tcg/tcg-all.c         | 2 +-
>   bsd-user/main.c             | 2 +-
>   linux-user/main.c           | 2 +-
>   target/i386/nvmm/nvmm-all.c | 2 +-
>   target/i386/whpx/whpx-all.c | 2 +-
>   10 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

