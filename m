Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54782CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 07:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPbFt-0006YX-OY; Wed, 20 May 2026 03:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wPbEt-0006De-M0; Wed, 20 May 2026 03:21:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wPbEp-0002T0-64; Wed, 20 May 2026 03:21:10 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K6K6Fo2562204; Wed, 20 May 2026 07:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6Syxy2UAX0dzS6aBy
 iyXvfDNMURuoKfM2nfhdpxwjss=; b=EXYIf1yMdysx2rkoQWYOdGIksKZIdrtRY
 AhtA2Oo12X585onKKza42HbVzsnYtUHl307AQC1YqLhjpgAWp6I6qXGuBHrLhp6B
 PnS7qKzBAPwviWdFlPgK/mr1VmU4yaUkDjv2YcrGGsa6fCDIrx5grpPIiZqNSR5g
 zo7KeitOkxtFlgpcWTkjxMmKX/L0mF7Lmrn2rS+xnhe4SRHuwNuEqKn2pdCskTnk
 0k/WvoYWOdQyvd6JbR51IfBciAXS1pieVd8GDAVBQG5sOu9NHD9C8vr0rjoKBxRA
 EDMOGoVdmtp0tYI34wAsC1u7iT6nLWhEBpi9MYU13tTDPgAXSmrVA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88fxdd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 07:20:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K79GI6029148;
 Wed, 20 May 2026 07:20:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhp7jw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 07:20:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64K7Kt1P53477840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 07:20:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2887F20040;
 Wed, 20 May 2026 07:20:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0823B2004B;
 Wed, 20 May 2026 07:20:55 +0000 (GMT)
Received: from funtu2.fritz.box (unknown [9.111.209.15])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 07:20:54 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com
Subject: [PATCH v5 01/15] target/s390x: Rework s390 cpacf implementations
Date: Wed, 20 May 2026 09:20:40 +0200
Message-ID: <20260520072054.293306-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520072054.293306-1-freude@linux.ibm.com>
References: <20260520072054.293306-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: csIG5o5NxO1cVdgVQBbikxskCX9zN4OM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2NyBTYWx0ZWRfXzx4KdBRDP4YP
 l31tMpvItEY1w1hGqiivMLpOZkBljQooErPFp0KhmwliCQKhkgtBjPb0TLxB4G0IQ00J8xxM8SB
 h6Q+lU22LRDp0nTfbuZ1bHzhehptbhIqA4DpNu4gW75c86mkvSBIcrAdJv62vtLleFjPuKATC/l
 lmX0SwwE6FtOM8bVBXfRbXp0SJyPNB5JHe+hLaPs+T8gBUM3Ebw5x0Ij7+BEXuCwbxqQPAjq4w9
 z1/Dvd7QL4vIgGb/xn7Xl9IECh1NJz4qDqh4r2iWmJakCist6BJKSn82g/1I2mrkBWEtBBCcdfA
 GKffFQ+v18Fu0kI+w7op5eKYYC0llcReHKgJQqnF0EZbwpnRW1bnACjQ3c/ru17ROXwynnpUiBw
 hOmuBfHcjvm0MMglo+sFhGrkn4c7CtY75mkkBuN4+AIlS4XcehTECImJ08AYJRiRZYS5NlywzfR
 qjN67NDsEfeOdaZaMkw==
X-Proofpoint-GUID: csIG5o5NxO1cVdgVQBbikxskCX9zN4OM
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0d60db cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=n0GLcnPdRiOQeUnuI50A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200067
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Fix missing parts for MSA 9 kdsa and rework the cpacf
handling code so that further extensions can be made in
a clean and structured way.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
---
 target/s390x/tcg/crypto_helper.c | 85 ++++++++++++++++++++++++++------
 target/s390x/tcg/insn-data.h.inc |  1 +
 target/s390x/tcg/translate.c     |  2 +
 3 files changed, 74 insertions(+), 14 deletions(-)

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
index 4d2b8c5e2b..8ddd0975f8 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2564,6 +2564,7 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
         /* FALL THROUGH */
     case S390_FEAT_TYPE_PCKMO:
     case S390_FEAT_TYPE_PCC:
+    case S390_FEAT_TYPE_KDSA:
         break;
     default:
         g_assert_not_reached();
@@ -6018,6 +6019,7 @@ enum DisasInsnEnum {
 #define FAC_MSA4        S390_FEAT_MSA_EXT_4 /* msa-extension-4 facility */
 #define FAC_MSA5        S390_FEAT_MSA_EXT_5 /* msa-extension-5 facility */
 #define FAC_MSA8        S390_FEAT_MSA_EXT_8 /* msa-extension-8 facility */
+#define FAC_MSA9        S390_FEAT_MSA_EXT_9 /* msa-extension-9 facility */
 #define FAC_ECT         S390_FEAT_EXTRACT_CPU_TIME
 #define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */
 #define FAC_AIS         S390_FEAT_ADAPTER_INT_SUPPRESSION
-- 
2.43.0


