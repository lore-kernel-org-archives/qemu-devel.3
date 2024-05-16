Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1042DC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 14:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7cCN-0005Ep-7t; Thu, 16 May 2024 10:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1s7cCD-0004tR-Hy; Thu, 16 May 2024 10:35:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1s7cCB-0008PD-Q0; Thu, 16 May 2024 10:35:01 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44G8LObO004082;
 Thu, 16 May 2024 14:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=gn+BG1wXXQbLuvm78504UqR1HklffQD2CPYQ6ADrJJo=; b=N+
 wC7hVQgzXl5ZHWYMNmTHKctu2UD0iclqj3Ost5+Lf9cXl29MrnZiMDPQBai88Z/d
 BST653CqUzgBO0sA1Hnd1U4/Huv/GdS6qtiXRxA5c7amrparrwlgnA3ZuDPxkoaa
 Sfvrsm7tCd5B3rrNvoVD60P/Ml1p9DbDK4B8azlN39IG6Xxy515Q/N2HTfVc79QB
 h4HR77jm0n4+i7Zw5D8qrpgL+fWE1QTUSNqD2TsXdK6+pK+u0+GUxAMZWU+PKwKd
 iM0lwQrgNgZHte0AA4q6oSk8duxznfiHveLV7kRqqFM8R1GN3/pAEXs0aS3nnly3
 9UD8vvUcczqqbOvwK8/g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y2125m0au-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 14:34:57 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44GEYuJS027163
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 14:34:56 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 16 May 2024 07:34:52 -0700
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <philmd@linaro.org>, <alex.bennee@linaro.org>, 
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v2 11/12] gunyah: Workarounds (NOT FOR MERGE)
Date: Thu, 16 May 2024 14:33:55 +0000
Message-ID: <20240516143356.1739402-12-quic_svaddagi@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240516143356.1739402-1-quic_svaddagi@quicinc.com>
References: <20240516143356.1739402-1-quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: u1hrZTLcLXAbo-Nw50J5JD_gEa4EHEQW
X-Proofpoint-ORIG-GUID: u1hrZTLcLXAbo-Nw50J5JD_gEa4EHEQW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160102
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These are some work-arounds required temporarily until some limitations
with Gunyah hypervisor are addressed.

Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
---
 include/sysemu/gunyah_int.h |  1 +
 accel/gunyah/gunyah-all.c   | 18 ++++++++++++++++++
 hw/arm/boot.c               | 17 ++++++++++++++++-
 hw/arm/virt.c               |  3 ++-
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/gunyah_int.h b/include/sysemu/gunyah_int.h
index ef82c6edd8..bdda430dbd 100644
--- a/include/sysemu/gunyah_int.h
+++ b/include/sysemu/gunyah_int.h
@@ -62,5 +62,6 @@ int gunyah_add_irqfd(int irqfd, int label, Error **errp);
 GUNYAHState *get_gunyah_state(void);
 int gunyah_arch_put_registers(CPUState *cs, int level);
 void gunyah_cpu_synchronize_post_reset(CPUState *cpu);
+gunyah_slot *gunyah_find_slot_by_addr(uint64_t addr);
 
 #endif    /* GUNYAH_INT_H */
diff --git a/accel/gunyah/gunyah-all.c b/accel/gunyah/gunyah-all.c
index 4c56dd8c73..bc106fbad6 100644
--- a/accel/gunyah/gunyah-all.c
+++ b/accel/gunyah/gunyah-all.c
@@ -158,6 +158,24 @@ static gunyah_slot *gunyah_find_overlap_slot(GUNYAHState *s,
     return NULL;
 }
 
+gunyah_slot *gunyah_find_slot_by_addr(uint64_t addr)
+{
+    GUNYAHState *s = GUNYAH_STATE(current_accel());
+    int i;
+    gunyah_slot *slot = NULL;
+
+    gunyah_slots_lock(s);
+    for (i = 0; i < s->nr_slots; ++i) {
+        slot = &s->slots[i];
+        if (slot->size &&
+            (addr >= slot->start && addr <= slot->start + slot->size))
+                break;
+    }
+    gunyah_slots_unlock(s);
+
+    return slot;
+}
+
 /* Called with s->slots_lock held */
 static gunyah_slot *gunyah_get_free_slot(GUNYAHState *s)
 {
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 84ea6a807a..a29b2cb0f9 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -413,7 +413,8 @@ static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
     char *nodename;
     int ret;
 
-    nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
+    /* Workaround until RM can parse memory nodes of type memory@XYZ. */
+    nodename = g_strdup_printf("/memory");
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
     ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acells, mem_base,
@@ -661,6 +662,20 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         binfo->modify_dtb(binfo, fdt);
     }
 
+    /*
+     * Gunyah RM inspects and modifies device-tree (to provide additional
+     * information that VM may need). It depends on knowing total size reserved
+     * for device-tree (i.e FDT_MAX_SIZE) and current size (via @totalsize). At
+     * this point however, @totalsize = FDT_MAX_SIZE, making RM think that there
+     * is no room for modification and fail to start VM.
+     *
+     * RM should ideally pack device-tree so that @totalsize reflects the actual
+     * size before it attempts modification. Until RM is fixed, pack
+     * device-tree so that @toalsize reflects the actual size.
+     */
+
+    fdt_pack(fdt);
+
     qemu_fdt_dumpdtb(fdt, size);
 
     /* Put the DTB into the memory map as a ROM image: this will ensure
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b0132beddd..5f3075e748 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -188,7 +188,8 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_PCIE_PIO] =           { 0x3eff0000, 0x00010000 },
     [VIRT_PCIE_ECAM] =          { 0x3f000000, 0x01000000 },
     /* Actual RAM size depends on initial RAM and device memory settings */
-    [VIRT_MEM] =                { GiB, LEGACY_RAMLIMIT_BYTES },
+    /* Workaround until Gunyah can accept mapping that starts from GiB */
+    [VIRT_MEM] =                { 2 * GiB, LEGACY_RAMLIMIT_BYTES },
 };
 
 /*
-- 
2.25.1


