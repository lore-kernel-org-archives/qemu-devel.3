Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F439FB44C3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGAyu-0006Fa-V8; Fri, 24 Apr 2026 03:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGAyr-0006Eh-OB
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:29:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGAyp-00022J-R3
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:29:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so79097405e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 00:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777015778; x=1777620578; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RSbW9Qx2dWjLtuJrhqfT7Hxo7vlzHXH21y77sugPQjM=;
 b=oeUzaXXbNuHY8IixB9ztDm3+gVFXElWjQUiliRY7fhZpIINPbnsFoszP8TcogMeWgq
 eWGO2R8Egk9cEZGuqlooN8TPbIzlr8Z5+5ueOrwotn2GWtppFeFlwNGDPlUoA/1wEP9/
 kMME8rmV0vRLJnucK8Gajv79RzOW7VQ7j6JkdZWZA9sZfRqJoT/luXSdZR1TZVMsDOaQ
 5u/EgujkqmLH07gBhFajHDvyNBipgElMg2T4noVniXaM57bZ0+VVuK/S+Y4/vp8jg+wy
 TBMn9rV6SBKbYh3znGDOgEHyeZVT3uyHfCdHi4YJrsUk+zCtbca+YyTO6WXqv3ThCa8x
 ga0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777015778; x=1777620578;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RSbW9Qx2dWjLtuJrhqfT7Hxo7vlzHXH21y77sugPQjM=;
 b=lDJKnNrDC+HzixHANwV/W9cZveGSDH+DVJ2OhMfZXGK6V4eNl4jicWZ9AcEo32eSd3
 L4E19CE6PoYO/5GwbXp16r7Zg2XcwBgEyIzP3daxHuNrM33jc3uQJ6J7JWOJWTbiJVP8
 nEpiYSjSyguoiqMUKhk+7Xl53mXfvxYOilhm6rvsh8dEftBY5be77Oxvy/wrhvneIwlx
 4uRTRJG0/vbuGvUPu4ouKBnvGxhq+JunRLLxPyoCHw5SAvfrz0wscdUaaNrSS6cL+Ytj
 Ji8Ig+ZzbQF/fiIe5gAX0BWqtMYlee/WxnwD2ydu/0n/bfJpUnpEj+uZtBc5XBzOy0EV
 qBSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9muapmfcqlrplbW/56rBqcrZhjPXlRVuVH5Ot0RCgFCuqu1+jrIPQaQnimj6FftIQ+mKD+cOT7XRbR@nongnu.org
X-Gm-Message-State: AOJu0YxiBAQuQMrXWw6RkFswIYuofqijDLm/NLviFh4IJb0p5eDclmhW
 IyDGrUzCCKtDHaN2Azm0jq0Lc7isMlz6gOh5+kArBNNedJvQi65eatJq9B04ybyVnKg=
X-Gm-Gg: AeBDiesWyw+c/8XqeQCaIpxXjWGpsrcj80AFzA4RanRgMjyD50pMI5nRoD/H8Gjpade
 dBAJ/+5hoL1OTAQwFSISzzXm+aTZSmQ567tpt42zD0RPUPpsPkf4rL48tIJXBIhE9bBh0M1crum
 z8kJrcKrjxsvOOaHRegefYs64pKsSEoYxvyyTah2Ag9QR97XlH3UXqwlDPHrHJ8AUUtifNxs26V
 SOmk798eQbvV9Gy1E4pZ8ioqviUnv/my6JU/dGCaLMbcxG/pU/4Nlk+4wyvpD9APIQU+CrOgBZ/
 pc3D8f6na7tSVXGD7eYwvsdvdT2tDbxpjcytsWtVeiaRX8PThIyBkyoDQgeD1jzHSbkV2cFl+4t
 4+kbzoR8eBCJTsribg8JW5B/OIY9Tj/GifeKmneRNeaOqPuR/1NdXPZgekqp8Lbg4/vG/ar2Dqv
 qnXHMAyH3IQdBWeB2MnflrVgMjmQNSXGNdBQVMggjQ18UaL/RdSMFGHn4CufN474LYN0jTFpoN1
 +c7
