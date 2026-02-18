Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64075E9A03E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdXI-000268-0W; Wed, 18 Feb 2026 04:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdWw-0000zl-8p
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:07:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdWr-0002SC-0L
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3OAaXAmQUOzrQJUP1azsyJhaEVjpS4H5leIXvLWgao=;
 b=dbAdmN81UpqG2EcVMhU9MdFQJkv+qmYldG80qSOwyICd9dBc5wiRbJNMdE3GjdUc3iPNyV
 oRC9bXb4WT/KG2ZVSIyZ8Obm+L9HcckKFVd6SjaBMKNvcE3IJ850LyjGFYtSIFCG6wOQ/t
 0E0xlw30Fvs2TDymgBWL2sfuSZprV4w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-4LaR5YZ7POaRzCTt5H-SMg-1; Wed,
 18 Feb 2026 04:07:16 -0500
X-MC-Unique: 4LaR5YZ7POaRzCTt5H-SMg-1
X-Mimecast-MFC-AGG-ID: 4LaR5YZ7POaRzCTt5H-SMg_1771405635
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8D0218003F6; Wed, 18 Feb 2026 09:07:15 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0069C180034A; Wed, 18 Feb 2026 09:07:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 74/85] audio: replace ldebug with trace events
Date: Wed, 18 Feb 2026 10:03:14 +0100
Message-ID: <20260218090330.1476169-75-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
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
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace the ldebug macro calls with proper trace events:
- audio_get_avail: traces available samples in capture stream
- audio_open_out/audio_open_in: traces stream open parameters

This provides structured tracing that can be enabled at runtime
without requiring debug builds.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_template.h  | 7 +++++--
 audio/audio-mixeng-be.c | 6 +-----
 audio/trace-events      | 7 +++++++
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 3da91a4782c..c47a2f202f0 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -507,8 +507,11 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
     k = AUDIO_MIXENG_BACKEND_GET_CLASS(s);
     pdo = glue(audio_get_pdo_, TYPE)(s->dev);
 
-    ldebug ("open %s, freq %d, nchannels %d, fmt %d\n",
-            name, as->freq, as->nchannels, as->fmt);
+#ifdef DAC
+    trace_audio_open_out(name, as->freq, as->nchannels, as->fmt);
+#else
+    trace_audio_open_in(name, as->freq, as->nchannels, as->fmt);
+#endif
 
     if (audio_bug(__func__, audio_validate_settings(as))) {
         audio_print_settings (as);
diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index d05202aabae..84e4d136de3 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -881,11 +881,7 @@ static size_t audio_get_avail(SWVoiceIn *sw)
         return 0;
     }
 
-    ldebug (
-        "%s: get_avail live %zu frontend frames %u\n",
-        SW_NAME (sw),
-        live, st_rate_frames_out(sw->rate, live)
-        );
+    trace_audio_get_avail(SW_NAME(sw), live, st_rate_frames_out(sw->rate, live));
 
     return live;
 }
diff --git a/audio/trace-events b/audio/trace-events
index f33be2dd8e3..4749c54fc04 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -58,3 +58,10 @@ audio_be_set_active_out(void *sw, bool on) "sw=%p, on=%d"
 audio_timer_start(int interval) "interval %d ms"
 audio_timer_stop(void) ""
 audio_timer_delayed(int interval) "interval %d ms"
+
+# audio-mixeng-be.c
+audio_get_avail(const char *name, size_t live, uint32_t frontend_frames) "%s: get_avail live %zu frontend frames %u"
+
+# audio_template.h
+audio_open_out(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"
+audio_open_in(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"
-- 
2.53.0


