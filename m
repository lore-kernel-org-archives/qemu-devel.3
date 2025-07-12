Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC99C83F10
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Jul 2025 10:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaXPc-0006cz-LO; Sat, 12 Jul 2025 06:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaXPX-0006O1-Vi
 for qemu-devel@nongnu.org; Sat, 12 Jul 2025 06:24:54 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaXPT-0008Jn-TR
 for qemu-devel@nongnu.org; Sat, 12 Jul 2025 06:24:50 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so2270669f8f.2
 for <qemu-devel@nongnu.org>; Sat, 12 Jul 2025 03:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752315885; x=1752920685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HSfZDC0vov3/SEuDpR5eeoQwoq2SNjKH4mFg1TnOJS8=;
 b=SbrJH8LJydbctBJ9UT9irN27la4LpCximkoFnDUxWuy6Fvr69G46kybJdPgsmJBhB4
 FXgHGLUMISHbtJYRrhckbz0qfzwTgyzweHd1Zz92HtfiqgrNnBp6d4uEs4ilDtrDKW3f
 xOnHueYuk0uVlOMi1RLoPGvTfSWi1AplEVyMvmKaiRYlQZPClVLK2iDCPQYvDvEPRbF8
 JLm0gIFP2E78G9FDEVOyB8ZgM2OYaDWnziOggrCPz32QSX2cLn6l9gohzCpyJfLKsRqT
 dpY2x0It8nUkTN7RDcoHO1q7Q0ZOt0XMhvAPNJEKlRg5dSn/EPk9BLk+U+wk2etDoP4l
 5E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752315885; x=1752920685;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HSfZDC0vov3/SEuDpR5eeoQwoq2SNjKH4mFg1TnOJS8=;
 b=Du5xQdsZAhmn9za2oWvMxcRz2+ON5ULhyoMOwrtzLQ2F5gf5gFa8x49HhXtXpGD16O
 y4Jw/s7OO2UhMexB6nbjIy6v9Sn1Hx7ZW+4jdhvTOIvphl+s6HjBg/wFo7rJ2ABjHN8u
 J6vDhkO9rODLS0bEW/rDXE08ZrYvZB9aTjQC5An5Fz6mgLVUQPVVLU1Qlec9ep+PrKts
 CBaMNo+ilg/bVvj2tqQH5Q+lCxycyPNw75W/kGbGEe6mHYJc0uVeydpy64iaVUuGPahe
 ygS5rBJ7QXdddgTJ9/mwDICU+L14iSqseRnBJ/H9wJhxv7nvPG277+t4ebsUw1HUYgr8
 aJKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7FuDsBvSC55/fACR00XoEt3pdJhWv9AgzKloGfEflOqIdtCalD4BQh7FpFi68l5lRI+J/VOThK224@nongnu.org
X-Gm-Message-State: AOJu0YynPBjXEHFBWrop7swtxZ6ywZ1e90vvJHTfKdhH6fENDudMl+5v
 RUroULqGkoKRiVtzLF0u6YXyCSrl1ExpNZjgA0a9WbtVqF+JaU7Oz5IRSuLCQrBJ0iNQ2sUIFoT
 NzCdK
X-Gm-Gg: ASbGncsfKIee+KYdtlJmEZY7rnljr2uXwQvrR9Hr6mHPAYNtqWeEl6URLUyZHqnyDvX
 IijdRxR0QjMQVRCuEobvWPLL7NLSBN3X/yGIr9FF0XDx8+22ZTFSM2WIHlYuC4yw0mB6AwNyOZ+
 rBdSs5mbM69IFwKls1PXpO+G9MEL5td/K9Yy4AhxaDPwRikG3n/TQ+m9FpmTgi89Re6Sw+B69gW
 Y8RIdBXM0/VZ6VhF5qZS5afDhf4gP5YvcSHr/dIkYpbULquSLPq2adgDER6inlslLgvwexW1sAl
 r+FZZq6rbn0T8mIQlhX2GRyFz9m731s3Dx4lPH1NXfjWvsSoGGJrubCpQElWIw2DFAYU20faKwk
 abJ5WmOcLoBazEgiYDUBvF3+bVbmXF/gnGrfnOlgQuwj/zSFjoJXZOtqQjpHMtclbVd6tmtNURP
 jOui8=
X-Google-Smtp-Source: AGHT+IGk0JRq8y/ZKQ/apUbVqs1JfegRdAEi633Y+6DiiyFuys2abuyvlMm0TvXtog7V/CHeBqfxNg==
X-Received: by 2002:a05:6000:2c04:b0:3a3:4baa:3f3d with SMTP id
 ffacd0b85a97d-3b5f2db14dfmr5198818f8f.6.1752315885383; 
 Sat, 12 Jul 2025 03:24:45 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd437fb0sm73613895e9.5.2025.07.12.03.24.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Jul 2025 03:24:43 -0700 (PDT)
Message-ID: <531271d6-f243-496e-b36b-431eded7ea79@linaro.org>
Date: Sat, 12 Jul 2025 12:24:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] target/arm: Add prot_check parameter to
 pmsav8_mpu_lookup
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250711224915.62369-1-richard.henderson@linaro.org>
 <20250711224915.62369-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250711224915.62369-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 12/7/25 00:49, Richard Henderson wrote:
> Separate the access_type from the protection check.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h    |  5 +++--
>   target/arm/ptw.c          | 11 ++++++-----
>   target/arm/tcg/m_helper.c |  4 ++--
>   3 files changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


