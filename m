Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43B9CAC5BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v20p8-0004sD-7Z; Fri, 26 Sep 2025 01:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v20p1-0004oB-56
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:16:45 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v20op-00061Q-Pw
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:16:42 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-27eed7bdfeeso6914925ad.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 22:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758863786; x=1759468586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqvAjhF9PeBnkzh7otQwLKhrmJazNmoc6H8q1BcmrGw=;
 b=epBtE1i+Lp+TTTgh2haWFmw146XpCUImdLq742wFplHj68xW/CLyDYVOADAafmTO/9
 uriE+oMmYZwcqNdTdRrW1+bbwgkW2JWm6YTKyNxVBvhGCnrC/A75N2jTS4mYgWXBdj3o
 OvSKY5iPITrVF/RYWVQAAte00mPMV4OMlAsZFTt3+WQtor6PDW//e3v0gTm9ud2Eo5JX
 ItjdeJbmTM4v0Glp2K3d0pAENQOkHhGAdeFLqEXXtLxCG/7ujfrwr+T0BALuU+NzHkY1
 BBvLO/k1fhFUGr9SNosRQKBaVqtMCEW2Eb5KsYk0aWkNXtuuSj7eqH3hVy6y+duDMRxt
 ohqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758863786; x=1759468586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqvAjhF9PeBnkzh7otQwLKhrmJazNmoc6H8q1BcmrGw=;
 b=ayZk/ptZ0+C2FIZHZW9+MD9fMmL4I9vvRuCE3clOrqkWPzuWzdFEGgzWi5mFKCC6yC
 ECt3j/xYsgKsI0c8LJMEh5DAwPgnFB+9R0Q/0NRjn2XeXRhDn8gw3zjStDWoRDYZTzaA
 jQtpKWXGykq6CcWb0/EQXG2esRRkWGfbhUsoyv1iOLNcUCzAuN8TWuXCH9fc1qoCdBKp
 4Qg8WeCCF0Q21EQ5qBdm6wFVRtqHVlGdq2ag7Qk2rH9fQvlKI6LmJ2rODfd2bvPtenf3
 tcm7+qLygxpblSfTCEQ/LDJNnHeb2/hND3td4PYxgc27BLcrA+n2VShx+dzMjor6GX6h
 GueQ==
X-Gm-Message-State: AOJu0Yyn17q60U69o0QGZOCTZvo/Z9e5+OwbwlKGO/HmKhuhk3+qXGTE
 Y+aplncA2JrVb6Dkc7NXy5p0oGjiRttGGB9JGuG8akaPODsXVzwbUT1mdXARo2KUveURp1Q2Omn
 GGGgy
X-Gm-Gg: ASbGncv9xVEtAovM6skOZ7RjbfrBii+fUTC1ntNxaUGOECaN/LqWdg1kE03OiR/RiqE
 Ooo3gLnbRInl6ARYZcv30ZfALfN3LHZQgH16hQIiF/Z++Og7Lsljik/Fa5UNySUwB4aRO6DYwPT
 6Cyp8E9L9AWqR4dhgjFqquj5B7LZg5bYx2t5rjBmQe+IWzrQZTJioEGGtJOhkc1+uT00dToXIQ4
 ZncRw0oPHYw11Ao2SLxVTH+qOcAxjpavm5jKErgMhvRt9MKs1lM7Dg53YbcZx+BX8qZwjygwQJO
 CRiSpTiQ4J32ybXe/NKXMVnG2JcuxXk/QRRpbI5rlmXD7xj7N3liOcqGoY0zfCmAd05YKTNse0L
 Gn8MkqElf027/f8PzKAMB9KnE8xiZLteZjLbvjLLItoAooHAJR56jhSPGMkp0ZwOtLAz1
X-Google-Smtp-Source: AGHT+IHYIWi5gcV0fp9+TeSsY77WtkC+hvKT/qc8RXgBb+kfZWgiPvxz6FshJdgCPkH6cON97RS6HA==
X-Received: by 2002:a17:902:e745:b0:272:d27d:48de with SMTP id
 d9443c01a7336-27ed6e05744mr64600655ad.18.1758863785704; 
 Thu, 25 Sep 2025 22:16:25 -0700 (PDT)
Received: from gromero0.. (189-47-45-49.dsl.telesp.net.br. [189.47.45.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed672a51fsm42160085ad.63.2025.09.25.22.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 22:16:25 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org,
 manos.pitsidianakis@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v4 7/9] tests/functional: Add decorator to skip test on
 missing env vars
Date: Fri, 26 Sep 2025 05:15:40 +0000
Message-Id: <20250926051542.104432-8-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926051542.104432-1-gustavo.romero@linaro.org>
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
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


