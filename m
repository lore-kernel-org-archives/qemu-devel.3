Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857C6D44162
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDP8g-0005va-K8; Tue, 19 Nov 2024 09:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8d-0005uQ-T2
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:31 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8c-0006Dk-1L
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:31 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4315e62afe0so9186975e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732026208; x=1732631008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OuFWCIawDqPLhOcXaJxY7QZdpE6/L5MzAQ8FkG7rb4k=;
 b=lyhoUzNjg6pBlOCUkj4coPVEqii4joKBO36JQoheOBf5fGtMUjPvLELpUHN1E4j2fa
 VrRDvuwX/by4K8dWfROSti+VQ2o4GpdxT26qSt3WIRujsn/TFWaDKtzyvFBPOadsupkE
 NZMkLVTgX2MNwOgXtAy8Op4qoBelMtDNoGGKzQArvuWMHVOwTWib5qQYevVM5NMYDkFQ
 UwGbeP65GmaYFgtZQGnXD9p3Mf9FZUwvE5cyhks5Z662f27j7XuVTIuSWGulfQK/Thkn
 TinPbz+Kg3IDlRiSGupI2DRk90D28pt3uTsp3dry4cjsbB4SzHelrgmvxP1A8ZWMYUE6
 O7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026209; x=1732631009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OuFWCIawDqPLhOcXaJxY7QZdpE6/L5MzAQ8FkG7rb4k=;
 b=w/KPpqQFpvCifNXmFmZNgoPVRO5U/6WYosfiHGoYrL37574IULA8fMXqhsM0+khjtD
 F5DjFRdSM82zniPWCS26ZIQBLhTGITwFcJIjHMAnrsGTwYF+r5oE9ZDT03drgW6hWSSV
 Wjl4xM9s7hmdkpeduOzq9qBN39XTRJjTviEjCkglCpElU5vkHJWNReBdOzYWpgfXa467
 KypY3jDFXhWotCeDaWpHZeP58a4HrDKR7BLu8q4RA5+XlAnrc8O6KeAWbCI+GW+1eOvD
 85gVxRD7CSmlT/xt+OQVbpF1g4YsQC8El/3ueG6WDrym8cCbMrC4ANmlKrzIzb9mNpG/
 sJ9w==
X-Gm-Message-State: AOJu0YwEk0mH74IllF0neo2iHItRsITl5N3B96Y7MbVuWLm3jjD9gicP
 xIRuTYIsIKqrb61m//DOYcTVNqlkyJ0PMxM8KIAE6qwN699u0c3/ojkNuGNStO/dGtjLLZom7Ew
 A
X-Google-Smtp-Source: AGHT+IGtaJU4jS18YI/bkffYOFEqER53joOsW41TxSEcz0gw7JMSMS1snL2jaGgWetfRhYRliOjrEQ==
X-Received: by 2002:a05:600c:5487:b0:431:5f55:28ad with SMTP id
 5b1f17b1804b1-432df78c44bmr115929235e9.22.1732026208573; 
 Tue, 19 Nov 2024 06:23:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac21a15sm193049985e9.38.2024.11.19.06.23.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:23:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/15] bitops.h: Define bit operations on 'uint32_t' arrays
Date: Tue, 19 Nov 2024 14:23:16 +0000
Message-Id: <20241119142321.1853732-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142321.1853732-1-peter.maydell@linaro.org>
References: <20241119142321.1853732-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 include/qemu/bitmap.h |   8 ++
 include/qemu/bitops.h | 172 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 177 insertions(+), 3 deletions(-)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 1cf288445f3..0044333cb51 100644
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
index 2c0a2fe7512..c7b838a6283 100644
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
@@ -224,6 +255,141 @@ static inline unsigned long find_first_zero_bit(const unsigned long *addr,
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
2.34.1


