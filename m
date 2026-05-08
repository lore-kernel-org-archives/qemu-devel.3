Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC45CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 14:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMMi-0001sU-UR; Fri, 08 May 2026 10:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wLMMb-0001rK-QM
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wLMMZ-0007cZ-Bh
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778251174;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPdghPq+tdyEmOuhyPSK5nQ1AdYqLmrQ28ER9Z/2XHI=;
 b=Rl/KbI5NbgTKWFDB9UAnJnlkVL+eTqySQ5ldh7oDpiEAUjlS7IrnkTBFWee8dLN+tluWQU
 Size72UhcddKmFJqb4XgjxgAvSXFselqSaJ4CQb89a4k2AoyLhkpm2Efycw46ZyK+cmWdl
 28ilUQ5XH5K1e4n6gRD6xrsvXZ9fpQg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-i7pkjUgAPwSOkyHLxHJifQ-1; Fri, 08 May 2026 10:39:32 -0400
X-MC-Unique: i7pkjUgAPwSOkyHLxHJifQ-1
X-Mimecast-MFC-AGG-ID: i7pkjUgAPwSOkyHLxHJifQ_1778251171
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48d035e8593so12566965e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 07:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778251171; x=1778855971;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPdghPq+tdyEmOuhyPSK5nQ1AdYqLmrQ28ER9Z/2XHI=;
 b=OVA4Cvx6WCEgeWC23MWdyXuJF8m8DTn9pKHdX46nglau4wUwxxkYSPrBdkxOgmSYug
 IYORPnwo91wuFbtC2oRTxlKBWx9mLc0CMuYxgkfqXxuwi7ChCPLNED4NiQbMRbIQoKar
 tRRsGvgpQ2JOrn+PRyzn+pcdvAB76x1PedceLzRxfjuBizHLeqGXbuk0U00llxeIK4Ap
 a/tQ5hJzOXxL99+qd6YveZuVSPB9EXKl7U3+d1m0vFA5z472ByMqb883MsKHLmqfQ1OV
 pyOiCPGpLGHbeuswxnxlJNDcBHcxIizhyAQ69kG2hSGdqd21tqHuCkDMQ8Iz3e6cbiVW
 0RpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rA01C1IJNp9x/m/ci9F4Q+NLG0eXPPdmKuMYXKwBqcOvtDEF1YCuTk+MwvKzAnV3Vn35VPiP2I/Nb@nongnu.org
X-Gm-Message-State: AOJu0YwU5dozGJRlgqAx7PKKfO5ULSS5WZE064tv3QpOweQ3TRD/6tBB
 f3UAcYiBqcU/6C0yVqh5plMGByNbdrdnTKzB0BdDaBaD3topftH5nC5qRmmty+sPhCjDO7+QzcA
 ur/1hjW+6NxRDXh4tyKVWUqjOfqRmUQG4Y6uwCcBjORWk3bTRrENIoInn
X-Gm-Gg: AeBDievXiL0jw7WfeLWd2P03+QfmjO4Tl1hbdzNQioob96g34j3L/MI9FsYOxxYEX6V
 jf49Bz8CViMXY5eKE3F3A1d0eXm/hjvClFBlR9MGd8vwQM2dSahH+AxzTCgWeZCCLOmYyCt2IRo
 UUvJu5B49xQz9ll6t2up5EFXCJ9Kxq5kZVH+l2RmcPTT+WDZlZ8reMgQ3dFkxG4lnCndQbjgop0
 x+KcOZ8u76p824CY/guWBEKTLXwaV65YlyxJ5tG4NL7GKY9u3L1Y7BBbGqys/Lrfgi8m4ZtrKD1
 DZzEpRp2RJkvmxp1Kcq77YIfvmNJfzwYiq4EbitL6UPnLOnCfHmZ0zOZLhNe9KHS1EP5a9UUGBV
 GhpcQJvptqW6pghB7BbJzSpYi6pRNB/pAX9l+pt5YWUkSYX2MSKeEf3s1GHWYITg96bD5Xg==
X-Received: by 2002:a05:600c:350a:b0:48a:5565:ec3d with SMTP id
 5b1f17b1804b1-48e676ac38fmr45837125e9.22.1778251170429; 
 Fri, 08 May 2026 07:39:30 -0700 (PDT)
X-Received: by 2002:a05:600c:350a:b0:48a:5565:ec3d with SMTP id
 5b1f17b1804b1-48e676ac38fmr45836485e9.22.1778251169904; 
 Fri, 08 May 2026 07:39:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454917d57aesm5010794f8f.26.2026.05.08.07.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 07:39:29 -0700 (PDT)
