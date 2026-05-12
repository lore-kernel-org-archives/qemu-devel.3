Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7EBCD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 07:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMhIJ-0002jE-6Y; Tue, 12 May 2026 03:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wMhHZ-0002cG-3A; Tue, 12 May 2026 03:11:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wMhHW-0002Ud-7p; Tue, 12 May 2026 03:11:56 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK7anU2611849; Tue, 12 May 2026 07:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FYkrxgvs8FxfNX9id
 QPHewaspppgsiXg86tr9Po6a8M=; b=o8CiEa3HgBeWeobnWVW2FkSaHZSaLblre
 jBGbYsjc8OZkh7/ZI9xLwCSLSE+aWgJDOxiA1CWiD3VyEC+Q/mTYDCJfxc6vjfBw
 ZBalXst/CCBWOVa19s5kiGq9wYUP4wxyHpgOc1p2Ys5WvCQraDocj6JpjvXvdTEO
 Bj0stdU/AXD8ozlsKYfHxOotK42v49+atKk5z9O/aI7XQYFbKqqDnCQLPzsX1XH6
 hHxzjV4OK0zPiJzJC2WfRmAakXlsCx0FIXmfzYkhnct4b6OPPq8blvozmQWRpRYx
 Fq93HhpSeDT8Yybueu8hz5/gsRFYKDIICgyM32cewxKVsqlHLDoQg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nvdsvxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 07:11:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64C79Nxs015807;
 Tue, 12 May 2026 07:11:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgj31t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 07:11:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64C7BkNd57278832
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 07:11:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5EEA2004D;
 Tue, 12 May 2026 07:11:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75FDB20040;
 Tue, 12 May 2026 07:11:43 +0000 (GMT)
Received: from dhcp-9-123-10-31.bl1-in.ibm.com (unknown [9.123.10.31])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 May 2026 07:11:43 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com
Subject: [PATCH 3/6] ppc/spapr: Add support for 'ibm, open-errinjct' and 'ibm,
 close-errinjct'
Date: Tue, 12 May 2026 12:41:08 +0530
Message-ID: <20260512071112.9675-4-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512071112.9675-1-nnmlinux@linux.ibm.com>
References: <20260512071112.9675-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Y/XIdBeN c=1 sm=1 tr=0 ts=6a02d2b8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=376oZdPSatvzr_fvEE0A:9
X-Proofpoint-GUID: o_q3lYtFotldUdS0OKEMQ7k-ogDP-eNJ
X-Proofpoint-ORIG-GUID: PxJxzCdXWm1xfoqIbVeVBBEEN8C98yWy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2OCBTYWx0ZWRfXxpK5+yG6SAtX
 kCM+SPC2zMMUaQZQupyaSpXsHg0Hx7QnnfgSi4+No3r1PWD3STywRLw4rNLoMyIqrKfAP3yJw+x
 V/Xxzi05g4tCb91o7pXqcQ5P7kQuT+qQKDAkoecie7CkSimLBcYr8jTo723/lJjae8AMUNnmScn
 3IBIYl5onMbJbLTCWKQr+w0FG3d+2ZZH2qFDjrRALr6S6GoTZ4R/042/JaAqAkryBzMrrcMKoE0
 kZH5LkCYSXIVCkA0/J58gOPPshb92kNJ7paebEbwmHDPpUVM9Ba0kHRv8DEELRnnrqAL2rUa4yK
 L60diTRViLWU6z9+SoUVm2HaOSEVZBHEM1FWjOpGdz924tBVcIdUvfu/U5EQfeBUDKsrQ4YbE8h
 D3rXc6HOhh5T/wpYcYsOEv0mXDzpipQ9t1nLMliW9vj3fLUBu7M7qswYMvJwnoTX6AMRc8AqjlB
 +aKF2Zf6s+4y/bXYlog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120068
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

Add support for the 'ibm,open-errinjct' and 'ibm,close-errinjct' RTAS
calls. These handlers manage exclusive access to error injection
facilities through a simple session-based mechanism.

Updates include:
  - Implementation of rtas_ibm_open_errinjct() and rtas_ibm_close_errinjct()
  - Tracking field 'spapr->errinjct_token' in SpaprMachineState
  - New token definitions for the above RTAS calls
  - Return codes for already open or invalid close conditions

