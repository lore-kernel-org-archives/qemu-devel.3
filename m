Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33A5E7BD9E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfU-0007XQ-Ow; Mon, 16 Feb 2026 06:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdY-0000co-Jb
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdW-0008WR-Vf
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m0EmStvnfux6SRdwIes6737BLoqxJP2yVeKJO8MbGz4=;
 b=Ia6TSTDxJzKU3qSdV5mt3XQGVq4pP41EgXQgxYj3+seoeyQHiS8JtC9bhkwPgKQiFuDokq
 0Yg/qR0L47BVD2Ux67w2vehwVcBJJ+Z06BJnxXbfHZlRidP6qJGMBTfy8wV+w+cY4oGGQO
 J8MgST20xixhko2QKcqlAna9qaME9xY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-qBn4hfwiOxy1PhneU5GLmw-1; Mon,
 16 Feb 2026 06:19:26 -0500
X-MC-Unique: qBn4hfwiOxy1PhneU5GLmw-1
X-Mimecast-MFC-AGG-ID: qBn4hfwiOxy1PhneU5GLmw_1771240764
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 416311800352; Mon, 16 Feb 2026 11:19:24 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 490CC30001A5; Mon, 16 Feb 2026 11:19:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:16:09 +0100
Subject: [PATCH 80/85] audio: rework invalid audsettings error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-80-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3338;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DOJovR/J2k1KAla05HmsB7pR9pRP9RvnTgMZQuarhDc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxSnXO32iYEl8o8zZV2F9Oh/JWAlwWg37ikc
 r7xIdTzuR6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UgAKCRDa6OEJdZac
 5aVEEACh9XvMthEFPQywxqOzatqETNSiy+JPT0Xu3afRti/u4CYaGO1uPl/mL39QskvYmUU79pW
 UAbDvbOzfLl3X4ABUSXsI6Txh1W4V1GoeY7CZrEW7X/hG7MuF6wgaIZUwlMa6ycLtpwqrfszJo7
 sWW92UWAd+XbYASkT2nMVj7rRNcsk3MKoAJ1F5LveFmJ1Cj/kEjspvjS05sMOGVQJTja2LPt7dU
 vcxTrol5D/Hes2WClKpxZrm4MqHHGlrC1n+9JnFjaV7Y/+99/k50jnp1L1QuLf6KEKd+gABOJB6
 NW6o6mE83UskEDBuSfc5U2SOR0YLi+QKBGbPdC5lhfgULyEClCqD263BkVdvvwOvYPgbZ/Bd4kG
 S4dfBvZWaEVGKadD+CflRzdbxWi/oZC9b/QpsLeCXuTiCPoybRpki0BfZts55DchoScL0JAxYpJ
 hE7wcsudaVF6mi+AMbHtiuAFRrlA7/v6fE2FYOObiBjIaQT4DSPAfNwP6es4njGz6iDmM1VOLwH
 r6lDXyGNQ9D/W2a3zmDoJ5w6UDTfs4tWEa0+uSZ3kxRws9JeBxCWUk6mexV3AO+Jeor5HZcloOZ
 8TiODYoCUOLdcBPlY+DM7h1tWmnZGnHdn1kVXtZnVUfotxpjLYPVT1BB3b5/x/kImG7yNHESnud
 ppkdaJCERvAbbnA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Currently, when given invalid settings, QEMU will print to stderr:

A bug was just triggered in audio_mixeng_backend_open_out
Save all your work and restart without audio
I am sorry
Context:
audio: frequency=44100 nchannels=0 fmt=S16 endianness=little

Now it will use error_report() and simply report:
audio: Invalid audio settings: frequency=44100 nchannels=0 fmt=s16 endian=little

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio_template.h  |  5 +++--
 audio/audio-mixeng-be.c | 41 +++++++----------------------------------
 2 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index e884c8e9b1a..5711f4a26e1 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -513,8 +513,9 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
     trace_audio_open_in(name, as->freq, as->nchannels, as->fmt);
 #endif
 
-    if (audio_bug(__func__, audio_validate_settings(as))) {
-        audio_print_settings (as);
+    if (audio_validate_settings(as)) {
+        g_autofree char *str = audsettings_to_string(as);
+        error_report("audio: Invalid audio settings: %s", str);
         goto fail;
     }
 
diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 7eabb1c2505..bb8c0b56f78 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -101,38 +101,11 @@ void AUD_log (const char *cap, const char *fmt, ...)
     va_end (ap);
 }
 
-static void audio_print_settings (const struct audsettings *as)
+static char *audsettings_to_string(const struct audsettings *as)
 {
-    dolog ("frequency=%d nchannels=%d fmt=", as->freq, as->nchannels);
-
-    switch (as->fmt) {
-    case AUDIO_FORMAT_S8:
-        AUD_log (NULL, "S8");
-        break;
-    case AUDIO_FORMAT_U8:
-        AUD_log (NULL, "U8");
-        break;
-    case AUDIO_FORMAT_S16:
-        AUD_log (NULL, "S16");
-        break;
-    case AUDIO_FORMAT_U16:
-        AUD_log (NULL, "U16");
-        break;
-    case AUDIO_FORMAT_S32:
-        AUD_log (NULL, "S32");
-        break;
-    case AUDIO_FORMAT_U32:
-        AUD_log (NULL, "U32");
-        break;
-    case AUDIO_FORMAT_F32:
-        AUD_log (NULL, "F32");
-        break;
-    default:
-        AUD_log (NULL, "invalid(%d)", as->fmt);
-        break;
-    }
-
-    AUD_log (NULL, " endianness=%s\n", as->big_endian ? "big" : "little");
+    return g_strdup_printf("frequency=%d nchannels=%d fmt=%s endian=%s",
+                           as->freq, as->nchannels, AudioFormat_str(as->fmt),
+                           as->big_endian ? "big" : "little");
 }
 
 static int audio_validate_settings (const struct audsettings *as)
@@ -1607,9 +1580,9 @@ static CaptureVoiceOut *audio_mixeng_backend_add_capture(
         return NULL;
     }
 
-    if (audio_validate_settings (as)) {
-        dolog ("Invalid settings were passed when trying to add capture\n");
-        audio_print_settings (as);
+    if (audio_validate_settings(as)) {
+        g_autofree char *str = audsettings_to_string(as);
+        error_report("audio: Invalid audio settings when trying to add capture: %s", str);
         return NULL;
     }
 

-- 
2.53.0


