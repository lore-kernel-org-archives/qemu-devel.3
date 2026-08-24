Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B470CC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyQ6W-0002fM-Po; Mon, 24 Aug 2026 04:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wyQ6R-0002YZ-Oc; Mon, 24 Aug 2026 04:32:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wyQ6O-0005BE-9P; Mon, 24 Aug 2026 04:32:23 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O5VmDH856999; Mon, 24 Aug 2026 08:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=B/Sybm
 Q/FJyrxZ7FxX4k3LSF1+CDBp2yE9MObY673j0=; b=Kx/AvqpF7gOlbY2AlB8OHc
 9KmsAuVrjCbsAf1RjyYEQH54PJfWgIVukRUZHYEVDwi6Cz9afrUhmU7K/VeApngt
 +nPPP8eZmXaE6I9ElLxi47uUITA5xfkEqmAsAslh/kYRj2yb+ZXAS57xns/4eBea
 f15fVGntJNbemFbvoqvNnQAtUL2ZGljbzZwxx3E/FWEPrfem4GLb29HtBm0vCkIU
 /4KX+iD2bN6q0Lo1yFkzj8h4h7KrGwrJDxlEg4SNOBPjXVH+Hj8KKOAt7uhAr/nj
 wegHTvmtDbRh2yH7qD5GERKn2qba7Akj+ZoU+62HKYFcVXJaoSuRs3m8MldVhvJQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hgax5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 08:32:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8QIpB028810;
 Mon, 24 Aug 2026 08:32:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsxvjjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 08:32:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67O8W7Av45744442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 08:32:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1212520043;
 Mon, 24 Aug 2026 08:32:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6D102004D;
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
Subject: [PATCH v16 07/20] crypto: Add aes-helpers file to support some AES
 modes
Date: Mon, 24 Aug 2026 10:31:51 +0200
Message-ID: <20260824083204.40877-8-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824083204.40877-1-freude@linux.ibm.com>
References: <20260824083204.40877-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX1f0MEZ2+uspF
 A4vUNfTpZQxZUhZh9P1w5ffS32PjkOhM/SvR5WLZhHV0vJAatvMamkH7eVIOAGWDtbBla7TIWn7
 lx1CGQAoM3QCA7iTJzFH9eRz/XTgv/8=
X-Proofpoint-GUID: YLdju1sL_nlucQznGIMEU0d3i95Myya6
X-Proofpoint-ORIG-GUID: YLdju1sL_nlucQznGIMEU0d3i95Myya6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX18dKy8pPoNTh
 5ha7IsrRMGyIj08GNTmdWblFoJkyiHjjVpf5xdjFCBbzmid182SAkwdyOR6564HHh7Z3SzIZDoZ
 iRYvkaDAzvh7ng43r19HtDod9IwwV7DYymTLY9sw7d1TTL5QiIVKqQtPjEvDIiQ1tgFJkyqp+6Q
 ikzcOWcxxWNKHFTjI49QrRx/QZgRDEOp3qqkk/CF3i3DBnX7l/27/wiSpF+c8oLcWG2AUceO+Ug
 +xe8vRmyG2kjwqSh2FnJ3B0rKFtsNbTPQx/kVA2pEje10NL6SNhopqZOPYaM+U1pZrpWWIIToUt
 3U67ptZYnGZUrYc37emyV+7+DtJ35op4oiM9zD+ppBGQmOkBppfgUYPjeRTawdYeSVFuzVZs/hQ
 HmCckr+YSJSFXfMLJ+cxKKOSGGpg4huP8fn9aNdvdSqIwE9gm37uKBnq5TaldlgAmNTeBFoSGoL
 yuNqHHljtnCFke1tvXg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8c018b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=zkwM-tl61wuaHISZUgYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
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

Add a new file crypto/aes-helpers.c with simple functions
to support some AES modes:
- AES cbc: AES_cbc_encrypt() AES_cbc_decrypt()
- AES ctr: AES_ctr_encrypt()
- AES xts: AES_xts_encrypt() AES_xts_decrypt()
and some AES related helpers:
- AES_xor()
- AES_xts_prep_next_tweak()
Add header file include/crypto/aes-helpers.h for these functions

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/aes-helpers.c         | 106 ++++++++++++++++++++++++++++++++++
 crypto/meson.build           |   1 +
 include/crypto/aes-helpers.h | 109 +++++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+)
 create mode 100644 crypto/aes-helpers.c
 create mode 100644 include/crypto/aes-helpers.h

