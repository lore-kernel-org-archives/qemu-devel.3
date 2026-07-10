Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0660C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi6Vg-0004DM-0Q; Fri, 10 Jul 2026 04:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wi6Ve-0004CA-I4
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:22:58 -0400
Received: from out-185.mta0.migadu.com ([91.218.175.185])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wi6Vb-0007Tg-Ph
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:22:57 -0400
Message-ID: <eb2d84d8-95bb-49ce-9671-153160fc529e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783671773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Np/oIZO73n9UrbgNeHiA4hxyrCE+v99CzSelxlH+CFE=;
 b=rzlk0SOd3hPS/Kza/QxZRlrStcDJVFXZqvHkdcYBkU3JOvzO+SDWzSmAtNeNsVu3ToCFaT
 pIvpPpnJ7o5vGHa872lhGFPHbeub3Cmx0qD3a5EwbLXXKPCpAb+MDymZ3uPshTBYemJQHY
 JRrj2tk6ry7eeSrOFwMc9lS813+xNFU=
Date: Fri, 10 Jul 2026 16:22:46 +0800
MIME-Version: 1.0
Cc: cui.tao@linux.dev, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2 2/3] target/loongarch: migrate pv_features in the vCPU
 VMState
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
References: <20260710005029.345378-1-cui.tao@linux.dev>
 <20260710005029.345378-3-cui.tao@linux.dev>
 <13ad4779-5887-f9e3-864a-075162ee38fc@loongson.cn>
 <d68d39b3-e197-af10-f926-ba76c481c7eb@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <d68d39b3-e197-af10-f926-ba76c481c7eb@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.185; envelope-from=cui.tao@linux.dev;
 helo=out-185.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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



在 2026/7/10 11:15, Bibo Mao 写道:
> 
> 
> On 2026/7/10 上午11:02, Bibo Mao wrote:
>>
>>
>> On 2026/7/10 上午8:50, Tao Cui wrote:
>>> From: Tao Cui <cuitao@kylinos.cn>
>>>
>>> pv_features holds the value of pseudo-register CPUCFG_KVM_FEATURE and is now
>>> pushed per vCPU. Add it to the vCPU VMState as a subsection (sent when
>>> non-zero) so it travels with the vCPU across migration between host kernel
>>> versions.
>>>
>>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>>> ---
>>>   target/loongarch/machine.c | 19 +++++++++++++++++++
>>>   1 file changed, 19 insertions(+)
>>>
>>> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
>>> index 931a5ca5ba..b8819bd44d 100644
>>> --- a/target/loongarch/machine.c
>>> +++ b/target/loongarch/machine.c
>>> @@ -65,6 +65,24 @@ static const VMStateDescription vmstate_msgint = {
>>>       },
>>>   };
>>> +static bool pv_features_needed(void *opaque)
>>> +{
>>> +    LoongArchCPU *cpu = opaque;
>>> +
>>> +    return cpu->env.pv_features != 0;
>> I think cpu->no_pv_feature should be check here. For QEMU 11.1 pv_feature is not supported for migration, for later version it supports, something like this:
>>         return !cpu->no_pv_feature;
> For successful migration, env.pv_features from source host should be subset of destination host, there should be such checking also.
> 
Agreed on both points.

1. I'll change .needed to `return !cpu->no_pv_feature` so the subsection
   is gated by machine version. Since it references no_pv_feature (added
   in the compat patch), I'll reorder so compat comes before vmstate.

2. For the subset check, I'll add a .post_load that calls
   kvm_feature_supported() for each PV feature to build the destination's
   supported mask, and rejects migration if the migrated pv_features has
   bits outside it. Does this look right?

Thanks,
Tao
>>
>> Regards
>> Bibo Mao
>>> +}
>>> +
>>> +static const VMStateDescription vmstate_pv_features = {
>>> +    .name = "cpu/pv_features",
>>> +    .version_id = 1,
>>> +    .minimum_version_id = 1,
>>> +    .needed = pv_features_needed,
>>> +    .fields = (const VMStateField[]) {
>>> +        VMSTATE_UINT32(env.pv_features, LoongArchCPU),
>>> +        VMSTATE_END_OF_LIST()
>>> +    },
>>> +};
>>> +
>>>   static const VMStateDescription vmstate_lsxh_reg = {
>>>       .name = "lsxh_reg",
>>>       .version_id = 1,
>>> @@ -289,6 +307,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
>>>           &vmstate_lbt,
>>>           &vmstate_msgint,
>>>           &vmstate_pmu,
>>> +        &vmstate_pv_features,
>>>           NULL
>>>       }
>>>   };
>>>
>>
> 


