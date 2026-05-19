Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80ABCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHlw-0001np-7R; Tue, 19 May 2026 06:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPHlu-0001nS-5G; Tue, 19 May 2026 06:33:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPHlr-0004ze-V7; Tue, 19 May 2026 06:33:57 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J5iN7x793884; Tue, 19 May 2026 10:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wKHK1qFn7LvxLFbfm
 /QQMufczV2QVHsm81ygBpG9oc0=; b=fCXYoKnNWKBGXX32Pck9yNqBOcj1YgHp6
 Oq/eulwxagWg2LHe7yMq5JeLNyCVyiqlfVFiEndeI2EjtWuJ04Q+7O6Yg3kISUP+
 IEFZu5l4ewYcHLFWRMGVqVZ2ac3QVkUYyDp1Ffqck+DXWRsLrzLifVtQiQdyHuhz
 xA3atnPIWmM6UaTtyGk/UCMFKJRxNlxJsn4hXvynALVxHsWgL5GqlLIXeEt1lP0n
 CJWe21Twfntkh6Fw7kVPFXlveY5Mb7JROB7PnVwsDZti1Y5L2wiifDrti5AdXP23
 LRP/7VPBNwhJGpqLTXRjtun3au5g8LW6QlBtIj190vMv936EQCOpg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74veq0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 10:33:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JAOB90027415;
 Tue, 19 May 2026 10:33:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky1tyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 10:33:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64JAXlBM62062926
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 May 2026 10:33:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB79820043;
 Tue, 19 May 2026 10:33:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AD9720040;
 Tue, 19 May 2026 10:33:45 +0000 (GMT)
Received: from dhcp-9-123-10-31.bl1-in.ibm.com (unknown [9.123.10.31])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 May 2026 10:33:45 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@linaro.org
Subject: [PATCH v2 2/6] ppc/spapr: Add ibm,errinjct RTAS call handler
Date: Tue, 19 May 2026 16:03:20 +0530
Message-ID: <20260519103325.8056-3-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519103325.8056-1-nnmlinux@linux.ibm.com>
References: <20260519103325.8056-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0c3c90 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=_MNm8bNPt0bhIkh_LCUA:9
X-Proofpoint-ORIG-GUID: UAW4qbT7GrcQUvMXNT8u5yg4QZIE-oQH
X-Proofpoint-GUID: 7da3HtDJBl-ye1a-2tP4tfO0V1fmT3QE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA5OSBTYWx0ZWRfX8pc/e9OrueLH
 ZUhQs9Dwp6ZMxFLUfujjocGJPbCFAQWVLQ/xhwZjWseAG+hIkZBb5g5RG+D9fvOOz8LFL6tmhyi
 NZm2eIoVS2Rg6Kt+4dRzBu0y+Gj43ToqFUFAudwA2oyQmIqd/uSbJWrQ8/fLGJbT/IoTlyIIVjb
 Kk+xeG66n3H1AtgfXQ9Hseso9s1CXPQjHWevyIxzorLsU8AuZAy2ksl6y1KqasBdTEpCSpYUxMM
 5MYPH9BwzTTEr2clfDq7iqDAdQL7KaoDV5rhrPL+9BSHbzOmHU6ybc3MURf4zPO+sT6XTfOlR7v
 Vv//pgeH1/UWrVerw/FOl0bKZOjg1PgHVTCel13gIlcDJ0D5BNcM8RatBwhey+Ws57Z9numgEwm
 eApaqIdLMhNAuUWVh/tuJhaLBAE4eNKgS6RygAxmq3xeiA3EcB+sDclCFGiPU7eMOTbkBHYkgTO
 pk833UANM6rL13OCjOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190099
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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


