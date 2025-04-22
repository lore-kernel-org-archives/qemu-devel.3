Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2ECC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GJT-000873-GA; Tue, 22 Apr 2025 12:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GJJ-000869-3C
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:17:26 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GJG-0006fO-SS
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:17:24 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c1efc4577so2864391f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745338640; x=1745943440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V1/KhUs2Z3QBQjh1+/mZtPENhQyFw8sQXIWzKSZsuEY=;
 b=i0mAAlPOeOW1BXJjpeL/cMCY5oCkS86zf9ZE6qFxMiFPjn880rktBj+BUlVSUQNwXd
 zjr4CS6qFr7SThQQYD1K6uLPL9U/rxBGpLikr9hKWA8jXKHh3aSUhmaKeqCyW/VbWalW
 Q26d9dgmbqrRnHKkEUW7D6ETuBnEGSmKl6/s4AyZ2KW5n3wdv2MPpuV2BAKI43KXSCTv
 F+2NFy6nUMhSip2k90lbebih2czlL7CZzHryhqC+Mq+OCVbvn1AYHTefG4h/8Oj+FbA2
 l7Dzcd8wBZHwOLMUJ0YDgMRIPJSgIzSKa+b4i0DeQLWNqVVgQvDdiW+v/vgy/RrAA0WA
 4JFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745338640; x=1745943440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V1/KhUs2Z3QBQjh1+/mZtPENhQyFw8sQXIWzKSZsuEY=;
 b=HOAfgO540uEo/bfssSDX0CXNkMdiauPE25/SRx6uoh81E+Ot5eyTUxTZEYWuu0Zlp+
 nusQk49wFxagXRT6o07kpJR/1WZ2sl39L8wkvVHbYMKOVaO0h5tyUr77LWFdj4/srM+4
 W8wL/rkAzUp+WqE999G7dHLoOJW5mDtgbUYQs9eoswJcSvkixpBWyAyqo2q0LJhnp56N
 RVYr+5p672DbPVLPvDFCA1Xu467UN66JdClwrsdkmG92+oePqAOBZKZqEDUFKPJx7Epf
 zecLS98UJ4u29g79ewFAtVoH0mLZU3D0jndSUeQB6H20MvA1tEyFrBrqVEyYoE1MafxE
 cz4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgyIx4vLFC0E186+77LSqnlw6X5yxHAwedH1lRozmXyqYMsg/7csZ64dFY/EwZel1P2TAmbJRPeCrF@nongnu.org
X-Gm-Message-State: AOJu0Yz8mYi4Eu5QXkD2CTOJDSef17FcP0xdAD1qVi0Yb6uhu4amufqP
 Lh/76sCR5SiXmshwWYact+uGGZKniU+dYeNUWcu7vEDsmi9EEGa1WrWm0WrXNX4LycHBWJ42S2X
 /
X-Gm-Gg: ASbGnctqoCelp6yHP0NZk7w/xAJ1b64pNg+RH6udmZA4OBExOkpFXIV2jzy6L327+oM
 eU9cOaTUIN7rQCLsP79deoJ0WxR7zu4POjm1Pt9Z2RIOA2anmODH0WZmTK2dwnLlg/b8q/9n1ob
 604Mi+TPDzRcRwztFmHx+Y6yTWX4Dc+TjWGLd3A6a1z9BeHig2Apd12Y2s0AQSoQMLVSbYTz31F
 qYZ/mwWFORwWMXBG5Ih1lObmqP/IK41W0q5Aa9DmC60tJp+hqhmJR9S7nhEEXik0xZaBNRRUH+x
 xLEKAOyC940q7YZua8Ti3MGULEEmbYTCiM1tDA8X7XPrrNvJwKfRMOtQEJxsC+QGg7HLWfiZwSY
 aAxoX5h+9
X-Google-Smtp-Source: AGHT+IENX8XQF5gbskywBcSIvx1YTOCM64tu7uqm9MqXatEbQzzBtyMLnozVBZLSZ1gSaSSm2U5WDA==
X-Received: by 2002:a05:6000:4287:b0:39c:1257:feba with SMTP id
 ffacd0b85a97d-39efbb229cbmr11590674f8f.58.1745338639871; 
 Tue, 22 Apr 2025 09:17:19 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43bf20sm15488332f8f.48.2025.04.22.09.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:17:19 -0700 (PDT)
Message-ID: <351ba728-7c62-49b0-8de6-a8d7cdd013c0@linaro.org>
Date: Tue, 22 Apr 2025 18:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 125/163] target/hppa: Use tcg_gen_addcio_i64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-126-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-126-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 15/4/25 21:24, Richard Henderson wrote:
> Use this in do_add, do_sub, and do_ds, all of which need
> add with carry-in and carry-out.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


