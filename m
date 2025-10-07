Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279BCCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66Io-0002lj-SX; Tue, 07 Oct 2025 07:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IR-0002Y6-R8
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:56:01 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IA-0001Jl-TV
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:59 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3f44000626bso3947516f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838138; x=1760442938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGaPJkIFeZLnWSkOQejb/Iaxr3wPsM/s4EknLxAt77s=;
 b=QneQKRfFVOrGv6pL5wJEvxYiWzdudU71R3EIdB6aL/iIkxbFfIDy4OiB6b6AJXSyQz
 Mp0RufJXhLOB3SgFYYCaYJisgBDL4b1PmYhWq/xMAfaUgSvkOKJVxTdJe+AFbYztA/4A
 wxP2tVGRYb+Q8QcXK3kN4aomHpADouniGYspAXp3f9w4ZHFH6SgfMugXxGCDdK2ff2x0
 nakMj4ZY8Mm9bIOihJPLGibWpgcqmqV9zV5MVXdfi5eWyvXAkAMkml/U4n/G3/xrTY28
 ycDqVdlbknV61zUq4fnaCuSKIvQ4K1w3QAygBtGv/KJ5tB5iCRRzc0mMyUPTmZ6pNntp
 BKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838138; x=1760442938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGaPJkIFeZLnWSkOQejb/Iaxr3wPsM/s4EknLxAt77s=;
 b=dUOqFC0tplqx+eD9Q2RwZyrcXHAl06av1HFNs15dCEKTbzHccxN/iaa7c1D8Kq+h2p
 GzisCtNhEn50UFCIyYLu5D9vhIQ0E4AqInLWo2xT9u+QmFG9XR0pklJ6AeF78xA/XE+6
 0K7/B4D4sNWKtoxU82RdPJE5eidAy3PJNi70cE9k2zho2uF0oXA+r3xSsaDR0YoAQC/1
 yoDGs2hvbsXQZ90jLESAgRAHJ65BtXX/YcVTgRYoaCRO0febcUcP+uOLL/uyZ37S7Lrj
 fkpfVgxWtHa0/vfbJRBPQ52g60KGLYQIx204oBmujly7m3VrRXY9jnYmRL4tuXEDJ8nj
 hmCQ==
X-Gm-Message-State: AOJu0YyrtuNEdKDtHkaQrEMYWCZi2aOMz3+O9a6/zDPmhA8Qfj3J0GmD
 asvTdg4a6LVoFbrEtla3JNtt4cE1b1A8v7MhM5dtNmDPm9eLU+wtgjovokxhNXsaedE=
X-Gm-Gg: ASbGncsua5EBsHYKcOtkfdHlc3fu5GNuCbWDwvyUcgW7fAA2DMArPKqAHEj99Skn4cD
 XTla4vaH1uzh53iYrY2B33dzY1knC/2gvKG1wMEqAeK4GhFDmRmyU/853ELcrVRjcMX9CYbfa4K
 Slsf6d+b5WMtS0Lc6m9KHmvZfw5mr/w5k+4CdOl/++yM3aznfJ0zeugcVHl7iLg3mDjEFwr2JjK
 PASSvHn7AI+76ouMSywu0pxyeEHpQfRB4j6vhjQ2Aj01pxWnr0evosPjVdqXINm0MDDy/Bw3SQq
 AJIo7if6wQp1BcSzyiDCJOnAb0uskwRpAmGclr6NuACXklF6zH9Q79kH9PkBDoRNMG2InCLbfhH
 EFAKH8+okGLp2XyLNwqhLRvYmjB6Sdd8O2MNYqGuaVRKTeLd0MLE=
X-Google-Smtp-Source: AGHT+IEkObAT//X6nBlZp7xGT8xcLiWO9VcWZvRajjoblOD7/ci1k++KmwOSROHKlWL5Ql/VT7QgOQ==
X-Received: by 2002:a05:6000:4022:b0:3f0:4365:1d36 with SMTP id
 ffacd0b85a97d-4256714c4c1mr9403530f8f.16.1759838138355; 
 Tue, 07 Oct 2025 04:55:38 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f45e9sm25625638f8f.51.2025.10.07.04.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 318936053D;
 Tue, 07 Oct 2025 12:55:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/17] tests/functional: Add decorator to skip test on missing
 env vars
Date: Tue,  7 Oct 2025 12:55:22 +0100
Message-ID: <20251007115525.1998643-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add a decorator to skip tests on missing env variable(s). Multiple
variable names can be provided and if one or more of them are not set in
the test environment the test is skipped and the missing vars are
printed out.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20251003141820.85278-8-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 60d19891bfc..320193591b2 100644
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
index c0d1567b142..b2392958041 100644
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
2.47.3


