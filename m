Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60B3CD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 07:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMhII-0002hd-HV; Tue, 12 May 2026 03:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wMhHZ-0002cF-3x; Tue, 12 May 2026 03:11:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wMhHS-0002LC-Fz; Tue, 12 May 2026 03:11:56 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK7OsG2761003; Tue, 12 May 2026 07:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wKHK1qFn7LvxLFbfm
 /QQMufczV2QVHsm81ygBpG9oc0=; b=L6St8naVw3TxsU0LwwUpUyTHEZiZW93m5
 zz/Vd/NdhiS/U+Ak1igNSemjIfBp3D85M6mjsM/JIorXAhFQ90FPFZfOBLtZgSen
 +FvYE+VbEHLScfdedne9yZDzYbGW1SdnWzp6Jc5Dckf4LzBWqlkrf+1pbjyvGY64
 UplufTbU+BWkFTygjHf2ytpfbs5+PebZuDDmwfYOmnyTu9q8t5WOZ8AvP7XhEVxm
 2iJc7vAHAN9e7EmzuAwHk8XwW9bxb3aJAie1Xg7xphnoHIUGHp0sSbSRmw/K4iMj
 NG0z1EkCyu2U/QQk0S5njhGA/THjma/3nnsQt9E5TSouxYk5IdvHQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6hsbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 07:11:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64C79MaZ018714;
 Tue, 12 May 2026 07:11:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgj2uk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 07:11:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64C7BhrW47645086
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 07:11:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 039F320043;
 Tue, 12 May 2026 07:11:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DA2D20040;
 Tue, 12 May 2026 07:11:40 +0000 (GMT)
Received: from dhcp-9-123-10-31.bl1-in.ibm.com (unknown [9.123.10.31])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 May 2026 07:11:40 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com
Subject: [PATCH 2/6] ppc/spapr: Add ibm,errinjct RTAS call handler
Date: Tue, 12 May 2026 12:41:07 +0530
Message-ID: <20260512071112.9675-3-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512071112.9675-1-nnmlinux@linux.ibm.com>
References: <20260512071112.9675-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: -mSDdoXoqW16MU4xQgPTIe8563NmcIG-
X-Proofpoint-GUID: MIZ6oBy9KwkibBE4HtwfLI5OXmjZo_-3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2OCBTYWx0ZWRfX4Cd7yArAmmcg
 EFoBatl+mTyqJBkPxbHskQG0dZ7utcBkqZSUs1IBgYyaxv2pD7hKZ2yqbfC5icVjV0h/67ZP1U/
 8Vl9PNizvDLPEGw+CySomsRea/1HWr97u3wjZZwnsWJnbf12seSqGWCVYZQOxfZKEyqTp5L3MXr
 oY2rYogGLaoMsg7v8rk6hN2Q2dOwu8KehBfDuMa9esnJit/2fHX2HL6QyKp/iIUDiskOfkx+k7Z
 hp0XSKIYPMtTcFabDEx43q3HscXZdESbCKBW8W8tzQBoQBI0dCbqsuRJZF5W/OauJpZFtfw86Ap
 p6QNignBLgF0eV+rZ3+81roGLP3nJw2PfH1CiEIb4tZBGQy7/dN8Ts25gK6fejoFws/etF66llC
 WVj3Ed1/hDFP8r6Ry0o4oilCXjLQaRx58NKMG54wnka8es5saqxEvlkS6KWuV3t6wVLh0dmZTEI
 LO3vUp0zz5tGazdOgBg==
X-Authority-Analysis: v=2.4 cv=P8UKQCAu c=1 sm=1 tr=0 ts=6a02d2b5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=_MNm8bNPt0bhIkh_LCUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120068
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
 hw/ppc/spapr_pci.c     | 153 +++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |   6 +-
 2 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index c1d4b7806e..82de04186e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -704,6 +704,156 @@ param_error_exit:
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
@@ -2380,6 +2530,9 @@ void spapr_pci_rtas_init(void)
     spapr_rtas_register(RTAS_IBM_SLOT_ERROR_DETAIL,
                         "ibm,slot-error-detail",
                         rtas_ibm_slot_error_detail);
+    spapr_rtas_register(RTAS_IBM_ERRINJCT,
+                        "ibm,errinjct",
+                        rtas_ibm_errinjct);
 }
 
 static void spapr_pci_register_types(void)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index fadb7cf7d9..512dd038ec 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -706,6 +706,9 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
 #define EEH_ERR_FUNC_DMA_WR_TARGET      19
 #define EEH_ERR_FUNC_MAX                EEH_ERR_FUNC_DMA_WR_TARGET
 
+#define EEH_ERR_EVENT_MODE_MIN     1
+#define EEH_ERR_EVENT_MODE_MAX     2
+
 /* RTAS PCI Error Injection Token Types */
 enum rtas_err_type {
     RTAS_ERR_TYPE_FATAL                   = 0x1,
@@ -808,8 +811,9 @@ enum rtas_err_type {
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


