Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F5FD1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 07:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQgq7-0001VR-AI; Wed, 03 Dec 2025 01:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQgpy-0001Ov-GB
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:59:43 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQgpw-0001T4-RQ
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:59:42 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so43708545e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 22:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764745176; x=1765349976; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IH6H/JAQVk1cE39zGDzQaUYfKlHp31S07r+yrJPdFtw=;
 b=us3mIs4vU9Mq7oGz4Is5fJrYcFnnBpWmgaZNsjB0WxhkRBQDpe7XltOHwuEHGZLHOu
 XQ2LcvYjjA8g2eaHE/6hnRR4sczTIaIGelIbpkNQdsKKmrrnwHRxo/KcRpmbHgPjn1vo
 ZSqhiA7o1YMeq5gKW9P86TOGDRl57mYMIZAHmVBlhWQ5oIGyteKmaY4lGlW8hUuITC4N
 B9UVdlbB59LIh0oWsJ/arepBsR++6I3XCUxGM5P2b5AjYG8q58i01MIzudqvX8RCkRJ9
 HEJEqV56UpHM8t9UAU2cIKV7MY/MrUg5vpGIghLqfhw836eCNxpndJw25vDrGJF1qfy2
 6LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764745176; x=1765349976;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IH6H/JAQVk1cE39zGDzQaUYfKlHp31S07r+yrJPdFtw=;
 b=juSUaXtcxeznZ6rjitil21tNSCpNpegq4eUnD/BQTvJydjZ/IpqeShEznyVIxhafFb
 LYHQkEeZl1wz5MO81TPIxCOVxgUA3UkJ/LVv4+7fIXFlIcgwKfEbfGJ3BoSGcEk9FyDJ
 k6SD8yWhznlphgDGxKIrlmBLa76czlf1F3cqGgL/TN+33EwdVbCUHRdDyDSUuSUbDKgd
 ayxYj0SV/ycfpMpO5xqz5zxmthEReKLTyE4i29xWAi1CCw+MilVB/enjcTf8QjKd5QSR
 cq12aazlLTWZxKxP8B4rok9erEjGOP+iPFVfIkOccjLsI5lB8TTkOxUfdy99HVd8DrEU
 J5MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFrPbAqGSOmYZw90z8JiNVzwxE/gO31xtLzAjadV9+RwYitNXtc4SyI2L+YSh95pw6IYKal2xgDlGl@nongnu.org
X-Gm-Message-State: AOJu0Yxc2UxUMm4CXwfB2hsediXuc5yVFgvemT9UyrTgY9wEEYnUWtAV
 76/RZKnl5roT8yyVfrg0koDnr0QZ1K6Yw7fqD9CyrPyJYM4qasTFc+sE/4F9NF/90rk=
X-Gm-Gg: ASbGnctc7lSrqw7tA9RjtbaQ4JNwI/LWHcfN8jtGLDrXPSoh9wO39dI+6n537VuvMiX
 +SOGUqe/58un1bXBHlqtyTXZTyC73uWuzZFu77LGZ+7cGUnMnC7aSvujkoSAuQlHPBLIFWOfVOr
 oVPbOQ/hLk9ZL5fA5+Y9DJPl6ptZ5q10ubf7GqLgPfBEO44ZesBJIdSESiQYhxaSGa88BVPBaSd
 Wpu+Vo1A0XgtVDqXVXnxQa2A/KDcQhEl1HHB6kGIsu0KIyIYmNdZ0yJEU/yyINOzBOR6dkudIn5
 vAL0xjBs4w/V4ovz7pbb12ta+GOd7RWCh+JXTjm6rfKVSG9TKJLkQQo1feKWPRQJsQvXaQaRkwr
 ck1EsBCt/WiQq34yyGCY7i7tYi8tQ/Zwosfkx1z+tEY7e9hw8os/NOIEAN5/YPTp7irQwFlpdeD
 hvK3GnJnYYA7FCPTh/q0hTI8F3lU0hEuLCo8LWsR4aoRsaOFDIik5ZTH0gnqfWi5Tv
X-Google-Smtp-Source: AGHT+IENt+Ug1ebDyUVrZL2J/Tpb/gfFULOzK2CRZ7YUIGUmw44XUZ1X1QKrIVAKwnTbZHVowulSfQ==
X-Received: by 2002:a05:600c:c491:b0:477:632c:5b91 with SMTP id
 5b1f17b1804b1-4792af30e95mr12804005e9.16.1764745176523; 
 Tue, 02 Dec 2025 22:59:36 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792a79dd66sm31622355e9.6.2025.12.02.22.59.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 22:59:35 -0800 (PST)
Message-ID: <75b1bf03-1f65-46e7-bbd2-0fa106cf8fae@linaro.org>
Date: Wed, 3 Dec 2025 07:59:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: allow slot size to increase
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
References: <20251203035847.94102-1-j@getutm.app>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203035847.94102-1-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Joelle,

On 3/12/25 04:58, Joelle van Dyne wrote:
> Instead of having a fixed limit of 32 slots, we allow the number of slots
> to expand. Currently there does not seem to be a need to add a limit, but
> if the allocation fails, we will abort. The KVM backend was used for
> inspiration here.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   include/system/hvf_int.h | 12 ++++++-
>   accel/hvf/hvf-all.c      | 78 ++++++++++++++++++++++++++++++----------
>   2 files changed, 71 insertions(+), 19 deletions(-)

See first 12 patches of:
https://lore.kernel.org/qemu-devel/20251114200422.4280-1-philmd@linaro.org/

