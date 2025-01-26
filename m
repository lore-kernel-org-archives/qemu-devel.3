Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24C8C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc1pW-00023C-D6; Sun, 26 Jan 2025 07:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1pN-00022P-2K
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:33:25 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1pJ-0005dr-D4
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:33:24 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21680814d42so57266905ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737894800; x=1738499600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JcK24c0M/leDHmJUQmX5reQwmJwVJoz5iZc99to1ucY=;
 b=Ro3BPl31XzbCUNo53YR7fm58BRPzqNv6p9G0y5wfd24stafoifkpPgTf7nQZm6se3V
 xKDLLRKLLEwAWFMDxzS7qqiu62DCfI3Mda+4z1MCjg3COPTyqAgqUPwNa+2GxmXpoD30
 ERmuW7+Q7Ltr/CrOsXFWuCQCbU3rhtts0lEd9Rfrxolbu5nacFh8eA7RlcRw8l8qrzRc
 /f9/GOxtyDPnDWo366uKFk75Mza6arLklbXLomj8r0Nm1JC9xcylF9Soc0m8W0gO7RlY
 NSQhHVkOnvuLpbOQV2aMaLMZHr6uCw36RWlaE1+YfJZM4CBANVfP/uS3SnxHi50mVlVX
 6x2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737894800; x=1738499600;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JcK24c0M/leDHmJUQmX5reQwmJwVJoz5iZc99to1ucY=;
 b=sBYDfh9S1mQu/kj95wwMarzmiQZoLKn/0KqPLP7AWrDMu9809Vod7tJ8ZM9TFAa9LZ
 I7AfQGs0vlYmVEW//dnSf2twYLbESNtjNy0XlgXOyyCSQiOXrkclNlyoJIMi9Fw2Y/L4
 5rLSD72OaX86j5YmxeKkBK4tXBdsmreAOH2dOcLlfOl69NODqbDVEkcymN3FwciXOp6U
 /xhbFcvScMXLYau7vscTsqS7jNGJSSYW2vqrhj1SneR6+X4MTsYrJLphtt9u2VVwnEpq
 76sgczFhiQJJpSl1CfOvoSdQUjP+5wU+ta3O4jerv7bLVcJB2ecU9/hEcXDnaXmKPwec
 MUcg==
X-Gm-Message-State: AOJu0Yz3vapW1O58HpMjCwplJjWj6R4fDRYtsDe+d36VSnkvsmTYgDB5
 de7vOjB8T5ynldhjEcSojIITzOvbrS60qfqUO8PYI30MxoXBtmHTZsYYyUjn9nYrYS9kGjkpOuO
 3
X-Gm-Gg: ASbGncvqz9XI2n7qyd1ZfMOomvugFMITCt3xzYS/vCHFm/vEGL1x7g9VkVUrqMrPGFe
 0fMXsG5w+1MAyseFv5iiEWW5H/TtkPS+znPvdChIr+GN7yG9jeQK12qMHrodhhWorG4tdDUL53o
 8wDsIVSfgsJsGeo/hiHvsztoNkK/q/Vl/rvGSA7jdezzf1czll3FScZp5tg2kCFJO6qCit+rm99
 CTJYcubdhqH/YGCHy5Al4h8umV+zE77BKOn+7mKLBgm8G+D1nW00vNojKSBaqKO4go7Dc7XN0fX
 NCKBPPthT0t85wUsCkI0ouE=
X-Google-Smtp-Source: AGHT+IHfNKaQZ8quUQkEmB/g4yYeCqpFb7V4bsMFWprN15e1xSVOKdimm+fI/y9CA85P2TzMm+Bs7Q==
X-Received: by 2002:a17:902:da87:b0:216:501e:e314 with SMTP id
 d9443c01a7336-21c3540d181mr543909305ad.20.1737894799722; 
 Sun, 26 Jan 2025 04:33:19 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3d9dfaasm45721385ad.45.2025.01.26.04.33.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:33:19 -0800 (PST)
Message-ID: <a0f0e9f7-29e0-4642-887a-c002ecd25a37@linaro.org>
Date: Sun, 26 Jan 2025 04:33:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 40/76] target/arm: Handle FPCR.NEP for 1-input scalar
 operations
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-41-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-41-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> Handle FPCR.NEP for the 1-input scalar operations.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

