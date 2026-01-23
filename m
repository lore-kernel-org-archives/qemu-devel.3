Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0BBD72379
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 11:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjFaX-0005VU-TB; Fri, 23 Jan 2026 06:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZQ-000500-35; Fri, 23 Jan 2026 06:43:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZN-0006xs-Ns; Fri, 23 Jan 2026 06:43:19 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MNkBr2022334;
 Fri, 23 Jan 2026 11:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=+45PfIQxU+yA/A4fK
 k21huq2ZUvMzyEEFJMyqcnn25M=; b=a7j4ShTwJoXSbE6VzYvfP5sBxY8uAZeQY
 nhyZSfVKrRqmWdRRrP/zlGSZlyCAx7msuLXRy3v0mjY6aRdl/s/U1etf/CeZdejB
 Uln7CyTbR8RpTt9LRdn07sPdV6VPO1jIq+pfVnNH6INWDhCq606xkK3hSfqhCiCX
 hGQelzqKYXaDXloXqaBTgxrpRkDOY8vPDL5CGCaYQrdr1TyLiLhdJ3QW1pM5aNcm
 546o4sVgrKZlOgVrpa1LzaiekwDek34p3Utg6gzGAddHOsy79cJO9wDY8H5PvYvI
 w1yZm1hsWVp6h0ctcTwSu9uIJfLvRCA04GhQ+xr1Bjzg0KPihR3gA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt612j8ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60NA5KuC016600;
 Fri, 23 Jan 2026 11:43:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4ygxv0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60NBh9Iu14680574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jan 2026 11:43:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5C942004E;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6FCB2004B;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.163.22])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jan 2026 11:43:09 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: pbonzini@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@linux.ibm.com,
 frankja@linux.ibm.com
Subject: [PATCH v3 09/14] target/s390x: Support pckmo encrypt AES subfunctions
Date: Fri, 23 Jan 2026 12:43:03 +0100
Message-ID: <20260123114308.19401-10-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123114308.19401-1-freude@linux.ibm.com>
References: <20260123114308.19401-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K9rJwT6rDVChHi3DZKddXOK1RkCn99RK
X-Authority-Analysis: v=2.4 cv=LaIxKzfi c=1 sm=1 tr=0 ts=69735ed2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Z4AAViVgUL_E5abT2tgA:9
X-Proofpoint-ORIG-GUID: K9rJwT6rDVChHi3DZKddXOK1RkCn99RK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA5MiBTYWx0ZWRfX+Q6HKzYm+aak
 uD0LQZewp8ACHLtO5ekA9jgDW+nj0PUKg1b9PwjOLx2EKL62GArI4AtoViAtx1C9PPJIYJg2kFr
 4mzi24VSDUdCsWyE7knC6dar5lblX0avplbj9yzw+Z5jYQ6b1gaT2kJNfpylCBUizjL3kiWmto3
 Iw94EjMpLprHeZ1FF85rZixDYaY0OEHPlr8i3WOrQOcjtFlFwexf0KgBarWZOfFnyG6mFMv7xbc
 W5VbH6bm8CZHiOnMh5DiSYv+a4HnRHM+g7IxTIT8g1wfiuyn0E+OcsStxaDFA3uFlo8GzrLDWcK
 5N6JX27SH/E85pP4nxubAfNmG2OICu3sLub77W+gWeoJfq8eIMotdv/tLZsJfLbuGXKTO2xZd3y
 GWnU6FtJ7tqOFS5xPOZyRwdVRUTKD5MRuD/aFop8BY15yiCndPzuLWmSU79l9nR0T/005c3mVKt
 Sx79MnGKJIeep/GgAkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230092
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

Support the subfuctions PCKMO-Encrypt-AES-128-Key,
PCKMO-Encrypt-AES-192-Key and PCKMO-Encrypt-AES-256-Key.

These subfunctions derive a protected key from an AES clear key
by encrypting it with an internal AES wrapping key. More
details can be found in the "z/Architecture Prinziples of
Operation" document.

The qemu version provided here is only a fake indented to make
protected key available for developing and testing purpose:
* The protected key is 'derived' from the clear key by xoring
  the fixed pattern 0xAAAA... onto the key value.
* The AES Wrapping Key Verification Pattern is a fixed
  value of 32 bytes 0xFACEFACE...

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 ++
 target/s390x/tcg/cpacf.h         |  2 +
 target/s390x/tcg/cpacf_aes.c     | 65 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 20 ++++++++++
 4 files changed, 90 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index f9b1a40c7c..d3e69aaca6 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -934,6 +934,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMCTR_AES_256,
     S390_FEAT_PCC_XTS_AES_128,
     S390_FEAT_PCC_XTS_AES_256,
+    S390_FEAT_PCKMO_AES_128,
+    S390_FEAT_PCKMO_AES_192,
+    S390_FEAT_PCKMO_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 8c1dbee67f..2617cbed80 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -31,5 +31,7 @@ int cpacf_aes_pcc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
 int cpacf_aes_xts(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
                   uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,
                   uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_aes_pckmo(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                    uint8_t fc);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index f067939f25..a53ef93635 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -449,3 +449,68 @@ int cpacf_aes_xts(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
 
     return !len ? 0 : 3;
 }
+
+/*
+ * Hard coded pattern xored with the AES clear key
+ * to 'produce' the protected key.
+ */
+static const uint8_t protkey_xor_pattern[32] = {
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA };
+
+/*
+ * Hard coded wkvp ("Wrapping Key Verification Pattern")
+ */
+static const uint8_t protkey_wkvp[32] = {
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E,
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E,
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E,
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E };
+
+int cpacf_aes_pckmo(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                    uint8_t fc)
+{
+    uint8_t key[32];
+    int keysize, i;
+    uint64_t addr;
+
+    switch (fc) {
+    case 0x12: /* CPACF_PCKMO_ENC_AES_128_KEY */
+        keysize = 16;
+        break;
+    case 0x13: /* CPACF_PCKMO_ENC_AES_192_KEY */
+        keysize = 24;
+        break;
+    case 0x14: /* CPACF_PCKMO_ENC_AES_256_KEY */
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* fetch key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        key[i] = cpu_ldub_data_ra(env, addr, ra);
+    }
+
+    /* 'derive' the protected key */
+    for (i = 0; i < keysize; i++) {
+        key[i] ^= protkey_xor_pattern[i];
+    }
+
+    /* store the protected key into param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        cpu_stb_data_ra(env, addr, key[i], ra);
+    }
+    /* followed by the fake wkvp */
+    for (i = 0; i < sizeof(protkey_wkvp); i++) {
+        addr = wrap_address(env, param_addr + keysize + i);
+        cpu_stb_data_ra(env, addr, protkey_wkvp[i], ra);
+    }
+
+    return 0;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 7129b38703..8d1070ec89 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -187,6 +187,23 @@ static int cpacf_pcc(CPUS390XState *env, uintptr_t ra, uint8_t fc)
     return rc;
 }
 
+static int cpacf_pckmo(CPUS390XState *env, uintptr_t ra, uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case 0x12: /* CPACF_PCKMO_ENC_AES_128_KEY */
+    case 0x13: /* CPACF_PCKMO_ENC_AES_192_KEY */
+    case 0x14: /* CPACF_PCKMO_ENC_AES_256_KEY */
+        rc = cpacf_aes_pckmo(env, ra, env->regs[1], fc);
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
@@ -246,6 +263,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_PCC:
         rc = cpacf_pcc(env, ra, fc);
         break;
+    case S390_FEAT_TYPE_PCKMO:
+        rc = cpacf_pckmo(env, ra, fc);
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