X-Received: by 2002:a05:600c:899:b0:489:1a63:509c with SMTP id
 5b1f17b1804b1-4891a635125mr195545065e9.0.1777015777894; 
 Fri, 24 Apr 2026 00:29:37 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489fec8f7cbsm292671055e9.11.2026.04.24.00.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 00:29:37 -0700 (PDT)
Message-ID: <6db61652-5659-40c2-9800-2c335f64c66c@linaro.org>
Date: Fri, 24 Apr 2026 09:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/15] hw/intc: arm_gicv3_hvf: save/restore Apple GIC
 state
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
 <20260316130642.13246-3-mohamed@unpredictable.fr>
 <tdzkzc.i0jgs6ineqnz@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <tdzkzc.i0jgs6ineqnz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 24/4/26 08:56, Manos Pitsidianakis wrote:
> On Mon, 16 Mar 2026 15:06, Mohamed Mediouni <mohamed@unpredictable.fr> 
> wrote:
>> On HVF, some of the GIC state is in an opaque Apple-provided structure.
>>
>> Save/restore that state to be able to save/restore VMs that use the 
>> hardware GIC.
>>
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/intc/arm_gicv3_common.c         |  1 +
>> hw/intc/arm_gicv3_hvf.c            | 95 ++++++++++++++++++++++++++++--
>> hw/intc/arm_gicv3_hvf_stub.c       | 25 ++++++++
>> hw/intc/meson.build                |  1 +
>> include/hw/intc/arm_gicv3_common.h |  3 +
>> 5 files changed, 121 insertions(+), 4 deletions(-)
>> create mode 100644 hw/intc/arm_gicv3_hvf_stub.c


>> diff --git a/hw/intc/arm_gicv3_hvf.c b/hw/intc/arm_gicv3_hvf.c
>> index 55171a796b..18e5b3fe68 100644
>> --- a/hw/intc/arm_gicv3_hvf.c
>> +++ b/hw/intc/arm_gicv3_hvf.c
>> @@ -13,6 +13,7 @@
>> #include "qemu/error-report.h"
>> #include "qemu/module.h"
>> #include "system/runstate.h"
>> +#include "migration/vmstate.h"
>> #include "system/hvf.h"
>> #include "system/hvf_int.h"
>> #include "hvf_arm.h"
>> @@ -34,8 +35,13 @@ struct HVFARMGICv3Class {
>>
>> typedef struct HVFARMGICv3Class HVFARMGICv3Class;
>>
>> -/* This is reusing the GICv3State typedef from ARM_GICV3_ITS_COMMON */
>> -DECLARE_OBJ_CHECKERS(GICv3State, HVFARMGICv3Class,
>> +typedef struct HVFGICv3State {
>> +    GICv3State gicv3_state;

s/gicv3_state/parent_obj/

>> +    uint32_t size;
>> +    void *state;
>> +} HVFGICv3State;
>> +
>> +DECLARE_OBJ_CHECKERS(HVFGICv3State, HVFARMGICv3Class,
>>                      HVF_GICV3, TYPE_HVF_GICV3);
>>
>> /*
>> @@ -660,7 +666,7 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
>> static void hvf_gicv3_realize(DeviceState *dev, Error **errp)
>> {
>>     ERRP_GUARD();
>> -    GICv3State *s = HVF_GICV3(dev);
>> +    GICv3State *s = (GICv3State *)HVF_GICV3(dev);
> 
> Nit:     GICv3State *s = &HVF_GICV3(dev)->gicv3_state;
> reads better and is checked

No need to change the line at all.

> 
>>     HVFARMGICv3Class *kgc = HVF_GICV3_GET_CLASS(s);
>>     int i;
>>
>> @@ -707,6 +713,87 @@ static void hvf_gicv3_realize(DeviceState *dev, 
>> Error **errp)
>>     }
>> }


