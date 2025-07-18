Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02FDC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 21:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uct6L-0001Jz-0M; Fri, 18 Jul 2025 17:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucsbQ-0006pE-E9
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:26:50 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucsbO-0003ys-AM
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:26:48 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-748e81d37a7so1765559b3a.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 14:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752874004; x=1753478804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eVqm4Sr+rCv9WURDs+h9I6y/Ain5biy3GAU79mPYkjw=;
 b=QAmSI3N2j4LPpsn4YAsHfQ/re5Ocshl+Lym7MiStQRnrKNchh4nIVLmTpTdRqJ3aYC
 XzMShqB+qXnm7Ybnzvo4h31dewj8C0czcr6E5zbk2nNBigP/6PuXOq6yfJNulcvPoo9t
 bO1ZVVsrXPPic9mUeCREppg/L/boUmHjNukx2ESgPPYk/904UyfDXCEKwkmlS9wrxpbW
 GeKVQecZ0CVUJRoVF65zh14z+t8tziwcV0B623Ai8kr4RlZussqGu+UpbTAQuede6Nhk
 c0FU9vtTqlJni5LK9lTwZ7UJv/UCftyHPjcIyYZETuzyQZZKH8Xmo9BjPTgyZ/17dRht
 aVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752874004; x=1753478804;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eVqm4Sr+rCv9WURDs+h9I6y/Ain5biy3GAU79mPYkjw=;
 b=aFflVGh93aur1u0nq+qh6mwJMDCLLlKBH0ZngyEcRygyOB9noEd8KvI4+Ii/eZrsAr
 MWeUeD94AuopJII4tr4NSHrKxe3vXRHJYGcaCG2yaEVNQpEtBFGBYPrdujPGS5TN/4Z3
 2MU3/jazOcFkrlUpblxc6TRjYD98ygf/0roKWqOmRIFUGIaf9h+/nN1EvY4q2eB3Byha
 05oSUgj5RZwGNwHok2Hf/PPXx+alAmYyPQzETS+xYxPlR9JvAKbbV5r7s+tC5cYrL4s1
 eV9050TqR2zY0os9WSDY/9BvxmKSrcPX5MLXohReOpRocqzeojAFpNIUccpQXtX1JJT5
 FnXg==
X-Gm-Message-State: AOJu0YzahBdD2sAXoJ4uu00a0l8iV8d2IyKhIn5SZCaSCFLVS5bIXqwH
 LRT3GvxOzTRziF4kJBOdkTO3ciKJmu3QiYVVOJhc82AF3jJBlVZERsBVH6EIEd3RHxw=
X-Gm-Gg: ASbGncu8nJbrn8cLBiji/92kz2ZuXtOEawvq/o+l6skVUfJ+SkOgTnERCYGJ11tM/40
 QbX46LAZ3a2ZMhW6EMjAuU/de+JVrkUV9nR1yGZCbwxEwhsJk8AZ94XSMcdm+49M3yt8rm7pRQH
 1TB4eXAXqatNTO7Oly+21eJB/DDiEVwpSVSRc89nIZIPPdZLupmHgtljukul+JOn8L7VB/48rHH
 dZ0PJum29WWU3HxT4vZW00gHiTh6kHH/8qw21IucmYUypqTfwd+kqeLrTy7032e9pvCDguvm74c
 UCzZ3scfmLcKr325qcsir51OM5NlA5Dc/r4+1D8G/q8kH6JKX/6aJXz3xZHnmFB2ZHRn9eEg82y
 JnrnatYcqH5phKgD97UKddiCo3fnYmirMcnUOZcMBbaw3f8wlaGn+
X-Google-Smtp-Source: AGHT+IFAKghjiDNFTB/mfAhCTMy876Lw28wb6VzzE3R63mYgog2K/6Xk8qRT0ckF6/mhS0Uhdn7vjQ==
X-Received: by 2002:a05:6a00:3e23:b0:748:e150:ac5c with SMTP id
 d2e1a72fcca58-759ae1e7120mr6682793b3a.23.1752874003729; 
 Fri, 18 Jul 2025 14:26:43 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cb1569d8sm1764857b3a.93.2025.07.18.14.26.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 14:26:43 -0700 (PDT)
Message-ID: <18195a7d-132f-4556-9f92-d7d241170619@linaro.org>
Date: Fri, 18 Jul 2025 14:26:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1] tcg/optimize: Don't fold INDEX_op_and_vec to
 extract
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org
References: <20250718173832.47820-1-richard.henderson@linaro.org>
 <CAFEAcA-nY-2YrZQg6seKzhqYvKc7Adu_xZVsa380KL1XJ4AuJQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-nY-2YrZQg6seKzhqYvKc7Adu_xZVsa380KL1XJ4AuJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 7/18/25 12:11, Peter Maydell wrote:
> On Fri, 18 Jul 2025 at 18:46, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> There is no such thing as vector extract.
>>
>> Fixes: 932522a9ddc1 ("tcg/optimize: Fold and to extract during optimize")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3036
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/optimize.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tcg/optimize.c b/tcg/optimize.c
>> index 62a128bc9b..3638ab9fea 100644
>> --- a/tcg/optimize.c
>> +++ b/tcg/optimize.c
>> @@ -1454,7 +1454,7 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
>>       a_mask = t1->z_mask & ~t2->o_mask;
>>
>>       if (!fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, a_mask)) {
>> -        if (ti_is_const(t2)) {
>> +        if (op->opc == INDEX_op_and && ti_is_const(t2)) {
>>               /*
>>                * Canonicalize on extract, if valid.  This aids x86 with its
>>                * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcod
> 
> 
> How does the fold_masks_zosa stuff work for vector operations here?
> The masks are only 64 bits but the value we're working with is
> wider than that, right?

For vectors, the known one/zero bits stem from immediate operands.  All vector immediates 
are dup_const, that is, some replication of uint64_t or smaller element.  There is no way 
to represent (__vector uin8_t){ 1,2,3,4,5,6,7,8,9,a,b,c,d,e,f } with tcg at the moment.

Thus we can treat this sort of simple vector optimization as replications of uint64_t. 
Any other operation resets the masks to "unknown" state.


r~

