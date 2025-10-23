Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99F7CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuVB-0006sS-MV; Thu, 23 Oct 2025 08:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjiaji1@huawei.com>)
 id 1vBuJP-00047E-W2; Thu, 23 Oct 2025 08:21:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjiaji1@huawei.com>)
 id 1vBuJK-0006tV-8a; Thu, 23 Oct 2025 08:20:59 -0400
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cslP8441nzRkLT;
 Thu, 23 Oct 2025 20:15:56 +0800 (CST)
Received: from kwepemj100010.china.huawei.com (unknown [7.202.194.4])
 by mail.maildlp.com (Postfix) with ESMTPS id 7495B180064;
 Thu, 23 Oct 2025 20:20:39 +0800 (CST)
Received: from huawei.com (10.246.99.10) by kwepemj100010.china.huawei.com
 (7.202.194.4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 20:20:38 +0800
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <kwolf@redhat.com>, <hreitz@redhat.com>,
 <zhuyangyang14@h-partners.com>, <eric.fangyi@huawei.com>,
 <suxiaodong1@huawei.com>, <wangjian161@huawei.com>, <wangyan122@huawei.com>,
 <liuxiangdong5@huawei.com>, <zhangjiaji1@huawei.com>,
 <wangqinxiao@huawei.com>, <luolongmin@huawei.com>
Subject: [RFC 0/2] block/qcow2: Improve I/O performance in write-through cache
 mode 
Date: Thu, 23 Oct 2025 20:24:55 +0800
Message-ID: <20251023122457.2610426-1-zhangjiaji1@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.246.99.10]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100010.china.huawei.com (7.202.194.4)
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=zhangjiaji1@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Oct 2025 08:24:33 -0400
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
Reply-to:  zhangjiaji <zhangjiaji1@huawei.com>
From:  zhangjiaji via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zhu Yangyang <zhuyangyang14@huawei.com>

I'm working on optimizing IO performance in writethrough cache mode. 
I've observed poor random write performance with the qcow2 driver, 
primarily because the writethrough mode executes a flush after 
each write operation. This flush triggers qcow2_write_caches(), and even 
with minimal changes in the cache, it refreshes the entire L2 table. 
This IO amplification becomes particularly noticeable when the L2 table size
is large.

My current approach involves writing to the cache immediately after 
updating an L2 entry, which would allow us to flush only the actually 
modified portions.

Initial test results are as follows:
The host uses an SSD disk with a 200GB qcow2 image file, created with
default configurations.
The virtual machine was tested using fio with the following command:
fio -ioengine=libaio -bs=4K -direct=1 -thread -numjobs=1 -rw=randwrite 
-size=200G -filename=/dev/vda -name=test -iodepth=32 -time_based -runtime=120

Before optimization:
IOPS: 3110, latency: 10.2ms
After optimization:
IOPS: 4964, latency: 6.4ms
Performance improved by 59.6%.

This patch is still quite preliminary, and I would greatly appreciate 
any comments or suggestions from the community.

Thank you very much!

Zhu Yangyang (2):
  block/qcow2-cache: Introduce qcow2_write_l2_entry()
  block/qcow2: Improve I/O performance in write-through cache mode for
    qcow2 driver

 block/qcow2-cache.c   | 40 +++++++++++++++++++++++++++++++++++++---
 block/qcow2-cluster.c | 15 +++++++++++++++
 block/qcow2.h         |  3 +++
 3 files changed, 55 insertions(+), 3 deletions(-)

-- 
2.33.0


