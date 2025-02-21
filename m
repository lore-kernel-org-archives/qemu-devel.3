Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543E9C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTnW-0000po-22; Fri, 21 Feb 2025 09:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlTnM-0000nu-CN
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:14:24 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlTnK-0005r7-DF
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:14:24 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38f29a1a93bso1768797f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 06:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740147261; x=1740752061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KSMUHQS/GTDe7M2xwkjMwMUEpaJHBy0e2fac14HmH6w=;
 b=BownUWFGWl8iJ8ztffazple/CNHKGVs+HYh/DLdI3ihERadZiB1El7BjKCbxAklGqL
 mmO9iZVyWN/J5xL0FklMmUukSOjl+AmWbT3aTQNONKUNOH2+hZqMxdysnPLJmrIYP6t2
 FkCBZus3YFIDWlLkuVo/HZp37OK94kxoNtB+Q5YAWToLTCIeSMgMIJVBy9oKTYJBx7P8
 pN6SZlGVrCw32pXMLRDIrYARXEq7+PnP8jzcDdft+8iSehhT/OyGu14FimCRQZa6moV6
 CmEyBigg3836KVR4ZY20pC07wQWo5p6zpSUt70J/qp/9r2/8wEZ2R/V0MCirv/MvMIj6
 lnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740147261; x=1740752061;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KSMUHQS/GTDe7M2xwkjMwMUEpaJHBy0e2fac14HmH6w=;
 b=VJAvCjslnkcFy3jv28I4GQ+1Qyraf2S8bLAmoZO4fLx3hXFTgGLG3IZ9iLr1AtUB5n
 SG1LEz2w1ZpXwf/honcHhwxgY4MY3zblgcN6oaCNFrMNVWuahzyZkUszdPH0mhov5ri3
 aVXD1JU7vPjb7OkXIHa4yJnOMBITD+XHcB2kMPUm5cfqmcibYcSHCkyLfk+ccDP/Knj/
 IBmQqjZaFpOhf2DWLQqIRFyhE9xzNt+HIoAJGdbfoFSdHjBN2jjy6uQ1uYQeWC6xG1KR
 X3bG2mJoa1jTLvhavjfnnLp9szfsWWNarHJX24/cP/KCl0NykIopUAPFwnjb81dUBgKm
 H9Pw==
X-Gm-Message-State: AOJu0Yx+lejwNKefZkrVxR32S5EfVhjwZdmUqUU+VlXiihEcX3cLKvNZ
 hs1/ySTeTeQkDuhce/9aYA+hs5KDuaLrFB8a00xlsUEFr45QmcNaRJ2fxg8dWSY=
X-Gm-Gg: ASbGncuscGTbLZDE+Xg1xgOeY02Man2UJuXrCy2kQW/eOSS8p5duoOXnm+ggsXxfmlK
 NddQAsZfCBkEAt3acraEy5VuQM8szk8BmhJN4zJRtFpdCi3OWbZp9PfBbKfFN1II9xRxuR03R2B
 X9kBbtfrwyYp9BGpcrRM4MRdnItrvUByqDyNQRnxTf8Tiv0vT0iseDlQnxt2ILxb6iY2J39Oeny
 /1N2D8Tf3JeITXCJ+f/Gkshc78H/O7x6e2LQLSibxxuDwukGhTknGOl7b0zAtJV8aExQLuDdq8m
 cTXQLo46rTSiHoEh4zFqeZ5485pwlIgSJe3WTrNLdDuM2LOQhcxVd6tnTRhN7IlGSe2nlg==
X-Google-Smtp-Source: AGHT+IFkb8y5Ttw8Vrqn88EyzkSiIrGktvG8jxZmTQI+yfVqkfGS7SALxxlw2iFCM1Qad++B2eNg6w==
X-Received: by 2002:a5d:6c6f:0:b0:38f:2173:b7b7 with SMTP id
 ffacd0b85a97d-38f6e95c4a3mr3263167f8f.18.1740147260585; 
 Fri, 21 Feb 2025 06:14:20 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5e9esm23868019f8f.61.2025.02.21.06.14.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 06:14:20 -0800 (PST)
