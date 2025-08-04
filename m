Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1FAC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 22:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj3Tz-0004lJ-SZ; Mon, 04 Aug 2025 18:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj3Tg-0004ep-Uo
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 18:16:25 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj3Te-0005Lf-TT
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 18:16:20 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2405c0c431cso50523915ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 15:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754345777; x=1754950577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g5ToaneZ0RAyMI/kf3IK8+SqKDvt+A7mZnMJ/2adNXA=;
 b=jOQ9LZlbud6QvmebzIsshc+wCrjB68Z5FxzK3Lpt1pWonJV7uz5s/V5mcHmQLZy+Ze
 i6n+ifzzyHtsFYCiUlJPjjAbVgcavoMGGUzvDnbJgAKvGTqhcp7OiXedFNUQllGw3M66
 1hxKlaXc6qm3MzLGhXsOE8ITvbUY9I6qOO18D5kyudu6v8QrxGHtCnfBK6MwyB+H/Obr
 5BqhO4Cl9DsIaLinmBBu7UDQ+zjAdiftfMRcw44R7laUgV5Nz+oLfLgvmlJyq6Jwz5LN
 NW52YZJpSlf2htXi8mWgkSxkRwm+W1WJa4jxknYTy2K26ukCM4+wF7yEgdDyXIwe4P5J
 KXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754345777; x=1754950577;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g5ToaneZ0RAyMI/kf3IK8+SqKDvt+A7mZnMJ/2adNXA=;
 b=cOtOo6hGzfkOSLvHvbcVDNqairLP4XK0F88rKlvf3hugdFw0j7eqISNQ1leKMgt/ux
 3KmWdvZohfFUHFkxTUdLiKAB76oofyWCtrP3ew9v0Pv9jKyMcVQho7WO2IOIwAMX3N/l
 YbjmB3HBZr1Xyicuhwm049QbJizsiLGhSoauY4hrK7HOsMppRURhpDMR4/nlz+EPl+Rh
 TesBqrYXeMuVAyiyKnf7drHZYSnjHX1Yh6zeYiTdR4bwo137FDZcV6O8y1zqSlZwbJYD
 76iOR0uVwqMZIVFhVuV1WLkF6nrnixzxN5u/2oZSHUjEnsuteqfYwdXLiolZYe/CrYwY
 sGDw==
X-Gm-Message-State: AOJu0YxnUavjoGCvu6XRL+snGIpuZ9rPHlht1k9ecXLimC5SS5Ff/KAZ
 3YeJF5cCxPy/Ruc2hDjF0QzaNRDTWxj0lAwdcNR5I3+olHddFGVB/EnFVjklGFFht18aJq1YCYL
 t9+QA
X-Gm-Gg: ASbGnctBIQ8XJrfMh9Jy9kIgc7UuB9pWAzI/gq2QfUdS8BsXmmmSit7L8cvMsEiDRjI
 rhh5I38gWHaJMfpOqPvX05My2lVEaQNYpssXhP+rP5lh+6lAA8lMPET1Lw06l6QK8MEYBfMzsm/
 N4RECJ+fYkEfkiUECnrtrxEIXHB56AN3tZWTxggFtHpE9qGMk09bIfP6JZc/3NJokGvx393bBnB
 rDBiaCRJE6BgZk2whTAmC3vahCaZ4q9Hl8SzGIGP9CnKB0o64kSxkPhAEgmPUMKlk1uGAIsG8Ic
 iaCKF7aZtLvQesv6C+VkYYthV0blf2Mroc4/7uKJL/HEd9VIPXn6dcX8p24hahaF41wrp6Zp8xl
 511CT7eUh+c5soA2mog8Ij5cC3UcojjmBOxQ=
X-Google-Smtp-Source: AGHT+IGm0qIPg7p0MdV0X7iprsyW/NQliyIgkc8HoGfGk22S4dDZkKJEzYHYC/LC5sK0Yqe2qAAljQ==
X-Received: by 2002:a17:903:2351:b0:23f:c945:6081 with SMTP id
 d9443c01a7336-24246fe0988mr135717515ad.31.1754345777330; 
 Mon, 04 Aug 2025 15:16:17 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63ee49d5sm15466546a91.22.2025.08.04.15.16.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 15:16:16 -0700 (PDT)
