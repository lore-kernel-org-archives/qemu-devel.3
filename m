Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6D5C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Ta6-0006RH-Ez; Fri, 04 Sep 2026 09:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZo-0006KE-4Z
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZm-00033b-8u
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:27 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso15446015e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527004; x=1789131804; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZNYQBkS0hVqwg3KO7xo8pHxpdKpIrSQL4tao4qR/MKw=;
 b=QiGUYZfbowkNNv3XRaiMrXABgoqdLhqwg80rc47Kb6+u7xhfLFBXUa5YCcU10LxeIn
 56vJNjdNwHdEZ3I38wGAvganrpbISYTQD9CoH11f9y/ZXm4Kr5ClUK2uv1JaqbxcKH+D
 A33vQNlABIB/HxgqJTMUdlTuFuIYceUzUh1Deq+DZlxlyjEh0FrOSUbzyNgF9Dq0IlKa
 BS8NMrahw6uEsHsPcdC0Z0jF2S0YHsOfcG2oVOMqBN1RbOIctCQ+ws1vnK0INJu4iFds
 uYZzUTmfsR8tY3IsHHu62I8oUVmMkAXbsDYQWPPgFo1MDy5lL/yfedmYdYTZLktrSID7
 8n5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527004; x=1789131804;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZNYQBkS0hVqwg3KO7xo8pHxpdKpIrSQL4tao4qR/MKw=;
 b=qMGy2WzWR7sj8lOo8PW7N5qwaRlwKSkZOm6a1bm/a2UqUajLUJO1TVH4CIEatDihMG
 ed9/Z5Cj6+Onv9OD0Q9HxXmbyVOKIXmrciW5zCOQMDZNuMwyPhSQ0ILhtW7o0B5IvT1a
 LTJfZNFcx3T1HpU1pv46dEzsBlZfGbw/QzfWf3YHGwZQMsZSJgRN2KGBgVJLoBaYwqha
 8tiXOw+tmhKWkwOIuaqWmYDZOh6OVeZ8cGJGa6vo91IsC+1grzJDfYH26vMD6JQSIpxk
 DOHnuUVVfUgpKdLn63cGO8lgKeTZ81SsUIh+SrgofF5cGYmau85Jd9zgv09EIxsMz9EQ
 0SFg==
X-Gm-Message-State: AFuF++neim42htZvUzdJFN61YV3Pn6Rny2/aD85EbfB+9FsKmVODB4Yi
 yjyARUxc0hqHRSPqRjvFnRGDNFy1g+28JSRqEywLwhLycnKTTXqcc+tSlip2zpslwcs=
X-Gm-Gg: AYBFou21sIZvqsGwEw3hqJEke4ZPBId4xzC2QwrB3yCO9YeFr+TFanTnimLQJuq7lHB
 8fbSEf4/WsyVxyA8cusLpsBu+4DXntipbW0U0F9h8SRDQFt3GXoWGMHpuWMUL6Itx4xqMSzwIYR
 V+7/eJI2kOjeb1lZl+l0ZRPWJSu6wKWSdjAQXvGHBQWE74cJdCN5u3xu73uBjw8o6H3g4psqxRu
 Ypn9zhcB3Bat4jbfH/W6LKWr67wD2vMA77FC7vle9Z8I331Sy9uub83/P/ZvrWkauDfHTaRcTK1
 jnhDtksCgGHgh9FsjGtlXj37W+Pzh78ivEzOAZ9VxrG+thhfh+xe7xGwjQp43bfsvA/wTVcHCiw
 qoCxHpgM7E/mWbCpBHgEMp6uQi22mEcUu+srEjysd/TazGuxeWeoJHr1BeD7Cx1zEa9ND5+Imga
 9AM8htk7HZUrPMnXbUAfEaLps3BTTjrYR7MY4UsC8LF8l6KriNlJTbc3IzxNIGy91PPa3k7TQ=
X-Received: by 2002:a05:600c:4f0c:b0:49b:924e:9a28 with SMTP id
 5b1f17b1804b1-49cf8207110mr66434355e9.1.1788527004345; 
 Fri, 04 Sep 2026 06:03:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7739b7asm65232045e9.13.2026.09.04.06.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 04A8761377;
 Fri, 04 Sep 2026 13:46:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PULL 081/105] tests/tcg/riscv64: system tests
Date: Fri,  4 Sep 2026 13:45:35 +0100
Message-ID: <20260904124604.2207440-82-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
Message-ID: <20260827221506.91574-82-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
index b5f574c1377..2292bf8ed1b 100644
--- a/tests/tcg/riscv64/meson.build
+++ b/tests/tcg/riscv64/meson.build
@@ -2,6 +2,8 @@ cc = 'riscv64-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_host_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
new file mode 100644
index 00000000000..80b4fdb91e4
--- /dev/null
+++ b/tests/tcg/riscv64/system/meson.build
@@ -0,0 +1,55 @@
+tests = []
+
+# Multi arch tests are not supported
+# tests += tcg_tests['multiarch-softmmu']['tests']
+
+link_script = files('../semihost.ld')[0]
+cflags = ['-nostdlib',
+          '-ffreestanding',
+          '-Wa,--noexecstack',
+          '-Wl,-T', link_script]
+qemu_args = ['-M', 'virt',
+             '-display', 'none',
+             '-serial', 'stdio',
+             '-semihosting',
+             '-bios']
+
+setup = {'cflags': cflags, 'qemu_args': qemu_args}
+
+tests += {
+  'doubletrap.S': setup + {'plugin_test': {'plugin': 'discons'}},
+  'interruptedmemory.S': setup + {'plugin_test': {'plugin': 'discons'}},
+  'issue1060.S': setup,
+  'test-mepc-masking.S': setup,
+  'test-crc32.S': setup + {'qemu_args': ['-cpu', 'rv64,xlrbr=true', qemu_args]},
+  'test-minstret-ecall.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
+  'test-misa-w.S': setup + {'qemu_args': ['-cpu', 'rv64,x-misa-w=true,c=true,v=true', qemu_args]},
+}
+
+tests += {
+  'test-zicclsm.S': {
+    'cflags': cflags + ['-march=rv64gcv_zfh'],
+    'qemu_args': ['-cpu', 'rv64,v=true,zfh=true,zicclsm=true', qemu_args],
+  }
+}
+tests += {
+  'test-zicclsm.S': {
+    'exe_name': 'test-zicclsm-off',
+    'cflags': cflags + ['-march=rv64gcv_zfh', '-DZICCLSM_DISABLED'],
+    'qemu_args': ['-cpu', 'rv64,v=true,zfh=true,zicclsm=false', qemu_args],
+  }
+}
+
+if 'qemu-system-riscv64' in emulators
+  tcg_tests += {
+    'riscv64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'riscv64',
+      'gdb_arch': 'riscv64',
+      'qemu': emulators['qemu-system-riscv64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


