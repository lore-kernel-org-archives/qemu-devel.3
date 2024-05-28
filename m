Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578BFC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 17:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC0fI-0004os-0a; Tue, 28 May 2024 13:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC0fF-0004lA-28
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:31:09 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC0fC-0003Vf-55
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:31:08 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f4c7b022f8so9391735ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716917464; x=1717522264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NB/nwVrrgDBRHouywkuXvv+N8TsBDL8RdTXXYQhf4mY=;
 b=yxRFxIbfZJnu1eSK/JJmqleOgx/IeMl4qLN5utWmpWJEFfM0IHbmK9pve2LGUHaJby
 hjIIIV7eDwStfUaHZ8GeFzuynjdv3uha87ftJpayd6s3u//ZNCX7JMxS+YK7vnr3MDwP
 dgSwplwCjiEoYsX64RrA+MBJ/15UCZT2Mhi+hZF7YB+7+9gmJ6pvaIIlsiznCpGf6STD
 JLKA7Plyg4KkgyWh8pirTaCYYbsRgriLnKvOED0ygXkfVP+PUSzBeKuiv+1Wwcuskc4f
 iuN+loi1o91YBVo8beXDNf4QKJUaw2xyn5OKnlVksjxvXBwUtpZWt6HdpgJ4LC1DJdmB
 9MTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716917464; x=1717522264;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NB/nwVrrgDBRHouywkuXvv+N8TsBDL8RdTXXYQhf4mY=;
 b=M+mxZQNyiTlm8yElCloJNWUhE2ESfCvp2pY78pP4C8EaRnDXw4xhf5OMjKNibi9xkx
 vloXAtnQ5KsCdxxGh3Bmz0jaGbIgZPXbzKfo/lWKd4eqV+sz/Zugh3eo2739cPliSAZE
 7v+9yA1hsg2kv1EqOcLxCYvgHLHbu5F6sxCjbt1xrN1RTKz+JDjmuYo4MuJPbu49RkfH
 G0aReBWWKi1UjYw28v/ABKiE/zqAWoHwcwT1BZPoHw4YDY6jzuUPD9/ic2J8iX3Ws+xP
 X5ilLp7Dvv4KueRsZrIHHc75oQXBemtf+IKBLBwqIKJh/Y5pWMneM3+7/F+rf/6R+cBZ
 kVkA==
X-Gm-Message-State: AOJu0YybZYZJgu116YE2gz5H1BUTMgDfOvFgITfrXj9sLCJq+DPK8ALe
 HUTpwQaef9GoJwpgySk38bP4DH7bBoY5B5sjZ2ziFrbj4/Kmn02oMxk+rmgd+4ZkiWnnoymO/kP
 t
X-Google-Smtp-Source: AGHT+IGGKuaPkzfPfZ+pC2q8vsc8BZZEhC7bFrNq4z9bFpaSlw80J9tMK5vkKrkPlfWiQFT0QUTkOA==
X-Received: by 2002:a17:902:e746:b0:1f4:be9b:d30d with SMTP id
 d9443c01a7336-1f4be9bd7b0mr37317795ad.25.1716917464587; 
 Tue, 28 May 2024 10:31:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm83033435ad.10.2024.05.28.10.31.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 10:31:04 -0700 (PDT)
Message-ID: <ebb37b0c-0ea6-4bfc-b704-1a006ae34acb@linaro.org>
Date: Tue, 28 May 2024 10:31:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 46/67] target/arm: Convert SQSHL and UQSHL (register)
 to gvec
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-47-richard.henderson@linaro.org>
 <CAFEAcA81fGFByCYbqYvDRWXib99tYGfYcujfBapfrsMxenMJmQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA81fGFByCYbqYvDRWXib99tYGfYcujfBapfrsMxenMJmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/28/24 08:53, Peter Maydell wrote:
> On Sat, 25 May 2024 at 00:28, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/helper.h             |  8 ++++++++
>>   target/arm/tcg/translate.h      |  4 ++++
>>   target/arm/tcg/neon-dp.decode   | 10 ++-------
>>   target/arm/tcg/gengvec.c        | 24 ++++++++++++++++++++++
>>   target/arm/tcg/neon_helper.c    | 36 +++++++++++++++++++++++++++++++++
>>   target/arm/tcg/translate-a64.c  | 17 +++++++---------
>>   target/arm/tcg/translate-neon.c |  6 ++----
>>   7 files changed, 83 insertions(+), 22 deletions(-)
> 
> 
>> +#define NEON_GVEC_VOP2_ENV(name, vtype) \
>> +void HELPER(name)(void *vd, void *vn, void *vm, void *venv, uint32_t desc) \
>> +{                                                               \
>> +    intptr_t i, opr_sz = simd_oprsz(desc);                      \
>> +    vtype *d = vd, *n = vn, *m = vm;                            \
>> +    CPUARMState *env = venv;                                    \
>> +    for (i = 0; i < opr_sz / sizeof(vtype); i++) {              \
>> +        NEON_FN(d[i], n[i], m[i]);                              \
>> +    }                                                           \
>> +    clear_tail(d, opr_sz, simd_maxsz(desc));                    \
>> +}
>> +
> 
> Same question about H macros as for patch 44.

No H macros needed.


r~


