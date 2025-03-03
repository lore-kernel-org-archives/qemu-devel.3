Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8418EC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 13:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6AO-0006Zd-Lz; Mon, 03 Mar 2025 08:49:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tp6AF-0006Yw-PD
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 08:49:00 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tp6AD-00039J-CH
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 08:48:59 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5dccaaca646so591242a12.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 05:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741009735; x=1741614535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/WsZMbELTBozPxBwBw+IDOie2Orceltd8QctJHKnVJM=;
 b=IpyjtcZ+/Ht9l1Uiu2LfAxEL7zIcMOfQaTUGxWSYKR2Ys6bOuE1Q3B5Lk/ekXoNgnp
 wdTObwgmLhzKYvbJOzHy1t0LkXSnQ1zf0ud6ZRmtV20a/5EqexyYzSwOiODgQeS82KAE
 SCv/BxwCZzhzhU1WlFw2URlxZHwQY2F4ssMJXX0C51TuSbfymUqkyvhWC9pfS667qZsJ
 S2C6nwgoEU1v5Qf+TFd32P9ewMNzhxKCiP9WufUvmtoiHGaGkIsWu/9HHTBChZDo2wue
 MJ+rUQvQc8BwCkz2VDffNE9r0yWAIiGViRfA1Vwv5iYhpEfTI3gk9V8HD5mPhzpFOyZJ
 EZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741009735; x=1741614535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/WsZMbELTBozPxBwBw+IDOie2Orceltd8QctJHKnVJM=;
 b=XoDqS9udWSDDaLuRfsGT+QX07ovf8M9YdyR0P7QRgz0FkhzqFJ8gX0fUXe9Miue0le
 qyvc94xiRz7q2md/nNtv+aRrZzPCVNV4hxws1RgrEvzpH4p5WG+S0ABvJH7n5GE+uXdY
 RyJObKSfsoSN9KfmzMvM+xkFyw2QIDFix03kb9zDfjGoYhpJjV7hV2tKbhqfhKZLEF0V
 +qcMkuad5f52JJcZ2csTM7bxCW05L+O0k+JfTFFAYkv1jey3YFt9IKDMDgRZrQpcYCYd
 CbrYYWbVPs+KBmTOjz8FgpGshhK2B8y0R7TvMc2veqVm68RtdVq86ZSAONgeXVGHHN8z
 G/1Q==
X-Gm-Message-State: AOJu0Ywg/McBmosuVmYXGvqPvTrUZqSiTf2hpVKGUCz49QsQpTTVsTGa
 6JHDJKxgk8Vo8jwkWISpHGHxmDAL5CxZnWVCXC+cDbYCcjjGgHLyQRfvCyybc1A=
X-Gm-Gg: ASbGncv8CpbqflmiZ+cxg2uEAbb9QCEqGOLPPrxLOsWeUOIJ8pmT4noftR8iysi26Sc
 hZf6rDvLU2azvZIqHCA1T9miVv0uUm3fj3VLv1vAFgMyBVzay/mlRIA3bMCJx1/ttJN5yYlz10M
 e1ccBEPmdRJ0D8LfaJHXF7IMks2ZWnU1FusMCB6ylOPg4JGzzX7UBfRdkLFvdeKpB6PJSHPn9W3
 tTtFheCIYScaKx551KXzh3N9uM4IB5l3fpkcCrR5nwqwiAqOx8FGb1PVCKhIaV5oRAYZH93ET9h
 KtHOb7uCQLlgQlXCw9fgyi5VM8+HnAGUrTuWZ4auE9d2WIc=
X-Google-Smtp-Source: AGHT+IHUfxbOIBkf7N4a/2kTd9oNR6AyZyEXjTB7fccvmrVM2oJ0BprDLoWWKpGgEHQa1u3EG69xbA==
X-Received: by 2002:a50:d708:0:b0:5e0:7df0:6623 with SMTP id
 4fb4d7f45d1cf-5e4bfaa6cbdmr16413209a12.6.1741009735102; 
 Mon, 03 Mar 2025 05:48:55 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3bb737asm6932534a12.44.2025.03.03.05.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 05:48:54 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 831C15F909;
 Mon,  3 Mar 2025 13:48:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Egorenkov <egorenar-dev@posteo.net>,
 Bernd Kuhls <bernd@kuhls.net>,
 Francis Laniel <flaniel@linux.microsoft.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jugurtha BELKALEM <jugurtha.belkalem@smile.fr>,
 Julien Olivain <ju.o@free.fr>, Laurent Vivier <laurent@vivier.eu>,
 Qais Yousef <qais.yousef@arm.com>, Romain Naour <romain.naour@gmail.com>,
 "Wojciech M. Zabolotny" <wzab01@gmail.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH v3] package/elfutils: ensure we have 5.0 kernel headers for
 aarch64
