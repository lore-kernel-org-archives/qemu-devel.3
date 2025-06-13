Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E662C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 13:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ4fi-0001hK-LE; Fri, 13 Jun 2025 09:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uQ4fL-0001bW-RB
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:42:03 -0400
Received: from smtp-out-60.livemail.co.uk ([213.171.216.60]
 helo=dkim.livemail.co.uk)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uQ4fJ-0006CX-Q2
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:41:55 -0400
Received: from smtp.livemail.co.uk (unknown [10.44.132.81])
 by dkim.livemail.co.uk (Postfix) with ESMTPS id A5CB5401DA;
 Fri, 13 Jun 2025 14:41:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=randomman.co.uk;
 s=livemail2; t=1749822109;
 bh=ab+3xdR1UyLAFwZmY/oF9kz1Xi2vy1PNKbZA5izqDbo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZtL55F4o2c5l+u83HJ4LaUcKyRzWTMMJj6tAd4TWV2DuvrFtQoyveMRHUfFRMDbZS
 NgpbrCDixQf1aw5j7dt/7lfjamTlJoVj2LVcXDFA6v8aJR/LhUC4cQP/wpUlEnLYd+
 v9AVx9T3dzX0R8lqTwKG8U19whEx0TZ1QUNStmh0=
Received: from localhost.localdomain (unknown [145.40.191.116])
 (Authenticated sender: roy.hopkins@randomman.co.uk)
 by smtp.livemail.co.uk (Postfix) with ESMTPSA id 1E325400DC;
 Fri, 13 Jun 2025 14:41:44 +0100 (BST)
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v8 01/16] meson: Add optional dependency on IGVM library
Date: Fri, 13 Jun 2025 14:41:17 +0100
Message-ID: <18ca3c22494971f9bbd892592e97d2be8b31dd03.1749820158.git.roy.hopkins@randomman.co.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
References: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.171.216.60;
 envelope-from=roy.hopkins@randomman.co.uk; helo=dkim.livemail.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The IGVM library allows Independent Guest Virtual Machine files to be
parsed and processed. IGVM files are used to configure guest memory
layout, initial processor state and other configuration pertaining to
secure virtual machines.

This adds the --enable-igvm configure option, enabled by default, which
attempts to locate and link against the IGVM library via pkgconfig and
sets CONFIG_IGVM if found.

The library is added to the system_ss target in backends/meson.build
where the IGVM parsing will be performed by the ConfidentialGuestSupport
object.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 backends/meson.build          | 3 +++
 meson.build                   | 8 ++++++++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 4 files changed, 16 insertions(+)

diff --git a/backends/meson.build b/backends/meson.build
index 9b88d22685..ac0fac7845 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -34,6 +34,9 @@ if have_vhost_user_crypto
 endif
 system_ss.add(when: gio, if_true: files('dbus-vmstate.c'))
 system_ss.add(when: 'CONFIG_SGX', if_true: files('hostmem-epc.c'))
+if igvm.found()
+  system_ss.add(igvm)
+endif
 
 system_ss.add(when: 'CONFIG_SPDM_SOCKET', if_true: files('spdm-socket.c'))
 
diff --git a/meson.build b/meson.build
index 34729c2a3d..c4b620be42 100644
--- a/meson.build
+++ b/meson.build
@@ -1427,6 +1427,12 @@ if host_os == 'linux' and (have_system or have_tools)
                        method: 'pkg-config',
                        required: get_option('libudev'))
 endif
+igvm = not_found
+if not get_option('igvm').auto() or have_system
+  igvm = dependency('igvm', version: '>= 0.3.0',
+                    method: 'pkg-config',
+                    required: get_option('igvm'))
+endif
 
 mpathlibs = [libudev]
 mpathpersist = not_found
@@ -2604,6 +2610,7 @@ config_host_data.set('CONFIG_CFI', get_option('cfi'))
 config_host_data.set('CONFIG_SELINUX', selinux.found())
 config_host_data.set('CONFIG_XEN_BACKEND', xen.found())
 config_host_data.set('CONFIG_LIBDW', libdw.found())
+config_host_data.set('CONFIG_IGVM', igvm.found())
 if xen.found()
   # protect from xen.version() having less than three components
   xen_version = xen.version().split('.') + ['0', '0']
@@ -5004,6 +5011,7 @@ summary_info += {'seccomp support':   seccomp}
 summary_info += {'GlusterFS support': glusterfs}
 summary_info += {'hv-balloon support': hv_balloon}
 summary_info += {'TPM support':       have_tpm}
+summary_info += {'IGVM support':      igvm}
 summary_info += {'libssh support':    libssh}
 summary_info += {'lzo support':       lzo}
 summary_info += {'snappy support':    snappy}
diff --git a/meson_options.txt b/meson_options.txt
index a442be2995..1e429311a2 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -117,6 +117,8 @@ option('tpm', type : 'feature', value : 'auto',
        description: 'TPM support')
 option('valgrind', type : 'feature', value: 'auto',
        description: 'valgrind debug support for coroutine stacks')
+option('igvm', type: 'feature', value: 'auto',
+       description: 'Independent Guest Virtual Machine (IGVM) file support')
 
 # Do not enable it by default even for Mingw32, because it doesn't
 # work on Wine.
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 73e0770f42..7851540445 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -130,6 +130,7 @@ meson_options_help() {
   printf "%s\n" '  hv-balloon      hv-balloon driver (requires Glib 2.68+ GTree API)'
   printf "%s\n" '  hvf             HVF acceleration support'
   printf "%s\n" '  iconv           Font glyph conversion support'
+  printf "%s\n" '  igvm            IGVM file support'
   printf "%s\n" '  jack            JACK sound support'
   printf "%s\n" '  keyring         Linux keyring support'
   printf "%s\n" '  kvm             KVM acceleration support'
@@ -346,6 +347,8 @@ _meson_option_parse() {
     --iasl=*) quote_sh "-Diasl=$2" ;;
     --enable-iconv) printf "%s" -Diconv=enabled ;;
     --disable-iconv) printf "%s" -Diconv=disabled ;;
+    --enable-igvm) printf "%s" -Digvm=enabled ;;
+    --disable-igvm) printf "%s" -Digvm=disabled ;;
     --includedir=*) quote_sh "-Dincludedir=$2" ;;
     --enable-install-blobs) printf "%s" -Dinstall_blobs=true ;;
     --disable-install-blobs) printf "%s" -Dinstall_blobs=false ;;
-- 
2.43.0


