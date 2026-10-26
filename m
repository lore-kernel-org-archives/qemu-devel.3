Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFF5606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 02:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLAfs-0006gD-FH; Sun, 25 Oct 2026 22:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xLAfa-0006br-Jg; Sun, 25 Oct 2026 22:42:43 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xLAfW-0002O1-9l; Sun, 25 Oct 2026 22:42:42 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jCdFf3nv8z5B108;
 Mon, 26 Oct 2026 10:42:30 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
 by mse-fl1.zte.com.cn with SMTP id 69Q2gLRa086507;
 Mon, 26 Oct 2026 10:42:21 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Mon, 26 Oct 2026 10:42:22 +0800
X-Zmail-TransId: 3e816adebe0d027-00c89
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Wang Yechao <wang.yechao255@zte.com.cn>,
 Xuemei Liu <liu.xuemei1@zte.com.cn>
Subject: [PATCH v5 2/4] hw/intc/riscv_aplic: Add in-kernel aplic save and
 restore function
Date: Mon, 26 Oct 2026 10:40:41 +0800
Message-ID: <20261026024048.630015-3-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20261026024048.630015-1-wang.yechao255@zte.com.cn>
References: <20261026024048.630015-1-wang.yechao255@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 69Q2gLRa086507
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 26 Oct 2026 10:42:30 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ADEBE16.002/4jCdFf3nv8z5B108
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

Add save and restore function if riscv_use_emulated_aplic return
false, it is to get and set APLIC irqchip state from KVM kernel.

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/intc/riscv_aplic.c         | 201 +++++++++++++++++++++++++++++-----
 include/hw/intc/riscv_aplic.h |   4 +
 2 files changed, 179 insertions(+), 26 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 03a0852b8b..a3d209ca23 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -979,9 +979,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
         }
 
         aplic->bitfield_words = (aplic->num_irqs + 31) >> 5;
-        aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
         aplic->state = g_new0(uint32_t, aplic->num_irqs);
-        aplic->target = g_new0(uint32_t, aplic->num_irqs);
         aplic->idelivery = g_new0(uint32_t, aplic->num_harts);
         aplic->iforce = g_new0(uint32_t, aplic->num_harts);
         aplic->ithreshold = g_new0(uint32_t, aplic->num_harts);
@@ -993,8 +991,16 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
         if (kvm_enabled()) {
             aplic->kvm_splitmode = true;
         }
+    } else {
+        aplic->nr_words = BITS_TO_U32S(aplic->num_irqs);
+        aplic->setip = g_new0(uint32_t, aplic->nr_words);
+        aplic->clrip = g_new0(uint32_t, aplic->nr_words);
+        aplic->setie = g_new0(uint32_t, aplic->nr_words);
     }
 
