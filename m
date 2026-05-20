Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49C3CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfF6-0004jl-CK; Wed, 20 May 2026 07:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPfF0-0004Oz-7X; Wed, 20 May 2026 07:37:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPfEy-0006Nn-91; Wed, 20 May 2026 07:37:33 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K5G4Px617871; Wed, 20 May 2026 09:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2v08B2DmlNs9ED6Ht
 gHqUKLFvvqhvKxsPs40uxOW8tc=; b=lSXaF7PYhgksoveQvNIfsRMSTqLjmasjU
 Qh7Zr/n4uZ9L52zYKWy0XnLhMv8eOUsiNpWioE5yigDKc33uIOBtFQ6eXQDztNpQ
 97vz5EXzqkzKs6TBdGImZRBd1AZfXiYkYve535xhR16861H5v3QdvN15gOH8maPa
 blvi9AdwLGywBEWs6LugvdoZQQ3RgbnHATEkCBONRZm5P3MUisH4dPNOGhm7UGgA
 d5OQhYhJs2kL2vleTiWQCIsd4+AHBvN9N+NXBLxuVH/YiTB4kZfy1u3a77rCuTmW
 IGpzxMc88EVWwyJ3AROYf/kLzVTXNX864/265rZEARVaaUBZQnUoQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h751dn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 09:55:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K9s53i021588;
 Wed, 20 May 2026 09:55:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk6se3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 09:55:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64K9t7dV19988808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 09:55:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83A0F20040;
 Wed, 20 May 2026 09:55:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52AF120043;
 Wed, 20 May 2026 09:55:05 +0000 (GMT)
Received: from dhcp-9-123-10-31.bl1-in.ibm.com (unknown [9.123.10.31])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 09:55:05 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@linaro.org
Subject: [PATCH v3 3/6] ppc/spapr: Add support for 'ibm,
 open-errinjct' and 'ibm, close-errinjct'
Date: Wed, 20 May 2026 15:24:43 +0530
Message-ID: <20260520095446.64206-4-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520095446.64206-1-nnmlinux@linux.ibm.com>
References: <20260520095446.64206-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0d8500 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=376oZdPSatvzr_fvEE0A:9
X-Proofpoint-ORIG-GUID: dJ-jZDxVNoxLSTZ8rBQl7q716qdUSh5q
X-Proofpoint-GUID: c5w0v1Run3iyFA9QIHRdFErh1dhpAHCh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA5MiBTYWx0ZWRfX4WZlUertElEp
 dXPyffOh4ow9kqa+awrGOhpSCsZAEzovkWwTUZPtolQZkaTrlEyKBPw3+MvCMTQAk04jL9YIM/j
 Whe7yjxIjfsH3isB+qx4EGWcerOsYp22tIu3lUmqThOqgGaBCFYRMXk/E6145IeAAAaINOo1qFZ
 /1O7N86ndORuzrUjFisyV7hYtOnGGio7+VkxijsgBIUOJqcFOVoxjQJtMm83BHdMkhl5Ig5fhjm
 z87ON9Dn7T3dG+cwoyNXJ4Gei0OVzi1oXeuuCuR0+BIi1+/ZoD10ZdH7qFcNTzAC49EYPoZACO1
 KZbsP2tx455KtKk3ybQYQSb4etACnSTV2AZLxv1/frz3x73zCTTevDs2wheEvKGfRkKpbItveLn
 UN1CGw71tIX7IcBB4vQe0cLWucE94SE9v4PsdgJEZVaNzAoChEklI12d5M9z02Z+xkAecR1xiP8
 lBUC7kdB9Tznimr5Hvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200092
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
index 74aefca827..f08f21f03c 100644
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


