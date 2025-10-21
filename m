Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6BACCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8L6-0008IS-E3; Tue, 21 Oct 2025 05:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8L3-00086c-UK
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8L0-0004TN-Kf
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=22a0insM+50eLf3LfN0tac94SvPSUaogq0VOtJx8xKo=;
 b=Ksx0+0P8B20Dbi6JwYbjs63UaDsHrHkRDz1WaUaj2u+Puezi74cP1DCNs/n5rm7Elqt+2V
 l1L3eu9wb+RessFGm2e7kclHsQTc11GAvVkQ/NkTzcgh352Rt+lvhjQknIqywWQYsyGAeB
 tUc2PCqvgqnTDU/jUAZPb1K7nwNnjIc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-PI9iVaOWNsybpeGgqUW_Qw-1; Tue,
 21 Oct 2025 05:07:16 -0400
X-MC-Unique: PI9iVaOWNsybpeGgqUW_Qw-1
X-Mimecast-MFC-AGG-ID: PI9iVaOWNsybpeGgqUW_Qw_1761037635
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B641319560AA; Tue, 21 Oct 2025 09:07:15 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6334A19560A2; Tue, 21 Oct 2025 09:07:13 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 42/43] audio: move capture API to own header
Date: Tue, 21 Oct 2025 13:03:13 +0400
Message-ID: <20251021090317.425409-43-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
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

For modularity/clarity reasons, move the capture API in a specific
header.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h            |  1 +
 include/qemu/audio-capture.h | 43 ++++++++++++++++++++++++++++++++++++
 include/qemu/audio.h         | 30 -------------------------
 ui/vnc.h                     |  2 +-
 4 files changed, 45 insertions(+), 31 deletions(-)
 create mode 100644 include/qemu/audio-capture.h

diff --git a/audio/audio_int.h b/audio/audio_int.h
index ef7a0de200..67da5ec6da 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -30,6 +30,7 @@
 /* #define RECIPROCAL */
 #endif
 #include "qemu/audio.h"
+#include "qemu/audio-capture.h"
 #include "mixeng.h"
 
 #ifdef CONFIG_GIO
diff --git a/include/qemu/audio-capture.h b/include/qemu/audio-capture.h
new file mode 100644
index 0000000000..7122afd385
--- /dev/null
+++ b/include/qemu/audio-capture.h
@@ -0,0 +1,43 @@
+/*
+ * QEMU Audio subsystem
+ *
+ * SPDX-License-Identifier: MIT
+ */
+#ifndef QEMU_AUDIO_CAPTURE_H
+#define QEMU_AUDIO_CAPTURE_H
+
+#include "audio.h"
+
+typedef struct CaptureVoiceOut CaptureVoiceOut;
+
+typedef enum {
+    AUD_CNOTIFY_ENABLE,
+    AUD_CNOTIFY_DISABLE
+} audcnotification_e;
+
+struct audio_capture_ops {
+    void (*notify) (void *opaque, audcnotification_e cmd);
+    void (*capture) (void *opaque, const void *buf, int size);
+    void (*destroy) (void *opaque);
+};
+
+struct capture_ops {
+    void (*info) (void *opaque);
+    void (*destroy) (void *opaque);
+};
+
+typedef struct CaptureState {
+    void *opaque;
+    struct capture_ops ops;
+    QLIST_ENTRY (CaptureState) entries;
+} CaptureState;
+
+CaptureVoiceOut *AUD_add_capture(
+    AudioBE *s,
+    struct audsettings *as,
+    struct audio_capture_ops *ops,
+    void *opaque
+    );
+void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque);
+
+#endif /* QEMU_AUDIO_CAPTURE_H */
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index 16c8877970..753e18c17c 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -41,30 +41,7 @@ typedef struct audsettings {
     int endianness;
 } audsettings;
 
-typedef enum {
-    AUD_CNOTIFY_ENABLE,
-    AUD_CNOTIFY_DISABLE
-} audcnotification_e;
-
-struct audio_capture_ops {
-    void (*notify) (void *opaque, audcnotification_e cmd);
-    void (*capture) (void *opaque, const void *buf, int size);
-    void (*destroy) (void *opaque);
-};
-
-struct capture_ops {
-    void (*info) (void *opaque);
-    void (*destroy) (void *opaque);
-};
-
-typedef struct CaptureState {
-    void *opaque;
-    struct capture_ops ops;
-    QLIST_ENTRY (CaptureState) entries;
-} CaptureState;
-
 typedef struct SWVoiceOut SWVoiceOut;
-typedef struct CaptureVoiceOut CaptureVoiceOut;
 typedef struct SWVoiceIn SWVoiceIn;
 
 typedef struct AudioBEClass AudioBEClass;
@@ -84,13 +61,6 @@ typedef struct QEMUAudioTimeStamp {
 
 bool AUD_register_fe (const char *name, AudioFE *fe, Error **errp);
 void AUD_unregister_fe (AudioFE *fe);
-CaptureVoiceOut *AUD_add_capture(
-    AudioBE *s,
-    struct audsettings *as,
-    struct audio_capture_ops *ops,
-    void *opaque
-    );
-void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque);
 
 SWVoiceOut *AUD_open_out (
     AudioFE *fe,
diff --git a/ui/vnc.h b/ui/vnc.h
index 8ebf9901bc..87c8cf11e4 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -31,7 +31,7 @@
 #include "qemu/thread.h"
 #include "ui/clipboard.h"
 #include "ui/console.h"
-#include "qemu/audio.h"
+#include "qemu/audio-capture.h"
 #include "qemu/bitmap.h"
 #include "crypto/tlssession.h"
 #include "qemu/buffer.h"
-- 
2.51.0


