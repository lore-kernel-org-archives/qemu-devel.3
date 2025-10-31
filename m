Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB65CCF9EE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 06:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEiwN-0007dx-W9; Fri, 31 Oct 2025 02:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vEivx-00070S-Kv
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vEivj-0003q3-1u
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761893286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EnHuJt01YxKm69T0x95B5ESs3I+4ASAEQVrLsiXBo34=;
 b=UcLoxxPYwmjvx5xKgodWyXF7RUGyGWIDkm9WsUeJktKfAQn2mA0tNQlNriO+ZQkOQHjV8Y
 UC1hqnmbUU5y01GxuCXvukwEZIGyokWAs88UOj+rXPFPNWMC6/l41Y6x1sxWV6s2ALTNs/
 li5gRjXEOV4kexuNaZtO/3X4xKBzpXY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-5BVdSjjfM3WYnu4heSX3Vw-1; Fri,
 31 Oct 2025 02:48:04 -0400
X-MC-Unique: 5BVdSjjfM3WYnu4heSX3Vw-1
X-Mimecast-MFC-AGG-ID: 5BVdSjjfM3WYnu4heSX3Vw_1761893283
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41A951955D85; Fri, 31 Oct 2025 06:48:03 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F6461955BE3; Fri, 31 Oct 2025 06:48:01 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 13/36] audio/dsound: simplify init()
Date: Fri, 31 Oct 2025 10:46:06 +0400
Message-ID: <20251031064631.134651-14-marcandre.lureau@redhat.com>
In-Reply-To: <20251031064631.134651-1-marcandre.lureau@redhat.com>
References: <20251031064631.134651-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.51.1