Date: Mon,  3 Mar 2025 13:48:49 +0000
Message-Id: <20250303134849.405711-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Since Buildroot commit [1] "package/elfutils: bump to version 0.192"
elfutils fails to build on Aarch64 with toolchain including Kernel older
than version 5.0. Error shows:

    aarch64_initreg.c: In function 'aarch64_set_initial_registers_tid':
    aarch64_initreg.c:61:24: error: storage size of 'pac_mask' isn't
    known
       61 |   struct user_pac_mask pac_mask;
          |                        ^~~~~~~~

elfutils 0.192 introduced a Aarch64 pointer authentication support in
upstream commit [2].

For reference, the user_pac_mask structure was introduced in Kernel
upstream commit [3], included in Kernel v5.0.

Fixes:
- e.g https://autobuild.buildroot.org/results/5156901a73be52ce8ffbf10729e6852499a300be/
- 4/6 of the failures here: https://autobuild.buildroot.org/?reason=elfutils-0.192&arch=aarch64

[1] https://gitlab.com/buildroot.org/buildroot/-/commit/5eb734766b24de5fce6e586897cd4827f8855442
[2] https://sourceware.org/git/?p=elfutils.git;a=commitdiff;h=64e3b451ad2cec8d45661b1816e3d2dc4431f3ca
[3] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=ec6e822d1a22d0eef1d1fa260dff751dba9a4258

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250217140332.310347-1-alex.bennee@linaro.org>

---
v3
  - introduce BR2_PACKAGE_ELFUTILS_KERNEL_SUPPORTS
    - expand Aarch64 condition to include BE
  - fix bcc test to use bleeding edge toolchain
---
 package/avrdude/Config.in                 |  1 +
 package/bcc/Config.in                     |  1 +
 package/bpftool/Config.in                 |  1 +
 package/bpftrace/Config.in                |  1 +
 package/elfutils/Config.in                | 12 ++++++++++--
 package/falcosecurity-libs/Config.in      |  1 +
 package/igt-gpu-tools/Config.in           |  1 +
 package/kexec-lite/Config.in              |  1 +
 package/libbpf/Config.in                  |  1 +
 package/ltrace/Config.in                  |  1 +
 package/makedumpfile/Config.in            |  1 +
 package/petitboot/Config.in               |  1 +
 support/testing/tests/package/test_bcc.py |  1 +
 13 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/package/avrdude/Config.in b/package/avrdude/Config.in
index 06fee0ca7f..13a84677c2 100644
--- a/package/avrdude/Config.in
+++ b/package/avrdude/Config.in
@@ -4,6 +4,7 @@ config BR2_PACKAGE_AVRDUDE
 	depends on BR2_USE_WCHAR # elfutils
 	depends on !BR2_STATIC_LIBS # elfutils
 	depends on BR2_TOOLCHAIN_GCC_AT_LEAST_4_9 # libusb
+	depends on BR2_PACKAGE_ELFUTILS_KERNEL_SUPPORTS # elfutils
 	select BR2_PACKAGE_ELFUTILS
 	select BR2_PACKAGE_LIBUSB
 	select BR2_PACKAGE_LIBUSB_COMPAT
diff --git a/package/bcc/Config.in b/package/bcc/Config.in
index bf46f07d93..e9d8b63a96 100644
--- a/package/bcc/Config.in
+++ b/package/bcc/Config.in
@@ -9,6 +9,7 @@ config BR2_PACKAGE_BCC
 	depends on BR2_USE_WCHAR # clang, python3
 	depends on BR2_TOOLCHAIN_HAS_THREADS # clang, python3
 	depends on !BR2_STATIC_LIBS # clang, python3
+	depends on BR2_PACKAGE_ELFUTILS_KERNEL_SUPPORTS # elfutils
 	select BR2_PACKAGE_CLANG
 	select BR2_PACKAGE_ELFUTILS
 	select BR2_PACKAGE_FLEX # needs FlexLexer.h
diff --git a/package/bpftool/Config.in b/package/bpftool/Config.in
index 9500baf11e..15ca736501 100644
--- a/package/bpftool/Config.in
+++ b/package/bpftool/Config.in
@@ -17,6 +17,7 @@ config BR2_PACKAGE_BPFTOOL
 	depends on !BR2_STATIC_LIBS # elfutils
 	depends on BR2_TOOLCHAIN_HAS_THREADS # elfutils
 	depends on BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_12