+    aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
+    aplic->target = g_new0(uint32_t, aplic->num_irqs);
+
     /*
      * Only root APLICs have hardware IRQ lines. All non-root APLICs
      * have IRQ lines delegated by their parent APLIC.
@@ -1020,47 +1026,190 @@ static const Property riscv_aplic_properties[] = {
     DEFINE_PROP_BOOL("mmode", RISCVAPLICState, mmode, 0),
 };
 
-static bool riscv_aplic_state_needed(void *opaque)
+static bool riscv_emulated_aplic_state_needed(void *opaque)
 {
     RISCVAPLICState *aplic = opaque;
 
     return riscv_use_emulated_aplic(aplic->msimode);
 }
 
+static const VMStateDescription vmstate_emulated_aplic_state = {
+    .name = "riscv_aplic/emulated_aplic_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = riscv_emulated_aplic_state_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VARRAY_UINT32(state, RISCVAPLICState,
+                              num_irqs, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
+        VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
+        VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
+        VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
+        VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
+        VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
+        VMSTATE_VARRAY_UINT32(idelivery, RISCVAPLICState,
+                              num_harts, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_VARRAY_UINT32(iforce, RISCVAPLICState,
+                              num_harts, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_VARRAY_UINT32(ithreshold, RISCVAPLICState,
+                              num_harts, 0,
+                              vmstate_info_uint32, uint32_t),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+#ifdef CONFIG_KVM
+static bool kvm_riscv_aplic_state_needed(void *opaque)
+{
+    RISCVAPLICState *aplic = opaque;
+
+    return !riscv_use_emulated_aplic(aplic->msimode);
+}
+
+static int kvm_riscv_aplic_state_pre_save(void *opaque)
+{
+    RISCVAPLICState *aplic = opaque;
+
+    for (uint32_t i = 0; i < aplic->nr_words; i++) {
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                 APLIC_SETIP_BASE + i * 4,
+                                 aplic->setip + i, false);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                 APLIC_CLRIP_BASE + i * 4,
+                                 aplic->clrip + i, false);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                 APLIC_SETIE_BASE + i * 4,
+                                 aplic->setie + i, false);
+    }
+
+    return 0;
+}
+
+static int kvm_riscv_aplic_state_post_load(void *opaque, int version_id)
+{
+    RISCVAPLICState *aplic = opaque;
+
+    for (uint32_t i = 0; i < aplic->nr_words; i++) {
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                 APLIC_SETIP_BASE + i * 4,
+                                 aplic->setip + i, true);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                 APLIC_CLRIP_BASE + i * 4,
+                                 aplic->clrip + i, true);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                 APLIC_SETIE_BASE + i * 4,
+                                 aplic->setie + i, true);
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_kvm_aplic_state = {
+    .name = "riscv_aplic/kvm_aplic_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = kvm_riscv_aplic_state_needed,
+    .pre_save = kvm_riscv_aplic_state_pre_save,
+    .post_load = kvm_riscv_aplic_state_post_load,
+    .fields = (const VMStateField[]) {
+            VMSTATE_VARRAY_UINT32(setip, RISCVAPLICState,
+                                  nr_words, 0,
+                                  vmstate_info_uint32, uint32_t),
+            VMSTATE_VARRAY_UINT32(clrip, RISCVAPLICState,
+                                  nr_words, 0,
+                                  vmstate_info_uint32, uint32_t),
+            VMSTATE_VARRAY_UINT32(setie, RISCVAPLICState,
+                                  nr_words, 0,
+                                  vmstate_info_uint32, uint32_t),
+            VMSTATE_END_OF_LIST()
+    }
+};
+
+static int riscv_aplic_pre_save(void *opaque)
+{
+    RISCVAPLICState *aplic = opaque;
+
+    if (!riscv_use_emulated_aplic(aplic->msimode)) {
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMAINCFG,
+                                 &aplic->domaincfg, false);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_GENMSI,
+                                 &aplic->genmsi, false);
+
+        for (uint32_t i = 1; i < aplic->num_irqs; i++) {
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                     APLIC_SOURCECFG_BASE + (i - 1) * 4,
+                                     aplic->sourcecfg + i, false);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                     APLIC_TARGET_BASE + (i - 1) * 4,
+                                     aplic->target + i, false);
+        }
+    }
+
+    return 0;
+}
+
+static int riscv_aplic_post_load(void *opaque, int version_id)
+{
+    RISCVAPLICState *aplic = opaque;
+
+    if (!riscv_use_emulated_aplic(aplic->msimode)) {
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMAINCFG,
+                                 &aplic->domaincfg, true);
+        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_GENMSI,
+                                 &aplic->genmsi, true);
+
+        for (uint32_t i = 1; i < aplic->num_irqs; i++) {
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                     APLIC_SOURCECFG_BASE + (i - 1) * 4,
+                                     aplic->sourcecfg + i, true);
+            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
+                                     APLIC_TARGET_BASE + (i - 1) * 4,
+                                     aplic->target + i, true);
+        }
+    }
+
+    return 0;
+}
+
+#else
+static int riscv_aplic_pre_save(void *opaque)
+{
+    return 0;
+}
+
+static int riscv_aplic_post_load(void *opaque, int version_id)
+{
+    return 0;
+}
+#endif
+
 static const VMStateDescription vmstate_riscv_aplic = {
     .name = "riscv_aplic",
-    .version_id = 3,
-    .minimum_version_id = 3,
-    .needed = riscv_aplic_state_needed,
+    .version_id = 4,
+    .minimum_version_id = 4,
+    .pre_save = riscv_aplic_pre_save,
+    .post_load = riscv_aplic_post_load,
     .fields = (const VMStateField[]) {
             VMSTATE_UINT32(domaincfg, RISCVAPLICState),
-            VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
-            VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
-            VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
-            VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
             VMSTATE_UINT32(genmsi, RISCVAPLICState),
-            VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
-            VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
-            VMSTATE_VARRAY_UINT32(sourcecfg, RISCVAPLICState,
-                                  num_irqs, 0,
-                                  vmstate_info_uint32, uint32_t),
-            VMSTATE_VARRAY_UINT32(state, RISCVAPLICState,
+            VMSTATE_VARRAY_UINT32(sourcecfg , RISCVAPLICState,
                                   num_irqs, 0,
                                   vmstate_info_uint32, uint32_t),
             VMSTATE_VARRAY_UINT32(target, RISCVAPLICState,
                                   num_irqs, 0,
                                   vmstate_info_uint32, uint32_t),
-            VMSTATE_VARRAY_UINT32(idelivery, RISCVAPLICState,
-                                  num_harts, 0,
-                                  vmstate_info_uint32, uint32_t),
-            VMSTATE_VARRAY_UINT32(iforce, RISCVAPLICState,
-                                  num_harts, 0,
-                                  vmstate_info_uint32, uint32_t),
-            VMSTATE_VARRAY_UINT32(ithreshold, RISCVAPLICState,
-                                  num_harts, 0,
-                                  vmstate_info_uint32, uint32_t),
             VMSTATE_END_OF_LIST()
-        }
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_emulated_aplic_state,
+#ifdef CONFIG_KVM
+        &vmstate_kvm_aplic_state,
+#endif
+        NULL
+    }
 };
 
 static void riscv_aplic_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
index 62d2b33ade..de0fed4748 100644
--- a/include/hw/intc/riscv_aplic.h
+++ b/include/hw/intc/riscv_aplic.h
@@ -53,6 +53,9 @@ struct RISCVAPLICState {
     uint32_t *idelivery;
     uint32_t *iforce;
     uint32_t *ithreshold;
+    uint32_t *setip;
+    uint32_t *clrip;
+    uint32_t *setie;
 
     /* topology */
 #define QEMU_APLIC_MAX_CHILDREN        16
@@ -66,6 +69,7 @@ struct RISCVAPLICState {
     uint32_t num_harts;
     uint32_t iprio_mask;
     uint32_t num_irqs;
+    uint32_t nr_words;
     bool msimode;
     bool mmode;
 
-- 
2.27.0


