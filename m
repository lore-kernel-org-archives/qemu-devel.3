Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36396C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMkv-0001SO-TR; Mon, 14 Jul 2025 13:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLdD-0005di-UF; Mon, 14 Jul 2025 12:02:20 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubLdC-0008RE-1E; Mon, 14 Jul 2025 12:02:19 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgn6s60dbz6L5Mj;
 Mon, 14 Jul 2025 23:58:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 301ED14044F;
 Tue, 15 Jul 2025 00:02:13 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 18:02:04 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: [RFC PATCH v3 13/15] hw/arm/smmuv3: Forward invalidation commands to
 hw
Date: Mon, 14 Jul 2025 16:59:39 +0100
Message-ID: <20250714155941.22176-14-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
invalidation commands to host SMMUv3.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/smmuv3-internal.h | 11 +++++++++++
 hw/arm/smmuv3.c          | 28 ++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 8cb6a9238a..f3aeaf6375 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -233,6 +233,17 @@ static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s)
 #define Q_CONS_WRAP(q) (((q)->cons & WRAP_MASK(q)) >> (q)->log2size)
 #define Q_PROD_WRAP(q) (((q)->prod & WRAP_MASK(q)) >> (q)->log2size)
 
+static inline int smmuv3_q_ncmds(SMMUQueue *q)
+{
+    uint32_t prod = Q_PROD(q);
+    uint32_t cons = Q_CONS(q);
+
+    if (Q_PROD_WRAP(q) == Q_CONS_WRAP(q))
+        return prod - cons;
+    else
+        return WRAP_MASK(q) - cons + prod;
+}
+
 static inline bool smmuv3_q_full(SMMUQueue *q)
 {
     return ((q->cons ^ q->prod) & WRAP_INDEX_MASK(q)) == WRAP_MASK(q);
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c94bfe6564..97ecca0764 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1285,10 +1285,17 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
     SMMUCmdError cmd_error = SMMU_CERROR_NONE;
     SMMUQueue *q = &s->cmdq;
     SMMUCommandType type = 0;
+    SMMUCommandBatch batch = {};
+    uint32_t ncmds;
 
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
@@ -1383,6 +1390,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
 
             trace_smmuv3_cmdq_cfgi_cd(sid);
             smmuv3_flush_config(sdev);
+            smmuv3_accel_batch_cmd(sdev->smmu, sdev, &batch, &cmd, &q->cons);
             break;
         }
         case SMMU_CMD_TLBI_NH_ASID:
@@ -1406,6 +1414,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
+            smmuv3_accel_batch_cmd(bs, NULL, &batch, &cmd, &q->cons);
             break;
         }
         case SMMU_CMD_TLBI_NH_ALL:
@@ -1433,6 +1442,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             trace_smmuv3_cmdq_tlbi_nsnh();
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_all(bs);
+            smmuv3_accel_batch_cmd(bs, NULL, &batch, &cmd, &q->cons);
             break;
         case SMMU_CMD_TLBI_NH_VAA:
         case SMMU_CMD_TLBI_NH_VA:
@@ -1441,6 +1451,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
                 break;
             }
             smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
+            smmuv3_accel_batch_cmd(bs, NULL, &batch, &cmd, &q->cons);
             break;
         case SMMU_CMD_TLBI_S12_VMALL:
         {
@@ -1499,12 +1510,29 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         queue_cons_incr(q);
     }
 
+    qemu_mutex_lock(&s->mutex);
+    if (!cmd_error && batch.ncmds) {
+        if (!smmuv3_accel_issue_cmd_batch(bs, &batch)) {
+            if (batch.ncmds) {
+                q->cons = batch.cons[batch.ncmds - 1];
+            } else {
+                q->cons = batch.cons[0]; /* FIXME: Check */
+            }
+            qemu_log_mask(LOG_GUEST_ERROR, "Illegal command type: %d\n",
+                          CMD_TYPE(&batch.cmds[batch.ncmds]));
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
     trace_smmuv3_cmdq_consume_out(Q_PROD(q), Q_CONS(q),
                                   Q_PROD_WRAP(q), Q_CONS_WRAP(q));
 
-- 
2.34.1


