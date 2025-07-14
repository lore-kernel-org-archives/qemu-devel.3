Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DB9C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 18:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubO6a-0004Mb-Kv; Mon, 14 Jul 2025 14:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1ubN1x-0000tU-Lw
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:32:06 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1ubN1v-00068C-OF
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:31:57 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgq905jqjz6L5CC;
 Tue, 15 Jul 2025 01:30:44 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id E293A14038F;
 Tue, 15 Jul 2025 01:31:49 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.81.206.233) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 19:31:48 +0200
To: <qemu-devel@nongnu.org>, <mst@redhat.com>
CC: <anisinha@redhat.com>, <gaosong@loongson.cn>, <imammedo@redhat.com>,
 <jiaxun.yang@flygoat.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <maobibo@loongson.cn>, <peter.maydell@linaro.org>,
 <prime.zeng@hisilicon.com>, <shameerali.kolothum.thodi@huawei.com>,
 <wangyanan55@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH v7 0/4] Building PPTT with root node and identical
 implementation flag
Date: Mon, 14 Jul 2025 18:31:42 +0100
Message-ID: <20250714173146.511-1-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.81.206.233]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500003.china.huawei.com (7.182.85.28)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

We observed an issue interacting with Loongarch with this patchset, and
there was a discussion about it in [3], and eventually thanks to Bibo we
have a patchset that fixed the interactions with Loongarch in the [4].

History:
    * v6->v7: Rebased on top of MST's v11-14-07-2025 branch, and added
      loongarch64 PPTT and PPTT.topology test files.
    * v5->v6: Rebased on 09be8a511a2e278b45729d7b065d30c68dd699d0
    * v4->v5: fixed a typo
    * v3->v4: PPTT rev to 2
    * v2->v3: rebase to 10

[1] ACPI 6.5 Table 5.158: Processor Structure Flags
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/pptt.c?h=v6.11-rc1#n810
[3] https://lore.kernel.org/all/99a37f40-56dc-ab7a-86ff-1a9dcb3cc711@loongson.cn/
[4] https://lore.kernel.org/qemu-devel/20250604065502.1114098-1-maobibo@loongson.cn/

DEPEND-ON: Message-ID: <20250604065502.1114098-1-maobibo@loongson.cn>

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
 tests/data/acpi/loongarch64/virt/PPTT         | Bin 76 -> 96 bytes
 .../data/acpi/loongarch64/virt/PPTT.topology  | Bin 176 -> 196 bytes
 6 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.43.0


