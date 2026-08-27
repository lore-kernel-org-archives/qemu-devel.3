Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0CCC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSOQ-0003Ye-84; Thu, 27 Aug 2026 01:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSOO-0003J0-1G
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:11:12 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSOL-0004BW-SS
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:11:11 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so1455468a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787807468; x=1788412268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7MocgzezO4mcFVyQD9N6vjeWFD6TnB7x7CFs1bu2VXk=;
 b=aoXg35RJWN6JfqFcXcLCDzKBzWFPBn3WyhT/E4my3emL0yg2vr+f87WVKRpwbIVT/j
 8gwNIYdkUuVBO5ZwLbUPtoTgTgQEhRWhP1qw8p87Pbf79ijBmRCz2jgytaozaaqiU2Er
 glZfVRRJ1Bm5+vsvwbazlWq/Qlr6JuKZyot6XsZPPKKFhoq1N01iBPrAaQpnWVv8H2FL
 aYtpuphbXvtTgb43srjAEF+NLqt8SF6+cKA4XuCrfUCw1sEvHMXa87o2gftIRr94o1/9
 DeTNx4AO/Z4u5cteMRds+CBKn3XpjxfqHZFvSJJwF4rxc7/npWl/EYRbApbp6VwQzgmH
 2R3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787807468; x=1788412268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7MocgzezO4mcFVyQD9N6vjeWFD6TnB7x7CFs1bu2VXk=;
 b=DxPsP3sooWZWc5wB0XkLyMniL2xYqfodJKUs+SJeJmsathEWgZHy8+pfiIzMrNR//I
 ag+iiw6PaDDVjeskaSUY+REIBnMIgM4tLglwlcjw6BrdNan10fyZyQnqeDB2tazzkGQA
 ZTFQPjyB7eJayU1o6N0cqrBWxu8rU1ZmOnGMrigv/vN+rMdGEmrZRrIahAVTf3faaTWv
 mo285um7tSSd3WYjAV04YLgIP5CmBER+Kh1HyLOCBtB3VfQzLW48uzpdb9qJuFasqL8P
 RwssYJ390xaHs83uSuJA1s+JNCqUFFpYrhiPUuOG88iu0JNC9k8dPOrduFKwTOFjfI8w
 HZwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1jXJk7jECdhgMxxiHgO0f2MSZowH+N5p1QW/taddeOY3PziJJRQ4lytTg4o7Vpsa8DM1M4Ojs6ex5@nongnu.org
X-Gm-Message-State: AFuF++mGg2E+VM6mdT/IN+Qm+vo5i1VE1ex4XyqL2uLjTAD8ncEmbC+t
 LLR1KM7Yw8T7uezNeOWMW/ek9e/oD/LcwUxaBXV/M217rUQeGzVGQTo6
X-Gm-Gg: AR+sD12YgVj6fZ5+tWiEsYco0hcc4x+CGXQ9H84B4Ofvl3R5CKO3FIXegrf5P4cYDAn
 iDh+koRaJzPAvDJOOS4eHM4pjr0FEOS4grD8PhgOulvytD+9eUknsF6BEH85hh482+ULPKbkfGl
 Ve33mnOrr1oXc9jemk/mp4UXJQQxeBfAK8zMdzKf1cJTMr6Ng9rrgt7/fxJpa9eA4mLC4+YsmSX
 pGEYtH2m2aH6BuiOXgq42cXXRbUjNmBidhZgNyhYsCNz8vA/GENWpitMNVzX5EQjRKhbf7TdZk1
 Mr4GmXrfidr6FxSk1HH5dPkMuQ/c7ujbUlAdXNdDnLdAO1x2bljkxuuthL+Pz77Snt65eBjERVp
 AjR1NCJauSWFHivixhZjrW0x3hqJuCX2F0o2sEA7yRoSc8rwmhiozRnENYTdMpdIWVdPOWrzydV
 Lwz3Vx6moK6VO6EbV31/bEs00L/NzK4udCMGa41wnV49JXKz8KP1MtzhhI8UqF7JK8mOR5iQPHx
 liI7De2AHvc4/ti8YEHpq9pyo3v90yzpNLAgifOs1hieXWS6vuL9ulzfFletARQ3f0AMlBUri84
 AvgPhQ7TFh0te+pucnicNw==
X-Received: by 2002:a17:90b:54cb:b0:380:f389:447b with SMTP id
 98e67ed59e1d1-3966d40becdmr26287538a91.11.1787807468439; 
 Wed, 26 Aug 2026 22:11:08 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39670599275sm2210473a91.0.2026.08.26.22.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 22:11:07 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 09/12] tests/tcg/multiarch: Fix vectorisation of memory test
