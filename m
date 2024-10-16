Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AE7D2A555
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 20:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1AMn-0005Da-CT; Wed, 16 Oct 2024 16:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1AMb-000500-M1; Wed, 16 Oct 2024 16:11:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1AMa-0000kF-1M; Wed, 16 Oct 2024 16:11:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9A4D098FA0;
 Wed, 16 Oct 2024 23:10:10 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 84359156380;
 Wed, 16 Oct 2024 23:10:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 46/49] hw/audio/hda: fix memory leak on audio setup
Date: Wed, 16 Oct 2024 23:10:05 +0300
Message-Id: <20241016201025.256294-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When SET_STREAM_FORMAT is called, we should clear the existing setup.

Factor out common function to close a stream.

Direct leak of 144 byte(s) in 3 object(s) allocated from:
    #0 0x7f91d38f7350 in calloc (/lib64/libasan.so.8+0xf7350) (BuildId: a4ad7eb954b390cf00f07fa10952988a41d9fc7a)
    #1 0x7f91d2ab7871 in g_malloc0 (/lib64/libglib-2.0.so.0+0x64871) (BuildId: 36b60dbd02e796145a982d0151ce37202ec05649)
    #2 0x562fa2f447ee in timer_new_full /home/elmarco/src/qemu/include/qemu/timer.h:538
    #3 0x562fa2f4486f in timer_new /home/elmarco/src/qemu/include/qemu/timer.h:559
    #4 0x562fa2f448a9 in timer_new_ns /home/elmarco/src/qemu/include/qemu/timer.h:577
    #5 0x562fa2f47955 in hda_audio_setup ../hw/audio/hda-codec.c:490
    #6 0x562fa2f4897e in hda_audio_command ../hw/audio/hda-codec.c:605

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20241008125028.1177932-3-marcandre.lureau@redhat.com>
(cherry picked from commit 6d6e23361fc732e4fe36a8bc5873b85f264ed53a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index ee3d0a7dec..4373565371 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -472,6 +472,24 @@ static void hda_audio_set_amp(HDAAudioStream *st)
     }
 }
 
+static void hda_close_stream(HDAAudioState *a, HDAAudioStream *st)
+{
+    if (st->node == NULL) {
+        return;
+    }
+    if (a->use_timer) {
+        timer_free(st->buft);
+        st->buft = NULL;
+    }
+    if (st->output) {
+        AUD_close_out(&a->card, st->voice.out);
+        st->voice.out = NULL;
+    } else {
+        AUD_close_in(&a->card, st->voice.in);
+        st->voice.in = NULL;
+    }
+}
+
 static void hda_audio_setup(HDAAudioStream *st)
 {
     bool use_timer = st->state->use_timer;
@@ -484,6 +502,7 @@ static void hda_audio_setup(HDAAudioStream *st)
     trace_hda_audio_format(st->node->name, st->as.nchannels,
                            fmt2name[st->as.fmt], st->as.freq);
 
+    hda_close_stream(st->state, st);
     if (st->output) {
         if (use_timer) {
             cb = hda_audio_output_cb;
@@ -741,23 +760,11 @@ static void hda_audio_init(HDACodecDevice *hda,
 static void hda_audio_exit(HDACodecDevice *hda)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
-    HDAAudioStream *st;
     int i;
 
     dprint(a, 1, "%s\n", __func__);
     for (i = 0; i < ARRAY_SIZE(a->st); i++) {
-        st = a->st + i;
-        if (st->node == NULL) {
-            continue;
-        }
-        if (a->use_timer) {
-            timer_free(st->buft);
-        }
-        if (st->output) {
-            AUD_close_out(&a->card, st->voice.out);
-        } else {
-            AUD_close_in(&a->card, st->voice.in);
-        }
+        hda_close_stream(a, a->st + i);
     }
     AUD_remove_card(&a->card);
 }
-- 
2.39.5


