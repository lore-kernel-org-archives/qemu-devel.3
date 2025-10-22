Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB60CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 06:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSnb-0002ab-03; Wed, 22 Oct 2025 02:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSnX-0002Q2-DN
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSnR-0008DF-5V
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qO3UCF88r7wg/RiyvGpw9tTC25/Vsr3Q7lftN3svXyI=;
 b=C41vr/KUtcpuB39WZvH5NmQLnrC5WWtz5Lz5rclFwVFvBEJmQrv6cz44s4dZaodNLzvUVl
 TGkvIYATGvzYbzSNaDcnt17s1LnOIibryu/30nn9C0faxQlyQHuUC/RmVHL9jOLH9n3Zqu
 u74IrrjDnUUdD28DbkhfkcEaM55H8bg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-XEmfMvgYOMuwo66G1UAD7w-1; Wed,
 22 Oct 2025 02:58:04 -0400
X-MC-Unique: XEmfMvgYOMuwo66G1UAD7w-1
X-Mimecast-MFC-AGG-ID: XEmfMvgYOMuwo66G1UAD7w_1761116283
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 679B11800D87; Wed, 22 Oct 2025 06:58:03 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B79F3180044F; Wed, 22 Oct 2025 06:58:01 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 14/42] hw/audio: generalize audio_model.init()
Date: Wed, 22 Oct 2025 10:56:09 +0400
Message-ID: <20251022065640.1172785-15-marcandre.lureau@redhat.com>
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


