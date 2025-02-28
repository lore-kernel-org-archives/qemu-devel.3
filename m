Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52872C197BF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 00:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tno5j-0007xu-4f; Thu, 27 Feb 2025 19:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tno5g-0007wf-By
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 19:18:56 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tno5d-0003sw-Ql
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 19:18:55 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2211cd4463cso30330535ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 16:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740701931; x=1741306731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+IgIJgHuUK+F2p+uThMoUAk2YCMJpN74jZllake+BnI=;
 b=sxkIHsu6uON7qaZ8iD2mCgfRG3g2Fqzkf1ilEaOoqowatw+N8Xq4V7V93/6XizDu6j
 yWrYcYTJJ9CgtT5/WPwr0EMGUkCuj8QqQZhobxZASqYAXlFQGY4fc2Xm7llJqAlWA501
 w+frOQua2tRM8GSffgCZ9CXW6L+WrMLrBB0suwKYroJH+U4GrFDEVeTt5ZAYAWyibcB3
 2jl/hMAk7FmSboBiy+p6WHsTquG8dYf/O3IfsJX36sZ2GwmmYxB+2SOLPLSt1bCA/cPL
 vD95yzEl/BNl3YocPZ8sxPg2zLF+T0D85olqZUzJoASoAPqXqkvkz1dAE5VKblORLR//
 2xHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740701931; x=1741306731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+IgIJgHuUK+F2p+uThMoUAk2YCMJpN74jZllake+BnI=;
 b=S9YGJ0/O3jIedYJX7GfgnmDUwP7lvgcBigiex+LSeY4Bts24fGf0UYRp7aGTzVZp+X
 V6GvMk7nsmBJTbMTfkGgHqz9SbOZvkruf4AYJVoUoh23BmHLlVax5U/787JI3KUGy8CQ
 H4Q0dGprLHPVM4fIJLmYWyjoitjLgUgALkFgWDdsyKCKQLUD0yQMC/0bMRQyGYLkb65M
 cPqEnsoXQKLHX+DIHiy/462GwM7vnjxr1bqjXyF7fNFpOAPm4qq0hiK7Op9E36LUVknV
 Yh911VJI/4JzQy9Wc2KpKaT+z+nNVvrv2uFow3XrB2pD5ks2sZMyV3baOWspHCVOstxR
 w1hQ==
X-Gm-Message-State: AOJu0YzndnJ6OaxTG7p3G6d9iTV1sBZitwWlqkyYuReZj+RAOkQ4VQDe
 7QZ60+51eMO71unU0lOXUQLIL+ZqaLjOyKrWMKBA+O6sIgAwlx8OZAP3btx39AU=
X-Gm-Gg: ASbGncsvLMqPHThedoM3/Uf85pSFoE3ElozGcmwWeYtcqwEqEXb9CU5dNPufFhPJoLb
 6ccYXsgjcQU86Y1Ve7wNYJQmiXWbkz1X/hg0FXcuTkZBmzLjgs4fLYLFr7l7QRWeih1tc5M27Tc
 29Hg80E6pZFpJtMP5XBmOw8zZe5+DgA3keXX7gUjDguV1D4MKYd6XdPQa1wgIICTpURS13Atjmn
 7tbFK0VSacDPIC3kMUap9VR6eOpqSs3dxzpeLKJhe2jEoSpej8LN+YxzCcZNT1A9XYmuxmknTbx
 1avgVH0zwLtRzyzm1U71yFg1XFF1ht10WjTL/a6Glnl4U/JNCKWmTNydW0kR5bV3kSyOWNg6v+1
 3/LEz3b4=
