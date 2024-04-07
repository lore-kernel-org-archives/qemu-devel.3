Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233C4CD11C2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 12:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtRd9-00041L-Mo; Sun, 07 Apr 2024 08:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshanliukou@163.com>)
 id 1rtJVi-0005uS-6N; Sat, 06 Apr 2024 23:48:02 -0400
Received: from m16.mail.163.com ([220.197.31.2])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaoshanliukou@163.com>)
 id 1rtJVc-0005om-Gm; Sat, 06 Apr 2024 23:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4f7TS
 RBbgfkLgOcVoI4QIjA+BkbLTOmgyh2hhWCMGvw=; b=HjnbinctP2VL5JlGEvzzX
 d18f3oU1ysZ77D9ie6bgDNAXLORScAz/X4KfOAYawPiKD7MgmBP8dcEaoZUY5RzX
 L5c67i++VTSS5sEf70sR7+Ry3SIsaK0EehFtz8OWIE4TUGn14B7aC+WTRtZ/jjlL
 5C4Oit1wArunk6K3jVS1nE=
Received: from yangzhang2020.localdomain (unknown [60.27.226.9])
 by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wDHp_crFxJmajFNAQ--.60835S2;
 Sun, 07 Apr 2024 11:46:52 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com, anup@brainfault.org
Cc: "yang.zhang" <yang.zhang@hexintek.com>
Subject: [PATCH] hw/intc/riscv_aplic: APLICs should add child earlier than
 realize
Date: Sun,  7 Apr 2024 11:46:52 +0800
Message-Id: <20240407034652.25739-1-gaoshanliukou@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHp_crFxJmajFNAQ--.60835S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1rGr4fWw13tr18uFW3ZFb_yoWDCrb_GF
 9ak3s7GrWrXF4fAayDCF4UGFyvv34rurW3ZFWSvF43tr4UKr98twnFgr9xtrW09rW7Wr93
 GFyvvr93AryUGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn8gAUUUUUU==
X-Originating-IP: [60.27.226.9]
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/1tbiRAGv8mVOCD0wFAABsj
Received-SPF: pass client-ip=220.197.31.2; envelope-from=gaoshanliukou@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 07 Apr 2024 08:27:52 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "yang.zhang" <yang.zhang@hexintek.com>

Since only root APLICs can have hw IRQ lines, aplic->parent should
be initialized first.

Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
---
 hw/intc/riscv_aplic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index fc5df0d598..32edd6d07b 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -1000,16 +1000,16 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
     qdev_prop_set_bit(dev, "msimode", msimode);
     qdev_prop_set_bit(dev, "mmode", mmode);
 
+    if (parent) {
+        riscv_aplic_add_child(parent, dev);
+    }
+
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     if (!is_kvm_aia(msimode)) {
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     }
 
-    if (parent) {
-        riscv_aplic_add_child(parent, dev);
-    }
-
     if (!msimode) {
         for (i = 0; i < num_harts; i++) {
             CPUState *cpu = cpu_by_arch_id(hartid_base + i);
-- 
2.25.1


