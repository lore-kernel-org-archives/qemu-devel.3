Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D86CD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY6Ec-0005yD-FA; Fri, 12 Jun 2026 14:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wY6Ea-0005xp-MF
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 14:04:00 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wY6EY-0000ZU-Dh
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 14:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1781287434;
 bh=rN7AqZT+PyyD1qQHm8Fh0d1KVRLGIZG6xv1nnDT0dzM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=4DWhgaFh4qpSPjfpIHpi6ae1htQF91bnpoghVBnUsGgbpIU6YPmaxsPbrMxqc0r8v
 sEE4PCrCYOhz6GLC5d/wOIt4C3SWFVzKN16rctf4gxI0lQgW26CZ9JqOPNHEAwtCgS
 F8xaSzS60axiS1UIb4xRwBR1enkufPEuDOskGZB/wb2iKCiaqcAgF0NEOPD080fNt8
 zzL719QZz4erSFE6hga5QtXd16NpRqwiMi6YlfsaUzaPAk7h/RrdRMQM/7TfpN/Tbi
 UXsJaIIA4WExr9de+sMFBvYwK4mbXK8awuHNXG/u8B8y34pOxZwMtaOk/CGD+eGFdp
 mlBt7q5KXjoPA==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id BCA714028F;
 Fri, 12 Jun 2026 20:03:54 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id B930FFF853;
 Fri, 12 Jun 2026 20:03:54 +0200 (CEST)
Received: from naga.. (unknown [37.167.227.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 3E8BD140101;
 Fri, 12 Jun 2026 20:03:54 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
To: philmd@mailo.com, pierrick.bouvier@oss.qualcomm.com, mst@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH 2/2] test/unit: Byte-swap tests
Date: Fri, 12 Jun 2026 20:03:46 +0200
Message-ID: <20260612180346.890429-2-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612180346.890429-1-frederic.petrot@univ-grenoble-alpes.fr>
References: <20260612180346.890429-1-frederic.petrot@univ-grenoble-alpes.fr>
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

Test to check byte-swap macros, in particular for Int128.

Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 tests/unit/meson.build  |   1 +
 tests/unit/test-bswap.c | 105 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 tests/unit/test-bswap.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 01cc540a45..6ad4412322 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -50,6 +50,7 @@ tests = {
   'test-interval-tree': [],
   'test-fifo': [],
   'test-envlist': [],
+  'test-bswap': [],
 }
 
 if have_system or have_tools
diff --git a/tests/unit/test-bswap.c b/tests/unit/test-bswap.c
new file mode 100644
index 0000000000..1c05b677ed
--- /dev/null
+++ b/tests/unit/test-bswap.c
@@ -0,0 +1,105 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Unit-tests for byte-swaps.
+ *
+ * Copyright (C) 2026, Université Grenoble Alpes
+ * Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "qemu/int128.h"
+
+#define TEST_HI_VAL 0x0011223344556677ULL
+#define TEST_LO_VAL 0x8899AABBCCDDEEFFULL
+
+static void test_basic_bswap(void)
+{
+    g_assert_cmphex(bswap16(0x1234), ==, 0x3412);
+    g_assert_cmphex(bswap32(0x12345678), ==, 0x78563412);
+    g_assert_cmphex(bswap64(0x1122334455667788ULL), ==, 0x8877665544332211ULL);
+    /* Checking the 128-bit case is a bit more involved */
+    Int128 v = int128_make128(TEST_LO_VAL, TEST_HI_VAL);
+    Int128 r = bswap128(v);
+    uint64_t hi = int128_gethi(r);
+    uint64_t lo = int128_getlo(r);
+    g_assert_cmphex(bswap64(hi), ==, TEST_LO_VAL);
+    g_assert_cmphex(bswap64(lo), ==, TEST_HI_VAL);
+}
+
+static void test_le_target_octoword(void)
+{
+    uint8_t buf[16];
+    Int128 v = int128_make128(TEST_LO_VAL, TEST_HI_VAL);
+    Int128 r;
+
+    /* LSB first comparison stream */
+    const uint8_t expected_le_stream[16] = {
+        0xFF, 0xEE, 0xDD, 0xCC, 0xBB, 0xAA, 0x99, 0x88,
+        0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11, 0x00
+    };
+
+    sto_le_p(buf, v);
+    g_assert_cmpmem(buf, 16, expected_le_stream, 16);
+    r = ldo_le_p(buf);
+    g_assert(int128_eq(v, r));
+}
+
+static void test_be_target_octoword(void)
+{
+    uint8_t buf[16];
+    Int128 v = int128_make128(TEST_LO_VAL, TEST_HI_VAL);
+    Int128 r;
+
+    /* MSB first comparison stream */
+    const uint8_t expected_be_stream[16] = {
+        0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+        0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF
+    };
+
+    sto_be_p(buf, v);
+    g_assert_cmpmem(buf, 16, expected_be_stream, 16);
+    r = ldo_be_p(buf);
+    g_assert(int128_eq(v, r));
+}
+
+static void test_host_conversions_octoword(void)
+{
+    Int128 v = int128_make128(TEST_LO_VAL, TEST_HI_VAL);
+    Int128 r, s;
+    Int128 p = int128_make128(bswap64(TEST_HI_VAL), bswap64(TEST_LO_VAL));
+
+    r = le128_to_cpu(v);
+    s = cpu_to_le128(v);
+    #if HOST_BIG_ENDIAN
+        g_assert(int128_eq(r, p));
+        g_assert(int128_eq(s, p));
+    #else
+        g_assert(int128_eq(r, v));
+        g_assert(int128_eq(s, v));
+    #endif
+
+    r = be128_to_cpu(v);
+    s = cpu_to_be128(v);
+    #if HOST_BIG_ENDIAN
+        g_assert(int128_eq(r, v));
+        g_assert(int128_eq(s, v));
+    #else
+        g_assert(int128_eq(r, p));
+        g_assert(int128_eq(s, p));
+    #endif
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/bswap/basic", test_basic_bswap);
+    g_test_add_func("/bswap/le_target_octoword", test_le_target_octoword);
+    g_test_add_func("/bswap/be_target_octoword", test_be_target_octoword);
+    g_test_add_func("/bswap/host_conversions_octoword",
+                    test_host_conversions_octoword);
+
+    return g_test_run();
+}
-- 
2.43.0


