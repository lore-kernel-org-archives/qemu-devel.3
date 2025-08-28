Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E89CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOcc-0004M1-1B; Sat, 30 Aug 2025 12:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkJQ-0005Nd-GB
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:37:41 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkJJ-0001hb-NP
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:37:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45a1b0bde14so8781525e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756417051; x=1757021851; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8j9TGNf5VgZqyxibF9SLEh5Avat5cxNOqr7xWgK7H+s=;
 b=eHEnKmtfXNLVt0TjtNFm1pyg45IUfDVWj2qzzoedyUXaTtrZ2qtSEKyOLNYSiXdxZi
 E8dcdvfvpyqmGgLkFygewJRlZMyx6c7PWRyFBqULsoEz87JniNcfquL9UMDV7vyoBre9
 9zwgFocg59374lwAOnecSJY0nMKE90VxjcGvoPhOySiBlqjESLDks7aDMV1z5UBbxNjj
 bO6AQwAykxHchQrwOb29+9wvIiaz6XHRy/wDcsQV81qLYINC+7im7OYev21r7cPjRA/R
 zD8PI1l6t03bdZxDXKmESfId+8xFXFwc974ZEC7pfIcr0+jtRAT37fdJkFfv9/WlH5U5
 CleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756417051; x=1757021851;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8j9TGNf5VgZqyxibF9SLEh5Avat5cxNOqr7xWgK7H+s=;
 b=BIGZVIbEJU2KI67jPlAqpYF8pviRunzPCb0Civ4sH5TOPDRoz+h7qZzIy9MJaJo5uW
 ERYlULla0I1OrxPNKD1PlHMRkoAdLD7pgHrZT4V1KJpZyhvtHVw6R5ULR8ia8eKj9yrp
 x4lkVFcAHazoxAvQ4fVKugHNWLueAXJv4a2e03dijtmRNIhwouJV6oH7H5xxQhyJl7n0
 RhtzXjsZ1Let9yx/HJZhRz9GXcIvwiWY24D9ksnFQmKkK6KVhzyh2uTOFegmHQ7zd08N
 SYsxdJTqDtFXseydzlL/2f8UEpfQtRTnQ6SRteSbiQdAOjj1nIobzowO7T/Cfh4do53x
 sLpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeJXQd8rzsV23B/r3gGrEY//C9nE9D8a1kTgFKHX/YrrgrZYh1vq6ZVG5s7RMr7bldNyjMcUXB//90@nongnu.org
X-Gm-Message-State: AOJu0YzMz5Q5GlgC4OgsW9l2oPpqZG9aIarBOhm1ZPoGpLM3RjQqghzM
 jVa9z08IvY38/gw8zd8CK5BG6CJXQRo+Z5rtMb1xBQGmbEti0/O1Co3ABWinv8xkCCGkPbJRsEO
 yVoZw
X-Gm-Gg: ASbGnctTdbPi9aFxFNdjbiUoUPhwLBKuUDbHfS8GGi+iwil0tRMCtuzcXHBnuxFHTYv
 Ev1Ly94RuoW6ZL/H//kqPo2VorVyncDP2uogbb8aH+T+t1nDc84IDOFcdpMwDZ7F8m7A9xtgouJ
 OlxuLOv5o28tOw7gae2ctUppqAfUWrkrI82X0tb7wPDfVLCDm9G7njMWIQpanRyGEfzgwD6uzr/
 6haH9R5gkGvkrwdzjfbGVhlIP6MTexg88e81xT9OdK+X8hSZHStrWeoPxaWHcrdS9V9Qv8YsPbU
 ovudU85xULCqCgktF/scTc4UDRhBvCgT8Gje/gMxSEzsw8PQdY9Q2Pj/r0VANE0nWi2wi/QRUFh
 /3pwt3IiKsBbYX+oZFJcB7eqVxmRaUYfRV0SwCpNcHGgXAuNNC2e5Q2seuCh8axtvsC4elwEkBx
 Om
X-Google-Smtp-Source: AGHT+IFhjqMOxqdsrAxp3E0RFCvY4jlsjRXiRpVPzYWcc79dWIS6dCHnj/YVsCZZcv5zVjl6hEsNIg==
X-Received: by 2002:a05:600c:4446:b0:45b:7a9e:c4ea with SMTP id
 5b1f17b1804b1-45b7aae0996mr31736015e9.27.1756417051229; 
 Thu, 28 Aug 2025 14:37:31 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33add838sm711587f8f.39.2025.08.28.14.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 14:37:30 -0700 (PDT)
Message-ID: <515be40b-33fb-40de-8322-a800b941a056@linaro.org>
Date: Thu, 28 Aug 2025 23:37:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/arm: Remove XScale and iWMMXt translate.c code
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250828140422.3271703-1-peter.maydell@linaro.org>
 <20250828140422.3271703-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250828140422.3271703-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/8/25 16:04, Peter Maydell wrote:
> Remove all the translator code that is accessible only via
> ARM_FEATURE_XSCALE or ARM_FEATURE_IWMMXT.  This includes the
> xscale-only cp15_cpar TB flags and cpu_{V0,V1,M0} TCG temps.
> 
> The no-longer-used helper functions will be removed in a separate
> commit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h           |    7 -
>   target/arm/tcg/translate.h |    2 -
>   target/arm/tcg/hflags.c    |   13 +-
>   target/arm/tcg/translate.c | 1324 +-----------------------------------
>   4 files changed, 7 insertions(+), 1339 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


