Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2F2C369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 21:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7hJe-0000jV-Qc; Wed, 23 Apr 2025 17:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7hJa-0000ij-2y
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 17:07:30 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7hJY-0006NX-Cm
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 17:07:29 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-af589091049so158343a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 14:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745442446; x=1746047246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XX8UNeUYoHrGWL2VB9+ZdXc8oDz80p2+4IzWArGzMhQ=;
 b=w6WlcNQOUUnpd/UINw/iR7lBRp+QeaU+ET7sERbpmNfvRTu97pK84Lf4eVdF3JegSA
 4AiNIG0/tuERz82YjeGX2erERH3fkAYdy6tLi7iiICS8yiE8JeTawBEONJbyRebjsE6L
 CoAI2pkKZk7bKSYp1UD2F68rXNFNTTRYqbrfw8DrdnP7EjsGVUO89+xytWGUp53DVdUM
 EnvxeLiW8FU1ADScAX+5tzFnQiGf4s4teKja2Z7/eSSjuls2cyeU/+MVc3mEWT8PSQru
 fFJntXNiDqsgNvf5KAFrF1SWLbeoDYpwZpyhv3sAPSmJ0flgkOTcBygsMcr6a1pQtGCq
 JZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745442446; x=1746047246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XX8UNeUYoHrGWL2VB9+ZdXc8oDz80p2+4IzWArGzMhQ=;
 b=dCVEE54qgJdc7h30ZkGjiDUwH/XcprEaobXDJ7CX+A4bzjI9zFEdHash48zJdcuxZ8
 BLrdXwxC3IJCGduZnRqEdRyowYcHHDTyBKyFmOgL6sQA+7uQAOkxEMAUPqnJsCKJMWZP
 YZ4Fzw97hQ22TEsL4XMZdJjf1EWXQ46lDm+MmHY3hPIhLWd0EJZOUsaUUy83mAxuRrQs
 u5eaVlWiDaDJhjDrdSXBbYmEpo6+5pNi8mhTypdCEgiV90pO2wEqMDDvaI2tw18RMpUQ
 y1VbBEiK4C6jhhF3wQjT6OCx+6g+eQ2lATtXFGE60Hxo9fudDpdDkzVypYg/tCUI0+9f
 t/eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAEqDxiFRBxZBxak9NACVG3HlyS/joOEbg6SFpeszHcbndosMxZ36QyfmB//3C2ICCoBVZuKEZoj+d@nongnu.org
X-Gm-Message-State: AOJu0Yy/TxbMHzcOC2YL3SotxRN4sK4C0cuFefFoZrdEDWFaRaRA9GIc
 rBK/IhpysqATCJv/3cQUrZjr/NsA9/tfNKpJ4b3uy9ld4VKf2rquq7zS/Aeczt0=
X-Gm-Gg: ASbGnct4ojfeKdqNUcax4RcjdBO+W+Ke1ynz+X06JsBCABs6At4VvjmNvsRgM5vy9ej
 J1rZYnCFH3nR40RZOEdWws80YGJsPw88ys3/jh6iQLJOawtPg29kLdujoSEYrtnGGwfBtyeOqXP
 wMuswN0eVFC7aHZrkiJ9C2/xWuwVxgzftIIQhi7/Kajel2DkV4ZcQL/AYHyY3I0IKQV6v90eaRT
 +hr98KXEOpuFt7eCCfXOh+H2uUoSqz+225s0iu9bGXMyUmyHYQQ2HjnnBr2SZcec03878u1VUjU
 xE6w26Y0RmlXzaq5RYha4u0h9gKzKRwWSv8fjhVcxyOsF0hIlAUGGSvDzGSFUW9VIlLDAjpJ1sR
 FPE62Vi4=
X-Google-Smtp-Source: AGHT+IFx3objwjuz0SJr7OOjvPDM/gIcxStMH7VDr/2Xwmv+xYvUD+XXtoLvG5kLRnFpx7irMUBDtA==
X-Received: by 2002:a05:6a20:d706:b0:1f5:77bd:ecbc with SMTP id
 adf61e73a8af0-20444e9b3a8mr79931637.16.1745442446503; 
 Wed, 23 Apr 2025 14:07:26 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25941bddsm27687b3a.69.2025.04.23.14.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 14:07:26 -0700 (PDT)
Message-ID: <a1463f24-83f3-4226-8862-607618005ce3@linaro.org>
Date: Wed, 23 Apr 2025 14:07:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 064/147] accel/tcg: Pass CPUTLBEntryFull to
 tlb_reset_dirty_range_locked
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-65-richard.henderson@linaro.org>
 <071a47a7-bc91-4f1b-8901-fc523444ca14@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <071a47a7-bc91-4f1b-8901-fc523444ca14@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 4/23/25 03:03, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 22/4/25 21:26, Richard Henderson wrote:
>> While we're renaming things, don't modify addr; save it for
>> reuse in the qatomic_set.  Compute the host address into a
>> new local variable.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/cputlb.c | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> index 10090067f7..5df98d93d0 100644
>> --- a/accel/tcg/cputlb.c
>> +++ b/accel/tcg/cputlb.c
>> @@ -882,18 +882,16 @@ void tlb_unprotect_code(ram_addr_t ram_addr)
>>    *
>>    * Called with tlb_c.lock held.
>>    */
>> -static void tlb_reset_dirty_range_locked(CPUTLBEntry *tlb_entry,
>> +static void tlb_reset_dirty_range_locked(CPUTLBEntryFull *full, CPUTLBEntry *ent,
>>                                            uintptr_t start, uintptr_t length)
>>   {
>> -    uintptr_t addr = tlb_entry->addr_write;
>> +    const uintptr_t addr = ent->addr_write;
> 
> Can we introduce 'int flags' here, and add the CPUTLBEntryFull
> argument in the following patch?

What 'int flags'?


r~

