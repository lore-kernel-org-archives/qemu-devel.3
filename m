Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A871C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNF8J-00082A-VD; Fri, 28 Jun 2024 13:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNF8G-00081i-Qs
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:11:33 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNF8F-0006nY-6f
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:11:32 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f9fb3ca81bso5592515ad.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719594689; x=1720199489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UEnv1Xe7Ey4m/cyKdLC8yf5wfk0oVg6dQ6fUguTxPjs=;
 b=BMiwChykhm4f5tv3AAG+jpMkiT3JUdzoGlpuYIWgIWxGrxWi+kXuNW3Ulh/Aw6w+CO
 PTsOqC9/V1J6U/FYAAPK1YcNBxsQfOjydiUEr66ecO4nMNPe/F+qhNJx1drh1KnZwJIi
 K2O+hMD8VsGQUeeKULhpHdgrcg7qbVbjHf+Ic31P4T23l9oyvc3kWGDDoJxP8e7+U2X3
 HpR2j8iyYKIrg87MpOKnpPmrMwphstCKp7GcV7ZlFv2MCZN8qwv8KgekomzVKYUNuTZJ
 a7olqvmswZDCXPGMo+UBrIXA/yo7L3DU8NQUSq2zCZdgW+L0A0LAQaRLw66D52bjAg1c
 aQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719594689; x=1720199489;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UEnv1Xe7Ey4m/cyKdLC8yf5wfk0oVg6dQ6fUguTxPjs=;
 b=av/IZri1KCSMUk+iqfkyFMQbeF/FM7/5OgrEcoW4/duLNqU0xJxvL3nBasKV2TQu8/
 6xKzYMVyq6a7MgwqjmYxzJkNHOUK0W+ULkJHCjcnTQHVFrCoH6a2cETnUjbymtLGgMI3
 HBiCmQyIz+jFz9pIjnEHBw0aFm9qnjyhN3LGfTUyjF2l71dGWrGXsfwwqsNNS3Ki4mCl
 l9ydHq2f+Fv3/4k2GWp5aE5zBd7+YiAAlgjPeoLLs8v4mqPCTYyEs8Y9A7RnpS7+MoCj
 dnf0F1yEZhJJLQhE8enUupVvD2HsCrr15ywm3x4UasuZgv8RKnXlanLQYOd6dLv/WOkP
 B9Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVODCGdjevILNlrZAexpss6JO2W/RBBfGHAoE0Gc66aNURzke7XHUY5MYg7M/lFI93Xdb7n3y8qCb/77LNByLZ+QMy99yk=
X-Gm-Message-State: AOJu0YyGcGWoIaJhuIPyK9k7OWLSijqHq3NLOQmxztrN/cQX2Z/guGsK
 xYl3GEyzJmjRKFyZ2YMGtKZbvG6oV/THAufDbP2BdP7oGgfMA1lbEsxigcX+8fo=
X-Google-Smtp-Source: AGHT+IHr4FXYFeYOW7zhzGEBHJbw9iVu0CVpzcGsecNfIlSeiWYB0XtB/kzXXHc1glCYIY86V+WoHA==
X-Received: by 2002:a17:902:ce81:b0:1f9:c3b3:d8f0 with SMTP id
 d9443c01a7336-1fa2401c255mr178196505ad.39.1719594688985; 
 Fri, 28 Jun 2024 10:11:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1594eb0sm17681165ad.246.2024.06.28.10.11.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 10:11:28 -0700 (PDT)
Message-ID: <afa54739-ce19-4b3f-84f9-696c1c28ddbd@linaro.org>
Date: Fri, 28 Jun 2024 10:11:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] tests/tcg/arm: Fix fcvt result messages
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240627-tcg-v2-0-1690a813348e@daynix.com>
 <20240627-tcg-v2-1-1690a813348e@daynix.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240627-tcg-v2-1-1690a813348e@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 6/27/24 06:58, Akihiko Odaki wrote:
> The test cases for "converting double-precision to single-precision"
> emits float but the result variable was typed as uint32_t and corrupted
> the printed values. Propertly type it as float.
> 
> Signed-off-by: Akihiko Odaki<akihiko.odaki@daynix.com>
> Fixes: 8ec8a55e3fc9 ("tests/tcg/arm: add fcvt test cases for AArch32/64")
> ---
>   tests/tcg/arm/fcvt.c       |   2 +-
>   tests/tcg/aarch64/fcvt.ref | 604 ++++++++++++++++++++++-----------------------
>   2 files changed, 303 insertions(+), 303 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

