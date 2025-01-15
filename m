Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BC3C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY70M-0000wc-68; Wed, 15 Jan 2025 12:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY702-0000qd-S8
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:16:23 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6zy-0007Tt-FJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:16:14 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so71936215e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736961367; x=1737566167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ivLKXp6s1QQiTYfBvfdOtj5QgTq8OAT6npLYYBJIVgU=;
 b=npmThJRsZp7GeVX47k0U4SUeXfBMP5m092ZoqT7RaWLYhKIXIXvpEezqx9qnl5CQcU
 ttkdBVxJEsy6X3xpEPSbb2puWexJilh6o5Zryk8MYMp2j5yNReq32Z5912V4ktaZSvP8
 4bEOlbzEbDE8hB9Uebw+mOt90moy1z7yYHOmfGxJcQ/pTorWf+8V5jKaSrjMnF4/dQ1X
 y83qS3vZl3aK5T7NujpXxsojdSANsmHmxGY/S0CE8BnYDI8goixpfMiqzrxJCW3OyeYj
 E9FGmmJQ0JVqjwIzsDGqK8LJlJH2I0C3xndAYfwFSD9MTe694bD1L91bJVSLiE1jMjxA
 nagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736961367; x=1737566167;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ivLKXp6s1QQiTYfBvfdOtj5QgTq8OAT6npLYYBJIVgU=;
 b=J0v63DYMRFJmybyYA1amRXQXhWJFRqBHeyUJ2EtnxP3LSxh7oAeJVqJuY3t3NzIfaG
 BLqP3oRAW6DbL2tjbYkYT6K9Hny7bZdddsdlwl4Asc8Fszi651brrQXopgWWfnoT0/SL
 xGhl2wf8t/ZRzti5Tz1Qe7Aqka29h4cGdkXA4ZXnDkrfMOzK4+q187/6+YondFhXlIxy
 G9VW1l8a0Cu/xOLtWeR0BE6DkTwKU/05UGtZo2RoPNJPhjAmOY50yu/Ifv+bHf0OqKtp
 x2nJ8hAv3H+NvVQ55dgEKDo9TxJ+6Yf0E4UPD/QZVtaOoPiA2TViwmRMzRKkwibaWTwy
 5xKQ==
X-Gm-Message-State: AOJu0YwuKZAGLGZAGskxTxLxjVGqOUDUUrREd5WPAHiRhdPYmbnmkyH7
 +cCfG0PIwx0iSl2BMAVtKW34NHFI8BHZWHBooZ46scIrKdQ5ZSq8vVypRAlNHN5ldO0cuoeAdG6
 iojY=
X-Gm-Gg: ASbGncsa05Qew/TYVl47S95uyjJlDdk0occGISUFa30xU3517RwU5ekFxTv7qj756DH
 CGCr1vRYMyfUiwsLds59EsJDJJMvICcMcRYFklnVevX6QE6adP+4lpSu8f9Uu9Z4mMwVDHPYzj4
 AAY5S+5uDeT4Zic/YuF0mSvJAr/IVeQSm3BkX7psizLICGwHnEC42YHwFPtuebylNXWUQFiQDiY
 1ZZzx9dHI3XK+1cAQDu6lB+P3abCP2neBa7IoIBGphiBrFUUqMUeDSTdV7BBscNwglhj6qdHCgR
 BMLqJTBNTjdWCMTCp+bx4rtBAHM=
X-Google-Smtp-Source: AGHT+IE1Bwf7a3sHqyJuXE00T8jm2djKSOqNg3vPOqOpyug6uIYl+4wwGBz7TOsno7f+lBx9IUzzQw==
X-Received: by 2002:a05:600c:5801:b0:436:30e4:459b with SMTP id
 5b1f17b1804b1-436e26adf89mr302487065e9.18.1736961367623; 
 Wed, 15 Jan 2025 09:16:07 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74fc57csm30795175e9.40.2025.01.15.09.16.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 09:16:07 -0800 (PST)
Message-ID: <b81472bd-8d16-4cb0-9e0d-d1488968c50d@linaro.org>
Date: Wed, 15 Jan 2025 18:16:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] hw/arm/virt: Remove deprecated virt-2.6 machine
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20250115171009.19302-1-philmd@linaro.org>
 <20250115171009.19302-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250115171009.19302-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 15/1/25 18:09, Philippe Mathieu-Daudé wrote:
> This machines has been supported for a period of more than 6 years.

Typo in all this series :/ To be replaced by "This machine".

> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") it can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/about/removed-features.rst |  4 ++++
>   hw/arm/virt.c                   | 12 ------------
>   2 files changed, 4 insertions(+), 12 deletions(-)


