Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E44FEFB5D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzbi-0000OL-EX; Fri, 27 Feb 2026 10:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzbd-0000Ma-On
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:18:17 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzba-0005lA-RW
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:18:17 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9373af81cdso183127066b.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 07:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772205493; x=1772810293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1+HIMtYYnwLHf3LpJjM+zs2SRXXOL2pYkUhseMKnJA=;
 b=QCzPQk7qagzW3M5X+99pqDXFkRJdWNGwvbD+kTsjIx+880vRl2BIwL1bRkG9VAJFOc
 QLX0itPMrqljo04UNGTtkmbMHR7ck8v9mvOZ9JtrSjCRYn8kWjmyxsRxWlDeVYmbHq/P
 afb7TecsgiivC+2A9bGDdCmieEjYY+qzKiOn2c+e3ZD0bapaNF64wbQGkcWsVLB0FRmx
 2gggZgLh364gAb1Pg7Gj3nTP3qEkFkHCM6JYB82PSWZGxq+o/H+elh3huwqnDPyxqs/X
 5vF9aZI0PptbyPO1uwR3e93k3iyEct9Snso7g27emfVSbBl8EsyAl9hTyjTyLgAAcz/p
 XXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772205493; x=1772810293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N1+HIMtYYnwLHf3LpJjM+zs2SRXXOL2pYkUhseMKnJA=;
 b=bvrrm8gzmjclLFT3cP4iXTUSChVkrYyn8oEohxPgs8o9Cq1/mggyk8AaWgM4Vr41z9
 hSnMXdNqg1WKqMqX0XBglcsAw5BSqCzxkKVYDYRReN0GpR9qMfj11bGv50ZbBC3qx6Xq
 JwBqgHGmd774eNH9gIHnFD5EqFaFWdhnW09gbTDayf7+ksTg7sAQQez4z1vTZXfoRJ1L
 3LC+TPbu4WC44cGPxQ3+5EZL9dF6WHhhUkg+nR753gUBDcPWu6e8U6KwXS182bcQDsB+
 dz729TA4cj6zryzMv8AYuhmljrHJ2/RfVnu04i/i6U5hJaA766R9xEr5ZT8OWVN+jD4a
 Q9Ew==
X-Gm-Message-State: AOJu0YywBeqFEP+WjzNqsjQOm0iAPZE4t1jAj0P/IXhUZzWCNOXt+dXD
 3APp70AsMPtJwT8a98mpvMZfnAUbCtNmwUVujENEN4V1j77hUxshPX+I/fhkcdgHfIUTFMnJEmI
 vNFmg
X-Gm-Gg: ATEYQzzc8u92BCOWjK4v2ru07MB1jV139IdL0w/cai3V6AsJ3Lb9Ka22XOw3knuT88c
 9HF55wAFJWx6Nu8zYWH88tyM0ic9tOJZRJZB9xlJ9pLR+Y7Jceu6zUHP82IEDEEvN+RdDegvSQ+
 S67H9MWfFO5/GeYgPFAJftZaBig/4T9d/rXzx9zvCm8cSJOo+fRIRPNmZZjo/KNYu69YO6qyYQq
 awLT9PeWc4e0tlG0XMwyD5Z7xoTCUpRMzbPMUymdfrxfskhBWaCQW6spttpjWQKIN8uSGccQDyR
 SnF033nWJjttv+5qnGS3MCGEwuBGWKQV+CH5xszgOcQLmv/JHgmUHQM/iHI5AHLYOeOr1ONVZVu
 C2mFTUXvHHiyR6LpZjps4uq2+770uQLCBqHHG+oPVibsbDEaDxwG/iIgZY01Il3OinJ/e9TsTAI
 T28LpM29bXp2L+GKSfKXJyJ9g=
X-Received: by 2002:a17:906:3d8:b0:b90:6a9a:e36 with SMTP id
 a640c23a62f3a-b9376583dc0mr140257466b.48.1772205492855; 
 Fri, 27 Feb 2026 07:18:12 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935aec7091sm156251166b.58.2026.02.27.07.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 07:18:10 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B740C5FA02;
 Fri, 27 Feb 2026 15:18:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>
