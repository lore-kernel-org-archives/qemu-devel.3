Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B41C61DC6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyycf-0003VH-IZ; Tue, 25 Aug 2026 17:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycd-0003Tf-DL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:23:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycb-0002Gj-K7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:23:55 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PL9hl82498720
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=O9DGexoTufl
 6srH88MZz/5wXHHGKrgy2EfMWxzyd2nY=; b=m/nvxvLfG2fx+h6X54haKdLdmrr
 pO7jvbKEqJtdzYq7xUr93OFjnwLQgKlMjqUBKSBobO0b8geIaQ0N8JReCtRRfBMZ
 aKiRFnfXq9yKmYUHLaZQnfys1LVXZcdL7tmP1y1aCk3LrQ4K+vl3R6x+aVyD+BQR
 bQgxCbjNPtpNd7CDuTlV95S/q3XbWcOwWCS/FVlgL+/89j5CsEAwZ8zeNiPjgyjK
 1mho6DFgZdNWca8prPM/JHRH6E+myyf4T6Czd6mwo/dZG0ln3BvWE9O3f6s1iVLX
 qY7BDTo9dHE/a2SpmlRYmLhVviRGgG4ec05D01jwPwkEALZD4ndTliptLsw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fjn0tef-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:23:52 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90c8d271ac9so5852096d6.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787693031; x=1788297831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O9DGexoTufl6srH88MZz/5wXHHGKrgy2EfMWxzyd2nY=;
 b=UsTfGZ8U32cQSkTkfupnCKPFT8aaW1TeGBA2FmBLNEQXT5pQ2NfvJ1VvCarZ/maLlZ
 5g7LN0zd6NGYBN2uhHAToHxS/hFZcPtwprYO/dm6f9UjGZohWHPG8e6shZvC/SatNoxl
 dKDoF9ZCs+bheCgWjNsfCjwT9ImMy/BmS4GouH3k9mVw+IamFKHQN/q234XL4Ql6Zt0+
 VCuJy+psYXZoybups2ru5eFEDOH+DUryd3wJ9Zh2JjODaK9XVwjU6AsKTNJN7SVq95OG
 ArkjHKBS9LGCNiG2fVIuuBdL7t+V8Q/ezG3wa3g4m6m2Zpp6xApCJrg1pbGhhgUby3lx
 Ce8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693031; x=1788297831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O9DGexoTufl6srH88MZz/5wXHHGKrgy2EfMWxzyd2nY=;
 b=nJ39I5OUBy8PpVmMyF/2uV3DoFB8sY6FHMt7NiK9vB5OhUayi+qcX6IBuusuxsTEDR
 NRMrGpL2FQcdk+GAI5reIVwRv9n++P/SPF7glxD0wSLIP1dVF/zIWqLsffsIKSL1PDnE
 MpnSSd4rRdZ1m/3KOIOqbjRW74/PN0P0cIysfTMWcmblfJYQFXiRLdRDm50s9EBPRrpE
 itWkjd14wSXiFr0Gyb6K2sYjlYHDwzidzcyux4E6f1/BHzh4qfXXoEdH1+qauF3Jjbol
 lt7Azf1umpXyKXUakwRKJf4HPgejRF/lr85lbBNj/rnCI05BDeQXHzzSJyXDk3cjhr4a
 r8kQ==
X-Gm-Message-State: AFuF++njZQiyMUeRvRN+O6TTOFAHyHORqbUKVls4chV+q52K+ljEbJEB
 9jiltFT0CJx6DpVYWOagKtAyQaUNzmr+iBbjvukqTQhX0eNx6Aw2imUPrKhITSyCeDUdSxz+K+L
 Pg2L/10NOQBohCeEEgdO3dSoPALl44/0nQJ35Fite6K5a5tAhwNDaT4VrnmYssKuGoQ==
