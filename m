Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AA8CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 15:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOtx-0002ST-4R; Mon, 27 Oct 2025 11:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOts-0002LV-QP
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:12:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOtn-0003ok-BF
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761577960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bTy2XfZWTNI82gqO1J9/Iw7lCvmW6GYnD3wFkHlzY5o=;
 b=M+Krkmmtzc6wiT6cWT8DNSHafuUB+5LJ3YKiGMAw8T4LCLObMRgg6tQtafxhwzbix8tVLI
 pp7dLGTtUTnRsUzrHlbPAqtf8KFLjLqxCEl42RSGD0yj99PRrG1b/1FmmdT9icfPOIPVah
 Gx3pukNyPu6FbPdZSQdE/+uogo/a8Ho=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-uCZb4dcaMdGk6389T5s3pA-1; Mon,
 27 Oct 2025 11:12:37 -0400
X-MC-Unique: uCZb4dcaMdGk6389T5s3pA-1
X-Mimecast-MFC-AGG-ID: uCZb4dcaMdGk6389T5s3pA_1761577953
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 214421956095; Mon, 27 Oct 2025 15:12:33 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A49830001A2; Mon, 27 Oct 2025 15:12:30 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 15/35] audio: simplify audio_driver_init()
Date: Mon, 27 Oct 2025 19:10:22 +0400
Message-ID: <20251027151045.2863176-16-marcandre.lureau@redhat.com>
In-Reply-To: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Catch and return from error early to avoid indentations and ease the
flow & return a bool for success value. All driver init() calls have
been checked to set errp on error.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.c | 48 ++++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 5bf4307fbd..087e1946e7 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1562,35 +1562,27 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
     return total;
 }
 
-static int audio_driver_init(AudioState *s, struct audio_driver *drv,
-                             Audiodev *dev, Error **errp)
+static bool audio_driver_init(AudioState *s, struct audio_driver *drv,
+                              Audiodev *dev, Error **errp)
 {
-    Error *local_err = NULL;
-
-    s->drv_opaque = drv->init(dev, &local_err);
-
-    if (s->drv_opaque) {
-        if (!drv->pcm_ops->get_buffer_in) {
-            drv->pcm_ops->get_buffer_in = audio_generic_get_buffer_in;
-            drv->pcm_ops->put_buffer_in = audio_generic_put_buffer_in;
-        }
-        if (!drv->pcm_ops->get_buffer_out) {
-            drv->pcm_ops->get_buffer_out = audio_generic_get_buffer_out;
-            drv->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
-        }
+    s->drv_opaque = drv->init(dev, errp);
+    if (!s->drv_opaque) {
+        return false;
+    }
 
-        audio_init_nb_voices_out(s, drv, 1);
-        audio_init_nb_voices_in(s, drv, 0);
-        s->drv = drv;
-        return 0;
-    } else {
-        if (local_err) {
-            error_propagate(errp, local_err);
-        } else {
-            error_setg(errp, "Could not init `%s' audio driver", drv->name);
-        }
-        return -1;
+    if (!drv->pcm_ops->get_buffer_in) {
+        drv->pcm_ops->get_buffer_in = audio_generic_get_buffer_in;
+        drv->pcm_ops->put_buffer_in = audio_generic_put_buffer_in;
     }
+    if (!drv->pcm_ops->get_buffer_out) {
+        drv->pcm_ops->get_buffer_out = audio_generic_get_buffer_out;
+        drv->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
+    }
+
+    audio_init_nb_voices_out(s, drv, 1);
+    audio_init_nb_voices_in(s, drv, 0);
+    s->drv = drv;
+    return true;
 }
 
 static void audio_vm_change_state_handler (void *opaque, bool running,
@@ -1748,7 +1740,7 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
         drvname = AudiodevDriver_str(dev->driver);
         driver = audio_driver_lookup(drvname);
         if (driver) {
-            done = !audio_driver_init(s, driver, dev, errp);
+            done = audio_driver_init(s, driver, dev, errp);
         } else {
             error_setg(errp, "Unknown audio driver `%s'", drvname);
         }
@@ -1768,7 +1760,7 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
             g_free(e);
             drvname = AudiodevDriver_str(dev->driver);
             driver = audio_driver_lookup(drvname);
-            if (!audio_driver_init(s, driver, dev, NULL)) {
+            if (audio_driver_init(s, driver, dev, NULL)) {
                 break;
             }
             qapi_free_Audiodev(dev);
-- 
2.51.0


