Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F601C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 09:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA54J-00020x-JB; Thu, 23 May 2024 05:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sA54I-00020H-8w; Thu, 23 May 2024 05:49:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sA54F-0001Vf-Bc; Thu, 23 May 2024 05:49:02 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N8eYxq009194; Thu, 23 May 2024 09:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UNnXlcHRJTUZoi+uip2u3AKQIwuaiC+301omLQnePXQ=;
 b=EZD2NZ6jh+vuB52Nz0PRcsm7aOqn4UBcapwZr6maP6XP+acO8Npm3Xb2fkZpzRW2Yon+
 fk7uqHThnZlZUKc+k0/UIjjDgf9SoqcJW4JjKPv4mLFWwlm6zIQZmvUD/7/yX5ypkVzW
 TwJbfSrmrIoq22KVulq4WCaHTTz7OxOoMlW8Zgkzw0lKFoSZJwT7g0maFqjgjIVygvsq
 b5bbv9smALq3hm9/BTHlM1d2yj7PauNLnbS2tM6eRZQcDUw/zVmAkmFDor8oHBBhN6/V
 754gQsTFWlr9n+mwoGXWImvSCZjco1qu9eP14H50/NHGj5G9KZ5ALN0n4jU/WlIt1ldQ vg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya20rr955-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 09:48:55 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44N9mtZv029651;
 Thu, 23 May 2024 09:48:55 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya20rr953-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 09:48:55 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N6WVAf022112; Thu, 23 May 2024 09:48:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y76nu1hqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 09:48:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44N9moP126935848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 May 2024 09:48:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 820012004D;
 Thu, 23 May 2024 09:48:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CE3120043;
 Thu, 23 May 2024 09:48:49 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 May 2024 09:48:48 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 2/3] target/ppc: Move VSX arithmetic and max/min insns to
 decodetree.
Date: Thu, 23 May 2024 15:18:20 +0530
Message-Id: <20240523094821.124014-3-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240523094821.124014-1-rathc@linux.ibm.com>
References: <20240523094821.124014-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TFs-L5L_qwRAxD2XegpYpSBEa9GiA-9U
X-Proofpoint-ORIG-GUID: FXXrV4Fbcb3KsjqhfBHjiWpo08PhhWxu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_04,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=768 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405230065
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Moving the following instructions to decodetree specification:

	x{s, v}{add, sub, mul, div}{s, d}p	: XX3-form
	xs{max, min}dp, xv{max, min}{s, d}p	: XX3-form

