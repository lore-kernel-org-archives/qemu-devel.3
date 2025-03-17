Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9851CC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 08:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu5Ti-0001GE-6D; Mon, 17 Mar 2025 04:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tu5Tg-0001Fx-71
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 04:05:40 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tu5Tc-0002N7-7B
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 04:05:39 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2232aead377so88441135ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 01:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742198734; x=1742803534;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+u76pSQIDiqGW7JaPMss1jeI0wFCMu7PkI6YxE1sgaw=;
 b=XIVMuyBjbCIunZL83BLxYFLpvJgaKAbRwQPfs2Lx/Q5pSthiDQ2hL+q0QTSFCd+9MI
 mOO42c88gdxqr0QWSmcAaq3xtYlDE6zpwWDRomWo25svM7GZxJPq/WCVnGAzYCcQ+1UJ
 S+wldU5RMLAf3zQKk6tC3mNqcOesMi4tVx1NUZKB6OL5tLRBHrJ9acNmMMDeIi7Xqgok
 ebqqYl2uTdcl66iXvF54syup1jXKO7AriDVxk47navBJwJUL/91/VRQ8hTGuE52ceQj+
 YCp/tq4ikH5ynfCKjVpqdNvgAbinDzz1rnWR/UyNNRbUejvkqrk8r8eXfEUPZTgBIw7g
 sumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742198734; x=1742803534;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+u76pSQIDiqGW7JaPMss1jeI0wFCMu7PkI6YxE1sgaw=;
 b=Jng9916kXFg647H0LRLDB8EW4AnmI4PNnYXJwxdMX6d5npfiBY5PrMFcOViUmrH6VK
 y6v4SSW3mDTLJ6gHX1b7+xn12PIs5goM0HhtdjN2T3hrfSRtGF9Qu7CBZPCXySJvrA3k
 aInYBBIr0enbgn9/TLl6Iz8Hm1JyuoOjJmP/nHUQWFpAR/Ukt6ZTKe32EsNqGoaZPkQv
 c+vO55jJlaPvY2ZndgK515Na98vdnGPs0QMTYFFTfaRu5YUWfSZpFnrLbyH/D7nA5ipt
 apRqN9Y3IFejoi65JUYVOduY3GSi4zfd5IRnrI+/suI2mXaMiEw23XIAtemIj6MmdIHp
 SaGg==
X-Gm-Message-State: AOJu0YxTKNm8S8prXYWHNS+HRIvogId1Oo3Mi6Wmkwrf6NISEBHIjKOp
 r/dBOX9MHqRSc0NnfSpvZhX7z3hyAgPWaCUU/9t4rUEcICVd5wRA1FbxMeyCvAgissft/DVgumY
 iycY=
X-Gm-Gg: ASbGncvALDIKongEFetjbplrdpn/GValdl3Ztn5LrkZ9z5MUwIB23hmXMV7E/aynd90
 VP7rfBcn5DffUoxjvlYLCvYdGxlRtvSxnI8lV/wMOlolFDR4/MGUV4/dJKwRQf2k8/+CwpfW1k6
 LrLpJHafSUcOrwqELu7KB1A+vTCiV2X8qe77G4Ivx7ku73kkkZfClpd8RzLEy18gna8oEv3sJ05
 2UuGnn00w0G+gf7n6QA3h8dQwAXszk2gC3BB30aRlJ2SbFXoZTeRjCJlyT/z+BaNUfwvFBFDj4n
 lxL8ycZzCfvDjGgjOzm0118VelyJTzFY2D1qV9oKzlDeILjR
X-Google-Smtp-Source: AGHT+IEmyC5dyCPoLgaSPYPXo9aSlu3ZWMkpluYsm4z6Z1KX1AiSzw9kEj9fP/FSYkcPXsbV0NJdow==
X-Received: by 2002:a17:903:3c48:b0:223:f408:c3f7 with SMTP id
 d9443c01a7336-225e0a363cemr154801245ad.16.1742198733716; 
 Mon, 17 Mar 2025 01:05:33 -0700 (PDT)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-225c6bd3d45sm69126955ad.220.2025.03.17.01.05.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 01:05:33 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 17 Mar 2025 17:05:29 +0900
Subject: [PATCH] audio: Reset rate control when adding bytes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rate-v1-1-da9df062747c@daynix.com>
X-B4-Tracking: v=1; b=H4sIAMjX12cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0Nz3aLEklRdYwOLZNNkc8s0U4M0JaDSgqLUtMwKsDHRsbW1ADdrTQB
 WAAAA
X-Change-ID: 20250317-rate-308c5c79f50f
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 audio/audio_int.h |  1 +
 audio/audio.c     | 14 ++++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 2d079d00a259..f78ca05f92fb 100644
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
index 41ee11aaad6d..049d9d07aa58 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2274,17 +2274,19 @@ size_t audio_rate_peek_bytes(RateCtl *rate, struct audio_pcm_info *info)
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
 

---
base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
change-id: 20250317-rate-308c5c79f50f

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