X-Gm-Gg: AR+sD12LSM8+wE4896d72klSqMO/0U84pMg1tUqElkzHtT42/7lsX3UEPiD/lo3zadF
 6QHL2kT/B3NOynQm3Nf7gzXmxKlZ0JNG+06aObUrqXvoSRtPT3W7oBGvGoLR1I+ncAzfWqHoQYt
 PMxW3KfmsnSPkFQWuAdipA4RksCd8bQ95PGl5VE+gpqA6eim49139le8C1mH1xFo427pO4mArKr
 uahy7AVd318bJropQ56Gi/P18Z4u2m3ZI00h1EvZV8hflTo+3NWkmInL15QRzhCLkIgq8QWTyTk
 iD8is6cp8+VmIcqQhMms2n7voRyVATK1W+mESH+I3bCrCGfFZP9gQcBwix+jQHy+qeiMtBeiuyN
 q/J6TQZ+XvxsQtxSiYiwi3gnz5YObWI9pSxDHPQ==
X-Received: by 2002:a05:6214:4605:b0:8ee:d9e7:be2d with SMTP id
 6a1803df08f44-90cc79308d8mr18698076d6.7.1787693031255; 
 Tue, 25 Aug 2026 14:23:51 -0700 (PDT)
X-Received: by 2002:a05:6214:4605:b0:8ee:d9e7:be2d with SMTP id
 6a1803df08f44-90cc79308d8mr18697606d6.7.1787693030841; 
 Tue, 25 Aug 2026 14:23:50 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cc65299f0sm8646386d6.41.2026.08.25.14.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:23:50 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 03/13] hw/riscv/fdt-common,
 virt.c: add create_fdt_riscv_iommu_sys()
Date: Tue, 25 Aug 2026 18:23:15 -0300
Message-ID: <20260825212326.1907-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
References: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: l87-TPpvTjx_ggZwYB1WlZulhb5eUBYm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfXzH2PqvKICY9E
 x2vA6uKyeIv7OQ1kM6+8yEy6HaGBeIVmGj0SC80M9XAAih16+1t1pCWvKBVy/jb2dzxptPqAkZS
 Itvx9BL+ChAj8Jj+Y2+HtnxyyOBfLDc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX6jcynybjbMjt
 8orC+HpZydyqi4OCp4Tu7oM17sUUN4XEbdjUCMVTAXEbq7+6Ag+bufbvj1efuoSqxnH4YvkO+yK
 8PHUG63/tc45T63siDcUdWJmOMwC5RyY4GldbEiGsX1ozA4QXRgH37sULkRYJTw9801Nmt3mbe4
 M97+YdLnjs0zwhA8+umMBeS5i/gBUITYXQd7HAUddEK11jgrq7gcNS/iH89N083dYqH+dYBeCx5
 BgxDgf9aDlX/rGl+hKUKvqRxqYN6Pkou2sx5lACWUKdSDENelAhaYAz04Qj7LnXfb8FL+LmIOeh
 vCnhkUdbedkVMjBcCvBxUq5B0Jd9N3hmGytMyZeedlVS1/ZSRZp4QnQGuXYPGidX7WFl4jZqyE8
 cG5Xvt2NQdINf2wUJcDjmFBYMhNp7fc7+8WJsue1QcgkcOQXvWCQQ22UmSuGbn6KvPw5TYDMgZw
 yG6Z/6irAjG26Sx9uLg==
X-Authority-Analysis: v=2.4 cv=ccziaHDM c=1 sm=1 tr=0 ts=6a8e07e8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=-lP9cGLPB0zaG0B-UEoA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: l87-TPpvTjx_ggZwYB1WlZulhb5eUBYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250182
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Both the 'virt' board and the future 'riscv-server-ref' boards uses an
iommu-sys device that is declared in the DT.

Create a helper to encapsulate the logic and avoid copy/pasting stuff
between boards.

No FDT changes intended.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 40 +++++++++++++++++++++++++++++
 hw/riscv/virt.c               | 47 ++++-------------------------------
 include/hw/riscv/fdt-common.h |  5 ++++
 3 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index a2168c09ec..ddc56821d3 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -13,6 +13,8 @@
 #include "hw/core/boards.h"
 #include "hw/riscv/fdt-common.h"
 #include "target/riscv/cpu_bits.h"
+#include "hw/riscv/riscv-iommu-bits.h"
+#include "hw/riscv/iommu.h"
 
 void *create_board_device_tree(const char *model, const char *compatible,
                                int *fdt_size)
@@ -347,3 +349,41 @@ void create_fdt_syscon(void *fdt, uint32_t *phandle,
     qemu_fdt_setprop_cell(fdt, name, "value", poweroff);
     g_free(name);
 }
