Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDE1CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2hP-0002t0-Tm; Wed, 29 Oct 2025 05:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE2hO-0002sp-0d
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:42:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE2hG-0000AQ-VD
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:42:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so43193915e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 02:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761730941; x=1762335741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1sPBkvJccfENOLAKV+kWrUkd54IxjcmLgzR0y35IVoo=;
 b=CY7ttHtddjyOVqoiMzgW5kkLTdvkjZXphw/x7wEZGVoCgdCnELVfT2SmxO3OWbaOwh
 6jiqq9qcS1uqi9hPUXzdf5TFu0DLI0rYh8iWXfa9q8yAguUQEgVBgWy3kDVM7tu+MSFv
 GKsi0tmD5Z/dq5VMEHmR59ADsYcKBMxN1WfhimatnJhA7MIs6sGGdJjc+HnlEDsWxdoq
 Q2mUtxCQUmlwjOEAbdzrDbAJw2pYvTV49HMJVvJa5sf46omeFwlbD6lnMSOa+ZgsuSU9
 OKoyWRm2tCnnRM3DUy7KgmMg/PhLGvAMxm5dPW9k/gZ1pEVc4foBin5FE5mDKxKL1XMD
 nCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761730941; x=1762335741;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1sPBkvJccfENOLAKV+kWrUkd54IxjcmLgzR0y35IVoo=;
 b=R7iO/aE1kX2+3EHx+CQs9N2OrLaKYQ+n2MERRs+mzHBcYifWoLRrEE+5euQWXOhw00
 FbTRHzKm8pWY+9B6Iqm6LOe2Bw2728gJ0V8jYOaVXTogiKECXqXDLQr6KF3SOqIyR67u
 59ARuoKS/gqbNJPaIC87aKWwYt3JCwrHoy8I3Y2gUAE79TKQpeDbHqOGxalT5qXeLd2W
 o8xVP/nqwD/KFXJWDXERJ1VP2fk8aFLkAsjNDifO8MQk9TY/iNTgGH6e1zYJLXie7vob
 EkDm5zzvOjULVDI4f7Y9TzRc3rVjYDiSr+jX6vVIoMFIYzY7eOEXmaA9ONXO7hxM8RSG
 egCQ==
X-Gm-Message-State: AOJu0YzZwDKb1ltYIp1VBPJSQqc6QaKdMXfAf4YTxS4qbktx6foWzJN4
 4ujJhqiXgKPImxDz78xtYRlARBrwQFFi0ahf/tEI8dZEkbDtN/bEzH1zb74qnJPXhk0=
X-Gm-Gg: ASbGncsPwPhrt/kfC3aX3t+jrGdBKMD8CXDXB86jOm7ziWwaBxTJ5J00hhejznp5gIo
 F2gRoq1BsSRc0a/lJzm5bXR99NAyulZpaDgk6VF/8mH3Jsq6NqoGkux3KD2kKeQi1+vmga4JuKP
 jr0ZTf1jLdY1xf0VzUVJGDVELiDgCZQwIZLPGnHv+xU0J7AUwlENA3MT6SLMTUz6INo8gMSUfzv
 m3ckP09pL2d+HG8BSOSKwqW+/MD8LrDDkkUJgbi+s8zPSk0wCfjwe0BJ1moJ/xt8YS1FzVOVqt2
 lLMJbPbtCAXLFH/yg9yhlBAgLmqjEms+bArvTs49o5QYoMrEwuPIcbPki13Xa1PixtuQnWCvibY
 3NxxjkN6WYiwjVLMQBKz5Rk6noaDFZ31BkDznOm0/u7cea5MaDfgLgrkc0XcElJCIAxc+x5W1ho
 e5kwClRwk/9s6zU++h
