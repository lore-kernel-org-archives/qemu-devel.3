Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D212CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 19:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEBWO-0006Pk-67; Wed, 29 Oct 2025 15:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1vEBWK-0006OA-Ey; Wed, 29 Oct 2025 15:07:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1vEBW3-0001Ou-Mk; Wed, 29 Oct 2025 15:07:44 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TCb60t030847;
 Wed, 29 Oct 2025 19:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=WoGXQw6q2TVBRKVbY
 jkZeg21img8cNrMEz4VLL7uPzQ=; b=o+RUO1t8NAZImZDASnppqR8JAZ9eNTLD3
 LgvbvT3P8OYAk6CVsAQK7+zonfxApcpZd8P30n4JyLkAhj34CqSPba/rFa5KF60V
 Khw2JVYBbBih6V31jKmgbN3bOvbauNX9Dc/kzL+8PLpZSgbieozvfhk+dSsYJIHM
 3rgCPeE9iriVk6RGGUWCEaPtGhtdYLckxK6vUUEE6BUDUFd1LscQJSp5jWFSmBr5
 E+2vQXVctex9goT/S28BSlurtRKneeKuK8BPSZfh9TgYTP038SOkgPF4fmj5cqju
 ykZeLLlJ+yJfsA1j85RZpznBHisMUcCujTOijlOjS3Y8moQZw0XrQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34ajmwmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 19:07:09 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59TJ7897012955;
 Wed, 29 Oct 2025 19:07:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34ajmwmb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 19:07:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGcOba030770;
 Wed, 29 Oct 2025 19:07:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwn1mr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 19:07:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59TJ74wP22872538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Oct 2025 19:07:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4086F20049;
 Wed, 29 Oct 2025 19:07:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F35F920040;
 Wed, 29 Oct 2025 19:07:02 +0000 (GMT)
Received: from ltcd48-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Oct 2025 19:07:02 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: mahesh@linux.ibm.com, ganeshgr@linux.ibm.com
Subject: [RFC 2/4] ppc/spapr: Add ibm,errinjct RTAS call handler
Date: Wed, 29 Oct 2025 10:06:16 -0500
Message-ID: <20251029150618.186803-3-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029150618.186803-1-nnmlinux@linux.ibm.com>
References: <20251029150618.186803-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/XkCAP+ c=1 sm=1 tr=0 ts=690265dd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=_MNm8bNPt0bhIkh_LCUA:9
X-Proofpoint-GUID: u2xGwuK7tTJzFsg8gSMZ089I-Q8JP7g-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfXw9PLgtkHLiub
 M/7Y+gNjz9cFus3GfIZXFvatkr1N9s8GcqbNyKZs3mxZ8NJ6yyab5Y3tbuwJ9/euIwDZS2woUyK
 JE6mVuWlgm0I/1FKyR6Y8LbrCT0WRJG18bFQS+lJiBmfA/E/SZWqYSMIRdaGoicbt+gTAOPBMKY
 vi3jUyF7+ma7dmNlV6QahpJaMGOGpvoZwMQOhCtth5FcFpgoXKBay5jYMEiYFsz2Q35q8AKtgsH
 776gfGxrn22X184mtCxeKHuJk4l7uwCOD3kuq3ortNn0Tyz9bZII0UVnYSS2DyuWsv5P77sXal6
 qgqGy4ZaCoHIt+lL1pPvYkMGJSB4AF8//B9HIrGydoR3yb/ZAEuFVzyEYv5YhM/05K/Ov5ukXwC
 9Zhf+2ZXvbHioNlFzDYgxak/0BRdEA==
X-Proofpoint-ORIG-GUID: OmayW4_-tlwlg4nFr84vfRAHOIAxxupd
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
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Implements the 'ibm,errinjct' RTAS call for PHB-level PCI error injection
via firmware. This handler decodes the RTAS parameter buffer, validates
arguments, and delegates the injection to the backend.

The patch includes:
    - 'rtas_ibm_errinjct()' handler implementation
    - Registration of 'RTAS_IBM_ERRINJCT' token
    - RTAS error codes for result reporting
    - Helper macros used exclusively in RTAS code path

