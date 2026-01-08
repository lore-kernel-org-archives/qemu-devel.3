Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53340D1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwNE-00032z-MF; Thu, 08 Jan 2026 15:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdwNC-00031l-MS
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:12:46 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdwNA-0000jC-UP
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:12:46 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34c84dc332cso2163308a91.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767903163; x=1768507963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RudaXk6Q5sdMKRR1y0TJ2yEtQLKOGVfHwuB+Wp4A9lE=;
 b=W/h2jSXs/tgHT4GE0fW/1uZjOEvp7NU3AjPRouKhjZtGSivGK7z6nS3FgJiz+VgUh/
 WnRIXg0QW28Cc0tzczBvg5LCQ8fZYJ8lH0Vy1Nx3iai5UoOW0P4Gd5jSSvuSiMpI2Om7
 plimGcaeJgiGP2KW7dPXJig4GByBZZmzOQJ+GAsuJhYf9r13H0qaCPiUGVsDBSjMGk5R
 uggC0n2boVvMe6Kc4IkXz3/2XqDEOILGs25eKD4HIEMYfAVpWRP4F2RQ9/o/ul4C99sH
 jpzowrWnVdcWa9lWHXQpm1Xw/1L9nYQzajwBbb8VcidFudxhyTG4m26eC1/h7XXCcLtp
 Zk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767903163; x=1768507963;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RudaXk6Q5sdMKRR1y0TJ2yEtQLKOGVfHwuB+Wp4A9lE=;
 b=sbczFeUaiNazkBWK1dOkDP6EjjffJ+pYVmbaDeDuj8sDx5CaBW2VqK9UOk1c84TTri
 2eTLu3/0jAntwEI5s3R8XiP2KaABtIv1fIavv2oQb9Ab97w7rNancOcjiPOW639jWE8u
 6tg6ScIgpYwaf3r4IsiZcercIpFcmNoz+xSEKoL8P6Na6Hw0sazxSkpEkyiFU4yE4vf+
 UZVsC2/M9/Id8RXh7bW5RGU7ZHS12BS3Eax9/GeaCFHI16rA3tf1y6x4z5LtQYhUquHa
 JCmhh5vq1kdhv+3HvIyBB0B8/mm7E3ajG3zp/NTrZUCSJxG5bhaWxTAHruCJA8uSET9O
 hbZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpxqdpq4pEr5fuULcp+AL/KaU5tawnhTXSYzbzRrjVrBOrgHGxU7Cg2eYFnW0tjevvK66J9UhSJSr1@nongnu.org
X-Gm-Message-State: AOJu0Ywx5N7fzEhU1ZQbLVUZDUjPEw7ZmpWagF6NSTOKn9oNY4bEKavU
 8gThXiZDB89zY05iNJ68858v0dfY78p+FgQNlg6bjXOXX9RHFFsDRrKWjGMRgnMlJan/7PexC6i
 jrUXzF0A=
X-Gm-Gg: AY/fxX6KjMjNGJllDSydP5nqxQhdsefPXFfd3y5PNRJZSmlVPZhoKK8agY88YHaVf1t
 qa1xcK3uuDyUQycE+gp9l3VFA75UP6X89uI3Qn5hB34grMH83LE8N7/23jw9IZiMiD2Y2jm+YfF
 hQIAITL7s4S1iHPtluLVngxr30lVJ/2GWQM/dxF+76Wie0n8GDUc7llRo6hwtwYAX7ZuvHTog+N
 JMrqZqIoJ6G8ipKff9NWqAmeHv8MBFoNHEpF1DJME5oxP67s6AZVOJlccSzmdu9iWFfEFnURssT
 xtFa7T7OXoWUt0ITVF9c3TAqF3uU6SomShoTnIe9vcaKGlAufOjZBpSCAIOsC/idCQJpQBGcUP5
 1ZW8dzr4+Cxgl6geZJhDKsp7gYMxlOJucK3ZzdNBVqrk/iGN85WWtxgm3PR4ShCKrTbuSIKVEu6
 KXUInYnSsCrYpsAotqxzGBd+Vj8N3GWFJaYkhfOb1u
