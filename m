Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507BBC79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Tb5-0000Fs-QS; Fri, 04 Sep 2026 09:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Ta8-0006VL-JM
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:51 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZz-000398-59
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:47 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-495437bb891so7388495e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527016; x=1789131816; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WucCoEbwOaJ6yFrDTrkuFcra5z9cb0XgU8deFVQYTuI=;
 b=zMgnoR2E0dPnZusXP+l4YNTuGTbaBIIvLPSzCvoJX/dyjj8iXqfmAbaSK8vVXxYN9F
 aufNcdJOnI9ZKUeotdAV2Fq5UEt60AGFGnep5eUlCgfbLf9WyDLyNjjaxRJHAfN2pH6Z
 RmqclavLGKiaoi5bQ8lu5+E8AkM16HIvK4fuuy6PAKr0595Tk94v7lhg5x/eBVJ8aeHl
 b6pq1HILIdm71J/AgIsum+njRFUFr/4ZlZcxAFbD5KP0cFhG68wJc7jhoIWuV1zZJZRW
 iPe+ULxT61hFdW4yIULSmW9Wdw2VW6p2UJqnM9IssGthypK8inTLBP47AjHZsQtQgsM/
 OPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527016; x=1789131816;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WucCoEbwOaJ6yFrDTrkuFcra5z9cb0XgU8deFVQYTuI=;
 b=HaG3bo14BsmBoE+6xkZW6wq0OPZyPQv0koMhXK2KPKNB5hsOP7WSIDN72uzi1uCTq8
 eLeQvfHLETHxuL3Ki6PcuYc4wwcWSmOIMJUR/ZyLK77y3yG13MgJN4KuifYGuekLBufI
 UJJw1PnDm4dr9xqBbX0dOywOUroYgejGRYRzLJyP5n/tqVT67nU9IcoAoMK+4nNPJBJp
 CUu8JpJIy1jsqtNJmbPwOmOTDhNY/OehjOEFZjMg2g/b7O1PXelhNDr0+k5C0ksdjS9y
 rrqqWS/9Rzi2YogWRnM8SCfM2JrCCRUgjQOtm6AG1NA38Qkvc020RVB3e46YVUI6/C6E
 2bJA==
X-Gm-Message-State: AFuF++luWPpdbNt/kVlY30RwLT3BuB98nyWyh3K0iHJNhjMYc0lH3UhZ
 Bzfcs6EwTDxQSqRCVb3eiyLVnOoxLZo3MpVbNvTYY7I16eTzDj9ohipNncwUwpOzWR4=
X-Gm-Gg: AYBFou2TIxBB7owL9st7bkHWI/U08krXPDJHPU1GU7o4qSJ593W/+c0cl8+b+9QNzb9
 nF/Xmq66ymED0YoBfkwbFuTYAAyU/hbUQK4Q99dzq9THjduPRnC9gxk9NE671LMTpJEgoXj16/8
 11r2gYmgqatGn32zueRvgZkWsFVXQcwxIeR3xz9EfARrIlOIm7e9ddiD12LQRLmczhlo4bSzTgw
 a2cT6aYdAJ00a8+49X6t5CNNMr201n5MSyWFQ1lSTdGs8wHmphb9v3xKEOjWfxvpI5kOz+26CDC
 fz7qdMwtfrGA++vnR/BRNRkHu52CHt47ags6f1AANX0M82393OUGtUTanxyx5/c+RO42jekcLtj
 r97RbnUZLX9cFke5UnXsEcM2l8eRZ5SZlR9GAETwHaqG1dG0qiedBmzemrMf6VAlboIDO5oUnZe
 H8CG8ZYYRhu6GQrvCITrGJuAdL/9uwkgrfmTcy6o7/8R5mpBl67YG6ohm8xmVZ4nTod4ezKh6r3
 Q==
X-Received: by 2002:a05:600c:6303:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-49cf82cbab5mr42070715e9.6.1788527015782; 
 Fri, 04 Sep 2026 06:03:35 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf755c22esm69452665e9.0.2026.09.04.06.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6FD515FFE5;
 Fri, 04 Sep 2026 13:46:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 042/105] tests/tcg/aarch64: system tests
