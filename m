Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0AEC0219B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 19:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thCqO-0000UB-4p; Sun, 09 Feb 2025 14:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thCqM-0000U1-GW
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 14:19:50 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thCqL-0005Js-2q
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 14:19:50 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21f62cc4088so27246335ad.3
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2025 11:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739128787; x=1739733587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HJ2+3EgpE5qzVyOKZqgVNqeGrmPIaoZxDlQIrRRPatI=;
 b=tmPEynCUH/PyzZfI4ghNxAMH80w7IV1hhr/n3rKsigXot1AdOTx+aLN54BiU7GDLkO
 +/ww6YK2BXik3HVqxo48/zweZijM0bk2zCbqKHZDKHxjnuSKf1KJL/C049s7CJK+EzEP
 b4p+NatDOxUz1OaGJnGglXns5d/0Zu5XNmEwodsba70OBWHqW+eziKPVLith9jSlojR+
 jdyO/SSiX0+m/GD+Nb+lMVKKkiTXC1BVzFwW/T0aYE3NT1TH5vU0t06Q37LOjvyqM8S0
 xSqF71iCzE3aSovbtO0uA2Roc3fDlWHNsgN8R0x6ICGH47hAdMs4XDoZXLJ0hvAOF/eW
 mtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739128787; x=1739733587;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HJ2+3EgpE5qzVyOKZqgVNqeGrmPIaoZxDlQIrRRPatI=;
 b=tuwlg1rgyTssLmFPt4Wf/hxPZ5jqsNtGYxzV7+sESQmsoDBnbg4ejSzNh4yz5Y4O5W
 a0Tm8Wy14Vh9ahDRfyXE+bAizTWzUo0jaND31okpXxXQiSxIW897waqhDQ2reOI30MxO
 XNU4Td+6ChQM6Alak10PRsjQVjUFADc2dFBYajRnuBDWN9xFcvmwiPCFd63tgN4MVQpF
 kazNRr7QpmuhWiF74aEDG52OGuYep05Lj6AzdfPuCY6tTqeoKilUbtxHGUNKR4NykidR
 mgl+upCHyUCKIOIo9xgNe1Z/6OIeHwGi2IwTrDL65CMFGJ1VvxCr5Yqqj1EdaGnfZTdE
 ZfFQ==
X-Gm-Message-State: AOJu0YyfEXuc6uTZo4M/QOSqKcKK3RMq8qDPcSlJ6aNzIoFhBwO701Vb
 TFq2u51QGSUatNFYrRwQhIRhaiYBcpV94+EvzRz7XP0JpSB/JD9JGuUZ7dl4TTSH1DPVmZpuy9e
 i
X-Gm-Gg: ASbGncu4KCrbKRvbGG8WeWGwinT5mjJ4DwFVTFu2RNWRzGiOflmmOmhew800NLHKTmj
 T+vvs8R4VI3uEeEta6CvUcBi+VLMGWzkB3IMf0RkBqLro+3keaZEFFgPq19XljFgKraG4MWvtjV
 5tL2k7w5GvKjUzAYC+I+3TKlvdgkFfrQsECezsAneGsNClG0ZO4HSmf/JB6gqxnnOqM287Fom0B
 9BEAodxBPjq2t5/1BD+xJVoENQbdcDTmJQeHNR9b8kQkP0m4UjUtNu+W0+0UfsW/j1oJ0JVLGxb
 ipSgdyQVzOKaunoBfTpSZXgqPcLLnwjgbmoR6cUc9SQcp8mv7FI+Ats=
X-Google-Smtp-Source: AGHT+IHHRs1ChtLXZJRTL0fhgB4Rk5MmONAJZR8l9YDETbSeNlXAFk/4mlICfmlRpTylQu8oeigJAA==
X-Received: by 2002:a17:903:2381:b0:216:7ee9:220b with SMTP id
 d9443c01a7336-21f4e6cf894mr208481305ad.22.1739128787146; 
 Sun, 09 Feb 2025 11:19:47 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f36516d7esm63415315ad.13.2025.02.09.11.19.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2025 11:19:46 -0800 (PST)
Message-ID: <96710e26-9cb3-43de-b739-a67670faa93e@linaro.org>
Date: Sun, 9 Feb 2025 11:19:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: arm: sign extend when SSE=1
To: qemu-devel@nongnu.org
References: <20250209025358.43533-1-j@getutm.app>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250209025358.43533-1-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/8/25 18:53, Joelle van Dyne wrote:
> According to the ARM manual, when SSE=1 the data item must be sign
> extended.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   target/arm/hvf/hvf.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 0afd96018e..28886970c9 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1876,6 +1876,11 @@ static void hvf_sync_vtimer(CPUState *cpu)
>       }
>   }
>   
> +static inline uint64_t sign_extend(uint64_t value, uint32_t bits)
> +{
> +    return (uint64_t)((int64_t)(value << (64 - bits)) >> (64 - bits));
> +}

This is sextract64(value, 0, bits).

r~

