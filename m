Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AAE606A33B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 02:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTs7S-0000r1-87; Wed, 18 Nov 2026 21:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xTs7O-0000pX-Fk; Wed, 18 Nov 2026 21:43:22 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xTs7K-0005bs-PU; Wed, 18 Nov 2026 21:43:22 -0500
Received: from k3-03 (unknown [159.226.43.8])
 by APP-01 (Coremail) with SMTP id qwCowAD3Hfg8Yv5qZFtAAQ--.232S3;
 Thu, 19 Nov 2026 10:43:11 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH 1/3] hw/riscv: iommu: Add migration support for common state
Date: Thu, 19 Nov 2026 10:42:48 +0800
Message-ID: <20261119024251.280765-2-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119024251.280765-1-tanchi25@mails.ucas.ac.cn>
References: <20261119024251.280765-1-tanchi25@mails.ucas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAD3Hfg8Yv5qZFtAAQ--.232S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuF43CF4DAF17ArWfWw1Dtrb_yoWrZw13pF
 s5WF4ayr18Jrn3ZanxJw4DCF4Fg3Z5Ww1Y9rW3uws7tF4UtrW3WFs8ta45Ars7GFyxZw12
 va4rWr9xCr1jvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
 8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
 nxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
 CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
 eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
 1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s02
 6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
 I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
 6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
 0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
 JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjMqcUUUUUU==
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=tanchi25@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add VMState support for the common RISC-V IOMMU device to preserve
its register state, device directory configuration, and command,
fault, and page-request queue state across migration.

Save the HPM cycle counter state and overflow timer in a separate
subsection when HPM is enabled. Rebuild the HPM event-to-counter
mapping from the restored event selector registers on the
destination.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---
 hw/riscv/riscv-iommu-hpm.c | 27 +++++++++++++++++++
 hw/riscv/riscv-iommu-hpm.h |  2 ++
 hw/riscv/riscv-iommu.c     | 54 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
index 9bfef6db45..9656fdc839 100644
--- a/hw/riscv/riscv-iommu-hpm.c
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -381,3 +381,30 @@ void riscv_iommu_process_hpmevt_write(RISCVIOMMUState *s, uint32_t evt_reg)
 
     update_event_map(s, val, ctr_idx);
 }
+
+int riscv_iommu_hpm_post_load(void *opaque, int version_id)
+{
+    RISCVIOMMUState *s = opaque;
+    uint64_t evt_val;
+    unsigned int i;
+
+    if (!(s->cap & RISCV_IOMMU_CAP_HPM)) {
+        return 0;
+    }
+
+    g_hash_table_remove_all(s->hpm_event_ctr_map);
+
+    for (i = 0; i < s->hpm_cntrs; i++) {
+        evt_val = riscv_iommu_reg_get64(
+                    s, RISCV_IOMMU_REG_IOHPMEVT_BASE + (i << 3));
+
+        if (!check_valid_event_id(
+                get_field(evt_val, RISCV_IOMMU_IOHPMEVT_EVENT_ID))) {
+            continue;
+        }
+
+        update_event_map(s, evt_val, i);
+    }
+
+    return 0;
+}
diff --git a/hw/riscv/riscv-iommu-hpm.h b/hw/riscv/riscv-iommu-hpm.h
index 5fc4ef2e8b..516974ec87 100644
--- a/hw/riscv/riscv-iommu-hpm.h
+++ b/hw/riscv/riscv-iommu-hpm.h
@@ -30,4 +30,6 @@ void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_inh);
 void riscv_iommu_process_hpmcycle_write(RISCVIOMMUState *s);
 void riscv_iommu_process_hpmevt_write(RISCVIOMMUState *s, uint32_t evt_reg);
 
+int riscv_iommu_hpm_post_load(void *opaque, int version_id);
+
 #endif
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 5b1a388364..7c23e32693 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -3067,6 +3067,59 @@ void riscv_iommu_reset(RISCVIOMMUState *s)
     qemu_mutex_unlock(&s->iot_lock);
 }
 
+static bool riscv_iommu_hpm_state_needed(void *opaque)
+{
+    RISCVIOMMUState *s = opaque;
+
+    return !!(s->cap & RISCV_IOMMU_CAP_HPM);
+}
+
+static const VMStateDescription vmstate_riscv_iommu_hpm = {
+    .name = "riscv-iommu/hpm",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = riscv_iommu_hpm_state_needed,
+    .post_load = riscv_iommu_hpm_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(hpmcycle_val, RISCVIOMMUState),
+        VMSTATE_UINT64(hpmcycle_prev, RISCVIOMMUState),
+        VMSTATE_UINT64(irq_overflow_left, RISCVIOMMUState),
+        VMSTATE_TIMER_PTR(hpm_timer, RISCVIOMMUState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_riscv_iommu = {
+    .name = "riscv-iommu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .priority = MIG_PRI_IOMMU,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BUFFER_POINTER_UNSAFE(regs, RISCVIOMMUState,
+            0, RISCV_IOMMU_REG_MSI_CONFIG),
+
+        VMSTATE_UINT64(ddtp, RISCVIOMMUState),
+        VMSTATE_UINT64(fctl, RISCVIOMMUState),
+
+        VMSTATE_UINT64(cq_addr, RISCVIOMMUState),
+        VMSTATE_UINT64(fq_addr, RISCVIOMMUState),
+        VMSTATE_UINT64(pq_addr, RISCVIOMMUState),
+
+        VMSTATE_UINT32(cq_mask, RISCVIOMMUState),
+        VMSTATE_UINT32(fq_mask, RISCVIOMMUState),
+        VMSTATE_UINT32(pq_mask, RISCVIOMMUState),
+
+        VMSTATE_BUFFER_POINTER_UNSAFE(regs_ro, RISCVIOMMUState,
+            0, RISCV_IOMMU_REG_MSI_CONFIG),
+
+        VMSTATE_END_OF_LIST(),
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_riscv_iommu_hpm,
+        NULL
+    }
+};
+
 static const Property riscv_iommu_properties[] = {
     DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
         RISCV_IOMMU_SPEC_DOT_VER),
@@ -3094,6 +3147,7 @@ static void riscv_iommu_class_init(ObjectClass *klass, const void *data)
     dc->user_creatable = false;
     dc->realize = riscv_iommu_realize;
     dc->unrealize = riscv_iommu_unrealize;
+    dc->vmsd = &vmstate_riscv_iommu;
     device_class_set_props(dc, riscv_iommu_properties);
 }
 
-- 
2.53.0


