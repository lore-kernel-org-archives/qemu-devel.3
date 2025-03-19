Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6836C282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 01:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tui3H-0007fg-2K; Tue, 18 Mar 2025 21:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tui2t-0007YM-Fq
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:16:39 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tui2r-0000lY-Cv
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:16:35 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-225e3002dffso70692755ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 18:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742346990; x=1742951790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ac/EPeLpivdewdCOr1s6nOgo38GWkws/nd7TB5d+KUs=;
 b=g3nAGOim/hboCq8j8YWODtKrnf17Vjvop7zGl5ogbD6SlKJry/hrYH16juVA2C0SHY
 tyIcfQqSG/aRksMrZtUd7n49Soqh4gORExYYesSGRJoWBNnpTY2IWdKFhVkG6tLmOkgW
 u1/dNvUuS2UJ2fbgaD79MJIG5xxjz/faE4S2GgvsLXjSBcGBNu/E24rFVFN7LPksAfws
 vq6ZLTmDZGUq4FxjLTnzkIxIVxnR4Z7ffc7Q9cNTh3NVpcw3nG0N3xuNdvK5LlAPFN1B
 56WDTHNbs0oUNXagWqeFcxUQt1LtlsaR95TsKTpKtvupYtP90wPDpoRSeU+ADmPELXqV
 QtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742346990; x=1742951790;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ac/EPeLpivdewdCOr1s6nOgo38GWkws/nd7TB5d+KUs=;
 b=h+29IPOenooYxzBY/yTYckbDhl6K9RGGMiVlhR57+QJFlWligMJXjjqq5IDoHZcy0c
 gEcAhm1dFcJRNN3t/NB/pbH4oXFoNvJXvL67dZOjrrM+ptMKksVnIc3XyBk1HoN1Aauf
 gS/Epzjyxmp3gvyxMhYWIkyXDugXsLMWTNpCfBGNlfI7QWAMWm8YNOv3VNrm9y8QFRDu
 KDuxNV4aIXC3jwJnQfaTa5r1CFaQW0SBl3s3yBJ6Zo55g/G+/fHY/MTgvu6OGVgKjqfW
 lcDCCbbFfpgEdhAF2wabJstWf4Y3P2sqEE6TS3+hJlWyQTqJk4Erj+1WOsDdROXK8kEi
 nlPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURVNOb/3fheJ/GviFj4IiQRnjRghKg0j+uPMC5FajREr01r15q9BdIDCurZvtDGDsLs7mCWWrAPV6R@nongnu.org
X-Gm-Message-State: AOJu0Yx+fdcmMT3U/tC6/QesHPjNTUCACFJhHIAQOokyaXlqv609sI7U
 01fuG79gUwyMTCnxya1FO9WBmxDChspQBUDrrJoZQjyyyFE4CsPVGROSMVU5vHo=
X-Gm-Gg: ASbGncvokrAik+lwBqWd3bPI+/VPyC2IuCdf0FWIKCkoSDUJv7nBDHA0nESg/2ovI6I
 jech38T3aPlDYN/ydirZtTaaHpDlt+Nq7/aSBYfYy3l5zITqqA+btfe5DqAjN1E2hnWMCJwBxQB
 rxDirD4monpRwQ/pFE59VQCuwyl2mPNbVBuOG+NlTCOe2xXMVuYVunFb6Dho/aFRqmywj6wg0cA
 YMJDLuvn7VJi03OEHuq/9sUb1CO+PMR/kFDGbb3vHJ/kxGvkhPGJrU/aA4UkRiJsixk3H0gO1Ui
 AkSzdIcsxH7tMY6ATIx5qxwFMgbsj+BOivIDlbvPZSCpuPmo4SjPl3JsMRvri1gdoFMGdIilV6c
 K3HB9OR4m
X-Google-Smtp-Source: AGHT+IFZtoLbibdwQYGfdO5vr5SNBFUsRWGP78hA2I2Wn2KvNZstYNVgfWzdqDfuEFqjSJYBwBaa1Q==
X-Received: by 2002:a17:902:f60f:b0:220:c4e8:3b9f with SMTP id
 d9443c01a7336-22649573a26mr13968425ad.0.1742346990088; 
 Tue, 18 Mar 2025 18:16:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6d5dsm102026685ad.153.2025.03.18.18.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 18:16:29 -0700 (PDT)
Message-ID: <b039499c-4c0a-4eb1-ae74-ce1fe5386f20@linaro.org>
Date: Tue, 18 Mar 2025 18:16:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/42] include/exec: Split out cpu-mmu-index.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-7-richard.henderson@linaro.org>
 <c76d7019-7087-4522-9b49-bc99fa71436f@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <c76d7019-7087-4522-9b49-bc99fa71436f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/18/25 17:02, Pierrick Bouvier wrote:
> On 3/18/25 14:31, Richard Henderson wrote:
>> The implementation of cpu_mmu_index was split between cpu-common.h
>> and cpu-all.h, depending on CONFIG_USER_ONLY.  We already have the
>> plumbing common to user and system mode.  Using MMU_USER_IDX
>> requires the cpu.h for a specific target, and so is restricted to
>> when we're compiling per-target.
>>
> 
> A side question: Why is MMU_USER_IDX different depending on architecture?
> I'm trying to understand why (and by what) previous indexes are reserved when MMU_USER_IDX 
> is not zero.

Depends on the translator, but often: cpu_mmu_index may be encoded into tb_flags, and the 
translator *also* uses this encoding to determine the priv state.  So if, in user-only 
mode, we fail to encode MMU_USER_IDX into tb_flags, we'll get incorrect priv checks in the 
translator and fail to raise SIGILL for privledged operations.

Depending on the target, the mmu_index space may be quite complicated, with various 
meanings assigned to various bits.  Thus "0" may not be reasonable for MMU_USER_IDX.

See, for instance, enum ARMMMUIdx or ppc hreg_compute_hflags_value().
(Both of which, amusingly, use MMU_USER_IDX 0; neither here nor there.)


r~

