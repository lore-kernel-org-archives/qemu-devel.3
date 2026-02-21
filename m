Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25ECBC61DCB
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 10:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtjpn-0005o2-TW; Sat, 21 Feb 2026 05:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtjpf-0005mN-RV; Sat, 21 Feb 2026 05:03:28 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vtjpd-00054P-QC; Sat, 21 Feb 2026 05:03:27 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwB3fJjjgplpbqBVBw--.3745S2;
 Sat, 21 Feb 2026 18:03:15 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwD3TevcgplpBk4cAA--.34138S8;
 Sat, 21 Feb 2026 18:03:14 +0800 (CST)
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
Subject: [RFC v4 05/31] hw/arm/smmuv3: Thread SEC_SID through helper APIs
Date: Sat, 21 Feb 2026 18:02:24 +0800
Message-Id: <20260221100250.2976287-6-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3TevcgplpBk4cAA--.34138S8
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWmYzyUAHgABsN
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3XF1UXw1fuFyUuryfWFyUJrb_yoWxJrWrpw
 4DJFn5KryDtasYgFW7J3y8C3W3Xw4fKrn8trn8Ga93C3WUAr1UXr1kG345Ka4Dury8Ca1a
 v3yfWF48uw42yrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Extend the register and queue helper routines to accept an explicit
SEC_SID argument instead of hard-coding the non-secure bank.

All existing callers are updated to pass SMMU_SEC_SID_NS, so the
behavior remains identical. This prepares the code for handling
additional security state banks in the future. So Non-secure state
is the only state bank supported for now.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/qemu-devel/3097d58e-3793-4434-8beb-2e4f4c52f772@redhat.com/
---
 hw/arm/smmuv3-accel.c    |  3 ++-
 hw/arm/smmuv3-internal.h | 21 +++++++++------------
 hw/arm/smmuv3.c          | 15 ++++++++-------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 30d4b38c0a3..fdcb15005ea 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -243,6 +243,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
     SMMUS1Hwpt *s1_hwpt = NULL;
     const char *type;
     STE ste;
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
 
     if (!accel || !accel->viommu) {
         return true;
@@ -272,7 +273,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
      * attach/alloc fails, since the Guest–Host SID mapping stays
      * valid as long as the device is behind the accelerated SMMUv3.
      */
-    if (!smmu_enabled(s)) {
+    if (!smmu_enabled(s, sec_sid)) {
         hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
     } else {
         config = STE_CONFIG(&ste);
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index deb1ef60e87..866d62257e3 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -39,9 +39,8 @@ typedef enum SMMUTranslationClass {
     SMMU_CLASS_IN,
 } SMMUTranslationClass;
 
-static inline int smmu_enabled(SMMUv3State *s)
+static inline int smmu_enabled(SMMUv3State *s, SMMUSecSID sec_sid)
 {
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     return FIELD_EX32(bank->cr[0], CR0, SMMUEN);
 }
@@ -69,16 +68,16 @@ static inline uint32_t smmuv3_idreg(int regoffset)
     return smmuv3_ids[regoffset / 4];
 }
 
-static inline bool smmuv3_eventq_irq_enabled(SMMUv3State *s)
+static inline bool smmuv3_eventq_irq_enabled(SMMUv3State *s,
+                                             SMMUSecSID sec_sid)
 {
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     return FIELD_EX32(bank->irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
 }
 
-static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s)
+static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s,
+                                             SMMUSecSID sec_sid)
 {
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     return FIELD_EX32(bank->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
 }
@@ -123,23 +122,21 @@ static inline void queue_cons_incr(SMMUQueue *q)
     q->cons = deposit32(q->cons, 0, q->log2size + 1, q->cons + 1);
 }
 
-static inline bool smmuv3_cmdq_enabled(SMMUv3State *s)
+static inline bool smmuv3_cmdq_enabled(SMMUv3State *s, SMMUSecSID sec_sid)
 {
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     return FIELD_EX32(bank->cr[0], CR0, CMDQEN);
 }
 
-static inline bool smmuv3_eventq_enabled(SMMUv3State *s)
+static inline bool smmuv3_eventq_enabled(SMMUv3State *s, SMMUSecSID sec_sid)
 {
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     return FIELD_EX32(bank->cr[0], CR0, EVENTQEN);
 }
 
-static inline void smmu_write_cmdq_err(SMMUv3State *s, uint32_t err_type)
+static inline void smmu_write_cmdq_err(SMMUv3State *s, uint32_t err_type,
+                                       SMMUSecSID sec_sid)
 {
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     bank->cmdq.cons = FIELD_DP32(bank->cmdq.cons, CMDQ_CONS, ERR, err_type);
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5511585601d..2c107724e77 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -59,7 +59,7 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
 
     switch (irq) {
     case SMMU_IRQ_EVTQ:
-        pulse = smmuv3_eventq_irq_enabled(s);
+        pulse = smmuv3_eventq_irq_enabled(s, sec_sid);
         break;
     case SMMU_IRQ_PRIQ:
         qemu_log_mask(LOG_UNIMP, "PRI not yet supported\n");
@@ -79,7 +79,7 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
         bank->gerror ^= new_gerrors;
         trace_smmuv3_write_gerror(new_gerrors, bank->gerror);
 
-        pulse = smmuv3_gerror_irq_enabled(s);
+        pulse = smmuv3_gerror_irq_enabled(s, sec_sid);
         break;
     }
     }
@@ -155,7 +155,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
     SMMUQueue *q = &bank->eventq;
     MemTxResult r;
 
-    if (!smmuv3_eventq_enabled(s)) {
+    if (!smmuv3_eventq_enabled(s, sec_sid)) {
         return MEMTX_ERROR;
     }
 
@@ -178,8 +178,9 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
 {
     Evt evt = {};
     MemTxResult r;
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
 
-    if (!smmuv3_eventq_enabled(s)) {
+    if (!smmuv3_eventq_enabled(s, sec_sid)) {
         return;
     }
 
@@ -1087,7 +1088,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
 
     qemu_mutex_lock(&s->mutex);
 
-    if (!smmu_enabled(s)) {
+    if (!smmu_enabled(s, sec_sid)) {
         if (FIELD_EX32(bank->gbpa, GBPA, ABORT)) {
             status = SMMU_TRANS_ABORT;
         } else {
@@ -1317,7 +1318,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
     SMMUQueue *q = &bank->cmdq;
     SMMUCommandType type = 0;
 
-    if (!smmuv3_cmdq_enabled(s)) {
+    if (!smmuv3_cmdq_enabled(s, sec_sid)) {
         return 0;
     }
     /*
@@ -1568,7 +1569,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
 
     if (cmd_error) {
         trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
-        smmu_write_cmdq_err(s, cmd_error);
+        smmu_write_cmdq_err(s, cmd_error, sec_sid);
         smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
     }
 
-- 
2.34.1


