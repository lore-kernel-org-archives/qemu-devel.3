Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30453C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfrn-0004Qf-9r; Mon, 06 Jul 2026 05:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wgfrl-0004Pt-Bl; Mon, 06 Jul 2026 05:43:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wgfrj-0003xi-DM; Mon, 06 Jul 2026 05:43:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6669IYN14015378; Mon, 6 Jul 2026 09:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4jDaDveEQjx3M9gQg
 Gm7WqdzDPE7p/UTV3IR3bqedqw=; b=FXC1Bwiwg0zQ0PjArf3VfkFJZik3aoXI7
 6221BlJOTTYBldwFQH6F5vtoJewex68j7/dEgRQoGCZwv0P/lDdPYu+cG1EqmWvY
 r1ZrYShn7hWBj1tfAx5Ic1hWrvO+5uOuhIGDicXKw3IejiUVz46jvUMHXtO2NDpz
 jQpWV49ptu/28I3VvelrSbtpJvymE0RVGASbvf4m90dX0oqHTx04GVyl9pQVdvs9
 kzmlpCTrskIvmUOs1lxhz6f/xx29PVZAqMostsCkALWDwOJkunj7fZyjlsoadibN
 fFZ1T3ibX4ZAMS4dLid03Mbdo+UjtUzO1I9svZr/jIh9Hmpq6BpUw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqgp84-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:43:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6669Ya7Z028303;
 Mon, 6 Jul 2026 09:43:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjw0gu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:43:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6669hI6746727530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 09:43:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D8B62004E;
 Mon,  6 Jul 2026 09:43:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 175C720040;
 Mon,  6 Jul 2026 09:43:18 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.193.81])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 09:43:18 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v10 11/21] target/s390x: Support pckmo encrypt AES subfunctions
Date: Mon,  6 Jul 2026 11:43:04 +0200
Message-ID: <20260706094317.17032-12-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706094317.17032-1-freude@linux.ibm.com>
References: <20260706094317.17032-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX2wKHrP3OF7T8
 eHor9y5XjDI+U7DaQ8Gd6O/q6JJal0QCSbdAjw9X26k/2BpPu0lm0H7X+V46x5R3Ew3BW5xl7Yd
 bnepXtuNVFORrB0byUUPp+T6mRSQjQM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfXzqv/EgdHkw9h
 v9uQhfItp++SgkKsV2b0J7qFBEnlCprgJGRMxzttnzmVhOjExkgActrioPwMOknwUQhAehwoIZB
 yqN7We6B+D7NiTSqt2jNxnf70f8qd3dJgYzbmDj2tVkacCML9AxuiZ7OzRafsmleQRv/jINuXWI
 kmNUIvE0fcGf+jsZ9w3Nwdp3LZP7SVsX0bk97+OwmZ3Cf8hHNRwDGTspO8ZQ94vf810A41deMPV
 0lS0YcC9QLMjg6FJ9HUY8JtYhgCZbukJ/4m/LWQSelm5ovailIS0jNOgF6Lu5x7KpeiC/kUZKP2
 kwpzH9qEyeK8xWBCkLSoImG07J89/4LTcU5qpFOfBA4ftwj1rTTn1jc/QkbQDsiz30lR6xx/2jf
 OBM2x7spHvCQB08NO1Vp7jzxhk2neXbWZ2Qs0w8TKf7QCWZaTSuqMNmoBxNMJylTsd5bodgYqmW
 anyeDw16CSogDkMzPeQ==
X-Proofpoint-GUID: VBpHvLdiaMkdZMHaEiTC_VFsRRYMtKX9
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4b78bb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Z4AAViVgUL_E5abT2tgA:9
X-Proofpoint-ORIG-GUID: VBpHvLdiaMkdZMHaEiTC_VFsRRYMtKX9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060094
Received-SPF: pass client-ip=148.163.156.1; envelope-from=freude@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Support the subfuctions PCKMO-Encrypt-AES-128-Key,
PCKMO-Encrypt-AES-192-Key and PCKMO-Encrypt-AES-256-Key.

