Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BE7CCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 07:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSoT-0006b5-Aj; Wed, 22 Oct 2025 02:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSoR-0006UW-Oz
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSoP-0008Jk-Nk
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3qEMyN2Ig2MXdwLXWBdlvpZ1JIUr5GwgkG+gBGafMQ=;
 b=YQiMal0w4+lpLQNc9myKNdrw6TwnRC70zW4NAVrPOZ9IPDeKW7E9I/xwQWf8yo69WFtxq4
 hPcqGFYP+YyUCvAwkL3lu///FwjBdOuGoYZlkSmxSYwjtVNvv7Ep98OF/LQZofS/P+S0yh
 BitbcIHxVZe8249uVDi0o/3miEQnk7g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-i9DThp5rN2GmqwHJ7cvLBg-1; Wed,
 22 Oct 2025 02:59:04 -0400
X-MC-Unique: i9DThp5rN2GmqwHJ7cvLBg-1
X-Mimecast-MFC-AGG-ID: i9DThp5rN2GmqwHJ7cvLBg_1761116343
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A58019560A2; Wed, 22 Oct 2025 06:59:03 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C53E830001BF; Wed, 22 Oct 2025 06:59:01 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 25/42] audio: clean-up vmstate change handler on finalize
Date: Wed, 22 Oct 2025 10:56:20 +0400
Message-ID: <20251022065640.1172785-26-marcandre.lureau@redhat.com>
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
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


