Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BDFCC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGyWG-0006uB-Qi; Wed, 14 Oct 2026 08:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu7F-0006Sa-FS; Wed, 14 Oct 2026 04:13:37 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu7D-00015Z-Jj; Wed, 14 Oct 2026 04:13:37 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4P99024Wz8Xrrc;
 Wed, 14 Oct 2026 16:13:33 +0800 (CST)
Received: (from root@localhost) by mse-fl2.zte.com.cn id 69E8DUrV005788;
 Wed, 14 Oct 2026 16:13:30 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Message-Id: <202610140813.69E8DUrV005788@mse-fl2.zte.com.cn>
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl1.zte.com.cn with SMTP id 69E80N3K093763;
 Wed, 14 Oct 2026 16:00:23 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Wed, 14 Oct 2026 16:00:25 +0800
X-Zmail-TransId: 3e816acf3699024-0e2d0
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
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH 12/14] hw/riscv/riscv-iommu-accel: Add support to issue
 invalidation cmd to host
Date: Wed, 14 Oct 2026 16:00:03 +0800
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
References: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69E8DUrV005788
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 14 Oct 2026 16:13:33 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ACF39AC.000/4j4P99024Wz8Xrrc
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Oct 2026 08:55:01 -0400
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
index 9846374468..1bfdad8dcb 100644
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
index 55cabc4f45..baec21390c 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2098,6 +2098,9 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
             }
 
             riscv_iommu_iot_inval(s, func, gscid, pscid, iova, transtag);
+            if (!riscv_iommu_accel_issue_inv_cmd(s, &cmd)) {
+                goto cmd_ill;
+            }
             break;
         }
 
-- 
2.53.0


