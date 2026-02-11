Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FF5EB5954
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 10:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq73S-0000t0-4K; Wed, 11 Feb 2026 05:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq73Q-0000od-98
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:02:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq73O-0002zW-QB
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770804157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iS8/dntZN4zBsXF8Njo765W2B88ONbFZMmoLQ45zTic=;
 b=hpSq2Tv1/Zei3AoZiQrfM26m4E3lsxqiUWaGU3+114jF6rzA7CFjI8r6Bnw5ea0kPTrHGk
 pOnZG3cCtm0gegbIp+zmOEjoS2VxyKi/Rwx/wn4spWTOhtjv9VG1qTU5otJu7hpC2GkxqI
 Gc82Flp15zVZxaSme6BCI7vfNejkg0o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-D4gRtrSOMkmLVP8gFfyhPg-1; Wed,
 11 Feb 2026 05:02:34 -0500
X-MC-Unique: D4gRtrSOMkmLVP8gFfyhPg-1
X-Mimecast-MFC-AGG-ID: D4gRtrSOMkmLVP8gFfyhPg_1770804153
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C9D51955F12; Wed, 11 Feb 2026 10:02:33 +0000 (UTC)
Received: from localhost (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10B4019560B4; Wed, 11 Feb 2026 10:02:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Feb 2026 14:01:44 +0400
Subject: [PATCH 4/7] audio: require pulse >= 0.9.13
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260211-cleanups-v1-4-e63c96572389@redhat.com>
References: <20260211-cleanups-v1-0-e63c96572389@redhat.com>
In-Reply-To: <20260211-cleanups-v1-0-e63c96572389@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2441;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eNlFJzzbmzOFlrez/F/ZTWDdEg3Z9wDORaNsGyPZReM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpjFOVkIduquQGIEnI9ntt4g5LGXba7e+tIaTxT
 U7tuJU5ly2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaYxTlQAKCRDa6OEJdZac
 5UXrEACwiOXiuysM1hlzbo2GwBLRjTzP3CJb/opUGkzQXmWpRFer+fypyb+Ooex3bWPZqLbTtjD
 L62W7qiA7DbbK+H5Cxd3MMikgDfjxt3FzCAWsPku0T8R9eJVj0J/hM1WajdlFjZPX9ZPqN/mxjW
 1bDgHWe34U+N5m7TvZRBpBQ3LrX6oWSqUnKIb3UCjkHBauN9Imbp9ufGwS+BrFflJzSrzCpDTWK
 +sS2AZz11gwE+AdbipwyDbo1MULl0BASq58kLrjk2lRQJOnG77qwwJWhsfNKqhurTOJM/63z7R2
 IuQd25ye/Q6sdL1A6cOWPYGVghHV7ZAU2yJ55bH+qm5LVDG2HvbHbNChaIYU6rUuwLk4dNZeH4T
 8Tq6cyYHyqsxvAF3hY2+90aIZQUIdigvqQOtN+a+BOYhrrdCg9WBP3XHprsJ9d144+WQANInX3o
 fYYrXVxb+HG4Ibg54k9QiIkO2+cfzlaeCBXXTWHYbmdknvvDuHiuYtwzEHFYRLPVwKHsx8KdcEy
 /s44lPzeorEZSaxed1ZJW27kLZxAO0McSX/YKThrwUt+2LJHg8htYh5VjQQlSCFr2BfS0UjaPF3
 EKfuz+6CPCCDErRXdiJ+hGDv2JzYfyo/2J1Xrt0NIg81tUJ8uo6zm1624x9fBvwZfErJ2m4zze/
 m3oIozeqZ5mc2LA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

pulseaudio 0.9.13 was released on 2009-09-10. All our supported
distros have it.

PA_*_IS_GOOD are from 0.9.11.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build     |  2 +-
 audio/paaudio.c | 28 ++--------------------------
 2 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/meson.build b/meson.build
index 2d114e90184..fb89fbd1cc5 100644
--- a/meson.build
+++ b/meson.build
@@ -1283,7 +1283,7 @@ endif
 
 pulse = not_found
 if not get_option('pa').auto() or (host_os == 'linux' and have_system)
-  pulse = dependency('libpulse', required: get_option('pa'),
+  pulse = dependency('libpulse', version: '>=0.9.13', required: get_option('pa'),
                      method: 'pkg-config')
 endif
 alsa = not_found
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 0c06a397195..88c7c286689 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -54,26 +54,6 @@ static void G_GNUC_PRINTF (2, 3) qpa_logerr (int err, const char *fmt, ...)
     AUD_log (AUDIO_CAP, "Reason: %s\n", pa_strerror (err));
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
@@ -671,9 +651,7 @@ static void qpa_volume_out(HWVoiceOut *hw, Volume *vol)
     PAConnection *c = pa->g->conn;
     int i;
 
-#ifdef PA_CHECK_VERSION    /* macro is present in 0.9.16+ */
-    pa_cvolume_init (&v);  /* function is present in 0.9.13+ */
-#endif
+    pa_cvolume_init(&v);
 
     v.channels = vol->channels;
     for (i = 0; i < vol->channels; ++i) {
@@ -713,9 +691,7 @@ static void qpa_volume_in(HWVoiceIn *hw, Volume *vol)
     PAConnection *c = pa->g->conn;
     int i;
 
-#ifdef PA_CHECK_VERSION
-    pa_cvolume_init (&v);
-#endif
+    pa_cvolume_init(&v);
 
     v.channels = vol->channels;
     for (i = 0; i < vol->channels; ++i) {

-- 
2.52.0


