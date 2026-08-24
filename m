Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556B8C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyQ6U-0002bR-SM; Mon, 24 Aug 2026 04:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wyQ6P-0002XT-Aq; Mon, 24 Aug 2026 04:32:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wyQ6L-0005AW-SZ; Mon, 24 Aug 2026 04:32:21 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O5WFEC858644; Mon, 24 Aug 2026 08:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=aRvARu0ajlqM4piDI
 Td7K2rBygg6kppEPJw7iMAJOlM=; b=fN1sskmgbrXB2BR3fVQ+4H/+uZ2TGsxji
 g+zCIo4oGuFxkjIT0Yp2KfXYA6pdN+3oJJxRZfOemV51czsRzhVkVymtiYdGfp1O
 bEtuawDn34O9hRMDvArlz/n5Hiv43VyZBejvXZxlrONqfmQuYlPbKfuT1y492FYz
 K4bC8LZYPG7c9KfTWWVsd7BkMHdzdZNEzkFzm2yG/XJjvqKvCf0xzAIRMK/kfjXb
 nFQ8LM2PF9EA0S+rR3OmsvDYWiVCXCUmyppDyABt2xljx14E1k4oW3azrW7FJvSn
 vaXovalWjshqpICGJcihS/zDkIpqoL0Q2P220xUB6U2bNvM7qo4SA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hgax3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 08:32:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8QHhT014770;
 Mon, 24 Aug 2026 08:32:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3pvyv8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 08:32:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67O8W6NI35586460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 08:32:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C18A720043;
 Mon, 24 Aug 2026 08:32:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97EAA2004B;
 Mon, 24 Aug 2026 08:32:06 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.131.174])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 08:32:06 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v16 06/20] target/s390x: Adjust addressing mode checks for
 sha512 and sha256
Date: Mon, 24 Aug 2026 10:31:50 +0200
Message-ID: <20260824083204.40877-7-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824083204.40877-1-freude@linux.ibm.com>
References: <20260824083204.40877-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX+04AJMxhi9Xd
 1XpYTH9ttwtlb4/QsVlsZqsqBCjmCxtspQDTPAsUokCFanyVWbePH6HtRB33d8awcsUljKjg4ct
 sebmtmhidE9slFmtP1lZGx+HglWi0sM=
X-Proofpoint-GUID: v22AKTaigAgv6q_Xw7fEH-mqenl8N5x2
X-Proofpoint-ORIG-GUID: v22AKTaigAgv6q_Xw7fEH-mqenl8N5x2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX82ssCj0Bq89k
 AT+t8cydAEpQBJuVne415sL7Rkel/Y/pWanLy0W8GcIVXbZEAxtyB0+yoV5MqA3ypch/dNRpW/v
 SAy8rx+iNutcc5A5JnA+vJUxGJ0J0vfnJUPhTSTkcXtO9c6IXGjUGoVn5JdpELEBNalQY4dtWgt
 MyKDNncnYFB1nayhUnYnOTPBB3NJYK1K+dU1a3lthPGfhzt9V3C1rTVxcKbZ2PN1s3t+brAAenL
 zxVeI/jSXZtKTRPz2R0t7t+wkkUzj6wL5da37o2fq73zvCRrRxRdP5xeCIe0nW2cOLRWyMFzmA7
 MQ7tl9EtVe0jkOy89x5ABwnFejD8GQT+pBtkPCnPSQFv8jkcrRKf/lOKv0r093+MnINHgW+3IfW
 lunEyNqaCPcLFdZU/pMmO/sCeDKMgTOQIhJevkaEgXMFCPP48DRBM9ENMyv4A9ksg9smNmoKSQU
 RB7ThAtqOAjAfIasU1w==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8c018b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=2oDd-pRd1qGgCFYxvY4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240074
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

The handling for different addressing modes in the both sha
implementations cpacf sha256 and sha512 was incomplete. Rework this
addressing checking to clearly have support for s390 64 bit and 32 bit
addressing mode but raise an exception otherwise.

Also bail out early (for KIMD only) if length is 0.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/cpacf_sha256.c | 16 +++++++++++++---
 target/s390x/tcg/cpacf_sha512.c | 16 +++++++++++++---
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/target/s390x/tcg/cpacf_sha256.c b/target/s390x/tcg/cpacf_sha256.c
index 67321b565c..de305b6838 100644
--- a/target/s390x/tcg/cpacf_sha256.c
+++ b/target/s390x/tcg/cpacf_sha256.c
@@ -111,14 +111,24 @@ int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 128 }; /* 128 * 64 = 8K */
     uint64_t len = *len_reg, processed = 0;
-    int message_reg_len = 64;
+    int message_reg_len;
     uint32_t a[8];
 
     g_assert(type == S390_FEAT_TYPE_KIMD || type == S390_FEAT_TYPE_KLMD);
 
-    if (!(env->psw.mask & PSW_MASK_64)) {
+    /* check addressing mode, raise exception if not supported here */
+    if (env->psw.mask & PSW_MASK_64) {
+        message_reg_len = 64;
+    } else if (env->psw.mask & PSW_MASK_32) {
+        message_reg_len = 32;
         len = (uint32_t)len;
-        message_reg_len = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
+    } else {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    /* for KIMD only: early bail out if length is zero */
+    if (type == S390_FEAT_TYPE_KIMD && !len) {
+        return 0;
     }
 
     /* KIMD: length has to be properly aligned. */
diff --git a/target/s390x/tcg/cpacf_sha512.c b/target/s390x/tcg/cpacf_sha512.c
index edd8dae78f..cad8e0e1bd 100644
--- a/target/s390x/tcg/cpacf_sha512.c
+++ b/target/s390x/tcg/cpacf_sha512.c
@@ -126,13 +126,23 @@ int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 64 }; /* Arbitrary: keep interactivity. */
     uint64_t len = *len_reg, a[8], processed = 0;
-    int message_reg_len = 64;
+    int message_reg_len;
 
     g_assert(type == S390_FEAT_TYPE_KIMD || type == S390_FEAT_TYPE_KLMD);
 
-    if (!(env->psw.mask & PSW_MASK_64)) {
+    /* check addressing mode, raise exception if not supported here */
+    if (env->psw.mask & PSW_MASK_64) {
+        message_reg_len = 64;
+    } else if (env->psw.mask & PSW_MASK_32) {
+        message_reg_len = 32;
         len = (uint32_t)len;
-        message_reg_len = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
+    } else {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    /* for KIMD only: early bail out if length is zero */
+    if (type == S390_FEAT_TYPE_KIMD && !len) {
+        return 0;
     }
 
     /* KIMD: length has to be properly aligned. */
-- 
2.43.0


