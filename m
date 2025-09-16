Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155F2CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya5V-0003xG-LK; Tue, 16 Sep 2025 14:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya58-0003Tw-TX
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4w-0001dE-1Z
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45f2b062b86so19300335e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758046001; x=1758650801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6LeILhwPgBbuYTZtg4+zNF/Wb2Nc+4dWl/EGuDadDTQ=;
 b=R8w1lTRtykeSHndbucGiUMeauNPQH2hRkm6v1smnOal/uZaN+PeCp8eUE99L8yT5CZ
 bbEl3Vp+QTLhYFQz/vFKkxLUK4FhYkGYKbr4Tkklk64FN2f5NdhPoPXbPB4Z/USWkzLL
 Zi//KqaqnRqxh+N/Ny96m9Vl3lQSyrEkU/I9/AD52EqkE7YMRNYp5fodOXRxLNIHGla5
 nOuBrZxsaeWlcIW4tS8y4LQtONdKVbfWljoVJiDCo0CU68PWsVw+IFpjShYA7O2Dv0C9
 yFuRYNpZ9DmiXPyqscofUz5gm3LEy0zSdqnDP23IzxFT/Dgn8huumw/QTYa7u/7yKcXC
 Agww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758046001; x=1758650801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LeILhwPgBbuYTZtg4+zNF/Wb2Nc+4dWl/EGuDadDTQ=;
 b=rL7Vp9I/JgCuDlt8KogFmcpTf7mVpJaEp7HnnLrNTAEapRCoJuSmk8MiBorrFgFZmh
 stTDnDOLEMoVCEvGUmRcNbit+7Kvkg81agEek0IjIYBYiN9UEXri3Z0oyW920Z/UgbJD
 FzVrk66ghL8/xPTq7ruFOM3iYj9q5XahYq2oioQDrkJJLz8IsEWlMyUlBc+i4x+vNuQ3
 n9A3bJTnrKtnag0JNCf3zpf4Jcmk4w9PGTlakfxNBxN8d3sjbb4m2AzCAVejLIqmz/Zs
 mEwm29M4ICjd8VFaAY+/kUUX87ImCLr/ETLfDQyH7M5uQdrk7ksdPVvKigetCT9I3nZK
 ZmOg==
X-Gm-Message-State: AOJu0Yxo/RxD+/GMEGdKWAG3yiwmF/2P8D1JUSYLVzuvbN6ggSfjjQNj
 AqIiWoLwwjBbFHmR9jWHNLg1bTb/bYJDHYlLgh3J5Lo7teVVrPsM43Iy7KX5QBcy5ozIzID6Zq4
 5hoY1
X-Gm-Gg: ASbGnctb7QWPZVUxc5t3eUPKkNONIGC+51AXynpaNDzeU6QLqC5P7tM3JE12QKoytqj
 WM9X34DNUStbEM5sqzdwjgqUz/ErDcBpGHWF0FLNpcGEylmcg8461aD6IfePGQqnwsaKwjSPtbL
 Q4UxfOOR4MBERtmY5qz+F92hCTc9/rDfIKJDO6hHzejn/UT+OFZaajjQhlKAR5FQjFNOh4cw5VV
 1qpe7nlxsP5mdoHeA9KygCKh20lnulu12Wyj/Or35ft2/PdRvT422LNOtmN9aKMUSC6GcpRIFjG
 NAHe8DMR/iBaxpwQ5qBoDkOuDPQrsDAiT/lOlrZqf/mQlB5bZadVoWmy1/jx2KJ2dtl5FMhCH0k
 oFMGVyKN547Zft1khYdVhEjn6Rjg2
X-Google-Smtp-Source: AGHT+IGHNh8LaZgjHpHH+PlrZ46zw5X6VQEU0Qh5FgPTwZp02ErjE4Ar9QgwWWesz/kFAQogHOHROw==
X-Received: by 2002:a05:600c:5755:b0:45b:71ac:b45a with SMTP id
 5b1f17b1804b1-45f211d5128mr127372485e9.11.1758046000953; 
 Tue, 16 Sep 2025 11:06:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/36] target/arm: Added test case for SME register exposure to
 GDB
Date: Tue, 16 Sep 2025 19:05:58 +0100
Message-ID: <20250916180611.1481266-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>

This patch adds a test case to test SME register exposure to
a remote gdb debugging session. This test simply sets and
reads SME registers.

Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Message-id: 20250909161012.2561593-4-vacha.bhavsar@oss.qualcomm.com
[PMM: fixed various python formatting nits]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure                             |   6 ++
 tests/tcg/aarch64/Makefile.target     |  29 +++++++
 tests/tcg/aarch64/gdbstub/test-sme.py | 117 ++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sme.py

diff --git a/configure b/configure
index 274a7787642..9aea02cf6a2 100755
--- a/configure
+++ b/configure
@@ -1839,6 +1839,12 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
+      if test "${gdb_arches#*$arch}" != "$gdb_arches" && version_ge $gdb_version 14.1; then
+          echo "GDB_HAS_SME_TILES=y" >> $config_target_mak
+      else
+          echo "GDB_HAS_SME_TILES=n" >> $config_target_mak
+      fi
+
       if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.1; then
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 16ddcf4f883..1755874beed 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -134,6 +134,35 @@ run-gdbstub-sve-ioctls: sve-ioctls
 
 EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls
 
+ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
+# SME gdbstub tests
+
+run-gdbstub-sysregs-sme: sysregs
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
+		-- test_sme --gdb_basic_za_test, \
+	basic gdbstub SME support)
+
+ifeq ($(GDB_HAS_SME_TILES),y)
+run-gdbstub-sysregs-sme-tile-slice: sysregs
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
+		-- test_sme --gdb_tile_slice_test, \
+	gdbstub SME ZA tile slice support)
+else
+run-gdbstub-sysregs-sme-tile-slice: sysregs
+	$(call skip-test,"gdbstub SME ZA tile slice support", \
+	"selected gdb ($(GDB)) does not support SME ZA tile slices")
+endif
+
+EXTRA_RUNS += run-gdbstub-sysregs-sme run-gdbstub-sysregs-sme-tile-slice
+
+endif
+
 ifeq ($(GDB_HAS_MTE),y)
 run-gdbstub-mte: mte-8
 	$(call run-test, $@, $(GDB_SCRIPT) \
diff --git a/tests/tcg/aarch64/gdbstub/test-sme.py b/tests/tcg/aarch64/gdbstub/test-sme.py
new file mode 100644
index 00000000000..ec031896427
--- /dev/null
+++ b/tests/tcg/aarch64/gdbstub/test-sme.py
@@ -0,0 +1,117 @@
+#
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+#
+# Test the SME registers are visible and changeable via gdbstub
+#
+# This is launched via tests/guest-debug/run-test.py
+#
+
+import argparse
+import gdb
+from test_gdbstub import main, report
+
+MAGIC = 0x01020304
+BASIC_ZA_TEST = 0
+TILE_SLICE_TEST = 0
+
+
+def run_test():
+    """Run the requested test(s) for SME ZA gdbstub support"""
+
+    if BASIC_ZA_TEST:
+        run_basic_sme_za_gdbstub_support_test()
+    if TILE_SLICE_TEST:
+        run_basic_sme_za_tile_slice_gdbstub_support_test()
+
+
+def run_basic_sme_za_gdbstub_support_test():
+    """Test reads and writes to the SME ZA register at the byte level"""
+
+    frame = gdb.selected_frame()
+    rname = "za"
+    za = frame.read_register(rname)
+    report(True, "Reading %s" % rname)
+
+    # Writing to the ZA register, byte by byte.
+    for i in range(0, 16):
+        for j in range(0, 16):
+            cmd = "set $za[%d][%d] = 0x01" % (i, j)
+            gdb.execute(cmd)
+            report(True, "%s" % cmd)
+
+    # Reading from the ZA register, byte by byte.
+    for i in range(0, 16):
+        for j in range(0, 16):
+            reg = "$za[%d][%d]" % (i, j)
+            v = gdb.parse_and_eval(reg)
+            report(str(v.type) == "uint8_t", "size of %s" % (reg))
+            report(v == 0x1, "%s is 0x%x" % (reg, 0x1))
+
+
+def run_basic_sme_za_tile_slice_gdbstub_support_test():
+    """Test reads and writes of SME ZA horizontal and vertical tile slices
+
+    Test if SME ZA tile slices, both horizontal and vertical,
+    can be correctly read and written to. The sizes to test
+    are quadwords and doublewords.
+    """
+
+    sizes = {}
+    sizes["q"] = "uint128_t"
+    sizes["d"] = "uint64_t"
+
+    # Accessing requested sizes of elements of ZA
+    for size in sizes:
+
+        # Accessing various ZA tiles
+        for i in range(0, 4):
+
+            # Accessing various horizontal slices for each ZA tile
+            for j in range(0, 4):
+                # Writing to various elements in each tile slice
+                for k in range(0, 4):
+                    cmd = "set $za%dh%c%d[%d] = 0x%x" % (i, size, j, k, MAGIC)
+                    gdb.execute(cmd)
+                    report(True, "%s" % cmd)
+
+                # Reading from the written elements in each tile slice
+                for k in range(0, 4):
+                    reg = "$za%dh%c%d[%d]" % (i, size, j, k)
+                    v = gdb.parse_and_eval(reg)
+                    report(str(v.type) == sizes[size], "size of %s" % (reg))
+                    report(v == MAGIC, "%s is 0x%x" % (reg, MAGIC))
+
+            # Accessing various vertical slices for each ZA tile
+            for j in range(0, 4):
+                # Writing to various elements in each tile slice
+                for k in range(0, 4):
+                    cmd = "set $za%dv%c%d[%d] = 0x%x" % (i, size, j, k, MAGIC)
+                    gdb.execute(cmd)
+                    report(True, "%s" % cmd)
+
+                # Reading from the written elements in each tile slice
+                for k in range(0, 4):
+                    reg = "$za%dv%c%d[%d]" % (i, size, j, k)
+                    v = gdb.parse_and_eval(reg)
+                    report(str(v.type) == sizes[size], "size of %s" % (reg))
+                    report(v == MAGIC, "%s is 0x%x" % (reg, MAGIC))
+
+
+parser = argparse.ArgumentParser(description="A gdbstub test for SME support")
+parser.add_argument("--gdb_basic_za_test",
+                    help="Enable test for basic SME ZA support",
+                    action="store_true")
+parser.add_argument("--gdb_tile_slice_test",
+                    help="Enable test for ZA tile slice support",
+                    action="store_true")
+args = parser.parse_args()
+
+if args.gdb_basic_za_test:
+    BASIC_ZA_TEST = 1
+if args.gdb_tile_slice_test:
+    TILE_SLICE_TEST = 1
+
+main(run_test, expected_arch="aarch64")
-- 
2.43.0


