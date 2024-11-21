Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57E9D743FD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHp-0001aJ-Iq; Wed, 20 Nov 2024 20:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHn-0001ZT-IU
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:11 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHl-0004X7-Tm
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=5YVDpLsCIhM0Je0KSsPGzZGsGqGUsmMzfsGlF+C2ZE0=; b=rK/9p6PrysTn5bv
 g0i1MoWEYfzdeZDxhNyWJcWd+h0KUjtKXBJb9hNA2X38Sb4jF2FpufHNRdYkvcEnDt5IhGK0qKWmG
 7VmyaRCZlY+nkLPTWefj/0E4stKWCUrE8hpXBZN+yQJYvlYNSnOrysrzCdcV9FbE1YdigBNRPI67f
 1o=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 10/43] helper-to-tcg: Add meson.build
Date: Thu, 21 Nov 2024 02:49:14 +0100
Message-ID: <20241121014947.18666-11-anjo@rev.ng>
In-Reply-To: <20241121014947.18666-1-anjo@rev.ng>
References: <20241121014947.18666-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Sets up a barebones meson.build that handles:

  1. Exposing command for converting .c files to LLVM IR by looking at
     compile_commads.json;

  2. Finding LLVM and verifying the LLVM version manually by running
     llvm-config, needed for dealing with multiple LLVM versions in a
     sane way;

  3. Building of helper-to-tcg.

A meson option is added to specify the path to llvm-config.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/meson.build       | 70 +++++++++++++++++++++
 subprojects/helper-to-tcg/meson_options.txt |  2 +
 2 files changed, 72 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/meson.build
 create mode 100644 subprojects/helper-to-tcg/meson_options.txt

diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
new file mode 100644
index 0000000000..af593ccdfe
--- /dev/null
+++ b/subprojects/helper-to-tcg/meson.build
@@ -0,0 +1,70 @@
+##
+##  Copyright(c) 2024 rev.ng Labs Srl. All Rights Reserved.
+##
+##  This program is free software; you can redistribute it and/or modify
+##  it under the terms of the GNU General Public License as published by
+##  the Free Software Foundation; either version 2 of the License, or
+##  (at your option) any later version.
+##
+##  This program is distributed in the hope that it will be useful,
+##  but WITHOUT ANY WARRANTY; without even the implied warranty of
+##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+##  GNU General Public License for more details.
+##
+##  You should have received a copy of the GNU General Public License
+##  along with this program; if not, see <http://www.gnu.org/licenses/>.
+##
+
+project('helper-to-tcg', ['cpp'],
+        meson_version: '>=0.63.0',
+        version: '0.7',
+        default_options: ['cpp_std=none', 'optimization=2'])
+
+python = import('python').find_installation()
+
+# Find LLVM using llvm-config manually.  Needed as meson struggles when multiple
+# versions of LLVM are installed on the same system (always returns the most
+# recent).
+llvm_config = get_option('llvm_config_path')
+cpp_args = [run_command(llvm_config, '--cxxflags').stdout().strip().split()]
+bindir = run_command(llvm_config, '--bindir').stdout().strip()
+ldflags = run_command(llvm_config, '--ldflags').stdout().strip().split()
+libs = run_command(llvm_config, '--libs').stdout().strip().split()
+syslibs = run_command(llvm_config, '--system-libs').stdout().strip().split()
+incdir = run_command(llvm_config, '--includedir').stdout().strip().split()
+version = run_command(llvm_config, '--version').stdout().strip()
+version_major = version.split('.')[0].to_int()
+
+# Check LLVM version manually
+if version_major < 10 or version_major > 14
+    error('LLVM version', version, 'not supported.')
+endif
+
+sources = [
+]
+
+clang = bindir / 'clang'
+llvm_link = bindir / 'llvm-link'
+
+get_llvm_ir_cmd = [python, meson.current_source_dir() / 'get-llvm-ir.py',
+                   '--compile-commands', 'compile_commands.json',
+                   '--clang', clang,
+                   '--llvm-link', llvm_link]
+
+# NOTE: Add -Wno-template-id-cdtor for GCC versions >= 14.  This warning is
+# related to a change in the C++ standard in C++20, that also applies to C++14
+# for some reason. See defect report DR2237 and commit
+#   https://gcc.gnu.org/git/gitweb.cgi?p=gcc.git;h=4b38d56dbac6742b038551a36ec80200313123a1
+# (temporary)
+compiler_info = meson.get_compiler('cpp')
+compiler = compiler_info.get_id()
+compiler_version = compiler_info.version().split('-').get(0)
+compiler_version_major = compiler_version.split('.').get(0)
+if compiler == 'gcc' and compiler_version_major.to_int() >= 14
+    cpp_args += ['-Wno-template-id-cdtor', '-Wno-missing-template-keyword']
+endif
+
+pipeline = executable('helper-to-tcg', sources,
+                      include_directories: ['passes', './', 'include'] + [incdir],
+                      link_args: [ldflags] + [libs] + [syslibs],
+                      cpp_args: cpp_args)
diff --git a/subprojects/helper-to-tcg/meson_options.txt b/subprojects/helper-to-tcg/meson_options.txt
new file mode 100644
index 0000000000..8a4b28a585
--- /dev/null
+++ b/subprojects/helper-to-tcg/meson_options.txt
@@ -0,0 +1,2 @@
+option('llvm_config_path', type : 'string', value : 'llvm-config',
+       description: 'override default llvm-config used for finding LLVM')
-- 
2.45.2