These subfunctions derive a protected key from an AES clear key
by encrypting it with an internal AES wrapping key. More
details can be found in the "z/Architecture Prinziples of
Operation" document.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 +++
 target/s390x/tcg/cpacf.h         |  4 +++
 target/s390x/tcg/cpacf_aes.c     | 45 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 21 +++++++++++++++
 target/s390x/tcg/translate.c     |  9 +++++--
 5 files changed, 80 insertions(+), 2 deletions(-)

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
index df7f258443..7512c0ea4c 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -279,4 +279,8 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E, \
     0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E }
 
+/* from cpacf_aes.c */
+int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                    uint64_t param_addr, uint8_t fc);
+
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 6702006b66..37c616ca5c 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -500,3 +500,48 @@ static void decrypt_protkey(uint8_t *key, int keysize)
         key[i] ^= protkey_xor_pattern[i];
     }
 }
+
+int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                    uint64_t param_addr, uint8_t fc)
+{
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+    uint8_t key[32];
+    int keysize, i;
+    uint64_t addr;
+
+    switch (fc) {
+    case CPACF_PCKMO_ENC_AES_128_KEY:
+        keysize = 16;
+        break;
+    case CPACF_PCKMO_ENC_AES_192_KEY:
+        keysize = 24;
+        break;
+    case CPACF_PCKMO_ENC_AES_256_KEY:
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* fetch key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+
+    /* 'derive' the protected key from the clear key */
+    encrypt_clrkey(key, keysize);
+
+    /* store the protected key into param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        cpu_stb_mmu(env, addr, key[i], oi, ra);
+    }
+    /* followed by the fake wkvp */
+    for (i = 0; i < sizeof(protkey_wkvp); i++) {
+        addr = wrap_address(env, param_addr + keysize + i);
+        cpu_stb_mmu(env, addr, protkey_wkvp[i], oi, ra);
+    }
+
+    return 0;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 564f7fa243..08151e916f 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -192,6 +192,24 @@ static int cpacf_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return rc;
 }
 
+static int cpacf_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                       uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case CPACF_PCKMO_ENC_AES_128_KEY:
+    case CPACF_PCKMO_ENC_AES_192_KEY:
+    case CPACF_PCKMO_ENC_AES_256_KEY:
+        rc = cpacf_aes_pckmo(env, mmu_idx, ra, env->regs[1], fc);
+        break;
+    default:
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    return rc;
+}
+
 uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
                      uint32_t type)
 {
@@ -251,6 +269,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_PCC:
         rc = cpacf_pcc(env, mmu_idx, ra, fc);
         break;
+    case S390_FEAT_TYPE_PCKMO:
+        rc = cpacf_pckmo(env, mmu_idx, ra, fc);
+        break;
     case S390_FEAT_TYPE_PPNO:
         rc = cpacf_ppno(env, mmu_idx, ra, r1, r2, r3, fc);
         break;
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index cef1b55149..d7a99e6c1e 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2558,6 +2558,7 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
     int r2 = have_field(s, r2) ? get_field(s, r2) : 0;
     int r3 = have_field(s, r3) ? get_field(s, r3) : 0;
     TCGv_i32 t_r1, t_r2, t_r3, type;
+    bool update_cc = true;
 
     switch (s->insn->data) {
     case S390_FEAT_TYPE_KMA:
@@ -2589,8 +2590,10 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
             gen_program_exception(s, PGM_SPECIFICATION);
             return DISAS_NORETURN;
         }
-        /* FALL THROUGH */
+        break;
     case S390_FEAT_TYPE_PCKMO:
+        update_cc = false;
+        /* FALL THROUGH */
     case S390_FEAT_TYPE_PCC:
     case S390_FEAT_TYPE_KDSA:
         break;
@@ -2603,7 +2606,9 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
     t_r3 = tcg_constant_i32(r3);
     type = tcg_constant_i32(s->insn->data);
     gen_helper_msa(cc_op, tcg_env, t_r1, t_r2, t_r3, type);
-    set_cc_static(s);
+    if (update_cc) {
+        set_cc_static(s);
+    }
     return DISAS_NEXT;
 }
 
-- 
2.43.0


