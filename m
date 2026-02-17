Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD03E83856
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 05:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsDcr-0002cP-9y; Tue, 17 Feb 2026 00:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsDcm-0002aa-OD
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:27:52 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsDci-0006cD-Mf
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:27:52 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:8aa5:0:640:e6ae:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 561578850B;
 Tue, 17 Feb 2026 08:27:43 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:b54::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id eRRjrX2Ak0U0-ia88aOt0; 
 Tue, 17 Feb 2026 08:27:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771306062;
 bh=ls0bepPgan6SXopc401jXzwdANvz23800COR8K8r76A=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=hhznRAKEvTF2eXcPYZ5ytvDNDsU0GQX08HQt6UnUfvC6CkuM4tRjvf3dfYJU9Bmn6
 CvzPgqcRPVgNdojefbqL/8BZ2fm/F90cQ3SpiGl8JqVeGnekK9TUL/d4lptRp7Pe+h
 1b7H78E//OOcCtFXeg+82869BxSpbQgqm8yyE+gk=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 1/8] audio: add `audio` build option for meson and Kconfig
Date: Tue, 17 Feb 2026 10:27:33 +0500
Message-Id: <20260217052740.114117-2-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217052740.114117-1-heifetz@yandex-team.com>
References: <20260217052740.114117-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 Kconfig.host      | 3 +++
 configure         | 4 ++++
 meson.build       | 3 +++
 meson_options.txt | 3 +++
 4 files changed, 13 insertions(+)

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
 
diff --git a/configure b/configure
index 4b61fd3bbf..ff391c79a1 100755
--- a/configure
+++ b/configure
@@ -762,6 +762,10 @@ for opt do
   ;;
   --wasm64-32bit-address-limit)
   ;;
+  --enable-audio) meson_option_add -Daudio=true
+  ;;
+  --disable-audio) meson_option_add -Daudio=false
+  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
diff --git a/meson.build b/meson.build
index 8c6c0a9a32..69aa7cd189 100644
--- a/meson.build
+++ b/meson.build
@@ -68,6 +68,8 @@ foreach target : target_dirs
 endforeach
 have_user = have_linux_user or have_bsd_user
 
+audio_enabled = get_option('audio')
+
 ############
 # Programs #
 ############
@@ -3244,6 +3246,7 @@ disassemblers = {
 have_ivshmem = config_host_data.get('CONFIG_EVENTFD')
 host_kconfig = \
   (get_option('fuzzing') ? ['CONFIG_FUZZ=y'] : []) + \
+  (audio_enabled ? ['CONFIG_AUDIO=y'] : []) + \
   (have_tpm ? ['CONFIG_TPM=y'] : []) + \
   (pixman.found() ? ['CONFIG_PIXMAN=y'] : []) + \
   (spice.found() ? ['CONFIG_SPICE=y'] : []) + \
diff --git a/meson_options.txt b/meson_options.txt
index 2836156257..172ed10ead 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -71,6 +71,9 @@ option('malloc_trim', type : 'feature', value : 'auto',
 option('malloc', type : 'combo', choices : ['system', 'tcmalloc', 'jemalloc'],
        value: 'system', description: 'choose memory allocator to use')
 
+option('audio', type: 'boolean', value: true,
+       description: 'Audio support')
+
 option('kvm', type: 'feature', value: 'auto',
        description: 'KVM acceleration support')
 option('mshv', type: 'feature', value: 'auto',
-- 
2.34.1


