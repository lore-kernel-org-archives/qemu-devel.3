Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE2CC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWz9U-0001zd-RE; Wed, 02 Jul 2025 11:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz9O-0001vo-J3
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:13:31 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz9J-0004RQ-Jw
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:13:30 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72bc3987a05so4307a34.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751469204; x=1752074004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ae4SMpp1BxP3kFcPn4aANF+45WSSq72eywLS8Mz/lps=;
 b=I9pSGdwqtBbAQY+vdZuKdFywyGQGCf1xyPP0yBrKigyKEKMeWmIfHv6lE3P0qi7ACA
 LThlTUfhBWLbwiXy9IqOsMf5dTU3bLdCDMbkO5+I4vQA5pAPC0RaLbyF9n7y1ShFwXW9
 jReTzGQhTUcLHPLxIUiVCnNdwy5RVhW/xcuVof97okdA3PcOxqdku1UilgoPVk3d5y+P
 1gaQpRM7ctPRf2PZGpgK8RxrBdcndVPVi58RuW3XiN10flqRhyEfb8hwh3tg7hkA2mJK
 5xO4gKNj9y3Qb/ahGCfO6RVoS59F9M8hREK2CUWtuA91lhnC5OwWUHhR+Fk537TaVetu
 tGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751469204; x=1752074004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ae4SMpp1BxP3kFcPn4aANF+45WSSq72eywLS8Mz/lps=;
 b=wcNZBg15OgzzW0V1yCrjiMJ9sS5I2MFjAZiUH7R5ByEaz0Ns9ylElAoNvNZs551wQp
 J261UfJT698K9PUEHFQy1+DgX23mIIbgTZvReMy+FIWYPjEis79CGDTI4Wx2n5OWs6mI
 /VCYVba2+Y3CG4XNawBdkoc4WT0eegATYDh5lFsn93la6/fhKUkoAeAkS1h5FBvTmB0J
 qlnMNLeFVF30u8maPRyfpovgdwcfQNo2U8xqX8gZqItMpHb8TYMWxGDyiV2qQnVJcU4g
 kq8WE2TjS7IQAM2CO0n0tTKPROZ/aYH5LLMRyoZ8UBsdj63GBBaYXeJFKl1b2eq0pN19
 SdPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNVcXP9ZDEmPGX2JXESEEnSkbEXCelgHduiiqDJDrpMotPjyxHVl0cp05jfLt/+mXDjxuBomry2RqN@nongnu.org
X-Gm-Message-State: AOJu0YzQDQSVfIlgtI/FaOVgu2V+ocQuCEKmN5+9fHNQFAm6SS8E+FCr
 qPwdECw6gjgiwOvID2ao9rYnisZvbGTHVJiDp0Me0Om889ZFgaDeyLkpD4OwfPG0z34=
X-Gm-Gg: ASbGnctPgjMDKFu04iJ3gMKIhd7cNxoUyvrbMMtYM/1Lqkai3uxulCqgysKkXUQxA/i
 UxRvTtSdDApTWqr9SvKuRxW80LBFddhC7/5XW5VhiAxvuIMVxgiNEYUnxWbtoFVMP2HqEQOaGMm
 Lmtn64g8vWsm7iuKQPnw8JPPgB1Z8c92uvdlFJq9bRlgYvxMBTtC4uOYwT7eLexA4nGJfP7mkqX
 SqbyCA/htkCg4pYdSS75sQJDlPPXSHJjLgDV7qiGJCIetz9Cq+Wm6FejGYTzYdQerpan1+wNPOf
 ztZ+bx7LcY+lbatYLbIfYdBzF6WYczm03bryKHyGpD0WKt/PbyZ5EnFncQM+j3RyGzlKaXYCrfj
 40Gk5VlAvfkU=
X-Google-Smtp-Source: AGHT+IGkJvojATtl8HuSvi8US5dCM7D4TVXunEJldIWBEm6c4QBD5eN3UpqyV7P/CKm+7UAsQClXUw==
X-Received: by 2002:a05:6830:4597:b0:735:a98d:a4c9 with SMTP id
 46e09a7af769-73b4f05b871mr1429593a34.7.1751469203937; 
 Wed, 02 Jul 2025 08:13:23 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afafee647sm2527702a34.4.2025.07.02.08.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:13:23 -0700 (PDT)
Message-ID: <f26ee796-25d3-47d6-9da1-06baa88dd247@linaro.org>
Date: Wed, 2 Jul 2025 09:13:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 43/68] accel/dummy: Extract 'dummy-cpus.h' header from
 'system/cpus.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-44-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-44-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

On 7/1/25 08:39, Philippe Mathieu-Daudé wrote:
> 'dummy' helpers are specific to accelerator implementations,
> no need to expose them via "system/cpus.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/dummy-cpus.h    | 14 ++++++++++++++
>   include/system/cpus.h |  5 -----
>   accel/dummy-cpus.c    |  1 +
>   accel/qtest/qtest.c   |  1 +
>   4 files changed, 16 insertions(+), 5 deletions(-)
>   create mode 100644 accel/dummy-cpus.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

