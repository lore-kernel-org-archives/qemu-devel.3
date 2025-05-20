Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3D7C54799
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLBl-000817-9w; Tue, 20 May 2025 07:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uHLBh-00080e-Ud
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:31:15 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uHLBf-00019Q-RY
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:31:13 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (unknown [172.201.77.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id A3508206789E;
 Tue, 20 May 2025 04:31:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3508206789E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747740670;
 bh=cUoMgvFdCgsMGM2JauNJvaGF6+KgwzbkP4Dx0XVdoiU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e0G/x4JRFPrHZ0ZGh1SJl53PeHHi+X5YW2IO43dfaQry3p8sdxptjirN9xgqDJdkW
 SW3FkkKqYnaWy7nyav7HtiluI1Jpa6nw89o7IvfhJJWaGM508OlPba9DW7P3LfmZyB
 Fp5s2xwT6TXC/QqbxIB8h3TmsmGq+vvzMCPPReJ0=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: magnuskulke@microsoft.com,
	qemu-devel@nongnu.org,
	liuwe@microsoft.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 01/25] accel: Add Meson and config support for MSHV
 accelerator
Date: Tue, 20 May 2025 13:29:54 +0200
Message-Id: <20250520113018.49569-2-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Introduce a Meson feature option and default-config entry to allow
building QEMU with MSHV (Microsoft Hypervisor) acceleration support.

This is the first step toward implementing an MSHV backend in QEMU.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/Kconfig                 |  3 +++
 meson.build                   | 16 ++++++++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 4 files changed, 24 insertions(+)

diff --git a/accel/Kconfig b/accel/Kconfig
index 4263cab722..a60f114923 100644
--- a/accel/Kconfig
+++ b/accel/Kconfig
@@ -13,6 +13,9 @@ config TCG
 config KVM
     bool
 
+config MSHV
+    bool
+
 config XEN
     bool
     select FSDEV_9P if VIRTFS
diff --git a/meson.build b/meson.build
index e819a7084c..a4269b816b 100644
--- a/meson.build
+++ b/meson.build
@@ -322,6 +322,13 @@ else
 endif
 accelerator_targets += { 'CONFIG_XEN': xen_targets }
 
+if cpu == 'x86_64'
+  mshv_targets = ['x86_64-softmmu']
+else
+  mshv_targets = []
+endif
+accelerator_targets += { 'CONFIG_MSHV': mshv_targets }
+
 if cpu == 'aarch64'
   accelerator_targets += {
     'CONFIG_HVF': ['aarch64-softmmu']
@@ -877,6 +884,14 @@ accelerators = []
 if get_option('kvm').allowed() and host_os == 'linux'
   accelerators += 'CONFIG_KVM'
 endif
+
+if get_option('mshv').allowed() and host_os == 'linux'
+  if get_option('mshv').enabled() and host_machine.cpu() != 'x86_64'
+    error('mshv accelerator requires x64_64 host')
+  endif
+  accelerators += 'CONFIG_MSHV'
+endif
+
 if get_option('whpx').allowed() and host_os == 'windows'
   if get_option('whpx').enabled() and host_machine.cpu() != 'x86_64'
     error('WHPX requires 64-bit host')
@@ -4747,6 +4762,7 @@ if have_system
   summary_info += {'HVF support':       config_all_accel.has_key('CONFIG_HVF')}
   summary_info += {'WHPX support':      config_all_accel.has_key('CONFIG_WHPX')}
   summary_info += {'NVMM support':      config_all_accel.has_key('CONFIG_NVMM')}
+  summary_info += {'MSHV support':       config_all_accel.has_key('CONFIG_MSHV')}
   summary_info += {'Xen support':       xen.found()}
   if xen.found()
     summary_info += {'xen ctrl version':  xen.version()}
diff --git a/meson_options.txt b/meson_options.txt
index cc66b46c63..e5671884b8 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -71,6 +71,8 @@ option('malloc', type : 'combo', choices : ['system', 'tcmalloc', 'jemalloc'],
 
 option('kvm', type: 'feature', value: 'auto',
        description: 'KVM acceleration support')
+option('mshv', type: 'feature', value: 'auto',
+       description: 'MSHV acceleration support')
 option('whpx', type: 'feature', value: 'auto',
        description: 'WHPX acceleration support')
 option('hvf', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 8a67a14e2e..cfd767a425 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -155,6 +155,7 @@ meson_options_help() {
   printf "%s\n" '  membarrier      membarrier system call (for Linux 4.14+ or Windows'
   printf "%s\n" '  modules         modules support (non Windows)'
   printf "%s\n" '  mpath           Multipath persistent reservation passthrough'
+  printf "%s\n" '  mshv            MSHV acceleration support'
   printf "%s\n" '  multiprocess    Out of process device emulation support'
   printf "%s\n" '  netmap          netmap network backend support'
   printf "%s\n" '  nettle          nettle cryptography support'
@@ -410,6 +411,8 @@ _meson_option_parse() {
     --disable-modules) printf "%s" -Dmodules=disabled ;;
     --enable-mpath) printf "%s" -Dmpath=enabled ;;
     --disable-mpath) printf "%s" -Dmpath=disabled ;;
+    --enable-mshv) printf "%s" -Dmshv=enabled ;;
+    --disable-mshv) printf "%s" -Dmshv=disabled ;;
     --enable-multiprocess) printf "%s" -Dmultiprocess=enabled ;;
     --disable-multiprocess) printf "%s" -Dmultiprocess=disabled ;;
     --enable-netmap) printf "%s" -Dnetmap=enabled ;;
-- 
2.34.1