diff --git a/crypto/aes-helpers.c b/crypto/aes-helpers.c
new file mode 100644
index 0000000000..68d848683c
--- /dev/null
+++ b/crypto/aes-helpers.c
@@ -0,0 +1,106 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * AES helper functions and mode implementations
+ *
+ * Authors:
+ *   Harald Freudenberger <freude@linux.ibm.com>
+ */
+
+#include "qemu/osdep.h"
+#include "crypto/aes.h"
+#include "crypto/aes-helpers.h"
+
+void AES_xor(const unsigned char *src1, const unsigned char *src2,
+             unsigned char *dst)
+{
+    int i;
+
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        dst[i] = src1[i] ^ src2[i];
+    }
+}
+
+void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
+                     unsigned char *iv, const AES_KEY *key)
+{
+    unsigned char buf[AES_BLOCK_SIZE];
+
+    /* in xor iv => buf */
+    AES_xor(in, iv, buf);
+    /* encrypt buf => out */
+    AES_encrypt(buf, out, key);
+    /* prep iv for next round */
+    memcpy(iv, out, AES_BLOCK_SIZE);
+}
+
+void AES_cbc_decrypt(const unsigned char *in, unsigned char *out,
+                     unsigned char *iv, const AES_KEY *key)
+{
+    unsigned char buf[AES_BLOCK_SIZE];
+
+    /* decrypt in => buf */
+    AES_decrypt(in, buf, key);
+    /* buf xor iv => out */
+    AES_xor(buf, iv, out);
+    /* prep iv for next round */
+    memcpy(iv, in, AES_BLOCK_SIZE);
+}
+
+void AES_ctr_encrypt(const unsigned char *in, unsigned char *out,
+                     const unsigned char *ctr, const AES_KEY *key)
+{
+    unsigned char buf[AES_BLOCK_SIZE];
+
+    /* encrypt ctr => buf */
+    AES_encrypt(ctr, buf, key);
+    /* exor input data with encrypted ctr => out */
+    AES_xor(in, buf, out);
+}
+
+/*
+ * Tweak calculation for AES XTS.
+ * Multiply tweak by α (x) in GF(2^128) per IEEE 1619-2007. The tweak
+ * is a 128-bit little-endian integer (tweak[0]=LSB, tweak[15]=MSB).
+ * This implementation has been verified on little and big endian.
+ */
+void AES_xts_prep_next_tweak(unsigned char *tweak)
+{
+    unsigned char carry;
+    int i;
+
+    carry = tweak[AES_BLOCK_SIZE - 1] >> 7;
+
+    for (i = AES_BLOCK_SIZE - 1; i > 0; i--) {
+        tweak[i] = (unsigned char)((tweak[i] << 1) | (tweak[i - 1] >> 7));
+    }
+
+    tweak[i] = (unsigned char)(tweak[i] << 1);
+    tweak[i] ^= (unsigned char)(0x87 & (unsigned char)(-(unsigned char)carry));
+}
+
+void AES_xts_encrypt(const unsigned char *in, unsigned char *out,
+                     const unsigned char *tweak, const AES_KEY *key)
+{
+    unsigned char buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
+
+    /* in xor tweak => buf1 */
+    AES_xor(in, tweak, buf1);
+    /* encrypt buf1 => buf2 */
+    AES_encrypt(buf1, buf2, key);
+    /* buf2 xor tweak => out */
+    AES_xor(buf2, tweak, out);
+}
+
+void AES_xts_decrypt(const unsigned char *in, unsigned char *out,
+                     const unsigned char *tweak, const AES_KEY *key)
+{
+    unsigned char buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
+
+    /* in xor tweak => buf1 */
+    AES_xor(in, tweak, buf1);
+    /* encrypt buf1 => buf2 */
+    AES_decrypt(buf1, buf2, key);
+    /* buf2 xor tweak => out */
+    AES_xor(buf2, tweak, out);
+}
diff --git a/crypto/meson.build b/crypto/meson.build
index 6ac83857aa..534b995c9b 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -55,6 +55,7 @@ system_ss.add(when: gnutls, if_true: files('tls-cipher-suites.c'))
 
 util_ss.add(files(
   'aes.c',
+  'aes-helpers.c',
   'clmul.c',
   'init.c',
   'sm4.c',
diff --git a/include/crypto/aes-helpers.h b/include/crypto/aes-helpers.h
new file mode 100644
index 0000000000..9a94c48d86
--- /dev/null
+++ b/include/crypto/aes-helpers.h
@@ -0,0 +1,109 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * AES helper functions and modes
+ */
+
+#ifndef QEMU_AES_HELPERS_H
+#define QEMU_AES_HELPERS_H
+
+/**
+ * AES_xor:
+ * @src1: first source buffer of AES_BLOCK_SIZE bytes
+ * @src2: second source buffer of AES_BLOCK_SIZE bytes
+ * @dst: destination buffer of AES_BLOCK_SIZE bytes
+ *
+ * Bitwise XOR operation between two AES blocks.
+ */
+void AES_xor(const unsigned char *src1, const unsigned char *src2,
+             unsigned char *dst);
+
+/**
+ * AES_cbc_encrypt:
+ * @in: input plaintext block of AES_BLOCK_SIZE bytes
+ * @out: output ciphertext block of AES_BLOCK_SIZE bytes
+ * @iv: IV, updated after processing for chaining
+ * @key: AES key
+ *
+ * Single block AES encrypt in CBC (Cipher Block Chaining) mode.
+ * The input block is XORed with the IV, then encrypted with AES.
+ * IV is updated at the end and is prepared for the next invocation.
+ */
+void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
+                     unsigned char *iv, const AES_KEY *key);
+
+/**
+ * AES_cbc_decrypt:
+ * @in: input ciphertext block of AES_BLOCK_SIZE bytes
+ * @out: output plaintext block of AES_BLOCK_SIZE bytes
+ * @iv: initialization vector, updated to input block for chaining
+ * @key: AES key
+ *
+ * Single block AES decrypt in CBC (Cipher Block Chaining) mode.
+ * The input block is decrypted, then XORed with the IV.
+ * IV is updated at the end and is prepared for the next invocation.
+ */
+void AES_cbc_decrypt(const unsigned char *in, unsigned char *out,
+                     unsigned char *iv, const AES_KEY *key);
+
+/**
+ * AES_ctr_encrypt:
+ * @in: input data block of AES_BLOCK_SIZE bytes
+ * @out: output data block of AES_BLOCK_SIZE bytes
+ * @ctr: counter value of AES_BLOCK_SIZE bytes
+ * @key: AES key
+ *
+ * Single block AES encrypt/decrypt in CTR (Counter) mode.
+ * The counter block is encrypted, then XORed with the
+ * input data block.
+ * In CTR mode encrypt and decrypt are identical operations.
+ * Note that the caller is responsible for incrementing the
+ * counter block.
+ */
+void  AES_ctr_encrypt(const unsigned char *in, unsigned char *out,
+                      const unsigned char *ctr, const AES_KEY *key);
+
+/**
+ * AES_xts_prep_next_tweak:
+ * @tweak: pointer to tweak value to be updated (16 bytes buffer
+ *         containing a 128 bit little endian integer)
+ *
+ * Tweak calculation for AES XTS.
+ * Prepares the next tweak value for AES-XTS mode by multiplying
+ * the current tweak by α (x) in GF(2^128) according to IEEE 1619-2007.
+ */
+void AES_xts_prep_next_tweak(unsigned char *tweak);
+
+/**
+ * AES_xts_encrypt:
+ * @in: input plaintext block of AES_BLOCK_SIZE bytes
+ * @out: output ciphertext block of AES_BLOCK_SIZE bytes
+ * @tweak: tweak value (16 bytes)
+ * @key: AES key
+ *
+ * Single block AES encrypt in XTS mode.
+ * The input is XORed with the tweak, encrypted, then XORed with
+ * the tweak again to produce the output.
+ * Note that the caller is responsible for managing the tweak value.
+ * Use AES_xts_prep_next_tweak() to advance the tweak for the next block.
+ */
+void AES_xts_encrypt(const unsigned char *in, unsigned char *out,
+                     const unsigned char *tweak, const AES_KEY *key);
+
+/**
+ * AES_xts_decrypt:
+ * @in: input ciphertext block of AES_BLOCK_SIZE bytes
+ * @out: output plaintext block of AES_BLOCK_SIZE bytes
+ * @tweak: tweak value (16 bytes)
+ * @key: AES key
+ *
+ * Single block AES decrypt in XTS mode.
+ * The input is XORed with the tweak, decrypted, then XORed with
+ * the tweak again to produce the output.
+ * Note that the caller is responsible for managing the tweak value.
+ * Use AES_xts_prep_next_tweak() to advance the tweak for the next block.
+ */
+void AES_xts_decrypt(const unsigned char *in, unsigned char *out,
+                     const unsigned char *tweak, const AES_KEY *key);
+
+#endif
-- 
2.43.0


