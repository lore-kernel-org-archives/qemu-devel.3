Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D32D68B18
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 13:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBaC2-0000py-Lg; Thu, 14 Nov 2024 08:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangzhou1@hisilicon.com>)
 id 1tBaBl-0000gu-Io
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:47:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangzhou1@hisilicon.com>)
 id 1tBaBi-0006nN-2S
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:47:13 -0500
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Xq1cL1q3Gz1T4wQ;
 Thu, 14 Nov 2024 21:45:06 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
 by mail.maildlp.com (Postfix) with ESMTPS id 49B0418002B;
 Thu, 14 Nov 2024 21:46:58 +0800 (CST)
Received: from [10.67.121.115] (10.67.121.115) by
 kwepemd200012.china.huawei.com (7.221.188.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 14 Nov 2024 21:46:57 +0800
Message-ID: <3bd1c8d4-d5bf-75bb-bd22-089ab591f026@hisilicon.com>
Date: Thu, 14 Nov 2024 21:46:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Question about migration on ARM system
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
CC: <qemu-devel@nongnu.org>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, "Zengtao (B)"
 <prime.zeng@hisilicon.com>
References: <ac98a734-5de5-e107-6257-0c5fcd2fdfcd@hisilicon.com>
 <864j4avvu9.wl-maz@kernel.org>
In-Reply-To: <864j4avvu9.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.115]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200012.china.huawei.com (7.221.188.145)
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=wangzhou1@hisilicon.com; helo=szxga07-in.huawei.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.115,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Zhou Wang <wangzhou1@hisilicon.com>
From:  Zhou Wang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2024/11/14 20:33, Marc Zyngier wrote:
> On Thu, 14 Nov 2024 09:03:24 +0000,
> Zhou Wang <wangzhou1@hisilicon.com> wrote:
>>
>> Hi,
>>
>> I am tring to heterogeneous live migration on ARM64 host. Now I just use
>> below kernel/qemu branch to have a try:
>> https://github.com/hisilicon/kernel-dev/tree/private-v6.11-rc2-hisi-migrn-wip
>> https://github.com/hisilicon/qemu/tree/stable-8.2-kunpeng920-initial-v2
>>
>> Currently guest on GICv4.1 and GICv3 host can do migration successfully. I am
>> not sure that it is expected.
> 
> It isn't. Or rather, it shouldn't. Are you reporting a KVM problem or
> a QEMU problem?

I think KVM checks it in vgic_mmio_uaccess_write_v3_misc, however, current qemu
does not consider GICD_TYPER2 during migration.

In fact, I am wondering the description about GICD_TYPER2 in GIC spec. It said
"This register is present only when FEAT_GICv4p1 is implemented", from the view
of guest, we have a GICv3 device, however, we can see that GICD_TYPER2.nASSGIcap
is 1.

> 
>>
>> GICv4.1 exports GICD_TYPER2.nASSGIcap and GICD_CTRL.nASSGIreq to guest, so
>> guests(GICv3) on GICv4.1 and GICv3 host will have different state here. So
>> basically a guest on host GICv4.1 will lost state when it move to a host with
>> GICv3.
>>
>> It seems that current mainline qemu does not consider GICD_TYPER2, and guest
>> OS(linux) does not use GICD_TYPER2.nASSGIcap and GICD_CTRL.nASSGIreq(just
>> check cap and set req), so current test has been passed.
> 
> Well, the guest won't test that after migration. It doesn't even know
> it is migrated. But Linux definitely uses it at probe time.
> 
>>
>> In fact, there was some discussions about this problem:
>> https://lore.kernel.org/kvmarm/20200304203330.4967-21-maz@kernel.org/
>>
>> I am not sure if we should prevent users from doing migration between host
>> GICv3 and GICv4.1?
> 
> We should allow the v3->v4.1 path (we can hide the nAS SGIs), but we
> should not it the other way around.

Make sense, in the case of v3->v4.1, source and destination will use SGI
with an active state.

Thanks,
Zhou

> 
> Thanks,
> 
> 	M.
> 

