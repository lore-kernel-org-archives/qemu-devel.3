Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8193AC282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpb4s-0007LE-9n; Tue, 04 Mar 2025 17:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpb4r-0007Kq-0I
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:49:29 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpb4p-0004WK-Er
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:49:28 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2fee05829edso6804059a91.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741128566; x=1741733366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sb2MTHQI0UuYHh8gnXs1zulzITA3CBflc3jchQJcVLk=;
 b=i8OHLh9VPbANWFHR3tp+xppr+cpWGNSntCzuoqyNPxz9oMddjN26gbOoL+Q4yFtbrh
 euRkZEctlpRbdtaZ2r6ibtxUlEcLY3ni2JaecJ1DRf50zTIzdJs8McXyV42uEkEaMyRD
 N+U3IRvap4UWY8Cir3ge7YGJBE/g/0PoogBuY63D8df7+IoFfI2SEWGZ3m1r0I2yYbNH
 L/AaiknBSQJ9IcfShnnGU4G6oxuxeCdunAY6DpfST1PJUjWckdICvIAJhGdMDAh1jptq
 1dpl174jRxtoui8fd2I/i9pBnoqhX6oC9ZaQoISfWnwHG3K/grDx8EPnvE8uq2MyMdr0
 NHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741128566; x=1741733366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sb2MTHQI0UuYHh8gnXs1zulzITA3CBflc3jchQJcVLk=;
 b=MrF1eVg70wnby106YY+tejvi+5EWHfDZWu+VwcXUqf9H5KvNlbR98eiqtt/gx4uvic
 ZZlwxJLWXoEj1a9jIF2a3gOSgyvc0VEvkRUpyNQ20FOnXRgACj15osPYKhpoQLx1PIPL
 oyt/tAQgUtFqzQq7gdHm9TiuK5ojxOUrLJAbYX9JqZKfpA9ogbN1bFMyi/kIQIILQEqQ
 zxbUSB6vcTKzbyyxbBI6pYftZHgL+Cciwa3yoMXd9fxLy80+PUT8FR9jYhYA6QtQdlp4
 yj5nDRSil/sqAM4MfhSSqkMz1p4M/FIFTlJIu2dWEN9ggJEjyVK51b0RwMw495gOyTyU
 Prog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoDEDQCV/uMH6bF/ZN4Ez/kbq73vX13cGmUdH2rD0PvIayqkmSGttCKYpOLRqV3sVfEZ86mBDpgNBE@nongnu.org
X-Gm-Message-State: AOJu0Ywyjv8b7SoiuQDG7QrtNwl//73A4xapAYk3szuA8hWCGZ5S9BA8
 DMO3sYNZ3v/dAmNXzNziVmSq3oFE74uNxdlmvtx1QoW22m6n2DTKJafOjed9XYmGCk0SanQnxyE
 4
X-Gm-Gg: ASbGncvd0UBC/dsLYa60GSkF6qM3jZ6zTyr3s4C95EfuMODQ4odbsB1kNMuEd6O7zAN
 k2Vpr4p1e4vs87efKkKD1CwrMqqsfzUAQ0x9pI1rVUXt2R07hayZNMaEK9PPFtOfiXah3sQWLlz
 nueR1rLjMbSXLAN/O+QGaZHGauoTiAX3lICh0PjFGJU0lRN4/5jM8+EK3xwnb+XvHqjskSSEXfY
 knbKUw6BtZVrljD7+vyDQEWtwY3tCP4Y6kEsAULX/bdt8Z3O3OcsxekN6WAJooTJ3KufswBjyes
 ZSsbWUPulR/Pt/+aOeZPbB+kNv+D4tGbe7PwevYP7J/Zp0l10OsgAVX0R+PHkbGyEmrqI3ddl1S
 KEamFJGhX
X-Google-Smtp-Source: AGHT+IH2uWjQ/IovKkjTzxmviHtaqyAqX9y9ok6Stpu/EtBXJ2EvJtoKft6AHrO07jhdz5s1yEx6fg==
X-Received: by 2002:a17:90a:d2c5:b0:2fe:ac91:465f with SMTP id
 98e67ed59e1d1-2ff497ccd53mr1547331a91.19.1741128566030; 
 Tue, 04 Mar 2025 14:49:26 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe999a5a1dsm12383243a91.33.2025.03.04.14.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 14:49:25 -0800 (PST)
Message-ID: <4b89117f-e7bf-48c8-a0fb-03b53c5286a0@linaro.org>
Date: Tue, 4 Mar 2025 14:49:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/32] tests/tcg: mark test-vma as a linux-only test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
 <20250304222439.2035603-14-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250304222439.2035603-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 3/4/25 14:24, Alex Bennée wrote:
> The main multiarch tests should compile for any POSIX system, however
> test-vma's usage of MAP_NORESERVE makes it a linux-only test. Simply
> moving the source file is enough for the build logic to skip on BSD's.
> 
> Message-Id: <20250226140343.3907080-12-alex.bennee@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/tcg/multiarch/{ => linux}/test-vma.c | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   rename tests/tcg/multiarch/{ => linux}/test-vma.c (100%)
> 
> diff --git a/tests/tcg/multiarch/test-vma.c b/tests/tcg/multiarch/linux/test-vma.c
> similarity index 100%
> rename from tests/tcg/multiarch/test-vma.c
> rename to tests/tcg/multiarch/linux/test-vma.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

