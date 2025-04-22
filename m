Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EE2C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 18:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7IgI-0002R2-Q8; Tue, 22 Apr 2025 14:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7IgH-0002Qg-1h
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:49:17 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7IgF-0007bw-2M
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:49:16 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22409077c06so77358245ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745347753; x=1745952553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MZY1GrGlyQMWy0DvALMVJra6yRbTMA+o6Fn/TJiylTE=;
 b=kKnP5CyJ/nFuxX+l3vMFjXEwflpHyL7YHKNRHYapU/TOmQFuth8kAqBON0nYm8anm4
 P/sLb/UKfueBGZd2YNFB6IMm8f+LMnnJTyuVtqykGJ3X2H0zAph0XtnflofHR6PUhrdg
 IbDPgC9Fjy0FJBUuBoNjXktg8YLwyEx4dTPVAdNugAkFk4i+G0nJXg8Webp4s6+zqqCv
 QbkRWvfIfTBKWnBhIitdWeM3b7kEV2WgQYhWgKex/OLrLA6I1idkXCu54NgCCufKvrjY
 grQV3XFEk4kvGHZPUjZ3bs7cX/cjIJ8sIPeZ4J1Oig0ICNl1+2997xEwD6GHHNwQn048
 lvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745347753; x=1745952553;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MZY1GrGlyQMWy0DvALMVJra6yRbTMA+o6Fn/TJiylTE=;
 b=xEH9PAonnOATAFeAZDJj/9FnKOcYx5qwUqmy1lXws9JW679STDDUUgSd9u/MSsu5SM
 aNcKs3yYX+gjHjwhHQCqPpjZoeSwkluPOSrqJi8cpGzy3tnID3NP5Rjxsivyb2JaAPAX
 u7ub5Wi+J2sN4Zw8D83UIP1/8QLi7y5JKecygdYabIWVVtiKk4M2WiXHpqekyn4voMS4
 N0ng/JmjZhjVZtrkOiYOAH+WS4D/qzgiYhv/1LLrmvXzbA5xR4/YMHrPff7gq2Ll8ffH
 DjygVRzevsMMrBEmwB5ayKhPPWXpGs/RDDg+yBSHxYk3Wo//SRjezhefBqevgpkLaiMT
 oGzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHWt3QET+wv7CrRxDMVXBe9+4F8Qd2Tjfz64Scbl+S9hcW4b62jW11LwHeNP+95G8F2+J6QsOmE0W4@nongnu.org
X-Gm-Message-State: AOJu0YyPp9ZPofN8Ukc6Iemc6/uMBI0zKMEcr9XARysUn+Mo1aPo5RYU
 lt/HSYNT5QYMlFSw1fLAerGwCT3ErJ4X2aiGqBFIA1a0UTo7hLHjWt4pdqOq7SU=
X-Gm-Gg: ASbGnctVlcdOyhk8U/1Libo5UPNCoLB9gA0sbBBlB7vRM5Iw9mEjFYqtur0T8y1GFnx
 QP2zCowy/UXdKUTXDWT2VbUR/c9QYndzbZjkqv56sxYA7cWPqVaUkcK0jUQyFhXs0x+uyAdWrdZ
 YUypcgj1ISyoFHoi+sVXf4yd4/oaPYAHBnomA4P+Q8KW/lcmNJjm8DXZ0dui+2VPJGgl9QYOXG3
 HQn2R5gLKUJlKAya9RFVC6u64TsklbTO3aWxJ5TmUJkhGO0JOSNzbuS1CzVkzV/i3OtEBSCfoSO
 FWSJC3AbOcD52KbbRU3xvG5HsXefV8aI9TSiHluuYqARymuDA7I3Ig==
X-Google-Smtp-Source: AGHT+IHCApRgLfIxL/Sct1kVzpXNY85PrYBBLDk3jSxMyis45if9iIUCxlNmqXlETP95qyDs2sCtfg==
X-Received: by 2002:a17:902:e742:b0:224:a96:e39 with SMTP id
 d9443c01a7336-22c53568406mr252066745ad.9.1745347753432; 
 Tue, 22 Apr 2025 11:49:13 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb5354sm88286375ad.154.2025.04.22.11.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 11:49:13 -0700 (PDT)
Message-ID: <9d81cb7e-8d20-4c16-8409-231498ac86a3@linaro.org>
Date: Tue, 22 Apr 2025 11:49:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 13/14] qemu/target_info: Add target_aarch64() helper
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-14-philmd@linaro.org>
 <41c9061f-ffd8-47a8-b2e8-7c4b2a2c2fcf@linaro.org>
 <ff7cdc09-f11c-43ae-b1e4-668c39db3efe@linaro.org>
 <3242cee6-7485-4958-a198-38d0fc68e8cd@linaro.org>
 <87tt6g91fq.fsf@pond.sub.org>
 <f5e7f82e-4a97-47e1-bcf5-67a9c72d9572@linaro.org>
 <87y0vsxdfd.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87y0vsxdfd.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/22/25 11:24, Markus Armbruster wrote:
>>> Effectively duplicates generated enum SysEmuTarget.  Can you explain why
>>> that's useful?
>>
>> In terms of code, it doesn't change anything. we could reuse SysEmuTarget.
>> I just think it's more clear to have the enum defined next to the structure using it, compared to have this buried in generated code that can't be grepped easily.
>> (git grep SYS_EMU returns nothing, so people have to remember it's converted from a Json, and that naming is different).
> 
> Yes, that's unfortunate, but we don't duplicate other QAPI enums because
> of it.
> 

Fine for me if it's the consensus we already have in QEMU, no one 
mentioned it until your answer.

>> IMHO, DRY principle should not always be followed blindly when it hurts code readability.
> 
> Treating DRY as dogma would be foolish.
> 

I agree, alas, it tends to be treated as such, even unintentionally, 
when people spend too much time on the same code/file.

>> That said, my editor is able to find the generated definition as well, so I don't really mind reusing SysEmuTarget if we think the code readability is not worth the duplication.
> 
> It's not just the duplication, it's also the conversion between the two
> enums.
> 
>> However, I think it's a problem to compare strings to find this, when it can be set at compile time, in a file that will have to stay target specific anyway.
> 
> Converting from string to enum at first practical opportunity makes the
> code simpler more often than not.
> 

Sure, it's not what is done in the v4 anymore, so it's fine.

> 
> [...]
> 


