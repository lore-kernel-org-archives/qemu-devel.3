Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3A7C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Ta8-0006Uq-Ii; Fri, 04 Sep 2026 09:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZq-0006Nc-5t
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:32 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZm-00033s-Qt
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:29 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c15e592da74so113210966b.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527005; x=1789131805; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VNYduESDtmcDFsqNFOi+JuL1O/4wUrbP18At2xpgW/8=;
 b=PzWkzQYOp8YnZx2F8SKPihdKeFz7znoioX0X8vZZmhKkdpXm40ikQLPi3o6+nJHN+P
 lNGwCEqNV2q5Io8xz5UqaTQy/C2F9ke19rFp+ehX8EqaV802KLM6V7SwQOqabRiDWuw+
 MV6SrrCj395yWuvnIMtdbxhlRmrz4PacsGz5NODZKGyKGpdWat/4w3efViaYkv7psxuT
 DRHiM2IXpcF/r+guhX4sOHmIFNM6QC6oZe7+Kn02eJiYT2ToRQjy7shhmh8SyFsTNe3Z
 id3wuNoASiEkeWokiWksxhHpKNYR0edQ64oDUncCMQ3gyTZY4j28EfR5JGCzoWZZb4Ka
 nkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527005; x=1789131805;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VNYduESDtmcDFsqNFOi+JuL1O/4wUrbP18At2xpgW/8=;
 b=rbFSTJEVpFt1Z9mDx8/bAyFZHDiqHRap8NtKffsQMtFi+l+JQrUDmJWP3M5yTGOtXS
 pTypGjGKtrLCJe1TTTa6OmqZtjSMRcRzz/eXCoyN2TZpCF52nY9ybsBzzd837sRO0B5w
 DrxJUgZsDeHAFRzg4Jh+Fq1UCe1lRv4L96rqSfLZ4H138QMb4APG5YUv3RfnCiKlcO5z
 Vo4WtRAgcDPOiWKywtK0Dk13E2T59q0oE4V5hgorcIbF+DqFd71b+7g8F8+lissbwz7z
 IICgoq/n+E/9BiuJQkgGNIwJcLRiX3KCpbGFygt7M9Ph4PfFqeH2Uy6cInFhRxo+mPz/
 /fkw==
X-Gm-Message-State: AFuF++lX4xyKNGZ3EP/BaM+xs3QdC+yfAfx/bWo7sp33YG8ZIarIwXgp
 4DmCRjvKJOHhQL5JdEyH1BRng+O+XjmSGcl3MlkxRRLuqo8NC1Ce3+Wce9+pJjIFtcU=
X-Gm-Gg: AYBFou2w4OTY5ekRmLGXHBtKEhXOrio4+PC21aZRQQ8yglizqLODVm4b1JajfGEXyEK
 4HMBT88jTWJKjW5i+xraDHjbplIUO3jv5HQTw9J1jP5Pcm6+kPskCgOH1XjJr1SynJK6k0iogfE
 iNgm1FiFvuhgpoWOdbWEge88KPpFeWGfUDwxd/xHtzUAAYnCg+tJrcW6b8GS2I/aCSIJQKhEoRH
 rUbHCruVxUCboLhkv+/LMuDVUe8sRvw/WXUQb8S8jvxjocnCtpqSAyLDivb+5foPPNfD+rtEdzL
 u5LXdJyNrTWY3Ezt+3o0Iw+SiniYX7bVtOY4lOuyzpdwSbuEOF5pkFC/Y0YDTKruEiZd0QUfaeB
 O6fIGRE6nsNaqiKV4fBNZAsBQ0k59bDoxiWMMOPlSVB78BfyKHCqD8dKb/zOAGDg+ZCp7MqhBNJ
 l7hnANERSNRiYJpBYMZEcx1Yf3vv6hYDTqI3v3Srg+cM085XND//tY/kvuuBiGxHig+r7oAys=
X-Received: by 2002:a17:907:3e8c:b0:c26:19de:9acc with SMTP id
 a640c23a62f3a-c2619dea6e2mr109602066b.36.1788527004915; 
 Fri, 04 Sep 2026 06:03:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883be709sm6042247f8f.21.2026.09.04.06.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 890F8618F9;
 Fri, 04 Sep 2026 13:46:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 043/105] tests/tcg/aarch64_be: user tests
Date: Fri,  4 Sep 2026 13:44:57 +0100
Message-ID: <20260904124604.2207440-44-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-44-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64_be/Makefile.target b/tests/tcg/aarch64_be/Makefile.target
deleted file mode 100644
index cbe5fa0b2db..00000000000
--- a/tests/tcg/aarch64_be/Makefile.target
+++ /dev/null
@@ -1,17 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# A super basic AArch64 BE makefile. As we don't have any big-endian
-# libc available the best we can do is a basic Hello World.
-
-AARCH64BE_SRC=$(SRC_PATH)/tests/tcg/aarch64_be
-VPATH += $(AARCH64BE_SRC)
-
-AARCH64BE_TEST_SRCS=$(notdir $(wildcard $(AARCH64BE_SRC)/*.c))
-AARCH64BE_TESTS=$(AARCH64BE_TEST_SRCS:.c=)
-#MULTIARCH_TESTS = $(MULTIARCH_SRCS:.c=)
-
-# We need to specify big-endian cflags
-CFLAGS +=-mbig-endian -ffreestanding
-LDFLAGS +=-nostdlib
-
-TESTS += $(AARCH64BE_TESTS)
diff --git a/tests/tcg/aarch64_be/meson.build b/tests/tcg/aarch64_be/meson.build
new file mode 100644
index 00000000000..9ea111f9885
--- /dev/null
+++ b/tests/tcg/aarch64_be/meson.build
@@ -0,0 +1,22 @@
+tests = []
+
+# As we don't have any big-endian libc available,
+# the best we can do is a basic Hello World.
+tests += {
+  'hello.c': {'cflags': ['-mbig-endian', '-ffreestanding', '-nostdlib']},
+}
+
+if 'qemu-aarch64_be' in emulators
+  tcg_tests += {
+    'aarch64_be-linux-user': {
+      'cc': 'aarch64-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'aarch64_be',
+      'gdb_arch': 'aarch64_be',
+      'qemu': emulators['qemu-aarch64_be'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 76d7dbe045b..d878581b660 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -137,6 +137,7 @@ endforeach
 
 # Now let's go through all architectures
 subdir('aarch64')
+subdir('aarch64_be')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


