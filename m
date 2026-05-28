Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26676CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScT1-00032R-Cr; Thu, 28 May 2026 11:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wScT0-0002zw-4c
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:16:14 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wScSy-0007Pg-Dx
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:16:13 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-36baec934b6so126089a91.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779981370; x=1780586170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lp0YaAo5MUn4sIcBp/oIXYHZiynPmUZ4ZJXdpXGtmVw=;
 b=r5GXjTMfhJ3eMIi1z5oRnCzBnNvMQzC/0xZQhQz+iOPpu5PQwEQ20zUlF0vr+N52bf
 O/KuCLzYtvG5LCwiu2CIBBWDw1n9SrSENQKFY3kni66mYOnq003Cq403AVyzOB0Oxnof
 hGIkmrrS+DxafMSdwukq0Ym0RzmzlquliZFpjkD84iqHK/VALxTy0t+RIKhkXh7dpeq1
 XJtJ9aN7ejQzdstspC8QeH2t8D7OY7HAuEFKtan2Ia6FA6Nsyo/V441r0E9DiS2KXc8Y
 motWHihrOQ53aRI5kRKGUYvT2UaaFIVS3BdfJHX+SR9DUIQsv95Cn01OuV6EEn4kdPtl
 Mccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779981370; x=1780586170;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lp0YaAo5MUn4sIcBp/oIXYHZiynPmUZ4ZJXdpXGtmVw=;
 b=aHTCDxZ0nK7OtG0jL1Ee9a9g1YI9BpQbKmgEjgmzSpEjah8QVp5wQOv7mD3i7ETMmp
 MGLU7SSw2ZvmFRoBPecOHNYsW0YL4wPWP8G6VEJSPGSj3TKmd0FrodB77787H3nIGA4f
 Xbist3m5uwi1QzlaW66NKTVXVSStUPuV/eiYVlv3EwGQzGGPhYeAORPsAS4aMjiB6iFv
 9yCPKV75U8R0ZG/tbkDKx54Oc189A/+MjF1XRjeVG1xmUhRgt1aegn8wI5Z6Aqb32Hfv
 qQNoItgrETidL+yJJtNtLxvZPb1llDV1uCZy8X3sIZX1KBRLAS9CZ9sWnm9ZY9gRctzA
 Y9YA==
X-Gm-Message-State: AOJu0Ywejvepc0DhZrkBWh0SWW3NKzG+rrKDc3kC1ale8GTPb2vnMoG0
 BPSsykeva/lKqHr3+f73e7UvbgWUK+zA+usxIRd1VUwUg3kvRCqIuMcfmgLqgkePtENAbFMGSQ0
 Me9z1dYs=
X-Gm-Gg: Acq92OFrd4oDFCEd+5DhoL8WFbc6wh6UviygtF2+z5rjF2dmQwbMC8ZYjC4hognFz8e
 vxVmon9iy7sbrEv4kL0m2QiHPGbMS4UfMhUNCNO45Tc7AoyT+yCLMJEni/vrxuqwD8d341fpm42
 4u+klizNyRzPkb7nZ8aRo1bMdGxOv4i2xveM+0RmDJMcMZ+IYiH+q984YHpRsVtT7KyhA8+Jrs3
 c6YJm6VkxhKuZbV2yXN/5Tc37pGuTf7QPU3D7pmuWUM/EK0ZYPmSALC+0VDugNFMxHH7LGgB1fV
 fNVc5DxKkO1x4ErAVfzE3FQUCv2DvSyxsbAQCyZ6VHM3u8O3Z0n4XCSs9WD0XRseD7PFYjJO1KE
 mAaC5UgoWRjQ1XdnVRGtqjv76Ytprc19X3IWQQv3AbodSB1tBI3/E5U+221MGBgU0eVrD+yIWUt
 OR/JKDtORZM6Nh9zNqPyYVCVU06/cfHs9PzVbiR6tIPKY8cf/3+4q/aF3n0w==
X-Received: by 2002:a17:90b:54c6:b0:368:3830:a8bd with SMTP id
 98e67ed59e1d1-36b9c6e1262mr1780529a91.7.1779981370187; 
 Thu, 28 May 2026 08:16:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36b90946729sm1948911a91.13.2026.05.28.08.16.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 08:16:09 -0700 (PDT)
Message-ID: <06d0284e-5803-4f9e-9367-3e28d1d18da5@linaro.org>
Date: Thu, 28 May 2026 08:16:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] disas: sparc: Fix integer overflow in compare_opcodes()
 for loop
To: qemu-devel@nongnu.org
References: <20260527175705.152301-1-christian.barry@usp.br>
 <CAFEAcA_t_Rx1CupetKR=aC1U6skFYmo_2oG-PyVYdwfJmb5X6Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_t_Rx1CupetKR=aC1U6skFYmo_2oG-PyVYdwfJmb5X6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 5/28/26 02:17, Peter Maydell wrote:
>> @@ -2525,7 +2526,7 @@ compare_opcodes (const void * a, const void * b)
>>
>>     for (i = 0; i < 32; ++i)
>>       {
>> -      unsigned long int x = 1 << i;
>> +      unsigned long int x = BIT(i);
>>         int x0 = (lose0 & x) != 0;
>>         int x1 = (lose1 & x) != 0;
> 
> If we're going to bother to change this not-a-bug, it would
> be  better to do it the way that upstream binutils did it,
> as noted in the gitlab issue: using "1ul".

I would go further and use uint32_t not unsigned long at all.
If we're going to change anything.

r~