Date: Thu, 27 Aug 2026 14:39:48 +0930
Message-ID: <20260827050953.67184-10-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827050953.67184-1-joel@jms.id.au>
References: <20260827050953.67184-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Compilers are not able to vectorise the load and store loops. Building
with -fopt-info-vec-missed with gcc 16.1:

  missed: statement clobbers memory: ml_printf (".");

This can be fixed by doing the printf after the loops.

Also, autovectorisation doesn't like more than one if statement in the
loop:

  missed: not vectorized: unsupported control flow in loop.

By combining them into ternary statements and one if, the loops are able
to be vectorised with both loads and stores.

The trade off is the dots are gone, and the tests no longer report fine
grained miscompares. A failure does report the number of bad elements in
a failing test loop.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tests/tcg/multiarch/system/memory.c | 113 ++++++++++++----------------
 1 file changed, 50 insertions(+), 63 deletions(-)

diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
index 7508f6b916d0..6eeb738343ab 100644
--- a/tests/tcg/multiarch/system/memory.c
+++ b/tests/tcg/multiarch/system/memory.c
@@ -42,9 +42,6 @@ static void pdot(int count, bool write)
     } else {
         test_read_count++;
     }
-    if (count % 128 == 0) {
-        ml_printf(".");
-    }
 }
 
 /*
@@ -77,7 +74,6 @@ static void init_test_data_u8(int unused_offset)
         *ptr++ = BYTE_NEXT(count);
         pdot(i, true);
     }
-
     ml_printf("done %d @ %p\n", i, ptr);
 }
 
@@ -127,7 +123,6 @@ static void reset_start_data(int offset)
         *ptr++ = 0;
         pdot(i, true);
     }
-
     ml_printf("done %d @ %p\n", i, ptr);
 }
 
@@ -203,7 +198,7 @@ static void init_test_data_u64(int offset)
 static bool read_test_data_u16(int offset)
 {
     uint16_t word, *ptr = (uint16_t *)&test_data[offset];
-    int i;
+    int i, bad = 0;
     const int max = (TEST_SIZE - offset) / sizeof(word);
 
     ml_printf("Reading u16 from %#lx (offset %d):", ptr, offset);
@@ -214,12 +209,13 @@ static bool read_test_data_u16(int offset)
         high = (word >> 8) & 0xff;
         low = word & 0xff;
         if (high < low && high != 0) {
-            ml_printf("Error %d < %d\n", high, low);
-            return false;
-        } else {
-            pdot(i, false);
+            bad++;
         }
-
+    }
+    test_read_count += max;
+    if (bad) {
+        ml_printf("Error: %d bad u16 words\n", bad);
+        return false;
     }
     ml_printf("done %d @ %p\n", i, ptr);
     return true;
@@ -228,7 +224,7 @@ static bool read_test_data_u16(int offset)
 static bool read_test_data_u32(int offset)
 {
     uint32_t word, *ptr = (uint32_t *)&test_data[offset];
-    int i;
+    int i, bad = 0;
     const int max = (TEST_SIZE - offset) / sizeof(word);
 
     ml_printf("Reading u32 from %#lx (offset %d):", ptr, offset);
@@ -247,21 +243,18 @@ static bool read_test_data_u32(int offset)
         zeros += (b2 == 0 ? 1 : 0);
         zeros += (b3 == 0 ? 1 : 0);
         zeros += (b4 == 0 ? 1 : 0);
-        if (zeros > 1) {
-            ml_printf("Error @ %p, more zeros than expected: %d, %d, %d, %d",
-                      ptr - 1, b1, b2, b3, b4);
-            return false;
-        }
-
-        if ((b1 < b2 && b1 != 0) ||
+        if (zeros > 1 ||
+            (b1 < b2 && b1 != 0) ||
             (b2 < b3 && b2 != 0) ||
             (b3 < b4 && b3 != 0)) {
-            ml_printf("Error %d, %d, %d, %d", b1, b2, b3, b4);
-            return false;
-        } else {
-            pdot(i, false);
+            bad++;
         }
     }
+    test_read_count += max;
+    if (bad) {
+        ml_printf("Error: %d bad u32 words\n", bad);
+        return false;
+    }
     ml_printf("done %d @ %p\n", i, ptr);
     return true;
 }
@@ -270,7 +263,7 @@ static bool read_test_data_u32(int offset)
 static bool read_test_data_u64(int offset)
 {
     uint64_t word, *ptr = (uint64_t *)&test_data[offset];
-    int i;
+    int i, bad = 0;
     const int max = (TEST_SIZE - offset) / sizeof(word);
 
     ml_printf("Reading u64 from %#lx (offset %d):", ptr, offset);
@@ -297,26 +290,22 @@ static bool read_test_data_u64(int offset)
         zeros += (b6 == 0 ? 1 : 0);
         zeros += (b7 == 0 ? 1 : 0);
         zeros += (b8 == 0 ? 1 : 0);
-        if (zeros > 1) {
-            ml_printf("Error @ %p, more zeros than expected: %d, %d, %d, %d, %d, %d, %d, %d",
-                      ptr - 1, b1, b2, b3, b4, b5, b6, b7, b8);
-            return false;
-        }
-
-        if ((b1 < b2 && b1 != 0) ||
+        if (zeros > 1 ||
+            (b1 < b2 && b1 != 0) ||
             (b2 < b3 && b2 != 0) ||
             (b3 < b4 && b3 != 0) ||
             (b4 < b5 && b4 != 0) ||
             (b5 < b6 && b5 != 0) ||
             (b6 < b7 && b6 != 0) ||
             (b7 < b8 && b7 != 0)) {
-            ml_printf("Error %d, %d, %d, %d, %d, %d, %d, %d",
-                      b1, b2, b3, b4, b5, b6, b7, b8);
-            return false;
-        } else {
-            pdot(i, false);
+            bad++;
         }
     }
+    test_read_count += max;
+    if (bad) {
+        ml_printf("Error: %d bad u64 words\n", bad);
+        return false;
+    }
     ml_printf("done %d @ %p\n", i, ptr);
     return true;
 }
@@ -374,28 +363,26 @@ static bool do_unsigned_test(init_ufn fn)
 static bool read_test_data_s8(int offset, bool neg_first)
 {
     int8_t *ptr = (int8_t *)&test_data[offset];
-    int i;
+    int i, bad = 0;
     const int max = (TEST_SIZE - offset) / 2;
 
     ml_printf("Reading s8 pairs from %#lx (offset %d):", ptr, offset);
 
     for (i = 0; i < max; i++) {
         int16_t first, second;
-        bool ok;
         first = *ptr++;
         second = *ptr++;
 
-        if (neg_first && first < 0 && second > 0) {
-            pdot(i, false);
-            pdot(i, false);
-        } else if (!neg_first && first > 0 && second < 0) {
-            pdot(i, false);
-            pdot(i, false);
-        } else {
-            ml_printf("Error %d %c %d\n", first, neg_first ? '<' : '>', second);
-            return false;
+        if (!(neg_first ? (first < 0 && second > 0)
+                        : (first > 0 && second < 0))) {
+            bad++;
         }
     }
+    test_read_count += max * 2;
+    if (bad) {
+        ml_printf("Error: %d bad s8 pairs\n", bad);
+        return false;
+    }
     ml_printf("done %d @ %p\n", i * 2, ptr);
     return true;
 }
@@ -403,7 +390,7 @@ static bool read_test_data_s8(int offset, bool neg_first)
 static bool read_test_data_s16(int offset, bool neg_first)
 {
     int16_t *ptr = (int16_t *)&test_data[offset];
-    int i;
+    int i, bad = 0;
     const int max = (TEST_SIZE - offset) / (sizeof(*ptr));
 
     ml_printf("Reading s16 from %#lx (offset %d, %s):", ptr,
@@ -420,15 +407,15 @@ static bool read_test_data_s16(int offset, bool neg_first)
     for (i = 0; i < max; i++) {
         int32_t data = *ptr++;
 
-        if (neg_first && data < 0) {
-            pdot(i, false);
-        } else if (!neg_first && data > 0) {
-            pdot(i, false);
-        } else {
-            ml_printf("Error %d %c 0\n", data, neg_first ? '<' : '>');
-            return false;
+        if (!(neg_first ? data < 0 : data > 0)) {
+            bad++;
         }
     }
+    test_read_count += max;
+    if (bad) {
+        ml_printf("Error: %d bad s16 words\n", bad);
+        return false;
+    }
     ml_printf("done %d @ %p\n", i, ptr);
     return true;
 }
@@ -436,7 +423,7 @@ static bool read_test_data_s16(int offset, bool neg_first)
 static bool read_test_data_s32(int offset, bool neg_first)
 {
     int32_t *ptr = (int32_t *)&test_data[offset];
-    int i;
+    int i, bad = 0;
     const int max = (TEST_SIZE - offset) / (sizeof(int32_t));
 
     ml_printf("Reading s32 from %#lx (offset %d, %s):",
@@ -453,15 +440,15 @@ static bool read_test_data_s32(int offset, bool neg_first)
     for (i = 0; i < max; i++) {
         int64_t data = *ptr++;
 
-        if (neg_first && data < 0) {
-            pdot(i, false);
-        } else if (!neg_first && data > 0) {
-            pdot(i, false);
-        } else {
-            ml_printf("Error %d %c 0\n", data, neg_first ? '<' : '>');
-            return false;
+        if (!(neg_first ? data < 0 : data > 0)) {
+            bad++;
         }
     }
+    test_read_count += max;
+    if (bad) {
+        ml_printf("Error: %d bad s32 words\n", bad);
+        return false;
+    }
     ml_printf("done %d @ %p\n", i, ptr);
     return true;
 }
-- 
2.47.3


