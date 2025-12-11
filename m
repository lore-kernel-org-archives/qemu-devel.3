Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E94D41D64
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 15:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTixo-0003Z8-R9; Thu, 11 Dec 2025 10:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTixj-0003YF-9M
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:52:15 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTixg-00030k-Rb
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:52:15 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c76f65feb5so216468a34.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 07:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765468331; x=1766073131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=10fjV400Xl3ahtk5TwH4vP215yHmfg8Alost9+eq5Ro=;
 b=ACTpTcCFb5sPgGw3y4eL3Uq3vgPQyMWDwhIRzCcRzPQ8+jWf7ir45HzBvHskes9Aml
 1LfC0mPVXK2N9q9c87R+g8VBWDAhG3AicWY90ft0dvvAQsr+kvmgIjNCzVLPLhl7LKdZ
 vF8K/TZE6D96AcV2vZFKm+4A4GKwhi93KxNQmJKscd+D9uz3Au4vadVP1fDPBNnt2bKL
 Gqbfene0tHU0Gn10LxDlRBBP65D0vC/p1GZptsPkc/gg4fSJclqvhmSf5/R98JnJGlne
 VYH5qxX79YGQSTHGoutVOuD/8VKqG0VmEKpeCm+qjea2+LxFAwoNMKzhcmuvxT2WOETm
 M+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765468331; x=1766073131;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=10fjV400Xl3ahtk5TwH4vP215yHmfg8Alost9+eq5Ro=;
 b=jTgMIouD4aRL8iMjAdyzVAPeiB3/g/7X6MMCJvm3H5KKnBU3hOQONz1A8TjNag2ohv
 l4uV02rJjMNdE8lhGaIhVR5UMcxhzvNlJdT2qdhTnprAxyPEIBqMDPDByZDvMRy8GlOI
 NsSHEl6szKLzo50KjqfHG7OsSdhRawEQePZTkM0fxUKOh6vHVbNJIemI1cbKfOt1nfPu
 3HGnGn7FaH0iH3KxQ5N6WLsu69XA3NOSBJ9IifMe4+qh6MdYRdvJcWI4m0Z7LvpI7oXc
 +k1trTZxM6oQP+RT3O/RZILScC+ojXpC5DAFywTCgh4c2ERcEayouoRxig4uL5uy9hRO
 szNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDeaYObsPfGrpo4Wmvu30P0OQJKPOqS6ElyYadKNHrzpTgsEG0oZ+GGSPkMH4k0oeYgV0u9oaRq6QP@nongnu.org
X-Gm-Message-State: AOJu0YybsvmYtNzfADxk0g2xkYcLxuhD7WfDzBIya2Kqs6i5XypI03x3
 R7boVe3+btGL1nAXje52t0+u/6FMHvvstotxx5bgAbxBCjufBokm89fL6RaTxmozqo0=
X-Gm-Gg: AY/fxX7HoWlglVlbnA/z8yA1GGEoP/6KtOx2YXHrEzoCLKbVN12zuUTE67O/uqq1OaI
 OPwN6L0VPSOwktY7tBXRd4ssmFEu6rn3OzDwMsMJLODhU/88q4iwI4+4dwiuKa30XYk5XyZmR8e
 +YRqNPSVJw13EX74A1LZhuze50MIIlqyBMBMDwORXvqhSnry6CVtvI3Dfq78fM6/m5u7q3eRIRa
 1INDb6q+WusgT/L1ICEoQH88vtF1H84iL54WYtRlCCtAvU7o1Ko3n7cx90TalvWvH59drRSSZik
 SZ2rdSwHMAx8zry6zv+yf3PnpEouA2FoAqo141zeBKTSr3TJ4/VpttTl6H77ZkWadvB6fcS3ncs
 Zdbd76hZMu92MZ8neIhLWwpR3j9bBs/ObZKDN+mcWRYSqaFjHrkcaVAJDummzIZ+ADbdzDxDziu
 HV5zd78VV4lzK/VKlqTrJ+dlTpX02Epi+jenLUoBvEp+lwA/uU00UgpUyyQLyKZPQDjHnY9+J8Y
 4M=
X-Google-Smtp-Source: AGHT+IGZdFr2PDbjUbb6qfqpRkv9R7UXmglCrwI2tWqfj3braUZ9Jw/f8EaBZPsA/9mMW7hPEiPS+A==
X-Received: by 2002:a05:6830:f82:b0:7c7:5f09:878d with SMTP id
 46e09a7af769-7cacebb97c7mr4531025a34.12.1765468331211; 
 Thu, 11 Dec 2025 07:52:11 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb200661sm1659552a34.8.2025.12.11.07.52.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 07:52:10 -0800 (PST)
Message-ID: <803f0bee-24e2-4308-af01-04bb44b94184@linaro.org>
Date: Thu, 11 Dec 2025 09:52:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] target/i386/tcg: ignore V3 in 32-bit mode
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

On 12/10/25 07:16, Paolo Bonzini wrote:
>  From the manual: "In 64-bit mode all 4 bits may be used. [...]
> In 32-bit and 16-bit modes bit 6 must be 1 (if bit 6 is not 1, the
> 2-byte VEX version will generate LDS instruction and the 3-byte VEX
> version will ignore this bit)."
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

