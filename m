Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41292606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKlS-00034h-TC; Fri, 23 Oct 2026 15:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlP-00033i-OC
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:17:15 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlO-00025Y-6H
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:17:15 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlK-00000007BFj-3Doy; Fri, 23 Oct 2026 21:17:10 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 08/13] audio: Split VM state change handler into start and
 stop parts
Date: Fri, 23 Oct 2026 21:16:19 +0200
Message-ID: <dbb3361d2ced27e0f7b002c44c1b9651788d2651.1792758436.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792758435.git.maciej.szmigiero@oracle.com>
References: <cover.1792758435.git.maciej.szmigiero@oracle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This will allow moving the VM stop part of this handler into
VM_CHANGE_STATE_PRI_HIGH.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 audio/audio-mixeng-be.c | 42 +++++++++++++++++++++++++++++++++--------
 audio/audio_int.h       |  3 ++-
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index f7d73d85608c..070c03c553e3 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -1381,10 +1381,8 @@ static bool audio_mixeng_backend_realize(AudioBackend *abe,
     return true;
 }
 
-static void audio_vm_change_state_handler (void *opaque, bool running,
-                                           RunState state)
+static void audio_vm_change_state(AudioMixengBackend *s, bool running)
 {
-    AudioMixengBackend *s = opaque;
     AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(s);
     HWVoiceOut *hwo = NULL;
     HWVoiceIn *hwi = NULL;
@@ -1403,6 +1401,26 @@ static void audio_vm_change_state_handler (void *opaque, bool running,
     audio_reset_timer (s);
 }
 
+static void audio_vm_change_state_start(void *opaque, bool running,
+                                       RunState state)
+{
+    if (!running) {
+        return;
+    }
+
+    audio_vm_change_state(opaque, true);
+}
+
+static void audio_vm_change_state_stop(void *opaque, bool running,
+                                      RunState state)
+{
+    if (running) {
+        return;
+    }
+
+    audio_vm_change_state(opaque, false);
+}
+
 static const VMStateDescription vmstate_audio;
 
 static const char *audio_mixeng_backend_get_id(AudioBackend *be)
@@ -1459,8 +1477,12 @@ static void audio_mixeng_backend_init(Object *obj)
     s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
     s->run_timer = g_timer_new();
 
-    s->vmse = qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
-    assert(s->vmse != NULL);
+    s->vmse_start = qemu_add_vm_change_state_handler(
+        audio_vm_change_state_start, s);
+    assert(s->vmse_start != NULL);
+    s->vmse_stop = qemu_add_vm_change_state_handler(
+        audio_vm_change_state_stop, s);
+    assert(s->vmse_stop != NULL);
 
     vmstate_register_any(NULL, &vmstate_audio, s);
 }
@@ -1511,9 +1533,13 @@ static void audio_mixeng_backend_finalize(Object *obj)
 
     g_clear_pointer(&s->run_timer, g_timer_destroy);
 
-    if (s->vmse) {
-        qemu_del_vm_change_state_handler(s->vmse);
-        s->vmse = NULL;
+    if (s->vmse_start) {
+        qemu_del_vm_change_state_handler(s->vmse_start);
+        s->vmse_start = NULL;
+    }
+    if (s->vmse_stop) {
+        qemu_del_vm_change_state_handler(s->vmse_stop);
+        s->vmse_stop = NULL;
     }
 
     vmstate_unregister(NULL, &vmstate_audio, s);
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 290cf373b49f..5bf6b8133e4a 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -229,7 +229,8 @@ struct AudioMixengBackend {
 
     bool timer_running;
     uint64_t timer_last;
-    VMChangeStateEntry *vmse;
+    VMChangeStateEntry *vmse_start;
+    VMChangeStateEntry *vmse_stop;
 };
 
 extern const struct mixeng_volume nominal_volume;

