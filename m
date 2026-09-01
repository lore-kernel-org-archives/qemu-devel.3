Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE0DC624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SUi-0002K9-1l; Tue, 01 Sep 2026 13:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x1SUf-0002Jg-9R; Tue, 01 Sep 2026 13:41:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x1SUd-0001AZ-6B; Tue, 01 Sep 2026 13:41:56 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681H5eFm1792279; Tue, 1 Sep 2026 17:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SwyboiY5S80NcRx3u
 Cc0+1ovue9I24l0bhHtzlfHvgc=; b=hhm0nH+LDMzy65Z1eB8qEQcymB7bj0OAl
 T77MknXnK1nk2u2x33EeJUb0ahbTH58Ben63yfb3Zfk+ElyHYAYuvbCIGYRgOyKH
 bPvrg41tnu0moltNNvZAKY/Ror1XJXYRDBDbrY6MvOdX3p+7Rsq6XptW826RGpig
 PeISvx/lUczltJDAt1ABPR/PWliSH+IRu2o8QkdW7AP/wABGCi2zM52c+2ZZ8y3z
 7nCCbhh2ZB3YxIhWA10BNzvw3Fu6iFNZptHq0jqpOiLjV1i6cHlJlvl02H3RjB1L
 /E0OCHWEo44BK0+k0PYaqTV8Ho8gVnfYdYDtufnN82SovJ8130Vuw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5hgev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 17:41:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681HQLh7026084;
 Tue, 1 Sep 2026 17:41:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcark529n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 17:41:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 681HfkLo29164136
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Sep 2026 17:41:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1CA52004E;
 Tue,  1 Sep 2026 17:41:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3778E20043;
 Tue,  1 Sep 2026 17:41:43 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.219.126])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Sep 2026 17:41:42 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mahesh@linux.ibm.com,
 sbhat@linux.ibm.com, anushree.mathur@linux.vnet.ibm.com,
 clg@redhat.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
Subject: [PATCH v5 3/6] ppc/spapr: Add support for ibm, open-errinjct and ibm,
 close-errinjct
Date: Tue,  1 Sep 2026 23:11:07 +0530
Message-ID: <20260901174110.45356-4-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901174110.45356-1-nnmlinux@linux.ibm.com>
References: <20260901174110.45356-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a970e61 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=iw8L5VQ-6e4m0g-3eYQA:9
X-Proofpoint-GUID: qk-gRzAo7XK-TWB_rf-mpzO3crrO-KJw
X-Proofpoint-ORIG-GUID: D1ivztSCIsx3ftd0C20nIWUbWrCDAWPU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX1ihe41e54mBB
 EL3n33QS3+xwPBqo33M0k6jlE+U/a3QjAcxc8MkNHEDb5tfzxlDPpVevgGpa3wNUdqm5TYxic8E
 Vpu6uOT7ox3o1JbRRAWn+z0fGo1T3pU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfXwu0oPlWFOVgL
 4oUNtNyon5IHUCf4CTwAeegYYagGE+M7SNMniRmsRoqL7VBT6ZxpI4kfwHm0i6uwShyVWQvum9m
 Y4BUjddpdDqcwyXaLaLzW0oIunDqISM87EThK/vKioHKBRKMzPqtR4AhrrCCQxI5lYLsKyOsMLO
 r77qUm5MJP/5bI+vpcv+QjbHDd0bJB0R3SWXRk0Cvvsz4++p8f1aYgCP/5F+ZIX4mpPMOEoXCR5
 3J+WOL08ZR1CEigPhxf+eD3V3e8o952XLO6ETeSFsnVWXgw788a+ySXzkAN2Tw4cT0qDno1s67k
 IMrCXaaYsKnCu5z/zkz3Mfl5/8yw8N8CFoSouni2EdQbmlkNlzj4lNcBVAGn2EELAYOcmj228hq
 0PxVRLIlbGn3zPC9YqGZjIRm/Kb3LSkN9UId0IoH0g3UZHnCSu11Hs5h7Kk5AqBfPWLUqLbY41D
 UOC/p+CyBLMpqrdYVXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010155
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

