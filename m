Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D54CD111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ21a-00034F-Nq; Mon, 01 Dec 2025 06:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ21X-00031f-Cy
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ21V-0006dz-U8
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OqqV1rAyj9tFNJdjrOVW2/JSZTxqKWI42PQNdQQe5eI=;
 b=FpvD4+/TnvNWDcz1xWJ72DCGzECw9lvz69PyBvpBrmbvp0ExGAj2SQBVsXE64tyJJAfkTb
 kfCyPYOX/Pz8OIQkasRus8ljykr+k7Ca31WPkNVq7m2bD/nahUsXvL5jzqou3gtmxyiNpc
 6OP5EnGjUzXF3mQQaG+zhzKcvcL1Avs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-bTz3ri5gPo-1cjdBBNi0ww-1; Mon,
 01 Dec 2025 06:24:50 -0500
X-MC-Unique: bTz3ri5gPo-1cjdBBNi0ww-1
X-Mimecast-MFC-AGG-ID: bTz3ri5gPo-1cjdBBNi0ww_1764588289
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8789F1955DA0; Mon,  1 Dec 2025 11:24:48 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E6B6819560A7; Mon,  1 Dec 2025 11:24:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 14/24] audio: make list type declaration private
Date: Mon,  1 Dec 2025 15:22:55 +0400
Message-ID: <20251201112309.4163921-15-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

No need to share in a common header.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h | 7 -------
 audio/audio.c     | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index eaf7838bfe..3bf1cf6a99 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -313,13 +313,6 @@ static inline size_t audio_ring_posb(size_t pos, size_t dist, size_t len)
 #define ldebug(fmt, ...) (void)0
 #endif
 
-typedef struct AudiodevListEntry {
-    Audiodev *dev;
-    QSIMPLEQ_ENTRY(AudiodevListEntry) next;
-} AudiodevListEntry;
-
-typedef QSIMPLEQ_HEAD(, AudiodevListEntry) AudiodevListHead;
-
 void audio_create_pdos(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev);
diff --git a/audio/audio.c b/audio/audio.c
index 8523f14daa..138d7b502a 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -67,6 +67,13 @@ const char *audio_prio_list[] = {
     NULL
 };
 
+typedef struct AudiodevListEntry {
+    Audiodev *dev;
+    QSIMPLEQ_ENTRY(AudiodevListEntry) next;
+} AudiodevListEntry;
+
+typedef QSIMPLEQ_HEAD(, AudiodevListEntry) AudiodevListHead;
+
 static AudiodevListHead audiodevs =
     QSIMPLEQ_HEAD_INITIALIZER(audiodevs);
 static AudiodevListHead default_audiodevs =
-- 
2.51.1


