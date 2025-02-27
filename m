Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C3CC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaII-0000d6-FG; Thu, 27 Feb 2025 04:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnaIG-0000cc-Tu
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:35:00 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnaIF-0000Ki-4L
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:35:00 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4398ec2abc2so6471035e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 01:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740648897; x=1741253697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iy1SP1woD7d8BxVkBRmawvINptgUMZzsWTjArjJv2JM=;
 b=JX4YtZIJfNNlw1h9f4Xs98yTkWISplyRqVD6SrKSBj0eaLGPTgNzuXg6VnDcB+Hsjj
 ND7G9Gnaa6v1dHrsOQsfWeoCLVSrF1BIgObrALaN1cT9nVqwRyf7O7+KexCrcOycIr82
 EtK5Ith/RTa3qxTk0QIMnJRj61tkQlfR2PgqGpjKECAAL8Buv669M19P4p44zh8oWKYd
 jdspEnVcQ0KiuFtUY8jD12rHd0/d5AMX/qZsHgaRlE5v+8GPnAwskBdrXAjXcdJd5muK
 wwSeQSY9N2yh66Yv28czBv82eqTjeQ2wQhN39rHQXpfAQiFYAWYykCe58kK+G3p6BkDq
 zZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740648897; x=1741253697;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iy1SP1woD7d8BxVkBRmawvINptgUMZzsWTjArjJv2JM=;
 b=GeH2CXYCGrrUzaHdp2HbaEqCmkShzUvmsu6JRKcLG1EcLZlONXKKArsJiasRzFQWM3
 enqKew3xZ6pMElsyrORbeVJ2M0LM2pUtxkWYzGnS4rFa0+PkefO4WM3XmkIxYdCXUbWC
 H5+qTvyOeyprVUsH1JmypGZV8e7fXmHq3QQXjniOY9aL027/WnG/R0Yeo2GgqKJ2PUww
 COkSMQYqufNfufJavibXZ02JKr3zLvolTbrBJOxBbkC2/sjGGec1P7tutsMMz41R+xwx
 vH0B3baMky85MYiQng9dHg6tMQnQMQD+Vp2kBHMy3Nyni331RGVKm6qXoqL4WrOyKJaz
 7C4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbShuBOl1cg5COc80fd9mViT0RFH9tHg2JD/poQ84CQ0xUJiLfqN0ktZsa8eyWdKDLE8WpCgKraYY2@nongnu.org
X-Gm-Message-State: AOJu0Yz6Vie5s+skgBXxs+KlKIcKWzRFcusRi8iCTUDV2GWWyPgsKyci
 WSqwMgwR3LzTTMTpxa7uj9AB0O6eRlegJ7HJrooqsy/XMAKbiBrnW4K9pH22vhYS8wwCTB4tZ3y
 ltFk=
X-Gm-Gg: ASbGncu1OAB5LeE1VtttU3rYQgJRlEVvjlwCtyeKWVRtvU7e576wYZSzG/ebRBlUanS
 DFdUVvB3E0VTnHBoJTLDb4LTKHt7Vqdc23cp0EotjrciJRJFPmbiFU3lwMsxwux3u7lE7pRiXAt
 XARkYQFArNFu9At93oMI5fbL+VjWvSxa3t0ebMsJWGy+VK44nBS5cu1vZxwdrVqZAynuzmaJYmA
 R7rYjzQlTcfJo1hAyvOctKjjOaUElAbMiNkr6UiMeFAsVLv/4ojPG5/SzTSxnzsQCvRloLdnUDL
 f81nVmSRS8irdkM6d67FNWhDynTnm0TiFlzV2/zd/rOnCCjGUXDEkk5X3k1wpbixbBHTPQ==
X-Google-Smtp-Source: AGHT+IHo4tMOfUQ3siVdPDzlsKMXoMqEG8YIH4nfsKdqlDowG5XyzBVNcFKXJNnF7M990lRVtGv6Rw==
X-Received: by 2002:a05:600c:1c1e:b0:439:33dd:48ea with SMTP id
 5b1f17b1804b1-43ab8fd1e5cmr53749585e9.2.1740648897397; 
 Thu, 27 Feb 2025 01:34:57 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba53943asm48178235e9.19.2025.02.27.01.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 01:34:56 -0800 (PST)
Message-ID: <24d49743-9143-428d-80cd-f0e798da8cb3@linaro.org>
Date: Thu, 27 Feb 2025 10:34:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 032/162] tcg: Convert not to TCGOutOpUnary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-33-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-has.h     |  2 --
>   tcg/arm/tcg-target-has.h         |  1 -
>   tcg/i386/tcg-target-has.h        |  2 --
>   tcg/loongarch64/tcg-target-has.h |  2 --
>   tcg/mips/tcg-target-has.h        |  2 --
>   tcg/ppc/tcg-target-has.h         |  2 --
>   tcg/riscv/tcg-target-has.h       |  2 --
>   tcg/s390x/tcg-target-has.h       |  2 --
>   tcg/sparc64/tcg-target-has.h     |  2 --
>   tcg/tcg-has.h                    |  1 -
>   tcg/tci/tcg-target-has.h         |  2 --
>   tcg/optimize.c                   |  4 ++--
>   tcg/tcg-op.c                     | 10 ++++++----
>   tcg/tcg.c                        |  8 ++++----
>   tcg/tci.c                        |  2 --
>   tcg/aarch64/tcg-target.c.inc     | 17 ++++++++++-------
>   tcg/arm/tcg-target.c.inc         | 15 ++++++++++-----
>   tcg/i386/tcg-target.c.inc        | 17 +++++++++++------
>   tcg/loongarch64/tcg-target.c.inc | 17 ++++++++++-------
>   tcg/mips/tcg-target.c.inc        | 20 ++++++++++----------
>   tcg/ppc/tcg-target.c.inc         | 17 ++++++++++-------
>   tcg/riscv/tcg-target.c.inc       | 17 ++++++++++-------
>   tcg/s390x/tcg-target.c.inc       | 25 ++++++++++++++++---------
>   tcg/sparc64/tcg-target.c.inc     | 20 ++++++++++----------
>   tcg/tci/tcg-target.c.inc         | 13 ++++++++++---
>   25 files changed, 119 insertions(+), 103 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


