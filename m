Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18423C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 18:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhuEl-0003Kq-TL; Fri, 01 Aug 2025 14:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhspE-0006YM-7a
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:41:46 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhspC-0003CO-9v
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:41:43 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-23fc5aedaf0so15290845ad.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 09:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754066499; x=1754671299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yIEXqfliB1+oonLgDfHyNEDNtRGn8bpzP0dWuMeLXZ0=;
 b=Yd4onsH4FeF++uD3zb+8fRONzBUDh71Ru4rZ2tuo3/NJK7hcIsR51A8RibWi7CX86d
 QDLnJuCHPuIAvW4INslLocsZqUcBJIXzde/RdyEM97StPRcJ8pTmHb21Ge9js+k6BFX+
 hPGfn/Udsi5vc+ejjADgF8yb91ns6YUnap9pS25ygNis9jBPyZngNBZnPMNLQyn0av8J
 NyKMSxavFZ55X/cwBbMEAGXhyvGxXvRL9hHd5J5EhclKlLss8gVNInAi2Ptse5aaLBHr
 ZXnlkaQ0mSDwnjMesDNA9ffWf8DFQszNTqhX32xB3RfepPeakZfIXY9QLHwmh6K0ud50
 rJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754066499; x=1754671299;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yIEXqfliB1+oonLgDfHyNEDNtRGn8bpzP0dWuMeLXZ0=;
 b=XjBzU94G+S9l4MGcqy0v6C2rwtajZBkH/zYN7w4aRBNIYnpCHFa/SbWVm/92pmIo8t
 8HcrRxh+ZmZRqKiMzJPm2ZkQDrv7xfbur+hrbib5+28oCXXM3t62kYxH8w0H+kMnUNTX
 pERLEe256Mx3FsFpJy0yOzlhZazUmp+tXm+/zo07DrZcRaFKpEJtK4VOjJxlpsgsLlOU
 Vxfum3+Abbq4ljGB6wGhl2Kd1jrlrIm+LhrV7GsPQpLnmk6iSMnOU6JL1oijfqPaoBlP
 Tho0QU9zhwxZQ41YvrY4F2UGEJlthnjvVetugMlIcG1Cnm514JO+L4OmcQLhVEhCJrV7
 Q3tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhV7Hz9rCGC1nOIoXFJWy8r0KLW2PiJ5NdQ7WhmK3XCmHbMRgKemI4u+XDAfBlQgoYDLtseZOAXXhQ@nongnu.org
X-Gm-Message-State: AOJu0Yzx75xWtREPwbz3ulPhLY5hNmGnZlshd5NFhDKIHOgIxmehJZa4
 E8HwzJuotEwKGlq3VG4wwapy+8yNe5UyqYQlnub5MLTv/35pg6rCW2BtymR/Rot7OZ8=
X-Gm-Gg: ASbGncvfYhJpL+2JIjmLAqaXltbksfTFQtzYCWjul9QmEQxni+JLPGs67iv/FZlEwWh
 qrYV5ZLvkVSFIp63QpmIEduu40qr7DCgFjI/FvebW/mayI9gKPiLVG3SbKg6BEQRP4hGaQGyaeO
 rQ9PBOdQKID3oQ3X8sDmrGSyfK5KKLXJws/timQCrRL5p5tchNlITxvdY4eUHYxqku6uCDqvrj0
 Yb3kWx8moDWo7SFWuBxu2PjlP/j/nUDU79LwOL0Y5vIzQYJsxSuf3I6tbpqFVl1bLEr2z7TuMcy
 N8P1BUQ1VHTx4jX0AH387/xWDhiNX75WaWCVcLscuyVsMok8DQH4B2i7XjA5TaM9pLlcuA2c1fM
 OaNVmRPi0CFI+CkznrFbEHGk9S2iie9lVDfc=
X-Google-Smtp-Source: AGHT+IH4TpBsILrrVPOsYyGmL6VI9ok49ReVjSDxOZqwPuKHoup13219zsX1eQGEaF9spZtQY2tp+w==
X-Received: by 2002:a17:902:e5cb:b0:240:3ca6:184c with SMTP id
 d9443c01a7336-24247056c29mr2698485ad.48.1754066498857; 
 Fri, 01 Aug 2025 09:41:38 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e89a6ec2sm47356865ad.145.2025.08.01.09.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 09:41:38 -0700 (PDT)
