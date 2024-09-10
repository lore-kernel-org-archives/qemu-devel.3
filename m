Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9770CEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1X2-0007tO-Vh; Tue, 10 Sep 2024 10:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1X1-0007mn-ER
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:47 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1Wy-0006W6-0d
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:47 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8a7b1c2f2bso133659766b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977262; x=1726582062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lUubg39HWYdaIBsvXY2XTeRzXHTolhDbI/MSB6QBok=;
 b=A/UWltSELuA4p82wdpPH1i4OTwbY+3mtI0vKjqge/gI1BlbGq5HV6NtqimZSEZ8jD5
 FbbfIQThTBDrpk06gdUI3PW27VEzEYklrjEBTy+wwvFRX2lPaOB2y83bNeimGu8NoKH7
 UroymOfh+CGRnAqIqRq9IIdwRGHHtA/ziLypWCfiKFadtRx+bMrWVqs1Nao1c+7Ilctn
 0Sbaf6Arm27XPXFslDEH5eTHkrVKuxfpFqjuCmzn8mrLs7oyTseAEVmXHBWtttPFbG6r
 BVfa8Uf+U7SC8b8GiTOQWUqOPrpZHrhjpxAMmXLw5E/DXZEHCbH+cCR8WUL5r9qMnV9v
 0p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977262; x=1726582062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8lUubg39HWYdaIBsvXY2XTeRzXHTolhDbI/MSB6QBok=;
 b=usEBvmHepIqnDDpQ3PkXRK+MeV1fWsVDi06w1I9O4vds7chCosQDb75LkfAS2NX8iP
 F9lE5dwqi1339jWV+OdXTOOaAQMr60gTnVud8JoaSnfbrSY6XaFdk82nVvKPhqMlgZXp
 cL/FlLrOGKgWtmEjngB83X58kUicbCBOtadc+cw5d3QFNCHX76n5IxpuH0lliltD6ylK
 HNBRylnyqKT6O/z0Z50Lol6gmSYnPg90LH4ePLQykKGjM8wOERJt5b+cfRdb6xMef2D+
 mF4WSC6XTZTE93hDOLPhztb6mfBJ0aFL8DV9MdQl+ho3Lqjti8UUoh+WLXO8c0Rs7Tvv
 /TyQ==
X-Gm-Message-State: AOJu0Yzz+hnT/cDN41tCOqbpgsEz3xDG2wjR1I0xmti+8S1aLKNTIL4o
 SeICiKnAysOmzoH0Xj88meRRkn505z/z6Y0ARZ2IiKTUBUYJyc+4vfEvV80Cfa0=
X-Google-Smtp-Source: AGHT+IExEUa6jkqzU0Brw13JAniPu7af1KeniNGhAN9RwmezE4X6NEhT+Lg12c4gYPlHfvjYORFQxg==
X-Received: by 2002:a17:907:3d8b:b0:a8a:7501:de39 with SMTP id
 a640c23a62f3a-a8ffaab0216mr71778666b.9.1725977262218; 
 Tue, 10 Sep 2024 07:07:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c62485sm485443566b.104.2024.09.10.07.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:07:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 876F25FA14;
 Tue, 10 Sep 2024 15:07:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 09/26] tests/tcg/aarch64: Extend MTE gdbstub tests to system
 mode
Date: Tue, 10 Sep 2024 15:07:16 +0100
Message-Id: <20240910140733.4007719-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

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
Message-Id: <20240906143316.657436-6-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure                                 |   5 +
 tests/tcg/aarch64/Makefile.softmmu-target |  49 +++++++++-
 tests/tcg/aarch64/Makefile.target         |   3 +-
 tests/tcg/aarch64/gdbstub/test-mte.py     |  71 +++++++++-----
 tests/tcg/aarch64/system/boot.S           |  11 +++
 tests/tcg/aarch64/system/kernel.ld        |   9 ++
 tests/tcg/aarch64/system/mte.S            | 109 ++++++++++++++++++++++
 7 files changed, 229 insertions(+), 28 deletions(-)
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
index 5f39258d32..aef043e31d 100644
--- a/tests/tcg/aarch64/system/kernel.ld
+++ b/tests/tcg/aarch64/system/kernel.ld
@@ -7,6 +7,8 @@ MEMORY {
     TXT (rx) : ORIGIN = 1 << 30, LENGTH = 2M
     /* Align r/w data to the 2nd 2 MiB chunk. */
     DAT (rw) : ORIGIN = (1 << 30) + 2M, LENGTH = 2M
+    /* Align the MTE-enabled page to the 3rd 2 MiB chunk. */
+    TAG (rw) : ORIGIN = (1 << 30) + 4M, LENGTH = 2M
 }
 
 SECTIONS {
@@ -18,6 +20,13 @@ SECTIONS {
         *(.data)
         *(.bss)
     } >DAT
+    .tag : {
+        /*
+         * Symbol 'mte_page' is used in boot.S to setup the PTE and in the mte.S
+         * test as the address that the MTE instructions operate on.
+         */
+        mte_page = .;
+    } >TAG
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
2.39.2


