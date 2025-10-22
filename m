Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B41CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 06:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSnZ-0002ZC-Sv; Wed, 22 Oct 2025 02:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSnW-0002NO-Qo
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSnU-0008Dw-KY
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yg4NLhxMkcVDvibW3oLI5+ujcThDlytrlMAaLa+r/XQ=;
 b=gezLAT+ztKxAOGqGilo9FqV3PhkEEauRo7PyAufZJ72vvFa2TiTpID4DnpKMHN8EsG+pne
 hYhwijS4Z4QT2H4al+Oxd4xsGdgZA1L0HyI0KPvsc7ihKa/R0WJG1zuzHrvjwlMW6T22Hm
 sD3KRoKG93kfbwug6XSMtc01FNdLOxw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-ZWnonhvPOxm_xkL5EcMdBQ-1; Wed,
 22 Oct 2025 02:58:10 -0400
X-MC-Unique: ZWnonhvPOxm_xkL5EcMdBQ-1
X-Mimecast-MFC-AGG-ID: ZWnonhvPOxm_xkL5EcMdBQ_1761116289
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB760195420F; Wed, 22 Oct 2025 06:58:08 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 845D6180045B; Wed, 22 Oct 2025 06:58:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 15/42] hw/audio: drop audio_model.isa
Date: Wed, 22 Oct 2025 10:56:10 +0400
Message-ID: <20251022065640.1172785-16-marcandre.lureau@redhat.com>
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
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

That's no longer necessary, the code is bus-agnostic.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/audio/model.h  | 2 +-
 hw/audio/ac97.c           | 2 +-
 hw/audio/adlib.c          | 2 +-
 hw/audio/cs4231a.c        | 2 +-
 hw/audio/es1370.c         | 2 +-
 hw/audio/gus.c            | 2 +-
 hw/audio/model.c          | 7 +------
 hw/audio/sb16.c           | 2 +-
 hw/audio/virtio-snd-pci.c | 2 +-
 9 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/hw/audio/model.h b/include/hw/audio/model.h
