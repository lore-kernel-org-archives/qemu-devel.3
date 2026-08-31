Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3DAC624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0wLz-0006p6-S5; Mon, 31 Aug 2026 03:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x0wLx-0006ns-FK; Mon, 31 Aug 2026 03:22:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x0wLv-0007Hf-Bc; Mon, 31 Aug 2026 03:22:49 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52fBY3591574; Mon, 31 Aug 2026 07:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=allVduVGsPWQkc6j4
 JKlUIUvGuRhvY6VPgVwnFjqutw=; b=m7HnHdFsbjEa4NcKM5OJ7Ma4j2Qar3EcN
 KaMg+42kZWIM2YgoMAYmXE+llt8h0YXduWbW2Hm6+OzCf8d60wTbQgEM5WkY8b4P
 PN1xSp+DxLLdylphPT0PiQH99QpHiUvVMA8IGp3nswzAuC1RuBjvSWjs8BZNjRmt
 Wxf30YsrvQkBh93s2z0UQLUfsMS7CfXcGxU+2pWmjrebok762Js5clDqv8jpzRZL
 R6SooynZtiVQWXA9/fvc4TKFSKhN9FuOF1kVaY8X5r+Pf3hQ5kg5JVtUb59F0DOX
 0tVuvA3UdF9mKDFgRMsDNRvnxv2J7kunDtYfbW80osqmSmTUNY8jg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3qyrj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 07:22:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V7BUDp012991;
 Mon, 31 Aug 2026 07:22:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjvk1h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 07:22:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67V7Mb0d9372112
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 07:22:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FF8D20049;
 Mon, 31 Aug 2026 07:22:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6945F20040;
 Mon, 31 Aug 2026 07:22:34 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.3.199])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 07:22:34 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mahesh@linux.ibm.com,
 sbhat@linux.ibm.com, anushree.mathur@linux.vnet.ibm.com,
 clg@redhat.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
Subject: [PATCH v4 1/6] ppc/spapr: Add VFIO EEH error injection backend
Date: Mon, 31 Aug 2026 12:49:53 +0530
Message-ID: <20260831071958.58824-2-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831071958.58824-1-nnmlinux@linux.ibm.com>
References: <20260831071958.58824-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a952bc5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=0fC1r5mNT4k1lSFpsBYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfXy1eyyPkuMir5
 Jq7ZqhXCBw9//PuAW0fGNoMHzQpWNSDeFgSgxDVRmldqYq7FJLVaCwGve2imWBcw9IiLurLtWNO
 s2T96J66utXEg5eER++n7e9NSolu9/yLCiOUcSQ/ucx9yZFS98af4/NCq0lBcYxOfW3oZRveCnI
 pAFlH1w6vqXh1TSOWwTADpcOCkEzQ2sDgxEiSlXasF4Gr81FG22a4A8QJ1L363oOpEnoRFSTCh8
 mygFELxHCubZtcss4EkSskFfRXOIwKNOZhMlhiHLqxHSUXbulsKGtglknLpIeyrXN4X2AvYcEQz
 rt8xlTu8YgB8GZPbMKV2rgn0gcExEff1/xZknUWBYNZudTvwUnu9JNz60a1N35eZQ+E7kAZpMkU
 p0RqrCYqZRYhbaJzTPPc24Zm5sbcX82rphh9mlRfj0KsC1IFtwsOoC/ZQjpMn9mUla5jzDN/vHn
 P1rywcoWmdNchJEVoFw==
X-Proofpoint-GUID: 6LQaR8Ypn5Ul0eQFQy9oJSZzMMc2VtdE
X-Proofpoint-ORIG-GUID: i1JXXCu9fVOGtIFf7Mwr3mnGGYWcavqM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfXzCrRuWVWEkRF
 AvkzUtNsvHlZJd3/cxD4wHJGJAhNN7qWntqd9KdRDOIBKYMswqi6tB6bRCTv/d7Hl4G9LcZGM8y
 upoRjjn5Mvo+NCACpD2cM9/0AmPVXoE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310059
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Add spapr_phb_vfio_errinjct() to the VFIO EEH backend in
spapr_pci_vfio.c.  The function maps guest RTAS IOA bus-error types to
the corresponding VFIO EEH ioctl error types:

  RTAS_ERR_TYPE_IOA_BUS_ERROR    -> EEH_ERR_TYPE_32
  RTAS_ERR_TYPE_IOA_BUS_ERROR_64 -> EEH_ERR_TYPE_64

EEH_ERR_TYPE_32 / EEH_ERR_TYPE_64 are imported from the powerpc UAPI
EEH header where available; fallback numeric definitions are provided
to guard against older build environments.

The backend consumes type, func, addr, and mask from the caller.  It
does not accept or interpret config_addr; PHB/PE selection is the
caller's responsibility via the sphb pointer.