Enables guest-initiated error injection for improved test coverage and
diagnostics in EEH emulation flows.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 include/hw/ppc/spapr.h |   6 +-
 hw/ppc/spapr_pci.c     | 155 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 331946ee57..f762be030c 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -715,6 +715,9 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
 #define EEH_ERR_FUNC_DMA_WR_TARGET      19
 #define EEH_ERR_FUNC_MAX                EEH_ERR_FUNC_DMA_WR_TARGET
 
+#define EEH_ERR_EVENT_MODE_MIN     1
+#define EEH_ERR_EVENT_MODE_MAX     2
+
 /* RTAS PCI Error Injection Token Types */
 enum rtas_err_type {
     RTAS_ERR_TYPE_FATAL                   = 0x1,
@@ -814,8 +817,9 @@ enum rtas_err_type {
 #define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BASE + 0x2A)
 #define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2B)
 #define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2C)
+#define RTAS_IBM_ERRINJCT                       (RTAS_TOKEN_BASE + 0x2D)
 
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2D)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2E)
 
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f9095552e8..219099f5aa 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -712,6 +712,158 @@ param_error_exit:
     rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
 }
 
+static int parse_and_verify_recovered_special_event(target_ulong param_buf,
+                                                    uint64_t *addr) {
+    uint32_t mode = rtas_ld(param_buf, 0);
+    if (mode != EEH_ERR_EVENT_MODE_MIN && mode != EEH_ERR_EVENT_MODE_MAX) {
+        return RTAS_OUT_PARAM_ERROR;
+    }
+    *addr = ((uint64_t)mode) << 32;
+    qemu_log("RTAS: recovered-special-event: mode=%u\n", mode);
+    return RTAS_OUT_SUCCESS;
+}
+
+static int parse_and_verify_corrupted_page(target_ulong param_buf,
+                                           uint64_t *addr) {
+    *addr = ((uint64_t)rtas_ld(param_buf, 0) << 32) | rtas_ld(param_buf, 1);
+    qemu_log("RTAS: corrupted-page: addr=0x%lx\n", *addr);
+    return (*addr) ? RTAS_OUT_SUCCESS : RTAS_OUT_PARAM_ERROR;
+}
+
+static int parse_and_verify_ioa_bus_error(target_ulong param_buf,
+                                          bool is_64bit,
+                                          uint64_t *addr, uint64_t *mask,
+                                          uint64_t *buid, uint32_t *func)
+{
+    if (is_64bit) {
+        *addr = ((uint64_t)rtas_ld(param_buf, 0) << 32) | rtas_ld(param_buf, 1);
+        *mask = ((uint64_t)rtas_ld(param_buf, 2) << 32) | rtas_ld(param_buf, 3);
+        *buid = ((uint64_t)rtas_ld(param_buf, 5) << 32) | rtas_ld(param_buf, 6);
+        *func = rtas_ld(param_buf, 7);
+    } else {
+        *addr = rtas_ld(param_buf, 0);
+        *mask = rtas_ld(param_buf, 1);
+        *buid = ((uint64_t)rtas_ld(param_buf, 3) << 32) | rtas_ld(param_buf, 4);
+        *func = rtas_ld(param_buf, 5);
+    }
+
+    /* Address/mask validation intentionally skipped for now */
+
+    return RTAS_OUT_SUCCESS;
+}
+
+static int parse_and_verify_corrupted_dcache(target_ulong param_buf,
+                                             uint64_t *addr)
+{
+    uint32_t action = rtas_ld(param_buf, 0);
+    uint32_t nature = rtas_ld(param_buf, 1);
+    *addr = ((uint64_t)action << 32) | nature;
+
+    return (action <= 2 && nature <= 2) ? RTAS_OUT_SUCCESS
+            : RTAS_OUT_PARAM_ERROR;
+}
+
+static int parse_and_verify_corrupted_icache(target_ulong param_buf,
+                                             uint64_t *addr)
+{
+    uint32_t action = rtas_ld(param_buf, 0);
+    uint32_t nature = rtas_ld(param_buf, 1);
+    *addr = ((uint64_t)action << 32) | nature;
+
+    return (action <= 3 && nature <= 2) ? RTAS_OUT_SUCCESS
+            : RTAS_OUT_PARAM_ERROR;
+}
+
+static int parse_and_verify_corrupted_tlb(target_ulong param_buf,
+                                          uint64_t *addr)
+{
+    uint32_t nature = rtas_ld(param_buf, 0);
+    *addr = ((uint64_t)nature << 32);
+
+    return (nature <= 2) ? RTAS_OUT_SUCCESS : RTAS_OUT_PARAM_ERROR;
+}
+
+static void rtas_ibm_errinjct(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                              uint32_t token, uint32_t nargs,
+                              target_ulong args, uint32_t nret,
+                              target_ulong rets)
+{
+    SpaprPhbState *sphb;
+    target_ulong param_buf;
+    uint64_t addr = 0, mask = 0, buid = 0;
+    uint32_t func = 0;
+    uint32_t type, o_token;
+    int ret = -1;
+
+    if ((nargs != 3) || (nret != 1)) {
+        goto param_error_exit;
+    }
+
+    type = rtas_ld(args, 0);
+    o_token = rtas_ld(args, 1);
+    param_buf = rtas_ld(args, 2);
+
+    if (o_token != spapr->errinjct_token) {
+        goto param_error_exit;
+    }
+
+    sphb = QLIST_FIRST(&spapr->phbs);
+    if (!sphb) {
+        goto param_error_exit;
+    }
+
+    switch (type) {
+    case RTAS_ERR_TYPE_IOA_BUS_ERROR:
+        ret = parse_and_verify_ioa_bus_error(param_buf, false, &addr,
+                                             &mask, &buid, &func);
+        break;
+    case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
+        ret = parse_and_verify_ioa_bus_error(param_buf, true, &addr,
+                                             &mask, &buid, &func);
+        break;
+    case RTAS_ERR_TYPE_CORRUPTED_PAGE:
+        ret = parse_and_verify_corrupted_page(param_buf, &addr);
+        break;
+    case RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT:
+        ret = parse_and_verify_recovered_special_event(param_buf, &addr);
+        break;
+    case RTAS_ERR_TYPE_CORRUPTED_DCACHE_START:
+    case RTAS_ERR_TYPE_CORRUPTED_DCACHE_END:
+        ret = parse_and_verify_corrupted_dcache(param_buf, &addr);
+        mask = 0;
+        break;
+    case RTAS_ERR_TYPE_CORRUPTED_ICACHE_START:
+    case RTAS_ERR_TYPE_CORRUPTED_ICACHE_END:
+        ret = parse_and_verify_corrupted_icache(param_buf, &addr);
+        mask = 0;
+        break;
+    case RTAS_ERR_TYPE_CORRUPTED_TLB_START:
+    case RTAS_ERR_TYPE_CORRUPTED_TLB_END:
+        ret = parse_and_verify_corrupted_tlb(param_buf, &addr);
+        mask = 0;
+        break;
+    default:
+        ret = RTAS_OUT_PARAM_ERROR;
+        break;
+    }
+
+    if (ret != RTAS_OUT_SUCCESS) {
+        goto param_error_exit;
+    }
+
+    ret = spapr_phb_vfio_errinjct(sphb, func, addr, mask, type);
+    if (ret < 0) {
+        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
+        return;
+    }
+
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+    return;
+
+param_error_exit:
+    rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+}
+
 static void pci_spapr_set_irq(void *opaque, int irq_num, int level)
 {
     /*
@@ -2405,6 +2557,9 @@ void spapr_pci_rtas_init(void)
     spapr_rtas_register(RTAS_IBM_SLOT_ERROR_DETAIL,
                         "ibm,slot-error-detail",
                         rtas_ibm_slot_error_detail);
+    spapr_rtas_register(RTAS_IBM_ERRINJCT,
+                        "ibm,errinjct",
+                        rtas_ibm_errinjct);
 }
 
 static void spapr_pci_register_types(void)
-- 
2.51.0