Date: Fri,  4 Sep 2026 13:44:56 +0100
Message-ID: <20260904124604.2207440-43-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-43-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
deleted file mode 100644
index 3f30be6c5d6..00000000000
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ /dev/null
@@ -1,147 +0,0 @@
-#
-# Aarch64 system tests
-#
-
-AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
-AARCH64_SYSTEM_SRC=$(AARCH64_SRC)/system
-
-VPATH+=$(AARCH64_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-AARCH64_TEST_C_SRCS=$(wildcard $(AARCH64_SYSTEM_SRC)/*.c)
-AARCH64_TEST_S_SRCS=$(AARCH64_SYSTEM_SRC)/mte.S
-
-AARCH64_C_TESTS = $(patsubst $(AARCH64_SYSTEM_SRC)/%.c, %, $(AARCH64_TEST_C_SRCS))
-AARCH64_S_TESTS = $(patsubst $(AARCH64_SYSTEM_SRC)/%.S, %, $(AARCH64_TEST_S_SRCS))
-
-AARCH64_TESTS = $(AARCH64_C_TESTS)
-AARCH64_TESTS += $(AARCH64_S_TESTS)
-
-CRT_PATH=$(AARCH64_SYSTEM_SRC)
-LINK_SCRIPT=$(AARCH64_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-TESTS+=$(AARCH64_TESTS) $(MULTIARCH_TESTS)
-EXTRA_RUNS+=$(MULTIARCH_RUNS)
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(MINILIB_OBJS) -lgcc
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    $(call cc-option,-march=armv8.3-a, CROSS_CC_HAS_ARMV8_3); \
-	    $(call cc-option,-march=armv8.5-a+memtag, CROSS_CC_HAS_ARMV8_MTE)) 3> config-cc.mak
--include config-cc.mak
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-vector_log_boot.o: $(CRT_PATH)/boot.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DLOGGING_VECTOR_TABLE -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=1
-
-memory-sve: memory.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
-
-memory-sve: CFLAGS+=-DCHECK_UNALIGNED=1 -march=armv8.1-a+sve -O3
-
-gpc-test: gpc-test.c $(LINK_SCRIPT) vector_log_boot.o $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) vector_log_boot.o
-
-TESTS+=memory-sve gpc-test
-
-# Running
-QEMU_BASE_MACHINE=-M virt -cpu max -display none
-QEMU_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output
-QEMU_OPTS+=$(QEMU_BASE_MACHINE) $(QEMU_BASE_ARGS) -kernel
-
-# console test is manual only
-QEMU_SEMIHOST=-serial none -chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
-run-semiconsole: QEMU_OPTS=$(QEMU_BASE_MACHINE) $(QEMU_SEMIHOST) -kernel
-run-semiconsole: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-	$(if $(V),@printf "  %-7s %s %s\n" "TO RUN" $(notdir $(QEMU)) "$(QEMU_OPTS) $<")
-run-plugin-semiconsole-with-%: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-
-# vtimer test needs EL2
-QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -smp 4
-QEMU_EL2_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="2"
-run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_EL2_BASE_ARGS) -kernel
-
-# gpc tests need EL3 and RME
-QEMU_EL3_MACHINE=-machine virt,virtualization=on,secure=on,gic-version=3 -cpu max,x-rme=on
-QEMU_EL3_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="3"
-run-gpc-test:  QEMU_OPTS=$(QEMU_EL3_MACHINE) $(QEMU_EL3_BASE_ARGS) -kernel
-run-gpc3-test: QEMU_OPTS=$(QEMU_EL3_MACHINE) $(QEMU_EL3_BASE_ARGS) -kernel
-
-# Simple Record/Replay Test
-.PHONY: memory-record
-run-memory-record: memory-record memory
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  -icount shift=5$(COMMA)rr=record$(COMMA)rrfile=record.bin \
-		  $(QEMU_OPTS) memory)
-
-.PHONY: memory-replay
-run-memory-replay: memory-replay run-memory-record
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  -icount shift=5$(COMMA)rr=replay$(COMMA)rrfile=record.bin \
-		  $(QEMU_OPTS) memory)
-
-EXTRA_RUNS+=run-memory-replay
-
-ifneq ($(CROSS_CC_HAS_ARMV8_3),)
-pauth-3: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
-# This test explicitly checks the output of the pauth operation so we
-# must force the use of the QARMA5 algorithm for it.
-run-pauth-3: QEMU_BASE_MACHINE=-M virt -cpu max,pauth-qarma5=on -display none
-else
-pauth-3:
-	$(call skip-test, "BUILD of $@", "missing compiler support")
-run-pauth-3:
-	$(call skip-test, "RUN of pauth-3", "not built")
-endif
-
-ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
-QEMU_MTE_ENABLED_MACHINE=-M virt,mte=on -cpu max -display none
-QEMU_OPTS_WITH_MTE_ON = $(QEMU_MTE_ENABLED_MACHINE) $(QEMU_BASE_ARGS) -kernel
-mte: CFLAGS+=-march=armv8.5-a+memtag
-mte: mte.S $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
-
-run-mte: QEMU_OPTS=$(QEMU_OPTS_WITH_MTE_ON)
-run-mte: mte
-
-ifeq ($(GDB_SUPPORTS_MTE_IN_BAREMETAL),y)
-run-gdbstub-mte: QEMU_OPTS=$(QEMU_OPTS_WITH_MTE_ON)
-run-gdbstub-mte: mte
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--output run-gdbstub-mte.out \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "-chardev null$(COMMA)id=output $(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py -- --mode=system, \
-	gdbstub MTE support)
-
-EXTRA_RUNS += run-gdbstub-mte
-else # !GDB_SUPPORTS_MTE_IN_BAREMETAL
-run-gdbstub-mte:
-	$(call skip-test "RUN of gdbstub-mte", "GDB does not support MTE in baremetal!")
-endif
-else # !CROSS_CC_HAS_ARMV8_MTE
-mte:
-	$(call skip-test, "BUILD of $@", "missing compiler support")
-run-mte:
-	$(call skip-test, "RUN of mte", "not build")
-endif
diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index 9ec8df169d5..28498e82cba 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -21,6 +21,8 @@ gdb_feat_version = {
   'mte-baremetal': '16.0',
 }
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
new file mode 100644
index 00000000000..94e16ba3300
--- /dev/null
+++ b/tests/tcg/aarch64/system/meson.build
@@ -0,0 +1,109 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-ffreestanding',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script]
+qemu_base_args = ['-display', 'none',
+                  '-semihosting-config', 'enable=on',
+                  '-kernel']
+qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]
+
+# Multi arch tests - add cflags only once per src
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=1'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+tests += {
+  '../../multiarch/system/memory.c': {
+    'exe_name': 'memory-sve',
+    'cc_feat': 'sve',
+    'cflags': [cflags, '-DCHECK_UNALIGNED=1', '-O3'],
+    'qemu_args': qemu_def_args,
+  },
+}
+
+tests += {
+  'asid2.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'feat-xs.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'gpc-test.c': {
+    'cflags': [cflags, '-DLOGGING_VECTOR_TABLE',
+               '-Wno-main', '-Wno-unused-but-set-variable'],
+    'qemu_args': ['-M', 'virt,secure=on,virtualization=on,gic-version=3',
+                  '-cpu', 'max,x-rme=on',
+                  '-semihosting-config', 'enable=on,arg=3',
+                  qemu_base_args],
+  },
+  'rme_gdi.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'semiheap.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'semiconsole.c': {
+    'cflags': cflags,
+    'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
+                  '-semihosting-config', 'enable=on,chardev=stdio0',
+                  '-mon', 'chardev=stdio0,mode=readline',
+                  qemu_def_args],
+    'wrapper': [prog_run_with_input, 'X']
+  },
+  '../../multiarch/system/memory.c': {
+    'test_name': 'memory-record-replay',
+    'qemu_args': qemu_def_args,
+    'wrapper': [prog_record_replay],
+  },
+  'vtimer.c': {
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt,virtualization=on,gic-version=2',
+                  '-cpu', 'cortex-a57', '-smp', '4',
+                  '-semihosting-config', 'enable=on,arg=2',
+                  qemu_base_args]
+  },
+}
+
+tests += {
+  'pauth-3.c': {
+    'cc_feat': 'v8.3',
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt', '-cpu', 'max,pauth-qarma5=on', qemu_base_args],
+  }
+}
+
+tests += {
+  'mte.S': {
+    'cc_feat': 'mte',
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt,mte=on', '-cpu', 'max', qemu_base_args],
+    'gdb_test': ['--test', files('../gdbstub/test-mte.py'), '--', '--mode=system'],
+    'gdb_feat': 'mte-baremetal',
+  }
+}
+
+if 'qemu-system-aarch64' in emulators
+  tcg_tests += {
+    'aarch64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'aarch64/system',
+      'gdb_arch': 'aarch64',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-system-aarch64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


