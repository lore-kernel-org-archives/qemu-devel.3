Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06627C54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH5t-0001nX-I6; Wed, 29 Jul 2026 23:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH5r-0001lO-5w
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:05:59 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH5l-0002rM-Oi
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=fUstv3mSVXiLKitmFFzJoN0BAt6jWPawXtZvtpdzUus=; b=EbYfeoB0VKsD7mg
 4s9fSnEniMZgzAGGikcvKkx+Eg0iKFMCslyEws+tKR76615k4Ch3ZQIvpTK1OqDFi/ipHq/OFgSGU
 fRUAzCdx9bFnl9wKRjJfRn1zIvlzWx0ms7J0UeZkTfLxB34AJ36GQPQItVq5Pbb8A8U7CZJsJx+2Z
 ns=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 06/50] Add helper-to-tcg subproject
Date: Thu, 30 Jul 2026 05:09:40 +0200
Message-ID: <20260730031025.12926-7-anjo@rev.ng>
In-Reply-To: <20260730031025.12926-1-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adds a new bare bones subproject along with options to enable or disable
it.  The LLVM dependency is managed manually through `llvm-config` for
two reasons: meson struggles with multiple system LLVM versions anyway
and usually returns the newest one even if it doesn't satisfy the version
requirement, and; It allows the user to override the default if they
choose.  As such, an option is added to the subproject to manually
override `llvm-config`.

A new target config option TARGET_HELPER_TO_TCG is also introduced,
which will used in future commits to conditionally add or remove
remove code and memory required by helper-to-tcg.

Current meson option is limited to Hexagon, this might change in the
future if more uses are found on different frontends.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 meson.build                                 | 10 ++++
 meson_options.txt                           |  2 +
 scripts/meson-buildoptions.sh               |  5 ++
 subprojects/helper-to-tcg/meson.build       | 61 +++++++++++++++++++++
 subprojects/helper-to-tcg/meson_options.txt |  2 +
 5 files changed, 80 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/meson.build
 create mode 100644 subprojects/helper-to-tcg/meson_options.txt

diff --git a/meson.build b/meson.build
index 49a5baf5b5..a1411b0eb6 100644
--- a/meson.build
+++ b/meson.build
@@ -3273,7 +3273,16 @@ host_kconfig = \
   (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
   (have_rust ? ['CONFIG_HAVE_RUST=y'] : [])
 
+helper_to_tcg = subproject('helper-to-tcg',
+  required: get_option('hexagon_helper_to_tcg') \
+    .disable_auto_if('hexagon-linux-user' not in target_dirs and \
+                     'hexagon-softmmu' not in target_dirs))
+
 ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR' ]
+if not helper_to_tcg.found()
+   # do not define it if it is not usable
+   ignored += ['TARGET_HELPER_TO_TCG']
+endif
 
 default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
 actual_target_dirs = []
@@ -4266,6 +4275,7 @@ foreach target : target_dirs
   if host_os == 'linux'
     target_inc += include_directories('linux-headers', is_system: true)
   endif
+
   if target.endswith('-softmmu')
     target_type='system'
     if target_base_arch in target_system_arch
diff --git a/meson_options.txt b/meson_options.txt
index a07cb47d35..63309ceaff 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -377,6 +377,8 @@ option('qemu_ga_version', type: 'string', value: '',
 
 option('hexagon_idef_parser', type : 'boolean', value : true,
        description: 'use idef-parser to automatically generate TCG code for the Hexagon frontend')
+option('hexagon_helper_to_tcg', type : 'feature', value : 'enabled',
+       description: 'use the helper-to-tcg translator to automatically generate TCG code from helpers')
 
 option('x86_version', type : 'combo', choices : ['0', '1', '2', '3', '4'], value: '1',
        description: 'tweak required x86_64 architecture version beyond compiler default')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index c003985047..9951d5ad95 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -125,6 +125,9 @@ meson_options_help() {
   printf "%s\n" '  gtk             GTK+ user interface'
   printf "%s\n" '  guest-agent     Build QEMU Guest Agent'
   printf "%s\n" '  guest-agent-msi Build MSI package for the QEMU Guest Agent'
+  printf "%s\n" '  hexagon-helper-to-tcg'
+  printf "%s\n" '                  use the helper-to-tcg translator to automatically generate'
+  printf "%s\n" '                  TCG code from helpers'
   printf "%s\n" '  hv-balloon      hv-balloon driver (requires Glib 2.68+ GTree API)'
   printf "%s\n" '  hvf             HVF acceleration support'
   printf "%s\n" '  iconv           Font glyph conversion support'
@@ -337,6 +340,8 @@ _meson_option_parse() {
     --disable-guest-agent) printf "%s" -Dguest_agent=disabled ;;
     --enable-guest-agent-msi) printf "%s" -Dguest_agent_msi=enabled ;;
     --disable-guest-agent-msi) printf "%s" -Dguest_agent_msi=disabled ;;
+    --enable-hexagon-helper-to-tcg) printf "%s" -Dhexagon_helper_to_tcg=enabled ;;
+    --disable-hexagon-helper-to-tcg) printf "%s" -Dhexagon_helper_to_tcg=disabled ;;
     --enable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=true ;;
     --disable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=false ;;
     --enable-hv-balloon) printf "%s" -Dhv_balloon=enabled ;;
diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
new file mode 100644
index 0000000000..8ab58adb39
--- /dev/null
+++ b/subprojects/helper-to-tcg/meson.build
@@ -0,0 +1,61 @@
+##
+##  Copyright(c) 2026 rev.ng Labs Srl. All Rights Reserved.
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
+        version: '0.8',
+        default_options: ['cpp_std=c++17'])
+
+python = import('python').find_installation()
+
+# Find LLVM using llvm-config manually.  Needed as meson struggles when multiple
+# versions of LLVM are installed on the same system (always returns the most
+# recent).
+llvm_config = get_option('llvm_config_path')
+cpp_args = run_command(llvm_config, '--cxxflags').stdout().strip().split()
+bindir = run_command(llvm_config, '--bindir').stdout().strip()
+ldflags = run_command(llvm_config, '--ldflags').stdout().strip().split()
+libs = run_command(llvm_config, '--libs').stdout().strip().split()
+syslibs = run_command(llvm_config, '--system-libs').stdout().strip().split()
+incdir = run_command(llvm_config, '--includedir').stdout().strip().split()
+version = run_command(llvm_config, '--version').stdout().strip()
+version_major = version.split('.')[0].to_int()
+
+# Check LLVM version manually
+if version_major < 10 or version_major > 21
+    error('LLVM version', version, 'not supported.')
+endif
+
+sources = [
+]
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
+                      include_directories: ['include'] + [incdir],
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
2.52.0


