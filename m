Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21583EEB577
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8leH-0008Op-OS; Fri, 03 Apr 2026 17:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8leG-0008OA-Mg
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:01:48 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8leF-0001OO-6E
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:01:48 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b0ba3bfe16so25998295ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 14:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775250104; x=1775854904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PvMNywnOxM1Ko4lHRw2mrBmkIQW+MXUABB15WTDxuP8=;
 b=WXiT6R0LAngUzDWzFe9/otJOp1fUc1p6nHZcTimsvFDZOWzEoUYn5shlJxy5sr+SQZ
 lFRy9RkqOX/pRm7H9TUcIVP5foQt0KkUS8jE+TjMbkr2FtN3rKRPGrym0gY0EA5Pdcac
 rizvN0CmOwU2rEvzJoJSpmVx4xfqw7Pt8oZf2P8LFPgn6E1TTdlYBcfpx6rFagEuknCO
 lnQlQ7keBqNSdzCJonzDF2cyIEOM83VdUQEDSCk5KKg7xSPPY5KLpyNBkoU66pALD7I1
 JN8APzGl5GJn/8t0jtyBfCF2GeJ30vb9r86KS1vOMWMWE+ORls7k7BSxWTS9gQIRUCOw
 rCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775250104; x=1775854904;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PvMNywnOxM1Ko4lHRw2mrBmkIQW+MXUABB15WTDxuP8=;
 b=ojm8dA2Tr4Aqj8L+oK+XeFWX/HbZmT+A/U2eXSM8F0jGuncG6dArh9cdZSQYnNriLT
 PmKHShkf0/9NtuV/pE0ajRM7QjHv8pquzD2QXXyitMiaWRsumgle+Hf97FZQkUrSvpPq
 RYTZyRXC9EeqD4KJ8OijBq1hl7ehFL94I2wqMrf3dfvvy83XoWP4IgbDPX1MRCWezeR7
 sWAY4d6bKDkB2xJw6MOm9i9dFgZcmkIE8A+lrpQnN0prqXVBFdgGPTj7vCQmWsIZMEK2
 0wed2HqkUXWG47RdnnyuMvFXeB8cEeqN+FtvHaU/OtLxdKKle5bRN3+bljcXtzFG/dBO
 9x5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV66jTNnT35u805MQRU+8insGmrmmmINc8KRAdFEAQ/gwWoCFXVYofgDKnAWTTUOeMfcVWH98T9ehZa@nongnu.org
X-Gm-Message-State: AOJu0YwnGJmwZxkexW9md1DfZo4AkL2v5siojfOxg8qICjE16nkTwvuJ
 /rNhuHenp/0K48ut2oxMOgbHOqfIjmp7Tlb7X0O8By5FYfXpk4toV67hc4FecWqAiJA=
X-Gm-Gg: AeBDietAAuH9D9rzJtFLnNG0HNj8z2Uuusb5HTZRXxAffJCCTCDnWLlDd/PUtaoF30q
 bm5OqKda+oMDI+vodyjMVThxbqnF08oNpgBuqPD6Occ0o7Flq3vJWUgLP0he63Qv6UdNZqoxEz/
 zq2K5qDfueUq99S1BNQgmblQds2wPs8/qn3XCxokQl6NDJAaHwxTjHnJenp4L4iT22euEw87QqF
 Ww6u1D8zt64c2+XwEASUnx162bF8FUIscpTY4g2W4Q/oFYbDfNuHGk2ZeN+aRL7EQzk6agVGws6
 JbGM0DIfyiym1+IMm1sr9AmlNfxjiit9DV5lcWU+/DlhlxPm5X7PXP3Xdbsw7B3bpGZw6THeYq6
 JGix9ZlolhfEjxhpf26hXUK4m/jVNEo9WTY2KGCPD6Zn08EdlDICy8gQmd89F0HVd2u4wIKzdIG
 if1sefbPsZetkqs1FQy1jgK1YKzIMw7EQ3vtAyiUNEr9ZCbNAnn2gTTZAdlnamcflTOVo=
X-Received: by 2002:a17:903:4b03:b0:2ae:5a38:96bb with SMTP id
 d9443c01a7336-2b277d633f8mr73464105ad.2.1775250103756; 
 Fri, 03 Apr 2026 14:01:43 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749a4791sm64169935ad.66.2026.04.03.14.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 14:01:42 -0700 (PDT)
Message-ID: <77bdb8a6-fa99-4b15-8466-852f20b8d52c@linaro.org>
Date: Sat, 4 Apr 2026 07:01:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/12] target/arm/tcg/translate-vfp.c: make compilation
 unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
 <20260401192057.1182724-6-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401192057.1182724-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/2/26 05:20, Pierrick Bouvier wrote:
> Generated decode files must be duplicated between user and system, as
> they are generated in private folders per libs, and can't be included
> otherwise, as meson does not give control on output folder.
> Indeed, meson generator is a different approach than custom_target, and
> this is a limitation by design.
> 
> They were already duplicated between arch variants anyway, so nothing
> new here. They will now be compiled once for system binaries, and still
> per target for user binaries.
> 
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/meson.build | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>


r~

