Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B377BCF5389
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bAh-0003yn-SS; Wed, 23 Oct 2024 09:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t3bAf-0003wZ-Vg; Wed, 23 Oct 2024 09:13:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t3bAc-0001U3-SN; Wed, 23 Oct 2024 09:13:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N0O2UO028145;
 Wed, 23 Oct 2024 13:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=k7b411KBmsXzw5E2hdYDLb3wnwfmkeMk8SApMGgKO
 8A=; b=TEsWNdkl0boQq3wESElsPo8PhSpMLBCtj90qg5a78T0vtgSsHfY4ERAmV
 JpsSyjxy6X2iVmHEWXGdSl2boZql2fRCwGYRNCqj8uDgQT8Qqbvj/uL0wq1l+yqi
 gAIuDD5XG8htbDVMN1UknqbnnutO3SnUdcgz+Xb0mIl0wnZMP8Q5Fn+ilo8xJg/y
 Bdhlc37BvfLTE1LTxe5hUvms3bcWzFi591huLMTBNjNi0sQSZv0ZdDiYM6LS3nvJ
 WtW/FPH5pQndRpNNemVZptej5P3M8PsJehOWJJctnz2VYDqNr3IaRYjy3wpYTmpQ
 Uf5rZuV7Uc40Yg6pO+r0Y2hkc/mlw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emafk652-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 13:12:59 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49NDCwY1013554;
 Wed, 23 Oct 2024 13:12:58 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emafk64w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 13:12:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBbnas008769;
 Wed, 23 Oct 2024 13:12:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emkajyds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 13:12:57 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49NDCqnr52822388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 13:12:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6104620043;
 Wed, 23 Oct 2024 13:12:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDC4C20040;
 Wed, 23 Oct 2024 13:12:51 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.38.72])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Oct 2024 13:12:51 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Kewen Lin <linkw@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, John Platts <john_platts@hotmail.com>,
 Fabiano Rosas <farosas@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2] tests/tcg: Replace -mpower8-vector with -mcpu=power8
Date: Wed, 23 Oct 2024 15:12:03 +0200
Message-ID: <20241023131250.48510-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VyLHxVFqFXW2yY7XQw_csEfIb7apoq_y
X-Proofpoint-GUID: aYnag3hpUMGGSJqwh1czKeO9dnLhEv6X
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410230072
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

[1] deprecated -mpower8-vector, resulting in:

    powerpc64-linux-gnu-gcc: warning: switch '-mpower8-vector' is no longer supported
    qemu/tests/tcg/ppc64/vsx_f2i_nan.c:4:15: error: expected ';' before 'float'
        4 | typedef vector float vsx_float32_vec_t;
          |               ^~~~~~

Use -mcpu=power8 instead. In order to properly verify that this works,
one needs a big-endian (the minimum supported CPU for 64-bit
little-endian is power8 anyway) GCC configured with --enable-checking
(see GCC commit e154242724b0 ("[RS6000] Don't pass -many to the
assembler").

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=109987

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
v1: https://lore.kernel.org/qemu-devel/20241021142830.486149-1-iii@linux.ibm.com/
v1 -> v2: Use -mcpu=power8 instead of -mvsx (Richard).

 tests/tcg/ppc64/Makefile.target | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
index 1940886c737..0d058b26006 100644
--- a/tests/tcg/ppc64/Makefile.target
+++ b/tests/tcg/ppc64/Makefile.target
@@ -6,7 +6,7 @@ VPATH += $(SRC_PATH)/tests/tcg/ppc64
 
 config-cc.mak: Makefile
 	$(quiet-@)( \
-	    $(call cc-option,-mpower8-vector,   CROSS_CC_HAS_POWER8_VECTOR); \
+	    $(call cc-option,-mcpu=power8,      CROSS_CC_HAS_CPU_POWER8); \
 	    $(call cc-option,-mpower10,         CROSS_CC_HAS_POWER10)) 3> config-cc.mak
 
 -include config-cc.mak
@@ -23,15 +23,15 @@ run-threadcount: threadcount
 run-plugin-threadcount-with-%:
 	$(call skip-test, $<, "BROKEN (flaky with clang) ")
 
-ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)
+ifneq ($(CROSS_CC_HAS_CPU_POWER8),)
 PPC64_TESTS=bcdsub non_signalling_xscv
 endif
-$(PPC64_TESTS): CFLAGS += -mpower8-vector
+$(PPC64_TESTS): CFLAGS += -mcpu=power8
 
-ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)
+ifneq ($(CROSS_CC_HAS_CPU_POWER8),)
 PPC64_TESTS += vsx_f2i_nan
 endif
-vsx_f2i_nan: CFLAGS += -mpower8-vector -I$(SRC_PATH)/include
+vsx_f2i_nan: CFLAGS += -mcpu=power8 -I$(SRC_PATH)/include
 
 PPC64_TESTS += mtfsf
 PPC64_TESTS += mffsce
-- 
2.47.0


