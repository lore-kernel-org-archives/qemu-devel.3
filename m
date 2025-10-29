Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416C6CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 19:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEBW5-0006Kd-M4; Wed, 29 Oct 2025 15:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1vEBW3-0006KJ-RA; Wed, 29 Oct 2025 15:07:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1vEBVu-0001Or-QS; Wed, 29 Oct 2025 15:07:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TBMOi8001087;
 Wed, 29 Oct 2025 19:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XnC9Njsa3+9pTSXEc
 6m+ZkC6y8BZ0W+4yH/alKcG3dY=; b=tHTtuhFahZZXv66M4VgIXc87R150e4IOq
 Xb/Da2lq2hv0Y07C1oJKD+1acwxIaVjg11rmIbz42hE4u4Z8wn5byBCYjYf6yema
 oSMVOgc6MqjnOV/5G0tupuRb6jw8Df8fUaofP5aLxTceIbRNxa9CSGW+ML+JlWZj
 zY1lPurmy+qfTMxqZ6y7sqAmYzvyLJPmNEvcyyvON9jS+ZrDnda9m2W6razd8KFu
 qYKcArXgbvfBo8cTA+dPBn8vpTDPDcodoROkXlTc5Vfr+WAae+QGyrFChn7u6gft
 SET+QR/7q4ypu54Vjxr5zxH7/5LraQfRwZ86NWCqUArzZnswK3eyA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34ajmwm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 19:07:07 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59TJ77RF012924;
 Wed, 29 Oct 2025 19:07:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34ajmwm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 19:07:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGncxo023836;
 Wed, 29 Oct 2025 19:07:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33vx5117-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 19:07:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59TJ72Lg42402228
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Oct 2025 19:07:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB03620049;
 Wed, 29 Oct 2025 19:07:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72EBE20040;
 Wed, 29 Oct 2025 19:07:01 +0000 (GMT)
Received: from ltcd48-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Oct 2025 19:07:01 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: mahesh@linux.ibm.com, ganeshgr@linux.ibm.com
Subject: [RFC 1/4] ppc/spapr: Add VFIO EEH error injection backend
Date: Wed, 29 Oct 2025 10:06:15 -0500
Message-ID: <20251029150618.186803-2-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029150618.186803-1-nnmlinux@linux.ibm.com>
References: <20251029150618.186803-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/XkCAP+ c=1 sm=1 tr=0 ts=690265db cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=qkVa7TRde7xkgx6zoNMA:9
X-Proofpoint-GUID: VXeibnPKf9mI4t4SC0aY4s6lBNbIYe33
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX4MfGKr7bKyAk
 vja9ZlzfdEjCNC4+08IScrJgWI5ED7y4QmVNr067NIzYHIk/7BfFHWo3Udl143zuO/s+k4sF+L/
 NpmO0cUe9WiERA6bkkU+YMiwaf/GCEJH52N4ondRWzgKNrjZiqdxBHiBIp7sgW/Uajh63oqWdAm
 /Cfu5MZXoXBEAhdaDSd5wRoj3qx3wJPWhRPVMfKbVPYJgVTcfJY54tFaXWKRf1FGO1FRiqLf97O
 q3fmsYrpsatEKeULyMXnlBgV+oz6FkjPEJB1BjSXT2paC0tdHYKv9LaTOPJQDXRRe/vwhfUEdDQ
 RpKLsKu1F+6XUw3B5iBjCNCz3/T7evu7WL79SkJ9yCZsMb7A5W99q574NPGFbHMCO1I9PD9Xep4
 g16paMtZy88tijjCccdJha9i+DaVcw==
X-Proofpoint-ORIG-GUID: jPeWKrkU85FZZpuorzGlnP_9nX9lOCrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce 'spapr_phb_vfio_errinjct()' to inject PCI PHB error events via
the VFIO passthrough backend. This function translates RTAS error injection
parameters into VFIO EEH injection commands suitable for hardware emulation.

