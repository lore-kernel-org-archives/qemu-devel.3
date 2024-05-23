Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0DDC25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 09:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA50m-0005If-0n; Thu, 23 May 2024 05:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sA50j-0005Dn-RN; Thu, 23 May 2024 05:45:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sA50g-0000cJ-1s; Thu, 23 May 2024 05:45:21 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N9356p019902; Thu, 23 May 2024 09:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wf9zC6La+zHBWnn5PQmsRp7OFXfxCrLAj+qyjnXu6ok=;
 b=cUTNIg57hzLXLWhE7WR09lbiki11bGJU07Md2t5ATaZHjqXTf+Vj9ZtWCc7D5aQUi6Ob
 Dik3U5YY7PaYy6M2v3kswuy5qpemTKyJLPeakbGT7mPykhWI3ThdHwc2PfjgGC5wKi74
 idWyA6Od+4LBdfa7BsJ+TC3/NftMOsm85/rlVQgRVlusHRtMoPxjvoRr4mEWPzM4w86V
 dTVhcU89FOPnd5ZWR5poXl9VRKzN+Eke02mtkkyw0lhQIPsJiRiyLQhWyhyZPJpnTnvw
 DgOKpIRUGClwJwqJTp/MUYijRepw1qENU8rpBiw05ame+WdDxvbq/RiWyz3lbrppaF4p GA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya2tsr394-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 09:45:14 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44N9jENO017056;
 Thu, 23 May 2024 09:45:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya2tsr391-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 09:45:14 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N82xog026453; Thu, 23 May 2024 09:45:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y785ms54a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 09:45:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44N9j9PJ57344454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 May 2024 09:45:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCA682004E;
 Thu, 23 May 2024 09:45:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7C612004D;
 Thu, 23 May 2024 09:45:08 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 May 2024 09:45:08 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v2 2/2] target/ppc: Improve VMX integer add/sub saturate
 instructions.
Date: Thu, 23 May 2024 15:14:54 +0530
Message-Id: <20240523094454.123114-3-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240523094454.123114-1-rathc@linux.ibm.com>
References: <20240523094454.123114-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EvpDMW0oIv7UQIpNsBn3FFiIu-vfPqLf
X-Proofpoint-ORIG-GUID: R1g07ZyJSjwCUfZhXARH0LYTl6jUu4EN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_04,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=686 impostorscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230064
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

No need for a full comparison; xor produces non-zero bits for QC just fine.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rath.chinmay@linux.ibm.com>
---
 target/ppc/translate/vmx-impl.c.inc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index fdb283c1d4..152bcde0e3 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -2876,15 +2876,15 @@ TRANS(VADDCUW, do_vx_vaddsubcuw, 1)
 /* Integer Add/Sub Saturate Instructions */
 static inline void do_vadd_vsub_sat
 (
-    unsigned vece, TCGv_vec t, TCGv_vec sat, TCGv_vec a, TCGv_vec b,
+    unsigned vece, TCGv_vec t, TCGv_vec qc, TCGv_vec a, TCGv_vec b,
     void (*norm_op)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec),
     void (*sat_op)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
 {
     TCGv_vec x = tcg_temp_new_vec_matching(t);
     norm_op(vece, x, a, b);
     sat_op(vece, t, a, b);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
-    tcg_gen_or_vec(vece, sat, sat, x);
+    tcg_gen_xor_vec(vece, x, x, t);
+    tcg_gen_or_vec(vece, qc, qc, x);
 }
 
 static void gen_vadd_sat_u(unsigned vece, TCGv_vec t, TCGv_vec sat,
@@ -2916,16 +2916,16 @@ static void gen_vsub_sat_s(unsigned vece, TCGv_vec t, TCGv_vec sat,
  * GVecGen4 struct variants.
  */
 static const TCGOpcode vecop_list_sub_u[] = {
-    INDEX_op_sub_vec, INDEX_op_ussub_vec, INDEX_op_cmp_vec, 0
+    INDEX_op_sub_vec, INDEX_op_ussub_vec, 0
 };
 static const TCGOpcode vecop_list_sub_s[] = {
-    INDEX_op_sub_vec, INDEX_op_sssub_vec, INDEX_op_cmp_vec, 0
+    INDEX_op_sub_vec, INDEX_op_sssub_vec, 0
 };
 static const TCGOpcode vecop_list_add_u[] = {
-    INDEX_op_add_vec, INDEX_op_usadd_vec, INDEX_op_cmp_vec, 0
+    INDEX_op_add_vec, INDEX_op_usadd_vec, 0
 };
 static const TCGOpcode vecop_list_add_s[] = {
-    INDEX_op_add_vec, INDEX_op_ssadd_vec, INDEX_op_cmp_vec, 0
+    INDEX_op_add_vec, INDEX_op_ssadd_vec, 0
 };
 
 static const GVecGen4 op_vsububs = {
-- 
2.39.3


