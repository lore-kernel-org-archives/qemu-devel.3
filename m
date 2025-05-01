Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AB6C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 23:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcvr-0000ix-PH; Thu, 01 May 2025 19:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcvi-0000bd-DB
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:02:59 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcvg-0002QO-J3
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:02:58 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-85df99da233so145625339f.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 16:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746140574; x=1746745374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WnkKvB1b+3d0EeHxFwXj6FOWV545S5FRjaJFzkqSlRY=;
 b=mEZAGoZUUGqPYxFrVPteuGgEvOXAt0gAmyMuMmGK58ymTxJEvDrQd+OLXxHcSoOws9
 6kI2uG9mZpYWbSHcxOtrr8OMbquJ+Smoph4A0mTGhhle6BPRXFlh4cILU7q1b6FrDqOH
 w4ktgZ9ulEi/kbQG50/m/UuhgU69OEJpRJPPCDxuGtmYPpBNLS6weC5rPrg3k8s5oBth
 3Y2l45LLMeZqA4C5cffyXPbX5XhZkPIKJmmzxO96x38pZEgvj6W9KDsHsI85h8DGWO5+
 7jeYvF3fi+ipJRtMnjGmcy1fCqfQbTS3vPB0EghwTPNt+CLqb7XD7xbv16eBea0aUB6I
 mdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746140574; x=1746745374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WnkKvB1b+3d0EeHxFwXj6FOWV545S5FRjaJFzkqSlRY=;
 b=MPVcIA6gVeJdxTL+cFuifI/5HCxn1Fs5Vg5ugGiJm2UYysulcfCIjIlOXST/5ih7Tw
 6HoXBC0xPVcZ0uHMyK1ufEp8gXeN/XvYoKOYxjkH5r7i4RZv4mWZw43DCpfV8yZq6D8f
 6IWgLTtmgTnslv1DtTvg2lClCpBtJrzqfTbk05ubI531ezmZM1dRmuYjmbGWkyfLstnP
 9uSciH9hTMOzGIT1TBcW3C+iYGdrpXt9czAod1a6Bx68l1kQJYNNld3FCSBABH6k8LvJ
 6iN5jJO/y7yHE4R3AB7a44cUtqxQOamfv08yCuIGsSIn6So6Hles7Yg/BUzjJTwilCLT
 iS2w==
X-Gm-Message-State: AOJu0YxSXZcmHBepMQ8CuBr0+h+C/u0AR0NNemtvf6HWmTyj2EkW0xZt
 XgsIdSmf/irzMSuqQ6+jCKdqi8WFTH8UL13E2Cng5SLoDGMvCfciOiMlcY8fp5w8Uxr2vwHa08+
 E
X-Gm-Gg: ASbGncv90XXyOgoWJcpSKC3CZWWk6yvGGXw/262s0nqgOtRtxjkQFVT9myTeZkKlutK
 4bC2/og6TcAl4MNfS555zC0xz9mvNLj4fLCzBLL5A8B4UgvPWfHbR9/l+licEfw79oCGuPjr0Ll
 /ZReUHOXueVgI/158YDY57rCzjedhBWoNgc1sJRfSBn5149z+GL9RuuHia04IHOb+SVwAHBskCx
 TD49HZ8js0+1/KWffQO3nlfy6U5C/w1PVtmK5lZzVNh4TpLgF4UPM8pXEqNS8A92DJdeCQVNVxd
 zAC1CSGru958AkHGJWva8GVpELGaKZaprzJ+QSUdonpsyjFGXw0g/gW4Y0AZQvBRg/AFEn82U7Q
 XaTE1wwIDREnwLx742An18U6dvGvxC1I=
X-Google-Smtp-Source: AGHT+IEiwebta2jjbmeb5yedYFDh3IKB0uoU2Du0UF3wCHzQ38JonuurTlwyuw+/UGzJLdk571OfdA==
X-Received: by 2002:a05:6602:4743:b0:864:6a74:b56d with SMTP id
 ca18e2360f4ac-8669f9b6da2mr136803839f.5.1746140574195; 
 Thu, 01 May 2025 16:02:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2f45adsm29354639f.18.2025.05.01.16.02.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 16:02:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-rust@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 09/10] hw/audio/hda-codec: Remove HDAAudioState::use_timer
 field
Date: Fri,  2 May 2025 01:01:27 +0200
Message-ID: <20250501230129.2596-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501230129.2596-1-philmd@linaro.org>
References: <20250501230129.2596-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The HDAAudioState::use_timer boolean was only set in the
hw_compat_2_12[] array, via the 'use-timer=false' property.
We removed all machines using that array, lets remove that
property and all the code around it, like the compatibility
callbacks.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/hda-codec.c | 91 +++++++-------------------------------------
 1 file changed, 13 insertions(+), 78 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 66edad280f2..92e1fe65827 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -187,7 +187,6 @@ struct HDAAudioState {
     /* properties */
     uint32_t debug;
     bool     mixer;
-    bool     use_timer;
 };
 
 static inline uint32_t hda_bytes_per_second(HDAAudioStream *st)
@@ -366,58 +365,6 @@ static void hda_audio_output_cb(void *opaque, int avail)
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
-            len = AUD_read(st->voice.in, st->compat_buf + st->compat_bpos,
-                           sizeof(st->compat_buf) - st->compat_bpos);
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
-        len = AUD_write(st->voice.out, st->compat_buf + st->compat_bpos,
-                        sizeof(st->compat_buf) - st->compat_bpos);
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
@@ -428,16 +375,14 @@ static void hda_audio_set_running(HDAAudioStream *st, bool running)
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
         AUD_set_active_out(st->voice.out, st->running);
@@ -474,7 +419,6 @@ static void hda_audio_set_amp(HDAAudioStream *st)
 
 static void hda_audio_setup(HDAAudioStream *st)
 {
-    bool use_timer = st->state->use_timer;
     audio_callback_fn cb;
 
     if (st->node == NULL) {
@@ -485,21 +429,13 @@ static void hda_audio_setup(HDAAudioStream *st)
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
         st->voice.out = AUD_open_out(&st->state->card, st->voice.out,
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
         st->voice.in = AUD_open_in(&st->state->card, st->voice.in,
                                    st->node->name, st, cb, &st->as);
     }
@@ -805,7 +741,7 @@ static void hda_audio_reset(DeviceState *dev)
 static bool vmstate_hda_audio_stream_buf_needed(void *opaque)
 {
     HDAAudioStream *st = opaque;
-    return st->state && st->state->use_timer;
+    return st->state;
 }
 
 static const VMStateDescription vmstate_hda_audio_stream_buf = {
@@ -861,7 +797,6 @@ static const Property hda_audio_properties[] = {
     DEFINE_AUDIO_PROPERTIES(HDAAudioState, card),
     DEFINE_PROP_UINT32("debug", HDAAudioState, debug,   0),
     DEFINE_PROP_BOOL("mixer", HDAAudioState, mixer,  true),
-    DEFINE_PROP_BOOL("use-timer", HDAAudioState, use_timer,  true),
 };
 
 static void hda_audio_init_output(HDACodecDevice *hda, Error **errp)
-- 
2.47.1


