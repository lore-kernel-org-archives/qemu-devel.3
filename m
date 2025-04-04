Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B8FC3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 01:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0VZ2-0008KK-DA; Thu, 03 Apr 2025 21:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0VYw-0008IE-Fo
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 21:09:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0VYu-00081H-Gv
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 21:09:37 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2241053582dso21836595ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 18:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743728975; x=1744333775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4BGzGdi+Q8YtuavjJZkyQGsY98kSfnKOoGLNVstGZOM=;
 b=kTwQ7i7cFyKSF+biVITBYYh/kmhnv25NkMwrQ3VAR3OEffXHTNHklDYVefGjGTkWzF
 eXkdgJZom5MDvhcxFbKSAUrly9YR8kpNwfDJQ66qq+sUmR5wLo2N9wfa+XzBGIVqO4Cp
 ep40RuAELOxsSVofP96/X67FoCRi8Y8XWF6r+uDor43QRa52Iw2W60mGYIJeTQJTOE+5
 kWlNSdGG01vUyloVZufrSQkzO19Hzs/VWm+PudmmAxkQhRiJLF6/v5/FGcyhZbrqjtko
 tQMReF1I2FyxDTyHpwfKu5HheFzAWmG44ycBfVrL/n3LQBlOrF31SfQORzCJqpUFQzEM
 XF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743728975; x=1744333775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4BGzGdi+Q8YtuavjJZkyQGsY98kSfnKOoGLNVstGZOM=;
 b=Qf+yl6rgL3Rbebe++xwsTFEse74QdgLQCIEFB9B3av1HR1dTdRRv7A45Gtin6Cvurn
 7zBYOkvGkbWiphCBNI//6y/iscHndh0w6qvzB+3t5g8r5737b4ctg4nXlh50gxWKJCI+
 2r2V3IT+j9Kd3DSf/7xUSGpqUE3DFPEzf71Q00utUaV2+8nEow9t6mzy3IbZUmNKNkCf
 4uoZfBOPfpLmx8kn0X7a61kf4kKgvFrcNNwh9reLnw4bgBGCQ2qhRBtAn6kOa3cAEPfD
 1NzieG5ecWU2WTY4lvu2mZq6wxtTKW+eA7cCsvHa5vyfBV0r9j1UOHFG0w/FZGCDOhX1
 O5eg==
X-Gm-Message-State: AOJu0Yy7Z60WHDEKrf3DIAuc0JILgQ4KJFifJUk2QU4R9QNXw6gsYl1K
 5PvgSTSH27OXI3FD/6gz7nn+8oVI18gDrolMaQF8Xp+6eQYjMezVdq/C9dQuWrySLOlxxLw2CaR
 b
X-Gm-Gg: ASbGncuoX+7fJlEuAlzi7i3cdCnz6K8i8yBzHJzbVvEVNZNcxHxeidHwX1kMx4MUgGZ
 S0dBB3zS8xjIeLAB3raOpRw2PVkLjmfdFC3ijbj+8tyG16YZ0iZ1FFPw44jaCy2V6q86cWbtQm1
 Ktq1f4tM3BGJEvsLOwAlh/gX3l4KcO02ZPzJT15PJ3GAXcrYvNJ/4oslcQFAWqEVNugYVeR1E/V
 787zTHfJn1sct9VFcRBmHaRIeGfl/KCFAhGlvfF5Bpgs+65FGfIei5kpXjn+M0RyIECKRhmYme3
 kkYzVvK8l010/Z8DQJM6W9pYzb7iev/P9ZvHlhfPud+pCy+vW+0=
X-Google-Smtp-Source: AGHT+IFEqtx5o5uJbeL/MXmz9PKZfHAypGgjv7+ZdMC3F5Bp+IE6GHChrtpugYVhD59SpobEQslwFw==
X-Received: by 2002:a17:902:ef0a:b0:229:1717:8812 with SMTP id
 d9443c01a7336-22a89eac8d3mr18321405ad.0.1743728974962; 
 Thu, 03 Apr 2025 18:09:34 -0700 (PDT)
Received: from stoup.. ([75.147.178.105]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee2d9sm2171755b3a.39.2025.04.03.18.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 18:09:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 3/6] tests/functional: Add a decorator for skipping tests on
 particular OS
Date: Thu,  3 Apr 2025 18:09:27 -0700
Message-ID: <20250404010930.164329-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404010930.164329-1-richard.henderson@linaro.org>
References: <20250404010930.164329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since tests might be failing on some operating systems,
introduce the skipIfOperatingSystem() decorator.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250403203241.46692-3-philmd@linaro.org>
---
 tests/functional/qemu_test/__init__.py   |  2 +-
 tests/functional/qemu_test/decorators.py | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 45f7befa37..af41c2c6a2 100644
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
index 1651eb739a..50d29de533 100644
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
2.43.0


