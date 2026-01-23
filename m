Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2267D7236C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 11:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjFac-0005b5-2Z; Fri, 23 Jan 2026 06:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZV-00050t-4J; Fri, 23 Jan 2026 06:43:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZN-0006yB-SO; Fri, 23 Jan 2026 06:43:22 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N9BJgw028566;
 Fri, 23 Jan 2026 11:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nPsDdoGjwRfkk3lX1
 8SG4RiW++gIDwyUmJEHk82NR68=; b=KdAKIP3O0qYb2DZddWBBxB5dI+uFCXwqf
 WDDWTQDRCQ9EjCsxL7txSfBCkZG2A0eS+VNrQChth4YH/unOb1hiOgn+AEPTIaDB
 5epk5fEpow/L8516pH5UvYakHD1VyVD1Y/J39VYg4N1sW4pzvHWIuCH+okFdiMZ0
 9n2JDGcu+qO4wNraR9lVTjkMt30cJ43QYbLrBYIGTmOi/UJg2P07agPN6NzzD5Ev
 zQmkBywGY5Ti217LWuqyfvZfFhaF5Lyp30c5gZxj8lnnGgCsvtkVOM97VvTlYkR2
 /28qyyCofwu3OM5siGpYI9GdGInZ2kFhcrrNUGAf97vphqt1Rf7EQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt60f38rh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N8Jn5m001171;
 Fri, 23 Jan 2026 11:43:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyk8m1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60NBhA3u34668932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jan 2026 11:43:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48D4520043;
 Fri, 23 Jan 2026 11:43:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 326682004D;
 Fri, 23 Jan 2026 11:43:10 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.163.22])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jan 2026 11:43:10 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: pbonzini@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@linux.ibm.com,
 frankja@linux.ibm.com
Subject: [PATCH v3 13/14] target/s390x: Minimal protected key AES XTS support
 for cpacf pcc instruction
Date: Fri, 23 Jan 2026 12:43:07 +0100
Message-ID: <20260123114308.19401-14-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123114308.19401-1-freude@linux.ibm.com>
References: <20260123114308.19401-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WMdyn3sR c=1 sm=1 tr=0 ts=69735ed3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=k9NNRZQrG_SOijgty3UA:9
X-Proofpoint-GUID: 4dgFsyvtIJ4c-7B82ToejzoUfebm_7Eo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA5MiBTYWx0ZWRfX+JpXeU/Ge9Aj
 GAkMYLBeDAALZP6DNZPt1Kqkdz0Xoi3uzNHF559SKTZvzmd4iCL64YU8rrwmi2YWrYtzlSrmic/
 hRcNTAIFtWd4Nn5K1v2j+BmupqNaQ6kQB6u87sM/4Ar+onpEHuJ6RHN4JFdTOBT4cq4TApte+PC
 Uif9TNliC7jIjjLZucL+a5qlzMIDaPWUm2g/kfsMpmFhI/gQR7J9LZP38OOZjD55KnYoOXRulT8
 pt5x3SAs4iALEWryj09DpP8Afd6SfGnPc2/HMBRP64SUdxgLtX+G5WDoj5hQTu5s8FMSgkL1M5b
 NmBmOPZ+D2MEtsRfA6ZV6410KW7E/9j3ZdnKtuXZNZj55bOsjBIcb5CY1t7iCB05aAYKjLB69qk
 3TiPY2B4oGV5RRctCeUXr/WyIt8tP7KK7GFUTpz1PB8iw87L0jJabXWStRqQevR8XzlyLM6ZE1A
 sXro+1VUy4ZdIKxS+0g==
X-Proofpoint-ORIG-GUID: 4dgFsyvtIJ4c-7B82ToejzoUfebm_7Eo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601230092
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

Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-Encrypted-AES-128
and PCC-Compute-XTS-Parameter-Encrypted-AES-128 but only for the special
case block sequential number is 0. However, this covers the s390 PAES XTS
implementation in the Linux kernel.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |  2 +
 target/s390x/tcg/cpacf.h         |  2 +
 target/s390x/tcg/cpacf_aes.c     | 79 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  4 ++
 4 files changed, 87 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 4a131dc191..126bacb281 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -943,6 +943,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMCTR_EAES_256,
     S390_FEAT_PCC_XTS_AES_128,
     S390_FEAT_PCC_XTS_AES_256,
