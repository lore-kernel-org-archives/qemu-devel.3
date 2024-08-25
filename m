Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC0FC5320E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2024 14:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siEc3-00033M-Pi; Sun, 25 Aug 2024 10:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1siEc1-0002vP-Lo
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 10:53:01 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1siEbz-0005vm-80
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 10:53:01 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-202146e93f6so35197005ad.3
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724597577; x=1725202377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4uI/+zEAjeI5zZ34lp5a318ReZmpPSQmnhFszSfJC8=;
 b=OrOPyCNHINKOpWtCOcOmBetL0Qllgfsn39PRtUULgv5aPTyUphEga/YykzDWOm7ApC
 AznogdXLoYn38FK8QAHTMnVX0P+sVUhJbhoiiQkgValllS9QwJRV2qytCW7vS7UTvv+p
 rEK0REJ4usmPdameMWiEUeWoNG6JSlZRbopLdYqNQeDd2HVi2ijSH2yhijrdUgz04kr2
 89CdQjO9DVc3iLpiql6aqqIgYXO2+y34+pQ23xMDJIxlT+t0f0MU0bvheXt0uAYEFmF4
 qAIpj9hlIz0Dn7mEcxfnzaB0OpXjMih2AGPeD1B8SCt39i8v3Vdwl0S6RsAOtzTwMK0I
 u/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724597577; x=1725202377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P4uI/+zEAjeI5zZ34lp5a318ReZmpPSQmnhFszSfJC8=;
 b=U5xK1UUurPzgWqxl8rxkmT9sx0KZQl+eruqd79nFvFhv8aGtdPbPcsxL38YvQbl/H7
 vQAAJaph5Af/1y7JYp4pWcceVHe0Oc/fGfTtNuX/NrOZjX3jjGC8CmVFzSMduwTKZmm1
 EP9+tkasLZL26goBSI+P/txpaqGLiF2scLpAFYgWO1GKNm9zjLqnMhN5KXHjxLjvY9pp
 BU3ggStzWtoOuL7MPlGTLEMqOwtcOdZ6pTW046/8HoxMjW6miJxQEuU8Ph+WFmHwK+a1
 2ErM92dy8QDuAaMUTJrWrVpW4Apa3YejknutSjnahEaDKUPQCLZv40L3XhrnR2XEV432
 ss3w==
X-Gm-Message-State: AOJu0YzgjaMqtasPfz+7QIZoWPANEtcIEZIsA/TZkhJmOgXFCG/ZaDJk
 1fs7GSY8CgG5it2sQB3r2jnpVx7HZLe01rDqnMdEQAN/4DslP1vjlfDzHgjoGsj1lidZuQVm+Yu
 cGRE=
X-Google-Smtp-Source: AGHT+IGR4ONJPnpS/uW1MzO99h7uIdqdZk3J5t4BHT4c/2TVk6TbaYrmMM/HzCvUYz6458exMnQr9Q==
X-Received: by 2002:a17:902:d2c8:b0:202:708:343b with SMTP id
 d9443c01a7336-2039e55514cmr88117705ad.65.1724597577088; 
 Sun, 25 Aug 2024 07:52:57 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:bb79:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0e164b8sm24698805ad.236.2024.08.25.07.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2024 07:52:56 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v3 4/4] tests/tcg/aarch64: Extend MTE gdbstub tests to system
 mode
Date: Sun, 25 Aug 2024 14:52:08 +0000
Message-Id: <20240825145208.46774-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240825145208.46774-1-gustavo.romero@linaro.org>
References: <20240825145208.46774-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Extend MTE gdbstub tests to also run in system mode (share tests between
user mode and system mode). The tests will only run if a version of GDB
that supports MTE on baremetal is available in the test environment and
if available compiler supports the 'memtag' flag
(-march=armv8.5-a+memtag).

For the tests running in system mode, a page that supports MTE ops. is
necessary. Therefore, an MTE-enabled page is made available (mapped) in
the third 2 MB chunk of the second 1 GB space in the flat mapping set in
boot.S. A new binary, mte.S, is also introduced for the tests. It links
against boot.S and is executed by QEMU in system mode.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 configure                                 |   5 +
 tests/tcg/aarch64/Makefile.softmmu-target |  49 +++++++++-
 tests/tcg/aarch64/Makefile.target         |   3 +-
 tests/tcg/aarch64/gdbstub/test-mte.py     |  71 +++++++++-----
 tests/tcg/aarch64/system/boot.S           |  11 +++
 tests/tcg/aarch64/system/kernel.ld        |   7 ++
 tests/tcg/aarch64/system/mte.S            | 109 ++++++++++++++++++++++
 7 files changed, 227 insertions(+), 28 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/mte.S

