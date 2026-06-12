Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356B3CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY6Ee-0005zg-Tu; Fri, 12 Jun 2026 14:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wY6Ea-0005xx-S9
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 14:04:00 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wY6EY-0000Yo-Dj
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 14:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1781287434;
 bh=r5yIP2Q4ILfJcIWsHFE12PI8Ouc0eJDYGoFsNYLFVgU=;
 h=From:To:Cc:Subject:Date:From;
 b=pGB+dTX0WN3U/ktwHh+9TfobnXGm11PXdl6qsC+sgGa0O2oYUFlJwA+lw1AQecs8S
 CLFL/OkjZexfAPWzWdWI5+Mlj7lT+nfc2X7+sG5xL6dBMW6UFzhGeAm8pY9/HzJwc9
 PirI7rCEx0kkpbCuYIdMNEK2yad7U9uK3VEHF+8oLF3gbnQDOTKSJeL9AK/a4zKjsF
 Ee6Ub39IL6dKofXALMs1x54hPMCTE79ouSDQ+EgyVRnwUNV+izsK7Ldpzs4e/s8E+h
 AJX79By1U32CJkSM9MkpL3dxbgEsc+A7jZJrcPGbSP4vQnxeiux3ihUGa1A1C5yrvJ
 eTXMS07waRIjw==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 2753C4028C;
 Fri, 12 Jun 2026 20:03:54 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub-1.u-ga.fr (Postfix) with ESMTP id 23CC5FF852;
 Fri, 12 Jun 2026 20:03:54 +0200 (CEST)
Received: from naga.. (unknown [37.167.227.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 37F15140101;
 Fri, 12 Jun 2026 20:03:53 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
To: philmd@mailo.com, pierrick.bouvier@oss.qualcomm.com, mst@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH 1/2] include/qemu/bswap.h: Add support for Int128 byte swaps
Date: Fri, 12 Jun 2026 20:03:45 +0200
Message-ID: <20260612180346.890429-1-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The recent introduction of endianness support is providing
a clean framework for the standard integer data types.
This patch adds support for the non-standard Int128 type QEMU provides.
Note that the ldn and sdn functions still keep an uint64_t as argument
and return value to avoid performance overhead.

Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 include/qemu/bswap.h | 63 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 387d65c0b0..bdc335c63f 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -40,20 +40,20 @@ static inline void bswap64s(uint64_t *s)
 
 #if HOST_BIG_ENDIAN
 #define be_bswap(v, size) (v)
-#define le_bswap(v, size) glue(__builtin_bswap, size)(v)
+#define le_bswap(v, size) glue(bswap, size)(v)
 #define be_bswap24(v) (v)
 #define le_bswap24(v) bswap24(v)
 #define be_bswaps(v, size)
 #define le_bswaps(p, size) \
-            do { *p = glue(__builtin_bswap, size)(*p); } while (0)
+            do { *p = glue(bswap, size)(*p); } while (0)
 #else
 #define le_bswap(v, size) (v)
 #define be_bswap24(v) bswap24(v)
 #define le_bswap24(v) (v)
-#define be_bswap(v, size) glue(__builtin_bswap, size)(v)
+#define be_bswap(v, size) glue(bswap, size)(v)
 #define le_bswaps(v, size)
 #define be_bswaps(p, size) \
-            do { *p = glue(__builtin_bswap, size)(*p); } while (0)
+            do { *p = glue(bswap, size)(*p); } while (0)
 #endif
 
 /**
@@ -64,9 +64,11 @@ static inline void bswap64s(uint64_t *s)
  * uint16_t le16_to_cpu(uint16_t v);
  * uint32_t le32_to_cpu(uint32_t v);
  * uint64_t le64_to_cpu(uint64_t v);
+ * Int128 le128_to_cpu(Int128 v);
  * uint16_t be16_to_cpu(uint16_t v);
  * uint32_t be32_to_cpu(uint32_t v);
  * uint64_t be64_to_cpu(uint64_t v);
+ * Int128 be128_to_cpu(Int128 v);
  *
  * Convert the value @v from the specified format to the native
  * endianness of the host CPU by byteswapping if necessary, and
@@ -75,9 +77,11 @@ static inline void bswap64s(uint64_t *s)
  * uint16_t cpu_to_le16(uint16_t v);
  * uint32_t cpu_to_le32(uint32_t v);
  * uint64_t cpu_to_le64(uint64_t v);
+ * Int128 cpu_to_le128(Int128 v);
  * uint16_t cpu_to_be16(uint16_t v);
  * uint32_t cpu_to_be32(uint32_t v);
  * uint64_t cpu_to_be64(uint64_t v);
+ * Int128 cpu_to_be128(Int128 v);
  *
  * Convert the value @v from the native endianness of the host CPU to
  * the specified format by byteswapping if necessary, and return
@@ -86,9 +90,11 @@ static inline void bswap64s(uint64_t *s)
  * void le16_to_cpus(uint16_t *v);
  * void le32_to_cpus(uint32_t *v);
  * void le64_to_cpus(uint64_t *v);
+ * void le128_to_cpus(Int128 *v);
  * void be16_to_cpus(uint16_t *v);
  * void be32_to_cpus(uint32_t *v);
  * void be64_to_cpus(uint64_t *v);
+ * void be128_to_cpus(Int128 *v);
  *
  * Do an in-place conversion of the value pointed to by @v from the
  * specified format to the native endianness of the host CPU.
@@ -96,9 +102,11 @@ static inline void bswap64s(uint64_t *s)
  * void cpu_to_le16s(uint16_t *v);
  * void cpu_to_le32s(uint32_t *v);
  * void cpu_to_le64s(uint64_t *v);
+ * void cpu_to_le128s(Int128 *v);
  * void cpu_to_be16s(uint16_t *v);
  * void cpu_to_be32s(uint32_t *v);
  * void cpu_to_be64s(uint64_t *v);
+ * void cpu_to_be128s(Int128 *v);
  *
  * Do an in-place conversion of the value pointed to by @v from the
  * native endianness of the host CPU to the specified format.
@@ -138,10 +146,12 @@ static inline void cpu_to_ ## endian ## size ## s(type *p)\
 CPU_CONVERT(be, 16, uint16_t)
 CPU_CONVERT(be, 32, uint32_t)
 CPU_CONVERT(be, 64, uint64_t)
+CPU_CONVERT(be, 128, Int128)
 
 CPU_CONVERT(le, 16, uint16_t)
 CPU_CONVERT(le, 32, uint32_t)
 CPU_CONVERT(le, 64, uint64_t)
+CPU_CONVERT(le, 128, Int128)
 
 #undef CPU_CONVERT
 
@@ -149,6 +159,8 @@ CPU_CONVERT(le, 64, uint64_t)
  * Same as cpu_to_le{16,32,64}, except that gcc will figure the result is
  * a compile-time constant if you pass in a constant.  So this can be
  * used to initialize static variables.
+ * The 128 case is ruled out because we must call int128_funcs during
+ * this initialization.
  */
 #if HOST_BIG_ENDIAN
 # define const_le64(_x)                          \
@@ -200,6 +212,7 @@ CPU_CONVERT(le, 64, uint64_t)
  *   24: 24 bits
  *   l: 32 bits
  *   q: 64 bits
+ *   o: 128 bits
  *
  * endian is:
  *   he   : host endian
@@ -296,6 +309,18 @@ static inline void stq_he_p(void *ptr, uint64_t v)
     __builtin_memcpy(ptr, &v, sizeof(v));
 }
 
