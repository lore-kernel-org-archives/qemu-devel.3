Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2043C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 13:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJBOS-0007ca-St; Sun, 25 May 2025 09:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uJBON-0007Zt-L1
 for qemu-devel@nongnu.org; Sun, 25 May 2025 09:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uJBOL-0003MU-TB
 for qemu-devel@nongnu.org; Sun, 25 May 2025 09:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748179673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dFvrH2+9GANTq3N03obPSF9VQnhO5Ah93xhdKnav2dY=;
 b=GMu9ntdFQxfpceQfjR875R+vdnk6Yi22wya85WP5nUd8mil6nzBfuTkPie116FFWE3yEDd
 KTm4XKa8b1SngprxXg/Zgt7/YXYuB3i1MSXdUEb3OuAws2ursgD2lLRBSE+hJJ8qD0NBnA
 LGzJbYQZVcI+qipa1YC00HOcbotpw84=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-sIypGuJJN22k1EBZFpOKUQ-1; Sun,
 25 May 2025 09:27:51 -0400
X-MC-Unique: sIypGuJJN22k1EBZFpOKUQ-1
X-Mimecast-MFC-AGG-ID: sIypGuJJN22k1EBZFpOKUQ_1748179670
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB806180045C; Sun, 25 May 2025 13:27:50 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A9CB1956095; Sun, 25 May 2025 13:27:48 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 9/9] audio: Reset rate control when adding bytes
Date: Sun, 25 May 2025 15:27:16 +0200
Message-ID: <20250525132717.527392-10-marcandre.lureau@redhat.com>
In-Reply-To: <20250525132717.527392-1-marcandre.lureau@redhat.com>
References: <20250525132717.527392-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Commit 90320051ea99 ("spiceaudio: add a pcm_ops buffer_get_free
function") caused to emit messages saying "Resetting rate control"
frequently when the guest generates no frames.

audio_rate_peek_bytes() resets the rate control when frames < 0 ||
frames > 65536 where frames is the rate-limited number of frames.
Resetting when frames < 0 is sensible as the number simply doesn't make
sense.

There is a problem when frames > 65536. It implies the guest stopped
generating frames for a while so it makes sense to reset the rate
control when the guest resumed generating frames. However, the
commit mentioned earlier broke this assumption by letting spiceaudio
call audio_rate_peek_bytes() whether the guest is generating frames or
not.

Reset the rate control in audio_rate_add_bytes(), which is called only
when actually adding frames, according to the previous call to
audio_rate_peek_bytes() to avoid frequent rate control resets even when
the guest generates no frame.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250317-rate-v1-1-da9df062747c@daynix.com>
---
 audio/audio_int.h |  1 +
 audio/audio.c     | 14 ++++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 2d079d00a2..f78ca05f92 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -255,6 +255,7 @@ const char *audio_application_name(void);
 typedef struct RateCtl {
     int64_t start_ticks;
     int64_t bytes_sent;
+    int64_t peeked_frames;
 } RateCtl;
 
 void audio_rate_start(RateCtl *rate);
diff --git a/audio/audio.c b/audio/audio.c
index b58ad74433..89f091bc88 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2283,17 +2283,19 @@ size_t audio_rate_peek_bytes(RateCtl *rate, struct audio_pcm_info *info)
     ticks = now - rate->start_ticks;
     bytes = muldiv64(ticks, info->bytes_per_second, NANOSECONDS_PER_SECOND);
     frames = (bytes - rate->bytes_sent) / info->bytes_per_frame;
-    if (frames < 0 || frames > 65536) {
-        AUD_log(NULL, "Resetting rate control (%" PRId64 " frames)\n", frames);
-        audio_rate_start(rate);
-        frames = 0;
-    }
+    rate->peeked_frames = frames;
 
-    return frames * info->bytes_per_frame;
+    return frames < 0 ? 0 : frames * info->bytes_per_frame;
 }
 
 void audio_rate_add_bytes(RateCtl *rate, size_t bytes_used)
 {
+    if (rate->peeked_frames < 0 || rate->peeked_frames > 65536) {
+        AUD_log(NULL, "Resetting rate control (%" PRId64 " frames)\n",
+                rate->peeked_frames);
+        audio_rate_start(rate);
+    }
+
     rate->bytes_sent += bytes_used;
 }
 
-- 
2.49.0