index 55d6ac7f6e..ebe456c22f 100644
--- a/include/hw/audio/model.h
+++ b/include/hw/audio/model.h
@@ -4,7 +4,7 @@
 void audio_register_model_with_cb(const char *name, const char *descr,
                                   int (*init_audio_model)(const char *audiodev));
 void audio_register_model(const char *name, const char *descr,
-                          int isa, const char *typename);
+                          const char *typename);
 
 void audio_model_init(void);
 void audio_print_available_models(void);
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 2e1be5089e..3d3c667e86 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1360,7 +1360,7 @@ static const TypeInfo ac97_info = {
 static void ac97_register_types(void)
 {
     type_register_static(&ac97_info);
-    audio_register_model("ac97", "Intel 82801AA AC97 Audio", 0, TYPE_AC97);
+    audio_register_model("ac97", "Intel 82801AA AC97 Audio", TYPE_AC97);
 }
 
 type_init(ac97_register_types)
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index a7c2efd87c..0bc0359ae6 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -323,7 +323,7 @@ static const TypeInfo adlib_info = {
 static void adlib_register_types (void)
 {
     type_register_static (&adlib_info);
-    audio_register_model("adlib", ADLIB_DESC, 1, TYPE_ADLIB);
+    audio_register_model("adlib", ADLIB_DESC, TYPE_ADLIB);
 }
 
 type_init (adlib_register_types)
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 1f7e0a33c0..18db8da324 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -723,7 +723,7 @@ static const TypeInfo cs4231a_info = {
 static void cs4231a_register_types (void)
 {
     type_register_static (&cs4231a_info);
-    audio_register_model("cs4231a", "CS4231A", 1, TYPE_CS4231A);
+    audio_register_model("cs4231a", "CS4231A", TYPE_CS4231A);
 }
 
 type_init (cs4231a_register_types)
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 913c9022f6..8cb47589c3 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -905,7 +905,7 @@ static const TypeInfo es1370_info = {
 static void es1370_register_types (void)
 {
     type_register_static (&es1370_info);
-    audio_register_model("es1370", "ENSONIQ AudioPCI ES1370", 0, TYPE_ES1370);
+    audio_register_model("es1370", "ENSONIQ AudioPCI ES1370", TYPE_ES1370);
 }
 
 type_init (es1370_register_types)
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index ac9332ea3d..16785ce226 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -319,7 +319,7 @@ static const TypeInfo gus_info = {
 static void gus_register_types (void)
 {
     type_register_static (&gus_info);
-    audio_register_model("gus", "Gravis Ultrasound GF1", 1, TYPE_GUS);
+    audio_register_model("gus", "Gravis Ultrasound GF1", TYPE_GUS);
 }
 
 type_init (gus_register_types)
diff --git a/hw/audio/model.c b/hw/audio/model.c
index 4f6a234159..924a41e0ac 100644
--- a/hw/audio/model.c
+++ b/hw/audio/model.c
@@ -28,14 +28,12 @@
 #include "qapi/error.h"
 #include "qom/object.h"
 #include "hw/qdev-properties.h"
-#include "hw/isa/isa.h"
 #include "hw/audio/model.h"
 
 struct audio_model {
     const char *name;
     const char *descr;
     const char *typename;
-    int isa;
     int (*init)(const char *audiodev);
 };
 
@@ -48,18 +46,16 @@ void audio_register_model_with_cb(const char *name, const char *descr,
     assert(audio_models_count < ARRAY_SIZE(audio_models) - 1);
     audio_models[audio_models_count].name = name;
     audio_models[audio_models_count].descr = descr;
-    audio_models[audio_models_count].isa = 0;
     audio_models[audio_models_count].init = init_audio_model;
     audio_models_count++;
 }
 
 void audio_register_model(const char *name, const char *descr,
-                          int isa, const char *typename)
+                          const char *typename)
 {
     assert(audio_models_count < ARRAY_SIZE(audio_models) - 1);
     audio_models[audio_models_count].name = name;
     audio_models[audio_models_count].descr = descr;
-    audio_models[audio_models_count].isa = isa;
     audio_models[audio_models_count].typename = typename;
     audio_models_count++;
 }
@@ -120,7 +116,6 @@ void audio_model_init(void)
         qdev_prop_set_string(dev, "audiodev", audiodev_id);
         qdev_realize_and_unref(dev, bus, &error_fatal);
     } else {
-        assert(!c->isa);
         c->init(audiodev_id);
     }
 }
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 0d9fa74108..cd7e813d05 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1471,7 +1471,7 @@ static const TypeInfo sb16_info = {
 static void sb16_register_types (void)
 {
     type_register_static (&sb16_info);
-    audio_register_model("sb16", "Creative Sound Blaster 16", 1, TYPE_SB16);
+    audio_register_model("sb16", "Creative Sound Blaster 16", TYPE_SB16);
 }
 
 type_init (sb16_register_types)
diff --git a/hw/audio/virtio-snd-pci.c b/hw/audio/virtio-snd-pci.c
index b78eaff851..230581ed63 100644
--- a/hw/audio/virtio-snd-pci.c
+++ b/hw/audio/virtio-snd-pci.c
@@ -74,7 +74,7 @@ static const VirtioPCIDeviceTypeInfo virtio_snd_pci_info = {
 static void virtio_snd_pci_register(void)
 {
     virtio_pci_types_register(&virtio_snd_pci_info);
-    audio_register_model("virtio", "Virtio Sound", 0, TYPE_VIRTIO_SND_PCI);
+    audio_register_model("virtio", "Virtio Sound", TYPE_VIRTIO_SND_PCI);
 }
 
 type_init(virtio_snd_pci_register);
-- 
2.51.0


