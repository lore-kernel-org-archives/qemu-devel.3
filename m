Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1392AC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQL-0001hq-U6; Fri, 04 Sep 2026 08:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQK-0001gH-2a
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:40 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQF-0000hh-SU
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4956869750eso7348665e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526414; x=1789131214; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dj+v3TQbzbt+rs3ih5A9gakkfKJdFS6VE4e9q11YFRs=;
 b=FzZYBr81CZWbjGYI5pAfj5/fL55iJVEvkrHfqolvaRVjeRo85SNlle92CBQR68ghtw
 Yl72AwQ3CHxelaEg2ZNnNiujMcIO1h0YbZxmlMSQKgj+/WiA5D4i/dO6on7PT7rrXbtj
 +cxzO3I73dTegohthFOqeKqjP4R13QddrHgF5s2rb/BJ89TnC8fxkTGYGC/fSFtsdpA4
 S4GqdicIt9MALMMKBnisbHfP08tR8OJO3mawKltKgijaVUpW/1Hx8ksfoCkBJ2lC63Jf
 iiLFXT5g+z7TaNqP2fi/txo4PwDvVEy4QPsrtqVBzmzLSb2+eGoDiQ99DbtxSwrrrAfp
 Pnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526414; x=1789131214;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dj+v3TQbzbt+rs3ih5A9gakkfKJdFS6VE4e9q11YFRs=;
 b=dhrLobypBXMYYcG1sZ++XUtZ2r9gnktusZVvUotBklHmo1pPRWsE//rYI+eWT1eqJu
 F9wYnyZHNkyZngSTUhAcheRL/41sn942U32JPABQTKcUqYEpXJpd17PEzK+yAZH3Mn0i
 GAv2pEl/hZJnDsiHQLtqUKX5LkwdSNVPA4i+U1p8E57EG6zPfBlnt6oG2xpX3a5LI2ZK
 zy+rvwdyC17U2G0EItQdxnODeRlmPDZdFSw1NtTk4+YuAdonsjgTroos+RJe82+ErSb5
 NJ1XCSav6xfZqxyB7QRHURvZMFYXKB4kHhD2sxZ3rD0zDTtD37tDCNNIfq2rKKnS+KR6
 xbvw==
X-Gm-Message-State: AFuF++nbcj7xLztR5mUnh0vRXxp37indTbrayVAWoGBqtR0k56xDf8vh
 iCKRv89lKDPYJXTLqoNleDbKiuNUVFQOWHtNYMItsyQkj3/R5xTZi+Ck4xkOSTO+Epw=
X-Gm-Gg: AYBFou26twSA/4JWjqrNcLvGUj5DSAGkFJYpocRNMtWC4Y2o5tgXIkcgZBlbr4gmf2M
 ZB6nT5YapHyESnYzkeMftM70ua0ZzoKRqQB8q2+Z36n8Y1a+rWlqWeG799ummeAcEhujqVFrlwp
 vIeBIvszn9HwP8H2f5UoXu6kCRj4u4xYqQxvZZYZO1dyCEdCoU73WfN8QYdYFekdjh/ZcvfLnFg
 iFbndpsQVz3sjiPzqeJxtI91KkNo2g2kzVXRPM2Pu6FDH4Jwl5462LQ8ae8MZX22DmoC17N5LC3
 RMwjoIWB0qv15isCG4ELBp1kx0VrICTC6LVQ6ajlDzZCH7bbDr29i0ISIp1zeV7ePpdzxned8WL
 DtV21dm2pZYoBinZDhxkUMiWWN6qJCKOonvLBtbPeBoYuRNEaWJ+iORWDXs/lYz266MnxhRzYll
 xaw/8ORCVzaG4DHKskNBjUVuPggjbgQ57O5AgR7bG2Mh83k/hIPP+5Bi+wfouk
X-Received: by 2002:a05:600c:37c8:b0:49c:cee2:a508 with SMTP id
 5b1f17b1804b1-49cf826c4e2mr54526995e9.16.1788526414104; 
 Fri, 04 Sep 2026 05:53:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7739b7asm64649625e9.13.2026.09.04.05.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9627C601D6;
 Fri, 04 Sep 2026 13:46:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 060/105] tests/tcg/m68k: user tests
Date: Fri,  4 Sep 2026 13:45:14 +0100
Message-ID: <20260904124604.2207440-61-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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
Message-ID: <20260827221506.91574-61-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/m68k/Makefile.target b/tests/tcg/m68k/Makefile.target
deleted file mode 100644
index 33f7b1b1275..00000000000
--- a/tests/tcg/m68k/Makefile.target
+++ /dev/null
@@ -1,7 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# m68k specific tweaks - specifically masking out broken tests
-#
-
-VPATH += $(SRC_PATH)/tests/tcg/m68k
-TESTS += trap denormal
diff --git a/tests/tcg/m68k/meson.build b/tests/tcg/m68k/meson.build
new file mode 100644
index 00000000000..8ecf450ac68
--- /dev/null
+++ b/tests/tcg/m68k/meson.build
@@ -0,0 +1,23 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'denormal.c': {},
+  'trap.c': {},
+}
+
+if 'qemu-m68k' in emulators
+  tcg_tests += {
+    'm68k-linux-user': {
+      'cc': 'm68k-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'm68k',
+      'gdb_arch': 'm68k',
+      'qemu': emulators['qemu-m68k'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 70aaa86afbf..dc83b7447bf 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -144,6 +144,7 @@ subdir('hexagon')
 subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
+subdir('m68k')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


