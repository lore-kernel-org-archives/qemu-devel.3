Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B591ACD5BA3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHls-0001nK-O8; Tue, 19 May 2026 06:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPHlp-0001ks-L6; Tue, 19 May 2026 06:33:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPHln-0004xE-JK; Tue, 19 May 2026 06:33:53 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IJP3Ep160368; Tue, 19 May 2026 10:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wyMUXuVoe5YB9/Gol
 FFQ9m0XvZYCncQp31ovl4uyYoY=; b=PwN6GLt0vm3NptC86BDNdv17I9HRGyb6u
 xHOulL145y1bNkqv/ookHuQ5MqUYcxssmVzdtq04Y9Q/LwgD600w9NG5vAF+YK3c
 Cnt0Ymm6YI+hdMKaBzCw+Bsm5cqR4v9WfNRR2+BPCUSrY7uBfM9Qt70HmN5Zg6nl
 sTwSQjU9aEv/TAAVfG9bIXnVYFEzXXVCRaiy233oabKv3sRLDOtpcGzX5AW6pQgh
 WWmAxrZ0vtqvFghfPDWffnB3JpOtHZI21cU3QrGlto7DyqGSgQQZ6uYLYkHrMC37
 2VNSIbnat3fFR9+O0fmIgi1SXJOEjcMh3VzDIOybQ5OqYodJ5fABg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8brcr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 10:33:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JAO6Ta022428;
 Tue, 19 May 2026 10:33:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754g9w4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 10:33:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64JAXjXi25821682
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 May 2026 10:33:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B3CD20043;
 Tue, 19 May 2026 10:33:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7E9B20040;
 Tue, 19 May 2026 10:33:42 +0000 (GMT)
Received: from dhcp-9-123-10-31.bl1-in.ibm.com (unknown [9.123.10.31])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 May 2026 10:33:42 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@linaro.org
Subject: [PATCH v2 1/6] ppc/spapr: Add VFIO EEH error injection backend
Date: Tue, 19 May 2026 16:03:19 +0530
Message-ID: <20260519103325.8056-2-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519103325.8056-1-nnmlinux@linux.ibm.com>
References: <20260519103325.8056-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA5OSBTYWx0ZWRfX15Bw1YETmHoq
 S5eT6D9QZKIEvNSlrEfYp7LakfFL9efI3Owg0fibwtJzaAxohOHEGY666cesD7eJtJXsOjJOJJw
 rgt5nvZCyvpt/Z31iJi9eGhdFRFD9oU9nUhYMVWtcWZkwmZl94WC8Nf0tLy4vX592B8I3X8bZ0b
 S4uLJY4GhW5X/ffSGKADGYrGH5947A7wTEKwamAnM8bYo9IUwmBSuO1CEPnfiQhOuBGKA9lCxc4
 cJdN+Ue9PuJRBx2kpEMAOKj2ssiC/rBmz2eCCtuaTQN92RW4Rr8MJU6kUvFJYqGigpmu9smG+zk
 xCwediRd+8yaV4oMsbECua8aceKT5tcUi0qIFeHL+uxpQkLbGkG8pj/kZeS9jL9mQ7e5qzRB1s+
 N65cvCNppBp0C/1LQlxkjywE/MkH2xBeCH1HvtHMSSf7s2c4jH83idA1Qbe/fIo64ZwEpOnPWeY
 8gG2niZbXEv5ZvJ4G6Q==
X-Proofpoint-GUID: xZlQSnsHC3XMrPQS3G9kIyxYvOujJ7-X
X-Proofpoint-ORIG-GUID: a1V6TQwWLFVreVpHIqIVvDjbrH7tm_Ik
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0c3c8d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=qkVa7TRde7xkgx6zoNMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190099
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 hw/ppc/spapr_pci_vfio.c     | 53 +++++++++++++++++++++++++++++++++++++
 include/hw/pci-host/spapr.h |  7 +++++
 include/hw/ppc/spapr.h      | 44 ++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)

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
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 0db87f1281..417d1f6c31 100644
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
+static inline int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t func,
+                                   uint64_t addr, uint64_t mask, uint32_t type)
+{
+    return RTAS_OUT_HW_ERROR;
+}
 #endif
 
 void spapr_phb_dma_reset(SpaprPhbState *sphb);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9acda15d4f..fadb7cf7d9 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -682,6 +682,50 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
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
-- 
2.54.0


