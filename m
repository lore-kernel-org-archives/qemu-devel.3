Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDF9F30937
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6L3-0004eE-B4; Thu, 05 Mar 2026 05:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6L0-0004Sf-Ir
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:53:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6Ky-0005l1-QD
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772708028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMwRFyszVHwmFHxuLsqKw06eCvsGENQbEI+Ki3As3Oo=;
 b=bXjQOhXLVOeu0TCOzJL65rB3akqKb5z1KBWdBMQsuCf98F5WRAjrlLOB8SNRMLwd3hKVX0
 4GHxQ9IIIZyhN5I9+V8oPHpaMEaprtTWHUnc3Pgvv/iAA4Q++r8QESbix0AohdHA8NtjXZ
 dOrh3JlsKQ8sKEdrzzbGLHktB/Refdk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-H8KRixL6N8SMxSY9T8_Ufg-1; Thu,
 05 Mar 2026 05:53:46 -0500
X-MC-Unique: H8KRixL6N8SMxSY9T8_Ufg-1
X-Mimecast-MFC-AGG-ID: H8KRixL6N8SMxSY9T8_Ufg_1772708025
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 545381955DE2; Thu,  5 Mar 2026 10:53:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9D5D3003E98; Thu,  5 Mar 2026 10:53:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/28] hw/audio/hda-codec: Remove HDAAudioState::use_timer field
Date: Thu,  5 Mar 2026 11:52:14 +0100
Message-ID: <20260305105215.302571-28-thuth@redhat.com>
In-Reply-To: <20260305105215.302571-1-thuth@redhat.com>
References: <20260305105215.302571-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The HDAAudioState::use_timer boolean was only set in the
hw_compat_2_12[] array, via the 'use-timer=false' property.
We removed all machines using that array, lets remove that
property and all the code around it, like the compatibility
callbacks.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501230129.2596-10-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
[thuth: Rebased the patch to current master branch, fixed conflicts]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/audio/hda-codec.c | 93 +++++++-------------------------------------
 1 file changed, 13 insertions(+), 80 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 984029a8db1..173fe56bea3 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -187,7 +187,6 @@ struct HDAAudioState {
     /* properties */
     uint32_t debug;
     bool     mixer;
-    bool     use_timer;
 };
 
 static inline uint32_t hda_bytes_per_second(HDAAudioStream *st)
@@ -368,60 +367,6 @@ static void hda_audio_output_cb(void *opaque, int avail)
     hda_timer_sync_adjust(st, (wpos - rpos) - (B_SIZE >> 1));
 }
 
-static void hda_audio_compat_input_cb(void *opaque, int avail)
-{
-    HDAAudioStream *st = opaque;
-    int recv = 0;
-    int len;
-    bool rc;
-
-    while (avail - recv >= sizeof(st->compat_buf)) {
-        if (st->compat_bpos != sizeof(st->compat_buf)) {
-            len = audio_be_read(st->state->audio_be, st->voice.in,
-                                st->compat_buf + st->compat_bpos,
-                                sizeof(st->compat_buf) - st->compat_bpos);
-            st->compat_bpos += len;
-            recv += len;
-            if (st->compat_bpos != sizeof(st->compat_buf)) {
-                break;
-            }
-        }
-        rc = hda_codec_xfer(&st->state->hda, st->stream, false,
-                            st->compat_buf, sizeof(st->compat_buf));
-        if (!rc) {
-            break;
-        }
-        st->compat_bpos = 0;
-    }
-}
-
-static void hda_audio_compat_output_cb(void *opaque, int avail)
-{
-    HDAAudioStream *st = opaque;
-    int sent = 0;
-    int len;
-    bool rc;
-
-    while (avail - sent >= sizeof(st->compat_buf)) {
-        if (st->compat_bpos == sizeof(st->compat_buf)) {
-            rc = hda_codec_xfer(&st->state->hda, st->stream, true,
-                                st->compat_buf, sizeof(st->compat_buf));
-            if (!rc) {
-                break;
-            }
-            st->compat_bpos = 0;
-        }
-        len = audio_be_write(st->state->audio_be, st->voice.out,
-                             st->compat_buf + st->compat_bpos,
-                             sizeof(st->compat_buf) - st->compat_bpos);
-        st->compat_bpos += len;
-        sent += len;
-        if (st->compat_bpos != sizeof(st->compat_buf)) {
-            break;
-        }
-    }
-}
-
 static void hda_audio_set_running(HDAAudioStream *st, bool running)
 {
     if (st->node == NULL) {
@@ -432,16 +377,14 @@ static void hda_audio_set_running(HDAAudioStream *st, bool running)
     }
     st->running = running;
     trace_hda_audio_running(st->node->name, st->stream, st->running);
-    if (st->state->use_timer) {
-        if (running) {
-            int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-            st->rpos = 0;
-            st->wpos = 0;
-            st->buft_start = now;
-            timer_mod_anticipate_ns(st->buft, now + HDA_TIMER_TICKS);
-        } else {
-            timer_del(st->buft);
-        }
+    if (running) {
+        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        st->rpos = 0;
+        st->wpos = 0;
+        st->buft_start = now;
+        timer_mod_anticipate_ns(st->buft, now + HDA_TIMER_TICKS);
+    } else {
+        timer_del(st->buft);
     }
     if (st->output) {
         audio_be_set_active_out(st->state->audio_be, st->voice.out, st->running);
@@ -480,7 +423,6 @@ static void hda_audio_set_amp(HDAAudioStream *st)
 
 static void hda_audio_setup(HDAAudioStream *st)
 {
-    bool use_timer = st->state->use_timer;
     audio_callback_fn cb;
 
     if (st->node == NULL) {
@@ -491,21 +433,13 @@ static void hda_audio_setup(HDAAudioStream *st)
                            fmt2name[st->as.fmt], st->as.freq);
 
     if (st->output) {
-        if (use_timer) {
-            cb = hda_audio_output_cb;
-            timer_del(st->buft);
-        } else {
-            cb = hda_audio_compat_output_cb;
-        }
+        cb = hda_audio_output_cb;
+        timer_del(st->buft);
         st->voice.out = audio_be_open_out(st->state->audio_be, st->voice.out,
                                      st->node->name, st, cb, &st->as);
     } else {
-        if (use_timer) {
-            cb = hda_audio_input_cb;
-            timer_del(st->buft);
-        } else {
-            cb = hda_audio_compat_input_cb;
-        }
+        cb = hda_audio_input_cb;
+        timer_del(st->buft);
         st->voice.in = audio_be_open_in(st->state->audio_be, st->voice.in,
                                    st->node->name, st, cb, &st->as);
     }
@@ -810,7 +744,7 @@ static void hda_audio_reset(DeviceState *dev)
 static bool vmstate_hda_audio_stream_buf_needed(void *opaque)
 {
     HDAAudioStream *st = opaque;
-    return st->state && st->state->use_timer;
+    return st->state;
 }
 
 static const VMStateDescription vmstate_hda_audio_stream_buf = {
@@ -866,7 +800,6 @@ static const Property hda_audio_properties[] = {
     DEFINE_AUDIO_PROPERTIES(HDAAudioState, audio_be),
     DEFINE_PROP_UINT32("debug", HDAAudioState, debug,   0),
     DEFINE_PROP_BOOL("mixer", HDAAudioState, mixer,  true),
-    DEFINE_PROP_BOOL("use-timer", HDAAudioState, use_timer,  true),
 };
 
 static void hda_audio_init_output(HDACodecDevice *hda, Error **errp)
-- 
2.53.0


