Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0571CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 19:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEBWL-0006O2-7U; Wed, 29 Oct 2025 15:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1vEBWC-0006MX-PK; Wed, 29 Oct 2025 15:07:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1vEBVz-0001P0-Nw; Wed, 29 Oct 2025 15:07:36 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TA1HfG026029;
 Wed, 29 Oct 2025 19:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=iwkaVuBlwz+ePTv+h
 51JfTzIRUzkqD2xxDdmV0GuXO0=; b=Xt5ZQQLq12qEfO1MUTCnq8i3hzmWeu5Co
 2hH99IwvfI/EieebbIa2ah5s+i1nuEn9mZXNCHsNIm1FbZZ7NZLTXMKuy+OYM6bw
 wk0M4k+ELhIO/OCZNPRomq7gkxgm7WwAJoTs5U/3e4Km6uWyVIXQMo5j81iB7mbt
 0anospeGFbilkRZZBhKrTO5sL6N+X1rCeMDpIsNxr9zusGGJzybVquYwjRQCpk9d
 BagUsPe84ugoZopxEO30EtKW+bzOf30iL9+Izjf2AuQkgIvQUXdfQUJk2KKkx0/q
 fAdDA7g4lkcHkgTjet6GXYWxZsvC9/f89njkmHjHbLH69cDHesRdg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aamwxt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 19:07:10 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59TJ7AGS012794;
 Wed, 29 Oct 2025 19:07:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aamwxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 19:07:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGj47Z030790;
 Wed, 29 Oct 2025 19:07:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwn1mv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 19:07:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59TJ75JE49414546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Oct 2025 19:07:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C039B20049;
 Wed, 29 Oct 2025 19:07:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8922620040;
 Wed, 29 Oct 2025 19:07:04 +0000 (GMT)
Received: from ltcd48-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Oct 2025 19:07:04 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: mahesh@linux.ibm.com, ganeshgr@linux.ibm.com
Subject: [RFC 3/4] ppc/spapr: Add support for 'ibm, open-errinjct' and 'ibm,
 close-errinjct'
Date: Wed, 29 Oct 2025 10:06:17 -0500
Message-ID: <20251029150618.186803-4-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029150618.186803-1-nnmlinux@linux.ibm.com>
References: <20251029150618.186803-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ALkgKXG8 c=1 sm=1 tr=0 ts=690265de cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=QI9oHtSxlEyCc_VTGTAA:9
X-Proofpoint-ORIG-GUID: tehYuktGMqcdlCgtlgkbJkHa8P6PZg9i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfXxJGHan1RQWBe
 tbTN4QguP+fp0HLNisQWFhuaFBN1TvJg0/6ErJv48HnZ/VcJ4FamRI6xQ55k6m5VTbEOYCyWSi1
 D/nMEjJ+XlucSEKl9c7Y+KPhi0HE32IXyOEYt6lmUmeew8TYo2KWmubRYcAp5hvj8ETBg5DEe1O
 I9d/KEY1hwE4MGnaRneeCsNv3KJOlfV/v6Z98LxNN/he6FpBuXCFkJ7Ig6VtXD/DuqCKYLWjJw/
 7EKm8PzBBWVNf9QPuROUFDSOJimpIchdgbMezN52k6nJQ8lpkRa2Elt/EQ/bfDLTNxbBsikMRHW
 Q3zPPClIizLJsvkxK8UKBZdhUvJpRu8y30qryAnZE2NELuWYiQZvbsE79TLdUfCLtHaggRg2Qgr
 z4uMFZVuMQ7EPxb7aR9blAjw8U4Y5w==
X-Proofpoint-GUID: ZVjPVnMAMVs2bYxekaLED23ywGBv1Eif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
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
---
 include/hw/ppc/spapr.h |  8 +++++-
 hw/ppc/spapr_pci.c     | 65 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f762be030c..af9617b13e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -283,6 +283,7 @@ struct SpaprMachineState {
     Error *fwnmi_migration_blocker;
 
     SpaprWatchdog wds[WDT_MAX_WATCHDOGS];
+    uint32_t errinjct_token;
 };
 
 #define H_SUCCESS         0
@@ -755,6 +756,9 @@ enum rtas_err_type {
 #define RTAS_OUT_PARAM_ERROR                    -3
 #define RTAS_OUT_NOT_SUPPORTED                  -3
 #define RTAS_OUT_NO_SUCH_INDICATOR              -3
+#define RTAS_OUT_ALREADY_OPEN                   -4
+#define RTAS_OUT_NOT_OPEN                       -5
+#define RTAS_OUT_CLOSE_ERROR                    -6
 #define RTAS_OUT_NOT_AUTHORIZED                 -9002
 #define RTAS_OUT_SYSPARM_PARAM_ERROR            -9999
 
@@ -818,8 +822,10 @@ enum rtas_err_type {
 #define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2B)
 #define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2C)
 #define RTAS_IBM_ERRINJCT                       (RTAS_TOKEN_BASE + 0x2D)
+#define RTAS_IBM_OPEN_ERRINJCT                  (RTAS_TOKEN_BASE + 0x2E)
+#define RTAS_IBM_CLOSE_ERRINJCT                 (RTAS_TOKEN_BASE + 0x2F)
 
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2E)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x30)
 
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 219099f5aa..4723b87c65 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -864,6 +864,65 @@ param_error_exit:
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
@@ -2560,6 +2619,12 @@ void spapr_pci_rtas_init(void)
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
-- 
2.51.0


