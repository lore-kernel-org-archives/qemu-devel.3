Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E34606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJ14-0007zb-0e; Thu, 29 Oct 2026 01:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xMIzl-00073G-Sh; Thu, 29 Oct 2026 01:48:14 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xMIzi-0000eq-Jj; Thu, 29 Oct 2026 01:48:13 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFYDS2TPqz8Xrrs;
 Thu, 29 Oct 2026 13:48:08 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl2.zte.com.cn with SMTP id 69T5lw1L024181;
 Thu, 29 Oct 2026 13:47:58 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Thu, 29 Oct 2026 13:47:59 +0800
X-Zmail-TransId: 3e816ae2de0f027-e63cc
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Wu Fei <wu.fei9@sanechips.com.cn>,
 Qingye Zhao <zhao.qingye@sanechips.com.cn>,
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH v2 12/14] hw/riscv/riscv-iommu-accel: Add support to issue
 invalidation cmd to host
Date: Thu, 29 Oct 2026 13:47:49 +0800
Message-ID: <20261029054751.563493-13-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029054751.563493-1-gong.shuai@sanechips.com.cn>
References: <20261029054751.563493-1-gong.shuai@sanechips.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69T5lw1L024181
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 29 Oct 2026 13:48:08 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2DE18.000/4jFYDS2TPqz8Xrrs
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxhk.zte.com.cn
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

From: Wu Fei <wu.fei9@sanechips.com.cn>

Provide a helper to forward guest IOTLB invalidations to the host
RISC-V IOMMU, and use it in the IOTINVAL command path so the
accelerated translation caches stay in sync with the guest. Only
one command is issued at a time for now.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 hw/riscv/riscv-iommu-accel.c | 44 ++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu-accel.h |  8 +++++++
 hw/riscv/riscv-iommu.c       |  3 +++
 3 files changed, 55 insertions(+)

diff --git a/hw/riscv/riscv-iommu-accel.c b/hw/riscv/riscv-iommu-accel.c
index f6cb2f77df..41de003f62 100644
--- a/hw/riscv/riscv-iommu-accel.c
+++ b/hw/riscv/riscv-iommu-accel.c
@@ -5,6 +5,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "qemu/error-report.h"
 #include "trace.h"
 
@@ -161,6 +162,49 @@ static uint32_t riscv_iommu_accel_ddtp_hwpt(RISCVIOMMUState *s,
                accel->abort_hwpt_id : accel->bypass_hwpt_id;
 }
 
+/*
+ * Issue the invalidation command to the host RISC-V IOMMU.
+ *
+ * The RISC-V IOTINVAL command carries no device (like ARM's SID)
+ * information, only (addr, gscid, pscid), so no per-device filtering
+ * is needed here.
+ */
+bool riscv_iommu_accel_issue_inv_cmd(RISCVIOMMUState *s,
+                                     const struct riscv_iommu_command *cmd)
+{
+    RISCVIOMMUAccelState *accel = s->accel_state;
+    struct iommu_viommu_riscv_invalidate inv = {
+        .cmd = { cpu_to_le64(cmd->dword0), cpu_to_le64(cmd->dword1) },
+    };
+    uint32_t entry_num = 1;
+    bool ret;
+    Error *local_err = NULL;
+
+    /* The uAPI entry must stay exactly one hardware command word */
+    QEMU_BUILD_BUG_ON(sizeof(inv) != sizeof(*cmd));
+
+    /*
+     * No accel or viommu means no VFIO/IOMMUFD devices, nothing to
+     * invalidate.
+     */
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    /* Single command (entry_num = 1); no need to check returned entry_num */
+    ret = iommufd_backend_invalidate_cache(accel->viommu->iommufd,
+                                           accel->viommu->viommu_id,
+                                           IOMMU_VIOMMU_INVALIDATE_DATA_RISCV,
+                                           sizeof(inv), &entry_num, &inv,
+                                           &local_err);
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
+
+    return ret;
+}
+
 static bool riscv_iommu_accel_alloc_viommu(RISCVIOMMUState *s,
                                            HostIOMMUDeviceIOMMUFD *idev,
                                            Error **errp)
diff --git a/hw/riscv/riscv-iommu-accel.h b/hw/riscv/riscv-iommu-accel.h
index 85a1ab6d42..55d3c0dc62 100644
--- a/hw/riscv/riscv-iommu-accel.h
+++ b/hw/riscv/riscv-iommu-accel.h
@@ -42,6 +42,8 @@ typedef struct RISCVIOMMUAccelDevice {
 void riscv_iommu_accel_init(RISCVIOMMUState *s);
 bool riscv_iommu_accel_install_dc(RISCVIOMMUState *s, int devid);
 bool riscv_iommu_accel_install_dc_all(RISCVIOMMUState *s);
+bool riscv_iommu_accel_issue_inv_cmd(RISCVIOMMUState *s,
+                                     const struct riscv_iommu_command *cmd);
 #else
 static inline void riscv_iommu_accel_init(RISCVIOMMUState *s)
 {
@@ -56,6 +58,12 @@ riscv_iommu_accel_install_dc_all(RISCVIOMMUState *s)
 {
     return true;
 }
+static inline bool
+riscv_iommu_accel_issue_inv_cmd(RISCVIOMMUState *s,
+                                const struct riscv_iommu_command *cmd)
+{
+    return true;
+}
 #endif
 
 #endif /* HW_RISCV_RISCV_IOMMU_ACCEL_H */
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index fa751d566f..4e92f3b15c 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2091,6 +2091,9 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
             }
 
             riscv_iommu_iot_inval(s, iot_func, gscid, pscid, iova, transtag);
+            if (!riscv_iommu_accel_issue_inv_cmd(s, &cmd)) {
+                goto cmd_ill;
+            }
             break;
         }
 
-- 
2.53.0


