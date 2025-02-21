Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C6BC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 22:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlbRg-00035b-Vz; Fri, 21 Feb 2025 17:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tlbRf-00035N-6M
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 17:24:31 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tlbRd-0005GF-Gw
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 17:24:30 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-220d132f16dso42782185ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 14:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740176667; x=1740781467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=czQ3in2NRWV2IjVUhes+vRjYztN+niZPh6IYd5ETZO0=;
 b=D2hZAJkvxxL+jAOV12low0b5n25XZfN3z2BBNZbOtKfgOIk2yeIMhbetW8NulbK67Q
 WxH8lMRKmzMb4+bl/ddaMFCDjWroR82DybOiPO0pUN8LmqIer1+NJcSjJykrJTgMylrk
 /B9WukhploA5suOsYReT+8kluQQ1HPAuKIZp9AJwhqyxwVBtPZcrIs5Dhq3wreQrukNo
 arzrN6BsnO0vyZC4F3mnOHcfPs0R3zQq4Qdm6HxfvyOz7mQomFVfx7rbAJS3UdqFstZe
 pkYji3XmDPw49nSFE65RMAtRNwGuj7MkavtACUdbWpTygOPpeJL6kh/np5dhPFt550R9
 TSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740176667; x=1740781467;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=czQ3in2NRWV2IjVUhes+vRjYztN+niZPh6IYd5ETZO0=;
 b=AlY571SjVgs1sw5vrb+OpEiQRIzXCHxxuLI0iqcXs+wKMfwdDFVonhwb3uTcgw2sxg
 zQP6nZFc1xAinWJqUxuxJOa8mbf65m1T1PxH8RpPDuRj3eG6cr5lRwAWJ0DF9v+Zq68w
 7iY9+2WJXRS+zsa1WEU8ahF9bqP7G8HNf78knb7ePScop+Y6NTwlOpJzrgsj/8o6H5iP
 MvwxdkUO2eb4G00p0fEargvigySvQsI5NGIj3Ku09z74VrRRPRqIVrxkHecu8AEn1D8g
 BD3U4gOP9F4JAX3PZBulVZN0H0+oe1VkVGGhB0RVwXdLPlYcyCiio2gm+XRh+n4DEFXk
 qKBQ==
X-Gm-Message-State: AOJu0Yx+3fFQWiOsy1fTcb4T881EZCqM/tc01fCfQowPP2k+GDCXvSro
 t2wLpZ2vTDtV2DHW6a1RfyGo6kAP3Aw2ORhXvkL834LVpdp00q9nV7VgCPGKElE=
X-Gm-Gg: ASbGncv7tL6MgrKM01PqWUiaqJj5hyN46ta5KYPUL6RuqhBSX3X3nWO5Sf5v47cWoMh
 eH3Q/lWEqruBJfchTrQDpZqme2wOYWyLkSCRHhkORasE+N6JOxh3rtu4nZDhW8qKyWU4DqrsX9n
 N0D4Lk2kvF+rAGjDxUXL4yUHqoaCvMlWL2VRLNcSDZu4x4achlB1uA4Ka3a6ghKa2FUAbTLLaBj
 sByFCyy5oBmN3w2kKVvqLW7AswJZJIHkzYGSfasI0b9HYwTPDtekk3LGj+xFWCRJBPFxA+WcI/6
 kpjhRewcQOkjMGqomg/0MgQ6MKNc3Ol51MKOHNMz/bKdB1DXDc6tLGXdM7nZeETYeU1nMoAZgIY
 SeHgdt88=
X-Google-Smtp-Source: AGHT+IHnSL1C/Luo8T6JDVf5gG+hTfYlM2bkWNNX+7+Uj3zHVsMCGZRzoUq8C3JoRkyUgB1ZsFf0JA==
X-Received: by 2002:a17:902:e80b:b0:220:e63c:5aff with SMTP id
 d9443c01a7336-2219fff351bmr82713475ad.47.1740176666820; 
 Fri, 21 Feb 2025 14:24:26 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d55963b5sm142372955ad.249.2025.02.21.14.24.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 14:24:26 -0800 (PST)
Message-ID: <ca0f219a-71e1-43fb-aa82-8db282c7a512@linaro.org>
Date: Fri, 21 Feb 2025 14:24:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] fpu: Move m68k_denormal fmt flag into
 floatx80_behaviour
To: Peter Maydell <peter.maydell@linaro.org>
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
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_uPWSgwpygQiSBzCLsBV+HH5Pun1E9RGw16Z3SMj4REQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/20/25 10:54, Peter Maydell wrote:
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
> 

Looks good.


r~

