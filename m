Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27E7E9A052
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 16:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7LY-0006Zo-Hq; Thu, 19 Feb 2026 11:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vt7LT-0006Ym-PX
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 11:57:43 -0500
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vt7LS-0005CZ-54
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 11:57:43 -0500
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-2bab70f8c8aso1019612eec.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 08:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771520260; x=1772125060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mq2fcTDrdYvBzNTSdJ3zgJOmq2U7Z9/ZuNI8J6dmpdE=;
 b=Un4cfjJeApGaUPfkkfbQM4Jkupew4XQh8lLQGOGbzFo5ql6yUdO+dGbzeFzT1iZ7kg
 irpQzK/9/w2yLzgr7XeAPoM/05QUP/EL8mfFO8BiSCHnOB6OzN+1th7zzxudtc8TYpsz
 ZE6kH20WtRiV5k9jlnS2PpMaPxdL3szGi3xZTDZQATWTTOfvbW1s9mQZnTuroeL/8x0m
 ffPOM6zKKc8FU8GH4ZyAGXDSN/pRfTDN9kcvEnL2wlnE2OAbmMVD2MzZhLzYN7iCgG1T
 2yLvO8Y/vCMR86YCrBtFrRceKyizZWNYE7pXUj0DongC8XWA1ebsXiqQtGElKDIBai70
 uaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771520260; x=1772125060;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mq2fcTDrdYvBzNTSdJ3zgJOmq2U7Z9/ZuNI8J6dmpdE=;
 b=EClcUSjWWWqkUC0ZJl+H9WTGLr6XWQczTekgHqsCj0wSRtpUMEgpUuKMnNCiIAEEGz
 0dIkz8BNpsPGWPqh7SawSR1wfcx0RMBIr0F/P5a+3s2Ld8sIQOynLgDj/roPJb1y68QW
 QI1Sl3i+LQx8m+EpJ/CC2xz6t1C+J/l8Cqh1P2U4ahx7GWo1hgXV9hpUBkN39Zhcnsg5
 aSLCD7GQSI/OZMChVwptAayGO2QIGd49S/VyGty8Y8kKgMmO5bfPyhbJzpfhADEgCOkM
 pnJzXpYNAHpgT7bMHlh6lNhBliU7gmZHHu0OlicuWh/DzVpSo4PDPEPrxD7zR2fLbx6Y
 GZnA==
X-Gm-Message-State: AOJu0YyK2CdbWi4EgauHci4Ch8CBbggLhWXa6vYuRLNc9wPX4HLQsplc
 7MKT1GXSQbF4NJyDYtFapkbhLn22FZfLqHECcYHzMq/8TVH39JSV97oXjNkOTFjySPA=
X-Gm-Gg: AZuq6aIeUbNw56X3VTzFxkofc5qXaA+hzeWORgnLQWWufKLvxdGpAB87KN0qbr0STWb
 1SOjNZFv+F7n5WiXHuTXIfUxz+OgT2lIYdhuVQlMsoTTecLXESYha4Q5hr9f1nINDEvVkXPEgOQ
 LZKAwozBmhgYBoQ9quKOKOX4IjtOG/xrO+Bm64zBe8j+czC0+eij1tPGJbz7jQY8rOY28YTh+7Q
 Raj6YwX8DhXBqoI9SOqWRqiL3X9hXB9c1AhznZh6LjopeWqWfNRd/pBcSKA1rQVcTQDr0tPhREn
 5Oy8s+zglF8J1Rj1XPwr6Gk2NN+4mDes0ENNI8IyA6yZBL7iJ5EbOeZ+3ThoOIWEbibZlmKIqfy
 vCUbx1Tf5jGUuL4c/NIw2gIOoBqgmWZeuiJbpWMbvLFNt8sBUI22LaayQByfGGjm1ZP0mAkL5Rm
 VFItsxTScUm3D/C0ujOjhYSMaWxXTaQqfEMoCX3VlenRebpqgJJAwmIzhC8NyWn+JrcUQTpMdfz
 tM=
X-Received: by 2002:a05:693c:300b:b0:2ae:533d:19ee with SMTP id
 5a478bee46e88-2bd5016fe56mr2808463eec.21.1771520260001; 
 Thu, 19 Feb 2026 08:57:40 -0800 (PST)
