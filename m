Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7733D75BD9
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 09:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE3G7-0005Yr-W5; Thu, 21 Nov 2024 04:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3G6-0005Ye-8A
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:13:54 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3G4-00051t-QK
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:13:54 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-382296631f1so433576f8f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 01:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732180431; x=1732785231; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9DwyxcdicjOuZPpepYKRSNG5kr9KZ7Mb7T8PSf1cbdQ=;
 b=bQy20/ggUhb0Q96ADyBMFoEh0a1ryovFO4hcqdxQhrEsU7aZJKsy7Bn3rCqvFVYwgV
 FAt6mtP/W1U7yLtQohIx1UG7xOF5kUV+Wv/mwzQgC9t0txm2AXMhIoGd7ZpyQjYU4RFS
 Lg+aAgcJFX+i2xvMPzs0L0fOmsV1MZ7bCcVi5nbOC0HRfg7amqPGrAAUig3nB1YwQ3vR
 HHvTJAJcgZVlvImnu+tguDIg24lxIBUEoQZmFkW41tdlSGyg30DUH5uTWI/GL4rqYuIf
 Wyh89Lt7D2RYIf6NFlvNv1YZWh8/Tgk4WnFoxfw+cTTeTlaC1aQRawXMFVhl6VKM29Hi
 mxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732180431; x=1732785231;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9DwyxcdicjOuZPpepYKRSNG5kr9KZ7Mb7T8PSf1cbdQ=;
 b=Z//CHb6JZ655rcZAAGTieSiJOuxvxJXGuX2OAvJcLYpHt5k+LEwiBcfFtZk8WPkgPm
 7ji/Ye62WZ0F2N6U1DATp2qT4hURU9L0cVlesLm/0A5U0/kISxXtHUJfDdZLI8RpFam9
 t1wfjwbQ+nzZs8GajeoM/UR30n4KtK9fPaC+tUAQa8p0aOUEm3uRQil/B4Su0W8iHm+H
 A0KHFCgWV6/Sg1RTbxkl1jH/DYG19Cfj2Ex4/KSDycjZ6iefvF+g+bp8V3yKtyI+0f4s
 N3xGezFMi3Krw2Q81VeOU6uJ8d6VSPbQdyUXIuzMseyNHkjvBi2EezYG0iduEsCz20Yx
 SCxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXONIZeEeP8VgkEf71aR9MoJl+dLln2uXgBAMo6xE9Ey9pxFAsey1LRN0LgfUPlcw3OSNpbo0Cvcl6g@nongnu.org
X-Gm-Message-State: AOJu0YyLqAlVFQVws9s9dvldkN3zXMzeRDlrlvD/lm4kAcSiBvWVrbSE
 kOTNQVJoIQgJNW+I9VjKwatSqLyA5T1AS+abLQ5smgfAiAGkekkmO7WY3zETgHI=
X-Gm-Gg: ASbGncvnY/QVuavKPOv+dpvJ1M1fPr2FFKQ726oGGV4eo3HVWmEsaqSskFEUeeXJCsF
 e0BL4rZUWScPMH/0JaUk5qBE36i3DI/2AWBlcGdGRf7WPvOuAxJQAzyIC0UajagwUEQFyNcWTQ3
 HSS8LWR2EbfmN8a3Oxe6QT0xKCLR3Bx6u0BfmUvkxQwnjziQvQ3Ja+15ULGNLkK1rCkkL8rpCYG
 21sH3T2nP7NCMxsHAJ0udExJzKOFDi78kF2/6KpQQ6l5swhUF8xsRZ2qRHiLI6wbiXixw==
X-Google-Smtp-Source: AGHT+IF8bllYWAMBwrB1sx2LBqxy688lEsvaHLH+fu4J4ueWFbdW2KCsyPbXFeGfXwsE6fd09uAyGw==
X-Received: by 2002:a05:6000:1fa9:b0:382:5ae6:5aac with SMTP id
 ffacd0b85a97d-3825ae65bf9mr1034301f8f.50.1732180430968; 
 Thu, 21 Nov 2024 01:13:50 -0800 (PST)
Received: from [192.168.69.146] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b4642ad5sm46889775e9.37.2024.11.21.01.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 01:13:49 -0800 (PST)
Message-ID: <ced8ba1c-5f4f-44ee-b662-c7e1c745b3b0@linaro.org>
Date: Thu, 21 Nov 2024 10:13:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] qom: Create system containers explicitly
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-11-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241120215703.3918445-11-peterx@redhat.com>
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

On 20/11/24 22:57, Peter Xu wrote:
> Always explicitly create QEMU system containers upfront.
> 
> Root containers will be created when trying to fetch the root object the
> 1st time.  Machine sub-containers will be created only until machine is
> being initialized.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/core/machine.c | 19 ++++++++++++++++---
>   qom/object.c      | 16 +++++++++++++++-
>   2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index a35c4a8fae..a184dbf8f0 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1193,14 +1193,27 @@ static void machine_class_base_init(ObjectClass *oc, void *data)
>       }
>   }
>   
> +const char *machine_containers[] = {

    const char *const machine_containers[] = {

> +    "unattached",
> +    "peripheral",
> +    "peripheral-anon"
> +};

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



