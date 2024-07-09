Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B63AC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9GN-0001GO-Qv; Tue, 09 Jul 2024 07:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sR9GL-000160-5I; Tue, 09 Jul 2024 07:44:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sR9GI-0004so-Ot; Tue, 09 Jul 2024 07:44:00 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469BQO7L002214;
 Tue, 9 Jul 2024 11:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=+XDrg+jzpjHhV
 6ikPpL91Za8N+89EhF0bS8U75IHCcI=; b=DDHKakQG+5Cjy3pOSMNWMP0loQGEF
 tcaWE22IOuoTKR75bbTJNljoJnC8+i2JoUuMkeIatSNKcV8Pq+xZppUhmSe8KBHU
 TBARzw9Zvi9OQh/jz/FVOw5Bo8H6M+u2y70zP+WMMWF8EvLwvj9c1swoiPMJOo6l
 Tg9wZYykS9yfP9vR0hMW7WonWFPrIUSPSdSElv7rk6+vy864mXG5DiJuE4oCwIfI
 FnxL7CUxHK4keLIRZB61Qvw/C3NRQ4X3Lr7yaG1+mO2GLIDBScSCaFMIrT3Z51VP
 8JoecjTqBCmGPq2d7gYoViQ866Fp73ldJNWJKSWBrOfrMkEO+zgG+GRrA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 409325885t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jul 2024 11:43:55 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469BhsDa028486;
 Tue, 9 Jul 2024 11:43:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 409325885r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jul 2024 11:43:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 469BfDTS013986; Tue, 9 Jul 2024 11:43:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407h8pm94m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jul 2024 11:43:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 469BhnIu54919478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jul 2024 11:43:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0B2120043;
 Tue,  9 Jul 2024 11:43:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 624CA20040;
 Tue,  9 Jul 2024 11:43:48 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jul 2024 11:43:48 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v3 1/3] target/ppc: Move get/set_avr64 functions to
 vmx-impl.c.inc.
Date: Tue,  9 Jul 2024 17:13:39 +0530
Message-Id: <20240709114341.152175-2-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240709114341.152175-1-rathc@linux.ibm.com>
References: <20240709114341.152175-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UGRS7TymDUHmdRSRU2AmDDFr39KHp1NN
X-Proofpoint-GUID: 1qwp4luaBRs1qf0B1-ZmJ07-0M_xptg9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=850 priorityscore=1501
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090077
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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

Those functions are used to ld/st data to and from Altivec registers,
in 64 bits chunks, and are only used in vmx-impl.c.inc file,
hence the clean-up movement.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/translate.c              | 10 ----------
 target/ppc/translate/vmx-impl.c.inc | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ad512e1922..f7f2c2db9e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6200,16 +6200,6 @@ static inline void set_fpr(int regno, TCGv_i64 src)
     tcg_gen_st_i64(tcg_constant_i64(0), tcg_env, vsr64_offset(regno, false));
 }
 
-static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
-{
-    tcg_gen_ld_i64(dst, tcg_env, avr64_offset(regno, high));
-}
-
-static inline void set_avr64(int regno, TCGv_i64 src, bool high)
-{
-    tcg_gen_st_i64(src, tcg_env, avr64_offset(regno, high));
-}
-
 /*
  * Helpers for decodetree used by !function for decoding arguments.
  */
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index 152bcde0e3..a182d2cf81 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -14,6 +14,16 @@ static inline TCGv_ptr gen_avr_ptr(int reg)
     return r;
 }
 
+static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
+{
+    tcg_gen_ld_i64(dst, tcg_env, avr64_offset(regno, high));
+}
+
+static inline void set_avr64(int regno, TCGv_i64 src, bool high)
+{
+    tcg_gen_st_i64(src, tcg_env, avr64_offset(regno, high));
+}
+
 static bool trans_LVX(DisasContext *ctx, arg_X *a)
 {
     TCGv EA;
-- 
2.39.3


