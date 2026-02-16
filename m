Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76B5E7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfV-0007c0-Gr; Mon, 16 Feb 2026 06:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdd-00014w-QN
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdc-00008p-1J
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FAUf6ISAZflTDjhXPD3ercX88fY0ngZoOrqUS7o23nE=;
 b=BiNGh4GsUVsrI5ErVCxb8+jKAeQqGg3HFPbaZJuHHNkqgnY0WFJGZ0MMJvo5Fjq34mxh3w
 dw4kcueH2vJPqJEBNz+mOHHU+3d7eayh1MjIRI842JEjtCt+KApmllSUybD0RtmTxPOtyX
 fhb5yDyj+1HoVP95Aqk5Ve+L+2vMiSY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-eZ5vn84fMCuPDEEuy7Dqdw-1; Mon,
 16 Feb 2026 06:19:32 -0500
X-MC-Unique: eZ5vn84fMCuPDEEuy7Dqdw-1
X-Mimecast-MFC-AGG-ID: eZ5vn84fMCuPDEEuy7Dqdw_1771240770
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13585180061C; Mon, 16 Feb 2026 11:19:30 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 366AE18003F5; Mon, 16 Feb 2026 11:19:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:16:11 +0100
Subject: [PATCH 82/85] audio: replace remaining dolog() and AUD_log
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-82-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5295;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mOUp9eC9vpEhRWm1F10PNR55828CsJNREo9Q5TCNNvM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxS8OVVpkPOKm5cUtP04sCqyOLFsyNqaNIl+
 zQ23O2L4S2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UgAKCRDa6OEJdZac
 5Tn9EACsUwLAH8MeYZjy+V08nmhf4+TbU/JZDkFGl+cx5bR8Lz114WS2shcfs0dbnzJVobZNqqw
 BLjBA/96RW2g3aPpaGlfYwKnJsZtK2dUhV8OSPzmyRN8t65kjIqdZic3epkDw12BdgSnVlkmPxl
 WYMJKRFfk6suDuXwGdvrCuvNKQOfmg6Z6Xl114MSZKSVbfR7Yoac7yrR09nW8+GPFhKqzSk3p61
 vpyAiAy+ClkBHyM97svUVRfNYXjSo4Ma7GH/TZzjGFaCqW5iADljBc7/9QWX+DPLad/6Hk2CRzA
 cWdxVZoDXXJYc6Z5DMTLiDyQCGgufr452FPMlI+SpplDo3u1082HdxghrBbmbqpd69tXJaFG7Pi
 TUYRX5dLEkAKEShuPBXu2QtbLV45sIKjwkDSERI+srdBFXNETo1W43TVkPlLVDNn2P0roHZ1gT5
 p6Pdvlog/oH8okWj/Gtieze1O9P5KgFvFCb1TzbrAeOTge9ekBx/YBnl4z/SMrrqQwYgVZrEJqi
 kst01pGscF9tnPcmgfT+6tdFtdI9tkvKS5Wgnx9H0Dgy+zP1+PtGKk4BaB0XHrE5Ij+7lLmtjhp
 cRpvpQGCJvMr9IWWFGAfC1KzXvlE1hlkkJRDxA4TcmiSstDMBcmjbzTpf0nF2/OL0aGL6bPRr7M
 vOVYUq6gDhnHJtQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Use warn_report/error_report and trace instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio_template.h  | 19 ++++++++-----------
 audio/audio-mixeng-be.c | 14 ++++++--------
 audio/trace-events      |  1 +
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 9dde36738bc..760aaf5f31f 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -47,21 +47,19 @@ static void glue(audio_init_nb_voices_, TYPE)(AudioMixengBackend *s,
     if (glue(s->nb_hw_voices_, TYPE) > max_voices) {
         if (!max_voices) {
 #ifdef DAC
-            dolog("Driver `%s' does not support " NAME "\n", k->name);
+            warn_report("audio: Driver '%s' does not support " NAME, k->name);
 #endif
         } else {
-            dolog("Driver `%s' does not support %d " NAME " voices, max %d\n",
-                   k->name,
-                   glue(s->nb_hw_voices_, TYPE),
-                   max_voices);
+            warn_report("audio: Driver '%s' does not support %d " NAME " voices, max %d",
+                        k->name, glue(s->nb_hw_voices_, TYPE), max_voices);
         }
         glue(s->nb_hw_voices_, TYPE) = max_voices;
     }
 
     if (glue(s->nb_hw_voices_, TYPE) < min_voices) {
-        dolog("Bogus number of " NAME " voices %d, setting to %d\n",
-               glue(s->nb_hw_voices_, TYPE),
-               min_voices);
+        warn_report("audio: Bogus number of " NAME " voices %d, setting to %d",
+                    glue(s->nb_hw_voices_, TYPE),
+                    min_voices);
     }
 
     if (!voice_size && max_voices) {
@@ -443,7 +441,7 @@ static SW *glue(audio_pcm_create_voice_pair_, TYPE)(
 
     hw = glue(audio_pcm_hw_add_, TYPE)(s, &hw_as);
     if (!hw) {
-        dolog("Could not create a backend for voice `%s'\n", sw_name);
+        error_report("audio: Could not create a backend for voice '%s'", sw_name);
         goto err1;
     }
 
@@ -537,8 +535,7 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
         HW *hw = sw->hw;
 
         if (!hw) {
-            dolog("Internal logic error: voice `%s' has no backend\n",
-                  SW_NAME(sw));
+            audio_bug("Internal logic error: voice '%s' has no backend", SW_NAME(sw));
             goto fail;
         }
 
diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 45bcfb74338..87e5a2fc3af 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -654,7 +654,7 @@ static size_t audio_mixeng_backend_write(AudioBackend *be, SWVoiceOut *sw,
     hw = sw->hw;
 
     if (!hw->enabled) {
-        dolog("Writing to disabled voice %s\n", SW_NAME(sw));
+        warn_report("audio: Writing to disabled voice %s", SW_NAME(sw));
         return 0;
     }
 
@@ -677,7 +677,7 @@ static size_t audio_mixeng_backend_read(AudioBackend *be,
     hw = sw->hw;
 
     if (!hw->enabled) {
-        dolog("Reading from disabled voice %s\n", SW_NAME(sw));
+        warn_report("audio: Reading from disabled voice %s", SW_NAME(sw));
         return 0;
     }
 
@@ -874,9 +874,8 @@ static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
                 sw->empty = sw->total_hw_samples_mixed == 0;
 
                 if (to_read - frames_in) {
-                    dolog("Could not mix %zu frames into a capture "
-                          "buffer, mixed %zu\n",
-                          to_read, frames_in);
+                    audio_bug("Could not mix %zu frames into a capture "
+                              "buffer, mixed %zu", to_read, frames_in);
                     break;
                 }
                 n -= to_read;
@@ -1561,7 +1560,7 @@ static CaptureVoiceOut *audio_mixeng_backend_add_capture(
     }
 
     if (!audio_get_pdo_out(s->dev)->mixing_engine) {
-        dolog("Can't capture with mixeng disabled\n");
+        error_report("audio: Can't capture with mixeng disabled");
         return NULL;
     }
 
@@ -1754,8 +1753,7 @@ size_t audio_rate_peek_bytes(RateCtl *rate, struct audio_pcm_info *info)
 void audio_rate_add_bytes(RateCtl *rate, size_t bytes_used)
 {
     if (rate->peeked_frames < 0 || rate->peeked_frames > 65536) {
-        AUD_log(NULL, "Resetting rate control (%" PRId64 " frames)\n",
-                rate->peeked_frames);
+        trace_audio_rate_reset(rate->peeked_frames);
         audio_rate_start(rate);
     }
 
diff --git a/audio/trace-events b/audio/trace-events
index ed04792d508..222e73c7e88 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -70,6 +70,7 @@ audio_sw_write(const char *name, size_t size, size_t written, size_t total_mixed
 audio_get_free(const char *name, size_t live, size_t dead, uint32_t frontend_frames) "%s: get_free live %zu dead %zu frontend frames %u"
 audio_out_disable(void) "Disabling voice"
 audio_out_played(size_t played) "played=%zu"
+audio_rate_reset(int64_t frames) "Resetting rate control (%" PRId64 " frames)"
 
 # audio_template.h
 audio_open_out(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"

-- 
2.53.0


