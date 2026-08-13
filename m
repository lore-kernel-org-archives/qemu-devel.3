Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0540C5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYEA-0007ui-MI; Thu, 13 Aug 2026 12:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYE9-0007tv-5B; Thu, 13 Aug 2026 12:24:21 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYE7-0000WN-5c; Thu, 13 Aug 2026 12:24:20 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwDHyXWw731q_hpvAw--.20295S2; 
 Fri, 14 Aug 2026 00:24:16 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwjnOq731q3SwjAA--.59176S5;
 Fri, 14 Aug 2026 00:24:14 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v5 03/28] hw/arm/smmuv3: Thread SEC_SID through helper APIs
Date: Fri, 14 Aug 2026 00:24:08 +0800
Message-Id: <20260813162410.2805113-3-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwjnOq731q3SwjAA--.59176S5
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWp8yc0HjgACsb
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3XrWfurW3Gw1UKF4xZr17Awb_yoWxXw47pw
 4DJFn5KryUtF9YgFW7Jw48C3W3Xw4fKFn8Krn8Ga93C3WUAr1UXr1kG345KasF9ry8Ca1a
 v3ySgF48uw47ArJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/3097d58e-3793-4434-8beb-2e4f4c52f772@redhat.com/
---
 hw/arm/smmuv3-accel.c    |  5 +++--
 hw/arm/smmuv3-internal.h | 21 +++++++++------------
 hw/arm/smmuv3.c          | 15 ++++++++-------
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 3ff3da66acd..fa079c8acea 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -294,6 +294,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
     SMMUS1Hwpt *s1_hwpt = NULL;
     const char *type;
     STE ste;
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
 
     if (!accel || !accel->viommu) {
         return true;
@@ -323,7 +324,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
      * attach/alloc fails, since the Guest–Host SID mapping stays
      * valid as long as the device is behind the accelerated SMMUv3.
      */
-    if (!smmu_enabled(s)) {
+    if (!smmu_enabled(s, sec_sid)) {
         hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
     } else {
         config = STE_CONFIG(&ste);
@@ -558,7 +559,7 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
         return true;
     }
 
-    if (!smmuv3_eventq_enabled(s)) {
+    if (!smmuv3_eventq_enabled(s, sec_sid)) {
         return true;
     }
 
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 10154ca161d..a88743ba9cd 100644
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
index d3baae8a32a..51e970d710a 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -60,7 +60,7 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
 
     switch (irq) {
     case SMMU_IRQ_EVTQ:
-        pulse = smmuv3_eventq_irq_enabled(s);
+        pulse = smmuv3_eventq_irq_enabled(s, sec_sid);
         break;
     case SMMU_IRQ_PRIQ:
         qemu_log_mask(LOG_UNIMP, "PRI not yet supported\n");
@@ -80,7 +80,7 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
         bank->gerror ^= new_gerrors;
         trace_smmuv3_write_gerror(new_gerrors, bank->gerror);
 
-        pulse = smmuv3_gerror_irq_enabled(s);
+        pulse = smmuv3_gerror_irq_enabled(s, sec_sid);
         break;
     }
     }
@@ -156,7 +156,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
     SMMUQueue *q = &bank->eventq;
     MemTxResult r;
 
-    if (!smmuv3_eventq_enabled(s)) {
+    if (!smmuv3_eventq_enabled(s, sec_sid)) {
         return MEMTX_ERROR;
     }
 
@@ -191,8 +191,9 @@ void smmuv3_propagate_event(SMMUv3State *s, Evt *evt)
 void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
 {
     Evt evt = {};
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
 
-    if (!smmuv3_eventq_enabled(s)) {
+    if (!smmuv3_eventq_enabled(s, sec_sid)) {
         return;
     }
 
@@ -1127,7 +1128,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
 
     qemu_mutex_lock(&s->mutex);
 
-    if (!smmu_enabled(s)) {
+    if (!smmu_enabled(s, sec_sid)) {
         if (FIELD_EX32(bank->gbpa, GBPA, ABORT)) {
             status = SMMU_TRANS_ABORT;
         } else {
@@ -1357,7 +1358,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
     SMMUQueue *q = &bank->cmdq;
     SMMUCommandType type = 0;
 
-    if (!smmuv3_cmdq_enabled(s)) {
+    if (!smmuv3_cmdq_enabled(s, sec_sid)) {
         return 0;
     }
     /*
@@ -1617,7 +1618,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
 
     if (cmd_error) {
         trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
-        smmu_write_cmdq_err(s, cmd_error);
+        smmu_write_cmdq_err(s, cmd_error, sec_sid);
         smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
     }
 
-- 
2.34.1


