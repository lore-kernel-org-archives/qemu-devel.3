Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A43C61DE3
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtk5G-0004Hr-6j; Sat, 21 Feb 2026 05:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk58-00040E-DB; Sat, 21 Feb 2026 05:19:26 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtk56-0004hh-R9; Sat, 21 Feb 2026 05:19:26 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCXnJirhplpgbBVBw--.3766S2;
 Sat, 21 Feb 2026 18:19:23 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCX7+yohplphU4cAA--.49442S3;
 Sat, 21 Feb 2026 18:19:20 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v4 29/31] hw/arm/smmuv3: Initialize the secure register bank
Date: Sat, 21 Feb 2026 18:19:18 +0800
Message-Id: <20260221101918.2997679-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCX7+yohplphU4cAA--.49442S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWmYzyUATwAAsd
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tFyDZF1Dur45ZrWrCrWDCFg_yoW8uFyfpa
 nrA3Z0kw1UKF1fW39xAw4UAr1aqr4Iqwn8Cry7GF13Cw15GryrXFWDK34rWa4IvrZ8Ww45
 GFnagFZ0vw15A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Initialize the secure register bank (SMMU_SEC_SID_S) with sane default
values during the SMMU's reset sequence.

This change ensures that key fields, such as the secure ID registers,
GBPA reset value, and queue entry sizes, are set to a known-good state.
The SECURE_IMPL attribute of the S_IDR1 register will be introduced
later via device properties.

This is a necessary step to prevent undefined behavior when secure SMMU
features are subsequently enabled and used by software.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 57a063b5e5d..f0fbc5fc96b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -321,7 +321,12 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     bk->idr[5] = FIELD_DP32(bk->idr[5], IDR5, GRAN4K, 1);
     bk->idr[5] = FIELD_DP32(bk->idr[5], IDR5, GRAN16K, 1);
     bk->idr[5] = FIELD_DP32(bk->idr[5], IDR5, GRAN64K, 1);
-    s->aidr = 0x1;
+
+    /* Initialize Secure bank */
+    SMMUv3RegBank *sbk = smmuv3_bank(s, SMMU_SEC_SID_S);
+    memset(sbk->idr, 0, sizeof(sbk->idr));
+    sbk->idr[0] = FIELD_DP32(bk->idr[0], S_IDR0, STALL_MODEL, 1); /* No stall */
+    sbk->idr[1] = FIELD_DP32(sbk->idr[1], S_IDR1, S_SIDSIZE, SMMU_IDR1_SIDSIZE);
     smmuv3_accel_idr_override(s);
 }
 
@@ -347,6 +352,26 @@ static void smmuv3_reset(SMMUv3State *s)
     bk->gerrorn = 0;
     bk->gbpa = SMMU_GBPA_RESET_VAL;
 
+    SMMUv3RegBank *sbk = smmuv3_bank(s, SMMU_SEC_SID_S);
+
+    sbk->cmdq.base = deposit64(sbk->cmdq.base, 0, 5, SMMU_CMDQS);
+    sbk->cmdq.prod = 0;
+    sbk->cmdq.cons = 0;
+    sbk->cmdq.entry_size = sizeof(struct Cmd);
+    sbk->eventq.base = deposit64(sbk->eventq.base, 0, 5, SMMU_EVENTQS);
+    sbk->eventq.prod = 0;
+    sbk->eventq.cons = 0;
+    sbk->eventq.entry_size = sizeof(struct Evt);
+
+    sbk->features = 0;
+    sbk->sid_split = 0;
+    sbk->cr[0] = 0;
+    sbk->cr0ack = 0;
+    sbk->irq_ctrl = 0;
+    sbk->gerror = 0;
+    sbk->gerrorn = 0;
+    sbk->gbpa = SMMU_GBPA_RESET_VAL;
+
     s->aidr = 0x1;
     s->statusr = 0;
 }
-- 
2.34.1


