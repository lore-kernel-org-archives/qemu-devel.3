Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883C6C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwL5K-0007sy-Po; Tue, 18 Aug 2026 10:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwL5J-0007sD-5s
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:46:37 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwL5H-0007Ng-Ju
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:46:36 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso4763269a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 07:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787064394; x=1787669194; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rvnci27srpaHU+0zql/InTn5LYvBRiMkG3J7pdDpi4s=;
 b=xPLlLbDkQ5RWvWZx84CUmEb+qFECJbOQDQ+4sJey9Wf3gF6udfV27QPA1Z2KzgJh1I
 Sriky5bpdjAFOoWtbilk39+b1otKvnQrnbRYPK7u4mzlx5SmHs7V4BMziNNmu0PrvteG
 5DFUo///XJ9chgAtQnTevPcuvw54yz7UGuNmZGomY4gmkZQi0Y3s0S5zzdd6TRUBsVkX
 e8ibHg0Dz8l1Yhk6kzJzhizCz/2qRNFAgd1bJ48dq4d6mtdvZ3f5Bp7ltYrfj12dO8Zh
 IAXjGjWnrwMxI1PoeoMQfnk6PAZMC4DUFzBkIqk6nbuieV/WZy56DVd3c/CES3XG3GgH
 M25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787064394; x=1787669194;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rvnci27srpaHU+0zql/InTn5LYvBRiMkG3J7pdDpi4s=;
 b=pZUvJmntcrYWMa+m0V/m2eaA3ud2PFFmTk/sbfKNNDFTe/ZiwbHGNv5NFH6r/nKfnT
 ana3X52uKvccE6rmXiI7lhSGhFnSBTXZCtq4oouMCJ/sFdbqakHVEAKjeFV9fEDZ8nNZ
 8WbRzXUTkPUZnhjlz8APudvyMy4meP8z57czKtYk6T+y+PrTfXIs3NZePPqieg5hSff0
 mLcXFhImbh/+iL4I41AHtfP4u9IIjHAyrUdnEmY8yec8+xVgEBqac2spqA+nzRt9hvUX
 VGpIYCbCJ29Ix+4YMYxWObKLPoG62EBA1GYNWYu5IyqvbHrL4+wJqbHL/CJO1Y6eRA05
 Ywqg==
X-Gm-Message-State: AOJu0YzJasItc3PolJ8NAz20qk19GEzMHX4vk5wYobHgZNYrkCIeR2dJ
 hMeLSjQUROMFOIC6hJjGV9XZ0lOFwLoFIALoUY+GqG3JUh1e0BXDY+uKiAasj+ZGrHc=
X-Gm-Gg: AR+sD10Fm0J+Pctw7lRe4xWHESMNxEV1YSox16YUliYwaT4JOI071LIvUrAqub5/9cf
 x/FD97HaRpCsQH/HDJ2nzMb4yt5gD0MRkoiPAbw8hQAHaeLFnWTrBQKiqM5sd+21sQAln3vtlbJ
 mTQoHy62FfIZyjmGEJalDR25Y+8pmQScK+aFdSZ5IAMggoED9FbREU3Clezv5PPEt4t9AkaK336
 45k0ik4ZiOS2kXDF1SISkF77yuwr7+jXPiTTpo1ITcXhhph3p2ikHhy/bfeiNS1coXNriQZDblN
 e41KrSk26zcWz7vB+ZFz2GtQRBAKMDsKqP97ip9oGpD0vYFbdlmrkKiqEWjmF2fVTmy1M7J0n6i
 nK33XRkhoD8JMmgIzkdEJFwZ9TPr4C9OgItCPa4cCFjo8jUopLMRSOIvc4VIrnk0FgfztQ/6psB
 M4xRz00sEMeZYY+cNYUOpY7nhjfqc5LFtdl5rNGeEDp1ws6BpeeBHEm0BlP+++NFmIcww6wbhDU
 x+IRQpEBOj2XgPF9Ek2P5U4lnOjrLfJpEJKDkxsK5xCp2U=
X-Received: by 2002:a17:90b:1d8e:b0:395:4290:46e0 with SMTP id
 98e67ed59e1d1-3955a5de3e9mr10164023a91.5.1787064393743; 
 Tue, 18 Aug 2026 07:46:33 -0700 (PDT)
Received: from [10.213.131.227] (c-73-181-156-132.hsd1.wa.comcast.net.
 [73.181.156.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395320229f4sm8475571a91.15.2026.08.18.07.46.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 07:46:33 -0700 (PDT)
Message-ID: <8bbe8781-7d25-4456-a41d-703e34d07e04@linaro.org>
Date: Tue, 18 Aug 2026 07:46:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] target/arm: Separate cpu types max-v8 and max-v9
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260812204435.295067-1-richard.henderson@linaro.org>
 <20260812204435.295067-11-richard.henderson@linaro.org>
 <CAFEAcA-xY3cyQYCvwLeFj91pMnG5FkhbgJmAYoF2VGCqssLSKg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-xY3cyQYCvwLeFj91pMnG5FkhbgJmAYoF2VGCqssLSKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 8/17/26 06:56, Peter Maydell wrote:
> On Wed, 12 Aug 2026 at 21:45, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Do not include v9-only features in "max-v8".
>> Do not include the prohibited v8 features in "max-v9".
>> In tcg mode, define "max" as "max-v9".
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> 
>> +/*
>> + * -cpu max-v9: an ARMv9 CPU with as many features enabled as
>> + * our emulation supports.
>> + */
>> +void aarch64_max_v9_tcg_initfn(Object *obj)
>> +{
>> +    ARMCPU *cpu = ARM_CPU(obj);
>> +    ARMISARegisters *isar = &cpu->isar;
>> +    uint64_t t;
>> +
>> +    /* Armv9.0 is based on a minimum of Armv8.5. */
>> +    aarch64_max_v8_tcg_initfn(obj);
>> +
>> +    /*
>> +     * Armv9.0 does not support AArch32 except at EL0,
>> +     * therefore indicate EL1 through EL3 are AArch64-only.
>> +     */
>> +    t = GET_IDREG(isar, ID_AA64PFR0);
>> +    t = FIELD_DP64(t, ID_AA64PFR0, EL1, 1);
>> +    t = FIELD_DP64(t, ID_AA64PFR0, EL2, 1);
>> +    t = FIELD_DP64(t, ID_AA64PFR0, EL3, 1);
>> +    SET_IDREG(isar, ID_AA64PFR0, t);
>> +
>> +    /* v9.0 prohibits FEAT_DoubleLock. */
>> +    FIELD_DP64_IDREG(isar, ID_AA64DFR0, DOUBLELOCK, -1);
>> +    FIELD_DP64_IDREG(isar, ID_AA64PFR0, RAS, 1);
> 
> Don't these two lines need to go inside the relevant
> GET_IDREG...SET_IDREG blocks ?

I thought it was clearer to do all the DoubleLock stuff separately.

>> +    isar->dbgdevid = FIELD_DP32(isar->dbgdevid, DBGDEVID, DOUBLELOCK, 0);
> 
> ...and this line is setting a field in DBGDEVID, which isn't
> accessible unless we have AArch32 EL1, which v9 doesn't.

True, but it's there and leaving it seems wrong.

Do we want to explicitly zero all the isar regs that are supposed to be missing?  I know a 
heap of them are still present, as the describe what is and is not available at EL0.

> Testing, I see that qemu-arm and qemu-system-arm don't have
> "max-v8" visible. I think they should.
Ok.


r~

