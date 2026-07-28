Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16589C54F55
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wolb6-0003CI-33; Tue, 28 Jul 2026 13:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wolb4-00030a-CP
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:28:06 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wolb2-00045a-RF
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:28:06 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso61906a91.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785259683; x=1785864483; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qppXp74RPADVMJza38z/8Z+e3PRii3MiGgbXUq82Nm8=;
 b=EZWvNiOpZtdDfc+K930wImVSmrFUDI/Q4ez0Rl08+Gqxe2XTGR2t1hAcSewkswcLFY
 4rJRKJxwiiLMwg0pyug/a2gM8nlxyXB6ukOJ8mZQ7HgL6816LpJiXUxJ98SDd24qYeeq
 OOe9aa7njogVwwH/moBDNjn47FWwlTBtxnFQK8YRWYrNsOyWkRdfOrx0a7HNkuxW3Egd
 eV+M7PeybpkF4tnExJx10UpaKLI5KZ7kaFTJxCqpRz4A2ny8cWE4XInPb6d5FFB2CLoq
 /s06Mh5LTT15QsxeJ7ha8BviVd4tC9fugTGYGfUzKqTrjXX5B47tbk/WvAij8dPre+Df
 TJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785259683; x=1785864483;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qppXp74RPADVMJza38z/8Z+e3PRii3MiGgbXUq82Nm8=;
 b=mdqTA87qjKrE0pYjO6Rg4dYcPDoWnqU3U7IKIlfbLx4yeHkhrT7PnLl6d00SLgCZ1D
 ANHe7W2XRJX/YCbtykg0J6SntcVkpv0ubdinHEb3sNUBhz/RqI2HrRZSWnbXMqjfrxfu
 F3Losbz05pspIJuaRAZCSNX59r9XsqDBONYF1t+o9/9RblpZjy87mx7STz+wQndDTGQ8
 234XHxkuz3ip+hXL+ImhUIigL0w1WpikDwcVKxQ9Ib2h35o7tuy6/a83LcttGjUb/LOk
 4Rz21j/axrUFKUxB9aw3U4obI2TcdsPI9IG2avYPc4/oCotBI36J0dAnvEwRHrlH7Zlf
 tGOQ==
X-Gm-Message-State: AOJu0YyOcCQcLNSqzfbMI8FkqQtwI7UgpYH4uuC+jFNwTFvlLS83iv4A
 bnhHpuhA3qh20tL16jNOUUYjMSO9MB8xJ+tzqKnB2HrMQ2TgseUfIfq8rdurAT/tkGs=
X-Gm-Gg: AR+sD11s2vHVvvn69tP09g9D14IfWNcYDgMmimePhqfqhWEssEvTVvLbYnLCDOD5rA6
 Y2JUOxjuPQT0j7w3Tt8pXKEJNsL2bIa8LgT08Sbe5ARp6qt5CrR5mIG8/8daj3MxO3Q/EVUMuiw
 DV6xlCne3l+68+E46Zz8YRfkh3Ly2mBcqbI8WZXFddioX1EbFk7XdTTX9i9R6RqfnrOYSrLBIoD
 0zRI6qEDqI2X3Nb3EJvAuyCaURqGQn3xFeXArsAykVfTS+K/+21Ttgqh+JnOsXlkFvIWHWxLFrM
 uGaWsQOpsvHm3FJsypRHlagEKvMSAuqIjrUauHar5xyh0V3ETXWZCQFH454byxOlelWM9zwasVq
 eVkA8SdQjxxRJCnXKLKPaAT8wpG8hd/e/XmiD36AoFLRovkgmv6sBnz6sZ2hYapidf39XqR+T46
 5h2++G/4NME5vH78ApF5r9dSvVDWaaqY4BixzfqX9NEw==
X-Received: by 2002:a17:90b:448c:b0:38d:f1a4:1116 with SMTP id
 98e67ed59e1d1-38f6a5809b4mr3103185a91.33.1785259683085; 
 Tue, 28 Jul 2026 10:28:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f6411189bsm1634666a91.3.2026.07.28.10.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 10:28:02 -0700 (PDT)
Message-ID: <f9920ec4-b19c-4956-88f5-b3955956d939@linaro.org>
Date: Tue, 28 Jul 2026 10:28:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/20] target/arm: Implement PMULL, PMLAL
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-20-richard.henderson@linaro.org>
 <CAFEAcA8SinMnnYyWxzbNsE-B9tB3TQ8KiXQem1KZ9Vt9sH5EEQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA8SinMnnYyWxzbNsE-B9tB3TQ8KiXQem1KZ9Vt9sH5EEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 7/28/26 09:37, Peter Maydell wrote:
> On Tue, 21 Jul 2026 at 19:49, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> 
> 
>> +void HELPER(sve_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
>> +{
>> +    intptr_t opr_sz = simd_oprsz(desc);
>> +    uint64_t *n = vn, *m = vm;
>> +    Int128 *d0 = vd;
>> +    Int128 *d1 = vd + sizeof(ARMVectorReg);
>> +
>> +    for (intptr_t i = 0; i < opr_sz / 16; ++i) {
>> +        Int128 rl = clmul_64(n[2 * i + 0], m[2 * i + 0]);
>> +        Int128 rh = clmul_64(n[2 * i + 1], m[2 * i + 1]);
>> +        d0[i] = rl;
>> +        d1[i] = rh;
> 
> Doesn't this put the two 64-bit halves of the results in the
> wrong order on big-endian hosts? Compare how we handle
> writing back the Int128 result in sve2_adcl_d.

Yep, good catch.


r~