This ensures that only one guest process can actively perform error
injection at a time, improving reliability and preventing conflicts.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 hw/ppc/spapr_pci.c     | 65 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  9 +++++-
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 82de04186e..b00f71d92a 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -854,6 +854,65 @@ param_error_exit:
     rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
 }
 
+static void rtas_ibm_open_errinjct(PowerPCCPU *cpu,
+                                   SpaprMachineState *spapr,
+                                   uint32_t token,
+                                   uint32_t nargs,
+                                   target_ulong args,
+                                   uint32_t nret,
+                                   target_ulong rets)
+{
+    /* Validate argument count */
+    if ((nargs != 0) || (nret != 2)) {
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    if (spapr->errinjct_token) {
+        /* Already open: return token=0 and code=ALREADY_OPEN */
+        rtas_st(rets, 0, 0);
+        rtas_st(rets, 1, RTAS_OUT_ALREADY_OPEN);
+        return;
+    }
+
+    spapr->errinjct_token = 1;
+
+    /*
+     * Unlike most RTAS calls, ibm,open-errinjct returns
+     * the session token in the first output parameter
+     * and the status in the second.
+     */
+    rtas_st(rets, 0, spapr->errinjct_token);
+    rtas_st(rets, 1, RTAS_OUT_SUCCESS);
+}
+
+static void rtas_ibm_close_errinjct(PowerPCCPU *cpu,
+                                    SpaprMachineState *spapr,
+                                    uint32_t token,
+                                    uint32_t nargs,
+                                    target_ulong args,
+                                    uint32_t nret,
+                                    target_ulong rets)
+{
+    uint32_t o_token;
+
+    if ((nargs != 1) || (nret != 1)) {
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    o_token = rtas_ld(args, 0);
+
+    if (o_token != spapr->errinjct_token) {
+        rtas_st(rets, 0, RTAS_OUT_NOT_OPEN);
+        return;
+    }
+
+    spapr->errinjct_token = 0;
+
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+}
+
 static void pci_spapr_set_irq(void *opaque, int irq_num, int level)
 {
     /*
@@ -2533,6 +2592,12 @@ void spapr_pci_rtas_init(void)
     spapr_rtas_register(RTAS_IBM_ERRINJCT,
                         "ibm,errinjct",
                         rtas_ibm_errinjct);
+    spapr_rtas_register(RTAS_IBM_OPEN_ERRINJCT,
+                        "ibm,open-errinjct",
+                        rtas_ibm_open_errinjct);
+    spapr_rtas_register(RTAS_IBM_CLOSE_ERRINJCT,
+                        "ibm,close-errinjct",
+                        rtas_ibm_close_errinjct);
 }
 
 static void spapr_pci_register_types(void)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 512dd038ec..6c87f94e1d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -274,6 +274,8 @@ struct SpaprMachineState {
     bool fadump_registered;
     bool fadump_dump_active;
     FadumpMemStruct registered_fdm;
+
+    uint32_t errinjct_token;
 };
 
 #define H_SUCCESS         0
@@ -746,6 +748,9 @@ enum rtas_err_type {
 #define RTAS_OUT_PARAM_ERROR                    -3
 #define RTAS_OUT_NOT_SUPPORTED                  -3
 #define RTAS_OUT_NO_SUCH_INDICATOR              -3
+#define RTAS_OUT_ALREADY_OPEN                   -4
+#define RTAS_OUT_NOT_OPEN                       -5
+#define RTAS_OUT_CLOSE_ERROR                    -6
 #define RTAS_OUT_DUMP_ALREADY_REGISTERED        -9
 #define RTAS_OUT_DUMP_ACTIVE                    -10
 #define RTAS_OUT_NOT_AUTHORIZED                 -9002
@@ -812,8 +817,10 @@ enum rtas_err_type {
 #define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2C)
 #define RTAS_CONFIGURE_KERNEL_DUMP              (RTAS_TOKEN_BASE + 0x2D)
 #define RTAS_IBM_ERRINJCT                       (RTAS_TOKEN_BASE + 0x2E)
+#define RTAS_IBM_OPEN_ERRINJCT                  (RTAS_TOKEN_BASE + 0x2F)
+#define RTAS_IBM_CLOSE_ERRINJCT                 (RTAS_TOKEN_BASE + 0x30)
 
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2F)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x31)
 
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
-- 
2.54.0