Message-ID: <13ecaca7-9365-4f44-a31d-7fdd0902dbcf@redhat.com>
Date: Fri, 8 May 2026 16:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/31] hw/arm/tegra241-cmdqv: Add reset handler
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-26-skolothumtho@nvidia.com>
 <667dd47e-bb1a-47d7-bd19-194efade286a@redhat.com>
 <CH3PR12MB7548B3CEB0292498F65837D1AB3D2@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548B3CEB0292498F65837D1AB3D2@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/8/26 1:19 PM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 07 May 2026 17:52
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
>> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>;
>> phrdina@redhat.com
>> Subject: Re: [PATCH v4 25/31] hw/arm/tegra241-cmdqv: Add reset handler
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 4/15/26 12:55 PM, Shameer Kolothum wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> Introduce a reset handler for the Tegra241 CMDQV and initialize its
>>> register state.
>>>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>  hw/arm/tegra241-cmdqv.h |  2 ++
>>>  hw/arm/tegra241-cmdqv.c | 50
>> +++++++++++++++++++++++++++++++++++++++++
>>>  hw/arm/trace-events     |  1 +
>>>  3 files changed, 53 insertions(+)
>>>
>>> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
>>> index 2befa6205e..b2a444daef 100644
>>> --- a/hw/arm/tegra241-cmdqv.h
>>> +++ b/hw/arm/tegra241-cmdqv.h
>>> @@ -79,6 +79,8 @@ FIELD(CONFIG, CMDQ_MAX_CLK_BATCH, 4, 8)
>>>  FIELD(CONFIG, CMDQ_MAX_CMD_BATCH, 12, 8)
>>>  FIELD(CONFIG, CONS_DRAM_EN, 20, 1)
>>>
>>> +#define V_CONFIG_RESET 0x00020403
>>> +
>>>  REG32(PARAM, 0x4)
>>>  FIELD(PARAM, CMDQV_VER, 0, 4)
>>>  FIELD(PARAM, CMDQV_NUM_CMDQ_LOG2, 4, 4)
>>> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
>>> index 9c2fc02b92..af68add2f0 100644
>>> --- a/hw/arm/tegra241-cmdqv.c
>>> +++ b/hw/arm/tegra241-cmdqv.c
>>> @@ -8,6 +8,7 @@
>>>   */
>>>
>>>  #include "qemu/osdep.h"
>>> +#include "qemu/error-report.h"
>>>  #include "qemu/log.h"
>>>
>>>  #include "hw/arm/smmuv3.h"
>>> @@ -645,8 +646,57 @@ free_viommu:
>>>      return false;
>>>  }
>>>
>>> +static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV
>> *cmdqv)
>>> +{
>>> +    int i;
>>> +
>>> +    cmdqv->config = V_CONFIG_RESET;
>>> +    cmdqv->param = FIELD_DP32(0, PARAM, CMDQV_VER, CMDQV_VER);
>> hw/core/registerfields.h:#define FIELD_DP32(storage, reg, field, val)
>> what does this 0?
> I think it is to make sure we have no garbage set for non-field bits.
> Starting from 0 guarantees non-field bits are clean.

OK thanks ;-)

Eric
>
>>> +    cmdqv->param = FIELD_DP32(cmdqv->param, PARAM,
>> CMDQV_NUM_CMDQ_LOG2,
>>> +                              CMDQV_NUM_CMDQ_LOG2);
>> I was a bit puzzled by the FIELD name being the value name but well.
>>> +    cmdqv->param = FIELD_DP32(cmdqv->param, PARAM,
>> CMDQV_NUM_SID_PER_VI_LOG2,
>>> +                              CMDQV_NUM_SID_PER_VI_LOG2);
>>> +    trace_tegra241_cmdqv_init_regs(cmdqv->param);
>>> +    cmdqv->status = R_STATUS_CMDQV_ENABLED_MASK;
>>> +    for (i = 0; i < 2; i++) {
>>> +        cmdqv->vi_err_map[i] = 0;
>>> +        cmdqv->vi_int_mask[i] = 0;
>>> +        cmdqv->cmdq_err_map[i] = 0;
>>> +    }
>>> +    cmdqv->cmdq_err_map[2] = 0;
>>> +    cmdqv->cmdq_err_map[3] = 0;
>> the split looks pretty strange, ie. loop of 2 + continue with individual
>> setting. why don't you do the init of
>>
>> cmdqv->cmdq_err_map in the x4 loop below
> 😊. True, that does look strange. I will change.
>
> Thanks,
> Shameer


