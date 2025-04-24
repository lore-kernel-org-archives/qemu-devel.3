Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA39C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 12:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7vdX-0006VB-I9; Thu, 24 Apr 2025 08:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1u7vdR-0006UB-0k
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 08:24:57 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1u7vdN-0003p9-U3
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 08:24:56 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zjw5w6knpz6K9cr;
 Thu, 24 Apr 2025 20:20:04 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id A54181402EF;
 Thu, 24 Apr 2025 20:24:41 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.67.86) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Apr 2025 14:24:40 +0200
To: <qemu-devel@nongnu.org>
CC: <anisinha@redhat.com>, <imammedo@redhat.com>,
 <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>, <mst@redhat.com>,
 <peter.maydell@linaro.org>, <prime.zeng@hisilicon.com>,
 <shameerali.kolothum.thodi@huawei.com>, <wangyanan55@huawei.com>,
 <yangyicong@hisilicon.com>
Subject: [PATCH v4 0/4] Building PPTT with root node and identical
 implementation flag
Date: Thu, 24 Apr 2025 13:24:35 +0100
Message-ID: <20250424122439.550-1-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.67.86]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500003.china.huawei.com (7.182.85.28)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

OS like Linux is using PPTT processor node's identical implementation
flag [1] to infer whether the whole system or a certain CPU cluster is
homogeneous or not [2]. QEMU currently only support building homogeneous
system, set the flag to indicate the fact. Build a root node in PPTT for
indicates the identical implementation which is needed for a
multi-socket system. Update the related PPTT tables as well.

[1] ACPI 6.5 Table 5.158: Processor Structure Flags
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/pptt.c?h=v6.11-rc1#n810

History:
    * v3->v4: PPTT rev to 2

    * v2->v3: rebase to 10

Alireza Sanaee (1):
  tests: virt: Update expected ACPI tables for virt test

Yicong Yang (3):
  tests: virt: Allow changes to PPTT test table
  hw/acpi/aml-build: Set identical implementation flag for PPTT
    processor nodes
  hw/acpi/aml-build: Build a root node in the PPTT table

 hw/acpi/aml-build.c                           |  24 +++++++++++++++---
 tests/data/acpi/aarch64/virt/PPTT             | Bin 76 -> 96 bytes
 .../data/acpi/aarch64/virt/PPTT.acpihmatvirt  | Bin 156 -> 176 bytes
 tests/data/acpi/aarch64/virt/PPTT.topology    | Bin 336 -> 356 bytes
 4 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.34.1