Received: from [192.168.0.103] (200-100-75-206.dial-up.telesp.net.br.
 [200.100.75.206]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12742cc9376sm25608991c88.16.2026.02.19.08.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 08:57:39 -0800 (PST)
Message-ID: <e5194b15-0a7c-472f-b1a6-21427d98e2d8@linaro.org>
Date: Thu, 19 Feb 2026 13:57:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/ptw: Clean up unused ARMMMUIdx
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org, 
 alex.bennee@linaro.org
References: <20260219140228.407513-1-gustavo.romero@linaro.org>
 <CAFEAcA_GdkVJbgGm2j8v15PM2ijKF2hYBAUKZ2_W=g6XasFvCA@mail.gmail.com>
 <00bed3eb-579b-4153-9bc1-07347a5d0792@linaro.org>
 <CAFEAcA-3BOhHZo_mD0Re5dpGpQ2=dydtSN5SxSKwywbVdhNarg@mail.gmail.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <CAFEAcA-3BOhHZo_mD0Re5dpGpQ2=dydtSN5SxSKwywbVdhNarg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-dy1-x132b.google.com
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

Hi Peter,

On 2/19/26 13:13, Peter Maydell wrote:
> On Thu, 19 Feb 2026 at 15:16, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>
>> Hi Peter!
>>
>> On 2/19/26 11:13, Peter Maydell wrote:
>>> On Thu, 19 Feb 2026 at 14:02, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>>>
>>>> get_phys_addr_disabled() is called from only one function,
>>>> get_phys_addr_nogpc(), and from two locations within it.
>>>>
>>>> The first call to get_phys_addr_disabled() occurs when mmu_idx is one of
>>>> the following: ARMMMUIdx_Phys_S, ARMMMUIdx_Phys_NS, ARMMMUIdx_Phys_Root,
>>>> or ARMMMUIdx_Phys_Realm. So, handling ARMMMUIdx_Stage2 or
>>>> ARMMMUIdx_Stage2_S is not required in get_phys_addr_disabled() for this
>>>> case.
>>>>
>>>> The second call to get_phys_addr_disabled(), with mmu_idx ==
>>>> ARMMMUIdx_Stage2 (or ARMMMUIdx_Stage2_S), only would occur if
>>>> regime_translation_disabled() returns
>>>> true for these mmu indexes. However, mmu_idx == ARMMMUIdx_Stage2 (or
>>>> ARMMMUIdx_Stage2_S) can only occur if get_phys_addr_twostage() was
>>>> called, since it's the only place where ptw->in_mmu_idx is set to
>>>> ARMMMUIdx_Stage2 (or ARMMMUIdx_Stage2_S) and that only happens if
>>>> regime_translation_disabled() returns false.
>>>
>>> This is true, but only because we never call get_phys_addr_for_at()
>>> with an mmu_idx argument of Stage2, right?
>>
>> Correct, and that's a case that will never exist too afaics.
> 
> Well, it doesn't exist currently (because the architecture doesn't
> define AT operations that do stage-2-only lookups). But two extra case
> labels in one function seems like a fairly small price for "the
> get_phys_addr_for_at() function will work correctly if you ask it to
> do a stage-2 translation", if we ever need it in future (given that
> it's a function ptw.c exposes to the rest of the code).

It doesn't exist currently and in my view it will probably never exist
because Stage2 is not an independent translation regime. It only exists
as an "extension" of a Stage1 translation. Also, Stage2 never translates
VA->PA, but IPA->PA, and IPA is not a valid architectural address.

These two extra cases, being unused, to me, complicates a further bit
the reading of ptw.c. Moreover, the semantics looks misleading, being it
from an AT command or from a real translation, because to fall into
that case regime_translation_disabled() must return true for Stage2,
i.e. Stage2 is disabled -- (hcr_el2 & (HCR_DC | HCR_VM)) == 0, but then
we case for Stage2 anyways in get_phys_addr_disabled().


> Also, removing these lines means that if we ever do get here then
> we'll drop into the definitely-wrong stage1 handling default case.

Getting here with mmu_idx = ARMMMUIdx_Stage2{,S} looks, first of
all, semantically wrong to me, as per my comment above.


Cheers,
Gustavo

