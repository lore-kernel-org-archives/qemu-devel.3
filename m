Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18C9CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 16:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVEz-0004Pf-RE; Mon, 11 Aug 2025 12:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangkunkun@huawei.com>)
 id 1ulUzA-0007je-FK
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:02:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangkunkun@huawei.com>)
 id 1ulUyx-0006lT-CU
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:02:55 -0400
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c0zpm1YXzz1R8y4;
 Mon, 11 Aug 2025 23:59:28 +0800 (CST)
Received: from kwepemh200008.china.huawei.com (unknown [7.202.181.115])
 by mail.maildlp.com (Postfix) with ESMTPS id 5E0061A0188;
 Tue, 12 Aug 2025 00:02:17 +0800 (CST)
Received: from [10.174.176.125] (10.174.176.125) by
 kwepemh200008.china.huawei.com (7.202.181.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 00:02:16 +0800
Subject: [Question] VFIO migration will not be aborted in a corner scenario
To: Alex Williamson <alex.williamson@redhat.com>, Yishai Hadas
 <yishaih@nvidia.com>, <clg@redhat.com>
CC: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <6f64724d-7869-1283-bb75-193c7fba5576@huawei.com>
Date: Tue, 12 Aug 2025 00:02:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.125]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemh200008.china.huawei.com (7.202.181.115)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=jiangkunkun@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 11 Aug 2025 12:19:09 -0400
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
Reply-to:  Kunkun Jiang <jiangkunkun@huawei.com>
From:  Kunkun Jiang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi all,

While testing VFIO migration, I encountered an corner scenario case:
VFIO migration will not be aborted when the vfio device of dst-vm fails 
to transition from RESUMING to RUNNING state in vfio_vmstate_change.

I saw the comments in the vfio_vmstate_change but I don't understand why 
no action is taken for this situation. Allowing the live migration 
process to continue could cause unrecoverable damage to the VM. In this 
case, can we directly exit the dst-vm? Through the return-path 
mechanism, the src-vm can continue to run.

Looking forward to your reply.

Thanks,
Kunkun Jiang

