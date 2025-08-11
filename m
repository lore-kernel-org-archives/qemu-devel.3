Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C3CC87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 03:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulJgE-0004AJ-HZ; Sun, 10 Aug 2025 23:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <z_bajeer@yeah.net>)
 id 1ulJg6-00046X-EA; Sun, 10 Aug 2025 23:58:31 -0400
Received: from mail-m16.yeah.net ([220.197.32.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <z_bajeer@yeah.net>)
 id 1ulJfz-0007RB-Jl; Sun, 10 Aug 2025 23:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uB
 koBmcdvuPo7oUAhA1VSaTg/FGyWr70u9Y0O+L5rOk=; b=p44bNTjm3Hdy/k9Tib
 uuJzPGIMbDNuLW0QrupjviVeuSetc4h2eDJ5FMFMpepxUqXZXwxAcdZAZ1hbESmr
 OebTOk/UNV+mLhqkGrvkKIqxuoVZprBluAUu5gynMZ6qlKl28PP/8UzmF/SdJlA0
 PG9wQrDT5MjdP+ap+6sxbFZjQ=
Received: from vcore-181.. (unknown [])
 by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3n90vaplo2XtlAg--.61904S2;
 Mon, 11 Aug 2025 11:57:37 +0800 (CST)
From: Yang Jialong <z_bajeer@yeah.net>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: yangjialong@rvcore.com, Yang Jialong <z_bajeer@yeah.net>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2] aplic: fix mask for smsiaddrcfgh
Date: Mon, 11 Aug 2025 11:44:53 +0800
Message-Id: <20250811034454.189208-1-z_bajeer@yeah.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Mc8vCgD3n90vaplo2XtlAg--.61904S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1UGryrZw13Cr4kZw1fZwb_yoW5uF1xpF
 4kGwsxKF45Jr1xKanay3WxJry3JrykC3sFyr1DW3409F4kZrs0934kKr4q9ry5JryfCr15
 Aw4Fq3WDWFsxA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UeBT5UUUUU=
X-Originating-IP: [49.7.252.142]
X-CM-SenderInfo: p2betyxhhuq5hhdkh0dhw/1tbiBBOmI2iZJXrFQgAAs7
Received-SPF: pass client-ip=220.197.32.17; envelope-from=z_bajeer@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

4.5.4. Supervisor MSI address configuration (smsiaddrcfg and
  smsiaddrcfgh)
smsiaddrcfgh:
        bits 22:20 LHXS(WARL)
        bits 11:0  High Base PPN(WARL)

Signed-off-by: Yang Jialong <z_bajeer@yeah.net>
---
 hw/intc/riscv_aplic.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

v1 --> v2:
- fix calculation of MSI address.
- In Supervisor mode, lhxw/hhxs/hhxw fields are in mmsiaddrcfgh register.
- And lhxs field is in smsiaddrcfgh.

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a1d9fa5085..2dd54cafaa 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -96,7 +96,7 @@
     (APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) << \
      APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs))
 
-#define APLIC_xMSICFGADDRH_VALID_MASK   \
+#define APLIC_MMSICFGADDRH_VALID_MASK   \
     (APLIC_xMSICFGADDRH_L | \
      (APLIC_xMSICFGADDRH_HHXS_MASK << APLIC_xMSICFGADDRH_HHXS_SHIFT) | \
      (APLIC_xMSICFGADDRH_LHXS_MASK << APLIC_xMSICFGADDRH_LHXS_SHIFT) | \
@@ -104,6 +104,10 @@
      (APLIC_xMSICFGADDRH_LHXW_MASK << APLIC_xMSICFGADDRH_LHXW_SHIFT) | \
      APLIC_xMSICFGADDRH_BAPPN_MASK)
 
+#define APLIC_SMSICFGADDRH_VALID_MASK   \
+    ((APLIC_xMSICFGADDRH_LHXS_MASK << APLIC_xMSICFGADDRH_LHXS_SHIFT) | \
+     APLIC_xMSICFGADDRH_BAPPN_MASK)
+
 #define APLIC_SETIP_BASE               0x1c00
 #define APLIC_SETIPNUM                 0x1cdc
 
@@ -409,13 +413,8 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
         msicfgaddr = aplic->kvm_msicfgaddr;
         msicfgaddrH = ((uint64_t)aplic->kvm_msicfgaddrH << 32);
     } else {
-        if (aplic->mmode) {
-            msicfgaddr = aplic_m->mmsicfgaddr;
-            msicfgaddrH = aplic_m->mmsicfgaddrH;
-        } else {
-            msicfgaddr = aplic_m->smsicfgaddr;
-            msicfgaddrH = aplic_m->smsicfgaddrH;
-        }
+        msicfgaddr = aplic_m->mmsicfgaddr;
+        msicfgaddrH = aplic_m->mmsicfgaddrH;
     }
 
     lhxs = (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
@@ -427,6 +426,14 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
     hhxw = (msicfgaddrH >> APLIC_xMSICFGADDRH_HHXW_SHIFT) &
             APLIC_xMSICFGADDRH_HHXW_MASK;
 
+    if (!aplic->kvm_splitmode && !aplic->mmode) {
+        msicfgaddrH = aplic_m->smsicfgaddrH;
+        msicfgaddr = aplic_m->smsicfgaddr;
+
+        lhxs = (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
+            APLIC_xMSICFGADDRH_LHXS_MASK;
+    }
+
     group_idx = hart_idx >> lhxw;
 
     addr = msicfgaddr;
@@ -771,7 +778,7 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_MMSICFGADDRH)) {
         if (!(aplic->mmsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
-            aplic->mmsicfgaddrH = value & APLIC_xMSICFGADDRH_VALID_MASK;
+            aplic->mmsicfgaddrH = value & APLIC_MMSICFGADDRH_VALID_MASK;
         }
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_SMSICFGADDR)) {
@@ -792,7 +799,7 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
                (addr == APLIC_SMSICFGADDRH)) {
         if (aplic->num_children &&
             !(aplic->mmsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
-            aplic->smsicfgaddrH = value & APLIC_xMSICFGADDRH_VALID_MASK;
+            aplic->smsicfgaddrH = value & APLIC_SMSICFGADDRH_VALID_MASK;
         }
     } else if ((APLIC_SETIP_BASE <= addr) &&
             (addr < (APLIC_SETIP_BASE + aplic->bitfield_words * 4))) {
-- 
2.34.1


