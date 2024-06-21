Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABC0C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 11:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKcix-0006MI-UJ; Fri, 21 Jun 2024 07:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sKciv-0006Kr-BO; Fri, 21 Jun 2024 07:46:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sKcit-0000DA-JE; Fri, 21 Jun 2024 07:46:33 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LBTZvf029725;
 Fri, 21 Jun 2024 11:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=KKKdeG9z56wPF
 h65BgP+t1XvOWpsaQfeAtkwY/JRDxQ=; b=pgoWh5zc+GIeZxLNH+st1pC0K3wXZ
 7GRqMdAlLubdzDXnmue3WqSGoM+RlCMgN7NUAowdYJxd0DJjhKxScClncAWXmg1e
 6V/cKMs9NY1FSS2Hd/vdiXvgkyVuF62gnAqkfaWZO0IfmJbd5FC97Fwjp0kwFMrk
 HQOYE+jG0UvPh0VJN2zzxHnjC9rfYa4/0RJeGSBWN9tlL2TVf4sRjHbhwbHuNvx3
 wYU9fOeKkfJ+kryh9TsU49Cb37aFHj6engQlZ5lPjTgrwtHOfYyjgmQwo68Cr0Js
 ymNCaNcTP1fgXovDupBHAe7egEPjAsUTmDdUhun5bmBjVRyoZKF16ulJg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw8p081a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 11:46:28 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45LBkRIe022784;
 Fri, 21 Jun 2024 11:46:27 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw8p081a0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 11:46:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45L9GIRN007654; Fri, 21 Jun 2024 11:46:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrspew5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 11:46:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45LBkN0w47055300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2024 11:46:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35FE72004B;
 Fri, 21 Jun 2024 11:46:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B9C220040;
 Fri, 21 Jun 2024 11:46:21 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.171.38.80])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Jun 2024 11:46:21 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 1/3] target/ppc: Move get/set_avr64 functions to
 vmx-impl.c.inc.
Date: Fri, 21 Jun 2024 17:16:02 +0530
Message-Id: <20240621114604.868415-2-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240621114604.868415-1-rathc@linux.ibm.com>
References: <20240621114604.868415-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PE9GgsQrQ8vF-tAZm4HGs_Nfb_wDlMCZ
X-Proofpoint-ORIG-GUID: -fvQjiRaxktd4RtBNswzO5sbsKK2bWDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 mlxlogscore=830 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210084
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


