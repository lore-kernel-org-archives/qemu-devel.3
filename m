Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4DDC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd8Yb-0005Bl-K6; Fri, 26 Jun 2026 11:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wd8YZ-0005BR-Rl
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 11:33:27 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wd8YY-0002c7-F1
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 11:33:27 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-37f816d01e3so311177a91.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782488005; x=1783092805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TY4VJnVWbgwM9PZOPKlVWdkQ9UB0qMHBSCt7DLzJlVA=;
 b=sHFih14lRrV3WT3TG7ORAd41R0eFtNebzriB/HOCI8WGoW0gGReLtfRogkDdX+orsJ
 +8EzEb48cGNTbcQaYzut/xfdCDhAYIFrIqhWhdoSHFFkiHNd1UG1v2M6wCBcjPrf0j8q
 J8qeVs99jrV5nAgNZko1hrawB1oYQ22LqxKyD3h5dV/NECqX76442jlmtu+DSgPzBs1H
 z7/+wv8i1iAL2B0jUlH9p/KAgQh3bjylsw4xG3GxeVNECPGB2DLhw/qH2TpJn0m2xrgK
 w/A/XvvdkBxFnV0nuQPRCHYox8i4pQqZfHyGAPRMlECXSfWr2siICK2mPbotXqXZf8TM
 ++0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782488005; x=1783092805;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TY4VJnVWbgwM9PZOPKlVWdkQ9UB0qMHBSCt7DLzJlVA=;
 b=QD5rpqYMDWx1sUkGOBTJJgftPlyRUwmpA1QUrdRL+TLXCUjHiFATIghHgTjUaO0mEq
 0m4E2eITRtl/hiBQQuUT9vvUn22AANbAxweeXdsCe5HLo9Qq+HHmSwNo+YBxR1BuXbFV
 GuHPioD6nEmOmMP3EMzL0MSm+E2uaPziCJRKS06q0Amwl8y42J6Q/Hhl+M/iNPXUtI4A
 6owrq6zYAGWI/E1hzkABgfE0XUJZQuVZLhYR/d3kk/LXlpyswR8jq+DCItUWbbR5hTKg
 LkLjN3wLGt9t6yaTwjgXK2QnXeKQStwTHrA9JbRODpo15FYELJrEO7UTr/rMq2arH52w
 LoLg==
X-Gm-Message-State: AOJu0YxLkmZqoS4Vo64wOngBTgOLI1TvTLv+yT4YqwBBgt5U+Svz6T8D
 /cG0JMgluWvaEcswfQaWnUvfbHazSXSJ7ywrPf5kN6yDe0t3GEuJcxAHv7JlXE+isdk=
X-Gm-Gg: AfdE7ckEgwM8pBh3clF0jaOeRLpd7yaFl6sNy/j4DGOTymUHcqtnBXkrodf45AupSoL
 EwhSFHGtODlVID8HEkETlsEB8yGqKvuJPHQ7Qo+lKDfgFsj5VhoX7mtBDJMLyinlgD/Qlhkon3P
 k65U+OIQmmOdG2enn4cbHD3URavIsVVB0vPQPfSjkiXz2K0gowQsnQiP2XSS0CgLq+nWgxjf9jk
 LkYguaA/rjPPvETokJ1vWH77I+lxRIXsIpvpXMtkK7jyiavlPPBGZju59bQIRg2PZkCgrBvmVdc
 LCZJ415RS+asX84CWHloti2mcDhdoOt+FMEG0Udyp3v8Cs6SuhNL8DhrboJoENLs6OoS8zX/0vj
 1/NLQ2UW/57OwMEABd3vJUz+mj9cR0kAZx9VTm4RMA1WX8Xy4xxoE+ePjJVbRv+wIbe7qmXckce
 mZbRZdLhIySZgxXyWSJqOYMVTkrXZLSV3QC16uX7Hqw0AZVj+RwuxW7q0uwA==
X-Received: by 2002:a17:90b:134c:b0:37c:e729:27ce with SMTP id
 98e67ed59e1d1-37dfa1bca8amr6903400a91.10.1782488004532; 
 Fri, 26 Jun 2026 08:33:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37e12c9229dsm772117a91.1.2026.06.26.08.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 08:33:24 -0700 (PDT)
Message-ID: <ba12bbcc-5801-40ad-b710-f834128816c7@linaro.org>
Date: Fri, 26 Jun 2026 08:33:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] target/arm: Implement FVDOT (FP8 to FP16)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260625015159.719300-1-richard.henderson@linaro.org>
 <20260625015159.719300-10-richard.henderson@linaro.org>
 <CAFEAcA9fCEyLoDvYA2JR30+7ZGaN_t_taRK01gb9y4k4NNe8HA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9fCEyLoDvYA2JR30+7ZGaN_t_taRK01gb9y4k4NNe8HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/26/26 02:27, Peter Maydell wrote:
> On Thu, 25 Jun 2026 at 02:52, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> 
> 
>> +void HELPER(sme_fvdot_idx_hb)(void *vd, void *vn, void *vm,
>> +                              CPUARMState *env, uint32_t desc)
>> +{
>> +    FP8MulContext ctx = fp8_mul_start(env, 0xf);
>> +    intptr_t oprsz = simd_maxsz(desc);
>> +    intptr_t elements = oprsz / sizeof(float32);
> 
> Shouldn't this be sizeof(float16) since the output elements
> are halfprec ?

Oops, yes.  Thanks.


r~

