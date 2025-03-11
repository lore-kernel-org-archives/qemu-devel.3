Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0440C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts0NI-0000vy-9E; Tue, 11 Mar 2025 10:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0NE-0000Ze-Le; Tue, 11 Mar 2025 10:14:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0NC-0007DF-Gy; Tue, 11 Mar 2025 10:14:24 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBwcs0dtrz6FGXG;
 Tue, 11 Mar 2025 22:09:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id A058F14038F;
 Tue, 11 Mar 2025 22:14:14 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 15:14:07 +0100
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [RFC PATCH v2 15/20] hw/arm/smmuv3: Forward invalidation commands to
 hw
Date: Tue, 11 Mar 2025 14:10:40 +0000
Message-ID: <20250311141045.66620-16-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nicolin Chen <nicolinc@nvidia.com>

Use the provided smmuv3-accel helper functions to issue the
command to physical SMMUv3.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3-internal.h | 11 ++++++++
 hw/arm/smmuv3.c          | 58 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 4602ae6728..546f8faac0 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -235,6 +235,17 @@ static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s)
 #define Q_CONS_WRAP(q) (((q)->cons & WRAP_MASK(q)) >> (q)->log2size)
 #define Q_PROD_WRAP(q) (((q)->prod & WRAP_MASK(q)) >> (q)->log2size)
 
+static inline int smmuv3_q_ncmds(SMMUQueue *q)
+{
+        uint32_t prod = Q_PROD(q);
+        uint32_t cons = Q_CONS(q);
+
+        if (Q_PROD_WRAP(q) == Q_CONS_WRAP(q))
+                return prod - cons;
+        else
+                return WRAP_MASK(q) - cons + prod;
+}
+
 static inline bool smmuv3_q_full(SMMUQueue *q)
 {
     return ((q->cons ^ q->prod) & WRAP_INDEX_MASK(q)) == WRAP_MASK(q);
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 83159db1d4..e0f225d0df 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1297,10 +1297,18 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
     SMMUCmdError cmd_error = SMMU_CERROR_NONE;
     SMMUQueue *q = &s->cmdq;
     SMMUCommandType type = 0;
+    SMMUCommandBatch batch = {};
+    uint32_t ncmds = 0;
+
 
     if (!smmuv3_cmdq_enabled(s)) {
         return 0;
     }
+
+    ncmds = smmuv3_q_ncmds(q);
+    batch.cmds = g_new0(Cmd, ncmds);
+    batch.cons = g_new0(uint32_t, ncmds);
+
     /*
      * some commands depend on register values, typically CR0. In case those
      * register values change while handling the command, spec says it
@@ -1395,6 +1403,13 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
 
             trace_smmuv3_cmdq_cfgi_cd(sid);
             smmuv3_flush_config(sdev);
+
+            if (smmuv3_accel_batch_cmds(sdev->smmu, sdev, &batch, &cmd,
+                                        &q->cons, true)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+
             break;
         }
         case SMMU_CMD_TLBI_NH_ASID:
@@ -1418,6 +1433,13 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
+
+            if (smmuv3_accel_batch_cmds(bs, NULL, &batch, &cmd, &q->cons,
+                                        false)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+
             break;
         }
         case SMMU_CMD_TLBI_NH_ALL:
@@ -1445,6 +1467,12 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             trace_smmuv3_cmdq_tlbi_nsnh();
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_all(bs);
+
+            if (smmuv3_accel_batch_cmds(bs, NULL, &batch, &cmd, &q->cons,
+                                        false)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         case SMMU_CMD_TLBI_NH_VAA:
         case SMMU_CMD_TLBI_NH_VA:
@@ -1453,7 +1481,24 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
                 break;
             }
             smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
+
+            if (smmuv3_accel_batch_cmds(bs, NULL, &batch, &cmd, &q->cons,
+                                        false)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+            break;
+        case SMMU_CMD_ATC_INV:
+        {
+            SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
+
+            if (smmuv3_accel_batch_cmds(sdev->smmu, sdev, &batch, &cmd,
+                                        &q->cons, true)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
+        }
         case SMMU_CMD_TLBI_S12_VMALL:
         {
             int vmid = CMD_VMID(&cmd);
@@ -1485,7 +1530,6 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         case SMMU_CMD_TLBI_EL2_ASID:
         case SMMU_CMD_TLBI_EL2_VA:
         case SMMU_CMD_TLBI_EL2_VAA:
-        case SMMU_CMD_ATC_INV:
         case SMMU_CMD_PRI_RESP:
         case SMMU_CMD_RESUME:
         case SMMU_CMD_STALL_TERM:
@@ -1511,12 +1555,24 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         queue_cons_incr(q);
     }
 
+    qemu_mutex_lock(&s->mutex);
+    if (!cmd_error && batch.ncmds) {
+        if (smmuv3_accel_issue_cmd_batch(bs, &batch)) {
+            q->cons = batch.cons[batch.ncmds];
+            cmd_error = SMMU_CERROR_ILL;
+        }
+    }
+    qemu_mutex_unlock(&s->mutex);
+
     if (cmd_error) {
         trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
         smmu_write_cmdq_err(s, cmd_error);
         smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
     }
 
+    g_free(batch.cmds);
+    g_free(batch.cons);
+
     trace_smmuv3_cmdq_consume_out(Q_PROD(q), Q_CONS(q),
                                   Q_PROD_WRAP(q), Q_CONS_WRAP(q));
 
-- 
2.34.1


