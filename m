Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67550D116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 12:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQPms-0000RS-2P; Tue, 02 Dec 2025 07:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1vQPmo-0000Qu-R6; Tue, 02 Dec 2025 07:47:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1vQPmn-0001Mv-84; Tue, 02 Dec 2025 07:47:18 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B276Wqt003477;
 Tue, 2 Dec 2025 12:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Nca2PDXNMoThjVSDGpDenLhX9VKM+EG8idiA9366O
 3c=; b=XLGwtjByvRL4k9h1dIo721PzuiusWIgDHW5bVIudin+sJ/hUGpcZt8jKP
 D5yEFQ+0FZxzkG7EBYyDfcR/1JU61H/qZZIHC2LY1LSKhtBrIw49yYdC23elYSXD
 27hr54EyTnN6fAGbGk5/svSxPSsMfky7VPLrm3Jvfc87BA61EpP+wuKPILz18JNo
 eoj1CBhR4TZvl0S1vDMpEck0/sQihFYSxf07425+GwT+XpMcy0iAjcASttgBtgA+
 twDYU97aSX5XulwzrIUrNuxydCgTThWcgFaIHWyuR5BwA2hsyhOBRhE1rWxl+EiG
 owQuV420sgBbQaA5QqEuz5Lc2Oqnw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9myr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Dec 2025 12:47:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B2CjZvj015003;
 Tue, 2 Dec 2025 12:47:12 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9myr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Dec 2025 12:47:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2B2jIa008558;
 Tue, 2 Dec 2025 12:47:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arc5mvbhy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Dec 2025 12:47:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B2Cl72G16515534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Dec 2025 12:47:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AEBC20040;
 Tue,  2 Dec 2025 12:47:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B8EB2004B;
 Tue,  2 Dec 2025 12:47:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.70.76])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  2 Dec 2025 12:47:03 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, rathc@linux.ibm.com,
 pbonzini@redhat.com, sjitindarsingh@gmail.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, qemu-ppc@nongnu.org,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH] target/ppc/kvm : Use macro names instead of hardcoded
 constants as return values
Date: Tue,  2 Dec 2025 18:16:52 +0530
Message-ID: <20251202124654.11481-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UCdXh0DoEy6l5r23AgGQehQLXOWuQkoP
X-Proofpoint-ORIG-GUID: gL-zHsFowwA5FiMpCnFNXBFbRWfuOXOI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX3EC8Vr/RSQwI
 H+/ZwmFSWh5eJMplLfqOGAalj7rEdmoHO93BGkX/W58ZUOvYeRQVH3Sna9FA9z6Y/l0IaEOIPeH
 fNreBhIklO+oDgYQL/483MPYoXdeIXPN/y6O7TBfwrXDrzU6FXGG8NFRunecrZMgxCsGpwTlSkP
 a8gIOKJrznBGyqIUIr+pRS41XB/4b7yDPT4zuxD7z6GF3dVHbSPXHtRcAOsj9QbtmPz6LRFp1No
 /7P0jbLGZYlOs7DbZtVgARGY2cswvAUMNd+Kk8YAbKsFsqn3+pQhrZ5C5YmZVf+hQ1BefiXsnyD
 mskMB//tAFBgmM4Rd9rqHG8/n8Fb2SlzdrmNrhLc0OTYVHBL8q41jDp+5RtxtIXAuUEHQsPXpDA
 0gGhDtOZx2FTH0jQ+Bn8UhyeROXpng==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=692edfd0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=TXOZxh5LdWKoDwPKVd0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=gautam@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In the parse_* functions used to parse the return values of
KVM_PPC_GET_CPU_CHAR ioctl, the return values are hardcoded as numbers.
Use the macro names for better readability. No functional change
intended.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 target/ppc/kvm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 43124bf1c7..464240d911 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2450,26 +2450,26 @@ static int parse_cap_ppc_safe_cache(struct kvm_ppc_cpu_char c)
     bool l1d_thread_priv_req = !kvmppc_power8_host();
 
     if (~c.behaviour & c.behaviour_mask & H_CPU_BEHAV_L1D_FLUSH_PR) {
-        return 2;
+        return SPAPR_CAP_FIXED;
     } else if ((!l1d_thread_priv_req ||
                 c.character & c.character_mask & H_CPU_CHAR_L1D_THREAD_PRIV) &&
                (c.character & c.character_mask
                 & (H_CPU_CHAR_L1D_FLUSH_ORI30 | H_CPU_CHAR_L1D_FLUSH_TRIG2))) {
-        return 1;
+        return SPAPR_CAP_WORKAROUND;
     }
 
-    return 0;
+    return SPAPR_CAP_BROKEN;
 }
 
 static int parse_cap_ppc_safe_bounds_check(struct kvm_ppc_cpu_char c)
 {
     if (~c.behaviour & c.behaviour_mask & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR) {
-        return 2;
+        return SPAPR_CAP_FIXED;
     } else if (c.character & c.character_mask & H_CPU_CHAR_SPEC_BAR_ORI31) {
-        return 1;
+        return SPAPR_CAP_WORKAROUND;
     }
 
-    return 0;
+    return SPAPR_CAP_BROKEN;
 }
 
 static int parse_cap_ppc_safe_indirect_branch(struct kvm_ppc_cpu_char c)
@@ -2486,15 +2486,15 @@ static int parse_cap_ppc_safe_indirect_branch(struct kvm_ppc_cpu_char c)
         return SPAPR_CAP_FIXED_IBS;
     }
 
-    return 0;
+    return SPAPR_CAP_BROKEN;
 }
 
 static int parse_cap_ppc_count_cache_flush_assist(struct kvm_ppc_cpu_char c)
 {
     if (c.character & c.character_mask & H_CPU_CHAR_BCCTR_FLUSH_ASSIST) {
-        return 1;
+        return SPAPR_CAP_WORKAROUND;
     }
-    return 0;
+    return SPAPR_CAP_BROKEN;
 }
 
 bool kvmppc_has_cap_xive(void)
-- 
2.51.1


