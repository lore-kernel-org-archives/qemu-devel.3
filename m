Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395E4C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 16:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wey5l-0006Mw-39; Wed, 01 Jul 2026 12:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wey5e-0006HR-A6; Wed, 01 Jul 2026 12:47:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wey5Z-0002rU-3q; Wed, 01 Jul 2026 12:47:09 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661AIOTr494396; Wed, 1 Jul 2026 16:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=F+UMGpZQYY5oCtCad
 l4DVVSQMMO7Tg14YadLoyTOYQE=; b=a3LtGpXDT2bVtJQwdBKylNRdGxeWhF9Va
 VYr8HWAuHj+L9QSScBc/NZSENdny1JTRPMBLAHKO0pyLMqtjRI6HuS1ad5l1oUWT
 evhWlGeU0OGcyy1GjnnPN00NSVsvVCqr8TR5U9N3mjaYYoUJpNdrHTNQ2+TDLoo0
 4eCKNat6XkKr5GhokGhNOPEfu8qMPb952TZrfRI///CyYP6RueRse6646V1GTHfj
 dWbaGECbmpAB8PKs2IEFZmPK8QWRxPFvkJlDgI9JD442K4UDxyKocXH+J1vR4EKi
 EIAJvnO2nF1lVXYCCyXpAriD7pMWHRatmy4ffWIixU1l/0klmL9HA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf56f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 16:46:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661GYgsk023278;
 Wed, 1 Jul 2026 16:46:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhg3wk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 16:46:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 661Gkswr28443284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 16:46:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3A6C2005A;
 Wed,  1 Jul 2026 16:46:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D64872004E;
 Wed,  1 Jul 2026 16:46:53 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.187.249])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 16:46:53 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v9 10/21] target/s390x: Base support for cpacf protected keys
Date: Wed,  1 Jul 2026 18:46:33 +0200
Message-ID: <20260701164650.95760-11-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701164650.95760-1-freude@linux.ibm.com>
References: <20260701164650.95760-1-freude@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a454482 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=pDJEeJrE-AQHYYEhGn0A:9
X-Proofpoint-ORIG-GUID: er4QiaaBo5RgTkhGI9rp6oXwJmdCPCw-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfX8zPociUUh8cY
 NQ8o/DUOr5N7EVBeYzHwRRR2hd1lQZi77aXhz1qOH2UO2q0wiazq1rw8bmkNRc8YX/r0Kd627MI
 ucQL1XXwqrFsgpTZPFo2Wy2rjy/x2synwl4DZbGVvEFDGovepPyy9Vpdi3OzZ8F8WQ2L8oYDhkC
 FhZ5eIIhsJUWGMFntW0qMMDfa1JuErFHW/VkFF6x3ewhwA3wvOsweqhAuvA3D/EyGHfOd9BWRmR
 O2UDrLXoIiFpX8QDRd3QD6e6QTpYMlU7jZ6AeAWTWz2+pVFM1cWxnqcLhP2KIcPh5p556lmBRSF
 E91b+CB8NLS7GN+MzxWPiTV5QNWcwNbsoZTqjBQ/KVD5UEO/HnsR5+bgtLai9C8TlrCatkpQ6LD
 ZwnolwzoKLtT5nwHmDK3uNgyS6YneRoUZgY/G60gnWcF6AzPjHSTIkru2GyI7FxIx5j5sdw5ZAb
 3jB5dYz61ZXcg+O5HKg==
X-Proofpoint-GUID: er4QiaaBo5RgTkhGI9rp6oXwJmdCPCw-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfX+UF57RmWfhRU
 P6OzvUKLZwWP2/qBxTn/Ng2zfsbvFxZz0/pBI6t0ImhRTEfXrZcGbq9u4Tb0RDFv5ipdYBuBcK9
 68PwQyyzOdObzHI3YGcZsvgKm0vvge0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010173
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

Add base support for cpacf protected key handling.

The qemu version provided here is only a fake intended to make
protected key available for developing and testing purpose:
* The protected key is 'derived' from the clear key by xoring
  the fixed pattern 0xAAAA... onto the key value.
* The AES Wrapping Key Verification Pattern is a fixed
  value of 32 bytes 0xFACEFACE...

Add preprocessor defines for the xor pattern and wkvp used to
construct ('encrypt') a protected key from a clear key value with
this implementation. Also add some static functions to 'encrypt'
from clear key to protected key and 'decrypt' back to cpacf_aes.c.

The preprocessor defines shall be used later in testcases to
construct and decode protected keys.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/tcg/cpacf.h     | 25 +++++++++++++++++++++++
 target/s390x/tcg/cpacf_aes.c | 39 ++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index e585b77766..df7f258443 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -254,4 +254,29 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod);
 
+/*
+ * Support for protected key cpacf functions. Note that this is
+ * a fake implementation intended for debugging and development.
+ * Do not use for production load !
+ */
+
+/*
+ * Hard coded pattern xored with the AES clear key
+ * to 'produce' the protected key.
+ */
+#define PROTKEY_XOR_PATTERN { \
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, \
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, \
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, \
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA }
+
+/*
+ * Hard coded wkvp ("Wrapping Key Verification Pattern")
+ */
+#define PROTKEY_WKVP { \
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E, \
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E, \
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E, \
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E }
+
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 4a28cc3d7c..6702006b66 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -461,3 +461,42 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+/*
+ * Support for protected key cpacf functions. Note that this is
+ * a fake implementation intended for debugging and development.
+ * Do not use for production load !
+ */
+
+/*
+ * Hard coded pattern xored with the AES clear key
+ * to 'produce' the protected key.
+ */
+static const uint8_t protkey_xor_pattern[32] = PROTKEY_XOR_PATTERN;
+
+/*
+ * Hard coded wkvp ("Wrapping Key Verification Pattern")
+ */
+static const uint8_t protkey_wkvp[32] = PROTKEY_WKVP;
+
+/*
+ * 'encrypt' the clear key value into a protected key
+ * by xor-ing the protkey_xor_pattern onto it.
+ */
+static void encrypt_clrkey(uint8_t *key, int keysize)
+{
+    for (int i = 0; i < keysize; i++) {
+        key[i] ^= protkey_xor_pattern[i];
+    }
+}
+
+/*
+ * 'decrypt' the protected key by reverting the xor
+ * of the protkey_xor_pattern onto the clear key value.
+ */
+static void decrypt_protkey(uint8_t *key, int keysize)
+{
+    for (int i = 0; i < keysize; i++) {
+        key[i] ^= protkey_xor_pattern[i];
+    }
+}
-- 
2.43.0


