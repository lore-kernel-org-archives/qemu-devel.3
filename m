Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8793C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI17-0001C7-Be; Wed, 26 Feb 2025 09:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0z-000114-8G
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:57 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0w-0005hC-3g
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:56 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-439946a49e1so44146835e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578632; x=1741183432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OLAEfb1TFH74FrITh5hY7sd4JTAq5WSAJV1LNPh/Qg=;
 b=mXRhvDKMmie0mgnG8hhjmuU9NiYBKMcnNxiWUyqRLd4C1RvmSpkBVUqcewUxOy8oZ6
 5WOkDMZ1lL0fK3iguzEnOQb887i95ge1XZXosmxyjDxjAD88bqASadZSgsHkjvmFvlY6
 rLUiX4oqwIMsPIAxvdoJ7E01o+FzFT+0219Xb84pLUK0iWnMINJOHP+8/VzBxPeHJEUi
 63ipbmRi/ah7wdmuGn69HdWlhPKsZ55KsTbxHNrqxRb39Q6gm/8j6XPr4CO2l4k0AUhM
 6MyMIEd9muidsGNe9QIGzoq5Uo9Al0nLDozJdRCBgoPoNnbPLII5gD5VqbEA9IpRkRPR
 AKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578632; x=1741183432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8OLAEfb1TFH74FrITh5hY7sd4JTAq5WSAJV1LNPh/Qg=;
 b=q3MRZv27Ti/1faRTxIjvxzPEn6g3zvw0z5qiY7sHnYAM8HGPZTGxokhEGaMhiD6qYF
 3kpJVlikCJV1m41mvBClLzXsH/6/THwVGWTCDYrBQHXfeGf8gabLcIST0B7y3FzSzNVJ
 e40kZYE5eyzCyL1+y45ezuC+Nkc+VnK3KtP+d5W6IGCY7IAhU4I85OthiPom4aZr0Zxe
 rOP2HnH7sRnYGFLo3X8sV72XufFpd4dRKzJkfgs6fXCwTEOcknU21eldvdL4wjvmK4ju
 8Y3LQyx9WpqdUZ1Q7KdWDRWKbhI+EUjnSCQ8RJW+QOS4u3H566wv1ygZ2A+Tx/lLpSnc
 in4Q==
X-Gm-Message-State: AOJu0Yzc2JObbnN/IvyCVCYVtT49AZX0A5PV1xq+3EC+yv6tXLs0284E
 x2QW4DnA2rfzXKLxMB3w+U3sbyWPwTmwhMItNTXXHAE7JnX5+JiTrrIr4x+cnVg=
X-Gm-Gg: ASbGncvjG7KbpFhNJ5s9CLRHPPEItTKAoWGmcSAtidMl+LGIGqLjgkj/GtvP8YU1qQR
 Rm1TXK3p1VIS0r+T6fIsk28BCt+hpGXZ/Kj8owH1iZRECPMPBdlyEztd44gD0+YUtnSvFwxnJXX
 EFIWaJ9xtxVQ/UbrB9jHpaee2krEMKrF91MKT6iSMtjAQDlXtCj75RRHmz70irKfpbN++f07V6z
 xYTDJc9dRlNBrNTcZsYZLxWTiLRgmTyKiOn36+GbToNxnHOlQcQ1KN+iSI6Xfu9NAhjwDPMkG9s
 +Q0gEB0GS8huRwXcu22inmR/+k4v
X-Google-Smtp-Source: AGHT+IE6AOHiFi8UETxjRSZnfI+8EyG7zhsKlcDWkooHEp9HVjJN5cw2ndmcfJu+OezpPsDJqiwCpw==
X-Received: by 2002:a05:6000:1fa5:b0:38f:3015:b9f4 with SMTP id
 ffacd0b85a97d-390d4f42947mr2619273f8f.27.1740578632136; 
 Wed, 26 Feb 2025 06:03:52 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390df959306sm470978f8f.58.2025.02.26.06.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 77BEE60339;
 Wed, 26 Feb 2025 14:03:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 06/25] tests/functional: Introduce the dso_suffix() helper
Date: Wed, 26 Feb 2025 14:03:24 +0000
Message-Id: <20250226140343.3907080-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce a helper to get the default shared library
suffix used on the host.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250220080215.49165-3-philmd@linaro.org>
[AJB: dropped whitespace cmd.py damage]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/qemu_test/__init__.py | 2 +-
 tests/functional/qemu_test/config.py   | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 5c972843a6..45f7befa37 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -7,7 +7,7 @@
 
 
 from .asset import Asset
-from .config import BUILD_DIR
+from .config import BUILD_DIR, dso_suffix
 from .cmd import is_readable_executable_file, \
     interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
     exec_command, exec_command_and_wait_for_pattern, get_qemu_img, which
diff --git a/tests/functional/qemu_test/config.py b/tests/functional/qemu_test/config.py
index edd75b7fd0..0eab1baa54 100644
--- a/tests/functional/qemu_test/config.py
+++ b/tests/functional/qemu_test/config.py
@@ -13,6 +13,7 @@
 
 import os
 from pathlib import Path
+import platform
 
 
 def _source_dir():
@@ -34,3 +35,8 @@ def _build_dir():
     raise Exception("Cannot identify build dir, set QEMU_BUILD_ROOT")
 
 BUILD_DIR = _build_dir()
+
+def dso_suffix():
+    '''Return the dynamic libraries suffix for the current platform'''
+    DSO_SUFFIXES = { 'Linux': 'so', 'Darwin': 'dylib', 'Windows': 'dll' }
+    return DSO_SUFFIXES[platform.system()]
-- 
2.39.5


