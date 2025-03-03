Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69996C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3gX-00028N-Qe; Mon, 03 Mar 2025 06:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3gS-00026x-2u
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:10:05 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3gP-0004XA-4V
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:10:03 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bbc8b7c65so9654225e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 03:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741000199; x=1741604999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H20jb8Y7PGopPbVM7zMvowlVLfa+8EEx2bZiZsE+96c=;
 b=WUdIjxu6NWoGUYZKfi2lQp5VgzQyavis20vBAqWAPjjCQXZoIC1iuyCdAK6/Z6xJVK
 hFPU21bZk3ZDV4fHqukggaJUqDzP4IRiq4cPjq5dp4DhLr064P66XR1KbRz5cDql5pan
 Nnjf3tK9Pjnevm+SxVYWEuzO22/VoJZJWpaoMezgPV2pnVq7uMpuPmDakqXl/fx9QbLw
 I6nNSCV56YnfwqUxtB1UONgnJg62Tk3S7s4IRug7CYBl+b7Ig0TOF3w3wy1PzdEtOQN4
 dGB0unI34OlJ27HPqVP3z5e4tjJgLMGVmD4d9yS5SWSZzyHgP1GTCwhpZLskh2lHQKM7
 AwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741000199; x=1741604999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H20jb8Y7PGopPbVM7zMvowlVLfa+8EEx2bZiZsE+96c=;
 b=sXzZDNPJrDWWRRPnpeh567kp/4rqtwZZkMOhYQuRBlnRYnFeN7Dx8efwg0V1v7F67a
 KtRKLIbiU0CG4OvRx/zuOn7rhM8JgEbi9MpNIyaXH7gxjvnVPtONExtQK+JjtbMwJ3dp
 Q5ZX+fyXcWmQmkNMFYuvh45cWgmGuxu1sgMjU6N3UuOVG4yOMr9zbfYalq1p+8MTkveI
 VB0r7qSMN9OffG6/cxkR360Xuna7r2+OgmU09xYawSJGHcmYHZdHzBuqpRr9MMaKdPLD
 nbwQ4XpQXnP+JwllxYqciKy/HGrYYkyYDnKZxWqHDtrkJ8Er28J6/u/4Fofr9UE1CmMH
 pTkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuwrzyxvZXG+2du8XRLYMvnV36RB2cWDtJVb1UWMA59KL6A2Iyhlx7SwHt3YqU6EMpldoEJ8avWoVD@nongnu.org
X-Gm-Message-State: AOJu0YxveY/XdV3wW3n4IjpIfC4PZnJAq2WP80DFVnYRSGjWpJEwEasa
 gMg4bknMqgVwZYpdgzePemmoAGEMEou8K+cDdpPXkZ/cRNP+nnbO02UGChbJogc=
X-Gm-Gg: ASbGncsjyeEZPg3xmRZnpzcza5rbkGdnE4j97xGyIy6N6S3Ip4Nd08647RjHIuTRa16
 vTfcwmd1yPm056Xhh8vHO1Ar55P7wY9BbHDPZkWhSUFXBPkhiMbydW04uNciL7Xec3K4hQCUc/+
 HzxmT99uDYZMdBu7MZbwcSxWdbf1Rhxc/z3fmP0wMzLf+vFcYyKi5um76AYUIk0j41woVzrKw1O
 oRm6LAAjTTxVy8dT/wGVhrxADpd22PS/lvDErlXP6AcqLvy+TuJlWaSjVlUSyh5sf8AqwyhRJo1
 dw1mhU3eyWSgOrnHDMJZQ7oo+oY7pqId4x3N/sVVu9QBiysw5glsdnLoY4dY4fBr1kt1GValfAL
 LNslvbrKR1Ozp
X-Google-Smtp-Source: AGHT+IHABYneg+9LLodEUA7/8SBkfNcJHrsQsuVTM1RNp0fdXkg71K1ZWrdKBFAu2a5xHURR2qxdHQ==
X-Received: by 2002:a05:600c:c09:b0:439:8c9c:6d32 with SMTP id
 5b1f17b1804b1-43ba7490a9emr128737235e9.13.1741000199126; 
 Mon, 03 Mar 2025 03:09:59 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52b97bsm184614425e9.8.2025.03.03.03.09.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 03:09:58 -0800 (PST)
Message-ID: <6800b228-a343-451d-9e69-e40a881d9682@linaro.org>
Date: Mon, 3 Mar 2025 12:09:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/fsl_etsec: Set eTSEC device description and
 category
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250218155407.838774E600E@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250218155407.838774E600E@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 18/2/25 16:54, BALATON Zoltan wrote:
> Add description and set category for eTSEC device so it shows up
> better in -device help.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/net/fsl_etsec/etsec.c | 2 ++
>   1 file changed, 2 insertions(+)

Patch queued, thanks!