+	depends on BR2_PACKAGE_ELFUTILS_KERNEL_SUPPORTS # elfutils
 	select BR2_PACKAGE_BINUTILS
 	select BR2_PACKAGE_ELFUTILS
 	help
diff --git a/package/bpftrace/Config.in b/package/bpftrace/Config.in
index 8af94443ab..f21da07601 100644
--- a/package/bpftrace/Config.in
+++ b/package/bpftrace/Config.in
@@ -18,6 +18,7 @@ config BR2_PACKAGE_BPFTRACE
 	depends on BR2_USE_WCHAR # bcc -> clang, bcc -> python3, libbpf
 	depends on BR2_TOOLCHAIN_HAS_THREADS # bcc -> clang, bcc -> python3, libbpf
 	depends on !BR2_STATIC_LIBS # bcc -> clang, bcc -> python3, libbpf
+	depends on BR2_PACKAGE_ELFUTILS_KERNEL_SUPPORTS # elfutils
 	select BR2_PACKAGE_BCC
 	select BR2_PACKAGE_BZIP2
 	select BR2_PACKAGE_CEREAL
diff --git a/package/elfutils/Config.in b/package/elfutils/Config.in
index c355048c6d..8fe19ef10d 100644
--- a/package/elfutils/Config.in
+++ b/package/elfutils/Config.in
@@ -1,12 +1,20 @@
-comment "elfutils needs a toolchain w/ wchar, dynamic library, threads"
+# This option ensures elfutils has recent enough kernel headers for the features it needs.
+config BR2_PACKAGE_ELFUTILS_KERNEL_SUPPORTS
+    bool
+    default y
+    depends on BR2_TOOLCHAIN_HEADERS_AT_LEAST_5_0 || (!BR2_aarch64 && !BR2_aarch64_be) # user_pac_mask
+
+comment "elfutils needs a toolchain w/ wchar, dynamic library, threads, (kernel headers >= 5.0 for AArch64)"
 	depends on !BR2_USE_WCHAR || BR2_STATIC_LIBS \
-		|| !BR2_TOOLCHAIN_HAS_THREADS
+		|| !BR2_TOOLCHAIN_HAS_THREADS \
+		|| !BR2_PACKAGE_ELFUTILS_KERNEL_SUPPORTS
 
 config BR2_PACKAGE_ELFUTILS
 	bool "elfutils"
 	depends on BR2_USE_WCHAR
 	depends on !BR2_STATIC_LIBS
 	depends on BR2_TOOLCHAIN_HAS_THREADS
+	depends on BR2_PACKAGE_ELFUTILS_KERNEL_SUPPORTS
 	select BR2_PACKAGE_ZLIB
 	select BR2_PACKAGE_ARGP_STANDALONE if !BR2_TOOLCHAIN_USES_GLIBC
 	select BR2_PACKAGE_MUSL_FTS if !BR2_TOOLCHAIN_USES_GLIBC
diff --git a/package/falcosecurity-libs/Config.in b/package/falcosecurity-libs/Config.in
index 028a0ed28b..1a7118f04f 100644
--- a/package/falcosecurity-libs/Config.in
+++ b/package/falcosecurity-libs/Config.in
@@ -10,6 +10,7 @@ config BR2_PACKAGE_FALCOSECURITY_LIBS
 	depends on BR2_TOOLCHAIN_HAS_SYNC_4 || BR2_TOOLCHAIN_HAS_ATOMIC # grpc
 	depends on BR2_TOOLCHAIN_USES_GLIBC # tbb
 	depends on BR2_PACKAGE_LUAINTERPRETER_ABI_VERSION_5_1
+	depends on BR2_PACKAGE_ELFUTILS_KERNEL_SUPPORTS # elfutils
 	select BR2_PACKAGE_C_ARES
 	select BR2_PACKAGE_ELFUTILS
 	select BR2_PACKAGE_GRPC
diff --git a/package/igt-gpu-tools/Config.in b/package/igt-gpu-tools/Config.in
index 184acb4cf1..7417aa9613 100644
--- a/package/igt-gpu-tools/Config.in
+++ b/package/igt-gpu-tools/Config.in
@@ -7,6 +7,7 @@ config BR2_PACKAGE_IGT_GPU_TOOLS
 	depends on BR2_PACKAGE_HAS_UDEV
 	depends on BR2_USE_WCHAR # elfutils, procps-ng
 	depends on BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_11 # linux/dma-buf.h
+	depends on BR2_PACKAGE_ELFUTILS_KERNEL_SUPPORTS # elfutils
 	select BR2_PACKAGE_BUSYBOX_SHOW_OTHERS # procps-ng
 	select BR2_PACKAGE_CAIRO
 	select BR2_PACKAGE_CAIRO_PNG
