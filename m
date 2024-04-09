Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAD6CD1292
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 01:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru0YG-0002rL-Er; Mon, 08 Apr 2024 21:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshanliukou@163.com>)
 id 1ru0YD-0002qs-Ny; Mon, 08 Apr 2024 21:45:30 -0400
Received: from m15.mail.163.com ([45.254.50.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaoshanliukou@163.com>)
 id 1ru0Y8-0002dZ-TI; Mon, 08 Apr 2024 21:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SKbmt
 GgfdYAt7wOyjzWxqhxCPv8VX3ag2PzYIUaPHL4=; b=RvTUF2zZcv5tew2E5TiJJ
 2fDem6qHGgA5qP5mD5fUaqD/N7cHXV+gS3eInrf63b7E6DMiBCtyR9Gc8sI63SsF
 kzX6bepZ0owg609h0TrEyUTL4Br+wVzxw+CGKlpFg6tE7Pk1vFWsFfmllTCr8hSQ
 Xw8vA7hlOOrp17m4VkzZVc=
Received: from yangzhang2020.localdomain (unknown [60.27.226.9])
 by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDXj5GbnRRm+V4oAg--.35579S2;
 Tue, 09 Apr 2024 09:45:00 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 "yang.zhang" <yang.zhang@hexintek.com>
Subject: [PATCH] hw/intc/riscv_aplic: APLICs should add child earlier than
 realize
Date: Tue,  9 Apr 2024 09:44:45 +0800
Message-Id: <20240409014445.278-1-gaoshanliukou@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXj5GbnRRm+V4oAg--.35579S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1rGr43WFWrGFy7WrW8Crg_yoWkurb_GF
 9ak3srGr45JF4Fva1DCF4UJrW0v34rurW3ZFWSvF4rtr4UKr98twsF9r93trW09rW7Cr95
 GFykZr93CryUGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnWE_tUUUUU==
X-Originating-IP: [60.27.226.9]
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/1tbiRAu68mVOCNubxgACsg
Received-SPF: pass client-ip=45.254.50.220; envelope-from=gaoshanliukou@163.com;
 helo=m15.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "yang.zhang" <yang.zhang@hexintek.com>

Since only root APLICs can have hw IRQ lines, aplic->parent should
be initialized first.

Fixes: e8f79343cf ("hw/intc: Add RISC-V AIA APLIC device emulation")
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
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