The patch adds:
    - A minimal 'enum rtas_err_type' for error types used in VFIO path
    - EEH function code macros ('EEH_ERR_FUNC_...')
    - Backend stub and integration into 'spapr_pci_vfio.c'
    - Necessary header declarations for interfacing

This forms the foundational layer for PCI error injection testing using VFIO
passthrough devices on pseries guests.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 include/hw/pci-host/spapr.h |  7 +++++
 include/hw/ppc/spapr.h      | 44 ++++++++++++++++++++++++++++++
 hw/ppc/spapr_pci_vfio.c     | 53 +++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 0db87f1281..2e91e0fb38 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -125,6 +125,8 @@ int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state);
 int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option);
 int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb);
 void spapr_phb_vfio_reset(DeviceState *qdev);
+int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t func,
+                            uint64_t addr, uint64_t mask, uint32_t type);
 #else
 static inline bool spapr_phb_eeh_available(SpaprPhbState *sphb)
 {
@@ -151,6 +153,11 @@ static inline int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
 static inline void spapr_phb_vfio_reset(DeviceState *qdev)
 {
 }
+static int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t func,
+                                   uint64_t addr, uint64_t mask, uint32_t type)
+{
+    return RTAS_OUT_HW_ERROR;
+}
 #endif
 
 void spapr_phb_dma_reset(SpaprPhbState *sphb);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 39bd5bd5ed..331946ee57 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -691,6 +691,50 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
 #define RTAS_EEH_PE_UNAVAIL_INFO         1000
 #define RTAS_EEH_PE_RECOVER_INFO         0
 
+/* EEH error types and functions */
+#define EEH_ERR_FUNC_MIN                0
+#define EEH_ERR_FUNC_LD_MEM_ADDR        0       /* Memory load  */
+#define EEH_ERR_FUNC_LD_MEM_DATA        1
+#define EEH_ERR_FUNC_LD_IO_ADDR         2       /* IO load      */
+#define EEH_ERR_FUNC_LD_IO_DATA         3
+#define EEH_ERR_FUNC_LD_CFG_ADDR        4       /* Config load  */
+#define EEH_ERR_FUNC_LD_CFG_DATA        5
+#define EEH_ERR_FUNC_ST_MEM_ADDR        6       /* Memory store */
+#define EEH_ERR_FUNC_ST_MEM_DATA        7
+#define EEH_ERR_FUNC_ST_IO_ADDR         8       /* IO store     */
+#define EEH_ERR_FUNC_ST_IO_DATA         9
+#define EEH_ERR_FUNC_ST_CFG_ADDR        10      /* Config store */
+#define EEH_ERR_FUNC_ST_CFG_DATA        11
+#define EEH_ERR_FUNC_DMA_RD_ADDR        12      /* DMA read     */
+#define EEH_ERR_FUNC_DMA_RD_DATA        13
+#define EEH_ERR_FUNC_DMA_RD_MASTER      14
+#define EEH_ERR_FUNC_DMA_RD_TARGET      15
+#define EEH_ERR_FUNC_DMA_WR_ADDR        16      /* DMA write    */
+#define EEH_ERR_FUNC_DMA_WR_DATA        17
+#define EEH_ERR_FUNC_DMA_WR_MASTER      18
+#define EEH_ERR_FUNC_DMA_WR_TARGET      19
+#define EEH_ERR_FUNC_MAX                EEH_ERR_FUNC_DMA_WR_TARGET
+
+/* RTAS PCI Error Injection Token Types */
+enum rtas_err_type {
+    RTAS_ERR_TYPE_FATAL                   = 0x1,
+    RTAS_ERR_TYPE_RECOVERED_RANDOM_EVENT  = 0x2,
+    RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT = 0x3,
+    RTAS_ERR_TYPE_CORRUPTED_PAGE          = 0x4,
+    RTAS_ERR_TYPE_CORRUPTED_SLB           = 0x5,
+    RTAS_ERR_TYPE_TRANSLATOR_FAILURE      = 0x6,
+    RTAS_ERR_TYPE_IOA_BUS_ERROR           = 0x7,
+    RTAS_ERR_TYPE_PLATFORM_SPECIFIC       = 0x8,
+    RTAS_ERR_TYPE_CORRUPTED_DCACHE_START  = 0x9,
+    RTAS_ERR_TYPE_CORRUPTED_DCACHE_END    = 0xA,
+    RTAS_ERR_TYPE_CORRUPTED_ICACHE_START  = 0xB,
+    RTAS_ERR_TYPE_CORRUPTED_ICACHE_END    = 0xC,
+    RTAS_ERR_TYPE_CORRUPTED_TLB_START     = 0xD,
+    RTAS_ERR_TYPE_CORRUPTED_TLB_END       = 0xE,
+    RTAS_ERR_TYPE_IOA_BUS_ERROR_64        = 0xF,
+    RTAS_ERR_TYPE_UPSTREAM_IO_ERROR       = 0x10
+};
+
 /* ibm,set-slot-reset */
 #define RTAS_SLOT_RESET_DEACTIVATE       0
 #define RTAS_SLOT_RESET_HOT              1
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index a748a0bf4c..ed0b22a84a 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -317,6 +317,55 @@ int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
     return RTAS_OUT_SUCCESS;
 }
 