+
+void create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
+                                uint32_t irq_chip,
+                                uint32_t msi_phandle,
+                                uint32_t *iommu_sys_phandle,
+                                uint32_t iommu_sys_irq)
+{
+    const char comp[] = "riscv,iommu";
+    uint32_t iommu_phandle;
+    g_autofree char *iommu_node = NULL;
+    uint32_t iommu_irq_map[RISCV_IOMMU_INTR_COUNT] = {
+        iommu_sys_irq + RISCV_IOMMU_INTR_CQ,
+        iommu_sys_irq + RISCV_IOMMU_INTR_FQ,
+        iommu_sys_irq + RISCV_IOMMU_INTR_PM,
+        iommu_sys_irq + RISCV_IOMMU_INTR_PQ,
+    };
+
+    iommu_node = g_strdup_printf("/soc/iommu@%"HWADDR_PRIx, addr);
+    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
+    qemu_fdt_add_subnode(fdt, iommu_node);
+
+    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
+    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
+
+    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg", 2, addr, 2, size);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
+
+    qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
+        iommu_irq_map[0], FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_irq_map[1], FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_irq_map[2], FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_irq_map[3], FDT_IRQ_TYPE_EDGE_LOW);
+
+    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
+
+    *iommu_sys_phandle = iommu_phandle;
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index acbbe458fa..9417aa7a06 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -867,46 +867,6 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
                            bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
 }
 
-static void create_fdt_iommu_sys(RISCVVirtState *s, uint32_t irq_chip,
-                                 uint32_t msi_phandle,
-                                 uint32_t *iommu_sys_phandle)
-{
-    const char comp[] = "riscv,iommu";
-    void *fdt = MACHINE(s)->fdt;
-    uint32_t iommu_phandle;
-    g_autofree char *iommu_node = NULL;
-    hwaddr addr = s->memmap[VIRT_IOMMU_SYS].base;
-    hwaddr size = s->memmap[VIRT_IOMMU_SYS].size;
-    uint32_t iommu_irq_map[RISCV_IOMMU_INTR_COUNT] = {
-        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_CQ,
-        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_FQ,
-        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PM,
-        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PQ,
-    };
-
-    iommu_node = g_strdup_printf("/soc/iommu@%x",
-                               (unsigned int) s->memmap[VIRT_IOMMU_SYS].base);
-    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
-    qemu_fdt_add_subnode(fdt, iommu_node);
-
-    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
-    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
-    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
-
-    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg", 2, addr, 2, size);
-    qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
-
-    qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
-        iommu_irq_map[0], FDT_IRQ_TYPE_EDGE_LOW,
-        iommu_irq_map[1], FDT_IRQ_TYPE_EDGE_LOW,
-        iommu_irq_map[2], FDT_IRQ_TYPE_EDGE_LOW,
-        iommu_irq_map[3], FDT_IRQ_TYPE_EDGE_LOW);
-
-    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
-
-    *iommu_sys_phandle = iommu_phandle;
-}
-
 static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
 {
     const char comp[] = "riscv,pci-iommu";
@@ -945,8 +905,11 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_virtio(s, irq_virtio_phandle);
 
     if (virt_is_iommu_sys_enabled(s)) {
-        create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
-                             &iommu_sys_phandle);
+        create_fdt_riscv_iommu_sys(MACHINE(s)->fdt,
+                                   s->memmap[VIRT_IOMMU_SYS].base,
+                                   s->memmap[VIRT_IOMMU_SYS].size,
+                                   irq_mmio_phandle, msi_pcie_phandle,
+                                   &iommu_sys_phandle, IOMMU_SYS_IRQ);
     }
     create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 31203df517..37a1544706 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -41,4 +41,9 @@ void create_fdt_syscon(void *fdt, uint32_t *phandle,
                        hwaddr addr, hwaddr size,
                        uint32_t reboot, uint32_t poweroff,
                        bool sifive_test_compat);
+void create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
+                                uint32_t irq_chip,
+                                uint32_t msi_phandle,
+                                uint32_t *iommu_sys_phandle,
+                                uint32_t iommu_sys_irq);
 #endif
-- 
2.43.0


