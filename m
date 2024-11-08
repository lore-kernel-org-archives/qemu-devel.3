Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36289D5C0C8
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 13:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9PSM-000758-36; Fri, 08 Nov 2024 08:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9PSL-00074P-4z
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:55:21 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9PSI-0005am-9g
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:55:20 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso12935025e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 05:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731074117; x=1731678917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8MLS0ts7CduEeJRIoLccc9jglcL03es1fitzm9sV2Cg=;
 b=m3VDiIBmh+kyU/Nl0rhr0YH0y8Fz9sWUI1W7JNt4AnsgKGO9A1yGyaTmsyu4/8AJkb
 JMi5n2+fjeUMiJrnpOVsQ0D19DUVtXBweq5aT0yUmxKRw0L25a5MKI+N02ED3xSZPwZu
 lt3M7+e9kSEK/Z1gf3bx1e2IiLRbQ38XXpcrWcTG6RrhjZ6qf9SKH0v3/jzjYOJQQY+8
 CK0hJURxN2pPS63mBZ3yaaPX8ZWvan+/De39JQ1mPdhlP8e/E4jvU3s84NVFSAz63A0k
 DJeWHDSfAs637XWzIDYRaD7KAIpFgvfid0M8jq9c2LOJ5LzInFEtQlo6MshIFdFIjj9c
 cvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731074117; x=1731678917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8MLS0ts7CduEeJRIoLccc9jglcL03es1fitzm9sV2Cg=;
 b=HUs9yDswtMg30EskwliZ6vxGcz87ObURjOku0cMyQOGzdh9VgmxmfVNnhN9o7CFHyJ
 01OGdeWcKZyMZ1JL6BK7rj34V1vE8VbspVKEOdt3ZVRxS1MZKcafX9WCI3kpAdUCPtq2
 QFfGSoVjF65OHJ1rQmDnMhArqjF0EPTJ+q5a5gp4JcdxnFomoXF+rmUPg9V6BtBLn83m
 1EI06OhZgCszeCI+ZGKToxeGjQZum3tUbaLya/5rFZT7vu+2AerrN8g9eihcYcE+oEKj
 0oEo5wsEhuDoFZb9slGO9hvHQaKewCd2/wrYXSc+qcf0dWswPT5LWH2rEHFzy6hyBt/P
 JsUA==
X-Gm-Message-State: AOJu0YyFoBY5oojK3LzVhXzgARpt044ZBmGaX9AuxWaplqv4tAOLM27m
 YpIO81cfZ0sJJd9S8XovN6foWrNUbGLnlxnRJ/X6tZFF4r9H7L/i7ux8ahdfIFDBGfH3a01KVHg
 8
X-Google-Smtp-Source: AGHT+IFhq6MgfbmBhRURYCi/2d8bIdb7KHayV0/NbRQ9JYMyBCvO2GU1pERV2Hd09Al5NADPUk8tng==
X-Received: by 2002:a05:600c:3b9c:b0:431:52da:9d89 with SMTP id
 5b1f17b1804b1-432b743575emr23486075e9.1.1731074116536; 
 Fri, 08 Nov 2024 05:55:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa70a2ccsm110082855e9.31.2024.11.08.05.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 05:55:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/3] bitops.h: Define bit operations on 'uint32_t' arrays
Date: Fri,  8 Nov 2024 13:55:12 +0000
Message-Id: <20241108135514.4006953-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108135514.4006953-1-peter.maydell@linaro.org>
References: <20241108135514.4006953-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 include/qemu/bitmap.h |   8 ++
 include/qemu/bitops.h | 172 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 177 insertions(+), 3 deletions(-)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 1cf288445f3..14e51e50a9f 100644
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
+#define DECLARE_BITMAP32(name,bits)             \
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


