Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C525D5E368
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kUF-0006Ie-Ok; Sat, 09 Nov 2024 07:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kSr-0004Qm-Ra; Sat, 09 Nov 2024 07:21:19 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kSq-0005sa-1x; Sat, 09 Nov 2024 07:21:17 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 81193A1664;
 Sat,  9 Nov 2024 15:08:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4AEC1167FEA;
 Sat,  9 Nov 2024 15:09:05 +0300 (MSK)
Received: (nullmailer pid 3296308 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 58/58] Revert "hw/audio/hda: fix memory leak on audio
 setup"
Date: Sat,  9 Nov 2024 15:08:59 +0300
Message-Id: <20241109120901.3295995-58-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This reverts commit 6d03242a7e47815ed56687ecd13f683d8da3f2fe.

Let's revert this one for now.  It is a revert of a commit picked
to 9.1.x from master 6d6e23361fc732e4fe36a8bc5873b85f264ed53a,
restoring the status quo with audio for now.

See https://gitlab.com/qemu-project/qemu/-/issues/2639 for details.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 4373565371..ee3d0a7dec 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -472,24 +472,6 @@ static void hda_audio_set_amp(HDAAudioStream *st)
     }
 }
 
-static void hda_close_stream(HDAAudioState *a, HDAAudioStream *st)
-{
-    if (st->node == NULL) {
-        return;
-    }
-    if (a->use_timer) {
-        timer_free(st->buft);
-        st->buft = NULL;
-    }
-    if (st->output) {
-        AUD_close_out(&a->card, st->voice.out);
-        st->voice.out = NULL;
-    } else {
-        AUD_close_in(&a->card, st->voice.in);
-        st->voice.in = NULL;
-    }
-}
-
 static void hda_audio_setup(HDAAudioStream *st)
 {
     bool use_timer = st->state->use_timer;
@@ -502,7 +484,6 @@ static void hda_audio_setup(HDAAudioStream *st)
     trace_hda_audio_format(st->node->name, st->as.nchannels,
                            fmt2name[st->as.fmt], st->as.freq);
 
-    hda_close_stream(st->state, st);
     if (st->output) {
         if (use_timer) {
             cb = hda_audio_output_cb;
@@ -760,11 +741,23 @@ static void hda_audio_init(HDACodecDevice *hda,
 static void hda_audio_exit(HDACodecDevice *hda)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
+    HDAAudioStream *st;
     int i;
 
     dprint(a, 1, "%s\n", __func__);
     for (i = 0; i < ARRAY_SIZE(a->st); i++) {
-        hda_close_stream(a, a->st + i);
+        st = a->st + i;
+        if (st->node == NULL) {
+            continue;
+        }
+        if (a->use_timer) {
+            timer_free(st->buft);
+        }
+        if (st->output) {
+            AUD_close_out(&a->card, st->voice.out);
+        } else {
+            AUD_close_in(&a->card, st->voice.in);
+        }
     }
     AUD_remove_card(&a->card);
 }
-- 
2.39.5


