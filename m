Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D761C02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 07:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgPa-0000uW-Bp; Tue, 28 Jan 2025 02:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgPY-0000tQ-JO; Tue, 28 Jan 2025 02:53:28 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgPW-0007ly-JN; Tue, 28 Jan 2025 02:53:28 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9C7C6E1ABB;
 Tue, 28 Jan 2025 10:52:59 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 16E781A62AA;
 Tue, 28 Jan 2025 10:53:25 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 109FF51FEB; Tue, 28 Jan 2025 10:53:25 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.16 02/31] bitops.h: Define bit operations on 'uint32_t'
 arrays
Date: Tue, 28 Jan 2025 00:40:54 +0300
Message-Id: <20250127214124.3730126-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
References: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently bitops.h defines a set of operations that work on
arbitrary-length bit arrays.  However (largely because they
originally came from the Linux kernel) the bit array storage is an
array of 'unsigned long'.  This is OK for the kernel and even for
parts of QEMU where we don't really care about the underlying storage
format, but it is not good for devices, where we often want to expose
the storage to the guest and so need a type that is not
variably-sized between host OSes.

We already have a workaround for this in the GICv3 model:
arm_gicv3_common.h defines equivalents of the bit operations that
work on uint32_t.  It turns out that we should also be using
something similar in hw/intc/loongarch_extioi.c, which currently
casts a pointer to a uint32_t array to 'unsigned long *' in
extio_setirq(), which is both undefined behaviour and not correct on
a big-endian host.

Define equivalents of the set_bit() function family which work
with a uint32_t array.

