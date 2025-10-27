Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EE8CCF9EF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 15:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOtY-0001uM-GK; Mon, 27 Oct 2025 11:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOt6-0001hy-TR
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:12:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOt2-0003al-Rq
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761577913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1TxxLbBB/nlbhAyoE+VGB060htJ/JfCS5v+EnXEJWcY=;
 b=QJbkcHnUDiX2ywh1rLk2LY4tyZvO/kZ8c2U537XLYeSuH0qv89fSDLLYGFhsXRrHh+qFBg
 tP2gXCrQkh1lL6K3ceesYX7m9WTio4I70x5M1+YtKoXwVeCMtvD67Jxfw14iAdG/gimdp8
 AAKhfxW+v1CuDJWcs/5X2LzvF/sMjTA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-uFlJT-OnPkuqMLLTGsG-kg-1; Mon,
 27 Oct 2025 11:11:49 -0400
X-MC-Unique: uFlJT-OnPkuqMLLTGsG-kg-1
X-Mimecast-MFC-AGG-ID: uFlJT-OnPkuqMLLTGsG-kg_1761577903
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40CAF1954225; Mon, 27 Oct 2025 15:11:43 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60D491800577; Mon, 27 Oct 2025 15:11:40 +0000 (UTC)
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
Subject: [PATCH v3 07/35] hw/audio: generalize audio_model.init()
Date: Mon, 27 Oct 2025 19:10:14 +0400
Message-ID: <20251027151045.2863176-8-marcandre.lureau@redhat.com>
In-Reply-To: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/audio/intel-hda.c     |  4 +---
 hw/audio/model.c         | 12 ++++--------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/hw/audio/model.h b/include/hw/audio/model.h
index aa237e9eb6..4d0be93042 100644
--- a/include/hw/audio/model.h
+++ b/include/hw/audio/model.h
@@ -3,7 +3,7 @@
 #define HW_AUDIO_MODEL_H
 
 void audio_register_model_with_cb(const char *name, const char *descr,
-                                  int (*init_pci)(PCIBus *bus, const char *audiodev));
+                                  void (*init_audio_model)(const char *audiodev));
 void audio_register_model(const char *name, const char *descr,
                           int isa, const char *typename);
 
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index c46b195b62..758e130c93 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1303,7 +1303,7 @@ static const TypeInfo hda_codec_device_type_info = {
  * create intel hda controller with codec attached to it,
  * so '-soundhw hda' works.
  */
-static int intel_hda_and_codec_init(PCIBus *bus, const char *audiodev)
+static void intel_hda_and_codec_init(const char *audiodev)
 {
     g_autoptr(QDict) props = qdict_new();
     DeviceState *intel_hda, *codec;
@@ -1317,8 +1317,6 @@ static int intel_hda_and_codec_init(PCIBus *bus, const char *audiodev)
     qdev_prop_set_string(codec, "audiodev", audiodev);
     qdev_realize_and_unref(codec, hdabus, &error_fatal);
     object_unref(intel_hda);
-
-    return 0;
 }
 
 static void intel_hda_register_types(void)
diff --git a/hw/audio/model.c b/hw/audio/model.c
index ddfefea706..7af0d960f5 100644
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
+    void (*init)(const char *audiodev);
 };
 
 static struct audio_model audio_models[9];
 static int audio_models_count;
 
 void audio_register_model_with_cb(const char *name, const char *descr,
-                                  int (*init_pci)(PCIBus *bus, const char *audiodev))
+                                  void (*init_audio_model)(const char *audiodev))
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


