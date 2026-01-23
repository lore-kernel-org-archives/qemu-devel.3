Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4376DD7236C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 11:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjFae-0005f0-M6; Fri, 23 Jan 2026 06:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZV-00050v-5a; Fri, 23 Jan 2026 06:43:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZN-0006xT-VK; Fri, 23 Jan 2026 06:43:24 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N1IehX006240;
 Fri, 23 Jan 2026 11:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=1E0j/ZGTg4KACLHVT
 PGEeHVAmQMEpLs0JPqT6lzOOL8=; b=Pn/IHWysY46whJsE/7tby6iLW6Zqv0eOt
 mkDBqdWz6yUGjN37D+yojEKL2wWflvTjClNHCLrAZ6rfWQ9YOyJKw2rtEYRfxQqQ
 HFvpi0ciO/cN0hTOkV9Ao2PzPsJXu6K0QMLvxgcVbq5xfL5qefE1zrN/9lBiYOnH
 4i3+h/gj75Igbil/wh4Nm8YCQm/GYzYvlROEmytg8GtAMk9VYrA0QsL6gKspEQvg
 m7E4EcxWy1W2G1iLktxzuCTyiOXTzXeMPlWyAHwxkcYbZsR95bE+6kCFDbkbiubz
 9wsYt2UArPcnNH/q54t27OTC7SwWfrS1DROLxLgT5y1XWCNQ9D5SA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23sfqs0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N9GwIO016611;
 Fri, 23 Jan 2026 11:43:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4ygxuu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60NBh8A855968192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jan 2026 11:43:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB35A20043;
 Fri, 23 Jan 2026 11:43:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3C9B2004D;
 Fri, 23 Jan 2026 11:43:08 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.163.22])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jan 2026 11:43:08 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: pbonzini@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@linux.ibm.com,
 frankja@linux.ibm.com
Subject: [PATCH v3 01/14] target/s390x: Rework s390 cpacf implementations
Date: Fri, 23 Jan 2026 12:42:55 +0100
Message-ID: <20260123114308.19401-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123114308.19401-1-freude@linux.ibm.com>
References: <20260123114308.19401-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6bkq1Oz93m63RiRmDeCeKcZFPF_TZjRk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA5MiBTYWx0ZWRfX4T8REFGlPu/w
 cr5jL+04MH6KLYgJtrcTXb/UzAX036dy6O1J77SKB2iTySCdygyPuri3yUvzWp+Q1HUGAnVMKGM
 dbD3qCpUnciEWDhKZ8plvMzBbhYCRFjIi3q91isHeOum/xcXp/fWu/SSF4htIloYVQYyEWZzIt+
 nlde3OKQTEUv3ALj6OFgvQ2Tgc4dEKjDc/UYURsejXVHn6PUqyADrwrJYquYFZEQIixWspBsle4
 zyBTA1YFSlrGfk5LKhZ4tg154JaTR7oaR8dQVgOrciml8/DyPGE86Y5tB82ntrIIti76100Nm7e
 iWRB+o2i3JGHOu3R9wsnrUfTHmvl3g5aPoWYuU+SCtuXndO75bJRK/S5Y+Hpl/DYt3quJAhP77K
 mtUPTB8OW+e3W92/ERBtfGezpqzENz77EhXSNcdtwgR+dnhG7dr5hoEiefxak3E5rsYls5HIm86
 pyhBGNMDNzqQUQSfpGQ==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=69735ed2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=n0GLcnPdRiOQeUnuI50A:9
X-Proofpoint-ORIG-GUID: 6bkq1Oz93m63RiRmDeCeKcZFPF_TZjRk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230092
Received-SPF: pass client-ip=148.163.156.1; envelope-from=freude@linux.ibm.com;
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

Fix missing parts for MSA 9 kdsa and rework the cpacf
handling code so that further extensions can be made in
a clean and structured way.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/tcg/crypto_helper.c | 85 ++++++++++++++++++++++++++------
 target/s390x/tcg/insn-data.h.inc |  1 +
 target/s390x/tcg/translate.c     |  7 +++
 3 files changed, 79 insertions(+), 14 deletions(-)

diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 4447bb66ee..0b00d8ba5b 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -268,6 +268,57 @@ static void fill_buf_random(CPUS390XState *env, uintptr_t ra,
     }
 }
 
