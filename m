Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E798AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 05:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1JLO-00037B-3w; Mon, 29 Apr 2024 01:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1s1JKj-0002uc-BQ; Mon, 29 Apr 2024 01:13:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1s1JKg-0005ir-Pa; Mon, 29 Apr 2024 01:13:45 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43T4XcKl002899; Mon, 29 Apr 2024 05:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=G8DyJjdtkYCy06bP/5u/Y6EZDtbQjLleEVVwtr0a70A=;
 b=D/B+8Wu1q4Lt2/YQiRq/UUe7nSKn1mvcp2vDadFeXqa2WdLXUsQoYjy2kbVkqgUVyYZ8
 X5RHullEjJbqoO3F7gf+mn7VR7X15mhOAF7u5K7GlvqIAJ8wQ5WFDU7ZuiFBwNj0Ee16
 La0O+yPLes6js8DlDAPkJtItbGR8WR7it8jAlWPiFLjKcUJdGiXrBMBi6AxjbussuTm8
 HKNxKucPSAcxm+JUgh189TzHHinE8SiV6Nxj3zzp9guyGxLg6b9u9q+FNjPMMzl1AxfL
 +GklhFl5I+DKaVDp7a8LhMgPOVj+YhMHL0Dc3/kiQ+6Dc167I+R7PyksfJkEXdhlyrro vA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xt4me01u1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 05:13:40 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43T5DeXP024852;
 Mon, 29 Apr 2024 05:13:40 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xt4me01u0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 05:13:40 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43T4cGGT003210; Mon, 29 Apr 2024 05:13:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xscpp5e2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 05:13:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43T5DZbI14418260
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 05:13:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4B2C2004E;
 Mon, 29 Apr 2024 05:13:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36A9B20043;
 Mon, 29 Apr 2024 05:13:34 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.171.12.153])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 29 Apr 2024 05:13:33 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 3/3] target/ppc: Move VMX integer max/min instructions to
 decodetree.
Date: Mon, 29 Apr 2024 10:43:17 +0530
Message-Id: <20240429051317.289426-4-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240429051317.289426-1-rathc@linux.ibm.com>
References: <20240429051317.289426-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _t2SVIvsOjr_DYaUlBqG5So3OmJB-nnj
X-Proofpoint-ORIG-GUID: 0U_4wjXGJ2CrW3H8XdCiKWUpQ7ncFScE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_02,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290033
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Moving the following instructions to decodetree specification :

	v{max, min}{u, s}{b, h, w, d}	: VX-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode            | 22 +++++++++++++++++
 target/ppc/translate/vmx-impl.c.inc | 37 ++++++++++++++++-------------
 target/ppc/translate/vmx-ops.c.inc  | 16 -------------
 3 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index e00bc05381..847a2f4356 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -717,6 +717,28 @@ VEXTSD2Q        000100 ..... 11011 ..... 11000000010    @VX_tb
 VNEGD           000100 ..... 00111 ..... 11000000010    @VX_tb
 VNEGW           000100 ..... 00110 ..... 11000000010    @VX_tb
 
+## Vector Integer Maximum/Minimum Instructions
+
+VMAXUB          000100 ..... ..... ..... 00000000010    @VX
+VMAXUH          000100 ..... ..... ..... 00001000010    @VX
+VMAXUW          000100 ..... ..... ..... 00010000010    @VX
+VMAXUD          000100 ..... ..... ..... 00011000010    @VX
+
+VMAXSB          000100 ..... ..... ..... 00100000010    @VX
+VMAXSH          000100 ..... ..... ..... 00101000010    @VX
+VMAXSW          000100 ..... ..... ..... 00110000010    @VX
+VMAXSD          000100 ..... ..... ..... 00111000010    @VX
+
+VMINUB          000100 ..... ..... ..... 01000000010    @VX
+VMINUH          000100 ..... ..... ..... 01001000010    @VX
+VMINUW          000100 ..... ..... ..... 01010000010    @VX
+VMINUD          000100 ..... ..... ..... 01011000010    @VX
+
+VMINSB          000100 ..... ..... ..... 01100000010    @VX
+VMINSH          000100 ..... ..... ..... 01101000010    @VX
+VMINSW          000100 ..... ..... ..... 01110000010    @VX
+VMINSD          000100 ..... ..... ..... 01111000010    @VX
+
 ## Vector Mask Manipulation Instructions
 
 MTVSRBM         000100 ..... 10000 ..... 11001000010    @VX_tb
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index cefe04127c..8084af75cc 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -342,22 +342,6 @@ GEN_VXFORM_V(vsububm, MO_8, tcg_gen_gvec_sub, 0, 16);
 GEN_VXFORM_V(vsubuhm, MO_16, tcg_gen_gvec_sub, 0, 17);
 GEN_VXFORM_V(vsubuwm, MO_32, tcg_gen_gvec_sub, 0, 18);
 GEN_VXFORM_V(vsubudm, MO_64, tcg_gen_gvec_sub, 0, 19);
