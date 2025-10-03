Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5BACCD184
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 14:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4gcx-0004OG-Ln; Fri, 03 Oct 2025 10:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gcu-0004NS-DS
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:19:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gcY-0000O8-8m
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:19:16 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-27c369f8986so22529115ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759501126; x=1760105926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6mQZxd/i8+rIw1saqr0gYaKPMxA97cW8VZlbdqTAW8=;
 b=iCNj/uLHWAyxnVYqgKQxErXlrEIGAXKMcC6fSHbopEAOpotz9dItWLJ0LK4x0KeG79
 c7hTLwagROadb8xkNQRDH2dRwvMb7Zk4S5QBdbLcwCXzwcZYy8mp1rlXDupX5jlGw/Uy
 txkr/VDfN8ZJv/IcR4wxEOXYugoIzSlp6FeL8jsAYYMfgwV1+OQv9usfXrm3Tc4GTK9Y
 spjtASaItT0GjWeXujhjGLWnuGYOgZiB3yO69P7Qq4BUEfK5+zWuQfTlk3G+UrZme+3+
 vyldEPZpUNgE+dy9K5MACaHEtv8WrBGSYjb4wf0fa2b4P9FVXBIGWEWdSAJn3MdkolPd
 5n5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759501126; x=1760105926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6mQZxd/i8+rIw1saqr0gYaKPMxA97cW8VZlbdqTAW8=;
 b=Q4yWGx68JadRWKuLx2owgJqCZ/+axegk743XmcE8ilNxRWohZrYDVYs+Fd3rTPqsKr
 L91NmjX2nrjQtskWV4P9dtg+N19wQRBSDNy/kMKtOi16lhUAVjBwmFlwVScKPVUZTsnI
 sXOUQ+0fYksMwpjkwd3hIXNLSmZN8nIgY0LRX8+eU44PnLn68IN3O5hOUMcNZIKn+7z6
 2upMmtUWq1Fxo0clxaMJheCoBIokfhAj95L99za6LYRQOY2IGb09iGKKkqh1qSoDrVKu
 nQujAQKvQbW1TTW+acOEXdYYfR71K8iCBqEE9bIwfGzJnPnA0mo0T4wijVOcpoKM1CtY
 tQlg==
X-Gm-Message-State: AOJu0YyYD264SjEsUkWy4BlgwUEMAvz8evFKI0ByPTMtbFkptbREiFo7
 Z1cpyqFMkiNnT+iwp6J/5W1mbI+Xl+U/wqXX0Uele4JDRogOiR70spyfOrYBADdd4M04HjI8OTY
 gV7+B
X-Gm-Gg: ASbGncsii1gUJXacLEhTbKgPJawefG+InbruTSjPQFJ+yXis67dIoUrDfIMlnLhlZr0
 1PoK1r48YuiT1Bo/UQYt/DkziZXcIHjqbK0D4b5PrdkDaqR70qWDnl/2gbW7+w/TFtgUXM0idII
 YM30aD+8scajmxLy4DVkBnQGdd5eaUgLI8og65hCpgVrCcFexUuJ7yQxG9nuxCQItC21OIID3mo
 o7Y74rXxGH2NP3/UEacBckSEmvF5s3L5XYrmAMLE9QlKE4etpt2o+EDSF9XOEDJ8Gb54jccOvzB
 OmIQt5Fmk6dj3TMCSoAc4YrnK0JFktPpPJBaFUKwssDwU5Zwd3JrqgBNsxBXbhlSUXwEA72fVys
 el/HdOAp1jgwnWm9mOWXJCRNOBHA53fgjrdS/DjRDTxoBsQ1Ps9FgoJMD6Tp6G2erRZI=
X-Google-Smtp-Source: AGHT+IFbiBTGvgbnzG9EmDWSimUw+CJepchtLQ5XyAxQEUwl8SBklLcmUqysRNS8oNZwghz6JT59fQ==
X-Received: by 2002:a17:902:ce8d:b0:267:44e6:11d3 with SMTP id
 d9443c01a7336-28e9a5b1934mr53528035ad.21.1759501126352; 
 Fri, 03 Oct 2025 07:18:46 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d5635sm51759645ad.102.2025.10.03.07.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 07:18:45 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 7/9] tests/functional: Add decorator to skip test on
 missing env vars
Date: Fri,  3 Oct 2025 14:18:18 +0000
Message-Id: <20251003141820.85278-8-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003141820.85278-1-gustavo.romero@linaro.org>
References: <20251003141820.85278-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x635.google.com
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

Add a decorator to skip tests on missing env variable(s). Multiple
variable names can be provided and if one or more of them are not set in
the test environment the test is skipped and the missing vars are
printed out.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/functional/qemu_test/__init__.py   |  3 ++-
 tests/functional/qemu_test/decorators.py | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 60d19891bf..320193591b 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -15,7 +15,8 @@
 from .linuxkernel import LinuxKernelTest
 from .decorators import skipIfMissingCommands, skipIfNotMachine, \
     skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipSlowTest, \
-    skipIfMissingImports, skipIfOperatingSystem, skipLockedMemoryTest
+    skipIfMissingImports, skipIfOperatingSystem, skipLockedMemoryTest, \
+    skipIfMissingEnv
 from .archive import archive_extract
 from .uncompress import uncompress
 from .gdb import GDB
diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index c0d1567b14..b239295804 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -11,6 +11,24 @@
 from .cmd import which
 
 '''
+Decorator to skip execution of a test if the provided
+environment variables are not set.
+Example:
+
+  @skipIfMissingEnv("QEMU_ENV_VAR0", "QEMU_ENV_VAR1")
+'''
+def skipIfMissingEnv(*vars_):
+    missing_vars = []
+    for var in vars_:
+        if os.getenv(var) == None:
+            missing_vars.append(var)
+
+    has_vars = True if len(missing_vars) == 0 else False
+
+    return skipUnless(has_vars, f"Missing env var(s): {', '.join(missing_vars)}")
+
+'''
+
 Decorator to skip execution of a test if the list
 of command binaries is not available in $PATH.
 Example:
-- 
2.34.1


