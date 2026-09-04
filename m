Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415F0C79F88
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQG-0001df-Ul; Fri, 04 Sep 2026 08:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQE-0001cG-RW
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQC-0000gI-UQ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:34 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48586861639so678803f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526411; x=1789131211; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S8eQ+7Z6+0xFs1DW+qXSLA+xxMg7Efwg9xJ1Y21YCVI=;
 b=wrzMMSenO2WOMr9MMqhqmVfWUi2uGZw0Jif6OjRTxPoQTRSlgUqdlnmbi8yuCJbJFF
 bxUj08B6qYhO6LM83E/vL2QditfIJQsCX31kude5o9kxkKfFTD77Njbun4h4B2N0AT8X
 TJQw8n2VVBxFb62Jv4Z0lzvrHVAaZPT1st5/dgM8ynsffwZlFICMHfrK9za56qwooSZQ
 5VK/gnSJaBGewEK8sH7TWAWYpNjaP5Pf5a5LyYkR/ZRZ+9wssz77oKKh4tPjM4GNGW5h
 R52d/lzM5w4/kPrMR6BVgTc5BFg47aqXfFNcHOgImb5c7WRRUP61Wtn6JUstbl48fO31
 FHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526411; x=1789131211;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S8eQ+7Z6+0xFs1DW+qXSLA+xxMg7Efwg9xJ1Y21YCVI=;
 b=OYZJtkr/UBmbYI7cG2XmXX7bFdmJP/n02Elo4AXefGo+PWOMmGn1eopjhFPw2vCt/9
 0D4jaiF+tU+nGprpGVrZh1H+fpw1h/ZxkEHZJ2wopNO0rx7gw0yFf+pYqJRtkdTItsMn
 kA44F8n7Ibovs5R0gxsaaIBE3Fpq2/J2U35qXUfn5qbyK77H6QeTBePROXDb5JiF98p4
 PVP47vunxTWGhUCGAMg2TiLOXXqA+DNGPI4P3VYgZXl3RMutD2aLI2mOnpsDguJgsipg
 dEkXlOD+OKN5+bNU1vg2ZDK21bwrtOIOQustNEUsgwiJf1DkgNfWWOztUDEEq5wn0Dat
 si0g==
X-Gm-Message-State: AFuF++mcYBJNWhC+SQ1wv8SfGAO3amBPT7T1u8ZbtnrEbV7zpP77DnnL
 zg2kVy5KUEEupToqGMt/RTt7bBl55TAeQMAF0A5dGhZ8sMs1xhnX6EcED+zQ3GVgvOo=
X-Gm-Gg: AYBFou3BppMTqgC6Hr+MT1TUItuPDaypXshCtHrXZHFZxbZ0uSA5GD6RHidbWOCeWTY
 GBtasQmk4I0Gbl8kweNfs346tGABaaFb4bQOQmYjj9sOudcpAr/mNqxnKeRy36MeuSBqRSPVHSq
 VdB7YYyRTjQxyyeE/tSORpbDbGVy5giJ9c9JmzoXMdoZV/vMIr3O1WMalrp1sfgibGwbOF+bxLG
 qKA59/rqAITAqRi5VMjwVOQFws0UzigEDHBsbFn7c1LEUedNolMnVTwGxJejKd/DhMGhtuFeU2Z
 BQbu6NCLF7kN0lK9DMcHTX73NRkWWkuub/rdDVvttnvOMYfi4EsWbVrlrmBqhGunp9HCUwh0AYg
 09apQSS6L0ib42ri2gnXrmWHFGSWB9IJd0Kp/1kXw/Cl7YB0pzsxkLFP9E8d4SDN0QLv4J2rDiW
 MnOkPNWLRGRsRUMTGpcvZJtXK0wgXKVhVnCeJxgymy4Es5F0YkT2mpbY4apo9LZgs5kTgFtFI=
X-Received: by 2002:adf:e011:0:20b0:485:8e0c:641e with SMTP id
 ffacd0b85a97d-4858e0c648bmr1255307f8f.22.1788526411360; 
 Fri, 04 Sep 2026 05:53:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883959f0sm6611886f8f.10.2026.09.04.05.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:26 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 265D061DD8;
 Fri, 04 Sep 2026 13:46:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 091/105] tests/tcg/x86_64: user tests
Date: Fri,  4 Sep 2026 13:45:45 +0100
Message-ID: <20260904124604.2207440-92-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-92-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4903947a636..163e0a96753 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -155,6 +155,7 @@ subdir('riscv64')
 subdir('s390x')
 subdir('sh4')
 subdir('tricore')
