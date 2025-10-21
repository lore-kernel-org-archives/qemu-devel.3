Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D25CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8J6-00037s-Ke; Tue, 21 Oct 2025 05:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8J4-000330-MS
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Ix-0004Dh-ID
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T5DGuhfLFoc7PT62ZhKWesCEDaDqaTP9IZTqxum1alU=;
 b=LdRn//DtKvv3FaiWhuKI7ERsV/80TgcIQMGnhFq0LSdAqDQd8h89Zb7OfZSj11ITH/Yy9X
 UGdkq4ZktYf4gdbZWxvTrlkmL3wSvf8PLFIA9pcxaD8jhoACnduIE7OMWdNGHleKHGWAqp
 +WSIX/yFxHmR6VRpPkT36+hHmKiR8yA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-JPC7Dc8LMGW6s6BzGREGpg-1; Tue,
 21 Oct 2025 05:05:14 -0400
X-MC-Unique: JPC7Dc8LMGW6s6BzGREGpg-1
X-Mimecast-MFC-AGG-ID: JPC7Dc8LMGW6s6BzGREGpg_1761037513
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60F5C1956086; Tue, 21 Oct 2025 09:05:13 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 059FD19541B2; Tue, 21 Oct 2025 09:05:11 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 20/43] audio/dsound: simplify init()
Date: Tue, 21 Oct 2025 13:02:51 +0400
Message-ID: <20251021090317.425409-21-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index f3bb48d007..d54d79d41c 100644
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
+    if (FAILED (hr)) {
+        dsound_logerr (hr, "Could not initialize DirectSoundCapture\n");
+        dsound_audio_fini(s);
+        return NULL;
     }
 
     err = dsound_set_cooperative_level(s);
-- 
2.51.0


