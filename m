Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1F1606A329
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGNn-0008Dz-HG; Sat, 14 Nov 2026 11:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGNk-00085c-5A; Sat, 14 Nov 2026 11:13:36 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSGNi-0000f7-49; Sat, 14 Nov 2026 11:13:35 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwCXnMCriPhqZEgqBg--.55613S2; 
 Sun, 15 Nov 2026 00:13:31 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwWnSqiPhqsdv6AA--.38452S3;
 Sun, 15 Nov 2026 00:13:30 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 03/35] hw/arm/smmuv3: Thread SEC_SID through helper APIs
Date: Sun, 15 Nov 2026 00:13:29 +0800
Message-Id: <20261114161329.3639254-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
References: <20261114154623.3599750-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwWnSqiPhqsdv6AA--.38452S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBYAABsE
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3XrWkurWkAry5XF45ZFWkZwb_yoWxGw4xpw
 4DJ3Z5KryUtFyFgFW7Jw48A3W3Xw4fKFnxJrn8Ga93C3WUAr15Xr1kG345KF9F9ry8Ca1a
 v3ySgF48uw42yrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend the register and queue helper routines to accept an explicit
SEC_SID argument instead of hard-coding the Non-secure bank.

All existing callers are updated to pass SMMU_SEC_SID_NS, so the
behavior remains identical. This prepares the code for handling
additional security state banks in the future. So Non-secure state
is the only state bank supported for now.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/3097d58e-3793-4434-8beb-2e4f4c52f772@redhat.com/
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3-internal.h | 21 +++++++++------------
 hw/arm/smmuv3-accel.c    |  4 ++--
 hw/arm/smmuv3.c          | 15 ++++++++-------
 3 files changed, 19 insertions(+), 21 deletions(-)

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
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 91df3362215..84d6718173c 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -323,7 +323,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
      * attach/alloc fails, since the Guest–Host SID mapping stays
      * valid as long as the device is behind the accelerated SMMUv3.
      */
-    if (!smmu_enabled(s)) {
+    if (!smmu_enabled(s, SMMU_SEC_SID_NS)) {
         hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
     } else {
         config = STE_CONFIG(&ste);
@@ -558,7 +558,7 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
         return true;
     }
 
-    if (!smmuv3_eventq_enabled(s)) {
+    if (!smmuv3_eventq_enabled(s, sec_sid)) {
         return true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 3198fcd9eeb..249ffaee4d4 100644
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
 
@@ -1126,7 +1127,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
 
     qemu_mutex_lock(&s->mutex);
 
-    if (!smmu_enabled(s)) {
+    if (!smmu_enabled(s, sec_sid)) {
         if (FIELD_EX32(bank->gbpa, GBPA, ABORT)) {
             status = SMMU_TRANS_ABORT;
         } else {
@@ -1356,7 +1357,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
     SMMUQueue *q = &bank->cmdq;
     SMMUCommandType type = 0;
 
-    if (!smmuv3_cmdq_enabled(s)) {
+    if (!smmuv3_cmdq_enabled(s, sec_sid)) {
         return 0;
     }
     /*
@@ -1616,7 +1617,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
 
     if (cmd_error) {
         trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
-        smmu_write_cmdq_err(s, cmd_error);
+        smmu_write_cmdq_err(s, cmd_error, sec_sid);
         smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
     }
 
-- 
2.34.1