Add RTAS handlers for ibm,open-errinjct and ibm,close-errinjct.  These
calls manage exclusive access to the error-injection facility through a
simple session token mechanism: only one session may be open at a time.

ibm,open-errinjct (nargs=0, nret=2):
  Returns rets[0]=token, rets[1]=status.
  On success: token=1, status=RTAS_OUT_SUCCESS.
  Already-open: token=0, status=RTAS_OUT_ALREADY_OPEN.
  Bad args:    token=0, status=RTAS_OUT_PARAM_ERROR.

ibm,close-errinjct (nargs=1, nret=1):
  Takes the session token in args[0].
  Returns RTAS_OUT_SUCCESS on a matching open token.
  Returns RTAS_OUT_NOT_OPEN if the token is invalid or no session exists.

RTAS_IBM_OPEN_ERRINJCT and RTAS_IBM_CLOSE_ERRINJCT token values and
RTAS_OUT_ALREADY_OPEN / RTAS_OUT_NOT_OPEN return codes are added to
include/hw/ppc/spapr.h.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 include/hw/ppc/spapr.h |  8 +++++-
 hw/ppc/spapr_pci.c     | 57 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 47791c71bd..bcb1da5fab 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -825,8 +825,14 @@ enum rtas_err_type {
 #define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2C)
 #define RTAS_CONFIGURE_KERNEL_DUMP              (RTAS_TOKEN_BASE + 0x2D)
 #define RTAS_IBM_ERRINJCT                       (RTAS_TOKEN_BASE + 0x2E)
+#define RTAS_IBM_OPEN_ERRINJCT                  (RTAS_TOKEN_BASE + 0x2F)
+#define RTAS_IBM_CLOSE_ERRINJCT                 (RTAS_TOKEN_BASE + 0x30)
 
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2F)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x31)
+
+/* ibm,open-errinjct/ibm,close-errinjct return codes */
+#define RTAS_OUT_ALREADY_OPEN                   -4
+#define RTAS_OUT_NOT_OPEN                       -5
 
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index cff12ef268..20cb913f12 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -836,6 +836,57 @@ param_error_exit:
     rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
 }
 
+static void rtas_ibm_open_errinjct(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                                   uint32_t token, uint32_t nargs,
+                                   target_ulong args, uint32_t nret,
+                                   target_ulong rets)
+{
+    if (nargs != 0 || nret != 2) {
+        rtas_st(rets, 0, 0);
+        rtas_st(rets, 1, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    if (spapr->errinjct_token) {
+        /* Session already open: return token=0, status=ALREADY_OPEN */
+        rtas_st(rets, 0, 0);
+        rtas_st(rets, 1, RTAS_OUT_ALREADY_OPEN);
+        return;
+    }
+
+    spapr->errinjct_token = 1;
+
+    /*
+     * ibm,open-errinjct has an unusual return convention: rets[0] is the
+     * session token and rets[1] is the status code.
+     */
+    rtas_st(rets, 0, spapr->errinjct_token);
+    rtas_st(rets, 1, RTAS_OUT_SUCCESS);
+}
+
+static void rtas_ibm_close_errinjct(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                                    uint32_t token, uint32_t nargs,
+                                    target_ulong args, uint32_t nret,
+                                    target_ulong rets)
+{
+    uint32_t o_token;
+
+    if (nargs != 1 || nret != 1) {
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    o_token = rtas_ld(args, 0);
+
+    if (!spapr->errinjct_token || o_token != spapr->errinjct_token) {
+        rtas_st(rets, 0, RTAS_OUT_NOT_OPEN);
+        return;
+    }
+
+    spapr->errinjct_token = 0;
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+}
+
 static void pci_spapr_set_irq(void *opaque, int irq_num, int level)
 {
     /*
@@ -2515,6 +2566,12 @@ void spapr_pci_rtas_init(void)
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
2.51.1