+subdir('x86_64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
deleted file mode 100644
index 9994dff4c44..00000000000
--- a/tests/tcg/x86_64/Makefile.target
+++ /dev/null
@@ -1,41 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# x86_64 tests - included from tests/tcg/Makefile.target
-#
-# Currently we only build test-x86_64 and test-i386-ssse3 from
-# $(SRC_PATH)/tests/tcg/i386/
-#
-
-#include $(SRC_PATH)/tests/tcg/i386/Makefile.target
-
-X86_64_TESTS += test-2413
-
-ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
-X86_64_TESTS += vsyscall
-X86_64_TESTS += noexec
-X86_64_TESTS += cmpxchg
-X86_64_TESTS += adox
-X86_64_TESTS += segment-prefixes
-X86_64_TESTS += test-1648
-X86_64_TESTS += test-2175
-X86_64_TESTS += cross-modifying-code
-X86_64_TESTS += fma
-TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) #test-x86_64
-else
-TESTS=$(MULTIARCH_TESTS)
-endif
-
-adox: CFLAGS=-O2
-
-run-test-i386-ssse3: QEMU_OPTS += -cpu max
-run-plugin-test-i386-ssse3-%: QEMU_OPTS += -cpu max
-
-cross-modifying-code: CFLAGS+=-pthread
-cross-modifying-code: LDFLAGS+=-pthread
-
-#test-x86_64: LDFLAGS+=-lm -lc
-#test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.h
-#	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
-
-%: $(SRC_PATH)/tests/tcg/x86_64/%.c
-	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
new file mode 100644
index 00000000000..2607a1cbcf4
--- /dev/null
+++ b/tests/tcg/x86_64/meson.build
@@ -0,0 +1,82 @@
+cc = 'x86_64-linux-gnu-gcc'
+cc_dockerfile = 'debian-amd64-cross'
+cc_docker_host_arch = ['x86_64']
+
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+test_3dnow_h = custom_target('test_3dnow_h',
+                             command: [files('../i386/test-mmx.py'),
+                                       files('../i386/x86.csv'),
+                                       '@OUTPUT@',
+                                       '3DNOW'],
+                             output: 'test-3dnow.h')
+
+test_avx_h = custom_target('test_avx_h',
+                           command: [files('../i386/test-avx.py'),
+                                     files('../i386/x86.csv'),
+                                     '@OUTPUT@'],
+                           output: 'test-avx.h')
+
+test_mmx_h = custom_target('test_mmx_h',
+                           command: [files('../i386/test-mmx.py'),
+                                     files('../i386/x86.csv'),
+                                     '@OUTPUT@',
+                                     'MMX', 'SSE', 'SSE2', 'SSE3', 'SSSE3'],
+                           output: 'test-mmx.h')
+
+tests += {
+  '../i386/test-i386-ssse3.c': {},
+  '../i386/test-3dnow.c': {
+    'cflags': ['-I', meson.current_build_dir(),
+               '-masm=intel', '-O'],
+    'depends': [test_3dnow_h],
+  },
+  '../i386/test-avx.c': {
+    'cflags': ['-I', meson.current_build_dir(),
+               '-mavx', '-masm=intel', '-O'],
+    'depends': [test_avx_h],
+  },
+  '../i386/test-flags.c': {},
+  '../i386/test-mmx.c': {
+    'cflags': ['-I', meson.current_build_dir(),
+               '-masm=intel', '-O'],
+    'depends': [test_mmx_h],
+  },
+  '../i386/test-i386.c': {
+    'cflags': ['-lm', '-lc'],
+    'exe_name': 'test-x86_64'
+  },
+  '../i386/test-i386-adcox.c': {'cflags': ['-O2']},
+  '../i386/test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
+}
+
+tests += {
+  'adox.c': {'cflags': ['-O2']},
+  'cmpxchg.c': {},
+  'cross-modifying-code.c': {
+    'cflags': ['-pthread', '-Wl,--no-warn-rwx-segments']
+  },
+  'fma.c': {},
+  'noexec.c': {},
+  'segment-prefixes.c': {},
+  'test-1648.c': {},
+  'test-2175.c': {},
+  'test-2413.c': {},
+  'vsyscall.c': {},
+}
+
+if 'qemu-x86_64' in emulators
+  tcg_tests += {
+    'x86_64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'x86_64',
+      'gdb_arch': 'x86_64',
+      'qemu': emulators['qemu-x86_64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


