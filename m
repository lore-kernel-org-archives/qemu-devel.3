Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1816E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 18:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJcrZ-0002iP-VQ; Fri, 06 Dec 2024 13:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJcrB-0002Wc-Se
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:15:14 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJcr9-0005Sh-Pc
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:15:13 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ea49cc8b88so1120085b6e.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 10:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733508910; x=1734113710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RgiFX+en6Qe18ZkyNDWy6LhFrZEhoqiQtCUXX4CHSvQ=;
 b=X42rRpY6WV06Pa4lbmjDj+D6lW3tFLQNsj18OOa23NUOFaXLFSi5pEsZZy7Ay72BQR
 kDHQiMawOyl6YqZL9n/gI7BAuoJ75nHocDsBdudvnm2ABERrG2+OdX/7y24qQ98kHtE+
 D0ZEn47vSoIm1EXjNEfwLuWMMac/xuBE4/Ew6HM0mohCJ/7KFVLtI9ED8l0rFbdyvhJ2
 rClkRJIkqH2pwqb+vwhNsUUI8kVJIccErpgOxJApkEypQ8CUObZAdAler0jSLQp89QeH
 3jkzTAJU32N2s+AjKgzIWEWtfHZ6kXbiA+wqt3ujAYZhzdM4M1DeOYe8HmWbGmRhHmK0
 FGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733508910; x=1734113710;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RgiFX+en6Qe18ZkyNDWy6LhFrZEhoqiQtCUXX4CHSvQ=;
 b=PK3J9GphG4wWq33jQu41xeuAOGnPdkc5rdNIV+liIYeOg4Vo8yagssq7xQmLCJUbhm
 DnCDdaHttgqpXctRAtyx8pDaxDHmTqruxfPugaf5MSYmx0/dfIu5QRfmBwLzq3xYFZt/
 2KJ+kdItW0POv/YhPDm0vyfu5zc+YaIym3v4huIHnt+9uqG3axbBLKKucFFSqn+CRZQu
 4+oZbtXpA44qezEtKtIpSv2a91c23e2oTVPsLrx6+7vGQmvM1ElJZk1aOHwkyKxeSFTp
 oXGd1M+mfWoHwoKJA2dxm5EjNXf/99KLviZl1cXvdidrcaKgLcrsoKa5LFiT78jjc2q4
 7tmg==
X-Gm-Message-State: AOJu0YwUPtL6fhJxyhr34y2w1KA3cOUDYM54ugDaGdI29Gw61Kg12KOM
 x+jXApYYotkdFLi3W8BlrV/bOBZ1PkNryFEDa9KIaPpnOg6hlX56bdBNHV5yla8=
X-Gm-Gg: ASbGnct086KkROEFM9ziF1k/6Pebo8+OmuxIqMc1MXvovgctWmyESnrr7peY1jspKN2
 +4j5Ea9pBwVFfCPafR7SEQ3n6jKY4zXTTAcs5uoFY+1E1LzG0wbaGNQOHH1dbAhU6Dj4HFOSYnA
 OFDE3XnsoWjmsaYlwyOtAOUdIbODvWPPRjRUPpg+eCZ0XRzIZDthkhDNnDtkgtQpW4XTdqMA+cR
 kOBtgRPZvhEzNje+Jsx9BcyHN23lY1XahcNPvDdSw3gxK69fpHXDj8R/Z+s6BLifI6tS97koVnx
 Hx/UUT8iDh0j/bt0guFx7dSahX08
X-Google-Smtp-Source: AGHT+IE0UaQDUJJHTWi+ixmBaEaPVeonluluGxcWOiGHyMxGwXMvLQfQgDYlXprXDjSG5cHn2VdxDA==
X-Received: by 2002:a05:6808:1927:b0:3ea:51d8:ff0b with SMTP id
 5614622812f47-3eb19ccf525mr2474967b6e.24.1733508908885; 
 Fri, 06 Dec 2024 10:15:08 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b8c08sm846163b6e.13.2024.12.06.10.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 10:15:08 -0800 (PST)
Message-ID: <535a9c3e-7cf3-4054-bf94-d9386ab63f67@linaro.org>
Date: Fri, 6 Dec 2024 12:15:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 58/67] target/arm: Convert [US]CVTF (vector, fixed-point)
 scalar to decodetree
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-59-richard.henderson@linaro.org>
 <CAFEAcA84p8+7bMtiAiRug3E9OXfe9n-ornGwuk5P3-M4EEy5ZQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA84p8+7bMtiAiRug3E9OXfe9n-ornGwuk5P3-M4EEy5ZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

