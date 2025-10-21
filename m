Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F7ACCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8JX-0003qI-2z; Tue, 21 Oct 2025 05:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8JP-0003lt-K9
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8JN-0004FD-8l
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3qEMyN2Ig2MXdwLXWBdlvpZ1JIUr5GwgkG+gBGafMQ=;
 b=jRdorxDjziBtL6+BBBhIy6vf81rqfCXGpuah75rTJz33ia17rLe9wHM7BlBwtpvmu5ZuIy
 SIUdIy/MsPToElwQJGe539TkrZHE33QBqF7RNr5+n+Hj8ur4qnSzfP/78/jNeiU3QHjmYM
 1427n3A4UXLhVuGBEtJhQPqjf2dNTVw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-gfTZBzQ1N4mEvp-Bm4dlUg-1; Tue,
 21 Oct 2025 05:05:40 -0400
X-MC-Unique: gfTZBzQ1N4mEvp-Bm4dlUg-1
X-Mimecast-MFC-AGG-ID: gfTZBzQ1N4mEvp-Bm4dlUg_1761037539
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D09F180121E; Tue, 21 Oct 2025 09:05:39 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A64A91800451; Tue, 21 Oct 2025 09:05:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 25/43] audio: clean-up vmstate change handler on finalize
Date: Tue, 21 Oct 2025 13:02:56 +0400
Message-ID: <20251021090317.425409-26-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

QOM-ification continues.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h |  1 +
 audio/audio.c     | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 4187a2dbfc..4a4d69f2bf 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -235,6 +235,7 @@ typedef struct AudioState {
 
     bool timer_running;
     uint64_t timer_last;
+    VMChangeStateEntry *vmse;
 } AudioState;
 
 extern const struct mixeng_volume nominal_volume;
diff --git a/audio/audio.c b/audio/audio.c
index 4478041e5d..b39b86cc2e 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1622,6 +1622,9 @@ static void audio_state_init(Object *obj)
     QLIST_INIT (&s->hw_head_in);
     QLIST_INIT (&s->cap_head);
     s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
+
+    s->vmse = qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
+    assert(s->vmse != NULL);
 }
 
 static void audio_state_finalize(Object *obj)
@@ -1671,6 +1674,11 @@ static void audio_state_finalize(Object *obj)
         timer_free(s->ts);
         s->ts = NULL;
     }
+
+    if (s->vmse) {
+        qemu_del_vm_change_state_handler(s->vmse);
+        s->vmse = NULL;
+    }
 }
 
 static Object *get_audiodevs_root(void)
@@ -1735,7 +1743,6 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
 {
     int done = 0;
     const char *drvname;
-    VMChangeStateEntry *vmse;
     AudioState *s;
     struct audio_driver *driver;
 
@@ -1775,9 +1782,6 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
         }
     }
 
-    vmse = qemu_add_vm_change_state_handler (audio_vm_change_state_handler, s);
-    assert(vmse != NULL);
-
     if (!object_property_try_add_child(get_audiodevs_root(), dev->id, OBJECT(s), errp)) {
         goto out;
     }
-- 
2.51.0


