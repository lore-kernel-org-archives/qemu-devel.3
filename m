Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4029DD41C24
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 18:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTkzD-0000mi-1F; Thu, 11 Dec 2025 13:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkz4-0000fe-O0
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:46 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkyy-00060O-So
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:45 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso1961695e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 10:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765476097; x=1766080897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjNIuzyK5V5xqm/v+ERCVfRQjHJqruku7oF2X8AM9z0=;
 b=cI8r9hMkgsEriZ9SapfslnbZ4CovY10YpgexImvpTbhClTlZkkoebOVRCgyRsf9PDY
 32Z23iShDkpxB2IYVdZItA7eUt5J+UPT9vtpJAMJ3CudRp0kyTzyPoBpW11oGu6m11jc
 Me6CwS24BH0P9jGhcLXA8I0nduKcUXRAfqKD80WEm2K9sF5F9IjYrvqlr/WdxzTAwsY2
 2044QFGn6Gl2t8xy3t3JsFxSyw0/ISVVxjBLCbTyRYb0cBeVii3PQv6w7ncEfOM4b/ed
 XuKWOizF9XgC+7UyxpJjU9bPtRxDwHbpROFvT/OAQvyTZgzdnOY1S04qnwJBVLHa5hB1
 0uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765476097; x=1766080897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xjNIuzyK5V5xqm/v+ERCVfRQjHJqruku7oF2X8AM9z0=;
 b=FwMJEsZwnoV9bHoJt91Axc/E1Nbn4hqEJgcEqgNsqFxkaw6UBP8bM10FyQCk8ybs9g
 wW3qI77/5f1ibz5pYN4ZaaFRtWiaKBVUILBc2ibWXEq87LzRvqjAoQKphD8XSI9aJBEm
 CqSt6JDFmY6MxDQ6KdM1mDOXT6vK71deWhCRqje2EnszB02YoFmeKUsbdcm070l8jlrx
 fgSLgT6usgV1Fp0X96HCn9k5sqZfSpfvbSVdalN7q9FUxQ9qj5TEy+AjhIePemo/WKZI
 uawUO1rnTExbwqydkKzXfGPRjJgWggx0eB3zIvxMAaovp5/TvRJJ4OiY9QnKvr3at/Y9
 lZjw==
X-Gm-Message-State: AOJu0YwNOiIJW+rSUKG7pWpYoGJggMEPJI4jOXLVdUk5xUTmYNWBRgFh
 kblZwtpJ58OkweKyVWIYQ+FRs10SvD6QxRvJtVelvZSZHJ60iMmQ8mfK1nUlGGO5rKI=
X-Gm-Gg: AY/fxX6JNr25V23LL0LJGQHWdXzHew7D3wj3qHqpSXGhee/5lDnnf0ZW/nyWl9POg1t
 ECKKApha62r+mypaypYIEuNR3Wa9v9NISNR6LEnri7o//4X+mZesMOwz/rbmTRUlgRXNWUgEB9q
 Vvo5Jj8mogH0LPsI2Ndy7sLyffCwY8WWsm1s3tFNfnFXIC55mdVeRZW0Y3Rsbws3D5girGytRhp
 nu4nML3DUHPMr28t0YAqvYxBum2KKz7dILoCnmWF0aIlhBph9qxL0IlN4UVLptuFs5QgfmcaWav
 n+RqYDeT2XvlwOuvm0MJzPAZL5+SI4DyHDZyA7p1Xteyr65sSeWRvV4KLYomQzUCKJ6mMECTOiv
 fxPwzzI34RcL40YMH6K4mpsWGru+HCzFCvFb0CZyCZsIL0It5EzUMu40deVv1dxe8N9UQTaVGkX
 JXRiSll2LZog8=
X-Google-Smtp-Source: AGHT+IESRZ5jXW92nTehu9/xS2VHvAEWK1m0YkhocFOsedoaRwXD6l3OFo+uOzvhegVs/QOzMmr5KA==
X-Received: by 2002:adf:e2d1:0:b0:429:eb05:1c69 with SMTP id
 ffacd0b85a97d-42fab23d7a2mr3364175f8f.2.1765476097163; 
 Thu, 11 Dec 2025 10:01:37 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b85d1esm6915549f8f.26.2025.12.11.10.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 10:01:36 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0DF0A5F8BC;
 Thu, 11 Dec 2025 18:01:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 5/9] scripts/get_maintainer.py: resolve the source path
Date: Thu, 11 Dec 2025 18:01:28 +0000
Message-ID: <20251211180132.3186564-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211180132.3186564-1-alex.bennee@linaro.org>
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

We will need this to automagically find MAINTAINERS. Use the same
logic as the perl script by looking for expected files and
directories.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 77 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index 2b8fc7ae9ee..c713f290cc7 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -15,6 +15,59 @@
 from pathlib import Path
 
 
+#
+# Helper functions for dealing with the source path
+#
+
+def is_qemu_src_root(directory):
+    """
+    Checks if the given path appears to be the root of a QEMU source tree,
+    based on the presence of key files and directories.
+    """
+    if not path.isdir(directory):
+        return False
+
+    required_files = ['COPYING', 'MAINTAINERS', 'Makefile', 'VERSION']
+    required_dirs = ['docs', 'linux-user', 'system']
+
+    for f in required_files:
+        if not path.isfile(path.join(directory, f)):
+            return False
+    for d in required_dirs:
+        if not path.isdir(path.join(directory, d)):
+            return False
+    return True
+
+
+def find_src_root():
+    """
+    Walks up the directory tree from the script's location
+    to find the QEMU source root.
+    Returns the absolute path of the root directory if found, or None.
+    """
+    script_dir = path.dirname(path.abspath(__file__))
+    current_dir = script_dir
+
+    while True:
+        if is_qemu_src_root(current_dir):
+            return current_dir
+
+        # Move up to the parent directory
+        parent_dir = path.dirname(current_dir)
+
+        # If we reached the filesystem root and haven't found it, stop
+        if parent_dir == current_dir:
+            break
+
+        current_dir = parent_dir
+
+    return None
+
+#
+# Argument validation
+#
+
+
 def valid_file_path(arg):
     """
     Checks if arg exists and is a regular file or raises ArgumentTypeError.
@@ -26,7 +79,21 @@ def valid_file_path(arg):
     return Path(path.abspath(arg))
 
 
+def valid_src_root(arg):
+    """
+    Checks if arg is a valid QEMU source root or raise ArgumentTypeError.
+    """
+    abs_path = path.abspath(arg)
+    if not is_qemu_src_root(abs_path):
+        raise ArgumentTypeError(f"Path '{arg}' is not a valid QEMU source tree")
+    return abs_path
+
+
 def main():
+    """
+    Main entry point for the script.
+    """
+
     parser = ArgumentParser(description='Extract maintainer information. ')
 
     # We can either specify patches or an individual file
@@ -36,6 +103,16 @@ def main():
     group.add_argument('-f', '--file', type=valid_file_path,
                        help='path to source file')
 
+    # We need to know or be told where the root of the source tree is
+    src = find_src_root()
+
+    if src is None:
+        parser.add_argument('--src', type=valid_src_root, required=True,
+                            help='Root of QEMU source tree')
+    else:
+        parser.add_argument('--src', type=valid_src_root, default=src,
+                            help=f'Root of QEMU source tree (default: {src})')
+
     args = parser.parse_args()
 
 
-- 
2.47.3


