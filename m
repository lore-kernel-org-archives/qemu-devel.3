Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021EFCCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 15:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xmQ-0002RJ-Ae; Sun, 12 Oct 2025 11:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xmG-0002MQ-Tz; Sun, 12 Oct 2025 11:14:32 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xmE-0002X9-Rs; Sun, 12 Oct 2025 11:14:28 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwD31yTPxeto+SorAA--.35253S2;
 Sun, 12 Oct 2025 23:14:23 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwD3WefOxetoWXhMAA--.2266S3;
 Sun, 12 Oct 2025 23:14:23 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 17/21] hw/arm/smmuv3: Pass security state to command queue
 and IRQ logic
Date: Sun, 12 Oct 2025 23:14:20 +0800
Message-Id: <20251012151420.4130577-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3WefOxetoWXhMAA--.2266S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBcgAAsD
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3GF13AF45XF1ktF1DtF45Awb_yoWfur4Upr
 4UK3sxWr1rt3Z3XF9rA3y8uF13J348tr9xtrWjga4fCas8Ar15Xr4vg3WY934DWryxZws3
 ZayfGrs8Z3W7Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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

The command queue and interrupt logic must operate within the correct
security context. Handling a command queue in one security state can
have side effects, such as interrupts or errors, that need to be
processed in another. This requires the IRQ and GERROR logic to be
fully aware of the multi-security-state environment.

This patch refactors the command queue processing and interrupt handling
to be security-state aware. Besides, unlike the command queue, the
event queue logic was already updated to be security-state aware in a
previous change. The SMMUSecSID is now passed through the relevant
functions to ensure that:

- Command queue operations are performed on the correct register bank.

- Interrupts are triggered and checked against the correct security
state's configuration.

- Errors from command processing are reported in the correct GERROR
register bank.

- Architectural access controls, like preventing secure commands from a
non-secure queue, are correctly enforced.

- As Secure Stage 2 is not yet implemented, commands that target it
are now correctly aborted during command queue processing.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c     | 61 +++++++++++++++++++++++++++++++--------------
 hw/arm/trace-events |  2 +-
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 432de88610..4ac7a2f3c7 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -46,11 +46,11 @@
  *
  * @irq: irq type
  * @gerror_mask: mask of gerrors to toggle (relevant if @irq is GERROR)
+ * @sec_sid: SEC_SID of the bank
  */
 static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
-                               uint32_t gerror_mask)
+                               uint32_t gerror_mask, SMMUSecSID sec_sid)
 {
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
 
     bool pulse = false;
@@ -87,9 +87,9 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
     }
 }
 
-static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
+static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn,
+                                 SMMUSecSID sec_sid)
 {
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     uint32_t pending = bank->gerror ^ bank->gerrorn;
     uint32_t toggled = bank->gerrorn ^ new_gerrorn;
@@ -109,7 +109,7 @@ static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
     trace_smmuv3_write_gerrorn(toggled & pending, bank->gerrorn);
 }
 
-static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
+static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd, SMMUSecSID sec_sid)
 {
     dma_addr_t addr = Q_CONS_ENTRY(q);
     MemTxResult ret;
@@ -167,7 +167,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
     }
 
     if (!smmuv3_q_empty(q)) {
-        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0);
+        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0, sec_sid);
     }
     return MEMTX_OK;
 }
@@ -263,7 +263,8 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
                               info->sid);
     r = smmuv3_write_eventq(s, sec_sid, &evt);
     if (r != MEMTX_OK) {
-        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
+        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR,
+                           R_GERROR_EVENTQ_ABT_ERR_MASK, sec_sid);
     }
     info->recorded = true;
 }
@@ -1457,11 +1458,10 @@ static bool smmu_eventq_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
     return smmu_irq_ctl_evtq_irqen_disabled(s, sec_sid);
 }
 
