Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFEFCD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUfW-0007af-Qf; Fri, 22 May 2026 14:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUfE-0006jP-Ua
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:32:06 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUfD-000872-51
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:32:04 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-83d31ac4017so3847746b3a.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474721; x=1780079521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9xJgHAKaFTjdVYpSRJIewfGuxYZa/FlXhCL+byl3Ess=;
 b=OVHi74Fc2L4DK6N9VIOPz+fKzQX9pmj1QCzEQ6P2+wBWBW416NMP/iH9fuP+99pI8h
 rlNc5RX+Jo5ymoMZ2h9mw/W3qujZB/siqVycLBfivArIsi2qMtJNkallMZOB05FbIiEE
 N5TpjcN4h1grh8LJziWgpSxnz+8n1K/WcfZtQOp11nhbQyR4r8VNrEERvTJ8noM4w3R1
 2O1qQXHbwbwb2PZOn5uC+QnjWx2SuUHncU7YHiIQXmPp1rJOl9pPcsL45pjEfz5k8oRI
 bKmlRHfu+G7P/75R6OHI5yxwlrklBiMYXN09dncicBtVwyuJvC7yZK5Kv1sB0tMpPFGt
 CIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474721; x=1780079521;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9xJgHAKaFTjdVYpSRJIewfGuxYZa/FlXhCL+byl3Ess=;
 b=TCDs24quQP1bIhYdhxpyepeWSYMfZL7SpBzWAKWAtSXTxvdFQ4gHJ/fpbT1DsAZRnG
 fvPtpivX8JhfmXfUo7CnSJO3yT184ZK/CK1b2Z49H0a6AorOnPNvJ7Gxt7qv+6G//+o7
 vTCq11JgcsyR7zfQ5DP285vnAjIWw+gIrvqIfnFwgtDAVI1OlzYKEYNEj7xUDan1DIhQ
 ourg2LbEnNoxoE96QHpRKNsfC4KTybkMMFpSCNYPqvsRiUWc5npcDzvPyVQwaVJsRZts
 u9WJGSFd0EjHfIayLQSeC5bx3qVbWgtXywhX1o53wqAbtUJ+9cjtl+X9Tor4/9/uTrMp
 ioDQ==
X-Gm-Message-State: AOJu0YyqD4ynQRDobdGUHqqhKDEwlCV+tv0tzLHFnOHEA9Vjf1lOvLoi
 4izIKP4HbeQfWBd/uCHwSmHzALGl2Rs2dGs1BYn1TYgKpR7v2S1PHXmWsnWkiztxoVoMTkr7N6u
 5cCPO
X-Gm-Gg: Acq92OH2I4p+LRpG9uFhYSzm4ywNlNqHAaUaXJcyb99XTX4aaWg/j7I5anoVYvdZQxj
 PS7p2GL/7HR22cweAw+3HRHnw0CIgtdN7TQS/m+lTCrT5UWaHujOVDzkVYe4FYmeohWi5vNsQIb
 1/bRAajXIjmJxSZzR2qEkhvSGRDI/eHKWcKPKZAQmdeIXH75avUSDhUg1Hm/H2mMB1Te8iwBB8z
 gZw54hT2CNlJ+qote7pJbQKdwOOJoYCMWTTvlXhQxjiQTVZBJNkLSEFsdsSUtEDdX2dNwlqmBkc
 /c9KJ+AwuzkoubSx9ccApdYheTW41n5qD7pIGm0fn0YKvP8SY4Fu0sij4RhGOkMAdj6Y52vK9LR
 FZpAuPOTgJchuZ8BUkcLqWYj8Q3HkcTVpV9OfTqlVpQh/agTadELvMFaQos0tczJxveMQV4sDPX
 c7AawrVCVepfTkXH98Ih/3ngdCmv9MiE3yBlSBBrqm
X-Received: by 2002:a05:6a00:2408:b0:82f:74dc:5f48 with SMTP id
 d2e1a72fcca58-8415f583a5emr5042094b3a.2.1779474721349; 
 Fri, 22 May 2026 11:32:01 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164e9e7a5sm3339464b3a.33.2026.05.22.11.32.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 11:32:00 -0700 (PDT)
Message-ID: <ce862e7f-f1fc-4b5f-addf-a630e443a2ad@linaro.org>
Date: Fri, 22 May 2026 11:31:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/64] target/arm: Implement ID_AA64ISAR3
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-2-richard.henderson@linaro.org>
 <874ik0okia.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <874ik0okia.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 5/21/26 08:22, Alex Bennée wrote:
>> @@ -6752,6 +6752,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>>                                  R_ID_AA64ISAR2_BC_MASK |
>>                                  R_ID_AA64ISAR2_RPRFM_MASK |
>>                                  R_ID_AA64ISAR2_CSSC_MASK },
>> +            { .name = "ID_AA64ISAR3_EL1",
>> +              .exported_bits = R_ID_AA64ISAR3_FAMINMAX_MASK |
>> +                               R_ID_AA64ISAR3_LSFE_MASK |
>> +                               R_ID_AA64ISAR3_FPRCVT_MASK },
> 
> With this definition should we also add it to arm_clear_aarch64_idregs()
> which clears the other ISARs with aarch64=off?

Fixed.


r~