+static int cpacf_kimd(CPUS390XState *env, const uintptr_t ra,
+                      uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case 0x03: /* CPACF_KIMD_SHA_512 */
+        rc = cpacf_sha512(env, ra, env->regs[1], &env->regs[r2],
+                          &env->regs[r2 + 1], S390_FEAT_TYPE_KIMD);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return rc;
+}
+
+static int cpacf_klmd(CPUS390XState *env, const uintptr_t ra,
+                      uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case 0x03: /* CPACF_KLMD_SHA_512 */
+        rc = cpacf_sha512(env, ra, env->regs[1], &env->regs[r2],
+                          &env->regs[r2 + 1], S390_FEAT_TYPE_KLMD);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return rc;
+}
+
+static int cpacf_ppno(CPUS390XState *env, uintptr_t ra,
+                      uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case 0x72: /* CPACF_PRNO_TRNG */
+        fill_buf_random(env, ra, &env->regs[r1], &env->regs[r1 + 1]);
+        fill_buf_random(env, ra, &env->regs[r2], &env->regs[r2 + 1]);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return rc;
+}
+
 uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
                      uint32_t type)
 {
@@ -276,14 +327,15 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     const uint8_t fc = env->regs[0] & 0x7fULL;
     uint8_t subfunc[16] = { 0 };
     uint64_t param_addr;
-    int i;
+    int i, rc = 0;
 
     switch (type) {
-    case S390_FEAT_TYPE_KMAC:
+    case S390_FEAT_TYPE_KDSA:
     case S390_FEAT_TYPE_KIMD:
     case S390_FEAT_TYPE_KLMD:
-    case S390_FEAT_TYPE_PCKMO:
+    case S390_FEAT_TYPE_KMAC:
     case S390_FEAT_TYPE_PCC:
+    case S390_FEAT_TYPE_PCKMO:
         if (mod) {
             tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         }
@@ -295,24 +347,29 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
-    switch (fc) {
-    case 0: /* query subfunction */
-        for (i = 0; i < 16; i++) {
+    /* handle query subfunction */
+    if (fc == 0) {
+        for (i = 0; i < sizeof(subfunc); i++) {
             param_addr = wrap_address(env, env->regs[1] + i);
             cpu_stb_data_ra(env, param_addr, subfunc[i], ra);
         }
+        goto out;
+    }
+
+    switch (type) {
+    case S390_FEAT_TYPE_KIMD:
+        rc = cpacf_kimd(env, ra, r1, r2, r3, fc);
         break;
-    case 3: /* CPACF_*_SHA_512 */
-        return cpacf_sha512(env, ra, env->regs[1], &env->regs[r2],
-                            &env->regs[r2 + 1], type);
-    case 114: /* CPACF_PRNO_TRNG */
-        fill_buf_random(env, ra, &env->regs[r1], &env->regs[r1 + 1]);
-        fill_buf_random(env, ra, &env->regs[r2], &env->regs[r2 + 1]);
+    case S390_FEAT_TYPE_KLMD:
+        rc = cpacf_klmd(env, ra, r1, r2, r3, fc);
+        break;
+    case S390_FEAT_TYPE_PPNO:
+        rc = cpacf_ppno(env, ra, r1, r2, r3, fc);
         break;
     default:
-        /* we don't implement any other subfunction yet */
         g_assert_not_reached();
     }
 
-    return 0;
+out:
+    return rc;
 }
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index ec730ee091..b6095711f2 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -1012,6 +1012,7 @@
     D(0xb92e, KM,      RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KM)
     D(0xb92f, KMC,     RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMC)
     D(0xb929, KMA,     RRF_b, MSA8, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMA)
+    D(0xb93a, KDSA,    RRE,   MSA9, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KDSA)
     E(0xb93c, PPNO,    RRE,   MSA5, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PPNO, IF_IO)
     D(0xb93e, KIMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KIMD)
     D(0xb93f, KLMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KLMD)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4d2b8c5e2b..a5fdc05d37 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2565,6 +2565,12 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
     case S390_FEAT_TYPE_PCKMO:
     case S390_FEAT_TYPE_PCC:
         break;
+    case S390_FEAT_TYPE_KDSA:
+        if (r1) {
+            gen_program_exception(s, PGM_SPECIFICATION);
+            return DISAS_NORETURN;
+        }
+        break;
     default:
         g_assert_not_reached();
     };
@@ -6018,6 +6024,7 @@ enum DisasInsnEnum {
 #define FAC_MSA4        S390_FEAT_MSA_EXT_4 /* msa-extension-4 facility */
 #define FAC_MSA5        S390_FEAT_MSA_EXT_5 /* msa-extension-5 facility */
 #define FAC_MSA8        S390_FEAT_MSA_EXT_8 /* msa-extension-8 facility */
+#define FAC_MSA9        S390_FEAT_MSA_EXT_9 /* msa-extension-9 facility */
 #define FAC_ECT         S390_FEAT_EXTRACT_CPU_TIME
 #define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */
 #define FAC_AIS         S390_FEAT_ADAPTER_INT_SUPPRESSION
-- 
2.43.0


