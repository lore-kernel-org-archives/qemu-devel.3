Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC93C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 05:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubByk-0003Bj-3s; Mon, 14 Jul 2025 01:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubByc-00033V-0I
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 01:43:46 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubBya-0004Ue-6E
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 01:43:45 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b271f3ae786so2896479a12.3
 for <qemu-devel@nongnu.org>; Sun, 13 Jul 2025 22:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752471821; x=1753076621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sns50AXd/gFcIaCyFyb9jl1iRq2rW5M/Mpzem08cjsc=;
 b=oqw6F6XdC18bIjZkluizpJclNXoXMCt/hZlbKM9cIFbAlkmuZ3SvaM2pXFJWuJx7zZ
 KX+HGwbsRUh9pZG9LZF4FBxdwE7Hf+Sp9cCadAuM2DI754tUq+pXNfHs2l1JalTlzLaG
 7wLEKy+S4Xf+Yg27X+ZViZBy9FH9sbX42+qVP0iynW+nxrC0kumGZdzBSRzDxnEkRyAk
 zdtol5/dPJdVXal9f4jrbhZPo+eFcp3RI1tJgNQTajCmnPfH6XgDb0BdeVXHgshsJvMY
 RMTuHZ9E8sTW1ASeafcDoI90QUTz1sshr7fH8POl16s8l+3XZboV5gd2pptZQP1IL/ij
 eaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752471821; x=1753076621;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sns50AXd/gFcIaCyFyb9jl1iRq2rW5M/Mpzem08cjsc=;
 b=kP3HWGiyup+Po8ckcJ9DMp+IDogG0UP/vO2tXqCXgOy9uyoxPBG3o9S1P0zBzskDBm
 Ocw+99r+pmRbLe4B9bIfk3KLeI4mAptKgiA8HQ9kui2uCsI8Y7ZTcq/RyU88s7rayg7+
 M35lPVpm8CwyWri0sqyLsUWO4PHTNbQk40CdGafp+EDqiwmVS8agpdjw0DgqsxnnUYKR
 q+Hji+MOt8MwcrRA4eEYZ+sQbgANMX73PR9Z5d6/Jd84H1Qn0/emluUqa/Zy590EWj+d
 0MJ7/VZSSgt6nvAUXKd9PmYz6cBvaqBwvUdBM+SUs4znaiesYH8+RoK8D3VBHji/RS+a
 STkQ==
X-Gm-Message-State: AOJu0YxFzGYIlF1TlYVuZinwi41jXccNViy+FqFmPj5c7sS441C/sXw/
 9/Kw9/bLo8XDf5y5vwxI/WxXGSclOThLD6/SWspwgCdYZ8C7cJkONx7fIIIQMBjMZ014g3IxhDo
 deAPh
X-Gm-Gg: ASbGncvnJV1PQjlcWggWkKd9RuDmPZbpP75XVNE/NCuVEvynRBbkFDztb4TPqL2TbrY
 2+CcLpQc74gznAsHwTrh+jVSi8kZC/Gj2l8tiW24KAWG7HgLwrD5onMmRHgR+b9Z/uQprHfBTww
 ZxL/agxzsX3HJuqAmlcsPAdN1+9fn7aO/qgvfTV1VOgghCM3I0P1xP+mwqJOqGJQh9dKyA5ovpq
 +CCBH8ec58HIdj52ib37ue5BHS7+JbqQDPK0r83FZDVyQgPwY1MkN3MG1M9r35cdxKdeiGsEHUh
 8elGMPtbQN7/iMfbUXlK1T3F8RWgLEYfZItaElGpj8ae8N1sx41PEE32Fd3i9j2leTIw7LZwAc5
 QWYA/isXAHzTjO5r/mKig9Sq1HkW3WIkcgB0dIgPVjh3aig==
X-Google-Smtp-Source: AGHT+IEtt4oaAcC9Z7OINrpzlAenGT8/e1FPK+2TRH1pNtGGrE+PoGH0RyRRirgReKGiPyxVARgWcA==
X-Received: by 2002:a05:6a20:914d:b0:233:d31d:25d9 with SMTP id
 adf61e73a8af0-233d31d2729mr6774540637.21.1752471821052; 
 Sun, 13 Jul 2025 22:43:41 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9e06995sm9464990b3a.38.2025.07.13.22.43.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Jul 2025 22:43:40 -0700 (PDT)
Message-ID: <8fb88ab0-7b14-43b1-b7c9-44e597c3425c@linaro.org>
Date: Sun, 13 Jul 2025 22:43:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] target/arm: Add FEAT_SCTLR2
To: Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20250711140828.1714666-1-gustavo.romero@linaro.org>
 <20250711140828.1714666-4-gustavo.romero@linaro.org>
 <09497926-db8a-4475-b361-7e8338597326@linaro.org>
 <268ae2cf-503f-4a51-b644-d227417fedb2@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <268ae2cf-503f-4a51-b644-d227417fedb2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

On 7/13/25 9:27 AM, Richard Henderson wrote:
> On 7/11/25 23:02, Richard Henderson wrote:
>> On 7/11/25 08:08, Gustavo Romero wrote:
>>> Add FEAT_SCTLR2, which introduces the SCTLR2_EL1, SCTLR2_EL2, and
>>> SCTLR2_EL3 registers. These registers are extensions of the SCTLR_ELx
>>> ones.
>>>
>>> Because the bits in these registers depend on other CPU features, and
>>> only FEAT_MEC is supported at the moment, this commit only implements
>>> the EMEC bits in CTLR2_EL2 and SCTLR2_EL3.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>    docs/system/arm/emulation.rst |  1 +
>>>    target/arm/cpu-features.h     |  5 +++
>>>    target/arm/cpu.c              |  3 ++
>>>    target/arm/cpu.h              | 15 +++++++
>>>    target/arm/helper.c           | 80 +++++++++++++++++++++++++++++++++++
>>>    target/arm/internals.h        |  1 +
>>>    target/arm/tcg/cpu64.c        |  5 ++-
>>>    7 files changed, 109 insertions(+), 1 deletion(-)
>>
>> Bisect points to this patch as breaking
>>
>> 45/60 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_rme_sbsaref
>>          TIMEOUT        1200.01s   killed by signal 15 SIGTERM
>> 46/60 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_rme_virt
>>          TIMEOUT        1200.02s   killed by signal 15 SIGTERM
>>
>> Try make check-functional-aarch64.
> 
> This is caused by the realm os being new enough to try to access SCTLR2, but the op-tee
> firmware is not new enough to enable access to SCTLR2.  So Realm EL2 unexpectedly but
> correctly traps to EL3, and the whole stack gets wedged:
> 
> 2025-07-13 10:16:12,680: SMC_RMI_REALM_ACTIVATE
> 2025-07-13 10:16:12,680: 10045c6c000 > RMI_SUCCESS
> 2025-07-13 10:16:12,689: Unexpected exception on CPU #0:
> 
> Pierrick, I believe you built the rme test images.  Is there perhaps a newer version of
> the firmware that supports (at least) SCTLR2 and TCR2?
> 

It seems that TF-A has an option 'ENABLE_FEAT_SCTLR2'.
I will try to build with it, and current series, and see how it goes.

> 
> r~


