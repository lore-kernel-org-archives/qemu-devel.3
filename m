Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F0DC021B5
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2025 17:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tltVW-00070r-Ek; Sat, 22 Feb 2025 12:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tltVU-00070T-Pd
 for qemu-devel@nongnu.org; Sat, 22 Feb 2025 12:41:40 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tltVT-00073W-2U
 for qemu-devel@nongnu.org; Sat, 22 Feb 2025 12:41:40 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-221206dbd7eso64314585ad.2
 for <qemu-devel@nongnu.org>; Sat, 22 Feb 2025 09:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740246097; x=1740850897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8JaaWtVVTIjxu1WcqHzAx/qf/HpDnRf1/YMn9xB3ihA=;
 b=Sp35oiyucBGXDpOuj4EoyUeJwj5t9+cIj8ljE9nHwEdV5tE9o67+IFih0px4csjZtO
 fbfwLhF4AhvZPCIKsVJ/EY78qUzmZsPY6apHurqbIE9n6/o/cIxiJZ7gUlSQhyzHeX0Y
 JlVAeaBuF0POTi3lO1FIhi5Gj56TCIVN7YWfCkLzC/EsqKHrJyW4pIZpgANFddxaH8pH
 wqxxBOvdxAsx0MO0qwm21ohZXAzd3oG5xZXoOMNVJb+Uj56Hd87qGdYQKfx3L4qgPfha
 CwS0xjTDfyXoUvss8VgX4iQnLDVwqRLlxit6TaZW0SmxxR51/7DSwP43XlgDvPXVEM/c
 9mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740246097; x=1740850897;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8JaaWtVVTIjxu1WcqHzAx/qf/HpDnRf1/YMn9xB3ihA=;
 b=G4MMl+FSTe86Dfqs0avwcM1I3I89U28ryD0ioJu131Ewk3LLHRxc0YPbHurPr2iP/O
 CskePEvOVV+JHpLEz36wpNxox7I9Uw6KwHyDpzYSzd+F+RV9TlMUdLW4oWxlj8sj9oIC
 QuIHkvJTme1g8SwBygC8TFnWZQGl1NXKdQMWXfU6sUbgplQXo1AkFP+cbw/Y+ISYeKZq
 c5ruAxUwfGcAjTt1aLsX5qXFJil2z3+x8Iz0hdtMyN0eH1ttEkARCc5rp9MDFvjcPJdu
 c5u7E8k9ErdK6H/E0thlbEqNFKC7Kbnj+EuAPTxPYN74gWMJcjNbdK7Ven+yPHXRWJSe
 r3jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7CAWmStU709BXiuzldNUmsM9Wx+nw1pbFLJ5rt791hLV7IhWnhtwx/uQyutqMchff6vRYM1asvdfb@nongnu.org
X-Gm-Message-State: AOJu0Yzpq3ybTLer1aHEK/A1JRSIpGs0VRxPgy7kP+bpKMqLsGHOXpFR
 kBImCfvqf9t7KNpsd3Yv5AUgyXbST9RTajbsUqkjLE7zDLRKOCIOF0I0sebQGQE=
X-Gm-Gg: ASbGncvv9NdPIq3/FQFjt0QyuW9IxRu3r5FMZw8OMJKYTdo9/QDNbkxtoVJOkMaYsDr
 ixEjyfBTgpwPuYXce4LBROXF1pm0Z2VypNjUUMsEciFcywQd8PD1HzZHxMvnps35LLF8apgV5Fz
 0CUjAVp2Ie28D7U4hydnQigU6MNn0kCRtn/YGTvmjCA3eg+wMwNNKzk1+NcLzmSvBLWSPmlYii1
 wLQUCGUJitUqZQokQfLGGgzKOg4H8qLQKBVb2qMSomkigArI2IpFaDolFacngpC1nLUeC3jBhtG
 o9icOsXDdT6sUp2OaoySGSYqsscxJ3L7WxDxmi2eeUcTHbJWzrBL8Hwr6hkHN0rbtoiMKNtW0ZD
 1/nIG2+s=
