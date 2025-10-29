Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917ECCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE60H-00032d-5J; Wed, 29 Oct 2025 09:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE60C-00031f-TL
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:14:13 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE608-0006u6-OI
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:14:12 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-93eab530884so725396139f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761743641; x=1762348441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8CwDeQgHWOU78qj3vwExfKImRfRzicchWo0CiASgO6U=;
 b=Ewc81KU4qA96UNEZJ31UPfNjialmkR9ypklbFfonU8tVhmVCz6xGQh5yKki8bnia1n
 dg1yk/6rUz1L1GTgZrMRQlNIvZD4UySCNR3WK6YkqmSJ3c10sfwufxpeHkMamLklY4FZ
 +mJcVpyBMMRZVItVUtQlefp9pAnQdg92t3lOMBr3eDKlB4wTVqAfLOtZt7rt1sb0Hny4
 kB8kcM6knlPW+J3HW99vcw3MwuwcJxs+h2Pki7ADLi4yRvGFIr7orfaWHAvyXUhkyira
 2YIJJ2Xx5Hbogn8iJoN7p3vKSIgMUCsS9DpBkQUZY+ahm/wU+WDpqHhLfqazPIiJTAQ6
 gUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761743641; x=1762348441;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8CwDeQgHWOU78qj3vwExfKImRfRzicchWo0CiASgO6U=;
 b=OxndXCQD1iAJF8HMi8ktpU/QhrosmV667lNn3q9//u0K7XE4ObipYas27njRjhuSPB
 fQhsYV2oBT3VrGPzlBXwP20SwpRpw3Pvwl/cpLpoi1bs5iRbJrAgO4VXdsiEw0/o/ZNt
 R51xxSPDCQLITAq06prnCbIZiF8Jx3JgU8eM+gciaWnytF9jUhcIX2tkzb40D9d9/gsE
 gXf8p0wwGz9aPpTwiBZ7uKM6A8pvkB1miV+Vos7mQGl0i6A+4GZibQ/eXI6Lsm8TeVfp
 Tyn/Jh0WsfGO0bZU7tiA9h0U7W/BToOlTf27Cz30eYAmT2G4VbGVByk/EXD++y21Ji6g
 2h/A==
X-Gm-Message-State: AOJu0Yz26A2QZNivyZSkxhoKuOrxiV4AgO3rfgj4tE4PoFHFAxujsuX7
 +WyVu6Ffmegw6Fsymf6QSXeMdAUcdpzsqT6/U9+RHXtNqV7beCq2wz+MUhBNbxp/nRk=
X-Gm-Gg: ASbGncshO6v9YJbfaMLLcWFp71THb2GoSVzE0bXHg7VTmM4p7fsn03gxY7AzGhdH7b4
 SD7aiz2FQ1G572NNZfwun7m8x2PRCm1Ow97wWKJmu9MHoWKflcLaZS83o+BvXpg2xGwv/9Bdaua
 CyZGwcJiXF+uvV/0a28T0wHezy296xXvVmt1hFJS8Hi6ErMY6nb0Yz6csuZXeEgrl8TgTBPv29a
 8KHyCB/NiLA6ZzaWSOCqWmSpKZ1M1KOkSryOo1QxceCqBWcWKl+FHm+mD+b0J998DEeAJ4UTub5
 ib3OD7pqjlnyAp8JMOE0IYGR9yExwiqP7IPBMi87LDRalY4xn+WC9ryjKyK+xM7dkAnEkKyG5qt
 oKemnI4U1CObCTnZeZP6DJ4TQIauZ4Nch4GGG4G/7PTHG948dVA6I0UJfO2/dWruqC2zgAn3Lec
 WB/nxKUtKEn0SiG6T367K1IAdZKUvfXHQQliLTuYUztkamK2jFOyDrUkOyIUPfyE3EuQ==
X-Google-Smtp-Source: AGHT+IEWvN7p+//FBA0ZWuYE/ju84/9e7kbleh7+rVusIpr2gqwtw5rmDBj/w5lml3Dwrmd+cYa4fw==
X-Received: by 2002:a05:6602:6088:b0:940:d6df:3b19 with SMTP id
 ca18e2360f4ac-945c97a0686mr416324639f.12.1761743640638; 
 Wed, 29 Oct 2025 06:14:00 -0700 (PDT)
Received: from [10.240.88.227] ([172.56.16.75])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5aea78e2fd4sm5585459173.26.2025.10.29.06.13.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 06:14:00 -0700 (PDT)
Message-ID: <3cdafcc5-dc91-4612-b53b-8b6ad92de7b2@linaro.org>
Date: Wed, 29 Oct 2025 14:13:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/37] target/arm: Use flush_if_asid_change in
 vmsa_ttbr_write
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-25-richard.henderson@linaro.org>
 <CAFEAcA83Tgv5CV+EjMDemEb5FQkfAj0en7dq1g4JkxHZ1kKOdQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA83Tgv5CV+EjMDemEb5FQkfAj0en7dq1g4JkxHZ1kKOdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 10/20/25 16:08, Peter Maydell wrote:
> On Tue, 14 Oct 2025 at 21:17, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Only flush the subset of tlbs that are affected by the ttbr
>> register to which we are writing.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/helper.c | 19 ++++++++++++++-----
>>   1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index c6d290ce7c..2b55e219c2 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -2943,11 +2943,20 @@ static void flush_if_asid_change(CPUARMState *env, const ARMCPRegInfo *ri,
>>   static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>                               uint64_t value)
>>   {
>> -    /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
>> -    if (cpreg_field_type(ri) == MO_64 &&
>> -        extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
>> -        ARMCPU *cpu = env_archcpu(env);
>> -        tlb_flush(CPU(cpu));
>> +    /*
>> +     * If the ASID changes (with a 64-bit write), we must flush the TLB.
>> +     * The non-secure ttbr registers affect the EL1 regime;
>> +     * the secure ttbr registers affect the AA32 EL3 regime.
>> +     */
>> +    if (cpreg_field_type(ri) == MO_64) {
>> +        flush_if_asid_change(env, ri, value,
>> +                             ri->secure & ARM_CP_SECSTATE_S
>> +                             ? (ARMMMUIdxBit_E30_0 |
>> +                                ARMMMUIdxBit_E30_3_PAN |
>> +                                ARMMMUIdxBit_E3)
>> +                             : (ARMMMUIdxBit_E10_1 |
>> +                                ARMMMUIdxBit_E10_1_PAN |
>> +                                ARMMMUIdxBit_E10_0));
>>       }
> 
> What's the value of ri->secure here for the case where EL3 is
> AArch64 and we're in Secure EL1 at AArch32 ?

Um.. the state of the cpu doesn't apply.
ri->secure is true only for TTBR[01]_S.

I'm not sure what the question is?


r~

