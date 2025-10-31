Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5974CCF9EE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 06:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEiwp-0008Vz-BC; Fri, 31 Oct 2025 02:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vEiwM-0007eV-UY
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vEiwJ-0003tW-7v
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761893326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iaTRZZopkfZtRrS9JMoiXkd5OnX21LT7v4mz7sPGUxw=;
 b=fWu2FvjyUapW8vgR0eVlfKzSQ/T9grqaWhHEjvTb9YfE+UvsljOoVfPwupjWTtjXXMcBCg
 6VeipTfBFNRuNrVVtXI2vi4N4/feejNW9Zfq7eRITp/e5U1u3kasxaoCAH0KOwfm9x+PLQ
 tM0KYoe1J60DUx5cP0C231SDbM1UkvU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-yhwVOBi-PKmMnoyqteFyIg-1; Fri,
 31 Oct 2025 02:48:43 -0400
X-MC-Unique: yhwVOBi-PKmMnoyqteFyIg-1
X-Mimecast-MFC-AGG-ID: yhwVOBi-PKmMnoyqteFyIg_1761893322
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42A97183453C; Fri, 31 Oct 2025 06:48:42 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 358EE1955BE3; Fri, 31 Oct 2025 06:48:40 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 19/36] audio: register and unregister vmstate with AudioState
Date: Fri, 31 Oct 2025 10:46:12 +0400
Message-ID: <20251031064631.134651-20-marcandre.lureau@redhat.com>
In-Reply-To: <20251031064631.134651-1-marcandre.lureau@redhat.com>
References: <20251031064631.134651-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Proper lifecycle management with QOM state.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 audio/audio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index 4c3c3fd52f..853930bb48 100644
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
2.51.1


