Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527DEC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNB59-0002nS-1h; Fri, 28 Jun 2024 08:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNB57-0002la-9K
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:52:01 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNB54-0007jA-E6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:52:00 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57d4ee2aaabso698796a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719579117; x=1720183917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IUp/jz4rurgmUyufGxM677pLFVpot9n0df0Oc0PFpvc=;
 b=xBy8Pef3RQWKFPCWwiq72AULwNfEoPUEzOcsOJ2zZmiLTdhbr2jHWEY3V2JlCqSqVH
 u9S3/XcBbyb38TNx9yWUW0u03pM+9SLX0clKNgCHvSHGPuDpZqzK5Q6kgWpePhOpoF/1
 fLcniesDzC48SkLvcMl+Kcc10FFoYZS6KgHnE9dKjRHQCbYFm+caVeho8F8Wx9fM0cTU
 VduXaL9HTz5Wx9qrV0vR+23nopHK6cHcjCbXUgnTDvUJ65Y7L+dwBJep8RkuJ9CRp3UE
 F+R/zcZVdAWbac5GABFmBDxZ7zgAGfKY8Cvbxl98QCi0RDC/LxvznZxd6y7R2kzPJP1m
 01bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719579117; x=1720183917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IUp/jz4rurgmUyufGxM677pLFVpot9n0df0Oc0PFpvc=;
 b=E51Rz3ybGFSslRn+1iF/YZVsjVgQBmzkrpcr3ndaK/uAEjW6Rhjji2qH7hUHpJlbdr
 FtxQ7L12e94WLjUPyaBX6+s12PJH8cTI5vi543OCNdSUtHe5ccG39S6WPAQPP/hWGDkG
 cXYqkBh4RurSOq70Q9MiZxgw81/kWmZ4u4YI3OaZxbsCxg4wDJpZrkX5ItYIdrJGeSGt
 6Jx0FR98IonuWNsgEP2vyPYIDKy0tBTvNC+BuYtatW8HSuIdzs+TzbF4WPDSJs5tUpjR
 DI2a0J93ck63Emc31lEXhN2aI8IdXSLbTb/6ibCCP3mRCa4spqx3h2fNHlE9GjkXNDoq
 maeA==
X-Gm-Message-State: AOJu0Yxs33fMqckkaos02ao5kxfEmmE9775O6/lXdry08fQLIXItwmNn
 HP8cg1G/QR4rWsFQx8hsM3qgm4QKPFh/5eEZUKIPOyDd7te7B1dkjnC7/I/zpkY=
X-Google-Smtp-Source: AGHT+IEC/Zx+ubpx7uuSHiTb5thWijYPZpOqy1lcU6c2bZjabMQe7zW8eO8SR8TSjF4ajM0mOUdJhg==
X-Received: by 2002:a05:6402:35d4:b0:57c:a7fe:d275 with SMTP id
 4fb4d7f45d1cf-57d4bdca699mr14040707a12.32.1719579116326; 
 Fri, 28 Jun 2024 05:51:56 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c83583sm1002569a12.5.2024.06.28.05.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:51:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3CAF55FA41;
 Fri, 28 Jun 2024 13:43:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 23/23] tests/tcg/aarch64: Add MTE gdbstub tests
Date: Fri, 28 Jun 2024 13:42:58 +0100
Message-Id: <20240628124258.832466-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Add tests to exercise the MTE stubs. The tests will only run if a
version of GDB that supports MTE is available in the test environment.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20240628050850.536447-12-gustavo.romero@linaro.org>
---
 configure                             |  4 ++
 tests/tcg/aarch64/mte-8.c             | 98 +++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target     | 14 +++-
 tests/tcg/aarch64/gdbstub/test-mte.py | 86 +++++++++++++++++++++++
 4 files changed, 201 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/mte-8.c
 create mode 100644 tests/tcg/aarch64/gdbstub/test-mte.py

