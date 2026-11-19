Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8B606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU1zc-0006du-Ir; Thu, 19 Nov 2026 08:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xU1zW-0006ZP-Ot; Thu, 19 Nov 2026 08:15:54 -0500
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xU1zT-0005nJ-Sm; Thu, 19 Nov 2026 08:15:54 -0500
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jVf9H1xhcz4yjjG;
 Thu, 19 Nov 2026 21:15:47 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl2.zte.com.cn with SMTP id 6AJDFdEf060324;
 Thu, 19 Nov 2026 21:15:39 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Thu, 19 Nov 2026 21:15:43 +0800
X-Zmail-TransId: 3e816afef67e02f-55743
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
 Cornelia Huck <cohuck@redhat.com>, Tan Chi <tanchi25@mails.ucas.ac.cn>,
 Wu Fei <wu.fei9@sanechips.com.cn>,
 Qingye Zhao <zhao.qingye@sanechips.com.cn>,
 Gong Shuai <gong.shuai@sanechips.com.cn>
Subject: [RFC PATCH v3 12/15] hw/riscv/riscv-iommu-accel: Apply the DDTP mode
 to every device
Date: Thu, 19 Nov 2026 21:15:21 +0800
Message-ID: <20261119131524.395861-13-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119131524.395861-1-gong.shuai@sanechips.com.cn>
References: <20261119131524.395861-1-gong.shuai@sanechips.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 6AJDFdEf060324
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 19 Nov 2026 21:15:47 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFEF683.000/4jVf9H1xhcz4yjjG
Received-SPF: pass client-ip=160.30.148.34;
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DDTP mode decides how the IOMMU translates accesses from the
devices behind it. On reset, attach every device to the pre-allocated
abort or bypass HWPT selected by DDTP mode and re-apply the mode on
every accepted DDTP change.

Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 hw/riscv/riscv-iommu-accel.c | 38 ++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu-accel.h |  6 ++++++
 hw/riscv/riscv-iommu.c       | 15 ++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/hw/riscv/riscv-iommu-accel.c b/hw/riscv/riscv-iommu-accel.c
index e203c384a6..47303323c7 100644
--- a/hw/riscv/riscv-iommu-accel.c
+++ b/hw/riscv/riscv-iommu-accel.c
@@ -496,6 +496,44 @@ bool riscv_iommu_accel_install_dc_all(RISCVIOMMUState *s)
     return all_ok;
 }
 
+/*
+ * Attach every accelerated device to the pre-allocated abort/bypass proxy
+ * HWPT selected by the current DDTP mode. All the devices must be re-attached
+ * whenever the DDTP mode is (re)applied.
+ */
+bool riscv_iommu_accel_attach_ddtp_hwpt(RISCVIOMMUState *s, Error **errp)
+{
+    RISCVIOMMUAccelState *accel = s->accel_state;
+    RISCVIOMMUAccelDevice *accel_dev;
+    Error *local_err = NULL;
+    bool all_ok = true;
+    uint32_t hwpt_id;
+
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    hwpt_id = riscv_iommu_accel_ddtp_hwpt(s, accel);
+    QLIST_FOREACH(accel_dev, &accel->device_list, next) {
+        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
+                                                   IOMMU_NO_PASID, hwpt_id,
+                                                   &local_err)) {
+            error_append_hint(&local_err, "Failed to attach DDTP hwpt %u for "
+                              "idev devid 0x%x", hwpt_id,
+                              accel_dev->idev->devid);
+            error_report_err(local_err);
+            local_err = NULL;
+            all_ok = false;
+        }
+    }
+
+    if (!all_ok) {
+        error_setg(errp, "Failed to attach all DDTP based HWPTs properly");
+    }
+
+    return all_ok;
+}
+
 static const PCIIOMMUOps riscv_iommu_accel_ops = {
     .supports_address_space = riscv_iommu_accel_supports_as,
     .get_address_space = riscv_iommu_accel_find_as,
diff --git a/hw/riscv/riscv-iommu-accel.h b/hw/riscv/riscv-iommu-accel.h
index 85a1ab6d42..bf614017e2 100644
--- a/hw/riscv/riscv-iommu-accel.h
+++ b/hw/riscv/riscv-iommu-accel.h
@@ -42,6 +42,7 @@ typedef struct RISCVIOMMUAccelDevice {
 void riscv_iommu_accel_init(RISCVIOMMUState *s);
 bool riscv_iommu_accel_install_dc(RISCVIOMMUState *s, int devid);
 bool riscv_iommu_accel_install_dc_all(RISCVIOMMUState *s);
+bool riscv_iommu_accel_attach_ddtp_hwpt(RISCVIOMMUState *s, Error **errp);
 #else
 static inline void riscv_iommu_accel_init(RISCVIOMMUState *s)
 {
@@ -56,6 +57,11 @@ riscv_iommu_accel_install_dc_all(RISCVIOMMUState *s)
 {
     return true;
 }
+static inline bool
+riscv_iommu_accel_attach_ddtp_hwpt(RISCVIOMMUState *s, Error **errp)
+{
+    return true;
+}
 #endif
 
 #endif /* HW_RISCV_RISCV_IOMMU_ACCEL_H */
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index fa751d566f..7a55b7514b 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1966,6 +1966,16 @@ static void riscv_iommu_process_ddtp(RISCVIOMMUState *s)
     s->ddtp = new_ddtp;
 
     riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_DDTP, new_ddtp);
+
+    /* Apply the new DDTP mode to the accelerated devices */
+    if (s->accel && new_ddtp != old_ddtp) {
+        if (new_mode == RISCV_IOMMU_DDTP_MODE_OFF ||
+            new_mode == RISCV_IOMMU_DDTP_MODE_BARE) {
+            riscv_iommu_accel_attach_ddtp_hwpt(s, NULL);
+        } else {
+            riscv_iommu_accel_install_dc_all(s);
+        }
+    }
 }
 
 /* Command function and opcode field. */
@@ -2894,6 +2904,11 @@ void riscv_iommu_reset(RISCVIOMMUState *s)
     qemu_mutex_lock(&s->iot_lock);
     g_hash_table_remove_all(s->iot_cache);
     qemu_mutex_unlock(&s->iot_lock);
+
+    /* Re-attach every accelerated device based on the reset DDTP mode */
+    if (s->accel) {
+        riscv_iommu_accel_attach_ddtp_hwpt(s, NULL);
+    }
 }
 
 static const Property riscv_iommu_properties[] = {
-- 
2.53.0


