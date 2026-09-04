Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCFCC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Tv2-0001QE-En; Fri, 04 Sep 2026 09:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Tv0-0001H8-I1
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:25:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Tuy-0000Km-Dd
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:25:22 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso8388745e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788528318; x=1789133118; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+UQa1ns1sHzCFUp6MFDqHelt5+H0pjkEegp8/6YCHtM=;
 b=vB+19xKFRiDVLnWm1beUSU8QaiJ//aHHin1I3cLg23vZier6wUJdQxXnsBywiHsKEr
 Uf92KR3AZ7a0IanLRJ252gNouUVHslSZ2P5MUzh0WdVj3X6Pb/0ceqV5/zR2p8y5Ly0R
 mljyOY4fOZ33tB6yKQA/hzM0e+H3wh3wAMFl8v7+lyVEdemzA2oJesYwHDazHJttf3VC
 FVdAqgrTO38onYGOf/Jk5NAYizkAkAqjzH0CVm/3YtCto4Q2M4fHEP8Lv2yyWL18VgUL
 2egTujuMIk6TSTJPAhMHf2YY03hcyyf3CIerOdQtyJBdJkgNWC775R6oRJHx8TC75mb5
 Awvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788528318; x=1789133118;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+UQa1ns1sHzCFUp6MFDqHelt5+H0pjkEegp8/6YCHtM=;
 b=kgL/O16OMCGvTNYVRdzHBsTfbdifhKUu6tf4w46PvbTWv/bieyTgNHrU/dZfTML66N
 TUHFXsUOaQafFV9tavUfAo4pPINAa0tdhOP6ZTHrZjy3MA2YPqiyIpC7wuvwC1zPY7k3
 eUgOfZuZXfzUpyX3KTfZ6hxKOAj4hPl9jQGQ3mdhFlpKrwcfqQfJXPk+CL8z1zza0BwD
 9+ZHu+xQ4qmQXTWx0RXdx2eTY4+4ZGnSFXCScULVREYyoLW6aOpRhbSwiGwpMLRPkW+t
 6qUhgt/s3v+L6CqvhheBltaliCoKjc+FRe3iYqkQTStiMd9XxFbzLaRqyS07S+bGVnLw
 XEQQ==
X-Gm-Message-State: AFuF++lJfOqzIgg+9b8f8JKwSC9roLysqAYCuQXNhQafFkSRbgdgi3uO
 FExAoH644iUUKu2nwTyHAATVloza5SIgvgMvUEJv+eqItP4GluHh6humI++0U7GhsSE7JImklev
 4vXQK1e0=
X-Gm-Gg: AYBFou1vL1OQ8G37o7Yoi6pNmvtw1wpPP/heO9OB1WGiY/0vyz5XfNAHbX/RuGgryY/
 IQPMD90tQocaAKn4KWn8JoDXvlPc1ENEUa+eFzVrPSX3bs+yJwsYXUR60gPXtH5AROJ8m3eBB28
 w2G9s/5OrPS9oXj9IIxmeD2BQ4NC9CNsglGXToooV3hlo+ZDD54fz5tSqtEzQjEIHNe7pWVSd5R
 hOlIJTPQ6kivpHe9ClnJmIWrMTgZ9S6nsFk410jHmmpud+hTqRi6+ImbyKbOR6ZNJwo+3IXuodr
 1i1z5B05pd62zTR2fRUx6wj5ZSBWgEEPBGXHwDwdi1NNnpI4jOHmrtV7liTreW2BoQlTcZL2q+L
 CTZCoVLsIh/U75AQ2LYpgekhb5oqBPmkNodw2B79YWqVrLIXlsAqDhogofP2ll+feFVWgLvr6dx
 h+MQ6G9jjgVcXlhLtx5otZzK78bEcULhj0kQPJK1q2R4U/Awlb0cxKGVXdoWBuJVXcBsbsvXY=
X-Received: by 2002:a05:600c:6095:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-49cf81ff697mr49727065e9.7.1788528210206; 
 Fri, 04 Sep 2026 06:23:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf771de2fsm71922955e9.8.2026.09.04.06.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:23:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EE87861BF2;
 Fri, 04 Sep 2026 13:46:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PULL 063/105] test/tcg/mips: user tests
Date: Fri,  4 Sep 2026 13:45:17 +0100
Message-ID: <20260904124604.2207440-64-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-64-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index dc83b7447bf..3d7438245dc 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -145,6 +145,7 @@ subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
 subdir('m68k')
+subdir('mips')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
deleted file mode 100644
index 5d17c1706e4..00000000000
--- a/tests/tcg/mips/Makefile.target
+++ /dev/null
@@ -1,19 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# MIPS - included from tests/tcg/Makefile.target
-#
-
-MIPS_SRC=$(SRC_PATH)/tests/tcg/mips
-
-# Set search path for all sources
-VPATH 		+= $(MIPS_SRC)
-
-# hello-mips is 32 bit only
-ifeq ($(findstring 64,$(TARGET_NAME)),)
-MIPS_TESTS=hello-mips
-
-TESTS += $(MIPS_TESTS)
-
-hello-mips: CFLAGS+=-mno-abicalls -fno-PIC -fno-stack-protector -mabi=32
-hello-mips: LDFLAGS+=-nostdlib
-endif
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
new file mode 100644
index 00000000000..3c4f6ec482d
--- /dev/null
+++ b/tests/tcg/mips/meson.build
@@ -0,0 +1,25 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'hello-mips.c': {
+    'cflags': ['-mno-abicalls', '-fno-PIC', '-fno-stack-protector', '-mabi=32',
+               '-nostdlib']
+  }
+}
+
+if 'qemu-mips' in emulators
+  tcg_tests += {
+    'mips-linux-user': {
+      'cc': 'mips-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mips',
+      'gdb_arch': 'mips',
+      'qemu': emulators['qemu-mips'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


