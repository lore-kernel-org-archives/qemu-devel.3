Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D2AE7716E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 01:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJNWK-0005UR-Bv; Thu, 05 Dec 2024 20:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJNWJ-0005U6-Ji
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 20:52:39 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJNWH-0005De-K0
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 20:52:39 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3ea60f074c3so859032b6e.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 17:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733449956; x=1734054756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=he90M4HxytPAKb6TY3Fz4JHY3u2W6xSjiI4r5HbLeNQ=;
 b=StDe9/4q30cfG1eRKxHdOKtHEK8LvhyV/DDm4gBpSuNUSPb7mM5bAronTAH/4OULOC
 jnkagWqkGwl3BDeY98uAUtGm9i4+B9BTun4i9gIpbfo93DKAOqydVHm/qRKv1yj7X0ov
 k/DF59LXXntGstNPc687TtP9ov2ncabxlm/HYkY/Rb9ZN8VqGEVwm63BGpuoBi/j/JlO
 jlnSEjCuld3MnsDGwHC/GUlGqZctDLczSxV8xQTfvyP8Z6ueEuN1p1SEcn8Z9JQ907wY
 NgOF8ozoKkke+onYFuXGaGc0OUWustjcQniEdNS8YTj633cfDECk4dY2xNACGkei+8FO
 6j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733449956; x=1734054756;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=he90M4HxytPAKb6TY3Fz4JHY3u2W6xSjiI4r5HbLeNQ=;
 b=KD9ooSnaPgqjEZa3E7x8geci/p/AGZtV12LRzvLJJNIN2a0Kj/+4xi5DqtfXRA3UBK
 O45KPeiC+34KtOdUNo1E94HNsINavquxcO+dT6yjY4A8VCYLbl2p8AYI/jMeYASpcCM/
 PqQDIs/olC1VwF9SSCMJGac8nCinWIY1aEcK76eT80keAzVj5w3F1M+4jMmym/hAgLp/
 gjxFOKg5NQn35DdhT1tgI34qdIdpYsNJR5mUUH944ATLQmt3CZq336Ggke10MNWYa8Cg
 x/q0sm+4f83YqOqm2ThirhrzOfHKWcHlC/OeO/nqOpH4+kiNYDtgu0glFTDV+/lQd6n7
 FSKQ==
X-Gm-Message-State: AOJu0YzpnHdiXpPD/wIAVpM3he77vmpSjVb5HBrkwvGuSy9pOudZN2NP
 9UCEWKniUYVXBs4JPGbOaMCAInuYDo/5y0VmZankRntruc5lvtlt/YILO5PjZyo=
X-Gm-Gg: ASbGncvLQRQlUsbNl/bLHT3Za8hOk1YMe35+giKwInqxi1BBu59EmLDVkTMwKNiYxhQ
 TmStFfQMkf5LL9/6i7q1U4kd9udgb/OK63QJKDLEVCa1ufCYxDh2MgNQFplgTE2cYH8I60/2DrI
 +gjb7Muly9Sa8Vbx4e2pqBkqwFjiMTJHQrIPSon5+VJnL9x3XOpR8fzXGzi1gAnKafIUaiWlsbY
 cpFlG8JJiTDe90n91bKtLwcXrt0m1o7TrCgRZxw9WQQSQPFRI01km4OW/ip4+saUnbGMPlYZ/sJ
 ElW1mA8zHJGT435j+FS5nYmstqfb
X-Google-Smtp-Source: AGHT+IFT+zpDpC2C6cNqJgbPriZKT4emhH9hLKIjbXFooGOETYRH603zLGgAX1hP32iBC3gDVrrirA==
X-Received: by 2002:a05:6808:f8c:b0:3ea:aa8a:c115 with SMTP id
 5614622812f47-3eb19ccf0ffmr629722b6e.21.1733449956315; 
 Thu, 05 Dec 2024 17:52:36 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb078695basm562111b6e.53.2024.12.05.17.52.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 17:52:35 -0800 (PST)
Message-ID: <4b1b91c2-80c2-4ed1-b313-a2e9ebba4049@linaro.org>
Date: Thu, 5 Dec 2024 19:52:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/67] target/arm: Convert FMOV, FABS, FNEG (scalar) to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-24-richard.henderson@linaro.org>
 <CAFEAcA9ECxgGvsSuw+GGsj4h2reKs9bVRSG=TD0oHPh519m7yA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9ECxgGvsSuw+GGsj4h2reKs9bVRSG=TD0oHPh519m7yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 12/5/24 15:12, Peter Maydell wrote:
>> @@ -8295,15 +8356,6 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
>>       TCGv_i32 tcg_res = tcg_temp_new_i32();
>>
>>       switch (opcode) {
>> -    case 0x0: /* FMOV */
>> -        tcg_gen_mov_i32(tcg_res, tcg_op);
>> -        break;
>> -    case 0x1: /* FABS */
>> -        gen_vfp_absh(tcg_res, tcg_op);
>> -        break;
>> -    case 0x2: /* FNEG */
>> -        gen_vfp_negh(tcg_res, tcg_op);
>> -        break;
>>       case 0x3: /* FSQRT */
>>           fpst = fpstatus_ptr(FPST_FPCR_F16);
>>           gen_helper_sqrt_f16(tcg_res, tcg_op, fpst);
>> @@ -8331,6 +8383,9 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
>>           gen_helper_advsimd_rinth(tcg_res, tcg_op, fpst);
>>           break;
>>       default:
>> +    case 0x0: /* FMOV */
>> +    case 0x1: /* FABS */
>> +    case 0x2: /* FNEG */
>>           g_assert_not_reached();
>>       }
>>
> 
> In these changes to the "handle this op" functions we make the
> function assert if it's passed an op we've converted. But shouldn't
> there also be a change which makes the calling function disas_fp_1src()
> call unallocated_encoding() for the ops ?

Yes.  I missed that because the line is

     case 0x0 ... 0x3:

without the usual set of comments.

>> @@ -10881,13 +10921,11 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
>>           case 0x7b: /* FCVTZU */
>>               gen_helper_advsimd_f16touinth(tcg_res, tcg_op, tcg_fpstatus);
>>               break;
>> -        case 0x6f: /* FNEG */
>> -            tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
>> -            break;
>>           case 0x7d: /* FRSQRTE */
>>               gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
>>               break;
>>           default:
>> +        case 0x6f: /* FNEG */
>>               g_assert_not_reached();
>>           }
> 
> What's this change about? This bit of decode is not in the area that
> corresponds to the new patterns you add to a64.decode.
> 
> Is this a bug in our existing decode where we decode something that
> should be undef? I think that 0x6f here corresponds to the decode
> table in section C4.1.96.6 ("Advanced SIMD scalar two-register
> miscellaneous FP16"), where it is U:a:opcode == 1 1 01111. But
> in that table that encoding is marked unallocated. A similar
> thing is true for case 0x2f FABS and case 07f FSQRT. All three
> of these should have set only_in_vector to true and not had the
> code handling in the is_scalar branch of the function.
> 
> We should fix that bug in a separate patch before we do the
> decodetree conversion, I think.

You're right.  I had thought there was something weird here, in that FNEG was present but 
not FABS.  The only scalar FNEG is in fp data-processing 1-src.


r~

