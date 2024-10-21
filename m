Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09561D15D8F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 14:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2tOt-0002OL-GH; Mon, 21 Oct 2024 10:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t2tOo-0002NT-0Y; Mon, 21 Oct 2024 10:28:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t2tOi-0007n7-U8; Mon, 21 Oct 2024 10:28:44 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L2KvGW027383;
 Mon, 21 Oct 2024 14:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=bqwWZzzMOEI41IeBqZVe8QOOCXoo4V6/c5GMOysKS
 lo=; b=jGaEHGgqR4EEazk8bBAnEdn9b1Ojza1LYlLlk2T10volrXbcH7H6pS95f
 EeZ3NRuTdAr1R7B9i9grCmOLU8GFirXHma+mEA3QQX01hh0qEKGLhWg7eEFqiMiY
 n6Sqmp+DnJjLH2N9lsJlHqaUWqgjFkq9L2rPxQJwh5vey7TCpizSPTCvtGFjMlYx
 pTHrBbu+nN2/oIxpQoSsyJvX7J0u57pig1cWqMWxvumLIHLZW589EF5qWlzR5Fyl
 ypgt4J529wR7qgoulp6Gs1bHJ7Djzz3paObNsYduuy3gXJqWYjaMGq0/W3mg3r5B
 DqRdlFB48k0IAfX4mS6ORvK8j24Vg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5eu99h5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Oct 2024 14:28:36 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49LERGH5007071;
 Mon, 21 Oct 2024 14:28:36 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5eu99h3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Oct 2024 14:28:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49LCBBve029398;
 Mon, 21 Oct 2024 14:28:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42crkjxnjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Oct 2024 14:28:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49LESVLu33227354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Oct 2024 14:28:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CEED72004D;
 Mon, 21 Oct 2024 14:28:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F8C120040;
 Mon, 21 Oct 2024 14:28:31 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.27.206])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Oct 2024 14:28:31 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Kewen Lin <linkw@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] tests/tcg: Replace -mpower8-vector with -mvsx
Date: Mon, 21 Oct 2024 16:27:48 +0200
Message-ID: <20241021142830.486149-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rGFEVGVtUg2cgD4Bl2wtCcLWLnqRy_PL
X-Proofpoint-ORIG-GUID: fyr50dFUKCs9OkQR_VcYxEJ_wO4i_2sl
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210098
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Similar to how this was done for the GCC testcases, replace
-mpower8-vector with -mvsx.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=109987

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/ppc64/Makefile.target | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
index 1940886c737..d1b00d2bf09 100644
--- a/tests/tcg/ppc64/Makefile.target
+++ b/tests/tcg/ppc64/Makefile.target
@@ -6,7 +6,7 @@ VPATH += $(SRC_PATH)/tests/tcg/ppc64
 
 config-cc.mak: Makefile
 	$(quiet-@)( \
-	    $(call cc-option,-mpower8-vector,   CROSS_CC_HAS_POWER8_VECTOR); \
+	    $(call cc-option,-mvsx,             CROSS_CC_HAS_VSX); \
 	    $(call cc-option,-mpower10,         CROSS_CC_HAS_POWER10)) 3> config-cc.mak
 
 -include config-cc.mak
@@ -23,15 +23,15 @@ run-threadcount: threadcount
 run-plugin-threadcount-with-%:
 	$(call skip-test, $<, "BROKEN (flaky with clang) ")
 
-ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)
+ifneq ($(CROSS_CC_HAS_VSX),)
 PPC64_TESTS=bcdsub non_signalling_xscv
 endif
-$(PPC64_TESTS): CFLAGS += -mpower8-vector
+$(PPC64_TESTS): CFLAGS += -mvsx
 
-ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)
+ifneq ($(CROSS_CC_HAS_VSX),)
 PPC64_TESTS += vsx_f2i_nan
 endif
-vsx_f2i_nan: CFLAGS += -mpower8-vector -I$(SRC_PATH)/include
+vsx_f2i_nan: CFLAGS += -mvsx -I$(SRC_PATH)/include
 
 PPC64_TESTS += mtfsf
 PPC64_TESTS += mffsce
-- 
2.47.0


