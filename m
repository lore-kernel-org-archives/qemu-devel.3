Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98885C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 12:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Hzk-0001WZ-6R; Fri, 25 Apr 2025 08:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u8Hzj-0001Vv-2K
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:17:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u8Hzg-0003NH-VB
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745583443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nLbsOSxCfnBnqyc2MP2v57kXgWVuIY0wQ08d0NS1aeQ=;
 b=IMNzzEs9PbyJx0T4K3jq+nmOxrRnSZqF/EYy8LVIvxP3lyeKoibYW3tOXr2B7BeeZkVSw0
 EmfzoKxKG9DaoHFebDrdMnUJRirxOvf+b/d7LulyzQzleOji+8g97q+27Tgb1L7xOqAOvc
 QFzADDTvEglLIUtbciy/JR1x9VFuksI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-w0PztMbSM2euwWX42BUXfA-1; Fri,
 25 Apr 2025 08:17:18 -0400
X-MC-Unique: w0PztMbSM2euwWX42BUXfA-1
X-Mimecast-MFC-AGG-ID: w0PztMbSM2euwWX42BUXfA_1745583437
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11152180056F; Fri, 25 Apr 2025 12:17:17 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.69])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D09519560A3; Fri, 25 Apr 2025 12:17:14 +0000 (UTC)
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] meson/configure: add 'valgrind' option & --{en,
 dis}able-valgrind flag
Date: Fri, 25 Apr 2025 13:17:12 +0100
Message-ID: <20250425121713.1913424-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
From:  =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently valgrind debugging support for coroutine stacks is enabled
unconditionally when valgrind/valgrind.h is found. There is no way
to disable valgrind support if valgrind.h is present in the build env.

This is bad for distros, as an dependency far down the chain may cause
valgrind.h to become installed, inadvertantly enabling QEMU's valgrind
debugging support. It also means if a distro wants valgrind support
there is no way to mandate this.

The solution is to add a 'valgrind' build feature to meson and thus
configure script.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build                   | 13 ++++++++++++-
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index bcb9d39a38..c0534c68be 100644
--- a/meson.build
+++ b/meson.build
@@ -2616,7 +2616,17 @@ config_host_data.set('CONFIG_FSTRIM', qga_fstrim)
 # has_header
 config_host_data.set('CONFIG_EPOLL', cc.has_header('sys/epoll.h'))
 config_host_data.set('CONFIG_LINUX_MAGIC_H', cc.has_header('linux/magic.h'))
-config_host_data.set('CONFIG_VALGRIND_H', cc.has_header('valgrind/valgrind.h'))
+valgrind = false
+if get_option('valgrind').allowed()
+    if cc.has_header('valgrind/valgrind.h')
+        valgrind = true
+    else
+        if get_option('valgrind').enabled()
+            error('valgrind requested but valgrind.h not found')
+        endif
+    endif
+endif
+config_host_data.set('CONFIG_VALGRIND_H', valgrind)
 config_host_data.set('HAVE_BTRFS_H', cc.has_header('linux/btrfs.h'))
 config_host_data.set('HAVE_DRM_H', cc.has_header('libdrm/drm.h'))
 config_host_data.set('HAVE_OPENAT2_H', cc.has_header('linux/openat2.h'))
@@ -4914,6 +4924,7 @@ endif
 if host_os == 'darwin'
   summary_info += {'ParavirtualizedGraphics support': pvg}
 endif
+summary_info += {'valgrind':          valgrind}
 summary(summary_info, bool_yn: true, section: 'Dependencies')
 
 if host_arch == 'unknown'
diff --git a/meson_options.txt b/meson_options.txt
index 59d973bca0..0b4115e733 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -115,6 +115,8 @@ option('dbus_display', type: 'feature', value: 'auto',
        description: '-display dbus support')
 option('tpm', type : 'feature', value : 'auto',
        description: 'TPM support')
+option('valgrind', type : 'feature', value: 'auto',
+       description: 'valgrind debug support for coroutine stacks')
 
 # Do not enable it by default even for Mingw32, because it doesn't
 # work on Wine.
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 3e8e00852b..d76a239130 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -198,6 +198,7 @@ meson_options_help() {
   printf "%s\n" '  u2f             U2F emulation support'
   printf "%s\n" '  uadk            UADK Library support'
   printf "%s\n" '  usb-redir       libusbredir support'
+  printf "%s\n" '  valgrind        valgrind debug support for coroutine stacks'
   printf "%s\n" '  vde             vde network backend support'
   printf "%s\n" '  vdi             vdi image format support'
   printf "%s\n" '  vduse-blk-export'
@@ -526,6 +527,8 @@ _meson_option_parse() {
     --disable-ubsan) printf "%s" -Dubsan=false ;;
     --enable-usb-redir) printf "%s" -Dusb_redir=enabled ;;
     --disable-usb-redir) printf "%s" -Dusb_redir=disabled ;;
+    --enable-valgrind) printf "%s" -Dvalgrind=enabled ;;
+    --disable-valgrind) printf "%s" -Dvalgrind=disabled ;;
     --enable-vde) printf "%s" -Dvde=enabled ;;
     --disable-vde) printf "%s" -Dvde=disabled ;;
     --enable-vdi) printf "%s" -Dvdi=enabled ;;
-- 
2.49.0


