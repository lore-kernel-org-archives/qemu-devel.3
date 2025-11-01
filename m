Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE006CCFA02
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 09:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF89O-00073I-UI; Sat, 01 Nov 2025 05:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF89N-000739-Ve
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 05:43:57 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF89L-0007UN-RV
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 05:43:57 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-63c45c11be7so5107458a12.3
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761990226; x=1762595026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fKf3k4MSQPlWImX7WdvEM/ppLAmAFMFUs2ufcAO7HeI=;
 b=cagY5Sa5L4Kug4gmYSIPkEW3rHA/BvMjwjbU3Va1wpy5QUIVKn9YDKauNTjPZHLqK2
 ttkZsKvk4XhwSxV7EFgVjkscUTWtIq+NGv2olyGRXmN215nHXA+kxjbrSEAs36NMawxR
 fwZdCYgPJ6LmpAyAgsPcGc85/eY+EZp8ng5kLngfyJexBgti+haXzPra5+/CUOs/SVWb
 /tenFv320GD4OB9ZuUPf1WMIvXfro1AuhRsXTTf63iG1JEzR+jU9MfIrjic1wDB4UuMz
 yzVy+am3N0yyItpLIQMkRlUiaBR6rU9oNzd+qeWvPCsNUS1v1c7hWyE/d+CaMpPGzMVz
 +6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761990226; x=1762595026;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fKf3k4MSQPlWImX7WdvEM/ppLAmAFMFUs2ufcAO7HeI=;
 b=DsJIx3lZ+ajbilFfFmf8wV/2GZ0nrQB4/bA6WHuJy9BkxWZbuuGi0w57IVCqCKr7lN
 KMN9YdysNfV2qSCTZvH9sQjLPIhx/f1O4OF0BPXDm243U3gJlKPMU2Q2UXsdh6pLtwg1
 GoEIFWAYnu76NuzW8kr4xEevFxTRbXPT8usbmjPRfBeRIqrTGuiCUKOatdt2UJ1FqSze
 R9RBFd41O7asZNwXVBV4E7iAEPGb+wGNQsNcATsTqNjNrXyvhBTQdBfD8EbPE0LCPOtd
 kvIhPOC8f2UOK2Z6mBbBlyiHCyASHm86VeK+aGrkeLWe+4HZiuvR1/LviHOfNpFH2eHR
 YixQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVezsHnWJ7wvepNgb5tBIiMQXvbQKE50CaS2lR532BpspwogphuL3Ad1taQNwEH+DIIzVmSaWb6bzP+@nongnu.org
X-Gm-Message-State: AOJu0YwMb7NAf2Wa5YNQE6tgLi0uhq00BFol8Ewn+sG080ds6vncOqMP
 prQciZFN8Tw2I+fI0IQfBHr7urhLaIKppUuVkATur7BqIZSmg/YYkst1+7b1vKV/w5I=
X-Gm-Gg: ASbGncsFejTDXVdH/8mjjqx/0VBX3lRRNzT6V0SHicUPYFmWuzVU/dplKKjVb+AhtHe
 1MWjdddkn9fYg491kGwwlvopWjtqyxcQJoA6276E56PaoHaGxsityb0qb7zdm0SDIEZ4olaQo64
 KBool9WfFyKK67o19y4sUg2PUTgqyJ4XBlmqqE5HCit4DhlZu8vmCZn/6YwPlDMRdotSDdJoZb7
 JfQsRBv4PfcAKc7zSORRfZpaBn80H/WwfYvsXMfgei/dqvqg3xZluEAQS79gds8geA68riq3r13
 gPdwocfChD2oy5ZqvzK3XNAAAJIyODh3SsaS39f9CRs+UJuMwagnuqwMzbABRyE0XOkIpeTelHH
 f068HhkE1s/2rMtac9qbbIGEkqyvvPpSRe5HSMXgUdblynSxP5KoL7LGaAtzlnHq1IbZzVgIkvN
 hm/jKGf8yI5ewoPlyFJkoscilOikEGrnSj6qVASjDHT2nYcM2JHnk=
X-Google-Smtp-Source: AGHT+IFhmf6yoRL/VfBog22/TbOsEgeswhqPqL+pleIcmi82al5aNXIz8Nxvk3vrp/SORSCxWu+29g==
X-Received: by 2002:a17:907:869f:b0:b6d:573d:bbc5 with SMTP id
 a640c23a62f3a-b70705f3778mr581751066b.37.1761990226494; 
 Sat, 01 Nov 2025 02:43:46 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b70779aa9f4sm420861566b.20.2025.11.01.02.43.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Nov 2025 02:43:46 -0700 (PDT)
Message-ID: <1f05a80a-12ba-46b8-9681-43e9331221dc@linaro.org>
Date: Sat, 1 Nov 2025 10:43:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Introduce and use MO_ALIGN_TLB_ONLY
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20251022001741.222499-1-richard.henderson@linaro.org>
 <82f3c305-bbc4-480a-9c73-ef4386e4ab3b@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <82f3c305-bbc4-480a-9c73-ef4386e4ab3b@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52d.google.com
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

On 10/31/25 21:21, Michael Tokarev wrote:
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3171
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> I wonder if we should pick this up for qemu-stable too (including
> 10.0.x lts series).  It's a rather large change though.
> 
> The patch applies cleanly to both 10.0.x and 10.1.x series, and
> seems to be working fine.  Maybe it can be picked up for a later
> release.

I think you should hold off for now.

> What's the implication of this bug, anyway?

Failure to raise an alignment trap accessing Device memory when architecturally required 
with -smp 1.

Before 10.0, we had no support for raising alignment traps accessing Device memory under 
any conditions, so this is more filling a hole in the implementation than a fixing a 
regression.


r~