+    S390_FEAT_PCC_XTS_EAES_128,
+    S390_FEAT_PCC_XTS_EAES_256,
     S390_FEAT_PCKMO_AES_128,
     S390_FEAT_PCKMO_AES_192,
     S390_FEAT_PCKMO_AES_256,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 35518aef4b..9d0801b217 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -42,5 +42,7 @@ int cpacf_paes_cbc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
 int cpacf_paes_ctr(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
                    uint64_t *dst_ptr, uint64_t *src_ptr, uint64_t *src_len,
                    uint64_t *ctr_ptr, uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_paes_pcc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                   uint8_t fc);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 78af0ce8d5..c4406f4a34 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -786,3 +786,82 @@ int cpacf_paes_ctr(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_paes_pcc(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
+                   uint8_t fc)
+{
+    uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    int keysize, i;
+    uint64_t addr;
+    AES_KEY exkey;
+
+    switch (fc) {
+    case 0x3a: /* CPACF_PCC compute XTS param Encrypted AES-128 */
+        keysize = 16;
+        break;
+    case 0x3c: /* CPACF PCC compute XTS param Encrypted AES-256 */
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* fetch and check wkvp from param block */
+    for (i = 0; i < sizeof(wkvp); i++) {
+        addr = wrap_address(env, param_addr + keysize + i);
+        wkvp[i] = cpu_ldub_data_ra(env, addr, ra);
+    }
+    if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
+        /* wkvp mismatch -> return with cc 1 */
+        return 1;
+    }
+
+    /* fetch block sequence nr from param block into buf */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize +
+                            sizeof(wkvp) + AES_BLOCK_SIZE + i);
+        buf[i] = cpu_ldub_data_ra(env, addr, ra);
+    }
+
+    /* is the block sequence nr 0 ? */
+    for (i = 0; i < AES_BLOCK_SIZE && !buf[i]; i++) {
+            ;
+    }
+    if (i < AES_BLOCK_SIZE) {
+        /* no, sorry handling of non zero block sequence is not implemented */
+        cpu_abort(env_cpu(env),
+                  "PCC-compute-XTS-param (encrypted) with non zero block seq nr is not implemented\n");
+        return 1;
+    }
+
+    /* fetch protected key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        key[i] = cpu_ldub_data_ra(env, addr, ra);
+    }
+    /* 'decrypt' the protected key */
+    for (i = 0; i < keysize; i++) {
+        key[i] ^= protkey_xor_pattern[i];
+    }
+
+    /* fetch tweak from param block into tweak */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + sizeof(wkvp) + i);
+        tweak[i] = cpu_ldub_data_ra(env, addr, ra);
+    }
+
+    /* expand key */
+    AES_set_encrypt_key(key, keysize * 8, &exkey);
+
+    /* encrypt tweak */
+    AES_encrypt(tweak, buf, &exkey);
+
+    /* store encrypted tweak into xts parameter field of the param block */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize +
+                            sizeof(wkvp) + 3 * AES_BLOCK_SIZE + i);
+        cpu_stb_data_ra(env, addr, buf[i], ra);
+    }
+
+    return 0;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 2791e69f84..3ff8331993 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -201,6 +201,10 @@ static int cpacf_pcc(CPUS390XState *env, uintptr_t ra, uint8_t fc)
     case 0x34: /* CPACF PCC compute XTS param AES-256 */
             rc = cpacf_aes_pcc(env, ra, env->regs[1], fc);
             break;
+    case 0x3a: /* CPACF_PCC compute XTS param Encrypted AES-128 */
+    case 0x3c: /* CPACF PCC compute XTS param Encrypted AES-256 */
+            rc = cpacf_paes_pcc(env, ra, env->regs[1], fc);
+            break;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


