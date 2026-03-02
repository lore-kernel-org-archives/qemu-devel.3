Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42736C624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzf-0007tF-MW; Mon, 02 Mar 2026 03:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyx1-0003IA-BT
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywz-0002EQ-P3
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kvfH/m3MJ3pc+JdzR3PQMiTgKe/mfGqHZA38rC7Xew=;
 b=UUJkKIY2cMFp43VyHWqW/RYA/qco4yEA+QXPmrHTdsGBoVhmwH668IhzfBlrdOZuEvWTtw
 3TnHNXG8eD+VwUd+oYdDMca/RLus0XgZhGcURFLd7vsZT8/LRYbM2jx6lBkIj3AOMWbn9E
 6SbATGlxXIOlbUrQvypDpcFa1Ppq1ZQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-5MxQ37k6NJSHU0XosJPdQg-1; Mon, 02 Mar 2026 03:48:24 -0500
X-MC-Unique: 5MxQ37k6NJSHU0XosJPdQg-1
X-Mimecast-MFC-AGG-ID: 5MxQ37k6NJSHU0XosJPdQg_1772441303
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439a9182148so877397f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441302; x=1773046102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kvfH/m3MJ3pc+JdzR3PQMiTgKe/mfGqHZA38rC7Xew=;
 b=gt/YRATuDU7LSyaZds1bne8+O4RS5SGKE5XztKJTACTBdP0Ph9OZfQzYYlqL9Gbojs
 9ODQIYfd1tkXCNtyk1PqxIY20K6sZ3HRWQsu2P45XvlVDfcVvy6fPesjSoQEv4giUF0a
 bJv9qxr1FUOB/cMHRmGwJ8SUjikku9zOZRSFmPe/nZvvNqltYKmbBui/iqsAqewLoJyN
 gPRxhIbeKYBB/xuAcWPuP6YtwklwGzeGRoQoUoBN/63XfCETfS/VEVD9KhiOOPdrDJOm
 zpDMli7YZufiXXClmfxS1Upv4Ky1vClHcxI36n2Ta+fL9C4vvJlkQRXvNINlMae7T/G0
 B/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441302; x=1773046102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5kvfH/m3MJ3pc+JdzR3PQMiTgKe/mfGqHZA38rC7Xew=;
 b=gs3Jv75Rueg+Hh/drakLhxlvyCLbeqLDJ40i3X+BwVpuDJHaPC92M7rGZv6AZW3Zwv
 fcvKbaXWA78eB8sKyXhiSFHRbLFkLuUahDnIjOxgo/k7t7ntswpDlN3hJWf2bs/I/t3Y
 bZhaergZ2w97LGbmnwNpyu1UMIBssZpSX9fcE9qdUoTZJvN73vAoVXC3J9OKzBrhCWQ5
 hlEq+Zau48qqu+h/N3+/fpvlicDUOZFKQA8XDeSpqD1M8pJxndr79m3Cf9gy9+trZf8a
 U4dX2wVMrR+gZ3bPhsfjVmGWbBDdio/ymJLFMweKOpWs4Yl1iohU+ZZF+B+3MS+kETaf
 WItw==
X-Gm-Message-State: AOJu0YyNTmLw75c8MZWYTGNg2yCX3RQWYJszbH+pz7V2C6tXneQ6Obeq
 biJoCjjh37LDOvoPn+mQhP93pVPlmtOu6ypMaQaZ4/b7hhzDtYK2gEJ3Kv/tFmZHJUsHCy1EMCg
 0RnISoxElQVcnF6GtZm37AktebY9f2LOCjCeKHtlqznp/6EDba1MWZaMatT9exYDF9DjgArqZ+7
 R4HcNAoC1B7WtjUjzMBAjIwglDBHB+od0CdGPw8jaH
