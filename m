Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4773BD65C5E
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 09:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBVlT-0004jU-Ji; Thu, 14 Nov 2024 04:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangzhou1@hisilicon.com>)
 id 1tBVlR-0004h8-Ts
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:03:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangzhou1@hisilicon.com>)
 id 1tBVlP-0004AU-Co
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:03:45 -0500
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XpvKt0t5Zz21l8t;
 Thu, 14 Nov 2024 17:02:10 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
 by mail.maildlp.com (Postfix) with ESMTPS id A1019140135;
 Thu, 14 Nov 2024 17:03:25 +0800 (CST)
Received: from [10.67.121.115] (10.67.121.115) by
 kwepemd200012.china.huawei.com (7.221.188.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 14 Nov 2024 17:03:25 +0800
Message-ID: <ac98a734-5de5-e107-6257-0c5fcd2fdfcd@hisilicon.com>
Date: Thu, 14 Nov 2024 17:03:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: <qemu-devel@nongnu.org>
Subject: Question about migration on ARM system
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Marc Zyngier
 <maz@kernel.org>, "Zengtao (B)" <prime.zeng@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.115]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200012.china.huawei.com (7.221.188.145)
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=wangzhou1@hisilicon.com; helo=szxga04-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

I am tring to heterogeneous live migration on ARM64 host. Now I just use
below kernel/qemu branch to have a try:
https://github.com/hisilicon/kernel-dev/tree/private-v6.11-rc2-hisi-migrn-wip
https://github.com/hisilicon/qemu/tree/stable-8.2-kunpeng920-initial-v2

Currently guest on GICv4.1 and GICv3 host can do migration successfully. I am
not sure that it is expected.

GICv4.1 exports GICD_TYPER2.nASSGIcap and GICD_CTRL.nASSGIreq to guest, so
guests(GICv3) on GICv4.1 and GICv3 host will have different state here. So
basically a guest on host GICv4.1 will lost state when it move to a host with
GICv3.

It seems that current mainline qemu does not consider GICD_TYPER2, and guest
OS(linux) does not use GICD_TYPER2.nASSGIcap and GICD_CTRL.nASSGIreq(just
check cap and set req), so current test has been passed.

In fact, there was some discussions about this problem:
https://lore.kernel.org/kvmarm/20200304203330.4967-21-maz@kernel.org/

I am not sure if we should prevent users from doing migration between host
GICv3 and GICv4.1?

Thanks,
Zhou

