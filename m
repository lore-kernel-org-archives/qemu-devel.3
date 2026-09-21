Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A64C982FA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kJn-0005ho-2M; Mon, 21 Sep 2026 16:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kJc-0005eY-55; Mon, 21 Sep 2026 16:08:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kJa-0005Kg-Eh; Mon, 21 Sep 2026 16:08:39 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8Lol1903077; Mon, 21 Sep 2026 20:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=QICLEegwFNDENGLoh
 U3G9EssSt6EnRiOx8sK4cnQN5Y=; b=GWf9JrjZjkmlakQbFoMsixYHs5cozgGVB
 5QuzK+sl3c4yBGowimBWlhBkkFNzAW8Ps0/0z1aG4ppm0gW+iUO0Qfd6cZUrnqPK
 cO34UwFKfEbOdHunTVqMVIYS2htRYbqVwYx1eZlgrSMPb60SE3TlmzWsnMtHkNl9
 /fESr7zryWJlp8QUL5fiCoe0ywHGCoMvsdHdST7M4Yi9D3yY4OYA1Yw9UfVDdEx2
 7qzwDk0SI3Jr3d9kDPkQYX/OOhm/Mq5V0XX+UaCRHaUROmbzA4MTa4cdJ1XlJ2dz
 +cTPKDki5YOIYSVdla16EZLeToMdlyXNSRIqsPbISl13DRLBCUXWg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv2bd8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LJEQDZ167302; Mon, 21 Sep 2026 20:08:36 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bk9eyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LK8ZtJ29098692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 20:08:35 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 492F858059;
 Mon, 21 Sep 2026 20:08:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C43C758043;
 Mon, 21 Sep 2026 20:08:34 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.69.195]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 20:08:34 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 06/33] target/s390x: Adjust addressing mode checks for sha512
 and sha256
Date: Mon, 21 Sep 2026 16:08:03 -0400
Message-ID: <20260921200830.1302919-7-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921200830.1302919-1-farman@linux.ibm.com>
References: <20260921200830.1302919-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f7D2eAxCtKLNgijORiUQcZ6zwwBWQp2m
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX9rpCryctbtam
 UMLmT7bXbxSCalWDdHceGos76ElQ5neo3tWFUPGeZlS3QI5G3IQkKP/1aZFDYv6V8HVekTLPEXH
 43Ttb3e6Gjw+1ivFf8ujkUPZNhGhZXA=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab18ec5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ZpfFLUfXnHEdiUPoyBIA:9
X-Proofpoint-GUID: f7D2eAxCtKLNgijORiUQcZ6zwwBWQp2m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX9z2gd64LXed5
 hYiUh3Hi97DlPeWk+NOmEGzdt7NZDmm3uXqIfoKonfxRXwSDzgGYoEPWMl4oIqaqzOyWUtc4Bz6
 n9q4EFqJyhYSIgZEy2DVyb3LHm5/GqgfmvqmzQ6vlKgwmw/NhuJR5LRvFInWQqFkjFAfayg/6T0
 FRD8ZDOodn2NleJK3pNDfPxD7feaJfR3YIyhY7ccK3IFnGBvuj1Ha8yrT7tJAPDXvkOuX7gK8/C
 GzLdhQYJeVTGGQSprBzToP47F8U1VI+f6AJK0aGw91zKe60nxa91QQZ3IJI61d+j4hMlDEVjocf
 Pzj7MXi0kwKPeK4kT58mjm+GlKgDccivc1HDOwiPXTFOWzZIJ7dz92HSuSto5ogjY2ckR/n1uOq
 9hTprd3/lajmkEepDFRJOGNWgAMkCrFaubgK4TWImwIHoCFLddUxPi/Mll0VmFN0QZHDQC9CGZX
 Wk/fwyTOvuOOQzAlW+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210294
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Harald Freudenberger <freude@linux.ibm.com>

The handling for different addressing modes in the both sha
implementations cpacf sha256 and sha512 was incomplete. Rework this
addressing checking to clearly have support for s390 64 bit and 32 bit
addressing mode but raise an exception otherwise.

Also bail out early (for KIMD only) if length is 0.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260824083204.40877-7-freude@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
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
2.55.0


