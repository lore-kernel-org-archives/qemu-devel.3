Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4690FE7BD95
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwff-0000OI-3t; Mon, 16 Feb 2026 06:21:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdi-0001Gz-KJ
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdf-00009q-ML
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LUP+G2rwSZjjp818AEO2MqOgi20Zq+c3evxaj7rofVg=;
 b=eL+WhRiMqBiEaR2GR3YxbOppvpdPo35kaGAMzjb460Z0g3DEY3QLlZODOX4HyB9UbvGxis
 r7qXnE2I+Gq/v9Jp1DzRv4G5GgKfVekc5AwzHuJAyKq3EWvzutZnZ1Jcy6IC10x3YVabg+
 /8rsP5uT8d94HuIvGnRP5tyLIHO3G+Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-6rvFx-VzM8q23-UhVuhAUw-1; Mon,
 16 Feb 2026 06:19:34 -0500
X-MC-Unique: 6rvFx-VzM8q23-UhVuhAUw-1
X-Mimecast-MFC-AGG-ID: 6rvFx-VzM8q23-UhVuhAUw_1771240772
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 809BC1800464; Mon, 16 Feb 2026 11:19:32 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D778B30001A5; Mon, 16 Feb 2026 11:19:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:16:12 +0100
Subject: [PATCH 83/85] audio: remove AUD_log/ldebug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-83-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3404;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wYEC+0RY6JzYLHGKwBVCYQt+/nE3Fr4RFck/o8ke+9Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxSB39sG13RfjzVUOgEPjEPtzl6qSSehB8VC
 Yyu8pBZpF6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UgAKCRDa6OEJdZac
 5cbxD/4gZMNLnfHBdGVo9QnEl60b3/UEw8dEanVeoITFTFDpqf2ci8JC75kPIInmGCi2Dobtz+f
 lsL5xSoxpyhZg+t0ojuc8T6UBcw5ZOzv57fwBCQDQvFaULlIzddwmRqR6CVOM+8HPrmlHS9nQIS
 UDheF1iCBoxwlaihAId4pxM1GIgTSHV6X1hwOApo7MSDqg/xNp2MqZnRcScPYKPbesk9mB9lSvs
 70mUUX3WFbndWXCJocQv1NEox7jfJsGhKVa/lUt5/M17GWDuNTCB6kNNbBmmBH/ocL532gItmWg
 LS5UJLDGrxkBuKRjZFQRDsKFG/ierneuNnN2mxDX49jfSJhucbXt4PCR9yVuzjiu1Pu0RYlzqtx
 Dt9fMlajxTVa9BJEgnbNVj0sMw7q8+YtkvzY8x9epI/fQkS/8kDN5pHNGztauT5CccgA8AAuwHv
 55LDXAtsofD6CghlgmOazwg/NvvU8BRA+kHpLHkSKvq0dwW7CSgfeX3bakCpWER49EcTYA4z6QF
 Fx2UUaRQLpKoWoCbJMLtbktdAFZwtqMgZFWh3TQNjgM7duLj5gDnFs/aJmtAHsLr7lqCZ8Jweyn
 Hv4ewuPxOX4oe8OzzO58dKge1Ht/oKntsoYqGdfHttiWD4JYX0zGSAY/qas6pvPEdoqyq8Dev0l
 MIlxQLE98zjuV8Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

audio/ is now converted to use QEMU standard trace & error reporting.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio_int.h       | 14 --------------
 audio/audio_template.h  |  2 +-
 audio/audio-mixeng-be.c | 19 -------------------
 audio/mixeng.c          |  1 -
 4 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 20ec7883aab..3fc4b516878 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -33,12 +33,6 @@
 #include "qemu/audio-capture.h"
 #include "mixeng.h"
 
-void G_GNUC_PRINTF(2, 0)
-AUD_vlog(const char *cap, const char *fmt, va_list ap);
-
-void G_GNUC_PRINTF(2, 3)
-AUD_log(const char *cap, const char *fmt, ...);
-
 struct audio_callback {
     void *opaque;
     audio_callback_fn fn;
@@ -276,14 +270,6 @@ static inline size_t audio_ring_posb(size_t pos, size_t dist, size_t len)
     return pos >= dist ? pos - dist : len - dist + pos;
 }
 
-#define dolog(fmt, ...) AUD_log(AUDIO_CAP, fmt, ## __VA_ARGS__)
-
-#ifdef DEBUG
-#define ldebug(fmt, ...) AUD_log(AUDIO_CAP, fmt, ## __VA_ARGS__)
-#else
-#define ldebug(fmt, ...) (void)0
-#endif
-
 AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev);
 
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 760aaf5f31f..85a128e2f47 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -128,7 +128,7 @@ static int glue (audio_pcm_sw_alloc_resources_, TYPE) (SW *sw)
         /* f_fe_min = ceil(1 [frames] * f_be [Hz] / size_be [frames]) */
         f_fe_min = (f_be + HWBUF.size - 1) / HWBUF.size;
         qemu_log_mask(LOG_UNIMP,
-                      AUDIO_CAP ": The guest selected a " NAME " sample rate"
+                      "audio: The guest selected a " NAME " sample rate"
                       " of %d Hz for %s. Only sample rates >= %" PRIu64 " Hz"
                       " are supported.\n",
                       sw->info.freq, sw->name, f_fe_min);
diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 87e5a2fc3af..a6d5812fc65 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -26,7 +26,6 @@
 #include "trace.h"
 #include "trace/control.h"
 
-#define AUDIO_CAP "audio"
 #include "audio_int.h"
 
 #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
@@ -68,24 +67,6 @@ static int audio_format_to_index(AudioFormat af)
     g_assert_not_reached();
 }
 
-void AUD_vlog (const char *cap, const char *fmt, va_list ap)
-{
-    if (cap) {
-        fprintf(stderr, "%s: ", cap);
-    }
-
-    vfprintf(stderr, fmt, ap);
-}
-
-void AUD_log (const char *cap, const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start (ap, fmt);
-    AUD_vlog (cap, fmt, ap);
-    va_end (ap);
-}
-
 static char *audsettings_to_string(const struct audsettings *as)
 {
     return g_strdup_printf("frequency=%d nchannels=%d fmt=%s endian=%s",
diff --git a/audio/mixeng.c b/audio/mixeng.c
index e63c76e021d..a209737a913 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -26,7 +26,6 @@
 #include "qemu/bswap.h"
 #include "qemu/audio.h"
 
-#define AUDIO_CAP "mixeng"
 #include "audio_int.h"
 #ifdef FLOAT_MIXENG
 #include "qemu/error-report.h"

-- 
2.53.0