The changes were verfied by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/helper.h                 | 44 ++++++++++----------
 target/ppc/insn32.decode            | 30 ++++++++++++++
 target/ppc/fpu_helper.c             | 44 ++++++++++----------
 target/ppc/translate/vsx-impl.c.inc | 63 +++++++++++++----------------
 target/ppc/translate/vsx-ops.c.inc  | 22 ----------
 5 files changed, 101 insertions(+), 102 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 86f97ee1e7..3b4a0c4674 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -361,12 +361,12 @@ DEF_HELPER_FLAGS_4(bcdsr, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
 DEF_HELPER_FLAGS_4(bcdtrunc, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
 DEF_HELPER_FLAGS_4(bcdutrunc, TCG_CALL_NO_RWG, i32, avr, avr, avr, i32)
 
-DEF_HELPER_4(xsadddp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XSADDDP, void, env, vsr, vsr, vsr)
 DEF_HELPER_5(xsaddqp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_4(xssubdp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsmuldp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XSSUBDP, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XSMULDP, void, env, vsr, vsr, vsr)
 DEF_HELPER_5(xsmulqp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_4(xsdivdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XSDIVDP, void, env, vsr, vsr, vsr)
 DEF_HELPER_5(xsdivqp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_3(xsredp, void, env, vsr, vsr)
 DEF_HELPER_3(xssqrtdp, void, env, vsr, vsr)
@@ -389,8 +389,8 @@ DEF_HELPER_4(xscmpodp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xscmpudp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xscmpoqp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xscmpuqp, void, env, i32, vsr, vsr)
-DEF_HELPER_4(xsmaxdp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsmindp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XSMAXDP, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XSMINDP, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(XSMAXCDP, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(XSMINCDP, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(XSMAXJDP, void, env, vsr, vsr, vsr)
@@ -436,10 +436,10 @@ DEF_HELPER_4(xsrqpxp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xssqrtqp, void, env, i32, vsr, vsr)
 DEF_HELPER_5(xssubqp, void, env, i32, vsr, vsr, vsr)
 
-DEF_HELPER_4(xsaddsp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xssubsp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsmulsp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xsdivsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XSADDSP, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XSSUBSP, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XSMULSP, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XSDIVSP, void, env, vsr, vsr, vsr)
 DEF_HELPER_3(xsresp, void, env, vsr, vsr)
 DEF_HELPER_2(xsrsp, i64, env, i64)
 DEF_HELPER_3(xssqrtsp, void, env, vsr, vsr)
@@ -458,10 +458,10 @@ DEF_HELPER_5(XSNMADDQPO, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(XSNMSUBQP, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(XSNMSUBQPO, void, env, vsr, vsr, vsr, vsr)
 
-DEF_HELPER_4(xvadddp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvsubdp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvmuldp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvdivdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XVADDDP, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XVSUBDP, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XVMULDP, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XVDIVDP, void, env, vsr, vsr, vsr)
 DEF_HELPER_3(xvredp, void, env, vsr, vsr)
 DEF_HELPER_3(xvsqrtdp, void, env, vsr, vsr)
 DEF_HELPER_3(xvrsqrtedp, void, env, vsr, vsr)
@@ -471,8 +471,8 @@ DEF_HELPER_5(xvmadddp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(xvmsubdp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(xvnmadddp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(xvnmsubdp, void, env, vsr, vsr, vsr, vsr)
-DEF_HELPER_4(xvmaxdp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvmindp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XVMAXDP, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XVMINDP, void, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpeqdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpgedp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpgtdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
@@ -492,10 +492,10 @@ DEF_HELPER_3(xvrdpim, void, env, vsr, vsr)
 DEF_HELPER_3(xvrdpip, void, env, vsr, vsr)
 DEF_HELPER_3(xvrdpiz, void, env, vsr, vsr)
 
-DEF_HELPER_4(xvaddsp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvsubsp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvmulsp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvdivsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XVADDSP, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XVSUBSP, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XVMULSP, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XVDIVSP, void, env, vsr, vsr, vsr)
 DEF_HELPER_3(xvresp, void, env, vsr, vsr)
 DEF_HELPER_3(xvsqrtsp, void, env, vsr, vsr)
 DEF_HELPER_3(xvrsqrtesp, void, env, vsr, vsr)
@@ -505,8 +505,8 @@ DEF_HELPER_5(xvmaddsp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(xvmsubsp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(xvnmaddsp, void, env, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(xvnmsubsp, void, env, vsr, vsr, vsr, vsr)
-DEF_HELPER_4(xvmaxsp, void, env, vsr, vsr, vsr)
-DEF_HELPER_4(xvminsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XVMAXSP, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(XVMINSP, void, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpeqsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpgesp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpgtsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index eada59f59f..9ed8e33cc8 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -803,6 +803,28 @@ XVNEGSP         111100 ..... 00000 ..... 110111001 ..   @XX2
 XVCPSGNDP       111100 ..... ..... ..... 11110000 ...   @XX3
 XVCPSGNSP       111100 ..... ..... ..... 11010000 ...   @XX3
 
+## VSX Binary Floating-Point Arithmetic Instructions
+
+XSADDSP         111100 ..... ..... ..... 00000000 ...   @XX3
+XSSUBSP         111100 ..... ..... ..... 00001000 ...   @XX3
+XSMULSP         111100 ..... ..... ..... 00010000 ...   @XX3
+XSDIVSP         111100 ..... ..... ..... 00011000 ...   @XX3
+
+XSADDDP         111100 ..... ..... ..... 00100000 ...   @XX3
+XSSUBDP         111100 ..... ..... ..... 00101000 ...   @XX3
+XSMULDP         111100 ..... ..... ..... 00110000 ...   @XX3
+XSDIVDP         111100 ..... ..... ..... 00111000 ...   @XX3
+
+XVADDSP         111100 ..... ..... ..... 01000000 ...   @XX3
+XVSUBSP         111100 ..... ..... ..... 01001000 ...   @XX3
+XVMULSP         111100 ..... ..... ..... 01010000 ...   @XX3
+XVDIVSP         111100 ..... ..... ..... 01011000 ...   @XX3
+
+XVADDDP         111100 ..... ..... ..... 01100000 ...   @XX3
+XVSUBDP         111100 ..... ..... ..... 01101000 ...   @XX3
+XVMULDP         111100 ..... ..... ..... 01110000 ...   @XX3
+XVDIVDP         111100 ..... ..... ..... 01111000 ...   @XX3
+
 ## VSX Scalar Multiply-Add Instructions
 
 XSMADDADP       111100 ..... ..... ..... 00100001 . . . @XX3
@@ -872,6 +894,14 @@ XSCMPEQQP       111111 ..... ..... ..... 0001000100 -   @X
 XSCMPGEQP       111111 ..... ..... ..... 0011000100 -   @X
 XSCMPGTQP       111111 ..... ..... ..... 0011100100 -   @X
 
+XSMAXDP         111100 ..... ..... ..... 10100000 ...   @XX3
+XSMINDP         111100 ..... ..... ..... 10101000 ...   @XX3
+
+XVMAXSP         111100 ..... ..... ..... 11000000 ...   @XX3
+XVMINSP         111100 ..... ..... ..... 11001000 ...   @XX3
+XVMAXDP         111100 ..... ..... ..... 11100000 ...   @XX3
+XVMINDP         111100 ..... ..... ..... 11101000 ...   @XX3
+
 ## VSX Binary Floating-Point Convert Instructions
 
 XSCVQPDP        111111 ..... 10100 ..... 1101000100 .   @X_tb_rc
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 4b3dcad5d1..a013160644 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -1696,14 +1696,14 @@ void helper_##name(CPUPPCState *env, ppc_vsr_t *xt,                          \
     do_float_check_status(env, sfifprf, GETPC());                            \
 }
 
-VSX_ADD_SUB(xsadddp, add, 1, float64, VsrD(0), 1, 0)
-VSX_ADD_SUB(xsaddsp, add, 1, float64, VsrD(0), 1, 1)
-VSX_ADD_SUB(xvadddp, add, 2, float64, VsrD(i), 0, 0)
-VSX_ADD_SUB(xvaddsp, add, 4, float32, VsrW(i), 0, 0)
-VSX_ADD_SUB(xssubdp, sub, 1, float64, VsrD(0), 1, 0)
-VSX_ADD_SUB(xssubsp, sub, 1, float64, VsrD(0), 1, 1)
-VSX_ADD_SUB(xvsubdp, sub, 2, float64, VsrD(i), 0, 0)
-VSX_ADD_SUB(xvsubsp, sub, 4, float32, VsrW(i), 0, 0)
+VSX_ADD_SUB(XSADDDP, add, 1, float64, VsrD(0), 1, 0)
+VSX_ADD_SUB(XSADDSP, add, 1, float64, VsrD(0), 1, 1)
+VSX_ADD_SUB(XVADDDP, add, 2, float64, VsrD(i), 0, 0)
+VSX_ADD_SUB(XVADDSP, add, 4, float32, VsrW(i), 0, 0)
+VSX_ADD_SUB(XSSUBDP, sub, 1, float64, VsrD(0), 1, 0)
+VSX_ADD_SUB(XSSUBSP, sub, 1, float64, VsrD(0), 1, 1)
+VSX_ADD_SUB(XVSUBDP, sub, 2, float64, VsrD(i), 0, 0)
+VSX_ADD_SUB(XVSUBSP, sub, 4, float32, VsrW(i), 0, 0)
 
 void helper_xsaddqp(CPUPPCState *env, uint32_t opcode,
                     ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)
@@ -1773,10 +1773,10 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                            \
     do_float_check_status(env, sfifprf, GETPC());                            \
 }
 
-VSX_MUL(xsmuldp, 1, float64, VsrD(0), 1, 0)
-VSX_MUL(xsmulsp, 1, float64, VsrD(0), 1, 1)
-VSX_MUL(xvmuldp, 2, float64, VsrD(i), 0, 0)
-VSX_MUL(xvmulsp, 4, float32, VsrW(i), 0, 0)
+VSX_MUL(XSMULDP, 1, float64, VsrD(0), 1, 0)
+VSX_MUL(XSMULSP, 1, float64, VsrD(0), 1, 1)
+VSX_MUL(XVMULDP, 2, float64, VsrD(i), 0, 0)
+VSX_MUL(XVMULSP, 4, float32, VsrW(i), 0, 0)
 
 void helper_xsmulqp(CPUPPCState *env, uint32_t opcode,
                     ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)
@@ -1847,10 +1847,10 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                             \
     do_float_check_status(env, sfifprf, GETPC());                             \
 }
 
-VSX_DIV(xsdivdp, 1, float64, VsrD(0), 1, 0)
-VSX_DIV(xsdivsp, 1, float64, VsrD(0), 1, 1)
-VSX_DIV(xvdivdp, 2, float64, VsrD(i), 0, 0)
-VSX_DIV(xvdivsp, 4, float32, VsrW(i), 0, 0)
+VSX_DIV(XSDIVDP, 1, float64, VsrD(0), 1, 0)
+VSX_DIV(XSDIVSP, 1, float64, VsrD(0), 1, 1)
+VSX_DIV(XVDIVDP, 2, float64, VsrD(i), 0, 0)
+VSX_DIV(XVDIVSP, 4, float32, VsrW(i), 0, 0)
 
 void helper_xsdivqp(CPUPPCState *env, uint32_t opcode,
                     ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)
@@ -2480,12 +2480,12 @@ void helper_##name(CPUPPCState *env, ppc_vsr_t *xt,                           \
     do_float_check_status(env, false, GETPC());                               \
 }
 
-VSX_MAX_MIN(xsmaxdp, maxnum, 1, float64, VsrD(0))
-VSX_MAX_MIN(xvmaxdp, maxnum, 2, float64, VsrD(i))
-VSX_MAX_MIN(xvmaxsp, maxnum, 4, float32, VsrW(i))
-VSX_MAX_MIN(xsmindp, minnum, 1, float64, VsrD(0))
-VSX_MAX_MIN(xvmindp, minnum, 2, float64, VsrD(i))
-VSX_MAX_MIN(xvminsp, minnum, 4, float32, VsrW(i))
+VSX_MAX_MIN(XSMAXDP, maxnum, 1, float64, VsrD(0))
+VSX_MAX_MIN(XVMAXDP, maxnum, 2, float64, VsrD(i))
+VSX_MAX_MIN(XVMAXSP, maxnum, 4, float32, VsrW(i))
+VSX_MAX_MIN(XSMINDP, minnum, 1, float64, VsrD(0))
+VSX_MAX_MIN(XVMINDP, minnum, 2, float64, VsrD(i))
+VSX_MAX_MIN(XVMINSP, minnum, 4, float32, VsrW(i))
 
 #define VSX_MAX_MINC(name, max, tp, fld)                                      \
 void helper_##name(CPUPPCState *env,                                          \
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 6025119e5b..0d16e0f02b 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -864,20 +864,6 @@ static void gen_##name(DisasContext *ctx)                                     \
     gen_helper_##name(tcg_env, opc);                                          \
 }
 
-#define GEN_VSX_HELPER_X3(name, op1, op2, inval, type)                        \
-static void gen_##name(DisasContext *ctx)                                     \
-{                                                                             \
-    TCGv_ptr xt, xa, xb;                                                      \
-    if (unlikely(!ctx->vsx_enabled)) {                                        \
-        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
-        return;                                                               \
-    }                                                                         \
-    xt = gen_vsr_ptr(xT(ctx->opcode));                                        \
-    xa = gen_vsr_ptr(xA(ctx->opcode));                                        \
-    xb = gen_vsr_ptr(xB(ctx->opcode));                                        \
-    gen_helper_##name(tcg_env, xt, xa, xb);                                   \
-}
-
 #define GEN_VSX_HELPER_X2(name, op1, op2, inval, type)                        \
 static void gen_##name(DisasContext *ctx)                                     \
 {                                                                             \
@@ -983,12 +969,8 @@ static void gen_##name(DisasContext *ctx)                     \
     set_cpu_vsr(xT(ctx->opcode), tcg_constant_i64(0), false); \
 }
 
-GEN_VSX_HELPER_X3(xsadddp, 0x00, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_R3(xsaddqp, 0x04, 0x00, 0, PPC2_ISA300)
-GEN_VSX_HELPER_X3(xssubdp, 0x00, 0x05, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsmuldp, 0x00, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_R3(xsmulqp, 0x04, 0x01, 0, PPC2_ISA300)
-GEN_VSX_HELPER_X3(xsdivdp, 0x00, 0x07, 0, PPC2_VSX)
 GEN_VSX_HELPER_R3(xsdivqp, 0x04, 0x11, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X2(xsredp, 0x14, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xssqrtdp, 0x16, 0x04, 0, PPC2_VSX)
@@ -1001,8 +983,6 @@ GEN_VSX_HELPER_X2_AB(xscmpodp, 0x0C, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xscmpudp, 0x0C, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_R2_AB(xscmpoqp, 0x04, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_R2_AB(xscmpuqp, 0x04, 0x14, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsmindp, 0x00, 0x15, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300)
 GEN_VSX_HELPER_X2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
 GEN_VSX_HELPER_R2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
@@ -1233,27 +1213,17 @@ GEN_VSX_HELPER_R2(xsrqpi, 0x05, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_R2(xsrqpxp, 0x05, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_R2(xssqrtqp, 0x04, 0x19, 0x1B, PPC2_ISA300)
 GEN_VSX_HELPER_R3(xssubqp, 0x04, 0x10, 0, PPC2_ISA300)
-GEN_VSX_HELPER_X3(xsaddsp, 0x00, 0x00, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xssubsp, 0x00, 0x01, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsmulsp, 0x00, 0x02, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsdivsp, 0x00, 0x03, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xsresp, 0x14, 0x01, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xssqrtsp, 0x16, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xsrsqrtesp, 0x14, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xscvsxdsp, 0x10, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xscvuxdsp, 0x10, 0x12, 0, PPC2_VSX207)
 
-GEN_VSX_HELPER_X3(xvadddp, 0x00, 0x0C, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvsubdp, 0x00, 0x0D, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmuldp, 0x00, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvdivdp, 0x00, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvredp, 0x14, 0x0D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvsqrtdp, 0x16, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtedp, 0x14, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xvtdivdp, 0x14, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_X1(xvtsqrtdp, 0x14, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmaxdp, 0x00, 0x1C, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmindp, 0x00, 0x1D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvcvdpsp, 0x12, 0x18, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvcvdpsxds, 0x10, 0x1D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvcvdpsxws, 0x10, 0x0D, 0, PPC2_VSX)
@@ -1269,17 +1239,11 @@ GEN_VSX_HELPER_X2(xvrdpim, 0x12, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrdpip, 0x12, 0x0E, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrdpiz, 0x12, 0x0D, 0, PPC2_VSX)
 
-GEN_VSX_HELPER_X3(xvaddsp, 0x00, 0x08, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvsubsp, 0x00, 0x09, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmulsp, 0x00, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvdivsp, 0x00, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvresp, 0x14, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvsqrtsp, 0x16, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtesp, 0x14, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xvtdivsp, 0x14, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_X1(xvtsqrtsp, 0x14, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmaxsp, 0x00, 0x18, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvminsp, 0x00, 0x19, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvcvspdp, 0x12, 0x1C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvcvhpsp, 0x16, 0x1D, 0x18, PPC2_ISA300)
 GEN_VSX_HELPER_X2(xvcvsphp, 0x16, 0x1D, 0x19, PPC2_ISA300)
@@ -2730,6 +2694,33 @@ TRANS_FLAGS2(ISA300, XSMINCDP, do_helper_XX3, gen_helper_XSMINCDP)
 TRANS_FLAGS2(ISA300, XSMAXJDP, do_helper_XX3, gen_helper_XSMAXJDP)
 TRANS_FLAGS2(ISA300, XSMINJDP, do_helper_XX3, gen_helper_XSMINJDP)
 
+TRANS_FLAGS2(VSX207, XSADDSP, do_helper_XX3, gen_helper_XSADDSP)
+TRANS_FLAGS2(VSX207, XSSUBSP, do_helper_XX3, gen_helper_XSSUBSP)
+TRANS_FLAGS2(VSX207, XSMULSP, do_helper_XX3, gen_helper_XSMULSP)
+TRANS_FLAGS2(VSX207, XSDIVSP, do_helper_XX3, gen_helper_XSDIVSP)
+
+TRANS_FLAGS2(VSX, XSADDDP, do_helper_XX3, gen_helper_XSADDDP)
+TRANS_FLAGS2(VSX, XSSUBDP, do_helper_XX3, gen_helper_XSSUBDP)
+TRANS_FLAGS2(VSX, XSMULDP, do_helper_XX3, gen_helper_XSMULDP)
+TRANS_FLAGS2(VSX, XSDIVDP, do_helper_XX3, gen_helper_XSDIVDP)
+
+TRANS_FLAGS2(VSX, XVADDSP, do_helper_XX3, gen_helper_XVADDSP)
+TRANS_FLAGS2(VSX, XVSUBSP, do_helper_XX3, gen_helper_XVSUBSP)
+TRANS_FLAGS2(VSX, XVMULSP, do_helper_XX3, gen_helper_XVMULSP)
+TRANS_FLAGS2(VSX, XVDIVSP, do_helper_XX3, gen_helper_XVDIVSP)
+
+TRANS_FLAGS2(VSX, XVADDDP, do_helper_XX3, gen_helper_XVADDDP)
+TRANS_FLAGS2(VSX, XVSUBDP, do_helper_XX3, gen_helper_XVSUBDP)
+TRANS_FLAGS2(VSX, XVMULDP, do_helper_XX3, gen_helper_XVMULDP)
+TRANS_FLAGS2(VSX, XVDIVDP, do_helper_XX3, gen_helper_XVDIVDP)
+
+TRANS_FLAGS2(VSX, XSMAXDP, do_helper_XX3, gen_helper_XSMAXDP)
+TRANS_FLAGS2(VSX, XSMINDP, do_helper_XX3, gen_helper_XSMINDP)
+TRANS_FLAGS2(VSX, XVMAXSP, do_helper_XX3, gen_helper_XVMAXSP)
+TRANS_FLAGS2(VSX, XVMINSP, do_helper_XX3, gen_helper_XVMINSP)
+TRANS_FLAGS2(VSX, XVMAXDP, do_helper_XX3, gen_helper_XVMAXDP)
+TRANS_FLAGS2(VSX, XVMINDP, do_helper_XX3, gen_helper_XVMINDP)
+
 static bool do_helper_X(arg_X *a,
     void (*helper)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr))
 {
diff --git a/target/ppc/translate/vsx-ops.c.inc b/target/ppc/translate/vsx-ops.c.inc
index a3ba094d62..18510d757d 100644
--- a/target/ppc/translate/vsx-ops.c.inc
+++ b/target/ppc/translate/vsx-ops.c.inc
@@ -153,12 +153,8 @@ GEN_XX2FORM_EO(xvxexpdp, 0x16, 0x1D, 0x00, PPC2_ISA300),
 GEN_XX2FORM_EO(xvxsigdp, 0x16, 0x1D, 0x01, PPC2_ISA300),
 GEN_XX2FORM_EO(xvxexpsp, 0x16, 0x1D, 0x08, PPC2_ISA300),
 
-GEN_XX3FORM(xsadddp, 0x00, 0x04, PPC2_VSX),
 GEN_VSX_XFORM_300(xsaddqp, 0x04, 0x00, 0x0),
-GEN_XX3FORM(xssubdp, 0x00, 0x05, PPC2_VSX),
-GEN_XX3FORM(xsmuldp, 0x00, 0x06, PPC2_VSX),
 GEN_VSX_XFORM_300(xsmulqp, 0x04, 0x01, 0x0),
-GEN_XX3FORM(xsdivdp, 0x00, 0x07, PPC2_VSX),
 GEN_XX2FORM(xsredp,  0x14, 0x05, PPC2_VSX),
 GEN_XX2FORM(xssqrtdp,  0x16, 0x04, PPC2_VSX),
 GEN_XX2FORM(xsrsqrtedp,  0x14, 0x04, PPC2_VSX),
@@ -170,8 +166,6 @@ GEN_XX2IFORM(xscmpodp,  0x0C, 0x05, PPC2_VSX),
 GEN_XX2IFORM(xscmpudp,  0x0C, 0x04, PPC2_VSX),
 GEN_VSX_XFORM_300(xscmpoqp, 0x04, 0x04, 0x00600001),
 GEN_VSX_XFORM_300(xscmpuqp, 0x04, 0x14, 0x00600001),
-GEN_XX3FORM(xsmaxdp, 0x00, 0x14, PPC2_VSX),
-GEN_XX3FORM(xsmindp, 0x00, 0x15, PPC2_VSX),
 GEN_XX2FORM_EO(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300),
 GEN_XX2FORM(xscvdpsp, 0x12, 0x10, PPC2_VSX),
 GEN_XX2FORM(xscvdpspn, 0x16, 0x10, PPC2_VSX207),
@@ -191,10 +185,6 @@ GEN_XX2FORM(xsrdpim, 0x12, 0x07, PPC2_VSX),
 GEN_XX2FORM(xsrdpip, 0x12, 0x06, PPC2_VSX),
 GEN_XX2FORM(xsrdpiz, 0x12, 0x05, PPC2_VSX),
 
-GEN_XX3FORM(xsaddsp, 0x00, 0x00, PPC2_VSX207),
-GEN_XX3FORM(xssubsp, 0x00, 0x01, PPC2_VSX207),
-GEN_XX3FORM(xsmulsp, 0x00, 0x02, PPC2_VSX207),
-GEN_XX3FORM(xsdivsp, 0x00, 0x03, PPC2_VSX207),
 GEN_VSX_XFORM_300(xsdivqp, 0x04, 0x11, 0x0),
 GEN_XX2FORM(xsresp,  0x14, 0x01, PPC2_VSX207),
 GEN_XX2FORM(xsrsp, 0x12, 0x11, PPC2_VSX207),
@@ -203,10 +193,6 @@ GEN_XX2FORM(xsrsqrtesp,  0x14, 0x00, PPC2_VSX207),
 GEN_XX2FORM(xscvsxdsp, 0x10, 0x13, PPC2_VSX207),
 GEN_XX2FORM(xscvuxdsp, 0x10, 0x12, PPC2_VSX207),
 
-GEN_XX3FORM(xvadddp, 0x00, 0x0C, PPC2_VSX),
-GEN_XX3FORM(xvsubdp, 0x00, 0x0D, PPC2_VSX),
-GEN_XX3FORM(xvmuldp, 0x00, 0x0E, PPC2_VSX),
-GEN_XX3FORM(xvdivdp, 0x00, 0x0F, PPC2_VSX),
 GEN_XX2FORM(xvredp,  0x14, 0x0D, PPC2_VSX),
 GEN_XX2FORM(xvsqrtdp,  0x16, 0x0C, PPC2_VSX),
 GEN_XX2FORM(xvrsqrtedp,  0x14, 0x0C, PPC2_VSX),
@@ -220,8 +206,6 @@ GEN_XX3FORM_NAME(xvnmadddp, "xvnmaddadp", 0x04, 0x1C, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmadddp, "xvnmaddmdp", 0x04, 0x1D, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmsubdp, "xvnmsubadp", 0x04, 0x1E, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmsubdp, "xvnmsubmdp", 0x04, 0x1F, PPC2_VSX),
-GEN_XX3FORM(xvmaxdp, 0x00, 0x1C, PPC2_VSX),
-GEN_XX3FORM(xvmindp, 0x00, 0x1D, PPC2_VSX),
 GEN_XX3_RC_FORM(xvcmpeqdp, 0x0C, 0x0C, PPC2_VSX),
 GEN_XX3_RC_FORM(xvcmpgtdp, 0x0C, 0x0D, PPC2_VSX),
 GEN_XX3_RC_FORM(xvcmpgedp, 0x0C, 0x0E, PPC2_VSX),
@@ -241,10 +225,6 @@ GEN_XX2FORM(xvrdpim, 0x12, 0x0F, PPC2_VSX),
 GEN_XX2FORM(xvrdpip, 0x12, 0x0E, PPC2_VSX),
 GEN_XX2FORM(xvrdpiz, 0x12, 0x0D, PPC2_VSX),
 
-GEN_XX3FORM(xvaddsp, 0x00, 0x08, PPC2_VSX),
-GEN_XX3FORM(xvsubsp, 0x00, 0x09, PPC2_VSX),
-GEN_XX3FORM(xvmulsp, 0x00, 0x0A, PPC2_VSX),
-GEN_XX3FORM(xvdivsp, 0x00, 0x0B, PPC2_VSX),
 GEN_XX2FORM(xvresp, 0x14, 0x09, PPC2_VSX),
 GEN_XX2FORM(xvsqrtsp, 0x16, 0x08, PPC2_VSX),
 GEN_XX2FORM(xvrsqrtesp, 0x14, 0x08, PPC2_VSX),
@@ -258,8 +238,6 @@ GEN_XX3FORM_NAME(xvnmaddsp, "xvnmaddasp", 0x04, 0x18, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmaddsp, "xvnmaddmsp", 0x04, 0x19, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmsubsp, "xvnmsubasp", 0x04, 0x1A, PPC2_VSX),
 GEN_XX3FORM_NAME(xvnmsubsp, "xvnmsubmsp", 0x04, 0x1B, PPC2_VSX),
-GEN_XX3FORM(xvmaxsp, 0x00, 0x18, PPC2_VSX),
-GEN_XX3FORM(xvminsp, 0x00, 0x19, PPC2_VSX),
 GEN_XX3_RC_FORM(xvcmpeqsp, 0x0C, 0x08, PPC2_VSX),
 GEN_XX3_RC_FORM(xvcmpgtsp, 0x0C, 0x09, PPC2_VSX),
 GEN_XX3_RC_FORM(xvcmpgesp, 0x0C, 0x0A, PPC2_VSX),
-- 
2.39.3


