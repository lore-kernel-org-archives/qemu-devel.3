Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA389C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 18:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTlUZ-0007KO-BB; Mon, 23 Jun 2025 14:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTlUX-0007Jg-Fg
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 14:02:01 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTlUU-0002wA-UR
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 14:02:00 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so4804825b3a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 11:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750701717; x=1751306517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kbHMgtzWklqNdOGW+IyW6dAgYLbKfMIAfv4Rzs66Yjg=;
 b=FuCGOhohZr5pFXjYoE/BGEW8DbH//H6VD6o5Wrgeu4/viHyCnFdilIaW/Z52pfHwxQ
 APPeOU3YWWyCScTNgucZGao0D6/CEf6WNC76eZXoezhFD7shek/LvaIFgG+MHedD0QTE
 WbnkYSiHNh+DooxWvTEu02jlAixcbsuITJ4hRmMCQECPGUorrktYlxFIF568WI0CSgkx
 A3UKc5nN3uw0xTEgG/4QcQXHewO4pBj3P5hbgbalDPDwu43D5yJHnI4JbC1kgEfpNr+J
 LkRWQEVWqmH6zjuZyV+qrFCAT6V4c+jij0j4WMQTpNHka4z+lCkXdI/UWtthOE483M9y
 rXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750701717; x=1751306517;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kbHMgtzWklqNdOGW+IyW6dAgYLbKfMIAfv4Rzs66Yjg=;
 b=WzOFvVjZ60wyfmkzYOdjD+xLyykJ7IM8S6J8VuqYQJwDOtalXLf5/rPwtInXl76Nvq
 YHFsOg7eS0ZGuLTFyZUAx5seNpE8i4nrxrujiDqV+esUS9u9HmNdAJvlRRqdlopzpLN9
 spESjkiO2bvfkp2w5eYrdmqtfoJ15UwJcEvkV+fhECKRZs77m2k+MyAtPO8YiW66Iy+L
 7kjR/ZbetZWzw1m5DSfAkir25spVJ4I8/n+jwU1Yzu8mduP7c5JwHwiyq9pRu6MJjttN
 8o1j17t1zQMWxNpFIpt3kIkiILt/3AQEqklQ+p2RZ66nC1CxsVKI2yOsBFwmlNFowFhS
 CVyw==
X-Gm-Message-State: AOJu0Yx/d06P638n1hKao58+fnVkRfl3Z7P/MJwsqMsdqLx+Xu80MbRQ
 AyIosc3pf7Mhl490Y9teEoByyVBFxRd2Wz9uh3OJa0j6pUSnBlwXh+oPwWuSzb2iLPHZFQ9vofq
 nD2H9Q6A=
X-Gm-Gg: ASbGnctQSDNsQQmSHHwRDOUKIANAJ66nBjrBrXbX2EbKbTiT3vFWW1NWeEIH/N9oGb5
 CWQMBzqjbTl8crkYg9uTG5giUE9f+O2C+dr0KtK03pw2Wyw3sISXAQFKmgDDof1d+GU/HKR4g02
 rYvW6GYm/qyH2GWDQ43mLAhLLmLHShpNWl3T7asLO+xpz2H4KF9WuUnkao/m87Eq/SGbKua6Afl
 NFecTQwYbTMQCiIJ8mH4zuXS59E4CuzEtGWyPDPdLR7Vw509DxXbXg1pmoI8nSOBEiQ8Nz+9wEU
 yyT4wBrF/AI3F5t5sZP+l71JHgdACjvR6+R59l2hrXt8oEeuQ2GSAPBhx5VoklNTDEwjaZpbnEQ
 xu6oWd+ZI801iumHYyU3HLWL1Hi2h
X-Google-Smtp-Source: AGHT+IGOQryLAYwpGGsrmRTeHCffRbdW0nPIlNQDDLzKKQdiC9pDKetn0WqkAjzrWCIE3OK7e9g64A==
X-Received: by 2002:a05:6a20:7350:b0:21f:62e7:cd2d with SMTP id
 adf61e73a8af0-22026ed2595mr22776467637.34.1750701716749; 
 Mon, 23 Jun 2025 11:01:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46bc2bsm8883164b3a.28.2025.06.23.11.01.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 11:01:56 -0700 (PDT)
Message-ID: <ddeb39cc-28ea-4d4a-b122-48c19d4bcf84@linaro.org>
Date: Mon, 23 Jun 2025 11:01:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 039/101] target/arm: Remove helper_gvec_sudot_idx_4b
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-40-richard.henderson@linaro.org>
 <CAFEAcA_6egE3UjyPHS-H7s+LuNc8je6=2YqLo42rTLRsXhdzDg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_6egE3UjyPHS-H7s+LuNc8je6=2YqLo42rTLRsXhdzDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 6/23/25 10:00, Peter Maydell wrote:
> On Sun, 22 Jun 2025 at 00:53, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Add gen_helper_gvec_sudot_idx_4b as an expander which
>> swaps arguments and uses helper_gvec_usdot_idx_4b.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/helper.h     | 2 --
>>   target/arm/tcg/translate.h  | 3 +++
>>   target/arm/tcg/gengvec.c    | 6 ++++++
>>   target/arm/tcg/vec_helper.c | 1 -
>>   4 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
>> index c459eba079..2702627eab 100644
>> --- a/target/arm/tcg/helper.h
>> +++ b/target/arm/tcg/helper.h
>> @@ -622,8 +622,6 @@ DEF_HELPER_FLAGS_5(gvec_sdot_idx_4h, TCG_CALL_NO_RWG,
>>                      void, ptr, ptr, ptr, ptr, i32)
>>   DEF_HELPER_FLAGS_5(gvec_udot_idx_4h, TCG_CALL_NO_RWG,
>>                      void, ptr, ptr, ptr, ptr, i32)
>> -DEF_HELPER_FLAGS_5(gvec_sudot_idx_4b, TCG_CALL_NO_RWG,
>> -                   void, ptr, ptr, ptr, ptr, i32)
>>   DEF_HELPER_FLAGS_5(gvec_usdot_idx_4b, TCG_CALL_NO_RWG,
>>                      void, ptr, ptr, ptr, ptr, i32)
>>
>> diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
>> index 8cf6324e2f..90a03a4642 100644
>> --- a/target/arm/tcg/translate.h
>> +++ b/target/arm/tcg/translate.h
>> @@ -627,6 +627,9 @@ void gen_gvec_urecpe(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
>>   void gen_gvec_ursqrte(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
>>                         uint32_t opr_sz, uint32_t max_sz);
>>
>> +void gen_helper_gvec_sudot_idx_4b(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
>> +                                  TCGv_ptr a, TCGv_i32 desc);
>> +
>>   /*
>>    * Forward to the isar_feature_* tests given a DisasContext pointer.
>>    */
>> diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
>> index 01867f8ace..c182e5ab6f 100644
>> --- a/target/arm/tcg/gengvec.c
>> +++ b/target/arm/tcg/gengvec.c
>> @@ -23,6 +23,12 @@
>>   #include "translate.h"
>>
>>
>> +void gen_helper_gvec_sudot_idx_4b(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
>> +                                  TCGv_ptr a, TCGv_i32 desc)
>> +{
>> +    gen_helper_gvec_usdot_idx_4b(d, m, n, a, desc);
>> +}
>> +
> 
> How does this work? In the DO_DOT_IDX() helper functions
> the 'm' argument is indexed, so I don't see how we can
> just flip the n and m arguments around.

Duh.  It doesn't work.  I wonder what I was thinking...


r~