+static inline Int128 ldo_he_p(const void *ptr)
+{
+    Int128 r;
+    __builtin_memcpy(&r, ptr, sizeof(r));
+    return r;
+}
+
+static inline void sto_he_p(void *ptr, Int128 v)
+{
+    __builtin_memcpy(ptr, &v, sizeof(v));
+}
+
 static inline int lduw_le_p(const void *ptr)
 {
     return (uint16_t)le_bswap(lduw_he_p(ptr), 16);
@@ -316,6 +341,11 @@ static inline uint64_t ldq_le_p(const void *ptr)
     return le_bswap(ldq_he_p(ptr), 64);
 }
 
+static inline Int128 ldo_le_p(const void *ptr)
+{
+    return le_bswap(ldo_he_p(ptr), 128);
+}
+
 static inline void stw_le_p(void *ptr, uint16_t v)
 {
     stw_he_p(ptr, le_bswap(v, 16));
@@ -336,6 +366,11 @@ static inline void stq_le_p(void *ptr, uint64_t v)
     stq_he_p(ptr, le_bswap(v, 64));
 }
 
+static inline void sto_le_p(void *ptr, Int128 v)
+{
+    sto_he_p(ptr, le_bswap(v, 128));
+}
+
 static inline int lduw_be_p(const void *ptr)
 {
     return (uint16_t)be_bswap(lduw_he_p(ptr), 16);
@@ -356,6 +391,11 @@ static inline uint64_t ldq_be_p(const void *ptr)
     return be_bswap(ldq_he_p(ptr), 64);
 }
 
+static inline Int128 ldo_be_p(const void *ptr)
+{
+    return be_bswap(ldo_he_p(ptr), 128);
+}
+
 static inline void stw_be_p(void *ptr, uint16_t v)
 {
     stw_he_p(ptr, be_bswap(v, 16));
@@ -376,6 +416,11 @@ static inline void stq_be_p(void *ptr, uint64_t v)
     stq_he_p(ptr, be_bswap(v, 64));
 }
 
+static inline void sto_be_p(void *ptr, Int128 v)
+{
+    sto_he_p(ptr, be_bswap(v, 128));
+}
+
 
 /**
  * ldm_p: Load value from host memory (byteswapping if necessary)
@@ -526,6 +571,11 @@ static inline uint64_t ldq_p(const void *ptr)
     LOAD_IMPL(q, ptr);
 }
 
+static inline Int128 ldo_p(const void *ptr)
+{
+    LOAD_IMPL(o, ptr);
+}
+
 static inline uint64_t ldn_p(const void *ptr, int sz)
 {
     LOAD_IMPL(n, ptr, sz);
@@ -559,6 +609,11 @@ static inline void stq_p(void *ptr, uint64_t v)
     STORE_IMPL(q, ptr, v);
 }
 
+static inline void sto_p(void *ptr, Int128 v)
+{
+    STORE_IMPL(o, ptr, v);
+}
+
 static inline void stn_p(void *ptr, int sz, uint64_t v)
 {
     STORE_IMPL(n, ptr, sz, v);
-- 
2.43.0