On 12/6/24 10:27, Peter Maydell wrote:
> On Sun, 1 Dec 2024 at 15:12, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Remove disas_simd_scalar_shift_imm as these were the
>> last insns decoded by that function.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/translate-a64.c | 47 ----------------------------------
>>   target/arm/tcg/a64.decode      |  8 ++++++
>>   2 files changed, 8 insertions(+), 47 deletions(-)
>>
>> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
>> index 9808b976fd..ea178f85c2 100644
>> --- a/target/arm/tcg/translate-a64.c
>> +++ b/target/arm/tcg/translate-a64.c
>> @@ -9543,52 +9543,6 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
>>       gen_restore_rmode(tcg_rmode, tcg_fpstatus);
>>   }
>>
>> -/* AdvSIMD scalar shift by immediate
>> - *  31 30  29 28         23 22  19 18  16 15    11  10 9    5 4    0
>> - * +-----+---+-------------+------+------+--------+---+------+------+
>> - * | 0 1 | U | 1 1 1 1 1 0 | immh | immb | opcode | 1 |  Rn  |  Rd  |
>> - * +-----+---+-------------+------+------+--------+---+------+------+
>> - *
>> - * This is the scalar version so it works on a fixed sized registers
>> - */
>> -static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
>> -{
>> -    int rd = extract32(insn, 0, 5);
>> -    int rn = extract32(insn, 5, 5);
>> -    int opcode = extract32(insn, 11, 5);
>> -    int immb = extract32(insn, 16, 3);
>> -    int immh = extract32(insn, 19, 4);
>> -    bool is_u = extract32(insn, 29, 1);
>> -
>> -    if (immh == 0) {
>> -        unallocated_encoding(s);
>> -        return;
>> -    }
>> -
>> -    switch (opcode) {
>> -    case 0x1c: /* SCVTF, UCVTF */
>> -        handle_simd_shift_intfp_conv(s, true, false, is_u, immh, immb,
>> -                                     opcode, rn, rd);
>> -        break;
>> -    default:
>> -    case 0x00: /* SSHR / USHR */
>> -    case 0x02: /* SSRA / USRA */
>> -    case 0x04: /* SRSHR / URSHR */
>> -    case 0x06: /* SRSRA / URSRA */
>> -    case 0x08: /* SRI */
>> -    case 0x0a: /* SHL / SLI */
>> -    case 0x0c: /* SQSHLU */
>> -    case 0x0e: /* SQSHL, UQSHL */
>> -    case 0x10: /* SQSHRUN */
>> -    case 0x11: /* SQRSHRUN */
>> -    case 0x12: /* SQSHRN, UQSHRN */
>> -    case 0x13: /* SQRSHRN, UQRSHRN */
>> -    case 0x1f: /* FCVTZS, FCVTZU */
>> -        unallocated_encoding(s);
>> -        break;
>> -    }
>> -}
>> -
>>   static void handle_2misc_64(DisasContext *s, int opcode, bool u,
>>                               TCGv_i64 tcg_rd, TCGv_i64 tcg_rn,
>>                               TCGv_i32 tcg_rmode, TCGv_ptr tcg_fpstatus)
>> @@ -10489,7 +10443,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
>>       { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
>>       { 0x0f000400, 0x9f800400, disas_simd_shift_imm },
>>       { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
>> -    { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
>>       { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
>>       { 0x00000000, 0x00000000, NULL }
>>   };
>> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
>> index 707715f433..197555555e 100644
>> --- a/target/arm/tcg/a64.decode
>> +++ b/target/arm/tcg/a64.decode
>> @@ -1699,6 +1699,14 @@ FCVTAU_f        0111 1110 0.1 00001 11001 0 ..... .....     @icvt_sd
>>   @fcvt_fixed_d   .... .... . 1 ...... ...... rn:5 rd:5       \
>>                   &fcvt sf=0 esz=3 shift=%fcvt_f_sh_d
>>
>> +SCVTF_f         0101 1111 0 ....... 111001 ..... .....      @fcvt_fixed_h
>> +SCVTF_f         0101 1111 0 ....... 111001 ..... .....      @fcvt_fixed_s
>> +SCVTF_f         0101 1111 0 ....... 111001 ..... .....      @fcvt_fixed_d
>> +
>> +UCVTF_f         0111 1111 0 ....... 111001 ..... .....      @fcvt_fixed_h
>> +UCVTF_f         0111 1111 0 ....... 111001 ..... .....      @fcvt_fixed_s
>> +UCVTF_f         0111 1111 0 ....... 111001 ..... .....      @fcvt_fixed_d
>> +
>>   FCVTZS_f        0101 1111 0 ....... 111111 ..... .....      @fcvt_fixed_h
>>   FCVTZS_f        0101 1111 0 ....... 111111 ..... .....      @fcvt_fixed_s
>>   FCVTZS_f        0101 1111 0 ....... 111111 ..... .....      @fcvt_fixed_d
> 
> Aren't we missing the new trans functions for these insns ?
No, we're sharing the trans functions with the previous patch.
The (vector, integer) insns decode with shift=0.
These (vector, fixed-point) insns decode a proper shift field.


r~



