Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1913E7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfZ-0008F0-HV; Mon, 16 Feb 2026 06:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdG-0007kz-RP
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdF-0008SJ-2V
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jh01TnR1WKr53dWUDRQLe2CRWCIsdVlOiG3qS34GaeQ=;
 b=Qr8v+z9+5DPTyaREJwtAcA3sEYWk9i6iZL0fWPlOjnBHIyiunWs4U5bVIz5YjR/oBY7khI
 QP99EGyVj65r97oBJBaXIKz3DcMFPJ7qCVZsoS7AFdxjLPRfLUwCw4DEZY48VldlnX+9U4
 zVksCSu0TMtgaMiZGJoY6rP8xGFGwz0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-t-1jchMZMYSArAE2aATl6g-1; Mon,
 16 Feb 2026 06:19:09 -0500
X-MC-Unique: t-1jchMZMYSArAE2aATl6g-1
X-Mimecast-MFC-AGG-ID: t-1jchMZMYSArAE2aATl6g_1771240747
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07E8C1800342; Mon, 16 Feb 2026 11:19:07 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D83CC18004AD; Mon, 16 Feb 2026 11:19:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:16:03 +0100
Subject: [PATCH 74/85] audio: replace ldebug with trace events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-74-e676662e4514@redhat.com>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
In-Reply-To: <20260216-audio-v1-0-e676662e4514@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2585;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LJcSuW2BtX9Mst8LxXKghg7ubBSgT/CUaX2Tj3sx1Wg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxSPE7di7Rch31YMastXMAVy+GZfzsJE4IK6
 Fvi8O83bZqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UgAKCRDa6OEJdZac
 5T+GEACpbLJzGOjg525NzPv4kC8pvkMsd0iF3XyMVgKJam1cBlQj3If6dK7B8zrxLr6BFknjArQ
 ySqgc1cXCqWLFgXK4BMJcHo5CaL8u/DHoi1lJFSbZPa+NoBEPGUB8wyGBt9XHsYytZenl7wUXFh
 vM6h/Zf+lGgdEykhcOCMTMx27HyCWYOehMkaHxvBBxG0PbsVIr3z7BbJllfUWG75bPZijIBe8VK
 yikCQXRwIhP3WfGV3DgTl31aWi2WuZ3J86HhKeT+7pAIwP6vO3yvZ/zmr7VqH3qzJJOv+rRzWb2
 NqMtIlJ5Q+nhaelSKGv8fHPak1ZQfPvEGbUeMcNLA25auYn6u+eDKs5PxsFJhlcQ6ukmGUFuj+T
 emyrxm6uBHi9u313nbGOiOjH5NcCfJJu8tbkEjUHi3b0C6s8wED1MJFeO7pAP1aQl7Q0j2kFXv0
 1pk8oozJhDROqsGgwEgnV6S1xEXoEBaA1OgjEjWW3CjoGg0ThJUX+Sv2SeEDMYBdrmfPjAVcxdu
 GpFi+SNC05FTnDNB7BafVusVJoozRXEcFi/k5wmYawxlmmh7bpOl0uG6u7yGQHShan845xSZrtt
 1C8it1U+Jmz/hkiO6SFY45YeG6vVaXDP3W3sMmwQiAUHmyaubvCB1G1lE5WK1MnLbevRjvAriTt
 ksLlNbUW3axPwlQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Replace the ldebug macro calls with proper trace events:
- audio_get_avail: traces available samples in capture stream
- audio_open_out/audio_open_in: traces stream open parameters

This provides structured tracing that can be enabled at runtime
without requiring debug builds.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
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


