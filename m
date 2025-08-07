Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775A1CA0EC0
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 14:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk1nA-0006N6-Kv; Thu, 07 Aug 2025 10:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uk1n8-0006L7-RD
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:40:26 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uk1n7-0000u0-45
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:40:26 -0400
Received: from localhost.localdomain (unknown [167.220.208.72])
 by linux.microsoft.com (Postfix) with ESMTPSA id 61720201BC67;
 Thu,  7 Aug 2025 07:40:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61720201BC67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1754577623;
 bh=eiqHqTtQYb4hBWCdUXTzyoddRbEICBU93TfkiFGEmx8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FqdcpL9cZOhTN8Oq78p8wvOKj6If2Ry9ti/b+byVGq/lSVMShbjcCaT86hP+7jPf/
 o/YxcOpZVW9mY6KE3SC8rlelcioc6LIWZcZNbc5Z866CQGv/AKBg7ib3y583JAn5rq
 ZFs6vRERPRtNJ5WKDoMBHEIjo7rZfTeaTvknde60=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/26] accel: Add Meson and config support for MSHV
 accelerator
Date: Thu,  7 Aug 2025 16:39:26 +0200
Message-Id: <20250807143951.1154713-2-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
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
 meson.build                   | 10 ++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 4 files changed, 18 insertions(+)

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
index e53cd5b413..b6e70714f1 100644
--- a/meson.build
+++ b/meson.build
@@ -334,6 +334,7 @@ elif cpu == 'x86_64'
     'CONFIG_HVF': ['x86_64-softmmu'],
     'CONFIG_NVMM': ['i386-softmmu', 'x86_64-softmmu'],
     'CONFIG_WHPX': ['i386-softmmu', 'x86_64-softmmu'],
+    'CONFIG_MSHV': ['x86_64-softmmu'],
   }
 endif
 
@@ -884,6 +885,14 @@ accelerators = []
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
@@ -4818,6 +4827,7 @@ if have_system
   summary_info += {'HVF support':       config_all_accel.has_key('CONFIG_HVF')}
   summary_info += {'WHPX support':      config_all_accel.has_key('CONFIG_WHPX')}
   summary_info += {'NVMM support':      config_all_accel.has_key('CONFIG_NVMM')}
+  summary_info += {'MSHV support':       config_all_accel.has_key('CONFIG_MSHV')}
   summary_info += {'Xen support':       xen.found()}
   if xen.found()
     summary_info += {'xen ctrl version':  xen.version()}
diff --git a/meson_options.txt b/meson_options.txt
index dd33530750..2a6e8dd950 100644
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
index d559e260ed..a3bc3d195e 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -157,6 +157,7 @@ meson_options_help() {
   printf "%s\n" '  membarrier      membarrier system call (for Linux 4.14+ or Windows'
   printf "%s\n" '  modules         modules support (non Windows)'
   printf "%s\n" '  mpath           Multipath persistent reservation passthrough'
+  printf "%s\n" '  mshv            MSHV acceleration support'
   printf "%s\n" '  multiprocess    Out of process device emulation support'
   printf "%s\n" '  netmap          netmap network backend support'
   printf "%s\n" '  nettle          nettle cryptography support'
@@ -413,6 +414,8 @@ _meson_option_parse() {
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


