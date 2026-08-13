Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8664C5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYGG-0003fx-Ng; Thu, 13 Aug 2026 12:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYFw-0003Lq-V3; Thu, 13 Aug 2026 12:26:14 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYFs-0001Bo-Qq; Thu, 13 Aug 2026 12:26:11 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwAnL7cd8H1qmlHmAA--.4877S2;
 Fri, 14 Aug 2026 00:26:05 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8Dw4XUX8H1q5iwjAA--.55915S7;
 Fri, 14 Aug 2026 00:26:03 +0800 (CST)
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
Subject: [RFC v5 20/28] hw/arm/smmuv3: Route IRQ and GERROR handling by SEC_SID
Date: Fri, 14 Aug 2026 00:25:58 +0800
Message-Id: <20260813162558.2808607-5-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dw4XUX8H1q5iwjAA--.55915S7
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWp8yc0HqgAAs9
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWFW5JrWfuw1DtrykCF4xXrb_yoW5tFW5pw
 47K3s0gr4rt3Z8XFyrJa9rZ3W7G34ktrn8CrWYgFWfA3W5AryUXrWDu3Wj934Dury7Zw4k
 ZaySgFW5Zr47A3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Interrupt and global error handling currently always selects the
Non-secure register bank, even when the event or command originates
from the Secure programming interface. This splits CMDQ_CONS.ERR from
GERROR.CMDQ_ERR and prevents Secure software from acknowledging the
error through S_GERRORN.

Pass SEC_SID through the IRQ and GERROR helpers and all queue call
sites so interrupt enable checks, global error reporting, and
acknowledgement use the originating programming-interface bank.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b36bc4a54e0..d69fc0898af 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -49,11 +49,11 @@
  *
  * @irq: irq type
  * @gerror_mask: mask of gerrors to toggle (relevant if @irq is GERROR)
+ * @sec_sid: security state of the programming interface
  */
 static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
-                               uint32_t gerror_mask)
+                               uint32_t gerror_mask, SMMUSecSID sec_sid)
 {
-    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
     SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
 
     bool pulse = false;
@@ -90,9 +90,9 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
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
@@ -173,7 +173,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
     }
 
     if (!smmuv3_q_empty(q)) {
-        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0);
+        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0, sec_sid);
     }
     return MEMTX_OK;
 }
@@ -187,7 +187,8 @@ void smmuv3_propagate_event(SMMUv3State *s, Evt *evt, SMMUSecSID sec_sid)
     QEMU_LOCK_GUARD(&s->mutex);
     r = smmuv3_write_eventq(s, sec_sid, evt);
     if (r != MEMTX_OK) {
-        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
+        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR,
+                           R_GERROR_EVENTQ_ABT_ERR_MASK, sec_sid);
     }
 }
 
@@ -1645,7 +1646,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
         switch (type) {
         case SMMU_CMD_SYNC:
             if (CMD_SYNC_CS(&cmd) & CMD_SYNC_SIG_IRQ) {
-                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0);
+                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0, sec_sid);
             }
             break;
         case SMMU_CMD_PREFETCH_CONFIG:
@@ -1879,7 +1880,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
     if (cmd_error) {
         trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
         smmu_write_cmdq_err(s, cmd_error, sec_sid);
-        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
+        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR,
+                           R_GERROR_CMDQ_ERR_MASK, sec_sid);
     }
 
     trace_smmuv3_cmdq_consume_out(Q_PROD(q), Q_CONS(q),
@@ -1996,7 +1998,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         bank->irq_ctrl = data;
         break;
     case A_GERRORN:
-        smmuv3_write_gerrorn(s, data);
+        smmuv3_write_gerrorn(s, data, reg_sec_sid);
         /*
          * By acknowledging the CMDQ_ERR, SW may notify cmds can
          * be processed again
-- 
2.34.1


