Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EBEC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMkw-0002ie-J9; Thu, 03 Jul 2025 12:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXMkt-0002hj-Vd
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:25:48 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXMkh-0007Iq-IF
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:25:47 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-407a6c6a6d4so62529b6e.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751559931; x=1752164731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iuA9MTMi0aNFWovQAIYAzCslGaCVz5WTerEbR0coeMw=;
 b=G0uxV/Iryxe9k7FQyNnn3sgHap/fSEJYIAP4lIOzfzF/32OCYBOOsmFGP+kj+HV7O6
 XmyvBWSj1pFLoSMoMkNikfBGGnzPtBB1Xa/IHwYwJ+0jQt6eZ0wrIXoX5QLx5wPXt8oV
 /xpfZAqtIBW+zIafLmZj9gzqMc2M6raoP/+YeP3xq+EBU5I53UZ/4jeUZCAXDyaxF6hu
 anUD6eSAaEWzbxR2cAaPvSFz1EXbDiNNVHjCyNk+8z1EzazHQ/arOwXF7unXok0FBZcZ
 bRf77TqT8Qo3VwJX/lt3dSyKCFf6DE7Jf4+2dfeXXs8b/C8DStKFxtt1RzsfeVMu6heo
 7LVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751559931; x=1752164731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iuA9MTMi0aNFWovQAIYAzCslGaCVz5WTerEbR0coeMw=;
 b=HPdBncZBM6QYedEiwK+9BS813RTeejp0LfBgOcp3+Uhjp8FGNe//C9Rt2BawmxRLMa
 iBNQLvyLKOvWtxusGM5UG4dtfvRKUrVf3oYq/8d4uoq840aie7K41XyBaOPfKIRnaksO
 nJWdxtIx1Fmv9b6jUeLAKiz5Q4c8pzne3+CrbUOtCJy7vyadB8z4IMMYumxzkZl4ozm5
 acxrW2GptAVUxtEUmGuPjpnkSQd8+cVhW0gXcaqfhp10gfxI31nCTG1HsI4G+eHzvKYh
 ptburSB3AWiVPMUr3IyPH2A68H9y1QWEGYVfhKdKGTWqwMFUWckj26MLAz9l1Wb8TlKr
 SJzA==
X-Gm-Message-State: AOJu0Ywz2qONdJkr3Dt8lenOwy7NMCB0sPKFJmBfFtcEgcQTkuFvcHrE
 t5yex/Fhg5mSu7DE4x+sY9NdBWZrTLsXjLLinavW+xX2cYx3Yp22J6AZ0Qwua6MVI2o=
X-Gm-Gg: ASbGncvIbqrIXwP2AmbGrSKI4eZqwNjA9uRP4mQXg/urytAWQiXQPXE3q2110zdIaON
 0vRm7rtXzhUYYIYUBXrVX4eZkptm3zXulz/3hUBUyAzz7I8AjFP24XrrdM3IdCh49hYvJMIOlkP
 kbRo8Sgc7y/juqBSsWNNZVyA9ngoOJ64w3t8z2lvvfbVEQzQ8GJDqc6fEh6l8mwyhZGNtIIQqMv
 iBASyKePY+Wbv/vMBdaDaR8r1/ctQ+BJu11Y1XnTkNz/a1imRt9Vi8ZL0ckgzR49AdO25gmVyw3
 4fee/pBmgINKMmyTme8OKyEcVtpIjtMbbn89T3kkX1p4iGfGNRgq9GDhCMQWI2/feYFOAxHmIZa
 nIrnoBSBiPVo=
X-Google-Smtp-Source: AGHT+IHiWGk0ej2oEfekoak9qb/NDGMDMa7XjuE+5cqVSvh81hGgE5NwZtnE2JC8t6xItURmzFlMuQ==
X-Received: by 2002:a05:6808:1691:b0:40a:532a:7102 with SMTP id
 5614622812f47-40b88789c19mr5626321b6e.16.1751559931383; 
 Thu, 03 Jul 2025 09:25:31 -0700 (PDT)
Received: from [10.25.6.71] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b3243dd8csm3031351b6e.47.2025.07.03.09.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 09:25:31 -0700 (PDT)
Message-ID: <2767ec10-d08d-4de0-95f1-3362e2acf15e@linaro.org>
Date: Thu, 3 Jul 2025 10:25:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/97] target/arm: Implemement SME2 SDOT, UDOT, USDOT, 
 SUDOT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-32-richard.henderson@linaro.org>
 <CAFEAcA8szLP4mEvkatHhbBJzU5A6w0XGcMRRJYr_HPSNgZmU7Q@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8szLP4mEvkatHhbBJzU5A6w0XGcMRRJYr_HPSNgZmU7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 7/3/25 03:45, Peter Maydell wrote:
> On Wed, 2 Jul 2025 at 13:34, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> 
>> +/* Similar for 2-way dot product */
>> +#define DO_DOT(NAME, TYPED, TYPEN, TYPEM) \
>> +void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
>> +{                                                                         \
>> +    intptr_t i, opr_sz = simd_oprsz(desc);                                \
>> +    TYPED *d = vd, *a = va;                                               \
>> +    TYPEN *n = vn;                                                        \
>> +    TYPEM *m = vm;                                                        \
>> +    for (i = 0; i < opr_sz / sizeof(TYPED); ++i) {                        \
>> +        d[i] = (a[i] +                                                    \
>> +                (TYPED)n[i * 2 + 0] * m[i * 2 + 0] +                      \
>> +                (TYPED)n[i * 2 + 1] * m[i * 2 + 1]);                      \
> 
> Don't we need some H macros here for the big-endian host case?
> (For that matter, the existing 4-way dot product helpers also
> look like they won't work on big-endian...)

The logic here is that all columns are treated identically.

...a0... ...a1...
.n0..n1. .n2..n3.
.m0..m1. .m2..m3.

vs

...a1... ...a0...
.n3..n2. .n1..n0.
.m3..m2. .m1..m0.

d0 = a0 + n0 * m0 + n1 * m1 -- it doesn't matter if n0 or n1 is at the lowest or highest 
address, because it still gets multiplied by the corresponding element in m, and then the 
two products are added to the sum that is addressed the same way.

The existing 4-way dot product uses the same endian independent logic, fwiw.


r~

