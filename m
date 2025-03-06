Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD90C282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 13:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqB3C-00020h-8H; Thu, 06 Mar 2025 08:14:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqB37-000203-3K
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 08:14:06 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqB34-0002EC-JP
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 08:14:03 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43bd03ed604so5665765e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 05:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741266840; x=1741871640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VYWoYPg/1IM3r7+i3guZKEmoSHrcds60b7KY/3mGM0g=;
 b=A+ls7P7uivs/bgEwwksqHwP118TGnVfqLiUGW/FQPC74nbOGUE5DwFDbd8VSr5FJva
 UePFDc8dHQSuI41NfQSW0hx2KJTZJhX+FLqbkvp+k8r41NHXVpHI05pRKrjnpfQPvk1t
 5WpcZ5ePgoOGPurs/UGQU1OxDDRb/HNPYj8rpYl9YffzMwXjjVYUFozJygMCmLhK6VrF
 LJHawuIfrKKyU622DymMWZADyKJ+otkB2JGJl1FLtUifHiopTqVde/mYyQjHjO62qmUJ
 tfiOnhJ0iBXXeTzNFjAcSZ55MgIni3EbaYSJHbxTM7OiGxnyMpBO7hZMFYSFJjqN5E1n
 ZoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741266840; x=1741871640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VYWoYPg/1IM3r7+i3guZKEmoSHrcds60b7KY/3mGM0g=;
 b=vIEozhdJ6XjQ9MPxrFltYa1d6NlOLNASqTK2Tckdo9ux4krWJm1yTKptghl0akzsaB
 rwdL4YEnBPDLq9fJOGQkkpCE9E31SNJVZRrhmTfr6j3kaZbNUFLeeqFvuPF1tOo/GVeb
 lokruPUobavudI1TtqTw7tRX9eP75JcxMb9qYXgj8g8fqUi2LO4H2sgF0sLb9Pv/TUGB
 2UafVVy3E4IM777Z1wVeZzInlu6biwYGLx4xZ7kS8Oxu3E/ymCJyEeAwlhpZrLW2pXa8
 T+c3ZnDZgOi4F7V3nUsolL7Llfee1I440yNagomAvr8UEvQ6mSsKdBMAS9/ry9oPB8qs
 sVKQ==
X-Gm-Message-State: AOJu0YwmH6az7hJfsXK4bZ5FcjLSSdUG9KupbtD6pt64inZVPp3815fw
 AEQcLhJWM+AuBX0MvrDc3wQmJJneaWbXciDGsEHsYBdZqb/GfTO2h1q/+8OP4MPsj0VPit51csA
 uBiA=
X-Gm-Gg: ASbGncvkhcTkv/7NcP0r2OlZBwy7fLHed6ksI21ALPpcwFEp8BElm1lFRs49vZlIzjr
 lZ6Q/z7GbXs7TZDz/47iE9QshF0zhsjHMPH5uWkqI/YRmKr1lA+Q1jCjqpFwivb0zdsUtDcuypw
 YGhSrNM9fI0qMC6634rUUn403GZEMfqapUVvGtAGGJWk9IXDz/oAaSfOw0E/qXbZASq7h9Rz8x1
 wFXBR8sCJ+YoihLudm78bbJpYmyWMarHXCDrrnCrnGBZWEsWZfGULbN3KD4mvkAiLylznH69Bfk
 b2kxC4i8889NzQxKWaeI3OtwsjyJhxsKbmXu9lq++xihG3V39cD4aaaGhEttDv++2VFwE0R/4Sh
 fcR1z50dlg1x1
X-Google-Smtp-Source: AGHT+IFWpiYt3BF7LU6dSSUlzpU/loido0qj1xVIBRpAUMQ6yP4XzkShIkbCVy0c44wkisfPQQ5B0w==
X-Received: by 2002:a5d:6d88:0:b0:390:eae5:5196 with SMTP id
 ffacd0b85a97d-3911f7a88a4mr7887794f8f.38.1741266840247; 
 Thu, 06 Mar 2025 05:14:00 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e4065sm2058961f8f.62.2025.03.06.05.13.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 05:13:59 -0800 (PST)
Message-ID: <3bfd2f3c-c595-4e9f-bc1e-3918ca1d9b87@linaro.org>
Date: Thu, 6 Mar 2025 14:13:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/alpha: Do not mix exception flags and FPCR bits
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250211162604.83446-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250211162604.83446-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 11/2/25 17:26, Philippe Mathieu-Daudé wrote:
> get_float_exception_flags() returns exception flags,
> which are distinct from the FPCR bits used as error code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20250211130626.3940412-1-peter.maydell@linaro.org>
> ---
>   target/alpha/fpu_helper.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)

Patch queued, thanks.

