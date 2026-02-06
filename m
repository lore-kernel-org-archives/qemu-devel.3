Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C65EE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQCu-0007zl-AN; Fri, 06 Feb 2026 13:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCq-0007wd-Bf
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:24 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCo-0001R0-Ek
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:24 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b8838339fc6so46280866b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770401120; x=1771005920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7rLTMaLaNyA13QPnQ+is080Z8HIDPH5vwzyyQGnqkxA=;
 b=BUOrC4FEgbIxw1hSeJBP6kObMJ4siT5te0f/eAAmNNCkuZ3unwgZveNPg6U66IF7MC
 lTU4W3Ak7o3E/ZX1qKWUcFUtJ2/I3CUxLP5G4dzY5KYQLQkh8TXgu+PjP6hDGsBYVKwr
 jJMe7spq8HnLkTJiIN0OZ2CYrdpH8StmpiCVGyBFMzV/rcERQB3eXUgmtXSxAdNAffGC
 umYZe1qWgaoVi4Lo3MKZYhl71QQasBi+cTR+NG5BR9zBBgv64YI+WMU8z7amJ6ZAY7yo
 yJuz3qlj9I5rqfpSPkQNhjeHhiPu8BrXNOllPfggjzuDDIC8Pi9Z/qnavKKFJZXnfK7F
 14EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401120; x=1771005920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7rLTMaLaNyA13QPnQ+is080Z8HIDPH5vwzyyQGnqkxA=;
 b=XelgmjJ/LhrFTDqZWsF4OSD1HvT+Y/LJUquMdQ1fKMsxFcTPlQ6FqYUoyxivuHeMZn
 qxthxal55H6BxpbGi6H+Hzf0zCSzYKTItjTi1tkjlklEXydcnF2MuheA9EXIImmbQ0PY
 2EGdyG66VLcKVhsCkV/15kEmKJ+sh4BCIl2wu8+C/hjomOXngmtxHU+Uk64+pJhlJUfL
 dInS/zRA41r1oSrlgt/vVZkoRNJ6ukReqiQxjVgzDAU3FiG+0qoneajR7CKcOG0B+CTc
 imrQU61xnTGlds10KFiUqE/lOlOcGZsCnhrEw7qx9OzEHIFyvr6Ur5IWGPSgyCd5e1Gz
 XjYg==
X-Gm-Message-State: AOJu0YyNd1cAzDSO5zYp6DeyplbHfO4zZT3P83D2yXb2XGJv7HWnvy/+
 1/NmYyxt7OwF+ZBC+7CGykYQOsl1Q4dFz9lrdCONLylKSMcSG5cyrYD/uc1PuO46kzQtGdNqUzj
 VkZe7fAw=
X-Gm-Gg: AZuq6aJwXv/J5Lwc9DxFPj5AWzyzDrAIHI10kQCdEZ6xWzxg3e1VciRwHMFetpBdSSW
 g1ASPACLwVIORG7iyL1ZQ3ADvwylJZYaxI37JCEAYjNvUDq8GjcadoI8ysp7aldzr/k41uztdCP
 AAHnvFW+Qzt3ZhKL4Sgezb0WhN3sYIYpbIFxNVXKbS5fkn+iNcx3WvuN5HIx3/nbCUgJwuGiR8k
 Ga0ePP98Dx8hu3pg3hAa4b5gVE+vUbxs3HFY94n/gEXvr3tmsTOqir8tsE3M+613hq2h5AKZEll
 1HjomN8ftYoJfFMV6gCPcRSoePK3qwTDL+ks2R8Z7tJbo5gxGDC//v3sFTTGrBfv1DTFNqshYnu
 wAyOCIcYYUjC1jkzGUNeYRgm16Gjd3Bm6Iofj4BlwyvJVsOKXEgBUG/j+E32kpSu0KXE1XcxUAa
 VKVSBRRhidaz8=
X-Received: by 2002:a17:907:c2a:b0:b87:763b:3da6 with SMTP id
 a640c23a62f3a-b8edbbcf011mr252917366b.23.1770401119983; 
 Fri, 06 Feb 2026 10:05:19 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8edacaffeesm99446066b.38.2026.02.06.10.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:05:18 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D3FD05FA07;
 Fri, 06 Feb 2026 18:05:17 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL 01/10] meson-buildoptions: Remove duplicated entry of --gdb in
 the help text
Date: Fri,  6 Feb 2026 18:05:08 +0000
Message-ID: <20260206180517.1335861-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206180517.1335861-1-alex.bennee@linaro.org>
References: <20260206180517.1335861-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260203115201.2387721-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