-GEN_VXFORM_V(vmaxub, MO_8, tcg_gen_gvec_umax, 1, 0);
-GEN_VXFORM_V(vmaxuh, MO_16, tcg_gen_gvec_umax, 1, 1);
-GEN_VXFORM_V(vmaxuw, MO_32, tcg_gen_gvec_umax, 1, 2);
-GEN_VXFORM_V(vmaxud, MO_64, tcg_gen_gvec_umax, 1, 3);
-GEN_VXFORM_V(vmaxsb, MO_8, tcg_gen_gvec_smax, 1, 4);
-GEN_VXFORM_V(vmaxsh, MO_16, tcg_gen_gvec_smax, 1, 5);
-GEN_VXFORM_V(vmaxsw, MO_32, tcg_gen_gvec_smax, 1, 6);
-GEN_VXFORM_V(vmaxsd, MO_64, tcg_gen_gvec_smax, 1, 7);
-GEN_VXFORM_V(vminub, MO_8, tcg_gen_gvec_umin, 1, 8);
-GEN_VXFORM_V(vminuh, MO_16, tcg_gen_gvec_umin, 1, 9);
-GEN_VXFORM_V(vminuw, MO_32, tcg_gen_gvec_umin, 1, 10);
-GEN_VXFORM_V(vminud, MO_64, tcg_gen_gvec_umin, 1, 11);
-GEN_VXFORM_V(vminsb, MO_8, tcg_gen_gvec_smin, 1, 12);
-GEN_VXFORM_V(vminsh, MO_16, tcg_gen_gvec_smin, 1, 13);
-GEN_VXFORM_V(vminsw, MO_32, tcg_gen_gvec_smin, 1, 14);
-GEN_VXFORM_V(vminsd, MO_64, tcg_gen_gvec_smin, 1, 15);
 GEN_VXFORM(vmrghb, 6, 0);
 GEN_VXFORM(vmrghh, 6, 1);
 GEN_VXFORM(vmrghw, 6, 2);
@@ -727,6 +711,27 @@ TRANS_FLAGS2(ALTIVEC_207, VEQV, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_eqv);
 TRANS_FLAGS2(ALTIVEC_207, VNAND, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_nand);
 TRANS_FLAGS2(ALTIVEC_207, VORC, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_orc);
 
+/* Integer Max/Min operations */
+TRANS_FLAGS(ALTIVEC, VMAXUB, do_vector_gvec3_VX, MO_8, tcg_gen_gvec_umax);
+TRANS_FLAGS(ALTIVEC, VMAXUH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_umax);
+TRANS_FLAGS(ALTIVEC, VMAXUW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_umax);
+TRANS_FLAGS2(ALTIVEC_207, VMAXUD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_umax);
+
+TRANS_FLAGS(ALTIVEC, VMAXSB, do_vector_gvec3_VX, MO_8, tcg_gen_gvec_smax);
+TRANS_FLAGS(ALTIVEC, VMAXSH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_smax);
+TRANS_FLAGS(ALTIVEC, VMAXSW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_smax);
+TRANS_FLAGS2(ALTIVEC_207, VMAXSD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_smax);
+
+TRANS_FLAGS(ALTIVEC, VMINUB, do_vector_gvec3_VX, MO_8, tcg_gen_gvec_umin);
+TRANS_FLAGS(ALTIVEC, VMINUH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_umin);
+TRANS_FLAGS(ALTIVEC, VMINUW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_umin);
+TRANS_FLAGS2(ALTIVEC_207, VMINUD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_umin);
+
+TRANS_FLAGS(ALTIVEC, VMINSB, do_vector_gvec3_VX, MO_8, tcg_gen_gvec_smin);
+TRANS_FLAGS(ALTIVEC, VMINSH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_smin);
+TRANS_FLAGS(ALTIVEC, VMINSW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_smin);
+TRANS_FLAGS2(ALTIVEC_207, VMINSD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_smin);
+
 static TCGv_vec do_vrl_mask_vec(unsigned vece, TCGv_vec vrb)
 {
     TCGv_vec t0 = tcg_temp_new_vec_matching(vrb),
diff --git a/target/ppc/translate/vmx-ops.c.inc b/target/ppc/translate/vmx-ops.c.inc
index 80c5217749..7bb11b0549 100644
--- a/target/ppc/translate/vmx-ops.c.inc
+++ b/target/ppc/translate/vmx-ops.c.inc
@@ -33,22 +33,6 @@ GEN_VXFORM_DUAL(vsubuhm, bcdsub, 0, 17, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_DUAL(vsubuwm, bcdus, 0, 18, PPC_ALTIVEC, PPC2_ISA300),
 GEN_VXFORM_DUAL(vsubudm, bcds, 0, 19, PPC2_ALTIVEC_207, PPC2_ISA300),
 GEN_VXFORM_300(bcds, 0, 27),
-GEN_VXFORM(vmaxub, 1, 0),
-GEN_VXFORM(vmaxuh, 1, 1),
-GEN_VXFORM(vmaxuw, 1, 2),
-GEN_VXFORM_207(vmaxud, 1, 3),
-GEN_VXFORM(vmaxsb, 1, 4),
-GEN_VXFORM(vmaxsh, 1, 5),
-GEN_VXFORM(vmaxsw, 1, 6),
-GEN_VXFORM_207(vmaxsd, 1, 7),
-GEN_VXFORM(vminub, 1, 8),
-GEN_VXFORM(vminuh, 1, 9),
-GEN_VXFORM(vminuw, 1, 10),
-GEN_VXFORM_207(vminud, 1, 11),
-GEN_VXFORM(vminsb, 1, 12),
-GEN_VXFORM(vminsh, 1, 13),
-GEN_VXFORM(vminsw, 1, 14),
-GEN_VXFORM_207(vminsd, 1, 15),
 GEN_VXFORM(vmrghb, 6, 0),
 GEN_VXFORM(vmrghh, 6, 1),
 GEN_VXFORM(vmrghw, 6, 2),
-- 
2.39.3


