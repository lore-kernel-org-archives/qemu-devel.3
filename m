Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA40E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 23:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUwyG-0005Fx-Ir; Mon, 06 Jan 2025 18:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tUwyE-0005FX-Dq
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 18:57:18 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tUwyC-0001Nt-QB
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 18:57:18 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2166651f752so19162905ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 15:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736207835; x=1736812635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g9249Rb3/lcMv2E/jajTEtt3CpLk0+HhoDHVJDgUKAc=;
 b=C4iqUo5awHWHeBdVRNnHd3fnCdfZ1IjV2wJWqAUoso4D6Ra4X4ScZ+E7YTr0AVMjI0
 0t2cm+I87MfHeugj5+59e2ckeI7hcE9Swsr0ZK1iqnH8Fno8LTKj4jF57LZQ2R79lHUA
 Qf1MUpH9srBlbS6NqYJb4pPxAGt+AaKyBJXPCYUfxr5AAJ9Tb28T1KYY6q0NXlP9y+AC
 F4s26tSUSxriFseXOym/OMRsU/sDP8xevtzLzbh82sfVW69ms8+ButbpQO3ZShwDYLP9
 dxFC5yVe04FiLjpynv7bGGhM5K7ZywW/GPunW29VARWg8KJtwdRCVxjcVHHHZyc0bhJ2
 b6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736207835; x=1736812635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g9249Rb3/lcMv2E/jajTEtt3CpLk0+HhoDHVJDgUKAc=;
 b=EyAKJF/8rj8gnKMgxM+f1+UB5/vmIyxYTvlKMRdd84o6JYiJgjyLpeDzd1QnPkMjJb
 p7IQdNYnuXQIHXwd8pitW+DvNAEO8+GrxYHfg0fElHh2IcQKCdXXsoUbnAirgQ0lhMNA
 6by+51onUzWjewJMEwQewoQmJLmFA0LJ6m/8gsZHZ8q3nDXnbsiqPmqYrkaNngkPe3Xf
 E1WK5nZI5kDOHnNwFUulZllEParjECseI7DKK7JIlEjsJKpKkcQSbktWmE64btt4hfdJ
 owQ+lo/G9+L/BC1ttwTDdry0FWUoE8cHYCsZYW5iDXkFXDFLORCLwZvxZnCnQHBPYYHG
 JyIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTDcU4kuxtlZThmMMAAH+oZA4APSj6XItUGRvQAe2Si6QPamno36xJ70bkAv83F73Ngqqr4om92a0k@nongnu.org
X-Gm-Message-State: AOJu0Yx+64yfHz42WrMzgbdHwoj6mJqBI4BE19cyxxaTkaoN4sZeDhFO
 yEKUsd1MglJKG9HAT31SFT2LjwFfE2BMSXpfp005MljJO064TWVXeYbYSJ2uM/g=
X-Gm-Gg: ASbGncsws32yb+Mb6JyqsMUb8SbAWYClVwGa3m0KAqre/b/hWSulPQA3wFYkblQHJ3A
 VnOOipuGUpzgr9+Rv6G4gGUuQkRyPQhxt7XNJ3aB39AgCA4s6iTpFXB8xkpI5/gKX59bavz3DsB
 +miVneoCxkJXKowbhJimrFYIZORDFNl2xF+M0sj8qvgbJ4YyXzqlTgW1dpZgDDkmfLvvMCIyemi
 HrCZs09FMCQhQPOxOP4jWPs//WuTqxt5h/3UvmpTJBCGpRvLmQm/37f0MjU5RSePs8OlqAB/ud3
 EU+bn6+SRGrG7oS+b7ikiRLfmajUXBw=
X-Google-Smtp-Source: AGHT+IGif72GbPGeexAXvh4/vnOyas/lGy83QsccPD0EUoFWs/steWIsumE4LDcvyElOQBOVGQ7b7Q==
X-Received: by 2002:a17:903:1cb:b0:216:6be9:fd57 with SMTP id
 d9443c01a7336-219e6ea1c3fmr683866235ad.21.1736207835312; 
 Mon, 06 Jan 2025 15:57:15 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9f72d1sm298447835ad.189.2025.01.06.15.57.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 15:57:14 -0800 (PST)
