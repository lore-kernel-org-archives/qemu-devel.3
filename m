Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B787ACD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZmt0-00079d-AS; Wed, 17 Jun 2026 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wZmsy-000786-5S; Wed, 17 Jun 2026 05:48:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wZmsv-0003B2-Px; Wed, 17 Jun 2026 05:48:39 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8mLVN4127632; Wed, 17 Jun 2026 09:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5WPZHN4nipLaxbAuc
 TQ0zsQgbxsrfj7ZHum/FNMXkFk=; b=QM86ZQ8ZN89nM+CzL63mn9nLMtAP2imXi
 qwAv1kBNcCiDovWAgCRPMVGw80MkvUymVGGT//nMTDOeMKOhFf9MAdw3LVjRj0YZ
 ElyDYshJFZgyBBYgNooFoFyWLOH1H7MjEcH3WHuO8Lk46TuEXFmGJON67Nl3gW1v
 56HKij0qxGJih78xIGdVuMmCYSv9fR4oSb/jXqX1WDR0fj6nuZ83Otb11hnH875O
 o+kvaTTtWXxjSHgjs8+06qio7WyzOvvRauLgvF5phjinufX0ICFUK1c+Mgy43Ewd
 4xZ2RUolqq0TzaYUaLjZDit1D3W+0wmwYaq7zHIA+CeLvtm7hXYrw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtj9bb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 09:48:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H9YdK7009201;
 Wed, 17 Jun 2026 09:48:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva2hjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 09:48:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H9mO4G48300376
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 09:48:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 902C120043;
 Wed, 17 Jun 2026 09:48:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6528620040;
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
Subject: [PATCH v7 16/17] crypto: Add aes-helpers file to support some AES
 modes
Date: Wed, 17 Jun 2026 11:48:19 +0200
Message-ID: <20260617094820.34402-17-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617094820.34402-1-freude@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wTX4iAWadAPlnFGNykOj2Ik03n7czm0E
X-Proofpoint-GUID: wTX4iAWadAPlnFGNykOj2Ik03n7czm0E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX7vz908zvBctL
 2jx02ZvTGTvEyoVndJ8WQ8p3FcbXHseHHMSwp1VMm/KJvNSu2nP6hAsOHvz5TwtINQUjSO/DUpM
 /GroFcSfhFZ4G0/S1GOK/eNt38OlAKD/beqy08xb51QkuUB7drnN+GK26HTPl1G6CcGE/zD1rEV
 wrbSM/91Bw2FzYUD18qwVkXjFwIb2a9qpUCQYS/rDYO2yw+GSRdjY7LkMl/BOAhILfEDNNp+iyS
 CyMm231JhhOAOqQLni5LY9MbCEBpqGgslWLlMcqP3m5/UCaFD2v5nPEfIccT8h1KdBssu9vvioT
 uO/RZe/Xm1JHtyQR3A3lb2azqDPVCd0Q4qdif2OEz4XHwBDMg07dg/vf18/RaYVDfVapSFuHKtF
 M1dFLsq51y/EZsV/r/QVkPMzDapcN3aiRsTfuIUBZgvWVnGbMwNwu1IOsFcoZvvVd4ARaZKlDvy
 IOMQ74VBRjc7CqS9UpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfXzd/1ZabfaQl0
 /lB22mSjtD4/b9dU8R2b6Rz10gLFicgY+/Vpj/C1NXFY/cTClmvbUuP/KL6TXejENtMzZjHEFXe
 XGffamhAHiMnv6qIrCLpvaJZVhtBamA=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a326d6d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=DMI8xbQNiVaRte-C14sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170092
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
---
 crypto/aes-helpers.c | 101 +++++++++++++++++++++++++++++++++++++++++++
 crypto/meson.build   |   1 +
 include/crypto/aes.h |  14 ++++++
 3 files changed, 116 insertions(+)
 create mode 100644 crypto/aes-helpers.c

diff --git a/crypto/aes-helpers.c b/crypto/aes-helpers.c
new file mode 100644
index 0000000000..8ad3c5132a
--- /dev/null
+++ b/crypto/aes-helpers.c
@@ -0,0 +1,101 @@
+/*
+ * AES helper functions and mode implementations
+ *
+ *  Authors:
+ *   Harald Freudenberger <freude@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
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