diff --git a/package/kexec-lite/Config.in b/package/kexec-lite/Config.in
index 71bd619ae4..1d15cda3d0 100644
--- a/package/kexec-lite/Config.in
+++ b/package/kexec-lite/Config.in
@@ -9,6 +9,7 @@ config BR2_PACKAGE_KEXEC_LITE
 	depends on !BR2_STATIC_LIBS # dtc, elfutils
 	depends on BR2_USE_WCHAR # elfutils
 	depends on BR2_TOOLCHAIN_HAS_THREADS # elfutils
+	depends on BR2_PACKAGE_ELFUTILS_KERNEL_SUPPORTS # elfutils
 	select BR2_PACKAGE_ELFUTILS
 	select BR2_PACKAGE_DTC
 	select BR2_PACKAGE_DTC_PROGRAMS
diff --git a/package/libbpf/Config.in b/package/libbpf/Config.in
index a78392cdc8..e538526e4f 100644
--- a/package/libbpf/Config.in
+++ b/package/libbpf/Config.in
@@ -5,6 +5,7 @@ config BR2_PACKAGE_LIBBPF
 	depends on !BR2_STATIC_LIBS # elfutils
 	depends on BR2_TOOLCHAIN_HAS_THREADS # elfutils
 	depends on BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_13
+	depends on BR2_PACKAGE_ELFUTILS_KERNEL_SUPPORTS # elfutils
 	select BR2_PACKAGE_ELFUTILS
 	select BR2_PACKAGE_ZLIB
 	help
diff --git a/package/ltrace/Config.in b/package/ltrace/Config.in
index 2dc969c4f1..7f131204f8 100644
--- a/package/ltrace/Config.in
+++ b/package/ltrace/Config.in
@@ -17,6 +17,7 @@ config BR2_PACKAGE_LTRACE
 	depends on BR2_TOOLCHAIN_HAS_THREADS # elfutils
 	depends on BR2_TOOLCHAIN_USES_UCLIBC || BR2_TOOLCHAIN_USES_GLIBC
 	depends on BR2_PACKAGE_LTRACE_ARCH_SUPPORTS
+	depends on BR2_PACKAGE_ELFUTILS_KERNEL_SUPPORTS # elfutils
 	select BR2_PACKAGE_ELFUTILS
 	help
 	  Debugging program which runs a specified command until it
diff --git a/package/makedumpfile/Config.in b/package/makedumpfile/Config.in
index 325a31d7b6..dfbc0588c4 100644
--- a/package/makedumpfile/Config.in
+++ b/package/makedumpfile/Config.in
@@ -19,6 +19,7 @@ config BR2_PACKAGE_MAKEDUMPFILE
 	depends on BR2_TOOLCHAIN_HAS_THREADS
 	depends on !BR2_STATIC_LIBS # dlopen
 	depends on BR2_USE_WCHAR
+	depends on BR2_PACKAGE_ELFUTILS_KERNEL_SUPPORTS # elfutils
 	select BR2_PACKAGE_BZIP2
 	select BR2_PACKAGE_ELFUTILS
 	select BR2_PACKAGE_XZ
diff --git a/package/petitboot/Config.in b/package/petitboot/Config.in
index 50d5a4da70..e32be4cba6 100644
--- a/package/petitboot/Config.in
+++ b/package/petitboot/Config.in
@@ -7,6 +7,7 @@ config BR2_PACKAGE_PETITBOOT
 	depends on BR2_TOOLCHAIN_HAS_THREADS # elfutils, kexec-lite, lvm2
 	depends on BR2_PACKAGE_HAS_UDEV
 	depends on BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_17 || !BR2_PACKAGE_KEXEC_ARCH_SUPPORTS # kexec
+	depends on BR2_PACKAGE_ELFUTILS_KERNEL_SUPPORTS # elfutils
 	select BR2_PACKAGE_ELFUTILS
 	select BR2_PACKAGE_LVM2 # devmapper
 	select BR2_PACKAGE_NCURSES
diff --git a/support/testing/tests/package/test_bcc.py b/support/testing/tests/package/test_bcc.py
index 51f175a5b4..bdcb722722 100644
--- a/support/testing/tests/package/test_bcc.py
+++ b/support/testing/tests/package/test_bcc.py
@@ -17,6 +17,7 @@ class TestBcc(infra.basetest.BRTest):
         f"""
         BR2_aarch64=y
         BR2_TOOLCHAIN_EXTERNAL=y
+        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
         BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
         BR2_LINUX_KERNEL=y
         BR2_LINUX_KERNEL_CUSTOM_VERSION=y
-- 
2.39.5


