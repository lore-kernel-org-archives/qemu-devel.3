Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E56CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScwt-0007QO-Au; Thu, 28 May 2026 11:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wScwn-0007P1-Bl
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:47:02 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wScwi-0005Im-TC
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:47:01 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45e6a4d0be0so5853368f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779983215; x=1780588015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lAN16lgQh9UekUbmg4lCk75hzDgXimz5qVhG2NR2Bl4=;
 b=wrMvITePg5eejNOgpFUUXTa4C9aSZrhMlUcNILHJZi9Te/Fs/ZDrQ7N0gd3qwUCTq3
 tNEJOL3wucgHMNkEX27Ti734WsY7X2mg6LB+xsbyTFvBaXZ/0hA/Wd3YAjDT0/69Zdzw
 JgL8lM1gOHpAgJZULMuyaCDaZwal9xO5gswalM4xxXNdPLqx+xh/88gN5QAz8x7WfIAs
 B4blIo322yPGOD9FTgY21ML6K/VZxmm7syGX7Fi/m2CiYc9xj0KzOzmZOa6hcDMY8dFd
 DW1ZVzGiA6FXLOCexAadOR99Gz/EAkEsOMoEO7/TIsowJ2xwnTqsNWmVn6jUtcAMlge5
 e0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779983215; x=1780588015;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lAN16lgQh9UekUbmg4lCk75hzDgXimz5qVhG2NR2Bl4=;
 b=sLVqCpbk49SCw7RFf+cX3+Ms+K+1qluah0INXXplAQHnYkuD+3k7ZvePdPdhb15KpK
 ldM9ClfdPlNQdumm+x3F/vhwHc6MwtqoRGESYPXhJW/EVcZwhU+XEtkTrU42Vj2d1cuc
 n1AvHS5afVRwxJvsGvc9PN8tQM6PXqeNqYPhs7iLVUs26/uMYW0i+rY3O23IvyGCLZ3J
 52lbeib9cmlZ3RR/5ewThIRwKCZSNP9OlZ1pe31FpT7vQhETdfkG+YUWDAHzlDt1owFl
 hJjcG+wJJNgIJf8pGLus76d0hXDKAdaX6AcOrvJbKLfEb2XSWrki7KeRHuMgnA9gttNB
 0AKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9AUEMkqm7gtPyi8sRQbiFe8OXrXEKJLBmZ3rODUg0TmMvh+bjQXllieO2yhQpXDnOjFOYEmDfXy43A@nongnu.org
X-Gm-Message-State: AOJu0YzuJ9vW5BCWy/eLxTGnayEu+R2NTr7jpRCMZAcMm+8HUQpGSJaS
 wuWdDE5t9iTFdW6Z8wSjuKWoCWAUBfWEFRHgnDTLA8c7QXfXzilCKAGDPsqRhCvGZ0c=
X-Gm-Gg: Acq92OGu9MA86X4mbS9fPppGBiSHrgEIxHuzhv3rG73D5c/sTe9pV7NG10tuvNthRIJ
 SpC87jWAFD7UimYESG29wDvHpXl4Stpb0BKxPG3mi2aTwtA4EwXhvNTff4NMy8d1YVn5qHHWb+E
 /8myCEjrSHfvwBeNFKQSnSBgb+30pixG/CvOFqKShouCcFTPvuLKq3xprdpMXzzzhRugZNNqjQ7
 kQ7d/+8G30V7LwkzDe7lLfhWDFQNDqYNXRJEUhoDFQquFAIOlMU72kP9Qjtxw9JsTeUCcOmx/dI
 w8DfGLTcXg+ev7t8JupnfjTJrSVwX3jDK81yz4p/jhZXUBucvbKbiue8iIwf1TVI0B58IKHqs+k
 g8207lSKRMiyg21A+Fo/JERTAcpF4CUV0IX2iFjQXTE+xeCc6aYmquYoBOzgJonzWhcP8pfG0Sh
 2VeKvmIpCVJT1DLY35oP0A5nEIZXqvdpcui/t2vQOeIY8hn8bEH4MUa+IgP8Bmg8l4w30lGSQbV
 OAr
X-Received: by 2002:a05:6000:26cf:b0:45e:93ac:769e with SMTP id
 ffacd0b85a97d-45eb3688c6amr46107784f8f.6.1779983215331; 
 Thu, 28 May 2026 08:46:55 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eec5eba06sm3116951f8f.22.2026.05.28.08.46.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 08:46:54 -0700 (PDT)
Message-ID: <5c7b5d01-cf5a-4164-9a92-516770eaaa07@linaro.org>
Date: Thu, 28 May 2026 17:46:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/dma/omap_dma: Fix indentation after ifdef removal
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260528152852.3349928-1-peter.maydell@linaro.org>
 <20260528152852.3349928-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260528152852.3349928-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 28/5/26 17:28, Peter Maydell wrote:
> Some of the ifdefs in omap_dma_transfer_setup() which we just
> removed had if() blocks in them. Now that the code inside them
> is always unconditional it has an extra unnecessary layer of
> indentation; fix this, as a whitespace only change.

Confirmed using 'git diff -w' :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/dma/omap_dma.c | 156 +++++++++++++++++++++++-----------------------
>   1 file changed, 78 insertions(+), 78 deletions(-)

