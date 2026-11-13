Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E060606A334
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRsyt-0001ql-4M; Fri, 13 Nov 2026 10:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xRsxo-0001Ct-MA; Fri, 13 Nov 2026 10:13:37 -0500
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xRsxk-0001rR-GZ; Fri, 13 Nov 2026 10:13:16 -0500
Received: from k3-03 (unknown [159.226.43.8])
 by APP-03 (Coremail) with SMTP id rQCowACneZr1KPdqPKn0AA--.15904S2;
 Fri, 13 Nov 2026 23:13:00 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 pierrick.bouvier@oss.qualcomm.com, nutty.liu@hotmail.com,
 Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH v2 0/3] hw/riscv: iommu: Support automatic PTE A/D updates
Date: Fri, 13 Nov 2026 23:12:48 +0800
Message-ID: <20261113151251.30618-1-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACneZr1KPdqPKn0AA--.15904S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr17AFyxXr17ZrWUGw15Arb_yoW8XrW7pF
 ZxGrs8uw4rJr1fAas3Zw17CF45Ga1rG3y5GF17J347JFsxKr48Wr1Dtay5Xa4DAa4rXF12
 v39FgF98uF40y37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
 YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwV
 W5WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
 6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
 Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
 Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
 IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUoyx_UUUUU
 =
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=tanchi25@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for automatic updates of page-table accessed
(A) and dirty (D) bits in the RISC-V IOMMU, as specified by the RISC-V
IOMMU architecture. The feature is advertised through the AMO_HWAD
capability and controlled by the SADE and GADE bits in device contexts.

The first two patches fix implicit G-stage page-table access handling
and IOATC permission checks. The third patch implements atomic A/D bit
updates using CAS, with page-table walk retries on concurrent
modifications and G-stage permission checks for implicit writes during
nested translation.

The implementation has been validated with QTests, Linux DMA tests under
KVM and TCG, and concurrency tests covering CAS retries, PTE
modifications, and G-stage mapping changes.

---
Changes in v2:
- Set iotval2 to zero for S-stage page faults, as suggested by
  Daniel Henrique Barboza.
- Avoid duplicate implicit_read calculations, as suggested by Nutty Liu.
- Document the new amo-hwad device property.

v1: https://lore.kernel.org/qemu-devel/20261108143934.129923-1-tanchi25@mails.ucas.ac.cn/

Tan Chi (3):
  hw/riscv: iommu: Fix implicit G-stage page-table accesses
  hw/riscv: iommu: Check permissions on IOATC hits
  hw/riscv: iommu: Support automatic PTE A/D updates

 docs/specs/riscv-iommu.rst |   2 +
 hw/riscv/riscv-iommu.c     | 254 +++++++++++++++++++++++++++++++++----
 hw/riscv/riscv-iommu.h     |   1 +
 3 files changed, 232 insertions(+), 25 deletions(-)

-- 
2.53.0


