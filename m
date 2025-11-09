Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD0ACCFA1E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 10:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI2vu-0008Le-Qi; Sun, 09 Nov 2025 05:46:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vI2vt-0008Gw-7C
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 05:46:05 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vI2vq-0008TH-Uj
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 05:46:04 -0500
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-640f627d01dso3824470a12.2
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 02:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762685161; x=1763289961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I0XbYMG3ZXeiT8BVAbvjtRixtNLKhkoATyUV7fZJRHI=;
 b=hlrUDek525ECRXHgAzq9xnB876yd/x1WrEPlMQmlZ2FvjEfSnsjEfwUp812nyyyKYn
 JEXYvUZfaWD3+jXs+rbt1olUmJ0QSX6tqKh6p0adVYFmm0feV/tso8mpFrcLnvX7b4SG
 VftWmdzLd/hz7J2K8bfWbAgAjffwUdVYh46TZ8WJcsJOZ73o6DYeQ9xhBFL30KF2WQd9
 IKLrJnoWc6gHWiyFQjUn4WPHUu1g6OtPmkWe+iF24xA6XXuEgAZaZ8vZ6LB7Yw24oil2
 AbQuPundOb8lJvKx+nQ3MrjocHgpSY+5B++aElM1GE/L16nb0qqK5bFznOIqmjqgVHoh
 htjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762685161; x=1763289961;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I0XbYMG3ZXeiT8BVAbvjtRixtNLKhkoATyUV7fZJRHI=;
 b=h6aOpcQvIbyTmVwUwoj3jh4fCSYgrePBv6CHowjvmYLuC3cSFdGP2u1H3ORoil1Nfp
 n5kY3V/wWuvBIxTR6FONLLBIseMAm0gk0TBNHzBV7A96MMJXDzlMzLhMb8Q0mpEROFJe
 0YZXe1kcO7EGeZHHtaOqODzSu057bAoQ9YvbHMyEgQj8Trx44gXiyAL3Y/ozXHYnXvRe
 HZ74e/cELreEBz3aPVc2BmP/NDGPJi1q5hZg4/9ZUSOuBBHcwqcjgy0XDUSHo5wTwERG
 U7g2rEYMnKNQN0IgjI767lu0nz+CWutmZ14HYZeOccfZ2q8FWbYtDnfE1UTdIJ3YERGh
 GXIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9qGm2K4uC0RO6nm+zyFy2mj+Ihwb4DdOco+JXQrHZCxh/AGOmn1UDZQkVCIFs/2lOPJIpSu/G5ZJh@nongnu.org
X-Gm-Message-State: AOJu0Yx87teB5Wkcis5V6yQ0QJDR5ZsbW6THgVd5jbK/Ngcj268TfaY2
 +SQHiBQOTCnDJRt9hILlAR5tEA5l3qz0gGD4upsC8zQ3+UVQS8EZsuWa0qQEW89Toyg=
X-Gm-Gg: ASbGncswBs3MbQp61QzLhG3D3KNs9hYOJyfKfG/FnYcrjjlFExpOcuWPEpdQ3CKyeVj
 peXm3aVtUEMi2DqRwkVofQHcU+ZQWlalhNcdS/EiwNkoQsTbK9o7F/qhvBXQ4AlxF/lOw8SHCR/
 0bddHNUIsnToA65YD9XE/5EjZdQ7JuQWFGePN5UCAsUh108FMp2mUYB8nzqPT+l5iheiL94xhu2
 6lRojhE0uObvVsnFxa2E5w5sqayEZ2UXqma+lUXruJKB71qpgkN95E/6+9+JuKQCGh3nheOWmml
 uatFzVz+u+R/bE+Wvtoci+3MgsGpp+Jqa9eD5QiUvNPAleD5cThqDgHz85B8f74phqQIJ1c2M1B
 EWqIMyIqykBgHnRxbJuD6mQQxPF5zylcm8X8XwNY7qYyU+pe0pmQW7e01xAxRmYBzNkJl6gy+0J
 vvbRVZtf0FJqQqUl/o3yn9GB8FRN+vnSmEx/mqwWHwrxu54JVu90vYTNsTB8XdWa4=
X-Google-Smtp-Source: AGHT+IFGDx2Hg73K7SSEPTwfZS2TGY1L073Ka2nm6rM/5PhMlrkhLyCHj33kzYD6np7OnaNg3o5IVw==
X-Received: by 2002:a17:907:9721:b0:b72:5640:ac15 with SMTP id
 a640c23a62f3a-b72e03156dcmr456854466b.26.1762685161095; 
 Sun, 09 Nov 2025 02:46:01 -0800 (PST)
Received: from [192.168.2.7] (tmo-086-152.customers.d1-online.com.
 [80.187.86.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bdbcea51sm767269166b.4.2025.11.09.02.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Nov 2025 02:46:00 -0800 (PST)
Message-ID: <e3530b1c-6f5f-48d0-ab5e-da94e59c275a@linaro.org>
Date: Sun, 9 Nov 2025 11:45:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/lm4549: Don't try to open a zero-frequency audio
 voice
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20251107154116.1396769-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251107154116.1396769-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x544.google.com
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

On 7/11/25 16:41, Peter Maydell wrote:
> If the guest incorrectly programs the lm4549 audio chip with a zero
> frequency, we will pass this to AUD_open_out(), which will complain:
> 
>     A bug was just triggered in AUD_open_out
>     Save all your work and restart without audio
>     I am sorry
>     Context:
>     audio: frequency=0 nchannels=2 fmt=S16 endianness=little
> 
> The datasheet doesn't say what we should do here, only that the valid
> range for the freqency is 8000 to 48000 Hz; we choose to log the
> guest error and ignore an attempt to change the DAC rate to something
> outside the valid range.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/410
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This bug has been around for so long and is a weird edge case whose
> only effect is to print a debug message, so it doesn't really seem
> worth cc'ing stable on.
> ---
>   hw/audio/lm4549.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)

With s/8000/4000/ in description:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


