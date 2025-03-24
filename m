Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17490C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 21:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twpH9-0008Ms-3K; Mon, 24 Mar 2025 17:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twpH7-0008M0-9R
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 17:24:01 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twpH5-00059C-KS
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 17:24:01 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ff4a4f901fso9027820a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742851438; x=1743456238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YFDA0JeDDrgv1GyZMFNeItH4CS9p72cfNWmfFzJWQlc=;
 b=GK3Fh9zQY5pvcZpQzpMrSFAZa+bKirzPvUIRpt5PHJkR5uvpswT6Ni8PLW/nbj3F7N
 wZO8BXri7GU1k+C56LE3T0odxtr//k0zNDG+abuz+Ehs61wPNkX5WgdBa0u0tR7DeIFw
 Bf48+Nh39yafnD3MvFHzX7ohmsqS5a5wGqnrEKLQKrMfYC/K5oS3kyNBL6LJjtolh8t4
 U+KQpV32O0KhpdfddKxRyngU0fQ8st46+VzReHZN+eE77VFnb92wqGCMgBmwN8g9pwcE
 mr66SM2pcCE6VXtn3854quTnqDv8zcYVMK0K35nAemeOgJOIvEHW5Q5YTGL4/gBAY4Ck
 xWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742851438; x=1743456238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YFDA0JeDDrgv1GyZMFNeItH4CS9p72cfNWmfFzJWQlc=;
 b=kv46M0Gm3aSin85EC5dP+aCP/lSdIsvXvulWisjrjgTA2O7jYNTVCOUB9NZI2lkjy7
 WT/eOWj7NrcqAmfGnbhunzysHJTPTI6ouVJLGG5/Ti2G8Ug6fKunKw9zufFCP0OS8o4j
 gq/VIbQGKSTndrCKBnXLlEkvGqhmRSSBPax1OQedQXEmiQueqiq5zH30K8S9ripP5ssE
 4TzpDgWNjA/LG3SR8iPXLic7sGBlkx/Vh47LLHL+s280/xklDS+ipQXuc7RoCQcXtylL
 ZEtUTFUNE461of6Jn1aU64xxdApxqvaSuqN0+1N07faOURppGyzTJKKgT7+VwUPdjkAE
 XDNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXegMhh47wyc/kYCH1bs626h5ZOU/u62iCCbSxc/Z/DUiWfeaVzPpav4EBMNd3A0rAr4+G3JdyR8pVM@nongnu.org
X-Gm-Message-State: AOJu0Yz+kivhpYn/Az8ni5kKRozdAeh2GYP8xNmRIko6OkJuzEhuNs2z
 jX7bE9s4jC1NT3kk3TNRl/bLOVdWlgtMPViNsZOHO82gS8FrWz5va8lcJltQhxA=
X-Gm-Gg: ASbGnctetWvbvmIelIF6yKwSrgisKa/tvWnuOnQ4z+igB6nvvnthb7brDMcpcY/T4Gu
 Ux+pZiVl91XdZmEU18yuWTkkreeH2CAGG8TYHBaTK2K5XtZh5xuIgdJk6URzCzbg7fwuSif3xtY
 yuGhyN22/DHYXyM474T3CtSVINJnksvnt94Sr8R+55WzXbkFqhD9hAUsBMdwJR76iH+hVNPkz9o
 /0ltZtWeBpqrKED4sANlom+VQquMrCVZTgSN0+6A1EQLZOrIeE6ZHe9a9EeifGS/xGUF3ckysSL
 VJPVmcTU6NkwgPFlx+fqP5GA8Py6joH7kfDi5u5G4UXE3Yl1TiI1teWA8A==
X-Google-Smtp-Source: AGHT+IHB6vBc7OKIKXxCYp0nll+Xe+XOOJIvF5rYK/LZ5u7+okuz4kyrpEKI3McVEYD3sWnzIOGaLQ==
X-Received: by 2002:a17:90b:2688:b0:2ff:784b:ffe with SMTP id
 98e67ed59e1d1-3030fe93ef7mr24860497a91.11.1742851438122; 
 Mon, 24 Mar 2025 14:23:58 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030f5b7891sm8763029a91.1.2025.03.24.14.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 14:23:57 -0700 (PDT)
Message-ID: <314709e0-3b1f-410d-bafe-37031629eed1@linaro.org>
Date: Mon, 24 Mar 2025 14:23:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/30] hw/arm/xlnx-zynqmp: prepare compilation unit to
 be common
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-29-pierrick.bouvier@linaro.org>
 <2a7a2a78-02cc-4954-85cf-b72f37678f36@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2a7a2a78-02cc-4954-85cf-b72f37678f36@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 3/23/25 12:50, Richard Henderson wrote:
> On 3/20/25 15:30, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    hw/arm/xlnx-zynqmp.c | 2 --
>>    1 file changed, 2 deletions(-)
>>
>> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
>> index d6022ff2d3d..ec2b3a41eda 100644
>> --- a/hw/arm/xlnx-zynqmp.c
>> +++ b/hw/arm/xlnx-zynqmp.c
>> @@ -22,9 +22,7 @@
>>    #include "hw/intc/arm_gic_common.h"
>>    #include "hw/misc/unimp.h"
>>    #include "hw/boards.h"
>> -#include "system/kvm.h"
>>    #include "system/system.h"
>> -#include "kvm_arm.h"
>>    #include "target/arm/cpu-qom.h"
>>    #include "target/arm/gtimer.h"
>>    
> 
> Is a better description that these headers are unused?
> 
> Anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>

Yes, I'll add this to commit message.

> 
> r~


