Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912BFD132AE
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 11:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7v8N-0001tL-U0; Mon, 04 Nov 2024 06:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t7v8D-0001sn-Dn
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:20:28 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t7v8A-000732-OS
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:20:25 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539fb49c64aso5455733e87.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 03:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730719209; x=1731324009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K/4xij/BSc0rJ6+hR412YXm76FFQgcd6TU/8derDxSA=;
 b=wxcH+BJOoe54Sq7JGj6dIAAO7Y9ZBevULgN4Mf3fKbW+AJxvzLZVmG5M8jqX7yn3K1
 RNrqBLEW2gQVLeFxJ46EON4IVZhqYDayo7wXQT1jkg6rIOv3D8UF/j/MSf0JZ7WOOOlS
 6YurJ6BvOi4j4UV/lRkJTf031wQ6BnGSUJw1OJ6uXoLGIttERqwc/uJ/0s5NdbWf4MFw
 25UavReUt0+iAoewT47T4pcAA2I9vZJfIHior8GudieIGCb/4AqRFyII79ePFQugOC9J
 ZEKpIDS5ezUvcGVbpziqAth0dQDTYf1VtFgIUgJ6IrOXHlfCP4Yjsr5+VBuTQsW0F5cZ
 TH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730719209; x=1731324009;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K/4xij/BSc0rJ6+hR412YXm76FFQgcd6TU/8derDxSA=;
 b=WZ9PAmOuFQkNx6VktXG0sthIMJeENxzbADLFntnj1Jrf4KOlHwXpgZpWYJvl17PxcT
 NeWLlcojPGoGkNRpRnK0Pl9skdi9UiF4z9nemNQGfk7/qqoSnTnq22YOu4vBb9rsaCyZ
 HZ06OUWRlxxRjoUYwsyusQJToTJnzf6Y+shWUfCFh1vv3R9TKm+6hH0q2YP5UqdgMg0E
 AFCaX0TbeD7PweqkmVPnmUdZS4q7D9A5LU+ZzHU4JPKhQ0qrFs5a9mRWmsq8CC5Lgysu
 WMDh9DOTl4crgQl2SlFaF+e/V0DER/1LCPZhKZ0D5H7WitNW0jUZvaq8jVILDcN11yTu
 kk1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtY5jFAMglsz/L50mfY9Lty8JDzUGWxK89nTbL34UkF4dfUmGDOgXeI5cnF8vNfpLwyzIpGmicKCeI@nongnu.org
X-Gm-Message-State: AOJu0YzWh5CLn/Hc/tHh+HXdObkwRbElTnrWTPqV7Ea/YB1Nf6XcbrJ1
 +h9bojCkoxiuZf7jiWsm/FA7jckOaP4rWLIakalIxMoOAw0KWhM6bavFQ+OD5Y4=
X-Google-Smtp-Source: AGHT+IE3IsogVSwyj5NFNALcthBOyYToexUocjr8j1X4dm9Q72jV/mylgHkh7m0dTovWey4V+SUYLw==
X-Received: by 2002:a05:6512:3d05:b0:53b:154c:f75d with SMTP id
 2adb3069b0e04-53d65df2783mr6929224e87.31.1730719207654; 
 Mon, 04 Nov 2024 03:20:07 -0800 (PST)
Received: from [192.168.21.227] ([91.223.100.66])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e564c5348sm538074566b.49.2024.11.04.03.20.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 03:20:06 -0800 (PST)
Message-ID: <3aa616f2-8a77-49db-91be-adb4e261b44e@linaro.org>
Date: Mon, 4 Nov 2024 11:20:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/watchdog/wdt_imx2: Remove redundant assignment
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Guenter Roeck <linux@roeck-us.net>
References: <20241103143330.123596-1-shentey@gmail.com>
 <20241103143330.123596-4-shentey@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241103143330.123596-4-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x131.google.com
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

On 11/3/24 14:33, Bernhard Beschow wrote:
> The same statement is executed unconditionally right before the if statement.
> 
> Cc: Guenter Roeck<linux@roeck-us.net>
> Reviewed-by: Guenter Roeck<linux@roeck-us.net>
> Signed-off-by: Bernhard Beschow<shentey@gmail.com>
> ---
>   hw/watchdog/wdt_imx2.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

