Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9075C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Taz-00085v-53; Fri, 04 Sep 2026 09:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TaF-0006YO-TJ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:04:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Ta3-00039o-44
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so12967585e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527017; x=1789131817; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+hFNbY683+aKu5INm/nevVq53hBRivg5hbWYiM/SJ/U=;
 b=o+QWBW4LpVMKqyPTLaHNO9kWuFED5Hr31c5ilBdyvAc/ONSLWeeCYBOGzQuNJio09c
 VVbk0/nsitH41sRGAZD3TiuJ7MmkiIfhtD1XTYQhwcwcU7A6vYszAPgT6OLQ9a64sk6P
 ss70APgl0ib/vxktXF6Pi1Rkiw4d6xgS4NvfNtl2gtzoszbLrw2YmJ0t6HPOYl8oz5nt
 sY4mt7IpdBCb2ijgFdJGoAUsZRvf2AuWZycNfuVKEgKwvMhbx+BRs+eWRso4R+2uiVyj
 jtD5aww8pAR/JQM2CGPxtmSFr14GswpSrKgxY0WV3Z1oNU2eLm/pZS1plKA6ezM2qxEy
 KNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527017; x=1789131817;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+hFNbY683+aKu5INm/nevVq53hBRivg5hbWYiM/SJ/U=;
 b=MI+7lxbm7tw/WwRXERl5eAaipugYxY5KdetNFqNX0D+61GUzzvUjVDY14M0tC/d099
 xT1bPKzPAShsO6i0/3/PYQyD5nyjFIQhD9puWWXpheaBu68uPOHflzqc4a1tSwspF1hX
 /8hVkEaJBC76BPuaYXiYgY3UtvKlpzyq6EAAwYcWRXYv5hYQBUkYaWfOgBd12CeVhyMC
 7iI5ZJei8Tr+J+DgTj3OExM1MFPY8IgGZqpH634UMzL3Ebtbd0m3GDdhoqbEWkWgIVLr
 5jFgFEe3qxR1xJimoXyAKr7MIQ8DzKGbXUQqACBewauJh/crVxAPfWgxt17+gl6oGL1B
 Iuhw==
X-Gm-Message-State: AFuF++ldNfGGXr/NyzfPPvijkwKuoklJObCYJdXbV6g57+QUeJamcaY7
 eqm6QAQ5t0PXU9WB6pI3d+80u/yQgl3YyYaP5G0pJrnckrtj+vkXzSrTnbx+Tfu+XYc=
X-Gm-Gg: AYBFou20jIEx57OHV1HwB5JAiDiMTlHmNw4BAnBCA//fcUJvyQWWpPZ4CeRC6FBJnPG
 wQJJ89L6EjPuSrHAd5obhm4TsA0lrta3CiXRpGSnrCuVE9WhMaUOjdHbFzRxYeoOttNvBX51/q5
 uhxJdJJ+K8n46l546uvRW+ST5Vz9HJTpcF96GXW9hJhE+Uk0/BeG4uPvZNaImySoZW6+LwE91F6
 MGAmAe4Nahq+nRvcCG56FTBRWYtXJ2/wOAGvagOrzD01Od1n+7/LGHR/I7faGhkpEZN7P/ejsp0
 NPzLlj2Vb9cPIziPZuvc+qExseFNgrZiSuyFFsCDMX7eAR5tp+993mEFd1Mn8ZrsZt1X7G76Jtk
 8/mpKsJddYLNsi9b49w98ESp/t9KZMO017jexObIanxNgHCb2YNNrjlCyzVSUty7ekesefpeBWI
 JRL+f0oTqtd7aJdQ8g0BysMrZL7Sqm0vBHiQqKv1WXzNZszcjlBk9a3fwyUSeg
X-Received: by 2002:a05:600c:310e:b0:49c:fa21:1c84 with SMTP id
 5b1f17b1804b1-49cfa211ce7mr40051485e9.25.1788527017203; 
 Fri, 04 Sep 2026 06:03:37 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5563c6csm161486995e9.4.2026.09.04.06.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E15F261D56;
 Fri, 04 Sep 2026 13:46:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PULL 080/105] tests/tcg/riscv64: user tests
Date: Fri,  4 Sep 2026 13:45:34 +0100
Message-ID: <20260904124604.2207440-81-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-81-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f13f0d84792..1a48b37f75c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -151,6 +151,7 @@ subdir('mips64el')
 subdir('or1k')
 subdir('ppc64')
 subdir('ppc64le')
+subdir('riscv64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
deleted file mode 100644
index 4da5b9a3b32..00000000000
--- a/tests/tcg/riscv64/Makefile.target
+++ /dev/null
@@ -1,20 +0,0 @@
-# -*- Mode: makefile -*-
-# RISC-V specific tweaks
-
-VPATH += $(SRC_PATH)/tests/tcg/riscv64
-TESTS += test-div
-TESTS += noexec
-
-# Disable compressed instructions for test-noc
-TESTS += test-noc
-test-noc: LDFLAGS = -nostdlib -static
-run-test-noc: QEMU_OPTS += -cpu rv64,c=false
-
-TESTS += test-aes
-run-test-aes: QEMU_OPTS += -cpu rv64,zk=on
-
-# Test for fcvtmod
-TESTS += test-fcvtmod
-test-fcvtmod: CFLAGS += -march=rv64imafdc
-test-fcvtmod: LDFLAGS += -static
-run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true
diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
new file mode 100644
index 00000000000..b5f574c1377
--- /dev/null
+++ b/tests/tcg/riscv64/meson.build
@@ -0,0 +1,36 @@
+cc = 'riscv64-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+tests = []
+
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'noexec.c': {},
+  'test-aes.c': {'qemu_args': ['-cpu', 'rv64,zk=on']},
+  'test-div.c': {},
+  'test-fcvtmod.c': {
+    'cflags': ['-march=rv64imafdc'],
+    'qemu_args': ['-cpu', 'rv64,d=true,zfa=true'],
+  },
+  'test-noc.S': {
+    'cflags': ['-nostdlib'],
+    'qemu_args': ['-cpu', 'rv64,c=false'],
+  },
+}
+
+if 'qemu-riscv64' in emulators
+  tcg_tests += {
+    'riscv64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'riscv64',
+      'gdb_arch': 'riscv64',
+      'qemu': emulators['qemu-riscv64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