X-Google-Smtp-Source: AGHT+IEgfcVtoMIvtu5T7ptlalzu2Prp5P/4D+VJ1qClnB7oVB+4Q9HzgZrh2KWnB6eaBDPQQWtg8g==
X-Received: by 2002:a17:90b:5823:b0:34e:6b7b:ded4 with SMTP id
 98e67ed59e1d1-34f68ccceb1mr6152952a91.36.1767903163191; 
 Thu, 08 Jan 2026 12:12:43 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa947ecsm8619830a91.6.2026.01.08.12.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:12:42 -0800 (PST)
Message-ID: <8215be4b-7896-4bb0-8b51-373b7c8eeee6@linaro.org>
Date: Fri, 9 Jan 2026 07:12:39 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/i386/tcg: remove register case from
 decode_modrm_address
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260107151400.273916-1-pbonzini@redhat.com>
 <20260107151400.273916-6-pbonzini@redhat.com>
 <9a0b5cc2-fddc-4c9d-a310-4ff4bc785c7c@linaro.org>
 <41a78ed4-8dba-4a8e-a33a-7b3dbd1b2af2@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <41a78ed4-8dba-4a8e-a33a-7b3dbd1b2af2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 1/9/26 00:28, Paolo Bonzini wrote:
> On 1/8/26 00:44, Richard Henderson wrote:
>> On 1/8/26 02:14, Paolo Bonzini wrote:
>>> Unlike the older code in translate.c, mod=11b *is* filtered out earlier
>>> by decode_modrm.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>   target/i386/tcg/decode-new.c.inc | 7 -------
>>>   1 file changed, 7 deletions(-)
>>>
>>> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/ decode-new.c.inc
>>> index 243df7e3735..7b595607fa7 100644
>>> --- a/target/i386/tcg/decode-new.c.inc
>>> +++ b/target/i386/tcg/decode-new.c.inc
>>> @@ -2024,12 +2024,6 @@ static AddressParts decode_modrm_address(CPUX86State *env, 
>>> DisasContext *s,
>>>       rm = modrm & 7;
>>>       base = rm | REX_B(s);
>>> -    if (mod == 3) {
>>> -        /* Normally filtered out earlier, but including this path
>>> -           simplifies multi-byte nop, as well as bndcl, bndcu, bndcn.  */
>>> -        goto done;
>>> -    }
>>> -
>>
>> I can see that this is true, but one has to dig around to see that it's so.
>>
>> There's enough prep code duplicated between decode_modrm and decode_modrm_address that I 
>> think it would be worthwhile to merge the two functions and simplify.
> 
> Is there really so much?  I guess you could write the combined function like so:
> 
>      int modrm = get_modrm(s, env);
>      int mod = (s->modrm >> 6) & 3;
>      int rm = s->modrm & 7;
>      if (mod == 3) {
>          op->n = (rm | REX_B(s)) & reg_nb_mask(s, op->unit);
>          return;
>      }
> 
>      int def_seg = R_DS;
>      int base = rm | REX_B(s);
>      int index = -1;
>      int scale = 0;
>      targe_long disp = 0;
>      bool is_vsib = decode->e.vex_class == 12;
>      switch(s->aflag) {
>          ...
>      }
> 
>      op->has_ea = true;
>      op->n = -1;
>      decode->mem = (AddressParts){ def_seg, base, index, scale, disp };

Yes, this is the sort of thing that I was thinking.

Where, in particular, the compiler gets to see that bounds of mod were [0-3], and that mod 
== 3 had been eliminated, so that later in the function the bounds of mod are [0-2] for 
those later switch statements.


> but it does not seem so much better...  I guess I could do the modrm
> split just once:
I suppose the compiler would be able to do the same bounds discovery with that, since 
it'll definitely inline the single-use function.  So at least that's an improvement over 
the current situation, where I think the two shift + mask extractions from a memory 
operand probably aren't CSE'd.

But the fact that you felt the need to add an assert there at the beginning suggests to me 
that it really is clearer as a single function.


r~

