Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF489C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYF9-0001Bo-KE; Thu, 13 Aug 2026 12:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYF6-0000zy-Os; Thu, 13 Aug 2026 12:25:20 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYF4-0000zn-SD; Thu, 13 Aug 2026 12:25:20 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwA3Pvbs731qvVDmAA--.4962S2;
 Fri, 14 Aug 2026 00:25:16 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwBnPo731q5SwjAA--.54277S5;
 Fri, 14 Aug 2026 00:25:15 +0800 (CST)
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
Subject: [RFC v5 13/28] hw/arm/smmuv3: Pass sec_sid into cmdq consume path
Date: Fri, 14 Aug 2026 00:25:10 +0800
Message-Id: <20260813162512.2807281-3-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwBnPo731q5SwjAA--.54277S5
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWp8yc0HnwABsJ
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxtFW3uF15KrWDAFW8XFyUGFg_yoWxXFyxpr
 WDJ3sI9r18X3Z3ZF9Fv3y8ur13J34DtFy3tr1UW3Wfu3WDAr15Xrs8Kr1ru34DGryxAws3
 XayfWan8Z3W2y37anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Make smmuv3_cmdq_consume() security-state aware by passing sec_sid
from smmu_writel() call sites (CR0/GERRORN/CMDQ_PROD paths), instead
of hardcoding non-secure state. The related AddressSpace and MemTxAttrs
are also obtained based on sec_sid.

Also move CMD_SSEC legality checking to a single early check before
command dispatch: secure commands are rejected on non-secure queues
(including future Realm queue) with CERROR_ILL. This removes duplicated
per-command checks in CFGI handlers.

Finally, extend cmdq trace output with sec_sid so command processing
can be correlated with the correct security bank.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/smmuv3.c     | 47 +++++++++++++++++++++------------------------
 hw/arm/trace-events |  2 +-
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 087112ba4b6..fa13191fc3b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -112,14 +112,14 @@ static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
     trace_smmuv3_write_gerrorn(toggled & pending, bank->gerrorn);
 }
 
-static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
+static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd,
+                                     AddressSpace *as, MemTxAttrs attrs)
 {
     dma_addr_t addr = Q_CONS_ENTRY(q);
     MemTxResult ret;
     int i;
 
-    ret = dma_memory_read(&address_space_memory, addr, cmd, sizeof(Cmd),
-                          MEMTXATTRS_UNSPECIFIED);
+    ret = dma_memory_read(as, addr, cmd, sizeof(Cmd), attrs);
     if (ret != MEMTX_OK) {
         return ret;
     }
@@ -1391,14 +1391,15 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
     }
 }
 
-static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
+static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
 {
     SMMUState *bs = ARM_SMMU(s);
     SMMUCmdError cmd_error = SMMU_CERROR_NONE;
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
     SMMUQueue *q = &bank->cmdq;
     SMMUCommandType type = 0;
+    MemTxAttrs attrs = smmu_get_txattrs(sec_sid);
+    AddressSpace *as = smmu_get_address_space(bs, sec_sid);
 
     if (!smmuv3_cmdq_enabled(s, sec_sid)) {
         return 0;
@@ -1413,19 +1414,30 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
     while (!smmuv3_q_empty(q)) {
         uint32_t pending = bank->gerror ^ bank->gerrorn;
         Cmd cmd;
+        SMMUSecSID ssec = SMMU_SEC_SID_NS;
 
-        trace_smmuv3_cmdq_consume(Q_PROD(q), Q_CONS(q),
+        trace_smmuv3_cmdq_consume(sec_sid, Q_PROD(q), Q_CONS(q),
                                   Q_PROD_WRAP(q), Q_CONS_WRAP(q));
 
         if (FIELD_EX32(pending, GERROR, CMDQ_ERR)) {
             break;
         }
 
-        if (queue_read(q, &cmd) != MEMTX_OK) {
+        if (queue_read(q, &cmd, as, attrs) != MEMTX_OK) {
             cmd_error = SMMU_CERROR_ABT;
             break;
         }
 
+        ssec = CMD_SSEC(&cmd) ? SMMU_SEC_SID_S : SMMU_SEC_SID_NS;
+        /*
+         * A command with SSec == 1 is illegal on Non-secure and Realm Command
+         * queues and raises CERROR_ILL, as specified by (IHI 0070G.b) 4.1.6.
+         */
+        if (ssec && sec_sid != SMMU_SEC_SID_S) {
+            cmd_error = SMMU_CERROR_ILL;
+            break;
+        }
+
         type = CMD_TYPE(&cmd);
 
         trace_smmuv3_cmdq_opcode(smmu_cmd_string(type));
@@ -1445,11 +1457,6 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             uint32_t sid = CMD_SID(&cmd);
             SMMUDevice *sdev = smmu_find_sdev(bs, sid);
 
-            if (CMD_SSEC(&cmd)) {
-                cmd_error = SMMU_CERROR_ILL;
-                break;
-            }
-
             if (!sdev) {
                 break;
             }
@@ -1469,11 +1476,6 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             uint8_t range = CMD_STE_RANGE(&cmd);
             SMMUSIDRange sid_range;
 
-            if (CMD_SSEC(&cmd)) {
-                cmd_error = SMMU_CERROR_ILL;
-                break;
-            }
-
             mask = (1ULL << (range + 1)) - 1;
             sid_range.start = sid & ~mask;
             sid_range.end = sid_range.start + mask;
@@ -1492,11 +1494,6 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             uint32_t sid = CMD_SID(&cmd);
             SMMUDevice *sdev = smmu_find_sdev(bs, sid);
 
-            if (CMD_SSEC(&cmd)) {
-                cmd_error = SMMU_CERROR_ILL;
-                break;
-            }
-
             if (!sdev) {
                 break;
             }
@@ -1720,7 +1717,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         bank->cr[0] = data;
         bank->cr0ack = data & ~SMMU_CR0_RESERVED;
         /* in case the command queue has been enabled */
-        smmuv3_cmdq_consume(s, &local_err);
+        smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
         if (local_err) {
             error_report_err(local_err);
             local_err = NULL;
@@ -1743,7 +1740,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
          * By acknowledging the CMDQ_ERR, SW may notify cmds can
          * be processed again
          */
-        smmuv3_cmdq_consume(s, &local_err);
+        smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
         break;
     case A_GERROR_IRQ_CFG0: /* 64b */
         bank->gerror_irq_cfg0 = deposit64(bank->gerror_irq_cfg0, 0, 32, data);
@@ -1801,7 +1798,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         break;
     case A_CMDQ_PROD:
         bank->cmdq.prod = data;
-        smmuv3_cmdq_consume(s, &local_err);
+        smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
         break;
     case A_CMDQ_CONS:
         bank->cmdq.cons = data;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 6a8716e8041..ccc0ab50164 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -36,7 +36,7 @@ smmuv3_trigger_irq(int irq) "irq=%d"
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