X-Google-Smtp-Source: AGHT+IE+oCx4fMmNrdpiOjUd7czQ9aaPNmrbpkqqbBB4Q0cRX6kfHXiUeoSPEAP6ZSv6/JV1clFjmw==
X-Received: by 2002:a05:6a00:1914:b0:730:8f67:2dbb with SMTP id
 d2e1a72fcca58-734ac3832fcmr2292315b3a.13.1740701931315; 
 Thu, 27 Feb 2025 16:18:51 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a0024d4bsm2452535b3a.104.2025.02.27.16.18.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 16:18:50 -0800 (PST)
Message-ID: <05633317-0484-4595-94e5-c7fddbb2d283@linaro.org>
Date: Thu, 27 Feb 2025 16:18:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/arm: Correct LDRD atomicity and fault behaviour
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250227142746.1698904-1-peter.maydell@linaro.org>
 <20250227142746.1698904-2-peter.maydell@linaro.org>
 <69ae459d-90ff-441d-a039-ae3ee15c919e@linaro.org>
 <CAFEAcA8=P0hJz45RFEBQX7QySR6+RiDqFA8BS8HF_k-m9BdZDw@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8=P0hJz45RFEBQX7QySR6+RiDqFA8BS8HF_k-m9BdZDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 2/27/25 09:58, Peter Maydell wrote:
> On Thu, 27 Feb 2025 at 17:41, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 2/27/25 06:27, Peter Maydell wrote:
>>> +static void do_ldrd_load(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
>>> +{
>>> +    /*
>>> +     * LDRD is required to be an atomic 64-bit access if the
>>> +     * address is 8-aligned, two atomic 32-bit accesses if
>>> +     * it's only 4-aligned, and to give an alignemnt fault
>>> +     * if it's not 4-aligned.
>>> +     * Rt is always the word from the lower address, and Rt2 the
>>> +     * data from the higher address, regardless of endianness.
>>> +     * So (like gen_load_exclusive) we avoid gen_aa32_ld_i64()
>>> +     * so we don't get its SCTLR_B check, and instead do a 64-bit access
>>> +     * using MO_BE if appropriate and then split the two halves.
>>> +     *
>>> +     * This also gives us the correct behaviour of not updating
>>> +     * rt if the load of rt2 faults; this is required for cases
>>> +     * like "ldrd r2, r3, [r2]" where rt is also the base register.
>>> +     */
>>> +    int mem_idx = get_mem_index(s);
>>> +    MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;
>>
>> The 64-bit atomicity begins with armv7 + LPAE, and not present for any m-profile.
>> Worth checking ARM_FEATURE_LPAE, or at least adding to the comment?
>>
>> Getting 2 x 4-byte atomicity, but not require 8-byte atomicity, would use
>> MO_ATOM_IFALIGN_PAIR.
> 
> Definitely worth a comment at minimum. Do we generate better
> code for MO_ATOM_IFALIGN_PAIR ? (If not, then providing higher
> atomicity than the architecture mandates seems harmless.)

We could, but currently do not, generate better code for IFALIGN_PAIR for MO_64. 
Currently the only place we take special care is for MO_128.

> For the comment in memop.h that currently reads
>       * MO_ATOM_SUBALIGN: the operation is single-copy atomic by parts
>       *    by the alignment.  E.g. if the address is 0 mod 4, then each
>       *    4-byte subobject is single-copy atomic.
>       *    This is the atomicity e.g. of IBM Power.
> 
> maybe we could expand the e.g:
> 
>    E.g if an 8-byte value is accessed at an address which is 0 mod 8,
>    then the whole 8-byte access is single-copy atomic; otherwise,
>    if it is accessed at 0 mod 4 then each 4-byte subobject is
>    single-copy atomic; otherwise if it is accessed at 0 mod 2
>    then the four 2-byte subobjects are single-copy atomic.
> 
> ?

Yes, that's correct.

> I wasn't sure when reading what we currently have whether
> it provided the 8-byte-aligned guarantee, rather than merely
> the 4-byte-aligned one.

I was trying to highlight the difference between SUBALIGN and IFALIGN, and perhaps didn't 
do adequate job of it.

r~

