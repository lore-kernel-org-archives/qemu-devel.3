Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA22E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqqf-0002TL-Ta; Thu, 09 Jan 2025 06:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqqb-0002Sn-1R
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:37:09 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqqZ-0007hJ-8D
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:37:08 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361c705434so6406515e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 03:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736422625; x=1737027425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9qqmss/4qlYz0j8THnWRptLMNQclHE3zub8jPRmGukc=;
 b=Y5Cm/wNGFFnvh7QEJ4uZ/hKVMHU19bme72GUAuHaZp9KSuHrwhnMRwWxM3KXrNyfxW
 FGn4VyDyTly7fTUv11KuRzckpJ8I5LWr28jyXTYI2xZ8lqgjgYDaoxiZHDAqMt69k/Zy
 oi9wr7PfWWO5mm07Jvyn+Dknsr3pQs/3UFcIrO/tgJXM1M2YJBzsQB0AXHHk2t7ny51u
 8krvDQMfdjTubeHJZCbJyKLMMtlZ7rSmjFQVT3mFeCdxuMKzGgvCopxq8blvhS/tqtL3
 hkQKxvwUkwVoXOrwzXrBbD0RM5KpmzyTvIio4CSN+mlNqQ27d1/p8kD9nvwLClGieIu9
 6x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736422625; x=1737027425;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9qqmss/4qlYz0j8THnWRptLMNQclHE3zub8jPRmGukc=;
 b=c79b7nEArbfbE9LHmWbzJKFCvnkAymKygfJ+m3IzG9LdUizLns2twE9YDNu/x0Bsco
 n3056m82PdJhbKLilmaPdIBKO+3Hf857YaAfq6qG1ecpJTv44Ev+mwoLXLYt0JCkq3WQ
 aqQdeKO6EYF543z/vG5jAhBKeBnKA6WBrtqAWoOnIEdmpJIdyP+Sk4fznoMIIn0cw9ER
 j0R3rxqgCvoBNtsI5lg2DVps83bOva+Is4VafAhldOtYOD0yry+I5eQ6XSmzPV9DgDCI
 DnRLf76urwKMYLjH8NUT/as5XiAtACO1e6+wzxp4w+/lJINb/ZOI2qCGDtqfaRrFt7gz
 tUlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrSShSu/lAksK5mqfY9hqtBfBTGIwtl/PI1mxzL4h7hRUXHuM78kHHWkWJQ3hZ8xbZbhkRvF+Hif75@nongnu.org
X-Gm-Message-State: AOJu0YwZZjKEg8jeYYBZlJImt7zUkEc9I86AffyFsiHfBnKhTRlhHyhs
 3mEcfTbxSJvygG1xvIKsYL3FmmueKgExLJ7QzoSZPbDW0WzB7R8RjNN7l7Q9no4=
X-Gm-Gg: ASbGncuODzFmgvLbvhu46ajXBX5+fSJfIxASICgdam86IyYB5gO+/6KoIWXZlUCjSZR
 FbWiTjhv0O79zrb+v59pI4rXjBWWNqP77n+JbkJLLgicdP5I1tfeF9DGf2DoTMyuHPI0zoUss8B
 XGA/6gASnFuFtQ3YRJNIctFxe0i0cnmQhWbY4ZyPWeb49IV4EKjsx04J4bt9tt90eTRIghJFIR/
 BhQF34BVKLJ2vVxDDb6h959tOCmdaIHQiPxnQX7hcCg0TUrcGTzF+6h+QscsgUEKqBTeDjAIM/r
 3xN+g7vDSE+GQA/cJ4kH0kiO
X-Google-Smtp-Source: AGHT+IGxIsXS9VddRGi7PbDgW0lhx+0SkjAWsgLRS5A0sNQlyUxIOmmJ1xECkOpB6L+VaPL/KgSU+g==
X-Received: by 2002:a05:600c:3584:b0:434:f871:1b96 with SMTP id
 5b1f17b1804b1-436e26f4ef4mr53737795e9.29.1736422624655; 
 Thu, 09 Jan 2025 03:37:04 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc0069sm53367715e9.11.2025.01.09.03.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 03:37:04 -0800 (PST)
Message-ID: <54ec7f31-8856-4d8b-9a86-b2f8d1a1943d@linaro.org>
Date: Thu, 9 Jan 2025 12:37:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] hw/sd/sd: Remove legacy sd_set_cb() in favor of
 GPIOs
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-8-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250108092538.11474-8-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 8/1/25 10:25, Bernhard Beschow wrote:
> Commit ce5dd27534b0 "hw/sd: Remove omap2_mmc device" removed the last user of
> sd_set_cb(). Rework this functionality into GPIOs.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/sd/sdcard_legacy.h |  1 -
>   hw/sd/sd.c                    | 31 ++++++++++++++-----------------
>   2 files changed, 14 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


