Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2611EC1134
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 20:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vucV7-0003Xp-WA; Mon, 23 Feb 2026 15:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vucUp-0003AB-4T
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:25:39 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vucUi-0002O8-Qb
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:25:32 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6A9E08E3E3;
 Mon, 23 Feb 2026 23:25:18 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:12d::1:2c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id CPmvPN6Ap8c0-oG0UwHQT; 
 Mon, 23 Feb 2026 23:25:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771878317;
 bh=BPR2Ft+Be4GyY3W7td6w3kfNXO3EhQGNxOQakq3iWlw=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=kGtIGTnTGu5FTYdv9FYw4jPA64Zc+O7jWlf7IoToJuTUl7T72fqec21pCex4nGETl
 NVxgAgqSXmyHkU41xGDBYtfDtgC3Fl9CyMw+LpR3B4iQqYJnxlejoQT/cHGnEE9bYp
 oNAU1n4C0yCEYKyN8VKuNL0vomB8boNcKO4Tlk6I=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 01/10] audio: add `audio` build option for meson and Kconfig
Date: Tue, 24 Feb 2026 01:25:03 +0500
Message-Id: <20260223202512.1308205-2-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223202512.1308205-1-heifetz@yandex-team.com>
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patch adds the `audio` option to meson_options.txt. It is
propagated into Kconfig as AUDIO. It is enabled by default.
The corresponding `--disable-audio` and `--enable-audio` options
for `configure` are also added.

For now, this option does nothing. In subsequent patches, it will
gradually disable audio in different places. The final goal is to stop
building sources from `audio/` and `hw/audio/` and other audio-related
files (except for some stubs). Note that this intent is different from
`-audio none`, which mutes audio but still compiles the audio subsystem.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 Kconfig.host                  | 3 +++
 meson.build                   | 3 +++
 meson_options.txt             | 3 +++
 scripts/meson-buildoptions.sh | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/Kconfig.host b/Kconfig.host
index 933425c74b..ec129aa4fc 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -29,6 +29,9 @@ config IVSHMEM
 config TPM
     bool
 
+config AUDIO
+    bool
+
 config FDT
     bool
 
diff --git a/meson.build b/meson.build
index 414c8ea7e2..fdb2578447 100644
--- a/meson.build
+++ b/meson.build
@@ -68,6 +68,8 @@ foreach target : target_dirs
 endforeach
 have_user = have_linux_user or have_bsd_user
 
+have_audio = get_option('audio').disable_auto_if(not have_system).allowed()
+
 ############
 # Programs #
 ############
@@ -3250,6 +3252,7 @@ disassemblers = {
 have_ivshmem = config_host_data.get('CONFIG_EVENTFD')
 host_kconfig = \
   (get_option('fuzzing') ? ['CONFIG_FUZZ=y'] : []) + \
+  (have_audio ? ['CONFIG_AUDIO=y'] : []) + \
   (have_tpm ? ['CONFIG_TPM=y'] : []) + \
   (pixman.found() ? ['CONFIG_PIXMAN=y'] : []) + \
   (spice.found() ? ['CONFIG_SPICE=y'] : []) + \
diff --git a/meson_options.txt b/meson_options.txt
index 2836156257..d7c94e6d6d 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -71,6 +71,9 @@ option('malloc_trim', type : 'feature', value : 'auto',
 option('malloc', type : 'combo', choices : ['system', 'tcmalloc', 'jemalloc'],
        value: 'system', description: 'choose memory allocator to use')
 
+option('audio', type: 'feature', value: 'auto',
+       description: 'Audio support')
+
 option('kvm', type: 'feature', value: 'auto',
        description: 'KVM acceleration support')
 option('mshv', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index e8edc5252a..642f06efc5 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -96,6 +96,7 @@ meson_options_help() {
   printf "%s\n" '  af-xdp          AF_XDP network backend support'
   printf "%s\n" '  alsa            ALSA sound support'
   printf "%s\n" '  attr            attr/xattr support'
+  printf "%s\n" '  audio           Audio support'
   printf "%s\n" '  auth-pam        PAM access control'
   printf "%s\n" '  blkio           libblkio block device driver'
   printf "%s\n" '  bochs           bochs image format support'
@@ -242,6 +243,8 @@ _meson_option_parse() {
     --disable-asan) printf "%s" -Dasan=false ;;
     --enable-attr) printf "%s" -Dattr=enabled ;;
     --disable-attr) printf "%s" -Dattr=disabled ;;
+    --enable-audio) printf "%s" -Daudio=enabled ;;
+    --disable-audio) printf "%s" -Daudio=disabled ;;
     --audio-drv-list=*) quote_sh "-Daudio_drv_list=$2" ;;
     --enable-auth-pam) printf "%s" -Dauth_pam=enabled ;;
     --disable-auth-pam) printf "%s" -Dauth_pam=disabled ;;
-- 
2.34.1


