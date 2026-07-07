Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E31C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh8Vc-0007kN-RU; Tue, 07 Jul 2026 12:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wh8Vb-0007j7-DX; Tue, 07 Jul 2026 12:18:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wh8VX-0008Cq-Fk; Tue, 07 Jul 2026 12:18:55 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FmQab4085087; Tue, 7 Jul 2026 16:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QD/5k5
 DzQ/RYiB6J58QkL3cIc1nFoqfhZ7/raOG6trQ=; b=rAgACAIZB+4mln25Gh9Pb1
 Z2K7jTLq7bN5xBXjEndJnX8gEbh6jDDh8h/jaGagomM3PYD4JOwpZI9510EL3IUV
 7Nxd98XKKug+Uhnq8s8VOllscZTH5SIyrVWfEhX9/Cybu000Y0J8GYckN3lYHpqU
 W8gqLpHWilKi3g445LIW38K2UEn8OS5lhoZK68Z/RC5gOPo1prC/tSjfvQ3hfiwJ
 3wVdFtGK0EkwSx0YdkFVH87QOliSs8eU5TsJSBtt/Vgae+7CNMQPeEDGKIZQaHpJ
 e+JccRmt7KL8j9D6k9UMsbNJBrIvGXL+iKUaJpYkSnYw3BNAQwj0nIe0z4ftd8XA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4r5pn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 16:18:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667G4asA018702;
 Tue, 7 Jul 2026 16:18:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg3d08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 16:18:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667GIHvc44237250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 16:18:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F96B2004F;
 Tue,  7 Jul 2026 16:18:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AC9C20043;
 Tue,  7 Jul 2026 16:18:17 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.140.5])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 16:18:17 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v11 18/21] crypto: Add aes-helpers file to support some AES
 modes
Date: Tue,  7 Jul 2026 18:18:05 +0200
Message-ID: <20260707161815.40919-19-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707161815.40919-1-freude@linux.ibm.com>
References: <20260707161815.40919-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jOkJMlIjeK4DgbsKGgvbGEdHc2yj_-58
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2MCBTYWx0ZWRfX2gOpktYVo7Ox
 7sQiATV3CsveX7SSm0kemlwxULMj9r5oiOexwS4Y1RfY2t7tU415tPPWqIUg3E/fjbN1avoY5j6
 8mhZhiJpL4oy9B8zQ8LKMIXyej7IHYrvlo4nklKJ7TArxBskUsLe4aOqjd7S/Bc2EVtrlMjx9rh
 GGqXGTe7xnBuDL2OX4QZryeBv7HCBC5CYosSkrVLqrgvuPM036A4ZmmaNMpMw1B9zYdkNav0C5D
 gIl+9r8eUWL4JU6djX0InOqr8c8lRq0jhNhm4MZchfZ978I/W86u+Q7bh+Oq2th4ie7S8yxTQFF
 pcK1C1u/8UH0p1nPqgVVUBhPPJI8osAR3SdO7QTdwoB0N/wqJ6j7QOX877IJWdvTKGU3hDNydBC
 m++3WYjH6RJ/mYnqvKpmQLkWNyZ2AnbufIT8kZai7GObig7oCMyzLfVv/P/GzkNkzheK+3fU+qr
 qTP5A9hQx/20LBmktKw==
X-Proofpoint-ORIG-GUID: jOkJMlIjeK4DgbsKGgvbGEdHc2yj_-58
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4d26cd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=ZNJHLeKVfsBpcIed2koA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2MCBTYWx0ZWRfX4kgbIvYgA0b0
 VWbnQhe4c5RJN1e1C4jCtvDCwy8AIfeiz2Z0Z/ZSlzEnJ7AMKtPRviJK1C41GVGRi52sQvyw+I9
 y3VUSqyZJYCMK+8a3NcoMbVEPY/mk0w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070160
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

Add a new file crypto/aes-helpers.c with simple functions
to support some AES modes:
- AES cbc: AES_cbc_encrypt() AES_cbc_decrypt()
- AES ctr: AES_ctr_encrypt()
- AES xts: AES_xts_encrypt() AES_xts_decrypt()
and some AES related helpers:
- AES_xor()
- AES_xts_prep_next_tweak()

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
---
 crypto/aes-helpers.c | 106 +++++++++++++++++++++++++++++++++++++++++++
 crypto/meson.build   |   1 +
 include/crypto/aes.h |  14 ++++++
 3 files changed, 121 insertions(+)
 create mode 100644 crypto/aes-helpers.c

diff --git a/crypto/aes-helpers.c b/crypto/aes-helpers.c
new file mode 100644
index 0000000000..39ca153737
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
+#include <stdint.h>
+#include <string.h>
+#include "crypto/aes.h"
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
+ * This implementation has been verified on litte and big endian.
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
index b51597a879..675f27311c 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -55,6 +55,7 @@ system_ss.add(when: gnutls, if_true: files('tls-cipher-suites.c'))
 
 util_ss.add(files(
   'aes.c',
+  'aes-helpers.c',
   'clmul.c',
   'init.c',
   'sm4.c',
diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 381f24c902..df6239cb9c 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -37,4 +37,18 @@ AES_Td0[x] = Si[x].[0e, 09, 0d, 0b];
 
 extern const uint32_t AES_Te0[256], AES_Td0[256];
 
+void AES_xor(const unsigned char *src1, const unsigned char *src2,
+             unsigned char *dst);
+void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
+                     unsigned char *iv, const AES_KEY *key);
+void AES_cbc_decrypt(const unsigned char *in, unsigned char *out,
+                     unsigned char *iv, const AES_KEY *key);
+void  AES_ctr_encrypt(const unsigned char *in, unsigned char *out,
+                      const unsigned char *ctr, const AES_KEY *key);
+void AES_xts_prep_next_tweak(unsigned char *tweak);
+void AES_xts_encrypt(const unsigned char *in, unsigned char *out,
+                     const unsigned char *tweak, const AES_KEY *key);
+void AES_xts_decrypt(const unsigned char *in, unsigned char *out,
+                     const unsigned char *tweak, const AES_KEY *key);
+
 #endif
-- 
2.43.0


