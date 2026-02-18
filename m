Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CC9E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdUf-0003Y2-88; Wed, 18 Feb 2026 04:05:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdUR-0002pZ-DU
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:05:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdUO-000088-1a
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6GhijycHKeebI32O4PhP+DIZaklxb5TcF/ISqeLI/T0=;
 b=CNwNhlXhSnWQ+YBG4IZ+dLVG8YjYR6BUKhZ/0V7ravULhjS6wTXTcB74ANIKLdN3xBKzF9
 1Gjl4AWnz3ugsGjKicdwQB0YHJg4J8dyrfgXCpRdnt5Qq9p0ISu1e4roI+tZgM8Lrm2VzI
 mFOzEUdV/9So8eTu45BiooQODGXKa+0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-U2R6vF2aNrWmZRRoJ5ri2A-1; Wed,
 18 Feb 2026 04:04:52 -0500
X-MC-Unique: U2R6vF2aNrWmZRRoJ5ri2A-1
X-Mimecast-MFC-AGG-ID: U2R6vF2aNrWmZRRoJ5ri2A_1771405491
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 353341800352; Wed, 18 Feb 2026 09:04:51 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8121430001A5; Wed, 18 Feb 2026 09:04:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 26/85] audio: lookup "audio-" object types, and realize them
Date: Wed, 18 Feb 2026 10:02:26 +0100
Message-ID: <20260218090330.1476169-27-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
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
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Now "audio_driver" is a detail implementation of AudioMixengBackend and
not required to implement an AudioBackend.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/audio.h |  1 +
 audio/audio.c        | 40 ++++++++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index 474d761f0be..1eeead2a722 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -51,6 +51,7 @@ typedef struct AudioBackend {
 typedef struct AudioBackendClass {
     ObjectClass parent_class;
 
+    bool (*realize)(AudioBackend *be, Audiodev *dev, Error **errp);
     const char *(*get_id)(AudioBackend *be);
 #ifdef CONFIG_GIO
     bool (*set_dbus_server)(AudioBackend *be,
diff --git a/audio/audio.c b/audio/audio.c
index 5d0f5ad2145..72949fe27f5 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1562,24 +1562,16 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
     return total;
 }
 
-static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
+static bool audio_mixeng_backend_realize(AudioBackend *abe,
+                                         Audiodev *dev, Error **errp)
 {
-    const char *drvname = AudiodevDriver_str(dev->driver);
-    struct audio_driver *drv = audio_driver_lookup(drvname);
+    AudioMixengBackend *be = AUDIO_MIXENG_BACKEND(abe);
+    audio_driver *drv = AUDIO_MIXENG_BACKEND_GET_CLASS(be)->driver;
 
-    if (!drv) {
-        error_setg(errp, "Unknown audio driver `%s'", drvname);
-        qapi_free_Audiodev(dev);
-        return NULL;
-    }
-
-    AudioMixengBackend *be = AUDIO_MIXENG_BACKEND(object_new(TYPE_AUDIO_MIXENG_BACKEND));
     be->dev = dev;
-
     be->drv_opaque = drv->init(be->dev, errp);
     if (!be->drv_opaque) {
-        object_unref(OBJECT(be));
-        return NULL;
+        return false;
     }
 
     if (!drv->pcm_ops->get_buffer_in) {
@@ -1601,7 +1593,26 @@ static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
         be->period_ticks = be->dev->timer_period * (int64_t)SCALE_US;
     }
 
-    return AUDIO_BACKEND(be);
+    return true;
+}
+
+static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
+{
+    const char *drvname = AudiodevDriver_str(dev->driver);
+    g_autofree char *type = g_strconcat("audio-", drvname, NULL);
+    AudioBackend *be = AUDIO_BACKEND(object_new(type));
+
+    if (!be) {
+        error_setg(errp, "Unknown audio driver `%s'", drvname);
+        return NULL;
+    }
+
+    if (!AUDIO_BACKEND_GET_CLASS(be)->realize(be, dev, errp)) {
+        object_unref(OBJECT(be));
+        return NULL;
+    }
+
+    return be;
 }
 
 static void audio_vm_change_state_handler (void *opaque, bool running,
@@ -1644,6 +1655,7 @@ static void audio_mixeng_backend_class_init(ObjectClass *klass, const void *data
 {
     AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
 
+    be->realize = audio_mixeng_backend_realize;
     be->get_id = audio_mixeng_backend_get_id;
 }
 
-- 
2.53.0


