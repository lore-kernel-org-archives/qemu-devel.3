Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B10E64AB3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 14:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tITak-0001CL-AC; Tue, 03 Dec 2024 09:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tITab-0001BP-6D
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 09:09:23 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tITaZ-00054t-Cb
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 09:09:20 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-29e842cb9b4so656448fac.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 06:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733234958; x=1733839758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4pt7pRc1nF+Cn4GnirVTuoBBpwLi4yWegrkLdcf7NhE=;
 b=IkUR9WjMStI0B4RyHelLkuofwn8lPO9175vGyks+bpzVeaptKk6RXUfltybmnrd9BU
 Ff9nf58ZzVX1meuLnAs+nXvBGUXFpH37OKjcGK2EWOlqIVuT+F5FOxAh6RI+tCUO4cpm
 sPAtV3sYYez3R8k7C0ezSwI/z4Htky+/JVn+CBuzZDokdC45cvkVsxoPtMA9CTdoWz0J
 cZD/qphlbjMheFoFt1Ka6Mjt2KmCJLDIG/Y4b8Pi02g2NgomKf8XsmqL8EiVwtPPoM1y
 zGOti0cMFBgV7k+4F1Wnr2I3XEWJ1/8yL6+898436LTH6WT4KJTvregV3Wx1N0p5YIy0
 NU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733234958; x=1733839758;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4pt7pRc1nF+Cn4GnirVTuoBBpwLi4yWegrkLdcf7NhE=;
 b=s5DqkQ84zd5wk4GZn0EeJEsQIGxdIGDwnzgajYZlH43Cvi44vTL2pvAHjOm+w7my0Y
 EE30Xk21NW0ODu49PPgYaRkll/thxJrgd7c+W0vzUj0V4zMNHP2TfZD+DVGEtQLh+Rnj
 wb0/U1JVC0HfaODX8YfhC5G2BmEN7wKmxnwDNDSvpX6m0IJ3ilCI2TdpCZaIs5aD4j/O
 Cx+A7QweG7Fqs6kmYAhqT2bG6bE4muGtBRwdigGORB75KzwMFvf/9C0El4DsdwTGTcVO
 ty24BWnP+bo1QVgzdFMAnwykHLVABWKHIY3JjLaWBXSoOpuiq9Xy+6niinEqBoXzot8P
 X26g==
X-Gm-Message-State: AOJu0YzLPayl4fFbW28nZ0ryUJOgEe7f40IZ4q92TXudtrCCpCn6dnb7
 2jpn6nL/AwIUPSUVHpRru1rPAvMGOtj4lZqwpcGxyvQdjrnPAH6rA6AdST/VYKUZM1irzACaf/m
 Fp1Q=
X-Gm-Gg: ASbGncuzsMZydqVcweVetjcTscROajXWPMWhcGsQ2JvuCzRd8Kcf9J8TVaS6iYXzt4i
 xJPTGeWOrNUVAqRSaEUNbRDjxt72wVwHP8tcVCGboQTjjY+BAO68EpHHuU+1pd4c9/n2l5jkCvO
 h0pFr8i9NsY12ePf2kshMyu+k8LkyVdoVEEzpISMrBMQccXzgyA3iMhObBAZrH72tSxxkYuziS+
 2TDsXbbaSud57NY7djFcpc3Yngp25rbofiPTF3gkKX4r5Q9ztOIrikJR7XvGw8AiOrGuf83Pd5P
 EJmP6jUKMGpivwwsopMyatZWGuCq
X-Google-Smtp-Source: AGHT+IGBcZ2JS1QzMhrHXPEunI05yz05+qGTEYvegjZiJFNN34AFTo+yG3+1UQGYG042X7599JDJJw==
X-Received: by 2002:a05:6870:5d94:b0:29e:62a6:de9 with SMTP id
 586e51a60fabf-29e8868bd80mr2631445fac.17.1733234957916; 
 Tue, 03 Dec 2024 06:09:17 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725476fesm2844656a34.28.2024.12.03.06.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 06:09:17 -0800 (PST)