Message-ID: <cedc5b94-78e3-4d9a-bdd8-60c82673c136@linaro.org>
Date: Fri, 1 Aug 2025 09:41:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 47/82] target/arm: Expand pstate to 64 bits
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-48-richard.henderson@linaro.org>
 <b2e40787-6043-4d4c-9cbb-731d0e92e25c@linaro.org>
 <CAFEAcA_9tkv1EoM33=G=zW6Pw0gBirvjs-SsDaC8ar8feyH_8g@mail.gmail.com>
 <2c337408-5caa-4e24-a8dd-d947203a1dc3@linaro.org>
 <CAFEAcA-LmS0dus5ZW6P+-VXkw=m4K3MaE6O+Qtj5i3H7ULJFFQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA-LmS0dus5ZW6P+-VXkw=m4K3MaE6O+Qtj5i3H7ULJFFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 8/1/25 9:37 AM, Peter Maydell wrote:
> On Fri, 1 Aug 2025 at 17:26, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 8/1/25 6:22 AM, Peter Maydell wrote:
>>> On Thu, 31 Jul 2025 at 21:34, Pierrick Bouvier
>>> <pierrick.bouvier@linaro.org> wrote:
>>>>
>>>> On 7/27/25 1:02 AM, Richard Henderson wrote:
>>>>> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
>>>>> index 64ee9b3b56..3cef47281a 100644
>>>>> --- a/target/arm/gdbstub64.c
>>>>> +++ b/target/arm/gdbstub64.c
>>>>> @@ -47,6 +47,7 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>>>>>         case 32:
>>>>>             return gdb_get_reg64(mem_buf, env->pc);
>>>>>         case 33:
>>>>> +        /* pstate is now a 64-bit value; can we simply adjust the xml? */
>>>>>             return gdb_get_reg32(mem_buf, pstate_read(env));
>>>>>         }
>>>>
>>>> If I'm correct, we currently don't expose PSTATE through gdbstub, but
>>>> only CPSR. This was a bit confusing for me, considering that CPSR is not
>>>> even supposed to exist in Aarch64.
>>>> Maybe it's a good opportunity to expose PSTATE instead, which could have
>>>> a 64 bits size. This way, we don't break any workflow.
>>>
>>> Architecturally, PSTATE is simply an abstract bundling together of
>>> different information: it is not a particular format of a value,
>>> whether 32 or 64 bit or otherwise. (This makes it different to
>>> AArch32 CPSR, which really is a guest-visible register.)
>>>
>>
>> I see.
>> Then maybe what we really miss are the special registers associated to
>> PSTATE (CurrentEL, DAIF, NZCV, ...) which are defined architecturally.
>> When I tried to read EL for the first time using gdbstub, I was looking
>> for CurrentEL, and finally found it accidently under CPSR.
>> Would that make more sense?
> 
> I think for backwards-compatibility reasons we should stick
> with the current cpsr format for the information that is in it.

Yes, it's here anyway. My proposal was to add new registers.

> We do at least define the fields so you get a nice view of it:
> 
> (gdb) print $cpsr
> $4 = [ EL=0 BTYPE=0 Z ]
>

Do you have specific pretty printers installed? On my debian trixie (gdb 
16.3), there is no pretty printer for cpsr by default.

>>> The thing that *is* defined architecturally is the SPSR_ELx format, which
>>> is where various bits of PSTATE get saved when reporting an exception up
>>> to a higher exception level (and which is pretty much the AArch32 CPSR
>>> format when the lower EL is AArch32). (Note that not *all* of PSTATE
>>> appears in the SPSR_ELx: for example the SME SM and ZA bits are
>>> considered part of PSTATE but they aren't saved into SPSR_ELx.)
>>>
>>> For convenience, various pieces of software pass around information
>>> in that SPSR_ELx format. Calling this either "CPSR" or "PSTATE"
>>> is not really correct, but either is perhaps less confusing than
>>> calling it SPSR when the context is that of the code running at the
>>> lower EL rather than the higher.
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/include/asm/kgdb.h#n41
>>> suggests that expanding the existing pstate to 64 bits is probably
>>> likely to produce problems. Perhaps we should define a pstate_high
>>> or something for the top 32 bits?
>>>
>>
>> It seems we don't expose pstate at all now, and from your answer above,
>> it would not make sense to expose it directly, as it's not formally
>> defined. What is exposed by kgdb?
> 
> kgdb currently does the same thing we do, and exposes a 32-bit
> "cpsr" value.
> 
> -- PMM


