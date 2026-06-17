Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3F7CD98F1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZmt0-0007AO-SA; Wed, 17 Jun 2026 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wZmsw-000751-9H; Wed, 17 Jun 2026 05:48:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wZmst-00039V-DI; Wed, 17 Jun 2026 05:48:37 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8mToO4003130; Wed, 17 Jun 2026 09:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xhf4zyh8REkyXlzHg
 Cgt2vTzhO6jP+fD3+QUkpYT8mU=; b=p1+knW8rmCwxoIvKBxXk3VmmRAB5AANMV
 Fp5+gtnyP4wsuKEbqiN4b+i4WiQGMRcY4+ziFAePx6BeR1r2NOiIBMLmrJ5wfs+O
 57F2PocB98lLIzAq91AaxEmJcYhMO4qWGYYVAPe64Aq9dnujZ1pquzkVw5JVB/Br
 +Zw28n/F/lCc5Y7sllVy43a7W9SV0LsGqXyvpkz89cWqLPSU+M7WFlOvV+vtU8GZ
 RoCFf6A9bzufoDV732RsqoNoTaBkT8KnYyHiMgaGxI3ix2NLI7Z563VM28DwzJpE
 JmrLo/0/7IkduS+v+rrLNNaTwozt/kR25B8ZSj1vL+ewkHgcwCenw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx28bq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 09:48:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H9YaTR028270;
 Wed, 17 Jun 2026 09:48:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudvaahdv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 09:48:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H9mODf48300380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 09:48:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCFA620040;
 Wed, 17 Jun 2026 09:48:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94E0B2004E;
 Wed, 17 Jun 2026 09:48:24 +0000 (GMT)
Received: from funtu2.ehn-de.ibm.com (unknown [9.224.92.54])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 09:48:24 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v7 17/17] target/s390x: Use generic AES helper functions
Date: Wed, 17 Jun 2026 11:48:20 +0200
Message-ID: <20260617094820.34402-18-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617094820.34402-1-freude@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Uw7SZeYd5012zPXZPq2m0q_3ZKF4nnFV
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a326d6d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=g6vVTg3iDwn42Crx3gMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX0W/pULkyliH9
 YgXotheddvXTIEJW3J3sqtNrN4CEEb1YJkIsVZM5rnfWQPkknCNBI/4I6pRIgiIwJks/CkGQPW0
 IdKS/sCHJLC1myEU7DsqyNTMtenH2Ks=
X-Proofpoint-ORIG-GUID: Uw7SZeYd5012zPXZPq2m0q_3ZKF4nnFV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX3imXPVVmmbXa
 8RNdyJbpu/DbKGtgSxQjAepfknioo1m4dnQKf+ADdC6fYAZeH8CGiIZmUwFX2xjJSL/34SDZm8X
 7zmDpci6Myq1L6m3Cb/YgKMg11Y6GByOwUixPtwEOdxJg+ssbgweUc63Sv0YR8UkwngaGRUXo8B
 H3jLBSt1FpoUZ5Xbxb9aHIrkSu1+f0MnvkXDT5jHx0MDcHHu+Qm8f3K/xuRDA2hh2zno0oVSCAE
 IRqBHrTtnUz7bSAauIqTZ/n6nc1FAXOeNYUZD1Ys18lu8EoN3jEIrJ6kDNSWUTCmJEaQkHOTQGP
 GRn7KeCoIjoY7LYPc79giAqDytu7W7m0mrSxfq1cqR8/HoCqP2I5Gm819/ug8Uy4lpzJqhVqoWH
 pkHSQabwmp3AYpxQkTqO3fh0jdnet5vmzswq35m1GHXuCtgezaTcoO1dSPTf3ZnUw47VL10vdBK
 yXO9OvSo7W3FpxSRSZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170092
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
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

Rewrite the cpacf implementations to use the generic
AES helper functions from crypto/aes-helpers.c

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/tcg/cpacf_aes.c | 124 ++++++++++-------------------------
 1 file changed, 36 insertions(+), 88 deletions(-)

diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 98d5134d5f..9935b6b39c 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -119,20 +119,13 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return !len ? 0 : 3;
 }
 
-static void aes_xor(const uint8_t *src1, const uint8_t *src2, uint8_t *dst)
-{
-    for (int i = 0; i < AES_BLOCK_SIZE; i++) {
-        dst[i] = src1[i] ^ src2[i];
-    }
-}
-
 int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint64_t *dst_ptr_reg,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint64_t addr, len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size = 64;
@@ -188,19 +181,11 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
         aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
         if (mod) {
-            /* decrypt in => buf */
-            AES_decrypt(in, buf, &exkey);
-            /* buf xor iv => out */
-            aes_xor(buf, iv, out);
-            /* prep iv for next round */
-            memcpy(iv, in, AES_BLOCK_SIZE);
+            /* decrypt in => out */
+            AES_cbc_decrypt(in, out, iv, &exkey);
         } else {
-            /* in xor iv => buf */
-            aes_xor(in, iv, buf);
-            /* encrypt buf => out */
-            AES_encrypt(buf, out, &exkey);
-            /* prep iv for next round */
-            memcpy(iv, out, AES_BLOCK_SIZE);
+            /* encrypt in => out */
+            AES_cbc_encrypt(in, out, iv, &exkey);
         }
         aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
@@ -229,11 +214,10 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
-    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     uint64_t addr, len = *src_len_reg, done = 0;
+    uint8_t ctr[AES_BLOCK_SIZE], key[32];
     int i, keysize, addr_reg_size = 64;
-    uint8_t key[32];
     AES_KEY exkey;
 
     g_assert(type == S390_FEAT_TYPE_KMCTR);
