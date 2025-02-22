Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3645EC021B2
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2025 18:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tltvn-0005gU-BX; Sat, 22 Feb 2025 13:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tltvk-0005g1-B4
 for qemu-devel@nongnu.org; Sat, 22 Feb 2025 13:08:49 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tltvh-00012s-9c
 for qemu-devel@nongnu.org; Sat, 22 Feb 2025 13:08:47 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fc4418c0b9so4886265a91.0
 for <qemu-devel@nongnu.org>; Sat, 22 Feb 2025 10:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740247724; x=1740852524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+uZ3Cl85dAYL2pYAX4KzwHhfawN6Ki/mb+U/TTR1jZ0=;
 b=DgOKz116URHWI00HeZzTn6U6Zk37thhjjN3R6nhpca4jW2o/eU9CWMy8jMmjDfoz8h
 Te+HMlAjayzp5nImIPr74iLV2B6qonIoJ0bHwYum9KoCT2QjDXYiQURyZ+zgcpv6hRMo
 Kaq8cXiyKYeCgRAcp57haCe187DJvWim9RqOPaId/wwE2eGWCh4Co08zgbRMJpjFsXIX
 yLh0qX5Oo+Fj93TH3M9tmKC6IaBNP7ygsMJaGujkqQF/JOdkgAvF2vjwbjL+Hx5TKnw1
 u8jI0/Hw+TEcSoLA6pIwmDlWAoNhobsaiw5aLd/6Kc3nVYAv33vN2RnduDSAMJ0jANcs
 vJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740247724; x=1740852524;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+uZ3Cl85dAYL2pYAX4KzwHhfawN6Ki/mb+U/TTR1jZ0=;
 b=oDBLfxywmzkUe9ccMa+UZ4YLXFcjmOSFcnEy1i8x1aNqiKXaZNEyt2RcFr3TqJERfo
 QRgP7UkS+EcKJjIeyaBY1yQSRCI1OMFNJ/DBoBqpDflSxNE+CameW9akJqgnn1ppOAjY
 HrnvZcyy1ZagBO5+hd6qY8BNCOPYRyZllF4Ukv5eTXFun7WAR7b+qOgvUm98vA/j3teQ
 7DyvdEsN7XHAxJQqSchdjZVTjz7ozBKPSafIBsJBnEWcgg4nrvEw9djomBdRTfSApkhH
 RnQtvtExBe02vA6+bVWQyLBOMicBLqcfbUQFKFRSDid1jSfK7P/FTwfPPqMEyU3/KAy4
 6oDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJLA5NhSwbH7Wd6E6zgVjzSNCZldU1JU40gdjGly54EvwfrjfzxKvv117lhUyJRJNhvBrPnCa0kUj6@nongnu.org
X-Gm-Message-State: AOJu0Yzg4OsFQ5e/BIHXfOoEzFkokbQu5XYAwLQIX33euFM9KT83OmfA
 K46RmsdIWI2gUG9TNl0WYdw15r03r/KUA+MufAJltnaTd4UzeFth8oJ1aP/CwGWdRa5HHXjlFWr
 n
X-Gm-Gg: ASbGncs23o1AiRsCErlyClUIfb/ZGoURISxZ/PawFd/6X0p/LhHEwpCV51He0yAX1A9
 f3aQIb4oHIVOxPWtOO5mK2kgHYESByJv9eWz4GiZtr9jqzhle/PA9aiJj9ZU5PTpaJ/bYA4zexi
 v/CRxTGfDfa8Owvl0EvISEhd4+3tbuixYhx4/oy8v5HAKd6JTIjAa8cSsjYBfLFKH7ArBh5p5yi
 1u5iIWlCQGNp6eaJJQBFBiZoA5w9YWCLpFgrtVXVoLxdDkqCzDULKz8tp/3rLPd3hIlMDlNCLQD
 IeLO7by5bS8koEsXE0+ZvXYjfi9YeYsQOSligBqwffWuMgqmpnKunAi22PzMQQkHqhZrvy8aEgx
 UbYBBoag=
X-Google-Smtp-Source: AGHT+IE4ELe75uVTKHdcw8I/LnhCxqEYQqi56Ee2wE/cJvGQh8yThfL4+W0qaV1IL+aFgbI7DhoxOg==
X-Received: by 2002:a17:90b:548c:b0:2ee:c04a:4276 with SMTP id
 98e67ed59e1d1-2fce77a4863mr11727875a91.5.1740247723714; 
 Sat, 22 Feb 2025 10:08:43 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5585fbfsm155095845ad.226.2025.02.22.10.08.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Feb 2025 10:08:43 -0800 (PST)
Message-ID: <baa12291-ee34-41c3-b2d8-417bf59f287b@linaro.org>
Date: Sat, 22 Feb 2025 10:08:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 122/162] tcg: Add tcg_gen_addcio_{i32,i64,tl}
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-123-richard.henderson@linaro.org>
 <21c3c655-3676-4bd3-9088-8f266d5dfd3a@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <21c3c655-3676-4bd3-9088-8f266d5dfd3a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 2/21/25 07:41, Paolo Bonzini wrote:
> Ok, this one definitely caught my eye. :)
> 
> On 2/17/25 00:09, Richard Henderson wrote:
>> +        tcg_gen_add_i32(t0, a, b);
>> +        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, a);
> 
> Compare against b instead?  If there's an immediate (which could even be
> zero) it is there.

Sure.

> 
>> +        tcg_gen_add_i32(r, t0, ci);
>> +        tcg_gen_setcond_i32(TCG_COND_LTU, t0, r, t0);
>> +        tcg_gen_or_i32(co, t0, t1);
> 
> setcond + or can become a movcond:

For the set of hosts that require this support (mips, riscv, loongarch), this isn't really 
an improvement -- we'll end up emitting a setcond LTU anyway and using that to feed 
movcond NE instruction.


>> +        if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
>> +            TCGv_i32 discard = tcg_temp_ebb_new_i32();
>> +            TCGv_i32 zero = tcg_constant_i32(0);
>> +            TCGv_i32 mone = tcg_constant_i32(-1);
>> +
>> +            tcg_gen_op3_i32(INDEX_op_addco, discard, TCGV_LOW(ci), mone);
>> +            tcg_gen_op3_i32(INDEX_op_addcio, discard, TCGV_HIGH(ci), mone);
> 
> This addcio is unnecessary/incorrect.  I think you assume that TCGV_HIGH(ci) = 0,
> since that's what you set it below, and then this you can remove it.

I am *not* assuming TCGV_HIGH(ci) == 0.

I briefly thought about ignoring the high part, because "of course" carry-in is just the 
low bit.  However, the code emitted for a 64-bit host will not ignore the upper 32 bits, 
so I thought it better to not intentionally change semantics.


>> +        } else {
>> +            TCGv_i32 t0 = tcg_temp_ebb_new_i32();
>> +            TCGv_i32 c0 = tcg_temp_ebb_new_i32();
>> +            TCGv_i32 c1 = tcg_temp_ebb_new_i32();
>> +
>> +            tcg_gen_or_i32(c1, TCGV_LOW(ci), TCGV_HIGH(ci));
>> +            tcg_gen_setcondi_i32(TCG_COND_NE, c1, c1, 0);
> 
> Likewise, this shouldn't be needed and you can just add TCGV_LOW(ci)
> below.

Again, this is about keeping the semantics the same as x86_64, where a non-zero ci is 
treated as a single carry-in bit.


r~

