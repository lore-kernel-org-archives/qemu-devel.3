Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0941DF30282
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 20:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1ruN-0006Oh-JQ; Sun, 15 Mar 2026 16:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1ru8-0006Lr-BJ
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:41 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1ru1-0002M9-Bk
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C286F80637;
 Sun, 15 Mar 2026 23:17:05 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:b49::1:d])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2HRSIO1AAGk0-IkLxsxvz; Sun, 15 Mar 2026 23:17:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773605825;
 bh=aeH+/uECi/aL57+2Bx/cCwTgTppVnXy/AcoFFTVljyA=;
 h=Cc:Message-Id:References:Date:In-Reply-To:Subject:To:From;
 b=FUB0MARdzqqvW3hsh+WrXEy0YRLlyZ8tW/KCX9eXJDuWqvylhAIQWatZojn55FEhs
 nrU1wNwsB6Jlwd/iMR9jGM2JeCOWNE7+LBk9pzz30ujx1aVvMofGWO8DDT8wEpOn9+
 ccF5qXX2GRB0sKnJ+L4zQYP0C8HTDHueeDpzgudA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
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
Subject: [PATCH v3 07/11] ui/dbus: run without Audio interface when audio is
 disabled
Date: Mon, 16 Mar 2026 01:16:42 +0500
Message-Id: <20260315201646.96862-8-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315201646.96862-1-heifetz@yandex-team.com>
References: <20260315201646.96862-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
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

D-Bus display can be used even when QEMU is configured with
`--disable-audio`. In that case, audio interface will not be available
on `/org/qemu/Display1/Audio`.

(The current handling of the situation when audio is enabled but
no D-Bus-compatible audio backend is available is different and
hasn’t been changed.)

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 qapi/ui.json    | 2 +-
 qemu-options.hx | 4 ++++
 ui/dbus.c       | 8 ++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index e3da77632a8..62eb05c6091 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1385,7 +1385,7 @@
   'data'    : { '*rendernode' : 'str',
                 '*addr': 'str',
                 '*p2p': 'bool',
-                '*audiodev': 'str' } }
+                '*audiodev': { 'type': 'str', 'if': 'CONFIG_AUDIO' } } }
 
 ##
 # @DisplayGLMode:
diff --git a/qemu-options.hx b/qemu-options.hx
index 29dc865820a..20d15c0004f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2232,6 +2232,10 @@ SRST
         If no audio backend is specified and the dbus display backend is
         specified, the dbus audio backend is used by default.
 
+        (If audio is disabled at compile time via the ``--disable-audio`` option,
+        no audio backend is used, and none of the audio-related D-Bus interfaces
+        are exported.)
+
         The connection is registered with the "org.qemu" name (and queued when
         already owned).
 
diff --git a/ui/dbus.c b/ui/dbus.c
index 4f24215555a..99dac3e7feb 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -217,6 +217,7 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
+#ifdef CONFIG_AUDIO
     {
         AudioBackend *audio_be = audio_get_default_audio_be(NULL);
         if (audio_be && !audio_be_can_set_dbus_server(audio_be)) {
@@ -232,6 +233,7 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
             return;
         }
     }
+#endif
 
     consoles = g_array_new(FALSE, FALSE, sizeof(guint32));
     for (idx = 0;; idx++) {
@@ -370,6 +372,7 @@ set_dbus_addr(Object *o, const char *str, Error **errp)
     dd->dbus_addr = g_strdup(str);
 }
 
+#ifdef CONFIG_AUDIO
 static char *
 get_audiodev(Object *o, Error **errp)
 {
@@ -386,6 +389,7 @@ set_audiodev(Object *o, const char *str, Error **errp)
     g_free(dd->audiodev);
     dd->audiodev = g_strdup(str);
 }
+#endif
 
 
 static int
@@ -412,7 +416,9 @@ dbus_display_class_init(ObjectClass *oc, const void *data)
     ucc->complete = dbus_display_complete;
     object_class_property_add_bool(oc, "p2p", get_dbus_p2p, set_dbus_p2p);
     object_class_property_add_str(oc, "addr", get_dbus_addr, set_dbus_addr);
+#ifdef CONFIG_AUDIO
     object_class_property_add_str(oc, "audiodev", get_audiodev, set_audiodev);
+#endif
     object_class_property_add_enum(oc, "gl-mode",
                                    "DisplayGLMode", &DisplayGLMode_lookup,
                                    get_gl_mode, set_gl_mode);
@@ -502,7 +508,9 @@ dbus_init(DisplayState *ds, DisplayOptions *opts)
                           object_get_objects_root(),
                           "dbus-display", &error_fatal,
                           "addr", opts->u.dbus.addr ?: "",
+#ifdef CONFIG_AUDIO
                           "audiodev", opts->u.dbus.audiodev ?: "",
+#endif
                           "gl-mode", DisplayGLMode_str(mode),
                           "p2p", yes_no(opts->u.dbus.p2p),
                           NULL);
-- 
2.34.1


