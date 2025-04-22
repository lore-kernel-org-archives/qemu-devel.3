Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F28C369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7FYI-00020O-2Q; Tue, 22 Apr 2025 11:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7FYE-0001zx-Vn
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:28:47 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7FYD-00015W-4O
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:28:46 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso3217071f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745335723; x=1745940523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sIT336GswfUUGGDWn/u3yXAGX5oRZi2o9Ol9Vf7QGAk=;
 b=WSRck1kBWUX17p0RwgSWGUWDdY7JfNKZ7Lu5oHQY/F1dzR6CoZD+p3NB2WEMkVL3Ba
 9tcelZHEHLsbMXkgsLDAFe78bmgoDzfOf0cRomN2+o7J73+IwmaUsT8093NWKRHNsgjc
 mrCcNizYqL1Glnn9sRgSDc6+YF5+M/17kuY1gG8jLifkNBT/bXfPDjgj8dV7n6T5xrKm
 RubmFL0zno2HmBcKQU7ZhoFYxIzaMfwcYYwMFiLYiQKYLn3Y6+zAC/TRTmND9OvIen6Q
 gqQAY7fgqd+MgN9OLWGU92Oha8zj7q3eCWkZPXmaJ85XZg+E9JBGwmvIgs7/js4oc/rZ
 ZMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745335723; x=1745940523;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sIT336GswfUUGGDWn/u3yXAGX5oRZi2o9Ol9Vf7QGAk=;
 b=qIp0k6KkDPVvZGzP/W3XMJ6TbsfyzINmMCoS2CFm/QKGsPQdSll4zj5SL1IFXss9Fl
 tH6h/5JbsFB0EtRHfh6IcHkCv5BTgt0A93AJHioSzkYP7vxWXj/m0vlvdMUD9SRgFCCp
 WU4VniLiiOhmJvtqgJq9inwV+eDkVUA1ib00e7tnwzD0fdLvG3XbbMYF1xtXFd31nS5E
 d9Gg1XeOtpn5NoBLPGElRPXdf89AtgQETHYdweG5GyNNPegJ1STj1Yo0QIhQQcbRw/Zq
 HsCeYsOYNjwXcUrxfOysAh9E6dwqzhzkuDDgQhSe0RoroD5+2CMV1SUA9N5URQo5V41t
 +ANg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOSIQCHrbM32q4/jKSBR81f57oBDlNIJHr57yfi7ibZcsAgVVpYq3AhVscoB7RgqtgHdyIV+qkNq/F@nongnu.org
X-Gm-Message-State: AOJu0YxMAwL24V62OvZBReBQ3gFUniWCoaMbf/idsUEy6ju8Tnqj8bPI
 ltcssG6VGFgYtdYUJJSpaJPTf9X17yDz2zE9QrEFeQ/chdDDf7L4gLwUdxt/zBZAcfzkWuh9Cjb
 c
X-Gm-Gg: ASbGncur0oPuYzXwxcMI4BD+oFW0BgvwF2fLGC1s4hm2UppLEcyKtVrOqAIA6GsTOEQ
 jWP2wR8cZfA98UVuC/Tz+a/f1rmUGFdM3AoCEv4EV3AahMp61BI+fL29eb/DQROePvc7JO5ALxh
 75i896MTe2teomWrE0wVEz0R8o75oLiuAmD6MvvIjpqohdtZaTynNKyxeY791fPZ+BBdoXGYHsN
 T2pmUmhc/a8lD7boa+S1o47IjGTY61ZZ42iLDkOns63tkJVuDeq3JmxN/FPIWAX2JcZiT3eUK2N
 w1j142vkRiOfxKcs9c4plZYU+z+5uon3dPpNjkYUqW8hvqCucC0t2D66MJbbYv2FCHaJzG3BGrO
 lAjqYkUrS
X-Google-Smtp-Source: AGHT+IFj35Lomh4JmR9+EiZDfpa2ZsbZp7WquZF2o6/WNJe5fVLQdfVJGSDSFUzPM0YMnPA5ujbzFg==
X-Received: by 2002:a05:6000:4008:b0:38d:ba8e:7327 with SMTP id
 ffacd0b85a97d-39efbd60d51mr13448341f8f.8.1745335723170; 
 Tue, 22 Apr 2025 08:28:43 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4e93sm15802399f8f.99.2025.04.22.08.28.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 08:28:42 -0700 (PDT)
Message-ID: <7458e422-a343-41db-990c-14080db84a60@linaro.org>
Date: Tue, 22 Apr 2025 17:28:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 074/163] tcg/tci: Support negsetcond
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-75-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-75-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 15/4/25 21:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tci/tcg-target-has.h |  4 ++--
>   tcg/tci/tcg-target.c.inc | 13 +++++++++++++
>   2 files changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