diff --git a/configure b/configure
index 5ad1674ca5..10f7e1259a 100755
--- a/configure
+++ b/configure
@@ -1673,6 +1673,10 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
+      if test "${arch}" = "aarch64" && version_ge ${gdb_version##* } 15.0; then
+          echo "GDB_HAS_MTE=y" >> $config_target_mak
+      fi
+
       echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
       tcg_tests_targets="$tcg_tests_targets $target"
   fi
diff --git a/tests/tcg/aarch64/mte-8.c b/tests/tcg/aarch64/mte-8.c
new file mode 100644
index 0000000000..9fffd7b737
--- /dev/null
+++ b/tests/tcg/aarch64/mte-8.c
@@ -0,0 +1,98 @@
+/*
+ * To be compiled with -march=armv8.5-a+memtag
+ *
+ * This test is adapted from a Linux test. Please see:
+ *
+ * https://www.kernel.org/doc/html/next/arch/arm64/memory-tagging-extension.html#example-of-correct-usage
+ */
+#include <errno.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/auxv.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <string.h>
+/*
+ * From arch/arm64/include/uapi/asm/hwcap.h
+ */
+#define HWCAP2_MTE              (1 << 18)
+
+/*
+ * From arch/arm64/include/uapi/asm/mman.h
+ */
+#define PROT_MTE                 0x20
+
+/*
+ * Insert a random logical tag into the given pointer.
+ */
+#define insert_random_tag(ptr) ({                   \
+    uint64_t __val;                                 \
+    asm("irg %0, %1" : "=r" (__val) : "r" (ptr));   \
+    __val;                                          \
+})
+
+/*
+ * Set the allocation tag on the destination address.
+ */
+#define set_tag(tagged_addr) do {                                      \
+        asm volatile("stg %0, [%0]" : : "r" (tagged_addr) : "memory"); \
+} while (0)
+
+
+int main(int argc, char *argv[])
+{
+    unsigned char *a;
+    unsigned long page_sz = sysconf(_SC_PAGESIZE);
+    unsigned long hwcap2 = getauxval(AT_HWCAP2);
+
+    /* check if MTE is present */
+    if (!(hwcap2 & HWCAP2_MTE))
+            return EXIT_FAILURE;
+
+    /*
+     * Enable the tagged address ABI, synchronous or asynchronous MTE
+     * tag check faults (based on per-CPU preference) and allow all
+     * non-zero tags in the randomly generated set.
+     */
+    if (prctl(PR_SET_TAGGED_ADDR_CTRL,
+              PR_TAGGED_ADDR_ENABLE | PR_MTE_TCF_SYNC | PR_MTE_TCF_ASYNC |
+              (0xfffe << PR_MTE_TAG_SHIFT),
+              0, 0, 0)) {
+        perror("prctl() failed");
+        return EXIT_FAILURE;
+    }
+
+    a = mmap(0, page_sz, PROT_READ | PROT_WRITE,
+             MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    if (a == MAP_FAILED) {
+        perror("mmap() failed");
+        return EXIT_FAILURE;
+    }
+
+    printf("a[] address is %p\n", a);
+
+    /*
+     * Enable MTE on the above anonymous mmap. The flag could be passed
+     * directly to mmap() and skip this step.
+     */
+    if (mprotect(a, page_sz, PROT_READ | PROT_WRITE | PROT_MTE)) {
+        perror("mprotect() failed");
+        return EXIT_FAILURE;
+    }
+
+    /* access with the default tag (0) */
+    a[0] = 1;
+    a[1] = 2;
+
+    printf("a[0] = %hhu a[1] = %hhu\n", a[0], a[1]);
+
+    /* set the logical and allocation tags */
+    a = (unsigned char *)insert_random_tag(a);
+    set_tag(a);
+
+    printf("%p\n", a);
+
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 70d728ae9a..f306e3d257 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -62,7 +62,7 @@ AARCH64_TESTS += bti-2
 
 # MTE Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
-AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7
+AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8
 mte-%: CFLAGS += -march=armv8.5-a+memtag
 endif
 
@@ -128,6 +128,18 @@ run-gdbstub-sve-ioctls: sve-ioctls
 	basic gdbstub SVE ZLEN support)
 
 EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls
+
+ifeq ($(GDB_HAS_MTE),y)
+run-gdbstub-mte: mte-8
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py, \
+	gdbstub MTE support)
+
+EXTRA_RUNS += run-gdbstub-mte
+endif
+
 endif
 endif
 