Message-ID: <57c37ba2-bfe1-40ca-bbe2-79c6da4cb920@linaro.org>
Date: Fri, 21 Feb 2025 15:14:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] fpu: Move m68k_denormal fmt flag into
 floatx80_behaviour
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-7-peter.maydell@linaro.org>
 <64deaf4f-b999-41aa-ae44-876a1860a10c@linaro.org>
 <CAFEAcA_upC=ty1PWXOSsHHgk67EoPi6rB2DhK2M5_q2mzUCW=Q@mail.gmail.com>
 <d7a0260d-5cdb-4e87-b12c-32e1dee4df1c@linaro.org>
 <CAFEAcA_uPWSgwpygQiSBzCLsBV+HH5Pun1E9RGw16Z3SMj4REQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_uPWSgwpygQiSBzCLsBV+HH5Pun1E9RGw16Z3SMj4REQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 20/2/25 19:54, Peter Maydell wrote:
> On Thu, 20 Feb 2025 at 18:39, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 2/20/25 09:12, Peter Maydell wrote:
>>> That suggests that we are correctly implementing the x87
>>> required behaviour in QEMU, and so that the TODO comment
>>> I add in this patch isn't right. But then I'm a bit confused
>>> about what the code is actually doing. Why do we need to look
>>> at fmt->m68k_denormal in the input (canonicalize) code (i.e.
>>> to have different behaviour here for x86 and m68k), if
>>> both x86 and m68k accept these pseudodenormals as input?
>>>
>>> Is the difference that for x86 we accept but canonicalize
>>> into the equivalent normal number immediately on input,
>>> whereas for m68k we accept and leave the pseudodenormal
>>> as a pseudodenormal (well, m68k calls these a kind of
>>> normal number) ?
>> The difference is in interpretation: x86 ignores the explicit integer bit of the
>> pseudo-denormal, m68k considers it part of the input value.  This gives m68k one extra bit
>> of range in their denormal, which allows representation of smaller numbers.
> 
> Ah, I see. So I suppose:
> 
> (1) we should call the floatx80_status flag
> "floatx80_pseudo_denormal_valid" since it affects both inputs
> and outputs, and document it in the enum like:
> 
> +    /*
> +     * If the exponent is 0 and the Integer bit is set, Intel call
> +     * this a "pseudo-denormal"; x86 supports that only on input
> +     * (treating them as denormals by ignoring the Integer bit).
> +     * For m68k, the integer bit is considered validly part of the
> +     * input value when the exponent is 0, and may be 0 or 1,
> +     * giving extra range. They may also be generated as outputs.
> +     * (The m68k manual actually calls these values part of the
> +     * normalized number range, not the denormalized number range.)
> +     *
> +     * By default you get the Intel behaviour where the Integer
> +     * bit is ignored; if this is set then the Integer bit value
> +     * is honoured, m68k-style.
> +     *
> +     * Either way, floatx80_invalid_encoding() will always accept
> +     * pseudo-denormals.
> +     */
> +    floatx80_pseudo_denormal_valid = 16,
> 
> 
> (2) the comment I add in canonicalize should instead read:
> 
> +    /*
> +     * It's target-dependent how to handle the case of exponent 0
> +     * and Integer bit set. Intel calls these "pseudodenormals",
> +     * and treats them as if the integer bit was 0, and never
> +     * produces them on output. This is the default behaviour for QEMU.
> +     * For m68k, the integer bit is considered validly part of the
> +     * input value when the exponent is 0, and may be 0 or 1,
> +     * giving extra range. They may also be generated as outputs.
> +     * (The m68k manual actually calls these values part of the
> +     * normalized number range, not the denormalized number range,
> +     * but that distinction is not important for us, because
> +     * m68k doesn't care about the input_denormal_used status flag.)
> +     * floatx80_pseudo_denormal_valid selects the m68k behaviour,
> +     * which changes both how we canonicalize such a value and
> +     * how we uncanonicalize results.
> +     */

Both changes LGTM but I'm no expert here ;) To the best of my
FPU knowledge:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


