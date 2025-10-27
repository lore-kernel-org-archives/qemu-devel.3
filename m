Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18481CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 15:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOti-00027M-GL; Mon, 27 Oct 2025 11:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOte-00023M-Nr
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOtb-0003l1-86
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761577947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ivw15n2eGgz0hbDON7Uymt7N26eR8ayKcunBK4tszNs=;
 b=ECC6hQ2thsnZ2sW3rlDl3h3EWPQ4xC4uiqO13ezXFCmQZbfJSbnzUeKJJN2CO2QGD4Jw3+
 q+NjR0LovLd9bYgKVDleB23y/QERqi7WS1K2iTyjr3UWS+DDgj2GaBT7SPN7NEIvBcySxO
 qQG4fVpQbYGuSGKT9hBnx5HoX/ObwGE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-Ttnqzm-RPi6ZxAjDGgXwBg-1; Mon,
 27 Oct 2025 11:12:23 -0400
X-MC-Unique: Ttnqzm-RPi6ZxAjDGgXwBg-1
X-Mimecast-MFC-AGG-ID: Ttnqzm-RPi6ZxAjDGgXwBg_1761577940
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8ED31801359; Mon, 27 Oct 2025 15:12:20 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 143CC30001A2; Mon, 27 Oct 2025 15:12:18 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 13/35] audio/dsound: simplify init()
Date: Mon, 27 Oct 2025 19:10:20 +0400
Message-ID: <20251027151045.2863176-14-marcandre.lureau@redhat.com>
In-Reply-To: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use dsound_audio_fini() on error & fail if the capture failed to
initialize too.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/dsoundaudio.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index f3bb48d007..c8745a3df0 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -638,7 +638,7 @@ static void *dsound_audio_init(Audiodev *dev, Error **errp)
     hr = CoInitialize (NULL);
     if (FAILED (hr)) {
         dsound_logerr (hr, "Could not initialize COM\n");
-        g_free(s);
+        dsound_audio_fini(s);
         return NULL;
     }
 
@@ -651,19 +651,14 @@ static void *dsound_audio_init(Audiodev *dev, Error **errp)
         );
     if (FAILED (hr)) {
         dsound_logerr (hr, "Could not create DirectSound instance\n");
-        g_free(s);
+        dsound_audio_fini(s);
         return NULL;
     }
 
     hr = IDirectSound_Initialize (s->dsound, NULL);
     if (FAILED (hr)) {
         dsound_logerr (hr, "Could not initialize DirectSound\n");
-
-        hr = IDirectSound_Release (s->dsound);
-        if (FAILED (hr)) {
-            dsound_logerr (hr, "Could not release DirectSound\n");
-        }
-        g_free(s);
+        dsound_audio_fini(s);
         return NULL;
     }
 
@@ -676,17 +671,15 @@ static void *dsound_audio_init(Audiodev *dev, Error **errp)
         );
     if (FAILED (hr)) {
         dsound_logerr (hr, "Could not create DirectSoundCapture instance\n");
-    } else {
-        hr = IDirectSoundCapture_Initialize (s->dsound_capture, NULL);
-        if (FAILED (hr)) {
-            dsound_logerr (hr, "Could not initialize DirectSoundCapture\n");
+        dsound_audio_fini(s);
+        return NULL;
+    }
 
-            hr = IDirectSoundCapture_Release (s->dsound_capture);
-            if (FAILED (hr)) {
-                dsound_logerr (hr, "Could not release DirectSoundCapture\n");
-            }
-            s->dsound_capture = NULL;
-        }
+    hr = IDirectSoundCapture_Initialize (s->dsound_capture, NULL);
+    if (FAILED(hr)) {
+        dsound_logerr(hr, "Could not initialize DirectSoundCapture\n");
+        dsound_audio_fini(s);
+        return NULL;
     }
 
     err = dsound_set_cooperative_level(s);
-- 
2.51.0


