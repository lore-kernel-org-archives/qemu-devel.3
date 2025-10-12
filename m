Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98F4CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 15:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xfo-0001l1-5K; Sun, 12 Oct 2025 11:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xfR-0001eM-7R; Sun, 12 Oct 2025 11:07:25 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xfL-0001cu-B0; Sun, 12 Oct 2025 11:07:24 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDn7mIcxOtooU6gAA--.30S2;
 Sun, 12 Oct 2025 23:07:08 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDXPOoXxOto33dMAA--.3068S9;
 Sun, 12 Oct 2025 23:07:07 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 06/21] hw/arm/smmuv3: Thread SEC_SID through helper APIs
Date: Sun, 12 Oct 2025 23:06:46 +0800
Message-Id: <20251012150701.4127034-7-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXPOoXxOto33dMAA--.3068S9
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBXQAAss
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3XrWkurWkAry5XF45ZFWkZwb_yoW7Xry8pw
 4DAFn5KryUKFySgFZrJ3y8C3W3Zw4fKFn8Gr15Ga93G3WUCr1UXrn5G345ta4DWry8Zan2
 v3yfGa1ruw47ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Extend the register and queue helper routines to accept an explicit
SEC_SID argument instead of hard-coding the non-secure bank.

All existing callers are updated to pass SMMU_SEC_SID_NS, so the
behavior remains identical. This prepares the code for handling
additional security state banks in the future. So Non-secure state
is the only state bank supported for now.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3-internal.h | 21 +++++++++------------
 hw/arm/smmuv3.c          | 15 ++++++++-------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 858bc206a2..af0e0b32b3 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -246,9 +246,8 @@ REG64(S_EVENTQ_IRQ_CFG0,    0x80b0)
 REG32(S_EVENTQ_IRQ_CFG1,    0x80b8)
 REG32(S_EVENTQ_IRQ_CFG2,    0x80bc)
 
-static inline int smmu_enabled(SMMUv3State *s)
+static inline int smmu_enabled(SMMUv3State *s, SMMUSecSID sec_sid)
 {
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     return FIELD_EX32(bank->cr[0], CR0, SMMUEN);
 }
@@ -276,16 +275,16 @@ static inline uint32_t smmuv3_idreg(int regoffset)
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
@@ -330,23 +329,21 @@ static inline void queue_cons_incr(SMMUQueue *q)
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
index 9c085ac678..6d05bb1310 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -57,7 +57,7 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
 
     switch (irq) {
     case SMMU_IRQ_EVTQ:
-        pulse = smmuv3_eventq_irq_enabled(s);
+        pulse = smmuv3_eventq_irq_enabled(s, sec_sid);
         break;
     case SMMU_IRQ_PRIQ:
         qemu_log_mask(LOG_UNIMP, "PRI not yet supported\n");
@@ -77,7 +77,7 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
         bank->gerror ^= new_gerrors;
         trace_smmuv3_write_gerror(new_gerrors, bank->gerror);
 
-        pulse = smmuv3_gerror_irq_enabled(s);
+        pulse = smmuv3_gerror_irq_enabled(s, sec_sid);
         break;
     }
     }
@@ -153,7 +153,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
     SMMUQueue *q = &bank->eventq;
     MemTxResult r;
 
-    if (!smmuv3_eventq_enabled(s)) {
+    if (!smmuv3_eventq_enabled(s, sec_sid)) {
         return MEMTX_ERROR;
     }
 
@@ -176,8 +176,9 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
 {
     Evt evt = {};
     MemTxResult r;
+    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
 
-    if (!smmuv3_eventq_enabled(s)) {
+    if (!smmuv3_eventq_enabled(s, sec_sid)) {
         return;
     }
 
@@ -1070,7 +1071,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
 
     qemu_mutex_lock(&s->mutex);
 
-    if (!smmu_enabled(s)) {
+    if (!smmu_enabled(s, sec_sid)) {
         if (FIELD_EX32(bank->gbpa, GBPA, ABORT)) {
             status = SMMU_TRANS_ABORT;
         } else {
@@ -1300,7 +1301,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
     SMMUQueue *q = &bank->cmdq;
     SMMUCommandType type = 0;
 
-    if (!smmuv3_cmdq_enabled(s)) {
+    if (!smmuv3_cmdq_enabled(s, sec_sid)) {
         return 0;
     }
     /*
@@ -1513,7 +1514,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
 
     if (cmd_error) {
         trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
-        smmu_write_cmdq_err(s, cmd_error);
+        smmu_write_cmdq_err(s, cmd_error, sec_sid);
         smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
     }
 
-- 
2.34.1