X-Google-Smtp-Source: AGHT+IEuI5qKqmex8pJST2O+wNiOrJlqwMkpAh6sdN3r6KrEGf+JKr/xcEEk48B9/1zp18i41h9a/w==
X-Received: by 2002:a05:600c:3b23:b0:475:de12:d3b5 with SMTP id
 5b1f17b1804b1-4771e1e3abemr24828125e9.34.1761730941265; 
 Wed, 29 Oct 2025 02:42:21 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df682sm25213877f8f.43.2025.10.29.02.42.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 02:42:20 -0700 (PDT)
Message-ID: <e914988a-e5f4-49f0-98a6-cdf83b5f2913@linaro.org>
Date: Wed, 29 Oct 2025 10:42:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] tcg: Expand missing rotri with extract2
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250928163155.1472914-1-richard.henderson@linaro.org>
 <20250928163155.1472914-5-richard.henderson@linaro.org>
 <CAAjaMXab1HbSQgB8txAat657efNDpXpQ-XmOH8FwX6Sow-79uw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAAjaMXab1HbSQgB8txAat657efNDpXpQ-XmOH8FwX6Sow-79uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/29/25 10:30, Manos Pitsidianakis wrote:
> On Sun, Sep 28, 2025 at 7:33 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Use extract2 to implement rotri.  To make this easier,
>> redefine rotli in terms of rotri, rather than the reverse.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/tcg-op.c | 70 ++++++++++++++++++++++++++++++----------------------
>>   1 file changed, 41 insertions(+), 29 deletions(-)
>>
>> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
>> index 4caf77da1e..3e10a3ad16 100644
>> --- a/tcg/tcg-op.c
>> +++ b/tcg/tcg-op.c
>> @@ -834,23 +834,12 @@ void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>>   void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>>   {
>>       tcg_debug_assert(arg2 >= 0 && arg2 < 32);
>> -    /* some cases can be optimized here */
>>       if (arg2 == 0) {
>>           tcg_gen_mov_i32(ret, arg1);
>>       } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
>> -        TCGv_i32 t0 = tcg_constant_i32(arg2);
>> -        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, t0);
>> -    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
>> -        TCGv_i32 t0 = tcg_constant_i32(32 - arg2);
>> -        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, t0);
>> +        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(arg2));
>>       } else {
>> -        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
>> -        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
>> -        tcg_gen_shli_i32(t0, arg1, arg2);
>> -        tcg_gen_shri_i32(t1, arg1, 32 - arg2);
>> -        tcg_gen_or_i32(ret, t0, t1);
>> -        tcg_temp_free_i32(t0);
>> -        tcg_temp_free_i32(t1);
>> +        tcg_gen_rotri_i32(ret, arg1, -arg2 & 31);
>>       }
>>   }
>>
>> @@ -878,7 +867,16 @@ void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
>>   void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>>   {
>>       tcg_debug_assert(arg2 >= 0 && arg2 < 32);
>> -    tcg_gen_rotli_i32(ret, arg1, -arg2 & 31);
>> +    if (arg2 == 0) {
>> +        tcg_gen_mov_i32(ret, arg1);
>> +    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
>> +        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, tcg_constant_i32(arg2));
>> +    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
>> +        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(32 - arg2));
>> +    } else {
>> +        /* Do not recurse with the rotri simplification. */
>> +        tcg_gen_op4i_i32(INDEX_op_extract2, ret, arg1, arg1, arg2);
>> +    }
>>   }
>>
>>   void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
>> @@ -2417,23 +2415,12 @@ void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>>   void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>>   {
>>       tcg_debug_assert(arg2 >= 0 && arg2 < 64);
>> -    /* some cases can be optimized here */
>>       if (arg2 == 0) {
>>           tcg_gen_mov_i64(ret, arg1);
>> -    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
>> -        TCGv_i64 t0 = tcg_constant_i64(arg2);
>> -        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, t0);
>> -    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
>> -        TCGv_i64 t0 = tcg_constant_i64(64 - arg2);
>> -        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, t0);
>> +    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
> 
> Shouldn't this be:
> 
> s/TCG_TYPE_I32/TCG_TYPE_I64
> 
> ?


Oops, yes.


r~