Message-ID: <54d6068b-49f6-42c5-aff6-dd4fa61579ff@linaro.org>
Date: Tue, 3 Dec 2024 08:09:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 42/67] target/arm: Convert handle_rev to decodetree
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-43-richard.henderson@linaro.org>
 <CAFEAcA8CbQXg7D22SCyqT0oJAPZ1g7_yWJENZX3wKBOmp4r58Q@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8CbQXg7D22SCyqT0oJAPZ1g7_yWJENZX3wKBOmp4r58Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

On 12/3/24 05:49, Peter Maydell wrote:
> On Sun, 1 Dec 2024 at 15:16, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This includes REV16, REV32, REV64.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> 
>> @@ -10070,10 +10003,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
>>       TCGv_ptr tcg_fpstatus;
>>
>>       switch (opcode) {
>> -    case 0x0: /* REV64, REV32 */
>> -    case 0x1: /* REV16 */
>> -        handle_rev(s, opcode, u, is_q, size, rn, rd);
>> -        return;
>>       case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
>>       case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
>>           if (size == 3) {
>> @@ -10276,6 +10205,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
>>           break;
>>       }
>>       default:
>> +    case 0x0: /* REV64 */
>> +    case 0x1: /* REV16, REV32 */
> 
> REV32 is case 0x0, not 0x1, per the comments deleted above.
> 
>>       case 0x3: /* SUQADD, USQADD */
>>       case 0x4: /* CLS, CLZ */
>>       case 0x5: /* CNT, NOT, RBIT */
>> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
>> index 4f8231d07a..2531809096 100644
>> --- a/target/arm/tcg/a64.decode
>> +++ b/target/arm/tcg/a64.decode
>> @@ -73,6 +73,7 @@
>>
>>   @qrr_b          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=0
>>   @qrr_h          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=1
>> +@qrr_bh         . q:1 ...... . esz:1 ...... ...... rn:5 rd:5  &qrr_e
>>   @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
>>
>>   @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
>> @@ -1657,3 +1658,7 @@ CMGE0_v         0.10 1110 ..1 00000 10001 0 ..... .....     @qrr_e
>>   CMEQ0_v         0.00 1110 ..1 00000 10011 0 ..... .....     @qrr_e
>>   CMLE0_v         0.10 1110 ..1 00000 10011 0 ..... .....     @qrr_e
>>   CMLT0_v         0.00 1110 ..1 00000 10101 0 ..... .....     @qrr_e
>> +
>> +REV16_v         0.00 1110 001 00000 00011 0 ..... .....     @qrr_b
>> +REV32_v         0.10 1110 0.1 00000 00011 0 ..... .....     @qrr_bh
>> +REV64_v         0.00 1110 ..1 00000 00001 0 ..... .....     @qrr_e
> 
> This doesn't look quite right -- in the decode table in C4.1.96.21,
> 2-reg misc REV32 is opcode 00000, like REV64, not 00001 like REV16.
> 
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -1660,5 +1660,5 @@ CMLE0_v         0.10 1110 ..1 00000 10011 0
> ..... .....     @qrr_e
>   CMLT0_v         0.00 1110 ..1 00000 10101 0 ..... .....     @qrr_e
> 
>   REV16_v         0.00 1110 001 00000 00011 0 ..... .....     @qrr_b
> -REV32_v         0.10 1110 0.1 00000 00011 0 ..... .....     @qrr_bh
> +REV32_v         0.10 1110 0.1 00000 00001 0 ..... .....     @qrr_bh
>   REV64_v         0.00 1110 ..1 00000 00001 0 ..... .....     @qrr_e
> 
> should I think be the right fixup.

Yep, my bad.  I remember "fixing" the comment, because I thought it was off.  I must have 
been tired, or something.  Odd that this passes risu... maybe we're missing a pattern.


r~