Message-ID: <7a716d4b-3846-4fc7-8c44-97ec63698c55@linaro.org>
Date: Mon, 6 Jan 2025 15:57:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/73] tcg: Merge TCG_TARGET_HAS_{muls2, mulu2, mulsh,
 muluh}
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-28-richard.henderson@linaro.org>
 <ecf37359-62d0-483d-a9b2-08bd32489a16@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ecf37359-62d0-483d-a9b2-08bd32489a16@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/6/25 13:58, Philippe Mathieu-Daudé wrote:
> On 2/1/25 19:06, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg-opc.h            |  16 ++---
>>   tcg/aarch64/tcg-target-has.h     |  12 ++--
>>   tcg/arm/tcg-target-has.h         |   8 +--
>>   tcg/i386/tcg-target-has.h        |  12 ++--
>>   tcg/loongarch64/tcg-target-has.h |  12 ++--
>>   tcg/mips/tcg-target-has.h        |  12 ++--
>>   tcg/ppc/tcg-target-has.h         |  12 ++--
>>   tcg/riscv/tcg-target-has.h       |  12 ++--
>>   tcg/s390x/tcg-target-has.h       |  12 ++--
>>   tcg/sparc64/tcg-target-has.h     |  12 ++--
>>   tcg/tcg-has.h                    |   4 --
>>   tcg/tci/tcg-target-has.h         |  14 ++--
>>   tcg/tcg-op.c                     | 115 +++++++++++++++++--------------
>>   tcg/tcg.c                        |  24 +++----
>>   tcg/tci.c                        |   8 ---
>>   15 files changed, 125 insertions(+), 160 deletions(-)
> 
> 
>> @@ -3099,58 +3099,73 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
>>   void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
>>   {
>> -    if (TCG_TARGET_HAS_mulu2_i64) {
>> -        tcg_gen_op4_i64(INDEX_op_mulu2_i64, rl, rh, arg1, arg2);
>> -    } else if (TCG_TARGET_HAS_muluh_i64) {
>> -        TCGv_i64 t = tcg_temp_ebb_new_i64();
>> -        tcg_gen_op3_i64(INDEX_op_mul_i64, t, arg1, arg2);
>> -        tcg_gen_op3_i64(INDEX_op_muluh_i64, rh, arg1, arg2);
>> -        tcg_gen_mov_i64(rl, t);
>> -        tcg_temp_free_i64(t);
>> -    } else {
>> -        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
>> -        tcg_gen_mul_i64(t0, arg1, arg2);
>> -        gen_helper_muluh_i64(rh, arg1, arg2);
>> -        tcg_gen_mov_i64(rl, t0);
>> -        tcg_temp_free_i64(t0);
>> +    TCGv_i64 t;
>> +
>> +    if (TCG_TARGET_REG_BITS == 64) {
>> +        if (TCG_TARGET_HAS_mulu2(TCG_TYPE_I64)) {
>> +            tcg_gen_op4_i64(INDEX_op_mulu2_i64, rl, rh, arg1, arg2);
>> +            return;
>> +        }
>> +        if (TCG_TARGET_HAS_muluh(TCG_TYPE_I64)) {
>> +            t = tcg_temp_ebb_new_i64();
>> +            tcg_gen_op3_i64(INDEX_op_mul_i64, t, arg1, arg2);
>> +            tcg_gen_op3_i64(INDEX_op_muluh_i64, rh, arg1, arg2);
>> +            tcg_gen_mov_i64(rl, t);
>> +            tcg_temp_free_i64(t);
>> +            return;
>> +        }
>>       }
> 
> Should we mention the new logic fallback in commit description?

It's not new, just indented under TCG_TARGET_REG_BITS == 64.
Previously, tcg-has.h provided TCG_TARGET_HAS_*_i64 false for 32-bit host.


r~

