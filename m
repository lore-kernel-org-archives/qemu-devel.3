Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29E3C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 07:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnBSi-0006Yb-Rz; Wed, 26 Feb 2025 02:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnBSd-0006Xq-48
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:04:05 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnBSb-0006i9-8g
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:04:02 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38f3ee8a119so3171639f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 23:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740553439; x=1741158239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x3+rDLr1IYC/sg2FsAeyY72QCdeKakGfIfnvwJ6M5A8=;
 b=DGEId8EOArJwEziTm92xeKQ7AKR42OriI6d3Bq7+2y5HPT8G3Myzsne/9zks7zXH2Z
 kh3Ek9bBprBvKJoGRXynL4xgmXTlrBCwrpdmfPOHNe/oWxz9qWaKbi049MkkkCMWN/iS
 pSejCGilZZo5awIzRA6WcYiBC+Oixs9kpyfFNPAGiWmeEoFe448iJD+qvEwpmT5Y+omQ
 2gvOkY+nq0GYHF3+ShTgIQAoeQcts2Im7rVKBtCmQhar21pROjcp8pKwsA9Z3X5RcAxA
 al0vbbx2luD3D17hK36ZLU4fr7HjZ/2sx1WRDtMl9XORnqrdFLmT+2/KP53U6kdOfdk+
 /ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740553439; x=1741158239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x3+rDLr1IYC/sg2FsAeyY72QCdeKakGfIfnvwJ6M5A8=;
 b=SfmuluVRq3XSOSvP4iOVT/CwKpTG7ZT/KY0/HyA0eG67eZtxiOQsn5hTc7jAs6jRcw
 9yjjRDE9Vfa0BIq/hCzzTog1Ha6PLjCCBIeF8JRzSIpNJ5utT+kTezIqB+90vHtoc1x0
 1Z2isWFvvmrw9WxvDGELyR4x/xkOEkwntVgTPHV57o7NAkFyTzP1oVlwfNpaoKsschYv
 9Ier5EcRkeOkNCEPJt2ddHcrv2GF9YVrD1q4yjGpMXATVqW/y9az26pDXIUpNqKtcs/a
 ljGu6oTgodL5mFgNW0K5GnQtSE1Bt5bD8SeQSARK4j8SxuKI3sLZqycbH++dFB9TdUXx
 YpkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwoomacYSJdiGSqsmPteTD8Ay3hKjW0eeLj+pcboiXfL0InihBhn9scluOWiknUjuu8oKpKWkfq1FH@nongnu.org
X-Gm-Message-State: AOJu0Ywih6ZS1pNIb96c2IZrB8QZQ98zV7FZyiuiFyr0CqMvqEGEqOHd
 nflKe4K7xdEtymMG+27ZpVwaV7k2hMCaEs4H2rKuOjDHfUrq2t7OlUtZtGYgWn8=
X-Gm-Gg: ASbGncsf7XRz/vyL3rSJVmiR1jYEuRRoy9nznv7AnOiVf/N5qGqitLBxXEW9DYmMywf
 Vbxrcv0J0PnEWZj1KObDLVxquFRMYfS+DqfOcnXd0Yc8b8y080giqy5C3u4fa4/UF7WwMztAdeB
 tXseCGA5Kk1emlgujI+Jtsx1XoOk6fo5n0oOOU0k5V84WGTD5TtILv74FJYOzM3Fpos0Y1YcKWZ
 DD829Hyr4aUhizm6tupV29DJYrSXxBJjxkv0YqZvyFrSgat+E/LAQBFUNPltsA5Y6c6M7aMKxR2
 Ao4bxQakyudYAaf2vnNurxdKbdrn3MwQAFVlcTi+naxiMNb3vYc9VRyPonw7fNJGcXYxGZZImp0
 =
X-Google-Smtp-Source: AGHT+IFqqsLRHGw/N+jZYCru99BiMtqmaFo1KufJ1mk4WmVQUllyXUc3RICshwChi54Vhafh3OMaXg==
X-Received: by 2002:a5d:65d0:0:b0:38f:2f9c:affa with SMTP id
 ffacd0b85a97d-38f707aabe9mr14657230f8f.33.1740553439515; 
 Tue, 25 Feb 2025 23:03:59 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd866f79sm4618286f8f.17.2025.02.25.23.03.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 23:03:59 -0800 (PST)
Message-ID: <f4b1dfc6-5265-400b-8842-349668c8e972@linaro.org>
Date: Wed, 26 Feb 2025 08:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/gpio: npcm7xx: fixup out-of-bounds access
To: Patrick Venture <venture@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com,
 wuhaotsh@google.com
References: <20250226024603.493148-1-venture@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250226024603.493148-1-venture@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 26/2/25 03:46, Patrick Venture wrote:
> The reg isn't validated to be a possible register before
> it's dereferenced for one case.  The mmio space registered
> for the gpio device is 4KiB but there aren't that many
> registers in the struct.
> 
> Google-Bug-Id: 397469048
> Change-Id: I2fb8d0d3d41422baab22e8fc7e9fadd0f2ee7068

^ Both lines are irrelevant on mainstream git history, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Cc: qemu-stable@nongnu.org
Fixes: 526dbbe0874 ("hw/gpio: Add GPIO model for Nuvoton NPCM7xx")

> Signed-off-by: Patrick Venture <venture@google.com>
> ---
>   hw/gpio/npcm7xx_gpio.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)


