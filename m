Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDE4F3026E
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 20:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1ruO-0006Ov-BB; Sun, 15 Mar 2026 16:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1ruG-0006NY-1O
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:50 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1ruA-0002Ly-D9
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 60593804C0;
 Sun, 15 Mar 2026 23:17:02 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:b49::1:d])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 1HRCj41ApeA0-iDor3Fr2; Sun, 15 Mar 2026 23:17:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773605821;
 bh=4YCWQjbfmJKd6yE++OeJuRhbUasuGUDO08QqlSsZ4Ik=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ZYnBpQGI/pPC5MkD65LbzonXcGdIze+iSYfTvGIwcvdfvAO23clTOpnF/84Yd7uTI
 CeQEy7+/5EA6gZO7Qt/f4BBPcVKU/HK+rIMN9QT32WbCbW3d01k84EjPE88kUFmtXM
 GLt4aDPvjGGAsTdCcPfqJGgKOfYw8pCzpJnmwJxg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
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
Subject: [PATCH v3 06/11] system/vl: remove audio and audiodev options when
 audio is disabled
Date: Mon, 16 Mar 2026 01:16:41 +0500
Message-Id: <20260315201646.96862-7-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315201646.96862-1-heifetz@yandex-team.com>
References: <20260315201646.96862-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
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

Remove the audio and audiodev runtime options when QEMU is configured
with `--disable-audio`.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 qemu-options.hx | 2 ++
 system/vl.c     | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 04ea2239296..29dc865820a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -788,6 +788,7 @@ SRST
 ERST
 
 
+#ifdef CONFIG_AUDIO
 DEF("audio", HAS_ARG, QEMU_OPTION_audio,
     "-audio [driver=]driver[,prop=value[,...]]\n"
     "                specifies default audio backend when `audiodev` is not\n"
@@ -1109,6 +1110,7 @@ SRST
         Write recorded audio into the specified file. Default is
         ``qemu.wav``.
 ERST
+#endif
 
 DEF("device", HAS_ARG, QEMU_OPTION_device,
     "-device driver[,prop=value[,...]]\n"
diff --git a/system/vl.c b/system/vl.c
index 38d7b849e0a..9ed0285c47a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2250,7 +2250,9 @@ static int global_init_func(void *opaque, QemuOpts *opts, Error **errp)
 static bool is_qemuopts_group(const char *group)
 {
     if (g_str_equal(group, "object") ||
+#ifdef CONFIG_AUDIO
         g_str_equal(group, "audiodev") ||
+#endif
         g_str_equal(group, "machine") ||
         g_str_equal(group, "smp-opts") ||
         g_str_equal(group, "boot-opts")) {
@@ -2267,6 +2269,7 @@ static void qemu_record_config_group(const char *group, QDict *dict,
         object_option_add_visitor(v);
         visit_free(v);
 
+#ifdef CONFIG_AUDIO
     } else if (g_str_equal(group, "audiodev")) {
         Audiodev *dev = NULL;
         Visitor *v = qobject_input_visitor_new_keyval(QOBJECT(dict));
@@ -2274,6 +2277,7 @@ static void qemu_record_config_group(const char *group, QDict *dict,
             audio_add_audiodev(dev);
         }
         visit_free(v);
+#endif
 
     } else if (g_str_equal(group, "machine")) {
         /*
@@ -3059,6 +3063,7 @@ void qemu_init(int argc, char **argv)
                 }
                 break;
 #endif
+#ifdef CONFIG_AUDIO
             case QEMU_OPTION_audiodev:
                 default_audio = 0;
                 audio_parse_option(optarg);
@@ -3099,6 +3104,7 @@ void qemu_init(int argc, char **argv)
                 }
                 break;
             }
+#endif
             case QEMU_OPTION_h:
                 help(0);
                 break;
-- 
2.34.1


