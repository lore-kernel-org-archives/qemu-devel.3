Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749E9E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZyY-0005g1-Cs; Fri, 06 Dec 2024 10:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJZyV-0005ff-Qe
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:10:37 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJZyT-00036p-JB
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:10:35 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3ea53011deaso613240b6e.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733497832; x=1734102632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SxL5VbJ0YJpwE8YrwqAvM2EfjoS1W637eH7sVAo2arM=;
 b=hY1W5CDL7sjGknNGA6EFrPUnpjzV7e77l2tml8nSsP2PKx9fL4wPFjKzmoET86Oeqj
 Fl+8y1PrZvfO4SQZXhYSpARjxE1p5cvciTUHgNuYuHOvKceQi9pbQX6iz+rgwmUQDytY
 la64K7agQmreib9UbL9TQ6IUgzbQIWZS550C2TAjBrL9p7k7X0rV728CRN05Bfh8Kcr4
 UNAQW5x1OeLf1fiBqi1DoD9wIEjDU9pyNKeXVfz2uMsV/VflvxMWbToMSbwpj3M6YO83
 vJyDdqCID+xaxGp2/BigVOaZXNjU/r7j7+CK2qL6lLV8GlUPOxT9vcchDHrx8+1CeewF
 NeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733497832; x=1734102632;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SxL5VbJ0YJpwE8YrwqAvM2EfjoS1W637eH7sVAo2arM=;
 b=Wb6OUOksmj1jwt0XIDEOuQq7PZr8tXtTQhKwbismBGsZA7LUrsRwls+CzHmyoIN4e5
 x8fyVRwAEkDpJaYQMb1y5M1iOvxG1jeBumJ3hDGEplM58c/CPOrX+EFAn8+2CcWxSdic
 QB5lDbmpvH8H1rIMF2DF0cHDEPdhkCWqR498rXiXq+OJarRc6ll0iLqJ4//DGGbhbIxb
 bx8aXKNRdfXmO5S6GpVelLIzoy8FZy1/CYETkIEpt34XPwD+YSkkszlC4hKbwFELzfqw
 1+2wao/W/Xo0efv5ix+gPRF+veV33VWAU8eroJW68v+QbMMZyb9kzSpQTMOWlXOeMskr
 pMrA==
X-Gm-Message-State: AOJu0YyT83N0K+DQEi0sF4PUiE5FZE9SzmchrP3faFv531dH9wz3o/xV
 xSKt/thwXvoV97QEd9NOvhicO+npTWT92F1ZcIewDkP20BOyILqwm9k52xthba4=
X-Gm-Gg: ASbGncuh3u8LQUojwbSE9WA9UwW2G1eFW/NbjwK/nhlUIt+NtP3XXIiv8dP55UV3qlq
 RQDpiYVjTfHWDAN6nrcUEdkajYsDgtKqXG8p75ZzLaqdP4nXT/AIRRl9bh19h1p8pOrDssT2BCz
 n90oAecG5e6yMirZFg0mhz64Rs0yw5pxzYXaX/oSmS13or+8lRZCVxD8095t3NcbvHUUwVeNjLZ
 aoTsnFTV2S53CWrhA+pk641G3kY+YzcKu0tDf3mMgMFJod45JuzY+V3Ax3wBtybK0GxQkK5BBL3
 bpBM0dUdtEEppDKMIRto31chHRNM
X-Google-Smtp-Source: AGHT+IHrzb2xqymGzh1u01ic0i9NCPTLdEZ4Fy2Wcz1eL7PmexX0hMdxA656jdidUzqINyD9ztAAvQ==
X-Received: by 2002:a05:6808:ed0:b0:3e7:c7c1:e6cf with SMTP id
 5614622812f47-3eb19e0d4e4mr1405247b6e.43.1733497832211; 
 Fri, 06 Dec 2024 07:10:32 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f567602f5sm854842fac.23.2024.12.06.07.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 07:10:31 -0800 (PST)
Message-ID: <b3cd1199-f63f-4383-bc31-3666d2bc9677@linaro.org>
Date: Fri, 6 Dec 2024 09:10:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/67] target/arm: Convert handle_fpfpcvt to decodetree
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-32-richard.henderson@linaro.org>
 <CAFEAcA-11+JX0N4vjU_3WDNVt8nis-+ufANLG2L1TNGZhLcubQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-11+JX0N4vjU_3WDNVt8nis-+ufANLG2L1TNGZhLcubQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

On 12/6/24 07:48, Peter Maydell wrote:
>> +static bool do_fcvt_g(DisasContext *s, arg_fcvt *a,
>> +                      ARMFPRounding rmode, bool is_signed)
>> +{
>> +    TCGv_i64 tcg_int;
>> +    int check = fp_access_check_scalar_hsd(s, a->esz);
>> +
>> +    if (check <= 0) {
>> +        return check == 0;
>> +    }
>> +
>> +    tcg_int = cpu_reg(s, a->rd);
>> +    do_fcvt_scalar(s, (a->sf ? MO_64 : MO_32) | (is_signed ? MO_SIGN : 0),
>> +                   a->esz, tcg_int, a->shift, a->rn, rmode);
>> +
>> +    if (!a->sf) {
>> +        tcg_gen_ext32u_i64(tcg_int, tcg_int);
> 
> For the MO_16 and MO_32 input cases we already did a
> zero-extend-to-64-bits inside do_fcvt_scalar().
> Maybe we should put the tcg_gen_ext32u_i64() also
> inside do_fcvt_scalar() in the cases of MO_64 input
> MO_32 output which are the only ones that actually need it?

I thought about that.

(0) In that case the duplicate zero-extend will be optimized away.

(1) I thought it was clearer to retain the !sf test here rather
     than rely on a zero-extend elsewhere.

(2) In the scalar vector case, the best method for Vd.H is to clear
     the entire vector and only then store the 0th element directly
     from the bottom bits of either TCGv_{i32,i64}.

     Otherwise we wind up with two zero-extends which cannot be folded:
     tcg_gen_ext16u_i32 + tcg_gen_extu_i32_i64 or
     tcg_gen_extu_i32_i64 + tcg_gen_ext16u_i64.
     Fixing this duplication would require new tcg ops to
     extend-and-change-type.

     While Vd.S does not suffer the same fate, it's easiest to use
     the same method as Vd.H.  See patch 55.


r~

