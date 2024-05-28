Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CA0C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 17:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC0fu-0005w6-Se; Tue, 28 May 2024 13:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC0fr-0005tv-Hs
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:31:47 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC0fe-0003a0-1W
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:31:47 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f4a6a54416so321735ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716917491; x=1717522291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Sp4Uj6nZT4QoOVoftjDPfPlgroRzXW2lSa8BSiQ4+k=;
 b=CTXlXDfdwjq/PZiy9RweN5qi8QEhb5j9pd5f3EQZBl2O5fIfQWxWLEqV3u4fyWnLuj
 4jX0SCgNEAjxpSnVoDga2+RvB45hpOuZKbKVsEHuHgDQvfh8Q/TLYjNzBdEPl3BlCMAs
 e3Bp8gnYU2jmiTGFbEfvQJoiiHrkC8r1p6Upg5iuwCZOezE0mAbZA5MWpO2/fa4gLLia
 mKmSo422O8Oii/aYw8tVpzDIda2XILQ4yE0820XssWpCyLToX0Pe4+BdaNYdC5CBG0ae
 r7oKIy2SX1YA62nONisCl62VXuOhaGuA9oHbeBtl71sMO+rr4VljBfCOsQWyCoSouJH7
 jb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716917491; x=1717522291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Sp4Uj6nZT4QoOVoftjDPfPlgroRzXW2lSa8BSiQ4+k=;
 b=H4n9wxeBJbRpQUAjrq29afmqf0F6LgNhgA5EKoAopQ/o3Hr/CYY2ik3wKGc/VqF2dm
 4ZBZjEZW0IDDa18SUbZWxp4u1r7bv5f57uJ09RHO7MuxJ+k7cmoy4cWIdAGWnzaFq+PV
 sWbu+fhOGXZLBsHAk4lKHUztgzWPjuigTofvFfNkAeWj3pmlIW2LtZ++g2dC4jPc15GJ
 OsWogYzmgsJcgwrx5QhjsMv7FoY0mup+Vh9rtM1PsHUi24jdAxN1Sj+S9P5sxV5qhDt+
 B3u8O2Ku5QgWFOSyKFWU/KAARhQAKQKpkqjhtc7SdwpZxArJr0U4GdTL9OcUIbIf4TUK
 pNBA==
X-Gm-Message-State: AOJu0YxQIpMV7rDfFbxNgaDHiKcjz3fVxpvnoMV2oKl1OwRKjI+9nPUB
 t6JJYdWHV3RWOHapjc1yFS3crkDhIMA83R8+u/NM5xM0x8dpuAf/vkpVY82hl4s=
X-Google-Smtp-Source: AGHT+IEtKAKE0Qm4+Spi1blI4DXOhNc700R5/PPC5bak8rNpMWs2+KQ+TdmvqBhuwtqHS2SxRPx68Q==
X-Received: by 2002:a17:902:d2ce:b0:1f4:a552:7e83 with SMTP id
 d9443c01a7336-1f4a5528076mr70519945ad.31.1716917491485; 
 Tue, 28 May 2024 10:31:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f4b412a5fesm32292355ad.239.2024.05.28.10.31.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 10:31:31 -0700 (PDT)
Message-ID: <b81a2145-99c0-416f-93fb-ff737d487198@linaro.org>
Date: Tue, 28 May 2024 10:31:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 66/67] target/arm: Convert FMADD, FMSUB, FNMADD, FNMSUB
 to decodetree
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-67-richard.henderson@linaro.org>
 <CAFEAcA8tSj=5QNBKb72iZ0fmYRBGf7QjpK-0YtpbF5sdBMffxQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8tSj=5QNBKb72iZ0fmYRBGf7QjpK-0YtpbF5sdBMffxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/28/24 09:15, Peter Maydell wrote:
> On Sat, 25 May 2024 at 00:27, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> These are the only instructions in the 3 source scalar class.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/a64.decode      |  10 ++
>>   target/arm/tcg/translate-a64.c | 233 ++++++++++++---------------------
>>   2 files changed, 93 insertions(+), 150 deletions(-)
>>
> 
>>   static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
>>   {
>> -    if (extract32(insn, 24, 1)) {
>> -        /* Floating point data-processing (3 source) */
>> -        disas_fp_3src(s, insn);
>> -    } else if (extract32(insn, 21, 1) == 0) {
>> +    if (extract32(insn, 21, 1) == 0) {
>>           /* Floating point to fixed point conversions */
>>           disas_fp_fixed_conv(s, insn);
>>       } else {
> 
> Doesn't this result in the unallocated-encodings in the
> fp-3src class now falling into the "else" clause and
> being mis-decoded as the wrong thing? I think this
> needs to be
> 
>      if (extract32(insn, 24, 1)) {
>          unallocated_encoding();
>      } else if (extract32(insn, 21, 1) == 0) {
>      [etc]

Agreed.


r~