+int spapr_phb_vfio_errinjct(SpaprPhbState *sphb,
+                            uint32_t func, uint64_t addr,
+                            uint64_t mask, uint32_t type)
+{
+    VFIOLegacyContainer *container = vfio_eeh_as_container(&sphb->iommu_as);
+    struct vfio_eeh_pe_op op = {
+        .op = VFIO_EEH_PE_INJECT_ERR,
+        .argsz = sizeof(op),
+    };
+
+    /* Set error type, address, and mask */
+    op.err.type = type;
+    op.err.addr = addr;
+    op.err.mask = mask;
+
+    /* Validate and set function code */
+    switch (func) {
+    case EEH_ERR_FUNC_LD_MEM_ADDR:
+    case EEH_ERR_FUNC_LD_MEM_DATA:
+    case EEH_ERR_FUNC_LD_IO_ADDR:
+    case EEH_ERR_FUNC_LD_IO_DATA:
+    case EEH_ERR_FUNC_LD_CFG_ADDR:
+    case EEH_ERR_FUNC_LD_CFG_DATA:
+    case EEH_ERR_FUNC_ST_MEM_ADDR:
+    case EEH_ERR_FUNC_ST_MEM_DATA:
+    case EEH_ERR_FUNC_ST_IO_ADDR:
+    case EEH_ERR_FUNC_ST_IO_DATA:
+    case EEH_ERR_FUNC_ST_CFG_ADDR:
+    case EEH_ERR_FUNC_ST_CFG_DATA:
+    case EEH_ERR_FUNC_DMA_RD_ADDR:
+    case EEH_ERR_FUNC_DMA_RD_DATA:
+    case EEH_ERR_FUNC_DMA_RD_MASTER:
+    case EEH_ERR_FUNC_DMA_RD_TARGET:
+    case EEH_ERR_FUNC_DMA_WR_ADDR:
+    case EEH_ERR_FUNC_DMA_WR_DATA:
+    case EEH_ERR_FUNC_DMA_WR_MASTER:
+        op.err.func = func;
+        break;
+    default:
+        return RTAS_OUT_PARAM_ERROR;
+    }
+
+    /* Perform the ioctl to inject the error */
+    if (ioctl(container->fd, VFIO_EEH_PE_OP, &op) < 0) {
+        return RTAS_OUT_HW_ERROR;
+    }
+
+    return RTAS_OUT_SUCCESS;
+}
 #else
 
 bool spapr_phb_eeh_available(SpaprPhbState *sphb)
@@ -349,4 +398,8 @@ int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
     return RTAS_OUT_NOT_SUPPORTED;
 }
 
+int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, int option)
+{
+    return RTAS_OUT_NOT_SUPPORTED;
+}
 #endif /* CONFIG_VFIO_PCI */
-- 
2.51.0


