Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD90BCCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8J1-0002lB-I8; Tue, 21 Oct 2025 05:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Ip-0002L5-Kr
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8In-0004C2-Po
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qO3UCF88r7wg/RiyvGpw9tTC25/Vsr3Q7lftN3svXyI=;
 b=hINhEH3b46VVeZu9Sp8gtJmGWRjCyT75hwKP0EgE/XnauJYUwglA1xaD9b+RO49+js3uiI
 Mjrn3ujnNkaW+Nn9jQk205N/Fm4M+l2VxGNLGo2VWYCmjnO1KiYZP2Imv8iq8hBzLr20ol
 2sAJ2EebARB7cGfNpHaj0QnyyW/krOs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-ZdxRAixOOWaefEhj_z2Mwg-1; Tue,
 21 Oct 2025 05:04:42 -0400
X-MC-Unique: ZdxRAixOOWaefEhj_z2Mwg-1
X-Mimecast-MFC-AGG-ID: ZdxRAixOOWaefEhj_z2Mwg_1761037481
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56713195608F; Tue, 21 Oct 2025 09:04:41 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E78831955F22; Tue, 21 Oct 2025 09:04:39 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 14/43] hw/audio: generalize audio_model.init()
Date: Tue, 21 Oct 2025 13:02:45 +0400
Message-ID: <20251021090317.425409-15-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

It is no longer PCI bus only.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/audio/model.h |  2 +-
 hw/audio/intel-hda.c     |  2 +-
 hw/audio/model.c         | 12 ++++--------
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/hw/audio/model.h b/include/hw/audio/model.h
index 27ae7dcc31..55d6ac7f6e 100644
--- a/include/hw/audio/model.h
+++ b/include/hw/audio/model.h
@@ -2,7 +2,7 @@
 #define HW_AUDIO_MODEL_H
 
 void audio_register_model_with_cb(const char *name, const char *descr,
-                                  int (*init_pci)(PCIBus *bus, const char *audiodev));
+                                  int (*init_audio_model)(const char *audiodev));
 void audio_register_model(const char *name, const char *descr,
                           int isa, const char *typename);
 
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 14bcf1257d..0d35afa4ab 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1305,7 +1305,7 @@ static const TypeInfo hda_codec_device_type_info = {
  * create intel hda controller with codec attached to it,
  * so '-soundhw hda' works.
  */
-static int intel_hda_and_codec_init(PCIBus *bus, const char *audiodev)
+static int intel_hda_and_codec_init(const char *audiodev)
 {
     g_autoptr(QDict) props = qdict_new();
     DeviceState *intel_hda, *codec;
diff --git a/hw/audio/model.c b/hw/audio/model.c
index 668349c69d..4f6a234159 100644
--- a/hw/audio/model.c
+++ b/hw/audio/model.c
@@ -24,14 +24,11 @@
 #include "qemu/osdep.h"
 #include "hw/qdev-core.h"
 #include "monitor/qdev.h"
-#include "qemu/option.h"
-#include "qemu/help_option.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qom/object.h"
 #include "hw/qdev-properties.h"
 #include "hw/isa/isa.h"
-#include "hw/pci/pci.h"
 #include "hw/audio/model.h"
 
 struct audio_model {
@@ -39,20 +36,20 @@ struct audio_model {
     const char *descr;
     const char *typename;
     int isa;
-    int (*init_pci) (PCIBus *bus, const char *audiodev);
+    int (*init)(const char *audiodev);
 };
 
 static struct audio_model audio_models[9];
 static int audio_models_count;
 
 void audio_register_model_with_cb(const char *name, const char *descr,
-                                  int (*init_pci)(PCIBus *bus, const char *audiodev))
+                                  int (*init_audio_model)(const char *audiodev))
 {
     assert(audio_models_count < ARRAY_SIZE(audio_models) - 1);
     audio_models[audio_models_count].name = name;
     audio_models[audio_models_count].descr = descr;
     audio_models[audio_models_count].isa = 0;
-    audio_models[audio_models_count].init_pci = init_pci;
+    audio_models[audio_models_count].init = init_audio_model;
     audio_models_count++;
 }
 
@@ -124,7 +121,6 @@ void audio_model_init(void)
         qdev_realize_and_unref(dev, bus, &error_fatal);
     } else {
         assert(!c->isa);
-        PCIBus *pci_bus = (PCIBus *) object_resolve_path_type("", TYPE_PCI_BUS, NULL);
-        c->init_pci(pci_bus, audiodev_id);
+        c->init(audiodev_id);
     }
 }
-- 
2.51.0