@@ -275,12 +259,10 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
         /* read in nonce/ctr => ctr */
         aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
-        /* encrypt ctr => buf */
-        AES_encrypt(ctr, buf, &exkey);
         /* read in one block of input data => in */
         aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
-        /* exor input data with encrypted ctr => out */
-        aes_xor(in, buf, out);
+        /* encrypt ctr and xor with in => out */
+        AES_ctr_encrypt(in, out, ctr, &exkey);
         /* write out the processed block */
         aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
@@ -361,28 +343,13 @@ int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return 0;
 }
 
-static void aes_xts_prep_next_tweak(uint8_t tweak[AES_BLOCK_SIZE])
-{
-    uint8_t carry;
-    int i;
-
-    carry = tweak[AES_BLOCK_SIZE - 1] >> 7;
-
-    for (i = AES_BLOCK_SIZE - 1; i > 0; i--) {
-        tweak[i] = (uint8_t)((tweak[i] << 1) | (tweak[i - 1] >> 7));
-    }
-
-    tweak[i] = (uint8_t)(tweak[i] << 1);
-    tweak[i] ^= (uint8_t)(0x87 & (uint8_t)(-(int8_t)carry));
-}
-
 int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint64_t *dst_ptr_reg,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    uint8_t buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint64_t addr, len = *src_len_reg, done = 0;
     uint8_t key[32], tweak[AES_BLOCK_SIZE];
@@ -433,23 +400,19 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        /* fetch one AES block into buf1  */
-        aes_read_block(env, mmu_idx, *src_ptr_reg + done, buf1, ra);
-        /* buf1 xor tweak => buf2 */
-        aes_xor(buf1, tweak, buf2);
+        /* fetch one AES block into in  */
+        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
         if (mod) {
-            /* decrypt buf2 => buf1 */
-            AES_decrypt(buf2, buf1, &exkey);
+            /* decrypt in => out */
+            AES_xts_decrypt(in, out, tweak, &exkey);
         } else {
-            /* encrypt buf2 => buf1 */
-            AES_encrypt(buf2, buf1, &exkey);
+            /* encrypt in => out */
+            AES_xts_encrypt(in, out, tweak, &exkey);
         }
-        /* buf1 xor tweak => buf2 */
-        aes_xor(buf1, tweak, buf2);
         /* prep tweak for next round */
-        aes_xts_prep_next_tweak(tweak);
-        /* write out this processed block from buf2 */
-        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, buf2, ra);
+        AES_xts_prep_next_tweak(tweak);
+        /* write out this processed block from out */
+        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
     }
 
@@ -627,7 +590,7 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint32_t type, uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t key[32], wkvp[32], iv[AES_BLOCK_SIZE];
     uint64_t addr, len = *src_len_reg, done = 0;
@@ -697,19 +660,11 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
         aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
         if (mod) {
-            /* decrypt in => buf */
-            AES_decrypt(in, buf, &exkey);
-            /* buf xor iv => out */
-            aes_xor(buf, iv, out);
-            /* prep iv for next round */
-            memcpy(iv, in, AES_BLOCK_SIZE);
+            /* decrypt in => out */
+            AES_cbc_decrypt(in, out, iv, &exkey);
         } else {
-            /* in xor iv => buf */
-            aes_xor(in, iv, buf);
-            /* encrypt buf => out */
-            AES_encrypt(buf, out, &exkey);
-            /* prep iv for next round */
-            memcpy(iv, out, AES_BLOCK_SIZE);
+            /* encrypt in => out */
+            AES_cbc_encrypt(in, out, iv, &exkey);
         }
         aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
@@ -738,11 +693,10 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
-    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint8_t ctr[AES_BLOCK_SIZE], key[32], wkvp[32];
     uint64_t addr, len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size = 64;
-    uint8_t key[32], wkvp[32];
     AES_KEY exkey;
 
     g_assert(type == S390_FEAT_TYPE_KMCTR);
@@ -798,12 +752,10 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
         /* read in nonce/ctr => ctr */
         aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
-        /* encrypt ctr => buf */
-        AES_encrypt(ctr, buf, &exkey);
         /* read in one block of input data => in */
         aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
-        /* exor input data with encrypted ctr => out */
-        aes_xor(in, buf, out);
+        /* encrypt ctr and xor with in => out */
+        AES_ctr_encrypt(in, out, ctr, &exkey);
         /* write out the processed block */
         aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
@@ -906,7 +858,7 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint32_t type, uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    uint8_t buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE];
     uint64_t addr, len = *src_len_reg, done = 0;
@@ -971,23 +923,19 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        /* fetch one AES block into buf1  */
-        aes_read_block(env, mmu_idx, *src_ptr_reg + done, buf1, ra);
-        /* buf1 xor tweak => buf2 */
-        aes_xor(buf1, tweak, buf2);
+        /* fetch one AES block into in */
+        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
         if (mod) {
-            /* decrypt buf2 => buf1 */
-            AES_decrypt(buf2, buf1, &exkey);
+            /* decrypt in => out */
+            AES_xts_decrypt(in, out, tweak, &exkey);
         } else {
-            /* encrypt buf2 => buf1 */
-            AES_encrypt(buf2, buf1, &exkey);
+            /* encrypt in => out */
+            AES_xts_encrypt(in, out, tweak, &exkey);
         }
-        /* buf1 xor tweak => buf2 */
-        aes_xor(buf1, tweak, buf2);
         /* prep tweak for next round */
-        aes_xts_prep_next_tweak(tweak);
-        /* write out this processed block from buf2 */
-        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, buf2, ra);
+        AES_xts_prep_next_tweak(tweak);
+        /* write out this processed block from out */
+        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
     }
 
-- 
2.43.0