-static int smmuv3_cmdq_consume(SMMUv3State *s)
+static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecSID sec_sid)
 {
     SMMUState *bs = ARM_SMMU(s);
     SMMUCmdError cmd_error = SMMU_CERROR_NONE;
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     SMMUQueue *q = &bank->cmdq;
     SMMUCommandType type = 0;
@@ -1480,14 +1480,14 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         uint32_t pending = bank->gerror ^ bank->gerrorn;
         Cmd cmd;
 
-        trace_smmuv3_cmdq_consume(Q_PROD(q), Q_CONS(q),
+        trace_smmuv3_cmdq_consume(sec_sid, Q_PROD(q), Q_CONS(q),
                                   Q_PROD_WRAP(q), Q_CONS_WRAP(q));
 
         if (FIELD_EX32(pending, GERROR, CMDQ_ERR)) {
             break;
         }
 
-        if (queue_read(q, &cmd) != MEMTX_OK) {
+        if (queue_read(q, &cmd, sec_sid) != MEMTX_OK) {
             cmd_error = SMMU_CERROR_ABT;
             break;
         }
@@ -1500,7 +1500,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         switch (type) {
         case SMMU_CMD_SYNC:
             if (CMD_SYNC_CS(&cmd) & CMD_SYNC_SIG_IRQ) {
-                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0);
+                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0, sec_sid);
             }
             break;
         case SMMU_CMD_PREFETCH_CONFIG:
@@ -1512,6 +1512,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             SMMUDevice *sdev = smmu_find_sdev(bs, sid);
 
             if (CMD_SSEC(&cmd)) {
+                if (sec_sid != SMMU_SEC_SID_S) {
+                    /* Secure Stream with Non-Secure command */
+                    cmd_error = SMMU_CERROR_ILL;
+                    break;
+                }
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
@@ -1532,6 +1537,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             SMMUSIDRange sid_range;
 
             if (CMD_SSEC(&cmd)) {
+                if (sec_sid != SMMU_SEC_SID_S) {
+                    cmd_error = SMMU_CERROR_ILL;
+                    break;
+                }
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
@@ -1551,6 +1560,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             SMMUDevice *sdev = smmu_find_sdev(bs, sid);
 
             if (CMD_SSEC(&cmd)) {
+                if (sec_sid != SMMU_SEC_SID_S) {
+                    cmd_error = SMMU_CERROR_ILL;
+                    break;
+                }
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
@@ -1618,7 +1631,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, SMMU_SEC_SID_NS);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, sec_sid);
             break;
         case SMMU_CMD_TLBI_S12_VMALL:
         {
@@ -1628,6 +1641,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
+            /* Secure Stage 2 isn't supported for now */
+            if (sec_sid != SMMU_SEC_SID_NS) {
+                cmd_error = SMMU_CERROR_ABT;
+                break;
+            }
 
             trace_smmuv3_cmdq_tlbi_s12_vmid(vmid);
             smmu_inv_notifiers_all(&s->smmu_state);
@@ -1639,11 +1657,16 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
+
+            if (sec_sid != SMMU_SEC_SID_NS) {
+                cmd_error = SMMU_CERROR_ABT;
+                break;
+            }
             /*
              * As currently only either s1 or s2 are supported
              * we can reuse same function for s2.
              */
-            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, SMMU_SEC_SID_NS);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, sec_sid);
             break;
         case SMMU_CMD_TLBI_EL3_ALL:
         case SMMU_CMD_TLBI_EL3_VA:
@@ -1680,7 +1703,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
     if (cmd_error) {
         trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
         smmu_write_cmdq_err(s, cmd_error, sec_sid);
-        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
+        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK, sec_sid);
     }
 
     trace_smmuv3_cmdq_consume_out(Q_PROD(q), Q_CONS(q),
@@ -1772,7 +1795,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         bank->cr[0] = data;
         bank->cr0ack = data & ~SMMU_CR0_RESERVED;
         /* in case the command queue has been enabled */
-        smmuv3_cmdq_consume(s);
+        smmuv3_cmdq_consume(s, reg_sec_sid);
         return MEMTX_OK;
     case A_CR1:
         bank->cr[1] = data;
@@ -1792,12 +1815,12 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         bank->irq_ctrl = data;
         return MEMTX_OK;
     case A_GERRORN:
-        smmuv3_write_gerrorn(s, data);
+        smmuv3_write_gerrorn(s, data, reg_sec_sid);
         /*
          * By acknowledging the CMDQ_ERR, SW may notify cmds can
          * be processed again
          */
-        smmuv3_cmdq_consume(s);
+        smmuv3_cmdq_consume(s, reg_sec_sid);
         return MEMTX_OK;
     case A_GERROR_IRQ_CFG0: /* 64b */
         if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
@@ -1899,7 +1922,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         return MEMTX_OK;
     case A_CMDQ_PROD:
         bank->cmdq.prod = data;
-        smmuv3_cmdq_consume(s);
+        smmuv3_cmdq_consume(s, reg_sec_sid);
         return MEMTX_OK;
     case A_CMDQ_CONS:
         if (!smmu_cmdqen_disabled(s, reg_sec_sid)) {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 0e7ad8fee3..697e0d84f3 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -35,7 +35,7 @@ smmuv3_trigger_irq(int irq) "irq=%d"
 smmuv3_write_gerror(uint32_t toggled, uint32_t gerror) "toggled=0x%x, new GERROR=0x%x"
 smmuv3_write_gerrorn(uint32_t acked, uint32_t gerrorn) "acked=0x%x, new GERRORN=0x%x"
 smmuv3_unhandled_cmd(uint32_t type) "Unhandled command type=%d"
-smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
+smmuv3_cmdq_consume(int sec_sid, uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "sec_sid=%d prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
 smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
 smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
 smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"
-- 
2.34.1


