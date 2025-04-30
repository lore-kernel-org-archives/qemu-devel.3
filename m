Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA034C3ABAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACWH-0003eN-Jn; Wed, 30 Apr 2025 14:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uACWE-0003cp-Uy
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uACWD-0008KS-AL
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746039052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wzRwNk5ModfAEUGVCA6UcUK+5NSudVJb7DLA3CuInMo=;
 b=Q6dZQI5eqh1NU7E4eJtVci2OG4hpXJ79SFYZ3K84qeHEoBuq6KxptcU6y7keT+jLzwk1vz
 Z+1FFfe0Jv6v9V3b/DUb9KnR1xw6pX43sWDtdry5KpgKb6dNi80tHHX6IatskeeWbmh5uo
 0mRIPVqTEH0FO1j6RQkOmF4bVbd8hio=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-yTHhqlyoNqeizH0mV2yVsw-1; Wed,
 30 Apr 2025 14:50:49 -0400
X-MC-Unique: yTHhqlyoNqeizH0mV2yVsw-1
X-Mimecast-MFC-AGG-ID: yTHhqlyoNqeizH0mV2yVsw_1746039049
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2990B19560AA
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 18:50:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A83D419560A3; Wed, 30 Apr 2025 18:50:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 4/9] meson/configure: add 'valgrind' option & --{en,
 dis}able-valgrind flag
Date: Wed, 30 Apr 2025 20:50:30 +0200
Message-ID: <20250430185035.724919-5-thuth@redhat.com>
In-Reply-To: <20250430185035.724919-1-thuth@redhat.com>
References: <20250430185035.724919-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel P. Berrangé <berrange@redhat.com>

Currently valgrind debugging support for coroutine stacks is enabled
unconditionally when valgrind/valgrind.h is found. There is no way
to disable valgrind support if valgrind.h is present in the build env.

This is bad for distros, as an dependency far down the chain may cause
valgrind.h to become installed, inadvertently enabling QEMU's valgrind
debugging support. It also means if a distro wants valgrind support
there is no way to mandate this.

The solution is to add a 'valgrind' build feature to meson and thus
configure script.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250425121713.1913424-1-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build                   | 13 ++++++++++++-
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 8ae70dbe45a..ccd6c71577d 100644
--- a/meson.build
+++ b/meson.build
@@ -2618,7 +2618,17 @@ config_host_data.set('CONFIG_FSTRIM', qga_fstrim)
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
@@ -4905,6 +4915,7 @@ endif
 if host_os == 'darwin'
   summary_info += {'ParavirtualizedGraphics support': pvg}
 endif
+summary_info += {'valgrind':          valgrind}
 summary(summary_info, bool_yn: true, section: 'Dependencies')
 
 if host_arch == 'unknown'
diff --git a/meson_options.txt b/meson_options.txt
index 59d973bca00..0b4115e733a 100644
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
index 3e8e00852b2..d76a239130a 100644
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


