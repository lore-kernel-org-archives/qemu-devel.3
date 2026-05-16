Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC1DCD4F3C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 16:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOI9p-0005gZ-K2; Sat, 16 May 2026 12:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOI9d-0005fl-PU
 for qemu-devel@nongnu.org; Sat, 16 May 2026 12:46:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOI9a-0006BB-BV
 for qemu-devel@nongnu.org; Sat, 16 May 2026 12:46:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso5058375e9.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 09:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778949976; x=1779554776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iZ02RO3PSz1nyGtCJDOCkyKYE/1aqq1dLtrf7VPpXqM=;
 b=akmeynSm0Exgib8N5vxRgz3uIb8CZ6fvNjquIJzWMnzlsYnve3PL8ZVsOWP7Uk8M6g
 b1sDbNBpGs4CEkobyS6MdKymH5zt+k4pE+h4jCFwwAKNDb/mAtNJBwZ3fowJoUXebC7g
 mqgc485Hde9d8KO0ty6ikDxPM7szezTyPvtnsFNhDxSV3hOpViS0Ny8kr+MlvFZGsQB3
 ZNSZnFwn7k9MjpumBkO+FZUewoy/9TnqBULpDDQtTKajitNS2BHaAXaOox/EoFR0FwiO
 SxzNa+x00tCzhBrHnqpkaB7Mk6BBajBnvkyp2Mc7294pSiMoXtir0iRZCoG/Os8jb51H
 UWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778949976; x=1779554776;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iZ02RO3PSz1nyGtCJDOCkyKYE/1aqq1dLtrf7VPpXqM=;
 b=lcRTF5z9b7Qq4FFlS/YcAPELpRUMhBiNWr3/cvwUnOY3KDET+HI/SNi5ipzJwynEpS
 l+LGJCXD6skUQFzRABpiVRfLDaUssc3UxL6HwV5Faceq7NnT7fptLfMK0PgsMU/48/nY
 eVZjp7E4CYzh1U+kseCAKxRdV4y7jQzNjdyFyS1Yl2vR24VC2gaP3liMOqJjeByzb+oZ
 tQkeXjuJ0Qmtz4mmE9YeQAofAEbGbJnaBJ2MIqcRpJ87ai/ErnUA2J12EIOdaZ7zkOfb
 qKXLyPqaP+rOIK82ZY13EgoR7Ntyoa78nQDHkUj52mC6bLS7pHf4XxlJ7oyL1TXEavws
 v/uA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/J22Na3HkcAB7dJPS9OlQu4BLXhCJFMfoda2CRgGjXFetp7x2CHhvDx36+44fnBNFQNjkGEmgMSMEx@nongnu.org
X-Gm-Message-State: AOJu0YwdsK4c1mIHmXWajHPksA6rumi+HBkGRa2A2r/Ytx33f0u+WeYS
 fkjXVph8fUdfvR6TgzI7hMglmKgKz7x1zpVGXHP+JsahHF9Uno3KJq1s0+sRoZid0CA=
X-Gm-Gg: Acq92OHPXp6oqRiID4fhx8KLajRYiMLIScTwmQ2Hw3q/rSwAAMo60m0TeQ/7cyYR8y7
 CJLMzXC/ybMbugRFwRqw/ULA8lJxri+Ph4Gr8NaqKuOMwGjsggLiaXQaIAMX6H9FkBhe0YIb0pY
 HHZIjnTn4E5dvbp7qnsuhSDo32ZMicZPOXnsYwV7umfQkND0k0Nm3Gq1bcPIJz01y9HFYk0JszM
 wtd344JXK5eUlMoUjHqzEDh08WB76oHRPir6EW+AU0G3DASJuXAmV20ywVp1ukDYr63fyc5JoLg
 c1N5jNLECpoPqdLpIAWTrJLrIIrs6AayjvsNUdA/wTKA5VKI3sKfo4iQ2g9b6SOaoWKCGpcCcut
 +s06NDnHjqeNKcyb/Ob4nKvZfhY1fmiqmh1C7BpLG6CKxwDTSM9spgpEHtjW31HAdnnLmjr+5yA
 NOdAT27VZ8vYk+AJxr1CRnIcIAfv2drxAacLKGohhBK5QdjBDSqpJo/RV23TpiRO/mTA==
X-Received: by 2002:a05:600c:828d:b0:48e:6db3:ff2e with SMTP id
 5b1f17b1804b1-48fe61eb313mr118333155e9.15.1778949976418; 
 Sat, 16 May 2026 09:46:16 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe53ab671sm138508365e9.1.2026.05.16.09.46.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2026 09:46:15 -0700 (PDT)
Message-ID: <da88afb5-2aa5-47f3-8841-81b4c2364716@linaro.org>
Date: Sat, 16 May 2026 18:46:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: fix discarded const qualifier warning
Content-Language: en-US
To: Matthew Penney <matt@matthewpenney.net>, qemu-devel@nongnu.org
Cc: farosas@suse.de, lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
References: <20260514191844.105888-1-matt@matthewpenney.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260514191844.105888-1-matt@matthewpenney.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 14/5/26 21:19, Matthew Penney wrote:
> Modern compilers warn that the result of strstr() may discard
> const qualifiers when assigned to a non-const pointer.
> 
> Make 'found' a const char * to fix the warning.
> 
> Signed-off-by: Matthew Penney <matt@matthewpenney.net>
> ---
>   tests/qtest/libqtest.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