diff --git a/tests/tcg/aarch64/gdbstub/test-mte.py b/tests/tcg/aarch64/gdbstub/test-mte.py
new file mode 100644
index 0000000000..2db0663c1a
--- /dev/null
+++ b/tests/tcg/aarch64/gdbstub/test-mte.py
@@ -0,0 +1,86 @@
+from __future__ import print_function
+#
+# Test GDB memory-tag commands that exercise the stubs for the qIsAddressTagged,
+# qMemTag, and QMemTag packets. Logical tag-only commands rely on local
+# operations, hence don't exercise any stub.
+#
+# The test consists in breaking just after a atag() call (which sets the
+# allocation tag -- see mte-8.c for details) and setting/getting tags in
+# different memory locations and ranges starting at the address of the array
+# 'a'.
+#
+# This is launched via tests/guest-debug/run-test.py
+#
+
+
+import gdb
+import re
+from test_gdbstub import main, report
+
+
+PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \(0x[0-9a-f]+\)."
+PATTERN_1 = ".*(0x[0-9a-f]+)"
+
+
+def run_test():
+    gdb.execute("break 95", False, True)
+    gdb.execute("continue", False, True)
+    try:
+        # Test if we can check correctly that the allocation tag for
+        # array 'a' matches the logical tag after atag() is called.
+        co = gdb.execute("memory-tag check a", False, True)
+        tags_match = re.findall(PATTERN_0, co, re.MULTILINE)
+        if tags_match:
+            report(True, f"{tags_match[0]}")
+        else:
+            report(False, "Logical and allocation tags don't match!")
+
+        # Test allocation tag 'set and print' commands. Commands on logical
+        # tags rely on local operation and so don't exercise any stub.
+
+        # Set the allocation tag for the first granule (16 bytes) of
+        # address starting at 'a' address to a known value, i.e. 0x04.
+        gdb.execute("memory-tag set-allocation-tag a 1 04", False, True)
+
+        # Then set the allocation tag for the second granule to a known
+        # value, i.e. 0x06. This tests that contiguous tag granules are
+        # set correct and don't run over each other.
+        gdb.execute("memory-tag set-allocation-tag a+16 1 06", False, True)
+
+        # Read the known values back and check if they remain the same.
+
+        co = gdb.execute("memory-tag print-allocation-tag a", False, True)
+        first_tag = re.match(PATTERN_1, co)[1]
+
+        co = gdb.execute("memory-tag print-allocation-tag a+16", False, True)
+        second_tag = re.match(PATTERN_1, co)[1]
+
+        if first_tag == "0x4" and second_tag == "0x6":
+            report(True, "Allocation tags are correctly set/printed.")
+        else:
+            report(False, "Can't set/print allocation tags!")
+
+        # Now test fill pattern by setting a whole page with a pattern.
+        gdb.execute("memory-tag set-allocation-tag a 4096 0a0b", False, True)
+
+        # And read back the tags of the last two granules in page so
+        # we also test if the pattern is set correctly up to the end of
+        # the page.
+        co = gdb.execute("memory-tag print-allocation-tag a+4096-32", False, True)
+        tag = re.match(PATTERN_1, co)[1]
+
+        co = gdb.execute("memory-tag print-allocation-tag a+4096-16", False, True)
+        last_tag = re.match(PATTERN_1, co)[1]
+
+        if tag == "0xa" and last_tag == "0xb":
+            report(True, "Fill pattern is ok.")
+        else:
+            report(False, "Fill pattern failed!")
+
+    except gdb.error:
+        # This usually happens because a GDB version that does not
+        # support memory tagging was used to run the test.
+        report(False, "'memory-tag' command failed!")
+
+
+main(run_test, expected_arch="aarch64")
-- 
2.39.2


