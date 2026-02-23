Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B526CEC112C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 20:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vucV7-0003Tu-6p; Mon, 23 Feb 2026 15:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vucUp-0003A7-3f
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:25:37 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vucUk-0002PB-NM
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:25:32 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9E9A98E415;
 Mon, 23 Feb 2026 23:25:27 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:12d::1:2c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id CPmvPN6Ap8c0-EWLOsRXS; 
 Mon, 23 Feb 2026 23:25:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771878327;
 bh=9ceJPNF+GibX+1lEopP1Na2t0yPChyucOxlsimiIu5s=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=jQytX73/oQ+PfgV9hyiPOrekaUXQpZmBYml9wpoTagxTmp6j50oDupdJrr55CmyqP
 vJBevK475SHWdbKumJnU5aYghce7l5wspqBTh2cbNMEDbUx4NSNpXYhrbYnKifGJaQ
 /BU7yNLdKZvHpIDtr30ZK7neLvnLUY4msxRsTsZs=
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
Subject: [PATCH v2 06/10] system/vl: remove audio and audiodev options when
 audio is disabled
Date: Tue, 24 Feb 2026 01:25:08 +0500
Message-Id: <20260223202512.1308205-7-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223202512.1308205-1-heifetz@yandex-team.com>
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
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

Remove the audio and audiodev runtime options when QEMU is configured
with `--disable-audio`.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 system/vl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/system/vl.c b/system/vl.c
index 3e341142a0..1034a4688f 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2248,7 +2248,9 @@ static int global_init_func(void *opaque, QemuOpts *opts, Error **errp)
 static bool is_qemuopts_group(const char *group)
 {
     if (g_str_equal(group, "object") ||
+#ifdef CONFIG_AUDIO
         g_str_equal(group, "audiodev") ||
+#endif
         g_str_equal(group, "machine") ||
         g_str_equal(group, "smp-opts") ||
         g_str_equal(group, "boot-opts")) {
@@ -2265,6 +2267,7 @@ static void qemu_record_config_group(const char *group, QDict *dict,
         object_option_add_visitor(v);
         visit_free(v);
 
+#ifdef CONFIG_AUDIO
     } else if (g_str_equal(group, "audiodev")) {
         Audiodev *dev = NULL;
         Visitor *v = qobject_input_visitor_new_keyval(QOBJECT(dict));
@@ -2272,6 +2275,7 @@ static void qemu_record_config_group(const char *group, QDict *dict,
             audio_add_audiodev(dev);
         }
         visit_free(v);
+#endif
 
     } else if (g_str_equal(group, "machine")) {
         /*
@@ -3057,6 +3061,7 @@ void qemu_init(int argc, char **argv)
                 }
                 break;
 #endif
+#ifdef CONFIG_AUDIO
             case QEMU_OPTION_audiodev:
                 default_audio = 0;
                 audio_parse_option(optarg);
@@ -3097,6 +3102,7 @@ void qemu_init(int argc, char **argv)
                 }
                 break;
             }
+#endif
             case QEMU_OPTION_h:
                 help(0);
                 break;
-- 
2.34.1