Message-ID: <9354c51d-95b7-404b-aa9a-110c3b03f6a2@linaro.org>
Date: Mon, 4 Aug 2025 15:16:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/17] whpx: add arm64 support
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-10-mohamed@unpredictable.fr>
 <de952126-10d3-4562-b3c5-779483eeaed1@linaro.org>
 <F3EA0A07-D4DA-4618-BA34-A999066E5496@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <F3EA0A07-D4DA-4618-BA34-A999066E5496@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 8/4/25 3:08 PM, Mohamed Mediouni wrote:
> 
> 
>> On 4. Aug 2025, at 23:59, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>>
>> On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>> ---
>>>   accel/whpx/whpx-common.c    |   1 +
>>>   meson.build                 |  21 +-
>>>   target/arm/meson.build      |   1 +
>>>   target/arm/whpx/meson.build |   3 +
>>>   target/arm/whpx/whpx-all.c  | 845 ++++++++++++++++++++++++++++++++++++
>>>   5 files changed, 864 insertions(+), 7 deletions(-)
>>>   create mode 100644 target/arm/whpx/meson.build
>>>   create mode 100644 target/arm/whpx/whpx-all.c
>>>
>>> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
>>> new file mode 100644
>>> index 0000000000..2e32debf6f
>>> --- /dev/null
>>> +++ b/target/arm/whpx/whpx-all.c
>>
>> ...
>>
>>> +    { WHvArm64RegisterDbgbvr15El1, WHPX_SYSREG(0, 15, 2, 0, 4) },
>>> +    { WHvArm64RegisterDbgbcr15El1, WHPX_SYSREG(0, 15, 2, 0, 5) },
>>> +    { WHvArm64RegisterDbgwvr15El1, WHPX_SYSREG(0, 15, 2, 0, 6) },
>>> +    { WHvArm64RegisterDbgwcr15El1, WHPX_SYSREG(0, 15, 2, 0, 7) },
>>> +#ifdef SYNC_NO_RAW_REGS
>>> +    /*
>>> +     * The registers below are manually synced on init because they are
>>> +     * marked as NO_RAW. We still list them to make number space sync easier.
>>> +     */
>>> +    { WHvArm64RegisterMidrEl1, WHPX_SYSREG(0, 0, 3, 0, 0) },
>>> +    { WHvArm64RegisterMpidrEl1, WHPX_SYSREG(0, 0, 3, 0, 5) },
>>> +    { WHvArm64RegisterIdPfr0El1, WHPX_SYSREG(0, 4, 3, 0, 0) },
>>> +#endif
>>> +    { WHvArm64RegisterIdAa64Pfr1El1, WHPX_SYSREG(0, 4, 3, 0, 1), true },
>>> +    { WHvArm64RegisterIdAa64Dfr0El1, WHPX_SYSREG(0, 5, 3, 0, 0), true },
>>> +    { WHvArm64RegisterIdAa64Dfr1El1, WHPX_SYSREG(0, 5, 3, 0, 1), true },
>>> +    { WHvArm64RegisterIdAa64Isar0El1, WHPX_SYSREG(0, 6, 3, 0, 0), true },
>>> +    { WHvArm64RegisterIdAa64Isar1El1, WHPX_SYSREG(0, 6, 3, 0, 1), true },
>>> +#ifdef SYNC_NO_MMFR0
>>> +    /* We keep the hardware MMFR0 around. HW limits are there anyway */
>>> +    { WHvArm64RegisterIdAa64Mmfr0El1, WHPX_SYSREG(0, 7, 3, 0, 0) },
>>> +#endif
>>
>> ...
>>
>> I understand this comes from existing hvf implementation, but I can't find where SYNC_NO_.* defines are supposed to come from (including on hvf side). Any idea?
> 
> They’re just annotations for developer use so that readers of the code know why they aren’t in the list.
> 

Ok, thanks.

