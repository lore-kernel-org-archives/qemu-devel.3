Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2950EC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RFE-0003zL-RC; Thu, 03 Apr 2025 16:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RFC-0003z1-9H
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:32:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RF9-00043E-7Z
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:32:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so963043f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743712373; x=1744317173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6+6tP0FDiD90XBJa6S5dJ//D1whWgsc0bfGPime3dk=;
 b=WdJsw10kcAtx2pl0+Kv6rdoaSX+pyOt6a/bLlprdrdDP10qy0IfxRYFa8Cz+dPOA2k
 29GBzSxqd3ni9Fq7pNR5UC2dTWy5sCjMO45ikAtJlVwmvEJNgXfcFfWxFcCj8DK+euH5
 qFVbfw/fUP16MGcDiF2Wbo5dHZH+26DSx2nJzG7OR654sqoEGrFaaX2yOrs5L2fiLKDe
 LSPeVBftYa7lQU6sU1KurhRA4UPCfS4TUGLGHa3tng2LN2O6b2g4FR4V/7DZwoRQEYo2
 T9ooDlKQlL0iAf114hIoQMSWyh+79z8+dYv0TKLIMPG8pLN8i2vQihE82L00TimkYS/J
 R2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712373; x=1744317173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A6+6tP0FDiD90XBJa6S5dJ//D1whWgsc0bfGPime3dk=;
 b=XeR3E76sXlot+MnA047sBuympN0PPyEB6MZy5ksS1qtarj6Xg1VnmcuZSePE0bYIoB
 sgdOPOX/KqXZzaQG6JPtp+8LXcg5iZOGop5HqVtCOyOi8Xyoaa0WDG9t1GogBU+MO89G
 drN3fMIvU+hw0b3YkIVuqAq3JfJTFqVRjbPhnH3A/K+RF7u2skakKRw+BvYEq4agmgfC
 TRHF73hwZxfJ+m+T6S+OACcI3nxbCXz8ZJt8ZGc5hO07dRV8zkn0UuPKehx3jrBhDLtJ
 tHtQFQOKRLQd5IVC1hJi3K6PL1CaU/wpjMvnBuxzo+NPv8KjGWIieHvm+WUMLXHSRgfw
 dGmw==
X-Gm-Message-State: AOJu0YyudKRFOEq1pkn/UekMfD8Hgo1Qu16TYX38uoS66TFmHys97ZHj
 dKD//9KFEE832MQbQNP3egtSFDxPR7DtJ/s/LRzBJLUCFDlq5SxeH/J5x5PbLzhreMlsxLmWc0x
 Y
X-Gm-Gg: ASbGnctLO8P1DpOZXX6xhXv3/+TmMI0a0ZhNSbNHtcTqw+VfRW+BU5B1DPSjV9avTEH
 7bMUp19JAyEJ1vhv9rmIpCG5MIRZUfe04b+fHyWuv8+6YYItIGhVyrpLZn+yUwMLHKefZk7y3jl
 wp7VtLkEjLYcC0KfYPs+xj31QU5ztS6LXyKYDgKHSeFqtbIf1DCjvpy3jNk4KJFWDK2xDWRSqc7
 N7DBsNvV2rMhfB0VkGYlrJX3jD7TgylpnNCVzyvYxIaQHYCNWSyFTjxDB+qiucggcvftwS8rWuu
 2AYqJoVN0S1yHaUoML7cvp6W0xOyT3zlqXlj3BBP1Ij2okSTwh3O3HscEavQNNduQJ9RrxKsZzs
 Yk0RGtaiagtB1Kn5WDJMG2FftFHObitS3+ls=
X-Google-Smtp-Source: AGHT+IGWDmr/Jg9vuJcsGn9SC40GCpkw35f6RHeYWix9nSxFU5dnPplOgOjeQ9Yv3qFw5Nsnm5msbA==
X-Received: by 2002:a5d:5d13:0:b0:39c:1f0b:8f6f with SMTP id
 ffacd0b85a97d-39cb35a1821mr554968f8f.24.1743712373310; 
 Thu, 03 Apr 2025 13:32:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226f1fsm2703680f8f.95.2025.04.03.13.32.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 13:32:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.0 v3 2/5] tests/functional: Add a decorator for
 skipping tests on particular OS
Date: Thu,  3 Apr 2025 22:32:38 +0200
Message-ID: <20250403203241.46692-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403203241.46692-1-philmd@linaro.org>
References: <20250403203241.46692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Since tests might be failing on some operating systems,
introduce the skipIfOperatingSystem() decorator.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/qemu_test/__init__.py   |  2 +-
 tests/functional/qemu_test/decorators.py | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 45f7befa374..af41c2c6a22 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -15,6 +15,6 @@
 from .linuxkernel import LinuxKernelTest
 from .decorators import skipIfMissingCommands, skipIfNotMachine, \
     skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipSlowTest, \
-    skipIfMissingImports
+    skipIfMissingImports, skipIfOperatingSystem
 from .archive import archive_extract
 from .uncompress import uncompress
diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index 1651eb739a7..50d29de533d 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -5,7 +5,7 @@
 import importlib
 import os
 import platform
-from unittest import skipUnless
+from unittest import skipIf, skipUnless
 
 from .cmd import which
 
@@ -26,6 +26,19 @@ def skipIfMissingCommands(*args):
     return skipUnless(has_cmds, 'required command(s) "%s" not installed' %
                                 ", ".join(args))
 
+'''
+Decorator to skip execution of a test if the current
+host operating system does match one of the prohibited
+ones.
+Example
+
+  @skipIfOperatingSystem("Linux", "Darwin")
+'''
+def skipIfOperatingSystem(*args):
+    return skipIf(platform.system() in args,
+                  'running on an OS (%s) that is not able to run this test' %
+                  ", ".join(args))
+
 '''
 Decorator to skip execution of a test if the current
 host machine does not match one of the permitted
-- 
2.47.1


