Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A679C28B20
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Mar 2025 08:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyoS7-000071-TD; Sun, 30 Mar 2025 04:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyoS5-00006G-84
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 04:55:33 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyoRz-0007H2-Jb
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 04:55:29 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-399749152b4so1276114f8f.3
 for <qemu-devel@nongnu.org>; Sun, 30 Mar 2025 01:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743324926; x=1743929726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9/nxt1LrBVyfREPr1sg3Dt3QD+ktmROgEeHZ5OrCeQg=;
 b=sXNneDhzQwtWodEKQgMem247WZjwyST958HjeGOXPwrTpNi091CnK5Buv7ImMJ8JnH
 sTdkCUAWTk8fF//G04vii15+c+ubcjJtxI1Ra36Cn12BPoXg2aKhUJomdDBAmS3Dl9uI
 NGQhsgBhjQwuVm9/aOBVnN8oGb46Q7uvM8gxDV650HCvOEkAu4j6g+TCoBeeGHVlk7g4
 jUYZFSR/mTs+jsnNfgqAZb2JcJzZFqp5w6B+wPgOyOeMi/XBDYK05+hGijAnDhHNGFDt
 Z8gb8J2CkImeJTgA+/5DBrW52XTeZLZGagcYjviOxtCMSBj3cDuQHL0CwSlsi87h49RD
 tlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743324926; x=1743929726;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9/nxt1LrBVyfREPr1sg3Dt3QD+ktmROgEeHZ5OrCeQg=;
 b=poYRLQXqNDdsFHO8lamxVwLqWlM6JdckBUHqptZ5+1Nd01HUnyfzYvYeBOQxEAMIL3
 B7kWGvfGScaQb9RDdx2GUycq9Ds5zyZn98hWgcd/LxBWRAw4cgrKXnu5K6tb1BLdJAGq
 AKHPqnQ9Iaq2DqGhiqZlfVu1izkpjYt7HfLX0+xsnj0E3DT0PsH478BiDo5HlNzglQ4b
 FuN2LqFjYAnydEVUhJ91GuXFBVLslSsTBJtcv+WehPu47NhyaFFsQXaSJZX7Ym5aXovo
 sPUUD+Sbm//lcoT4w5f8oA1A5dWi+1HPoflJEhIbqH18Qlo4WWjuAHDp0iUKU+MQ4djj
 CF4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBKKOo+7wCDkXqNB9dkU8npK13zl391c05bth2HbE6M4n0f8w18mJ7M1Jp404dYGHpIbuPgM+gfcP4@nongnu.org
X-Gm-Message-State: AOJu0Yz5nmgg2nn9iVadW3b3EXgRQOHvdbjIvTddf+tqjjMNrG5+L3M0
 sCFUyUiJQiZYh9oBSNmcMd/EDJn4lktiVrDkG/5R5NoUkBlFG2zf7rR/Vxbv50s=
X-Gm-Gg: ASbGncsKzdmFaUQjcs2wFSIst60b2iXda0Yttz16ZWIwMfwXm9zenAi5eaisdES0+6z
 1ttYPHbNinITIjWvme6iJv5hBLVC8G7lg671Va0020QjKLdZvnoleVSoWjySv18YfVQS0Yq/FTJ
 2b1JlfEn+s9wTidkNBMkQbzScIScBm97leCoiCC6s1DoSfU3JXYpdDb7IIGseNBl42ZFCHJTEE6
 c2+918XtiZDL498V7Lm6e1jaNwa4TikOR7eFNkqFzA+05lU2OU0jczbDNsgIpRAr5XzpeqmxPXT
 z1SRXsHCTuUqDtUATgIXaTMS5mqqQGm6pftTUP9B7Z/8waCPW6dioQjTptWVpk/JYzvcFRqw9rq
 GW8I=
X-Google-Smtp-Source: AGHT+IE+dNhmAlAK2mbAkbZ+IzjhYwl8hiKZp/nDqot5xHYuzUNswO/lea5IxJ/u1/9lbC3fAUdT8g==
X-Received: by 2002:a5d:5f91:0:b0:390:f9d0:5e3 with SMTP id
 ffacd0b85a97d-39c120ca76emr4304099f8f.1.1743324925667; 
 Sun, 30 Mar 2025 01:55:25 -0700 (PDT)
Received: from [10.155.70.213] (63.170.88.92.rev.sfr.net. [92.88.170.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658c87sm8110604f8f.9.2025.03.30.01.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Mar 2025 01:55:25 -0700 (PDT)
Message-ID: <e778d53b-7ff8-49cf-a23f-7255cc968672@linaro.org>
Date: Sun, 30 Mar 2025 10:55:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/bcm2835_aux: Fix incorrect interrupt ID when RX
 disabled
To: Chung-Yi Chen <yeechen0207@gmail.com>, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20250328123725.94176-1-yeechen0207@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250328123725.94176-1-yeechen0207@gmail.com>
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

On 28/3/25 13:37, Chung-Yi Chen wrote:
> This patch fixes a misconfiguration issue in the read implementation of
> the AUX_MU_IIR_REG register. This issue can lead to a transmit interrupt
> being incorrectly interpreted as a receive interrupt when the receive
> interrupt is disabled and the receive FIFO holds valid bytes.
> 
> The AUX_MU_IIR_REG register (interrupt ID bits [2:1]) indicates the
> status of mini UART interrupts:
> 
>      - 00: No interrupts
>      - 01: Transmit FIFO is empty
>      - 10: Receive FIFO is not empty
>      - 11: <Not possible>
> 
> When the transmit interrupt is enabled and the receive interrupt is
> disabled, the original code incorrectly sets the interrupt ID bits.
> Specifically:
> 
>      1. Transmit FIFO empty, receive FIFO empty
>          - Expected 0b01, returned 0b01 (correct)
>      2. Transmit FIFO empty, receive FIFO not empty
>          - Expected 0b01, returned 0b10 (incorrect)
> 
> In the second case, the code sets the interrupt ID to 0b10 (receive FIFO
> is not empty) even if the receive interrupt is disabled.
> 
> To fix this, the patch adds additional condition for setting the
> interrupt ID bits to also check if the receive interrupt is enabled.
> 
> Reference: BCM2835 ARM Peripherals, page 13. Available on
> https://datasheets.raspberrypi.com/bcm2835/bcm2835-peripherals.pdf
> 
> Signed-off-by: Chung-Yi Chen <yeechen0207@gmail.com>
> ---
>   hw/char/bcm2835_aux.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: 97398d900ca ("bcm2835_aux: add emulation of BCM2835 AUX (aka 
UART1) block")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


