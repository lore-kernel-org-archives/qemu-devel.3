Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88752CEF16B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 12:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy9gQ-0007SR-LL; Tue, 08 Oct 2024 08:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sy9fz-0007Ok-D6
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 08:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sy9fw-0002Ny-Ae
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 08:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728391850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JP1eYPg0YiK7mc6UkNhPnHTjeDAwCliMj+67c2894P8=;
 b=fnFMffnpVnkUrBwFM/dvlZhmkofn4ukqfBJItZVF+peFbMhnJzKttx6Cp6ENURZoIdPI6K
 08t2VZZK3HF+y0IJYZdwoJoAdd+RwTNjF8YkTpMHi0a0D7ZJxf4lWlxYM326LlGKXg9vQm
 rw6COUyCXgK2djSLK87/SSoukqe2JKQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-ie7izBkBOlmEcxIQjnPUyw-1; Tue,
 08 Oct 2024 08:50:45 -0400
X-MC-Unique: ie7izBkBOlmEcxIQjnPUyw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E6761954224; Tue,  8 Oct 2024 12:50:43 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3AFA19560B2; Tue,  8 Oct 2024 12:50:41 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, belmouss@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 02/19] hw/audio/hda: fix memory leak on audio setup
Date: Tue,  8 Oct 2024 16:50:11 +0400
Message-ID: <20241008125028.1177932-3-marcandre.lureau@redhat.com>
In-Reply-To: <20241008125028.1177932-1-marcandre.lureau@redhat.com>
References: <20241008125028.1177932-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 hw/audio/hda-codec.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 74c0292284..bc661504cf 100644
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
2.47.0