(Cc stable because we're about to provide a bugfix to
loongarch_extioi which will depend on this commit.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241108135514.4006953-2-peter.maydell@linaro.org
(cherry picked from commit 3d7680fb18c7b17701730589d241a32e85f763a3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 3ccb00865f..1f35e0193f 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -69,6 +69,14 @@
 #define DECLARE_BITMAP(name,bits)                  \
         unsigned long name[BITS_TO_LONGS(bits)]
 
+/*
+ * This is for use with the bit32 versions of set_bit() etc;
+ * we don't currently support the full range of bitmap operations
+ * on bitmaps backed by an array of uint32_t.
+ */
+#define DECLARE_BITMAP32(name, bits)            \
+        uint32_t name[BITS_TO_U32S(bits)]
+
 #define small_nbits(nbits)                      \
         ((nbits) <= BITS_PER_LONG)
 
diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index 03213ce952..888ac7f0e6 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -18,16 +18,47 @@
 
 #define BITS_PER_BYTE           CHAR_BIT
 #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
+#define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
+#define BITS_TO_U32S(nr)        DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(uint32_t))
 
 #define BIT(nr)                 (1UL << (nr))
 #define BIT_ULL(nr)             (1ULL << (nr))
-#define BIT_MASK(nr)            (1UL << ((nr) % BITS_PER_LONG))
-#define BIT_WORD(nr)            ((nr) / BITS_PER_LONG)
-#define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 
 #define MAKE_64BIT_MASK(shift, length) \
     (((~0ULL) >> (64 - (length))) << (shift))
 
+/**
+ * DOC: Functions operating on arrays of bits
+ *
+ * We provide a set of functions which work on arbitrary-length arrays of
+ * bits. These come in several flavours which vary in what the type of the
+ * underlying storage for the bits is:
+ *
+ * - Bits stored in an array of 'unsigned long': set_bit(), clear_bit(), etc
+ * - Bits stored in an array of 'uint32_t': set_bit32(), clear_bit32(), etc
+ *
+ * Because the 'unsigned long' type has a size which varies between
+ * host systems, the versions using 'uint32_t' are often preferable.
+ * This is particularly the case in a device model where there may
+ * be some guest-visible register view of the bit array.
+ *
+ * We do not currently implement uint32_t versions of find_last_bit(),
+ * find_next_bit(), find_next_zero_bit(), find_first_bit() or
+ * find_first_zero_bit(), because we haven't yet needed them. If you
+ * need them you should implement them similarly to the 'unsigned long'
+ * versions.
+ *
+ * You can declare a bitmap to be used with these functions via the
+ * DECLARE_BITMAP and DECLARE_BITMAP32 macros in bitmap.h.
+ */
+
+/**
+ * DOC:  'unsigned long' bit array APIs
+ */
+
+#define BIT_MASK(nr)            (1UL << ((nr) % BITS_PER_LONG))
+#define BIT_WORD(nr)            ((nr) / BITS_PER_LONG)
+
 /**
  * set_bit - Set a bit in memory
  * @nr: the bit to set
@@ -211,6 +242,141 @@ static inline unsigned long find_first_zero_bit(const unsigned long *addr,
     return find_next_zero_bit(addr, size, 0);
 }
 
+/**
+ * DOC:  'uint32_t' bit array APIs
+ */
+
+#define BIT32_MASK(nr)            (1UL << ((nr) % 32))
+#define BIT32_WORD(nr)            ((nr) / 32)
+
+/**
+ * set_bit32 - Set a bit in memory
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ */
+static inline void set_bit32(long nr, uint32_t *addr)
+{
+    uint32_t mask = BIT32_MASK(nr);
+    uint32_t *p = addr + BIT32_WORD(nr);
+
+    *p  |= mask;
+}
+
+/**
+ * set_bit32_atomic - Set a bit in memory atomically
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ */
+static inline void set_bit32_atomic(long nr, uint32_t *addr)
+{
+    uint32_t mask = BIT32_MASK(nr);
+    uint32_t *p = addr + BIT32_WORD(nr);
+
+    qatomic_or(p, mask);
+}
+
+/**
+ * clear_bit32 - Clears a bit in memory
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ */
+static inline void clear_bit32(long nr, uint32_t *addr)
+{
+    uint32_t mask = BIT32_MASK(nr);
+    uint32_t *p = addr + BIT32_WORD(nr);
+
+    *p &= ~mask;
+}
+
+/**
+ * clear_bit32_atomic - Clears a bit in memory atomically
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ */
+static inline void clear_bit32_atomic(long nr, uint32_t *addr)
+{
+    uint32_t mask = BIT32_MASK(nr);
+    uint32_t *p = addr + BIT32_WORD(nr);
+
+    return qatomic_and(p, ~mask);
+}
+
+/**
+ * change_bit32 - Toggle a bit in memory
+ * @nr: Bit to change
+ * @addr: Address to start counting from
+ */
+static inline void change_bit32(long nr, uint32_t *addr)
+{
+    uint32_t mask = BIT32_MASK(nr);
+    uint32_t *p = addr + BIT32_WORD(nr);
+
+    *p ^= mask;
+}
+
+/**
+ * test_and_set_bit32 - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ */
+static inline int test_and_set_bit32(long nr, uint32_t *addr)
+{
+    uint32_t mask = BIT32_MASK(nr);
+    uint32_t *p = addr + BIT32_WORD(nr);
+    uint32_t old = *p;
+
+    *p = old | mask;
+    return (old & mask) != 0;
+}
+
+/**
+ * test_and_clear_bit32 - Clear a bit and return its old value
+ * @nr: Bit to clear
+ * @addr: Address to count from
+ */
+static inline int test_and_clear_bit32(long nr, uint32_t *addr)
+{
+    uint32_t mask = BIT32_MASK(nr);
+    uint32_t *p = addr + BIT32_WORD(nr);
+    uint32_t old = *p;
+
+    *p = old & ~mask;
+    return (old & mask) != 0;
+}
+
+/**
+ * test_and_change_bit32 - Change a bit and return its old value
+ * @nr: Bit to change
+ * @addr: Address to count from
+ */
+static inline int test_and_change_bit32(long nr, uint32_t *addr)
+{
+    uint32_t mask = BIT32_MASK(nr);
+    uint32_t *p = addr + BIT32_WORD(nr);
+    uint32_t old = *p;
+
+    *p = old ^ mask;
+    return (old & mask) != 0;
+}
+
+/**
+ * test_bit32 - Determine whether a bit is set
+ * @nr: bit number to test
+ * @addr: Address to start counting from
+ */
+static inline int test_bit32(long nr, const uint32_t *addr)
+{
+    return 1U & (addr[BIT32_WORD(nr)] >> (nr & 31));
+}
+
+/**
+ * DOC: Miscellaneous bit operations on single values
+ *
+ * These functions are a collection of useful operations
+ * (rotations, bit extract, bit deposit, etc) on single
+ * integer values.
+ */
+
 /**
  * rol8 - rotate an 8-bit value left
  * @word: value to rotate
-- 
2.39.5


