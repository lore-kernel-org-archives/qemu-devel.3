Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B9CE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwMn-0003Fh-NJ; Thu, 09 Jan 2025 12:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwMj-0003FO-Cl
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:30:41 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwMh-0002st-Jj
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:30:40 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so1087462f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736443837; x=1737048637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C2cKzrhqL83T5vH9ia9BW4cX630tgscG7HBCVjqB2jw=;
 b=OFDFBcJwmhS4aBoARrgVfTlzgXQZ6b6YJebB6V2v7/IU0F2DOXCi2gJMHikJUlFWii
 ivnEdWGUhIA+BzY+FLzur7as/fggaFQDHSCVqVZBPbamZqDSLnmVLuXgfkuaAdd3L0Vf
 FpA3ntz3FTHtlt5eA+HoGWCn/TnwfxgSkbIk7PQhQzZW3LjNo6Z0MU4BMIoZyGNQnBqG
 y6/uTFlSrtHXS/uGO1gyMlvhpl/S2zt6RibVFgNzz1HUZzP62SdCfJbCKQNmGkZYDVI9
 VdwQSISnl/KZ2Lo15Y6an/H4fESp54X9ffl8LxrUSGkgztJiKswBUf7rAxmJo5fZIykL
 C+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736443837; x=1737048637;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C2cKzrhqL83T5vH9ia9BW4cX630tgscG7HBCVjqB2jw=;
 b=inuspFaaaev3BwqKJKDhGMyici52BxflH1Cjg6k9DD3ydUkiXZamSB8huLCY+EgNhp
 pDJWpKcVtfm/t87eJKGqoLKma4MaxFjKFimRNs296990i2sruUZWr9+aAfeNsnQO9Ade
 2rugP6cB1cxha0KtxMCiD688nnRQ8Z50xjqeZcq0HArVPfkZ6r7Fe/isG8f6pEFFjAbX
 NpH+8h9QVopFGUrcuPVtnWbQRKzpk/lJUAEWjHI1oQ3OdNrBdsqp5Q4NbqF0PUj7BqYV
 BCdeLZP/34D13RYczJgO+i2cUF6dJffVhzjvf1p1IOUrOtT5W77kbOPy8s7v9mQ1TAa5
 bRaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWduYgqwi56ZB2ByUHTx8KXzt3Il7e376YPl4yQQgJsGJatt0Kbr/HVfDgc8dRaupzby6tTLYuuZ3Sd@nongnu.org
X-Gm-Message-State: AOJu0Yyh2NMyoq5I8ytT58/yYu2BZ4LQ2cEqZ3cAgx0snxgZ9ouMrP+R
 gEgK8CpVmpTPFJcYJ1xdQjpEbE34K9Vk4syHgHEZGhdx/FUJ53fFi7QriPJYAv4=
X-Gm-Gg: ASbGncth7Y8QiLrOqdnwP5gsFcFiCBGk0dm43eZ8DjpAj4hOlXQnUmu1k2Khe/FgXVZ
 K22zbCaRP2dTdBR/Y5kZN18UeyJ3RvI2+ngFJhD3iJoymFHobB4CaFAag/m5Mlblv0i2NGt+S+u
 9p72ipVHVwRwmcDUR6Do8HdZzwx2rC+SS/1ralfTw3+naLpKIgJMdzfeuoDKKmaKyz+0XQweqec
 HWEKQfZxz3zH7Dtwd/w3tXwergCUdJjwetrHAFiqih0+5bnqcczsCq3crTv7rnBT1nuywl1O0k4
 VJzbmXL4i+2RmtCG60N+OzAM6TM=
X-Google-Smtp-Source: AGHT+IEa+Q4BkvU+RY7Cs+pVRxt7wfxaXdoelzq2PDiprAtMUHydkCW/om7pfS/Dz6kSgOnsBjAmKQ==
X-Received: by 2002:a5d:5f44:0:b0:386:3e3c:efd with SMTP id
 ffacd0b85a97d-38a8730fa79mr6790834f8f.44.1736443837549; 
 Thu, 09 Jan 2025 09:30:37 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e6236bsm26962785e9.37.2025.01.09.09.30.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 09:30:36 -0800 (PST)
Message-ID: <df5bf2d9-04f6-4263-829b-a1eae946c0af@linaro.org>
Date: Thu, 9 Jan 2025 18:30:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/22] system: squash usb_parse into a single function
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
 <20250109170619.2271193-10-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250109170619.2271193-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 9/1/25 18:06, Alex Bennée wrote:
> We don't need to wrap usb_device_add as usb_parse is already gated
> with an if (machine_usb(current_machine)) check. Instead just assert
> and directly fail if usbdevice_create returns NULL.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   system/vl.c | 22 ++++------------------
>   1 file changed, 4 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


