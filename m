Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4962C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 03:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXWqc-0003KT-GA; Thu, 03 Jul 2025 23:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXWqX-0003Jl-U1
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 23:12:17 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXWqU-0007T2-Oy
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 23:12:17 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2d09d495c6cso245038fac.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 20:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751598733; x=1752203533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0EioKaM8sJL4SY4I1DN+rMfzBhecT8dcNSRvDuxOOjc=;
 b=ZLMUSy4N3w+3ZANTQfFOfGeHLD8G8460aZmGwwaEKeYFJxZLhefjvHQgFJIO0srZfo
 y7vqnRytr01+jXGWHykAcW8Xyc9gO4YN06IavBvNZXZLeDCqB5sp9tDNyRLy18Cy6mY1
 AidMR9gI3GTukHFLtfzUzEgA3UiAv+qLvyOOWh77y6uiY8aQKvoMMdIL5awi+0zhEPW0
 +q9EmHyWjtubgX4wCCdvqYl9lM9xciyNkqzPnS8VUsykPEeNaj45rGTVaBHinoYdKr5r
 LsTU70qTYH16y3FLxJIZoLyXa4K4TJTiVRWHMTUhi9BPMfk4on88XePJGY6unKbU6pU1
 bolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751598733; x=1752203533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0EioKaM8sJL4SY4I1DN+rMfzBhecT8dcNSRvDuxOOjc=;
 b=MeG/j/6rA6JkPjwGlc1mlULxrMu6EJ0pu/ehftpuRxCiIU3/ZRNVRIavYIgS4sErns
 1P9NNJGBEotDHsqQ76ncoLmCFQGvG2PcVCB7jXKGhND1OGm3yFJXmbHTBy/8ag6LgalX
 /6AZM84lDQkb1AaygJUza+bkO3sobtLIJg6ibM/Lm05W36UspEDb4nP0o0a591+yITzl
 yRUITseyo1G/CSBbN9skboXDbanDQzeHHlSBVUpVwQcHzWy6i7IBCEuikBqsKpwInb4w
 bar4Ly9tiQdpSGRzO8RuHjA23SiT6YkcEGYIZE8/2Qib+XtD7TUz780AuaVzTXtYWiRL
 HzJg==
X-Gm-Message-State: AOJu0YxeZ4lu8HRpAXxDRxMktl5Hd5UWS2uw1EMZSZ6/MX+BstJBTjfv
 Ldkllmdr7SQwlvjMi/V22TdFXLXI54P/eYshSoGQGB8JEQ2i96bgJAab27Zp0TsPQM8=
X-Gm-Gg: ASbGncvClXM6ExgGolwpYlibhYcLoErn8kJL6BFu07zUD8pq7R6rj6qD8xl/YFtfzv4
 FRIL0SjQoEvWi+36z6B9Bv8pyovRXJNjrX6d9prnWtie9qvniRYh6bePuJJlvRjKhNwQA6Ao6Jx
 K1OW5uIVOAx/hScyfjeoX7SCfc09Iyic2pLkiEmStl7HXCw5upW5rMIkpTmhvndnAhpM8KkiJSB
 HC9icu/4bSCr/5yNhH4J7YJP8gOqRE6coCfwmFvIxRduAOMS34fK4MO0xokZMgR89/NEqj2samL
 X3ME9ZUj97eH0DlM9kJ0S8KCGFbsXNnDQgo41Z6AhmkvyEXIlmtmiQ1jzF71QlzZ9nLAGzB6Lzo
 Zj84T3GzOVtAcHeR6X3/S97waGxkPhaDE+FsW+9TP
X-Google-Smtp-Source: AGHT+IHtVvHlzb9pe6AYizvK475AMNHbfWAishd8by4r4npn0YngM/EqsEfzMpZhbZsslSejEYLRJg==
X-Received: by 2002:a05:6870:c05:b0:2e8:7505:638e with SMTP id
 586e51a60fabf-2f792168420mr987601fac.39.1751598732944; 
 Thu, 03 Jul 2025 20:12:12 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff050a4sm281054fac.7.2025.07.03.20.12.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 20:12:12 -0700 (PDT)
Message-ID: <65fc2bca-eba1-4736-96c6-59009d298476@linaro.org>
Date: Thu, 3 Jul 2025 21:12:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 95/97] target/arm: Enable FEAT_SME2p1 on -cpu max
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-96-richard.henderson@linaro.org>
 <87plehb3d6.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87plehb3d6.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

On 7/3/25 11:17, Alex Bennée wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/cpu64.c        | 10 ++++++++--
>>   docs/system/arm/emulation.rst |  6 ++++++
>>   2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
>> index 5d8ed2794d..f73729926b 100644
>> --- a/target/arm/tcg/cpu64.c
>> +++ b/target/arm/tcg/cpu64.c
>> @@ -1194,7 +1194,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>>        */
>>       t = FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* FEAT_MTE3 */
>>       t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* FEAT_RASv1p1 + FEAT_DoubleFault */
>> -    t = FIELD_DP64(t, ID_AA64PFR1, SME, 1);       /* FEAT_SME */
>> +    t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
> 
> With -cpu max moving to SME2 is there any way to test just plain SME
> now?

No.  What we'd want, I guess, is a real cpu model with just sme1.


r~

