Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE4DCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8Ku-0007MA-MJ; Tue, 21 Oct 2025 05:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Ks-0007Dc-Nz
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Kq-0004RP-Kh
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CMw81vkVQi04474LbjAtyqfg7CC8nxWj8ZSHSjYZ4I8=;
 b=MzYtnDpOgDlm8J375u3NdH9ouk0rxhSBN9oEtrkjOxKZoBpXOfpMSdQBPqisxnhWyUvQO2
 bgHkUmYfw+ueLCWUWvXdm0r9DSe9qB6oGMxeZzRbHIoz8iK+A5uKJW52nwWAPbPXMcBiDU
 OHp6TLeOX9bwLUgr0q3g/HrMJwO44f8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-IvOp5BhhOuuqWEv4nctYAg-1; Tue,
 21 Oct 2025 05:07:11 -0400
X-MC-Unique: IvOp5BhhOuuqWEv4nctYAg-1
X-Mimecast-MFC-AGG-ID: IvOp5BhhOuuqWEv4nctYAg_1761037630
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C6191956096; Tue, 21 Oct 2025 09:07:10 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED74D1800451; Tue, 21 Oct 2025 09:07:08 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 41/43] audio: drop needless list of FE
Date: Tue, 21 Oct 2025 13:03:12 +0400
Message-ID: <20251021090317.425409-42-marcandre.lureau@redhat.com>
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

Apparently, it was never used.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h    | 1 -
 include/qemu/audio.h | 1 -
 audio/audio.c        | 4 ----
 3 files changed, 6 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 0116ee6707..ef7a0de200 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -246,7 +246,6 @@ typedef struct AudioBE {
     void *drv_opaque;
 
     QEMUTimer *ts;
-    QLIST_HEAD (fe_listhead, AudioFE) fe_head;
     QLIST_HEAD (hw_in_listhead, HWVoiceIn) hw_head_in;
     QLIST_HEAD (hw_out_listhead, HWVoiceOut) hw_head_out;
     QLIST_HEAD (cap_listhead, CaptureVoiceOut) cap_head;
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index ab5367d28b..16c8877970 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -76,7 +76,6 @@ typedef struct AudioBE AudioBE;
 typedef struct AudioFE {
     char *name;
     AudioBE *be;
-    QLIST_ENTRY (AudioFE) entries;
 } AudioFE;
 
 typedef struct QEMUAudioTimeStamp {
diff --git a/audio/audio.c b/audio/audio.c
index e03da8c344..7c7801a6ce 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1620,7 +1620,6 @@ static void audio_be_init(Object *obj)
     QLIST_INIT (&s->hw_head_out);
     QLIST_INIT (&s->hw_head_in);
     QLIST_INIT (&s->cap_head);
-    QLIST_INIT (&s->fe_head);
     s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
 
     s->vmse = qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
@@ -1822,15 +1821,12 @@ bool AUD_register_fe (const char *name, AudioFE *card, Error **errp)
     }
 
     card->name = g_strdup (name);
-    memset (&card->entries, 0, sizeof (card->entries));
-    QLIST_INSERT_HEAD(&card->be->fe_head, card, entries);
 
     return true;
 }
 
 void AUD_unregister_fe (AudioFE *card)
 {
-    QLIST_REMOVE (card, entries);
     g_free (card->name);
 }
 
-- 
2.51.0