X-Google-Smtp-Source: AGHT+IGvjy+++inSKmxLC8Xp+2qhq34D1/pfJjVRhCjYFN51MV0gMtgWeXA/wZF08wCHX9JU1+O/eg==
X-Received: by 2002:a05:6a21:4613:b0:1ee:c695:e2c2 with SMTP id
 adf61e73a8af0-1eef3c7abbbmr12583928637.12.1740246097074; 
 Sat, 22 Feb 2025 09:41:37 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb586186c9sm16161602a12.35.2025.02.22.09.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Feb 2025 09:41:36 -0800 (PST)
Message-ID: <7035dcac-380b-49c6-a091-29afcdb631c2@linaro.org>
Date: Sat, 22 Feb 2025 09:41:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 002/162] tcg: Remove INDEX_op_ext{8,16,32}*
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-3-richard.henderson@linaro.org>
 <db558486-1eef-40e1-8b03-d89ee0c46fff@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <db558486-1eef-40e1-8b03-d89ee0c46fff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/20/25 14:17, Philippe Mathieu-Daudé wrote:
>> @@ -1794,23 +1715,19 @@ void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>>       case -1:
>>           tcg_gen_mov_i64(ret, arg1);
>>           return;
>> -    case 0xff:
>> -        /* Don't recurse with tcg_gen_ext8u_i64.  */
>> -        if (TCG_TARGET_HAS_ext8u_i64) {
>> -            tcg_gen_op2_i64(INDEX_op_ext8u_i64, ret, arg1);
>> -            return;
>> -        }
>> -        break;
>> -    case 0xffff:
>> -        if (TCG_TARGET_HAS_ext16u_i64) {
>> -            tcg_gen_op2_i64(INDEX_op_ext16u_i64, ret, arg1);
>> -            return;
>> -        }
>> -        break;
>> -    case 0xffffffffu:
>> -        if (TCG_TARGET_HAS_ext32u_i64) {
>> -            tcg_gen_op2_i64(INDEX_op_ext32u_i64, ret, arg1);
>> -            return;
>> +    default:
>> +        /*
>> +         * Canonicalize on extract, if valid.  This aids x86 with its
>> +         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
>> +         * which does not require matching operands.  Other backends can
>> +         * trivially expand the extract to AND during code generation.
>> +         */
> 
> Could also use s/0/ofs/ like for 32-bit.

Pardon?  Are you confusing the tcg_gen_andi_{i32,i64} changes
with the tcg_gen_{s}extract_{i32,i64} changes?

This andi_i64 hunk exactly matches the andi_i32 hunk.

>> @@ -2720,54 +2592,20 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
> 
> I note deposit_z_i32/i64 are not documented.

Indeed, it's probably worth removing, and just use tcg_gen_deposit_{i32,i64} with a 
constant zero argument.  There aren't very many uses in the tree at all.


>> @@ -2804,39 +2638,34 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
>>               tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
>>               return;
>>           }
>> -        /* The field is split across two words.  One double-word
>> -           shift is better than two double-word shifts.  */
>> -        goto do_shift_and;
>> +
>> +        /* The field is split across two words. */
>> +        tcg_gen_extract2_i32(TCGV_LOW(ret), TCGV_LOW(arg),
>> +                             TCGV_HIGH(arg), ofs);
>> +        if (len <= 32) {
>> +            tcg_gen_extract_i32(TCGV_LOW(ret), TCGV_LOW(ret), 0, len);
>> +            tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
>> +        } else {
>> +            tcg_gen_extract_i32(TCGV_HIGH(ret), TCGV_HIGH(arg),
>> +                                ofs, len - 32);
>> +        }
>> +        return;
> 
> This change would look better in a preliminary patch.

Done.


r~

