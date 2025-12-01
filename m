Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFDAD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ22X-0005mV-IQ; Mon, 01 Dec 2025 06:25:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ22P-0005Hs-6r
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:25:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ22M-00074H-Vv
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyvGm2cHLXm+YFmwtjHyM7NXD0+QEkLy407SaQIYwGQ=;
 b=MKYaAnBPAp9q0t7y06oTj8GQsAzeW6xx/s0oT5cMwKAfQzOUMiQ2DIPjOlYhJbKF8I0BLt
 ujCWIyr30bCDDU18fLnuiLMA5LpVezWYRR1Um5NQ5YdsLYLFQxasswTgHAV9Me0jr4AHEj
 /br5g4ePSC5pV41Bh2TenPAFo85YoL0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-aUkngF9NPFKIjMNOOEs4Fg-1; Mon,
 01 Dec 2025 06:25:43 -0500
X-MC-Unique: aUkngF9NPFKIjMNOOEs4Fg-1
X-Mimecast-MFC-AGG-ID: aUkngF9NPFKIjMNOOEs4Fg_1764588342
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FE591956053; Mon,  1 Dec 2025 11:25:42 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9304118004A3; Mon,  1 Dec 2025 11:25:40 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 22/24] audio-be: add some state trace
Date: Mon,  1 Dec 2025 15:23:03 +0400
Message-ID: <20251201112309.4163921-23-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio-be.c   | 9 +++++++--
 audio/trace-events | 4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/audio/audio-be.c b/audio/audio-be.c
index fde9c20e12..7b141566bc 100644
--- a/audio/audio-be.c
+++ b/audio/audio-be.c
@@ -1,9 +1,10 @@
 /* SPDX-License-Identifier: MIT */
 
 #include "qemu/osdep.h"
-#include "qemu/audio.h"
-#include "qemu/audio-capture.h"
 #include "qapi/error.h"
+#include "qemu/audio-capture.h"
+#include "qemu/audio.h"
+#include "trace-audio.h"
 
 bool audio_be_backend_check(AudioBackend **be, Error **errp)
 {
@@ -134,6 +135,8 @@ void audio_be_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    trace_audio_be_set_active_out(sw, on);
+
     if (!sw) {
         return;
     }
@@ -145,6 +148,8 @@ void audio_be_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    trace_audio_be_set_active_in(sw, on);
+
     if (!sw) {
         return;
     }
diff --git a/audio/trace-events b/audio/trace-events
index 7e3f1593c8..f7f639d960 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -26,6 +26,10 @@ pw_vol(const char *ret) "set volume: %s"
 pw_period(uint64_t quantum, uint32_t rate) "period =%" PRIu64 "/%u"
 pw_audio_init(void) "Initialize PipeWire context"
 
+# audio-be.c
+audio_be_set_active_in(void *sw, bool on) "sw=%p, on=%d"
+audio_be_set_active_out(void *sw, bool on) "sw=%p, on=%d"
+
 # audio.c
 audio_timer_start(int interval) "interval %d ms"
 audio_timer_stop(void) ""
-- 
2.51.1


