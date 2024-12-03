Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22033E64ABB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIUpZ-0001Mx-2z; Tue, 03 Dec 2024 10:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIUpX-0001Md-EL
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:28:51 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIUpV-00085o-PU
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:28:51 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2689e7a941fso3081844fac.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 07:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733239728; x=1733844528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ddVbX959t4yeE1SQjP6kfnD8JqKG7wqHgvg1qP3In/8=;
 b=mF9A1GJjKhLaeWwfABF97k/3wNlJwDItEHed0COEPcPaCFucENRGRMtMvA511iSKSk
 rZlY3xJb/CFgAcYdTRytqWarFy+lxXlK9C52FvWCYe6yDP2AlvsM867fnAsxuJW+48fi
 lK0MNlnpVm+P1YpQl+BIQjwtzk+SBvTUHNMjD/oLLKQXLJJ7cyHWedaxLGeiO9rBSw2N
 5f/nPRxK+zEKWX4p9I7Oxw5gEPw+Px+rhUdYLiYv65DcZwLImQJZVV4dHAml87B2f3zB
 zjx6qXsLKRI48Ki44QPsFw0b/f4/20jARiBlO3Kjohef8XVHuxcaJlXsjsN1Ox4UErvt
 3Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733239728; x=1733844528;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ddVbX959t4yeE1SQjP6kfnD8JqKG7wqHgvg1qP3In/8=;
 b=dx/krlAyVEcRu/SoxFJljCmOLmWSeBm16Xwgp2WPGumIrIEXCNrStmVSoLdB7HpeTY
 qOUzVriVITqbkAzWJcaQppL40BWvV043WfHy9SRukDYkyau3qWITgNpyTMuUFiyqBgPW
 G/5TetGnN6c8f2/jLnXSr9Av+lOAXbKaeqxL5NTsd8xq4wxbHL4d9zdEumYC7DcRBAYK
 9HNCDO87n9vSRoKjM0UKDzFbrUqF/ifA/B8u3LFEwZtnWOBMY0jjufd8xW8ynnQMB9WP
 o2jj04jGpMvw2DZJ8gfkJdlYiLHffCyT4usiWR12ZjhdzswvF4Da55FpivdojUsJfwE8
 0Grg==
X-Gm-Message-State: AOJu0Yx4M8j+QvVUXOsDZKMIHjiEF3gzF46zMD8OepYo1FhdeC/BqFyV
 BujdjuqrsewETgwKL/Ovk1aQxGCgp67clAWyvuIRK2u3qfNmJ2798OLvZ9BgtyY=
X-Gm-Gg: ASbGncse4orvsiy2sSksWjtRTvdSEHouTMYAFDyKnkk/Lt6tRtcAlMkvzPihyc5SSpa
 IWObFpghGlPDMzfZSCRNiHEav7ouOdoeJ/16mctzuJbiiB942yo0lnCKg34pK25aeyIAhYKInPI
 37VhE0lbhk5nw8BFjiEKFzcUqHkLjfTWLD2Fmn9ILIax9mUXfPRbaZAwIJ79rFfuBkQG/5OAvy4
 yz788yLxfXRkr8fC28DHBvObXb8Kv80SaAdriFQyssaN2WF4lRF52FCsF5QytLwFcxqUQXnpUNX
 DJkjvnoOKD+44D+x/S00A56qd+p/
X-Google-Smtp-Source: AGHT+IHlKH9g/gb2k0nqK9pBkZEHdZjTBjLzHcp3UKimP4eYyzflG4IuEu1zwbk6GgDHnF2MSKqM6w==
X-Received: by 2002:a05:6870:71c3:b0:29e:67e0:408b with SMTP id
 586e51a60fabf-29e8870d1efmr2536006fac.22.1733239728221; 
 Tue, 03 Dec 2024 07:28:48 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e2d2c4fd5sm2822924fac.30.2024.12.03.07.28.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 07:28:47 -0800 (PST)
Message-ID: <b0a41fbf-0ec6-47cc-805d-e762d99ddf82@linaro.org>
Date: Tue, 3 Dec 2024 09:28:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/67] target/arm: Convert BFCVT to decodetree
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-29-richard.henderson@linaro.org>
 <CAFEAcA9Aww0m_TPdbL53DPPnWqA=BU1TzjGLvQi-EokKyzkdfQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9Aww0m_TPdbL53DPPnWqA=BU1TzjGLvQi-EokKyzkdfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

On 12/3/24 08:05, Peter Maydell wrote:
> On Sun, 1 Dec 2024 at 15:11, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/translate-a64.c | 24 ++++++------------------
>>   target/arm/tcg/a64.decode      |  3 +++
>>   2 files changed, 9 insertions(+), 18 deletions(-)
>>
>> @@ -8661,21 +8664,6 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
>>           break;
>>
>>       case 0x6:
>> -        switch (type) {
>> -        case 1: /* BFCVT */
> 
> Here we decode BFCVT when the 'ftype' field (bits [23:22]) is 0b01...
> 
>> -            if (!dc_isar_feature(aa64_bf16, s)) {
>> -                goto do_unallocated;
>> -            }
>> -            if (!fp_access_check(s)) {
>> -                return;
>> -            }
>> -            handle_fp_1src_single(s, opcode, rd, rn);
>> -            break;
>> -        default:
>> -            goto do_unallocated;
>> -        }
>> -        break;
>> -
>>       default:
>>       do_unallocated:
>>           unallocated_encoding(s);
>> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
>> index fbfdf96eb3..476989c1b4 100644
>> --- a/target/arm/tcg/a64.decode
>> +++ b/target/arm/tcg/a64.decode
>> @@ -45,6 +45,7 @@
>>   &qrrrr_e        q rd rn rm ra esz
>>
>>   @rr_h           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=1
>> +@rr_s           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=2
>>   @rr_d           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=3
>>   @rr_sd          ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_sd
>>   @rr_hsd         ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_hsd
>> @@ -1337,6 +1338,8 @@ FRINTA_s        00011110 .. 1 001100 10000 ..... .....      @rr_hsd
>>   FRINTX_s        00011110 .. 1 001110 10000 ..... .....      @rr_hsd
>>   FRINTI_s        00011110 .. 1 001111 10000 ..... .....      @rr_hsd
>>
>> +BFCVT_s         00011110 10 1 000110 10000 ..... .....      @rr_s
> 
> ...but this decode pattern has them as 0b10.
> 
> 
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -1338,7 +1338,7 @@ FRINTA_s        00011110 .. 1 001100 10000 .....
> .....      @rr_hsd
>   FRINTX_s        00011110 .. 1 001110 10000 ..... .....      @rr_hsd
>   FRINTI_s        00011110 .. 1 001111 10000 ..... .....      @rr_hsd
> 
> -BFCVT_s         00011110 10 1 000110 10000 ..... .....      @rr_s
> +BFCVT_s         00011110 01 1 000110 10000 ..... .....      @rr_s
> 
>   # Floating-point Immediate
> 
> should fix this.

Yep, thanks.  Fixed.


r~

