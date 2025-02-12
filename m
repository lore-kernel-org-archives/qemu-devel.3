Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6C6C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 18:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiH4I-0000l5-VW; Wed, 12 Feb 2025 13:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiH4G-0000hp-Gt
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:02:36 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiH4F-0001Um-4F
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:02:36 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fa8ada664fso76513a91.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 10:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739383354; x=1739988154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j11+pggoZt6LWKb7cQUYM2QCVz6453x541Imp61mDT4=;
 b=xIqlu+o6Pj6qbRxiGNQicBCaZNRLpP3eGmFYy69k7rZbm41HnxWoxsov2nQb7jrmH7
 ZKfE183Dklw87M+ADDPZKSNMONSSUfd4p5AwVwIwvhiXuIgMdVfiNHVwpn2+vTQfBvoj
 fpQaEER4PLPXeE6Pb80adZ66ye44qMRDzKerwx1HEToc3yMF4MZOX4pq6i38RB2eSf0B
 wWz0PfHcVfn994YZsh6JEa7+1VrLiu7B+ilN2E1IpJ2R9pGy653iaHRc5Bi+ePxPc6m3
 KAhzEPKMFjvYnO2QnrAzLIyXQNTsIhFnudHF8brRDGdY4mFxXWL0SEG2nA0dBjrxW1ip
 3Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739383354; x=1739988154;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j11+pggoZt6LWKb7cQUYM2QCVz6453x541Imp61mDT4=;
 b=OZFNv1NQFpMUFG6I7esjb6xt71ZFm0nZfoh7tdWhvVM6drRJegeBSxhu1KxNFLQvnT
 lwMv1ONqFQSp9S86xZt1gmIs7XlR4GJfDPZPo5crJKnB8Mfzkwoh1w1UxUvljRlY06eP
 2CoR3zUTSa3Z30yLRQ6P73RkalbJi168hUDgkohIDcYBD+tge0VzjxaZNIZMNvIhTCdl
 S+pwdpMPWbdFs1ImlGQAKehukkkK403pXqDl/gL3IZZgrkn0rRkvHEU7RPkw5onIBZse
 iZKN+niMJf7iZgEy5fZhW6x6chXJmIz+BiLy7KKiej4xvEFOQpxgC3xDPPYrzRhBgHFK
 CSMQ==
X-Gm-Message-State: AOJu0YxpXvTDmEN9xzE0QJn2w6Mv7t5cSdgi0p4FX8WT3MqIaQCuRw6O
 l7DHqqMjTmTWFOVWaW67cNm2SpnQ+1q83IpAmV+AP3Cpr7Ds7boiEz16RSVvGj0skMla0L33ewn
 u
X-Gm-Gg: ASbGncstvEBOycL9BITocUBkUfHoY24PTjPukNbfuEugbGGq0Wp6YeeUPiuh4HL5ags
 F4YR5mYpR0Tju8AIMuhezJWATupqxoPtA948xeYN+IPNDCYStlhcVT6NzCnBHPCtnTZGCoYARzG
 nT8UwTNkuTZtsscF4jGaJCo51XEhmIOBkJsfb/+5Z4CJf+9BN0l/9d1J6B/KJWcWPJeOWu2YF9R
 dbE5gtSAillqidClJObsM7WxwrFxzu/FiEBSSD6yQZbajQk4UqzrusoISmuX4gI9YLBDTyGHddR
 PzLMC17rDtDRAdDpBcnRnQm1mGzgdv0yVWRb9eJpwWri01JLwKNKOPo=
X-Google-Smtp-Source: AGHT+IGRznOnkaUBixmdOpHK/Dhy4eb5kgRr4lkQ3Sal8BkhF+sRd0z4oySsHYT67RNFX5PFfYTIag==
X-Received: by 2002:a17:90b:518d:b0:2f4:43ce:dcea with SMTP id
 98e67ed59e1d1-2fbf5c580c0mr6358861a91.25.1739383353434; 
 Wed, 12 Feb 2025 10:02:33 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220ca43f1cesm5312515ad.37.2025.02.12.10.02.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 10:02:33 -0800 (PST)
Message-ID: <629a0227-d917-4bf2-b723-626a5be6a2fc@linaro.org>
Date: Wed, 12 Feb 2025 10:02:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] hw/arm/xilinx_zynq: Replace IRQ_OFFSET ->
 GIC_INTERNAL
To: qemu-devel@nongnu.org
References: <20250212154333.28644-1-philmd@linaro.org>
 <20250212154333.28644-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250212154333.28644-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 2/12/25 07:43, Philippe Mathieu-Daudé wrote:
> We already have a definition to distinct GIC internal
> IRQs versus external ones, use it. No logical changes.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/arm/xilinx_zynq.c | 34 ++++++++++++++++------------------
>   1 file changed, 16 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

