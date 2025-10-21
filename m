Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AAACCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8Jf-000484-Ez; Tue, 21 Oct 2025 05:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8JV-0003q7-61
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8JS-0004Fd-SY
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAafkmBEG44dEvteX7fLDwSFhNPhRmmSpWk7ihmCK6E=;
 b=fCyN49fKHa1qHKY+nZFEL9ztsft1bb5oF3NhhERFKmsV0i4Celrls2PMmMpu+DzCdBrP+y
 Ehn22HKSeeQ1h4f82SAlGD0PgWOQF0G6jXatHFE7m4ZxchXw1nPPMv9Fp6QRZAfVjePQ8N
 N+MgN2mscMMGzw6Smg/qhEo7rQvWYvA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-_DITWIAGPbCTkIaFqChIFQ-1; Tue,
 21 Oct 2025 05:05:45 -0400
X-MC-Unique: _DITWIAGPbCTkIaFqChIFQ-1
X-Mimecast-MFC-AGG-ID: _DITWIAGPbCTkIaFqChIFQ_1761037544
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8300E195606C; Tue, 21 Oct 2025 09:05:44 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 49435195419F; Tue, 21 Oct 2025 09:05:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 26/43] audio: unregister vmstate description
Date: Tue, 21 Oct 2025 13:02:57 +0400
Message-ID: <20251021090317.425409-27-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index b39b86cc2e..e610e8453a 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1614,6 +1614,8 @@ static void audio_vm_change_state_handler (void *opaque, bool running,
     audio_reset_timer (s);
 }
 
+static const VMStateDescription vmstate_audio;
+
 static void audio_state_init(Object *obj)
 {
     AudioState *s = AUDIO_STATE(obj);
@@ -1625,6 +1627,8 @@ static void audio_state_init(Object *obj)
 
     s->vmse = qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
     assert(s->vmse != NULL);
+
+    vmstate_register_any(NULL, &vmstate_audio, s);
 }
 
 static void audio_state_finalize(Object *obj)
@@ -1679,6 +1683,8 @@ static void audio_state_finalize(Object *obj)
         qemu_del_vm_change_state_handler(s->vmse);
         s->vmse = NULL;
     }
+
+    vmstate_unregister(NULL, &vmstate_audio, s);
 }
 
 static Object *get_audiodevs_root(void)
@@ -1787,7 +1793,6 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
     }
     object_unref(s);
     QLIST_INIT (&s->card_head);
-    vmstate_register_any(NULL, &vmstate_audio, s);
     return s;
 
 out:
-- 
2.51.0