Subject: [PULL 6/7] tests/vm: build openbsd from lcitool data
Date: Fri, 27 Feb 2026 15:18:03 +0000
Message-ID: <20260227151805.2335641-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227151805.2335641-1-alex.bennee@linaro.org>
References: <20260227151805.2335641-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

For now only use the minimal decadency set until all the OpenBSD
mappings can be divined.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260226185303.1920021-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 514b0cd7f63..5176e136ab1 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 514b0cd7f6375d0089f96e749079093906c532a8
+Subproject commit 5176e136ab11e275eb9f57c3d5c80e77af6507cb
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index c74345e03d0..3e4b026035b 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -87,9 +87,9 @@ def generate_cirrus(target, trailer=None):
     generate(filename, cmd, trailer)
 
 
-def generate_pkglist(vm, target):
+def generate_pkglist(vm, target, project="qemu"):
     filename = Path(src_dir, "tests", "vm", "generated", vm + ".json")
-    cmd = lcitool_cmd + ["variables", "--format", "json", target, "qemu"]
+    cmd = lcitool_cmd + ["variables", "--format", "json", target, project]
     generate(filename, cmd, None)
 
 
@@ -316,6 +316,7 @@ try:
     # VM packages lists
     #
     generate_pkglist("freebsd", "freebsd-14")
+    generate_pkglist("openbsd", "openbsd-78", project="qemu-minimal")
 
     #
     # Ansible package lists
diff --git a/tests/vm/generated/openbsd.json b/tests/vm/generated/openbsd.json
new file mode 100644
index 00000000000..0886afd0d3d
--- /dev/null
+++ b/tests/vm/generated/openbsd.json
@@ -0,0 +1,27 @@
+{
+  "ccache": "/usr/local/bin/ccache",
+  "cpan_pkgs": [],
+  "cross_pkgs": [],
+  "make": "/usr/local/bin/gmake",
+  "ninja": "/usr/local/bin/ninja",
+  "packaging_command": "pkg_add",
+  "pip3": "/usr/local/bin/pip3",
+  "pkgs": [
+    "bash",
+    "bison",
+    "bzip2",
+    "ccache",
+    "dtc",
+    "git",
+    "glib2",
+    "gmake",
+    "gsed",
+    "libffi",
+    "meson",
+    "ninja",
+    "pkgconf",
+    "python3"
+  ],
+  "pypi_pkgs": [],
+  "python": "/usr/local/bin/python3"
+}
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 9aabfeec963..4f8eeb28e24 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -24,45 +24,6 @@ class OpenBSDVM(basevm.BaseVM):
     link = "https://cdn.openbsd.org/pub/OpenBSD/7.8/amd64/install78.iso"
     csum = "a228d0a1ef558b4d9ec84c698f0d3ffd13cd38c64149487cba0f1ad873be07b2"
     size = "20G"
-    pkgs = [
-        # tools
-        "dtc",
-        "git",
-        "pkgconf",
-        "bzip2", "xz",
-        "ninja",
-
-        # gnu tools
-        "bash",
-        "gmake",
-        "gsed",
-        "gettext-tools",
-
-        # libs: usb
-        "libusb1--",
-
-        # libs: crypto
-        "gnutls",
-
-        # libs: images
-        "jpeg",
-        "png",
-
-        # libs: ui
-        "capstone",
-        "sdl2",
-        "gtk+3",
-        "libxkbcommon",
-
-        # libs: migration
-        "zstd",
-
-        # libs: networking
-        "libslirp",
-
-        # Python stuff
-        "py3-setuptools",
-    ]
 
     BUILD_SCRIPT = """
         set -e;
@@ -198,8 +159,9 @@ class OpenBSDVM(basevm.BaseVM):
         self.console_wait("login:")
         self.wait_ssh()
 
+        pkgs = self.get_qemu_packages_from_lcitool_json()
         self.print_step("Installing packages")
-        self.ssh_root_check("pkg_add %s\n" % " ".join(self.pkgs))
+        self.ssh_root_check("pkg_add %s\n" % " ".join(pkgs))
 
         # shutdown
         self.ssh_root(self.poweroff)
-- 
2.47.3