X-Gm-Gg: ATEYQzwlsHiVA7sitJP4KoWlIfCktv2UjNvxPwFnBDIdU3wbDwwbNmNM97b4AUgFof0
 /Gowl1m8gVgpT37PvJzdbzituUnyBgA/zF57FSpqjo0YtIFXzn8qoYYj/hEIx/wVkfG0WfaxZcZ
 DbHaoilE1rAWMtpdAFjjQf/fqMcYV3hrUNDRcrQ0esdSvrTAAK+js9/4TtD1KU2X+xB3Ja/B7k9
 fJ1SwLEhiX7j+jRnCX1FNWy+HssRLjognN4KedFQNtol9Y2JwE/z7saWEc3ELT33Y2dT3NvBSBJ
 uy3vJRjcs5JiJ8Iic0xlLCCRqZXdHh5Hrw7/mOVDZ+VgcNtDV8w9QqtaTHIHGJ6vCtWBtFgAx25
 /+AZSBwv0Dcefd0gkjeNrkAdf6+7QmT2s0ChqN9AgcN4ts7IsqyCljOcR2oAkECSKyst1m7HL3b
 LhWvpZPzjfxyKzD15FQWI/bVtgzb8=
X-Received: by 2002:a05:6000:4022:b0:439:b3f8:7753 with SMTP id
 ffacd0b85a97d-439b3f877ffmr7664295f8f.44.1772441301938; 
 Mon, 02 Mar 2026 00:48:21 -0800 (PST)
X-Received: by 2002:a05:6000:4022:b0:439:b3f8:7753 with SMTP id
 ffacd0b85a97d-439b3f877ffmr7664252f8f.44.1772441301445; 
 Mon, 02 Mar 2026 00:48:21 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439bb69e098sm2236858f8f.9.2026.03.02.00.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 079/102] audio: require pulse >= 0.9.13
Date: Mon,  2 Mar 2026 09:47:25 +0100
Message-ID: <20260302084749.474955-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

pulseaudio 0.9.13 was released on 2009-09-10. All our supported
distros have it.

PA_*_IS_GOOD are from 0.9.11.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20260211-cleanups-v1-4-e63c96572389@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build     |  2 +-
 audio/paaudio.c | 28 ++--------------------------
 2 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/meson.build b/meson.build
index cbd6d90ce64..11f83cf05c4 100644
--- a/meson.build
+++ b/meson.build
@@ -1298,7 +1298,7 @@ endif
 
 pulse = not_found
 if not get_option('pa').auto() or (host_os == 'linux' and have_system)
-  pulse = dependency('libpulse', required: get_option('pa'),
+  pulse = dependency('libpulse', version: '>=0.9.13', required: get_option('pa'),
                      method: 'pkg-config')
 endif
 alsa = not_found
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 23e8767a46b..24327ecbf45 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -62,26 +62,6 @@ static void G_GNUC_PRINTF(2, 3) qpa_logerr(int err, const char *fmt, ...)
     error_printf(" Reason: %s\n", pa_strerror(err));
 }
 
-#ifndef PA_CONTEXT_IS_GOOD
-static inline int PA_CONTEXT_IS_GOOD(pa_context_state_t x)
-{
-    return
-        x == PA_CONTEXT_CONNECTING ||
-        x == PA_CONTEXT_AUTHORIZING ||
-        x == PA_CONTEXT_SETTING_NAME ||
-        x == PA_CONTEXT_READY;
-}
-#endif
-
-#ifndef PA_STREAM_IS_GOOD
-static inline int PA_STREAM_IS_GOOD(pa_stream_state_t x)
-{
-    return
-        x == PA_STREAM_CREATING ||
-        x == PA_STREAM_READY;
-}
-#endif
-
 #define CHECK_SUCCESS_GOTO(c, expression, label, msg)           \
     do {                                                        \
         if (!(expression)) {                                    \
@@ -682,9 +662,7 @@ static void qpa_volume_out(HWVoiceOut *hw, Volume *vol)
     PAConnection *c = pa->g->conn;
     int i;
 
-#ifdef PA_CHECK_VERSION    /* macro is present in 0.9.16+ */
-    pa_cvolume_init (&v);  /* function is present in 0.9.13+ */
-#endif
+    pa_cvolume_init(&v);
 
     v.channels = vol->channels;
     for (i = 0; i < vol->channels; ++i) {
@@ -724,9 +702,7 @@ static void qpa_volume_in(HWVoiceIn *hw, Volume *vol)
     PAConnection *c = pa->g->conn;
     int i;
 
-#ifdef PA_CHECK_VERSION
-    pa_cvolume_init (&v);
-#endif
+    pa_cvolume_init(&v);
 
     v.channels = vol->channels;
     for (i = 0; i < vol->channels; ++i) {
-- 
2.53.0


