Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9CFE98E10
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSb3-0003kF-Oa; Mon, 23 Feb 2026 04:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSZr-00020n-Dg
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:50:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSZp-0007JE-OP
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tXlUokVOk05xaO6XwoA2MppkyQAliaUQDcaoGYgnaL4=;
 b=U9OGDpl396WY5I8a5SeQj3iClcchCy1CoFoUkb3gkcCf7pdnXWW8nj1v8MUINpVHZUToBu
 lvM+8GzHsymZc1lEuyYa8RSlNFqwvKpb3R1UzshchGQXNKdsEMvBmI3+rKrh5FXvR9Yjzu
 YwAxxqZJYy13oHXCAt6g76q0PZuUUSY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-DmcmWgUWMzqx0X315FRCdA-1; Mon,
 23 Feb 2026 04:50:02 -0500
X-MC-Unique: DmcmWgUWMzqx0X315FRCdA-1
X-Mimecast-MFC-AGG-ID: DmcmWgUWMzqx0X315FRCdA_1771840201
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C19F1956070; Mon, 23 Feb 2026 09:50:01 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D08251955D85; Mon, 23 Feb 2026 09:50:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PULL v2 63/85] audio/jack: replace custom logging with report & trace
Date: Mon, 23 Feb 2026 10:46:21 +0100
Message-ID: <20260223094649.2005118-64-marcandre.lureau@redhat.com>
In-Reply-To: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
References: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace the custom audio logging infrastructure with standard QEMU
error reporting and tracing.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/jackaudio.c  | 29 +++++++++++++----------------
 audio/trace-events |  9 +++++++++
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index e415e94e6e6..a2f725a3232 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -26,11 +26,11 @@
 #include "qemu/module.h"
 #include "qemu/atomic.h"
 #include "qemu/main-loop.h"
+#include "qemu/error-report.h"
 #include "qemu/audio.h"
 #include "qom/object.h"
-
-#define AUDIO_CAP "jack"
 #include "audio_int.h"
+#include "trace.h"
 
 #include <jack/jack.h>
 #include <jack/thread.h>
@@ -343,7 +343,7 @@ static void qjack_client_recover(QJackClient *c)
 
         /* if enabled then attempt to recover */
         if (c->enabled) {
-            dolog("attempting to reconnect to server\n");
+            trace_jack_client_recover();
             qjack_client_init(c);
         }
     }
@@ -399,10 +399,10 @@ static void qjack_client_connect_ports(QJackClient *c)
         }
 
         if (c->out) {
-            dolog("connect %s -> %s\n", p, ports[i]);
+            trace_jack_connect(p, ports[i]);
             jack_connect(c->client, p, ports[i]);
         } else {
-            dolog("connect %s -> %s\n", ports[i], p);
+            trace_jack_connect(ports[i], p);
             jack_connect(c->client, ports[i], p);
         }
     }
@@ -441,9 +441,9 @@ static int qjack_client_init(QJackClient *c)
       c->opt->server_name);
 
     if (c->client == NULL) {
-        dolog("jack_client_open failed: status = 0x%2.0x\n", status);
+        error_report("jack: jack_client_open failed: status = 0x%2.0x", status);
         if (status & JackServerFailed) {
-            dolog("unable to connect to JACK server\n");
+            error_report("jack: unable to connect to JACK server");
         }
         return -1;
     }
@@ -451,12 +451,11 @@ static int qjack_client_init(QJackClient *c)
     c->freq = jack_get_sample_rate(c->client);
 
     if (status & JackServerStarted) {
-        dolog("JACK server started\n");
+        trace_jack_server_started();
     }
 
     if (status & JackNameNotUnique) {
-        dolog("JACK unique name assigned %s\n",
-          jack_get_client_name(c->client));
+        trace_jack_unique_name(jack_get_client_name(c->client));
     }
 
     /* Allocate working buffer for process callback */
@@ -536,8 +535,7 @@ static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as)
     };
     audio_pcm_init_info(&hw->info, &os);
 
-    dolog("JACK output configured for %dHz (%d samples)\n",
-        jo->c.freq, jo->c.buffersize);
+    trace_jack_out_init(jo->c.freq, jo->c.buffersize);
 
     return 0;
 }
@@ -572,8 +570,7 @@ static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as)
     };
     audio_pcm_init_info(&hw->info, &is);
 
-    dolog("JACK input configured for %dHz (%d samples)\n",
-        ji->c.freq, ji->c.buffersize);
+    trace_jack_in_init(ji->c.freq, ji->c.buffersize);
 
     return 0;
 }
@@ -654,12 +651,12 @@ static int qjack_thread_creator(jack_native_thread_t *thread,
 
 static void qjack_error(const char *msg)
 {
-    dolog("E: %s\n", msg);
+    error_report("jack: %s", msg);
 }
 
 static void qjack_info(const char *msg)
 {
-    dolog("I: %s\n", msg);
+    trace_jack_info(msg);
 }
 
 static void audio_jack_class_init(ObjectClass *klass, const void *data)
diff --git a/audio/trace-events b/audio/trace-events
index b2f29666700..79744456cec 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -28,6 +28,15 @@ dsound_clear_sample(void *p1, uint32_t blen1, uint32_t len1, void *p2, uint32_t
 dsound_wave_format(uint16_t wFormatTag, uint16_t nChannels, uint32_t nSamplesPerSec, uint32_t nAvgBytesPerSec, uint16_t nBlockAlign, uint16_t wBitsPerSample, uint16_t cbSize) "wFormatTag=%u, nChannels=%u, nSamplesPerSec=%u, nAvgBytesPerSec=%u, nBlockAlign=%u, wBitsPerSample=%u, cbSize=%u"
 dsound_buffer_bytes(uint32_t caps_bytes, uint32_t desc_bytes) "caps_bytes=%u, desc_bytes=%u"
 
+# jackaudio.c
+jack_client_recover(void) "attempting to reconnect to server"
+jack_connect(const char *src, const char *dst) "connect %s -> %s"
+jack_server_started(void) "server started"
+jack_unique_name(const char *name) "unique name assigned %s"
+jack_out_init(uint32_t freq, int buffersize) "output configured for %uHz (%d samples)"
+jack_in_init(uint32_t freq, int buffersize) "input configured for %uHz (%d samples)"
+jack_info(const char *msg) "%s"
+
 # pwaudio.c
 pw_state_changed(int nodeid, const char *s) "node id: %d stream state: %s"
 pw_read(int32_t avail, uint32_t index, size_t len) "avail=%d index=%u len=%zu"
-- 
2.53.0