diff --git a/configure b/configure
index d08b71f14b..40186d865e 100755
--- a/configure
+++ b/configure
@@ -1679,6 +1679,11 @@ for target in $target_list; do
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
 
+      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 16.0; then
+          # GDB has to support MTE in baremetal to allow debugging MTE in QEMU system mode
+          echo "GDB_SUPPORTS_MTE_IN_BAREMETAL=y" >> $config_target_mak
+      fi
+
       echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
       tcg_tests_targets="$tcg_tests_targets $target"
   fi
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 139e04d15f..59ee662cda 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -2,14 +2,22 @@
 # Aarch64 system tests
 #
 
-AARCH64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/aarch64/system
+AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
+AARCH64_SYSTEM_SRC=$(AARCH64_SRC)/system
+
 VPATH+=$(AARCH64_SYSTEM_SRC)
 
 # These objects provide the basic boot code and helper functions for all tests
 CRT_OBJS=boot.o
 
-AARCH64_TEST_SRCS=$(wildcard $(AARCH64_SYSTEM_SRC)/*.c)
-AARCH64_TESTS = $(patsubst $(AARCH64_SYSTEM_SRC)/%.c, %, $(AARCH64_TEST_SRCS))
+AARCH64_TEST_C_SRCS_=$(wildcard $(AARCH64_SYSTEM_SRC)/*.c)
+AARCH64_TEST_S_SRCS=$(AARCH64_SYSTEM_SRC)/mte.S
+
+AARCH64_C_TESTS = $(patsubst $(AARCH64_SYSTEM_SRC)/%.c, %, $(AARCH64_TEST_C_SRCS))
+AARCH64_S_TESTS = $(patsubst $(AARCH64_SYSTEM_SRC)/%.S, %, $(AARCH64_TEST_S_SRCS))
+
+AARCH64_TESTS = $(AARCH64_C_TESTS)
+AARCH64_TESTS += $(AARCH64_S_TESTS)
 
 CRT_PATH=$(AARCH64_SYSTEM_SRC)
 LINK_SCRIPT=$(AARCH64_SYSTEM_SRC)/kernel.ld
@@ -21,7 +29,8 @@ LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
 config-cc.mak: Makefile
 	$(quiet-@)( \
-	    $(call cc-option,-march=armv8.3-a, CROSS_CC_HAS_ARMV8_3)) 3> config-cc.mak
+	    $(call cc-option,-march=armv8.3-a, CROSS_CC_HAS_ARMV8_3); \
+	    $(call cc-option,-march=armv8.5-a+memtag, CROSS_CC_HAS_ARMV8_MTE)) 3> config-cc.mak
 -include config-cc.mak
 
 # building head blobs
@@ -88,3 +97,35 @@ pauth-3:
 run-pauth-3:
 	$(call skip-test, "RUN of pauth-3", "not built")
 endif
+
+ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
+QEMU_MTE_ENABLED_MACHINE=-M virt,mte=on -cpu max -display none
+QEMU_OPTS_WITH_MTE_ON = $(QEMU_MTE_ENABLED_MACHINE) $(QEMU_BASE_ARGS) -kernel
+mte: CFLAGS+=-march=armv8.5-a+memtag
+mte: mte.S $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+
+run-mte: QEMU_OPTS=$(QEMU_OPTS_WITH_MTE_ON)
+run-mte: mte
+
+ifeq ($(GDB_SUPPORTS_MTE_IN_BAREMETAL),y)
+run-gdbstub-mte: QEMU_OPTS=$(QEMU_OPTS_WITH_MTE_ON)
+run-gdbstub-mte: mte
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--output run-gdbstub-mte.out \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "-chardev null$(COMMA)id=output $(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py -- --mode=system, \
+	gdbstub MTE support)
+
+EXTRA_RUNS += run-gdbstub-mte
+else # !GDB_SUPPORTS_MTE_IN_BAREMETAL
+run-gdbstub-mte:
+	$(call skip-test "RUN of gdbstub-mte", "GDB does not support MTE in baremetal!")
+endif
+else # !CROSS_CC_HAS_ARMV8_MTE
+mte:
+	$(call skip-test, "BUILD of $@", "missing compiler support")
+run-mte:
+	$(call skip-test, "RUN of mte", "not build")
+endif
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 8cc62eb456..9efe2f81ad 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -138,7 +138,8 @@ run-gdbstub-mte: mte-8
 	$(call run-test, $@, $(GDB_SCRIPT) \
 		--gdb $(GDB) \
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py, \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py \
+		-- --mode=user, \
 	gdbstub MTE support)
 
 EXTRA_RUNS += run-gdbstub-mte
diff --git a/tests/tcg/aarch64/gdbstub/test-mte.py b/tests/tcg/aarch64/gdbstub/test-mte.py
index 66f9c25f8a..a4cae6caa0 100644
--- a/tests/tcg/aarch64/gdbstub/test-mte.py
+++ b/tests/tcg/aarch64/gdbstub/test-mte.py
@@ -1,21 +1,26 @@
 from __future__ import print_function
 #
 # Test GDB memory-tag commands that exercise the stubs for the qIsAddressTagged,
-# qMemTag, and QMemTag packets. Logical tag-only commands rely on local
-# operations, hence don't exercise any stub.
+# qMemTag, and QMemTag packets, which are used for manipulating allocation tags.
+# Logical tags-related commands rely on local operations, hence don't exercise
+# any stub and so are not used in this test.
 #
-# The test consists in breaking just after a atag() call (which sets the
-# allocation tag -- see mte-8.c for details) and setting/getting tags in
-# different memory locations and ranges starting at the address of the array
-# 'a'.
+# The test consists in breaking just after a tag is set in a specific memory
+# chunk, and then using the GDB 'memory-tagging' subcommands to set/get tags in
+# different memory locations and ranges in the MTE-enabled memory chunk.
 #
 # This is launched via tests/guest-debug/run-test.py
 #
 
 
-import gdb
+try:
+    import gdb
+except ModuleNotFoundError:
+    from sys import exit
+    exit("This script must be launched via tests/guest-debug/run-test.py!")
 import re
-from test_gdbstub import main, report
+from sys import argv
+from test_gdbstub import arg_parser, main, report
 
 
 PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \\(0x[0-9a-f]+\\)."
@@ -23,12 +28,32 @@
 
 
 def run_test():
-    gdb.execute("break 95", False, True)
+    p = arg_parser(prog="test-mte.py", description="TCG MTE tests.")
+    p.add_argument("--mode", help="Run test for QEMU system or user mode.",
+                   required=True, choices=['system','user'])
+
+    args = p.parse_args(args=argv)
+
+    if args.mode == "system":
+        # Break address: where to break before performing the tests
+        # See mte.S for details about this label.
+        ba = "main_end"
+        # Tagged address: the start of the MTE-enabled memory chunk to be tested
+        # 'tagged_addr' (x1) is a pointer to the MTE-enabled page. See mte.S.
+        ta = "$x1"
+    else: # mode="user"
+        # Line 95 in mte-8.c
+        ba = "95"
+        # 'a' array. See mte-8.c
+        ta = "a"
+
+    gdb.execute(f"break {ba}", False, True)
     gdb.execute("continue", False, True)
+
     try:
-        # Test if we can check correctly that the allocation tag for
-        # array 'a' matches the logical tag after atag() is called.
-        co = gdb.execute("memory-tag check a", False, True)
+        # Test if we can check correctly that the allocation tag for the address
+        # in {ta} matches the logical tag in {ta}.
+        co = gdb.execute(f"memory-tag check {ta}", False, True)
         tags_match = re.findall(PATTERN_0, co, re.MULTILINE)
         if tags_match:
             report(True, f"{tags_match[0]}")
@@ -39,20 +64,20 @@ def run_test():
         # tags rely on local operation and so don't exercise any stub.
 
         # Set the allocation tag for the first granule (16 bytes) of
-        # address starting at 'a' address to a known value, i.e. 0x04.
-        gdb.execute("memory-tag set-allocation-tag a 1 04", False, True)
+        # address starting at {ta} address to a known value, i.e. 0x04.
+        gdb.execute(f"memory-tag set-allocation-tag {ta} 1 04", False, True)
 
         # Then set the allocation tag for the second granule to a known
         # value, i.e. 0x06. This tests that contiguous tag granules are
-        # set correct and don't run over each other.
-        gdb.execute("memory-tag set-allocation-tag a+16 1 06", False, True)
+        # set correctly and don't run over each other.
+        gdb.execute(f"memory-tag set-allocation-tag {ta}+16 1 06", False, True)
 
         # Read the known values back and check if they remain the same.
 
-        co = gdb.execute("memory-tag print-allocation-tag a", False, True)
+        co = gdb.execute(f"memory-tag print-allocation-tag {ta}", False, True)
         first_tag = re.match(PATTERN_1, co)[1]
 
-        co = gdb.execute("memory-tag print-allocation-tag a+16", False, True)
+        co = gdb.execute(f"memory-tag print-allocation-tag {ta}+16", False, True)
         second_tag = re.match(PATTERN_1, co)[1]
 
         if first_tag == "0x4" and second_tag == "0x6":
@@ -61,15 +86,15 @@ def run_test():
             report(False, "Can't set/print allocation tags!")
 
         # Now test fill pattern by setting a whole page with a pattern.
-        gdb.execute("memory-tag set-allocation-tag a 4096 0a0b", False, True)
+        gdb.execute(f"memory-tag set-allocation-tag {ta} 4096 0a0b", False, True)
 
         # And read back the tags of the last two granules in page so
         # we also test if the pattern is set correctly up to the end of
         # the page.
-        co = gdb.execute("memory-tag print-allocation-tag a+4096-32", False, True)
+        co = gdb.execute(f"memory-tag print-allocation-tag {ta}+4096-32", False, True)
         tag = re.match(PATTERN_1, co)[1]
 
-        co = gdb.execute("memory-tag print-allocation-tag a+4096-16", False, True)
+        co = gdb.execute(f"memory-tag print-allocation-tag {ta}+4096-16", False, True)
         last_tag = re.match(PATTERN_1, co)[1]
 
         if tag == "0xa" and last_tag == "0xb":
@@ -78,8 +103,8 @@ def run_test():
             report(False, "Fill pattern failed!")
 
     except gdb.error:
-        # This usually happens because a GDB version that does not
-        # support memory tagging was used to run the test.
+        # This usually happens because a GDB version that does not support
+        # memory tagging was used to run the test.
         report(False, "'memory-tag' command failed!")
 
 
diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index 501685d0ec..4eb1b35b88 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -135,6 +135,17 @@ __start:
 	orr	x1, x1, x3
 	str	x1, [x2]			/* 2nd 2mb (.data & .bss)*/
 
+	/* Third block: at 'mte_page', set in kernel.ld */
+	adrp	x1, mte_page
+	add	x1, x1, :lo12:mte_page
+	bic	x1, x1, #(1 << 21) - 1
+	and 	x4, x1, x5
+	add	x2, x0, x4, lsr #(21 - 3)
+	/* attr(AF, NX, block, AttrIndx=Attr1) */
+	ldr	x3, =(3 << 53) | 0x401 | (1 << 2)
+	orr	x1, x1, x3
+	str	x1, [x2]
+
 	/* Setup/enable the MMU.  */
 
 	/*
diff --git a/tests/tcg/aarch64/system/kernel.ld b/tests/tcg/aarch64/system/kernel.ld
index 7b3a76dcbf..46f1092522 100644
--- a/tests/tcg/aarch64/system/kernel.ld
+++ b/tests/tcg/aarch64/system/kernel.ld
@@ -18,6 +18,13 @@ SECTIONS
     .bss : {
         *(.bss)
     }
+    /*
+     * Align the MTE page to the next 2mb boundary (i.e., the third 2mb chunk
+     * starting from 1gb) by setting the address for symbol 'mte_page', which is
+     * used in boot.S to setup the PTE and in the mte.S test as the address that
+     * the MTE instructions operate on.
+     */
+    mte_page = ALIGN(1 << 22);
     /DISCARD/ : {
         *(.ARM.attributes)
     }
diff --git a/tests/tcg/aarch64/system/mte.S b/tests/tcg/aarch64/system/mte.S
new file mode 100644
index 0000000000..b611240a95
--- /dev/null
+++ b/tests/tcg/aarch64/system/mte.S
@@ -0,0 +1,109 @@
+/*
+ * Code to help test the MTE gdbstubs in system mode.
+ *
+ * Copyright (c) 2024 Linaro Limited
+ *
+ * Author: Gustavo Romero <gustavo.romero@linaro.org>
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#define addr		x0 /* Ptr to the start of the MTE-enabled page. */
+#define tagged_addr	x1 /* 'addr' ptr with a random-generated tag added. */
+#define tmp0		x2 /* Scratch register. */
+#define tmp1		x3 /* Scratch register. */
+#define tmp2		x4 /* Scratch register. */
+#define tmp3		x5 /* Sctatch register. */
+
+	.file   "mte.S"
+
+	.text
+	.align 4
+
+	.globl  main
+	.type   main, @function
+
+main:
+	/*
+	 * Set MAIR_EL1 (Memory Attribute Index Register). In boot.S, the
+	 * attribute index for .mte_page is set to point to MAILR_EL field Attr1
+	 * (AttrIndx=Attr1), so set Attr1 as Tagged Normal (MTE) to enable MTE
+	 * on this page.
+	 *
+	 * Attr1 = 0xF0 => Tagged Normal (MTE)
+	 */
+	mrs	tmp0, mair_el1
+	orr	tmp0, tmp0, (0xF0 << 8)
+	msr	mair_el1, tmp0
+
+	/*
+	 * Set TCR_EL1 (Translation Control Registers) to ignore the top byte
+	 * in the translated addresses so it can be used to keep the tags.
+	 *
+	 * TBI0[37] = 0b1 => Top Byte ignored and used for tagged addresses
+	 */
+	mrs	tmp1, tcr_el1
+	orr	tmp1, tmp1, (1 << 37)
+	msr	tcr_el1, tmp1
+
+	/*
+	 * Set SCTLR_EL1 (System Control Register) to enable the use of MTE
+	 * insns., like stg & friends, and to enable synchronous exception in
+	 * case of a tag mismatch, i.e., when the logical tag in 'tagged_addr'
+	 * is different from the allocation tag related to 'addr' address.
+	 *
+	 * ATA[43] = 0b1 => Enable access to allocation tags at EL1
+	 * TCF[41:40] = 0b01 => Tag Check Faults cause a synchronous exception
+	 *
+	 */
+	mrs	tmp2, sctlr_el1
+	mov	tmp3, (1 << 43) | (1 << 40)
+	orr	tmp2, tmp2, tmp3
+	msr	sctlr_el1, tmp2
+
+	isb
+
+	/*
+	 * MTE-enabled page resides at the 3rd 2MB chunk in the second 1GB
+	 * block, i.e., at 0x40400000 address. See .mte_page section in boot.S
+	 * and kernel.ld (where the address is effectively computed).
+	 *
+	 * Load .mte_page address into 'addr' register.
+	 */
+	adrp	addr, mte_page
+	add	addr, addr, :lo12:mte_page
+
+	/*
+	 * Set GCR for random tag generation. 0xA5 is just a random value to set
+	 * GCR != 0 so the tag generated by 'irg' insn. is not zero, which is
+	 * more interesting for the tests than when tag is zero.
+	 */
+	mov	tmp0, 0xA5
+	msr	gcr_el1, tmp0
+
+	/*
+	 * Generate a logical tag, add it to 'addr' address and put it into
+	 * 'tagged_addr'.
+	 */
+	irg	tagged_addr, addr
+
+	/*
+	 * Store the generated tag to memory region pointed to by 'addr', i.e.
+	 * set the allocation tag for granule at 'addr'. The tag is extracted
+	 * by stg from tagged_addr pointer.
+	 */
+	stg	tagged_addr, [addr]
+
+	/*
+	 * Store a random value (0xdeadbeef) to tagged_addr address. This must
+	 * not cause any Tag Check Fault since logical tag in tagged_addr and
+	 * allocation tag associated with the memory pointed by tagged_addr are
+	 * set the same, otherwise something is off and the test fails -- an
+	 * exception is generated.
+	 */
+	ldr	tmp1, =0xdeadbeef
+	str	tmp1, [tagged_addr]
+
+	/* This label is used by GDB Python script test-mte.py. */
+main_end:
+	ret
-- 
2.34.1


