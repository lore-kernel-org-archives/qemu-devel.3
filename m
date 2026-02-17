Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF03E83844
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 00:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs8XC-00020n-II; Mon, 16 Feb 2026 19:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vs8X4-0001zY-Rg
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 19:01:38 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vs8X2-00086a-U9
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 19:01:38 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-824ba8f0acaso2396185b3a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 16:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771286494; x=1771891294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J5/0992PuCS2bcfrcaS03zDXWvx0qMSr6W2hFnk2Q34=;
 b=YwWgV+lC0hS9MbBsB3P9ras2CPvDkUIOaxja2kxOyVQo6rVsSWuO5LWnDNA/BVRCgE
 TvKELNHxu4hy1fxMrhlXR1BeE4WEDkmICTkt8V6ghyr0B68ePGFNjPrPzQHu5YKEHLCe
 Svfjh4Cjc3aHcOUZs4JnPdsyaqgD76M3z7J/cekhkJIYapPr/ye1C+7FLV+4Xhgg07/u
 PFMr5Nkr0+KCdXyguwHc7dl8E/6OLHzokx97Kb47h6bCrrVUhq5cyhgjGXZ2YalVoGoj
 tTFQ16BTo0y6tNVQE0yBbttsjvi2tcQixVvs6ayh8ZeFn4QokJTUcs2+oalnIc3IhfrZ
 9B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771286494; x=1771891294;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J5/0992PuCS2bcfrcaS03zDXWvx0qMSr6W2hFnk2Q34=;
 b=DjWnhCFS2++n6YY1zWicfPrewoi9TrxF03tGzkn14eBh+qH0Eo3qtSM83/5Gfg//c8
 +Lw0QhbCu6D/AGbZydBI7ReH/bs2BHDRXy3f5ckMKNIslNzZJ2hq6aTx6of4UU0jxTnI
 GYBD7Mp7NsqHQG8qaV1WTWG3HqcbONF22DWCKmhf9n6f/P1Ft/Ji8CIdWoTY4ZTz3G8q
 NLocwOoAv07eMZ/jiydaCjR+/z+7vQhW1DJpLl2UhBsiV2SAYTKjzadNNrVIkeyE+Oex
 p1Fwr+hF9pO1WvJ2989BKMXaKSVyDj+B0NpdtmFxypXGKw56IMSHczUDFIQr3Cu0En/a
 GOEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhFunNpeyPGcvE87DLb2h4aECc/p39wa+9dsnjC9U5eZ8Zxc4yCFw80NPzcG3cYch9o9MAHlv7Q+ue@nongnu.org
X-Gm-Message-State: AOJu0Yxg0T4ThX1LVDzbkFja9j4FnbfxpDFmV87VFHuC+U1RSIag6sLY
 SObXEbGAlAoGyxWz+B5r6QKHm6+4nvPYclnE76u00N2JLTlelJPu55gwGDMZmwi0tPQ=
X-Gm-Gg: AZuq6aJSG9izVF30Gtb/kMO/MBbxZav1gNPdbAfFK3GTxBifoE/cK+5MYFco5B55hI9
 H+N0HL9Abp/4NHMGHisMczzVTax7JxmMp7ZAusfhJnJ+QhVSWembqAbhiM6gBiAmVvCYYktnYav
 Zz61jtQnCKyREFumfH2ACEk3yHNqZ49fXmmYYYCyXVPkz5tuzDiZwXDebTGBUHSM+CTpwIKtK0g
 GSHP363ONVRk6o74CqSl0uzq4adkR/wlASqxMt4t1uFb0Qzz4ZTvWq2r+qQt1q0qXwRA5WldUfE
 1zvmfRO60y5fXQl1Lwieb5Cflcb2NlfCjMe6OTHAY5w9IOQRx1QhSD9HA7kh50D5EiVOWiHjgPu
 u7Gh+WzNtln703GlDGQqvQ58yKuXqkzc21DRd9EM874kJz1LYCpEhgbGV3dr/d6MxAGyYyO0W9x
 Y0Pq64GE+vKeYiqeS2IMXR9ReJYW5fuDIS60h7J912aWhGOfdcdKZXhvKF/qEypFzqTuvQlJhVF
 tv2npsBCOY3zUu0pzkJs9X1RicT9AmSwWpxPZ4DkAc+yAfWNzACiHE=
X-Received: by 2002:a05:6a00:3005:b0:81f:4eda:3e07 with SMTP id
 d2e1a72fcca58-824c95f2672mr10952780b3a.52.1771286494328; 
 Mon, 16 Feb 2026 16:01:34 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1e87:e093:79fa:89a7?
 (bg30dhzpjwwrss5hh6ty.ip6.superloop.au.
 [2401:d002:dc0f:2100:1e87:e093:79fa:89a7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a3f83csm11851174b3a.17.2026.02.16.16.01.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 16:01:33 -0800 (PST)
Message-ID: <bf398bea-65ce-4412-b9e8-7b6862b2be2f@linaro.org>
Date: Tue, 17 Feb 2026 10:01:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] page-vary: Build set_preferred_target_page_bits() as
 common code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260213182713.44924-1-philmd@linaro.org>
 <600adf7c-2c6a-43df-9214-144ed03f8f11@linaro.org>
 <04284ddd-d606-4248-933b-8352b4ee3c52@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <04284ddd-d606-4248-933b-8352b4ee3c52@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 2/17/26 03:17, Philippe Mathieu-Daudé wrote:
> On 16/2/26 08:27, Richard Henderson wrote:
>> On 2/14/26 04:27, Philippe Mathieu-Daudé wrote:
>>> Allow common code check TARGET_PAGE_BITS_VARY at runtime
>>> via the target_page_bits_vary() helper, then use that
>>> in set_preferred_target_page_bits() in order to build this
>>> method once as common code.
>>>
>>> Philippe Mathieu-Daudé (5):
>>>    qemu/target_info: Add target_page_bits_vary() helper
>>>    page-vary: Expose TARGET_PAGE_BITS_MIN definition
>>>    page-vary: Use target_page_bits_vary in set_preferred_target_page_bits
>>>    page-vary: Build set_preferred_target_page_bits() as common code
>>>    page-vary: Inline set_preferred_target_page_bits_common()
>>>
>>>   include/exec/page-vary.h          | 15 ++++++++++++++-
>>>   include/qemu/target-info-impl.h   |  2 ++
>>>   include/qemu/target-info.h        |  7 +++++++
>>>   configs/targets/aarch64-softmmu.c |  1 +
>>>   configs/targets/arm-softmmu.c     |  1 +
>>>   page-vary-common.c                | 29 ++++++++++++++++++-----------
>>>   page-vary-target.c                | 25 -------------------------
>>>   target-info-stub.c                |  5 +++++
>>>   target-info.c                     |  5 +++++
>>>   9 files changed, 53 insertions(+), 37 deletions(-)
>>>
>>
>> This patch set moves code from page-vary-target.c to page-vary-common.c, based on the 
>> new target_info hook.  But since TARGET_PAGE_BITS_VARY is still used, I don't see the 
>> point.
> 
> The set_preferred_target_page_bits() symbol is removed from the
> per-target clash symbol list. One step at a time?

Ok, so, making set_preferred_target_page_bits is the goal.
I now see that you even stated that above, but I missed it.

I'll give this another think.


r~

