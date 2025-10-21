Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50D9CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8J8-0003Cz-H8; Tue, 21 Oct 2025 05:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8J7-00039s-2x
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8J5-0004E1-6C
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=juic9oRRoPnEyyLc+RZtMFFg/bc4UccwpaWA/hiu/p8=;
 b=MGjHMF8vBQiOE3IbNQgTKM3i+E7tVLkI0tX7p4jwBeZtc1saxaTf4bu+EcOYlNFHxit1Tf
 KBIDhvRxU3VnTH0oJ3rU4sn7HnlGAUFhrOhgbR8CMqanDCWS1kC9ZkDFVB+v08cOPcnHUM
 IDbDn8LivsntgCggPQL7o2Kz5GEC7Wk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-HF1QJhIMMOeI5yjXwE_R3w-1; Tue,
 21 Oct 2025 05:05:24 -0400
X-MC-Unique: HF1QJhIMMOeI5yjXwE_R3w-1
X-Mimecast-MFC-AGG-ID: HF1QJhIMMOeI5yjXwE_R3w_1761037523
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA253180060D; Tue, 21 Oct 2025 09:05:23 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66D1F30001BE; Tue, 21 Oct 2025 09:05:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 22/43] audio: simplify audio_driver_init()
Date: Tue, 21 Oct 2025 13:02:53 +0400
Message-ID: <20251021090317.425409-23-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index 3af5f2670b..bffb8cddb0 100644
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


