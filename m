Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D5FC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 23:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsVgV-0007xv-7u; Wed, 12 Mar 2025 19:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsVgS-0007xX-5S
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 19:40:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsVgQ-0002K2-8O
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 19:40:19 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso2088805e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 16:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741822815; x=1742427615; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qZDNiDDQB4FuhrxZCF2uEPJIW8Wwl+g1rNRFcx7RuzU=;
 b=p2FWpdicsK1wh2VOyf5/AYtvD1wilWQtym5qSY5lZ/UVZEYe+ISJfznvNNHMJhn+qa
 SFrPuz9Lc88ZRKzOd/nTD2VGYxEzuL8nm9vkknfLy3q3fs4lHETK4mFKAxDd8A5/LNJQ
 BULrubUM8ecP+x29rdjvrb0m6voqDYnBhH1Xqr1bTt02MDIakIUjMXTWgrfsxeBcbwQw
 SIntUjOiHBzXtj7AfbOZkLzY9IeloUafsobVKuuZBwiTOfM0zuiMsQMaU1rSZ/1kE7n8
 klOejdyDHRgZ56MXOBwhVq69oWflvUO1D7L9cnb3xP+5ug/c81ChUScLmNP6XciMuWmh
 h9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741822815; x=1742427615;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qZDNiDDQB4FuhrxZCF2uEPJIW8Wwl+g1rNRFcx7RuzU=;
 b=PQo+uyj5pbI8NQgIU9zjiq7OIuriqZNBkHw3Zck8dzSyRktWD8p+lCqwHVUA2wozZ+
 hw/8wYrtdbZ4bu0V5M5/uIlh0yGP628pWexxMxqwpQoOMRJT49y1WfL80hPdwrV6/EgN
 W6h+3H/jTbQ9pN7Ue2VRPxoMd7y0oMWjnXvMF3RGs/Xy5XKlM9BiqPy+qoweEYbzpUtD
 6z6IpOVNj/Fv5n87rQph/DdDwdhPQYO/GgTVRDhoYjHhA1QXOtGqzj0rN0v58dQCVcxO
 QA44VwlbsRE7XuGQmMDrnuSbyvLD1fG1UNdNHW2I+0H/Q81qdkBfD7XdV8T8j2bheZvF
 oTtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWJDK4r+OrVwLD1rx7cQvAWtyELduM9D+xhjkx2srMZvVLSPM2FKf5vNgtYa3annjcIulo1PzImjTx@nongnu.org
X-Gm-Message-State: AOJu0YxY6BsoedrLpWhQDseIeboIMs8qkx59l1aYZ0UUW0wjzH4U2e2T
 U5a5GcF6MATzhu0+sUhFIOQdrNW/Acxu+H+KwPyl7R8z1Q2iOeXh7Nrop9/bCiU=
X-Gm-Gg: ASbGnctFXz9OtPTb3OqX73aClqknpxvxDPQ2yqSsq1+AVIgO3Kp4LltdgaIxhs7ZZ0c
 sJfG4gFppAu6Tt+ZkxdM2/RwtIk3KbOVyQgiXil0zLlREVOPMLheF8GHdoDsETjXsylhugc1ZfI
 Lw7tS5vzxBf23OtAib+IeqwHTtdAdCJqWEmyhNyDLOgpzO6PqjnYmHXLpVX/k3mh6/TkV3PPfjp
 CgTiQvkqbuekly1hPNyI23nFVofrI2OpQ5NBwqNks0lIyaCoac/B3PZ+wfMw3qL+I1jMcaiDc1U
 99uhMkgyxBv6B3nqpniJGsqXO6i1fPKjDKZ0bJ39C6EMiajrzHbdDbbZQlNeBIZ3EzLjcJMEzTB
 EjZut7q4eVPWB+yf0WtMa
X-Google-Smtp-Source: AGHT+IHVpEqiJ2S4y6mXqxtJqDHOHhWfZUcBV+/vTWFJfb447Tdjy6J36/72vRbIwdUwTygPPZwE0Q==
X-Received: by 2002:a05:600c:3590:b0:43c:f928:71dd with SMTP id
 5b1f17b1804b1-43cf9287333mr101106805e9.1.1741822815050; 
 Wed, 12 Mar 2025 16:40:15 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d188b7555sm2166035e9.16.2025.03.12.16.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 16:40:14 -0700 (PDT)
Message-ID: <67b33d51-b8c8-421c-8aba-efa9a0b46bf5@linaro.org>
Date: Thu, 13 Mar 2025 00:40:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/38] target/hexagon: Initialize htid, modectl regs
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng,
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-29-brian.cain@oss.qualcomm.com>
 <44e23197-a2ec-4477-a4b8-a526f83e47c2@linaro.org>
 <b84bcd2d-9974-41f0-b9f5-2d416ed16d0d@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b84bcd2d-9974-41f0-b9f5-2d416ed16d0d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 13/3/25 00:10, Brian Cain wrote:
> 
> On 3/12/2025 2:19 PM, Philippe Mathieu-Daudé wrote:
>> On 1/3/25 06:26, Brian Cain wrote:
>>> From: Brian Cain <bcain@quicinc.com>
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   target/hexagon/cpu.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>>> index 36a93cc22f..2b6a707fca 100644
>>> --- a/target/hexagon/cpu.c
>>> +++ b/target/hexagon/cpu.c
>>> @@ -26,6 +26,7 @@
>>>   #include "fpu/softfloat-helpers.h"
>>>   #include "tcg/tcg.h"
>>>   #include "exec/gdbstub.h"
>>> +#include "cpu_helper.h"
>>>     static void hexagon_v66_cpu_init(Object *obj) { }
>>>   static void hexagon_v67_cpu_init(Object *obj) { }
>>> @@ -290,11 +291,18 @@ static void hexagon_cpu_reset_hold(Object *obj, 
>>> ResetType type)
>>>       set_float_default_nan_pattern(0b11111111, &env->fp_status);
>>>     #ifndef CONFIG_USER_ONLY
>>> +    HexagonCPU *cpu = HEXAGON_CPU(cs);
>>> +
>>>       if (cs->cpu_index == 0) {
>>
>> This doesn't scale to heterogeneous emulation.
>>
> 
> If we have a target-specific index here (instead of cpu_index) guarding 
> the "g_sreg" allocation shared by these Hexagon vCPUs, does that 
> suffice?  Or is the problem the shared allocation itself?

I'm not sure that suffices, but it is still better from my PoV.

Let's assume we instantiate 4 ARM cores, then 2 HEX ones. The first
Hexagon core has cpu_index=5. Now for the same example machine we
instantiate first the Hexagon cores, then the ARM ones. The first
Hexagon core has cpu_index=0.

> Could a heterogeneous emulation configuration consist of multiple 
> instances of (same-architecture) vCPU-groups?

Up to you if you want to model multiple hexagon SoCs in the same
machine ;) Note in that case you could use a CPUClusterState to
group.