Supporting type definitions are added to include/hw/ppc/spapr.h:
  - EEH_ERR_FUNC_* and EEH_ERR_FUNC_MAX
  - EEH_ERR_TYPE_32 / EEH_ERR_TYPE_64 (with #ifndef guards)
  - enum rtas_err_type (RTAS ibm,errinjct error token values)
  - RTAS_IBM_ERRINJCT token

The function prototype is added to include/hw/pci-host/spapr.h inside
the CONFIG_LINUX ifdef block alongside the other EEH hooks.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>

---
 hw/ppc/spapr_pci_vfio.c     | 75 +++++++++++++++++++++++++++++++++++++
 include/hw/pci-host/spapr.h |  8 ++++
 include/hw/ppc/spapr.h      | 60 ++++++++++++++++++++++++++++-
 3 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index a748a0bf4c..7afca0cec6 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -26,6 +26,7 @@
 #include "hw/pci/pci_device.h"
 #include "hw/vfio/vfio-container-legacy.h"
 #include "qemu/error-report.h"
+#include "hw/vfio/pci.h"
 #include CONFIG_DEVICES /* CONFIG_VFIO_PCI */
 
 /*
@@ -317,6 +318,74 @@ int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
     return RTAS_OUT_SUCCESS;
 }
 
+static int spapr_vfio_errinjct_rtas_type_to_vfio(uint32_t rtas_type)
+{
+    switch (rtas_type) {
+    case RTAS_ERR_TYPE_IOA_BUS_ERROR:
+        return EEH_ERR_TYPE_32;
+    case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
+        return EEH_ERR_TYPE_64;
+    default:
+        return -1;
+    }
+}
+
+static bool spapr_vfio_errinjct_func_valid(uint32_t func)
+{
+    return func <= EEH_ERR_FUNC_MAX;
+}
+
+int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
+                            uint32_t func, uint64_t addr, uint64_t mask)
+{
+    VFIOLegacyContainer *container;
+    struct vfio_eeh_pe_op op = {
+        .op   = VFIO_EEH_PE_INJECT_ERR,
+        .argsz = sizeof(op),
+    };
+    int vfio_type;
+
+    if (!sphb) {
+        return RTAS_OUT_PARAM_ERROR;
+    }
+
+    if (!spapr_vfio_errinjct_func_valid(func)) {
+        return RTAS_OUT_PARAM_ERROR;
+    }
+
+    vfio_type = spapr_vfio_errinjct_rtas_type_to_vfio(type);
+    if (vfio_type < 0) {
+        return RTAS_OUT_NOT_SUPPORTED;
+    }
+
+    container = vfio_eeh_as_container(&sphb->iommu_as);
+    if (!container) {
+        error_report("vfio/eeh errinjct: no VFIO EEH container for PHB");
+        return RTAS_OUT_NOT_SUPPORTED;
+    }
+
+    op.err.type = vfio_type;
+    op.err.func = func;
+    op.err.addr = addr;
+    op.err.mask = mask;
+
+    if (ioctl(container->fd, VFIO_EEH_PE_OP, &op) < 0) {
+        error_report("vfio/eeh errinjct: VFIO_EEH_PE_OP failed: %s",
+                     strerror(errno));
+        switch (errno) {
+        case EINVAL:
+            return RTAS_OUT_PARAM_ERROR;
+        case ENOTTY:
+        case EOPNOTSUPP:
+            return RTAS_OUT_NOT_SUPPORTED;
+        default:
+            return RTAS_OUT_HW_ERROR;
+        }
+    }
+
+    return RTAS_OUT_SUCCESS;
+}
+
 #else
 
 bool spapr_phb_eeh_available(SpaprPhbState *sphb)
@@ -349,4 +418,10 @@ int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
     return RTAS_OUT_NOT_SUPPORTED;
 }
 
+int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
+                            uint32_t func, uint64_t addr, uint64_t mask)
+{
+    return RTAS_OUT_NOT_SUPPORTED;
+}
+
 #endif /* CONFIG_VFIO_PCI */
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 0db87f1281..24109409f4 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -125,6 +125,8 @@ int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state);
 int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option);
 int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb);
 void spapr_phb_vfio_reset(DeviceState *qdev);
+int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
+                            uint32_t func, uint64_t addr, uint64_t mask);
 #else
 static inline bool spapr_phb_eeh_available(SpaprPhbState *sphb)
 {
@@ -151,6 +153,12 @@ static inline int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
 static inline void spapr_phb_vfio_reset(DeviceState *qdev)
 {
 }
+static inline int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
+                                          uint32_t func, uint64_t addr,
+                                          uint64_t mask)
+{
+    return RTAS_OUT_NOT_SUPPORTED;
+}
 #endif
 
 void spapr_phb_dma_reset(SpaprPhbState *sphb);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9acda15d4f..253dc0e862 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -682,6 +682,63 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
 #define RTAS_EEH_PE_UNAVAIL_INFO         1000
 #define RTAS_EEH_PE_RECOVER_INFO         0
 
+/* EEH error injection types and functions */
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
+/*
+ * RTAS ibm,errinjct error type byte values.  These are RTAS ABI token
+ * numbers, not the same as the VFIO EEH ABI type values consumed by
+ * VFIO_EEH_PE_INJECT_ERR.  An explicit mapping is required.
+ */
+/* Use powerpc EEH UAPI constants where available; define locally otherwise. */
+#ifndef EEH_ERR_TYPE_32
+#define EEH_ERR_TYPE_32                 0
+#endif
+#ifndef EEH_ERR_TYPE_64
+#define EEH_ERR_TYPE_64                 1
+#endif
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
@@ -764,8 +821,9 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
 #define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2B)
 #define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2C)
 #define RTAS_CONFIGURE_KERNEL_DUMP              (RTAS_TOKEN_BASE + 0x2D)
+#define RTAS_IBM_ERRINJCT                       (RTAS_TOKEN_BASE + 0x2E)
 
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2E)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2F)
 
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
-- 
2.54.0


