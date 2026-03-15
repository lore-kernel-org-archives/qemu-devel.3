Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93043F3026E
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 20:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1ru5-0006LV-HU; Sun, 15 Mar 2026 16:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1rty-0006Ka-2j
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:31 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1rtT-0002LC-9t
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 03869C015B;
 Sun, 15 Mar 2026 23:16:51 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:b49::1:d])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id nGRDD91AWKo0-yIvAEkCP; Sun, 15 Mar 2026 23:16:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773605810;
 bh=Yjyr/X5WOlNMkf+3wNCMMXzktFwXFLTQOlDO4YuexnY=;
 h=Cc:Message-Id:References:Date:In-Reply-To:Subject:To:From;
 b=KcYI4m9gqAc6dsoofsrU9JwunEFAbHN9OL4Y4V9/EnlkL07s/6HUl0aKqesXBmzw0
 GnTZzoZjw9xPcifl1T4E42hOIXUm/vX87w1ZxyG6X7HY04uHwjfPN0zi944coPGlHS
 6L3McF1N1mz08/aMEz6GBloSIPf3Vg2Y8a6im6BQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sergei Heifetz <heifetz@yandex-team.com>
Subject: [PATCH v3 01/11] audio: add `audio` build option for meson and Kconfig
Date: Mon, 16 Mar 2026 01:16:36 +0500
Message-Id: <20260315201646.96862-2-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315201646.96862-1-heifetz@yandex-team.com>
References: <20260315201646.96862-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Kconfig.host                  | 3 +++
 meson.build                   | 3 +++
 meson_options.txt             | 3 +++
 scripts/meson-buildoptions.sh | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/Kconfig.host b/Kconfig.host
index 933425c74b4..ec129aa4fc0 100644
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
index ed82247111e..d05533488f9 100644
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
@@ -3277,6 +3279,7 @@ disassemblers = {
 have_ivshmem = config_host_data.get('CONFIG_EVENTFD')
 host_kconfig = \
   (get_option('fuzzing') ? ['CONFIG_FUZZ=y'] : []) + \
+  (have_audio ? ['CONFIG_AUDIO=y'] : []) + \
   (have_tpm ? ['CONFIG_TPM=y'] : []) + \
   (pixman.found() ? ['CONFIG_PIXMAN=y'] : []) + \
   (spice.found() ? ['CONFIG_SPICE=y'] : []) + \
diff --git a/meson_options.txt b/meson_options.txt
index 31d5916cfce..d22386b4c15 100644
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
index ca5b113119a..05c55d2e70f 100644
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
@@ -243,6 +244,8 @@ _meson_option_parse() {
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


