Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E50E7DF13
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmxvi-0000es-40; Mon, 02 Feb 2026 12:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vmxvb-0000eH-PQ
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:41:39 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vmxvZ-000596-TX
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:41:35 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64bea6c5819so6870977a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 09:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770054090; x=1770658890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W7xvJjxpOAS27dQ9+Nn3Klb7G+/2Lu+nVEG7HRQOw1U=;
 b=COgvUwMTj4gTGkD4/8CSRjzu6INf1bOmmlFqu5dJxR/SuwApzWblWXoXViU8AXguqy
 JL/fvn8dLR4P+2azUX48Iv0gllygGaccNacdjXsAHbwi+NkfX4omZiU9AE0pH3k771vT
 4i9rcRqw3O2YTSgaInhkgZ1yyDItTUKUz9pS3qsEPp9g040nPXAgeAV3U5iUhe5WILan
 uPLA662WSNuPOl+LtPzLx0kmUfv6mHzWfcrntTolUlfs56WkHnY0lI8TMu2d2LYGnJjb
 a2nOeFkECL26XR6KzPPPx7Va6tYSzqGAHH8zm8BtDeXuvxpBm/nkEHpOhStsrg3QPK+b
 MU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770054090; x=1770658890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7xvJjxpOAS27dQ9+Nn3Klb7G+/2Lu+nVEG7HRQOw1U=;
 b=ZSxnI+9k/U16KZ8mr5GV8rmIlRVscMnV8SazrUlgoNDWdzt/XEHWh25zZ0eZz8weVL
 h6Y/1ASKgSZZYXyCiWB5rMISQ/ihtYZkxhzzLB632a51MjLaeAUNZuOncNUGqyqiXwcC
 iQytZLAl7tRDZgXSp7Wg6e0TGHIjDslMaC56Re4kN9j1cZzjQbxfJR3iwbwW2IujrID6
 7XGglMGGpfKYHJJhNtQZXA4AAo2k8f+y8I/eM1udPluexEFkKM7NT0eBIbS+wLAhwO+3
 t5R1iabivsfLApO25g4s3eQfvy/5wFXupm+5ZFBUbzmI2pWhhkqvlFwZ6L0TvXLJQanf
 pOAA==
X-Gm-Message-State: AOJu0YzqwjuhghfVE3hz20jB0hb/QclajnBHH9xnrvDElkZaOD9uhgGu
 E2XSHF/cQXONJ0RJB9BWbJNL3fPwvMe90F1y6K2yvJK0HSUvHpDqKCYjgv5diIq+xKM=
X-Gm-Gg: AZuq6aJSYukXL23lQ/BY//6rtgAWPYmxGbY/4yDSQAVRt6Pj2wWXA8RXg1/+75DEyN5
 F/H2WHKtLvkwTxq2xryAbm3dpKC8GWiFW3iTrGZ9ve21Cw+FV5gxdV9TikJedOuroZBnR+tPTz0
 pK7d8tWAz4uG1LfaoI6eSnVM5p07d5c7FHcwvz5n6kcA9wXPs85A5dZU5OlowLiGVwr6ZFW6NmB
 jzkS+RQ6Er+eYMAQSOLB68frcuMiXU+lZdbEeh4pl9xHSEGRQUIUTcSEuoN2y+O251UdDUICRP9
 WS6tAj5O2i569rBiryMhTPZR+16xrViIvj1EwTczBIEFWDPKjAuIYdMENsdsHeqG3qiscIwRbV/
 aP4OzesVfRPpFn9A37jNGR2RCxV45bFu1NU9Fnk5aRFwb4pyg6zHGfsAooyOOOBHN6Wv3pMcUv3
 FjEIV2HtK/mX0=
X-Received: by 2002:a17:907:3cc5:b0:b87:20eb:a66d with SMTP id
 a640c23a62f3a-b8dff723fecmr753136666b.65.1770054089615; 
 Mon, 02 Feb 2026 09:41:29 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dee927ec4sm674807666b.0.2026.02.02.09.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 09:41:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 031B05F7D8;
 Mon, 02 Feb 2026 17:41:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [RFC PATCH] meson-buildoptions: Remove duplicated entry of --gdb in
 the help text
Date: Mon,  2 Feb 2026 17:41:22 +0000
Message-ID: <20260202174123.1943748-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Since --gdb has recently been added to meson_options.txt, the help
text shows up twice in the output of "./configure --help":

 $ ./configure --help | grep gdb
   --gdb=GDB-path           gdb to use for gdbstub tests [/usr/bin/gdb]
   --gdb=VALUE              Path to GDB

As the probed value is of interest we want to keep the configure text
so make meson-buildoptions able to handle deferring to configure.

Fixes: b46b3818cf8 ("tests/functional: Provide GDB to the functional tests")
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
AJB:
  - This is an alternative take on Thomas's approach in 20260114155355.82096-1-thuth@redhat.com
---
 scripts/meson-buildoptions.py | 9 ++++++++-
 scripts/meson-buildoptions.sh | 1 -
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
index e636d258e8a..9e3a75c8b11 100644
--- a/scripts/meson-buildoptions.py
+++ b/scripts/meson-buildoptions.py
@@ -53,6 +53,11 @@
     "werror",
 }
 
+# Options that configure prints help for, so we can skip
+CONFIGURE_HELP = {
+    "gdb",
+}
+
 # Builtin options that should be definable via configure.  Some of the others
 # we really do not want (e.g. c_args is defined via the native file, not
 # via -D, because it's a mix of CFLAGS and --extra-cflags); for specific
@@ -189,7 +194,9 @@ def print_help(options):
         key = cli_help_key(opt)
         # The first section includes options that have an arguments,
         # and booleans (i.e., only one of enable/disable makes sense)
-        if require_arg(opt):
+        if opt["name"] in CONFIGURE_HELP:
+            pass
+        elif require_arg(opt):
             metavar = cli_metavar(opt)
             left = f"--{key}={metavar}"
             help_line(left, opt, 27, True)
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 3d0d1323446..e8edc5252a3 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -58,7 +58,6 @@ meson_options_help() {
   printf "%s\n" '  --enable-ubsan           enable undefined behaviour sanitizer'
   printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware files [share/qemu-'
   printf "%s\n" '                           firmware]'
-  printf "%s\n" '  --gdb=VALUE              Path to GDB'
   printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
   printf "%s\n" '  --includedir=VALUE       Header file directory [include]'
   printf "%s\n" '  --interp-prefix=VALUE    where to find shared libraries etc., use %M for'
-- 
2.47.3


