Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5BEFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHdap-0007Nb-Cy; Tue, 28 Apr 2026 04:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdaU-0006oE-PI
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHdaT-0006AK-1b
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777364072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=msfcYbXdPoxDb4VF0TVAMI3ngZnG5gWrGEoAA3b9h/I=;
 b=YfqUTIe5Z6c9Kk4qVSWyxgfqXHhTfx15usWAKYtHTzXY6GJi+3QSCub9CZ/rNyMnd3hdWJ
 bqBu0UgMaKha6Pe7IlNTmf5XNHOK5WWVFWNM6B76iwP+Cdu505SgJ5he0MejhT/hDe5O0J
 lol5WSzzxBW/Q+l6fLlLN3FqqNjRKQg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-wKHKDJdlOJCTK1bjJnrX0Q-1; Tue,
 28 Apr 2026 04:14:28 -0400
X-MC-Unique: wKHKDJdlOJCTK1bjJnrX0Q-1
X-Mimecast-MFC-AGG-ID: wKHKDJdlOJCTK1bjJnrX0Q_1777364067
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C31FE195609E; Tue, 28 Apr 2026 08:14:27 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5C4119560B7; Tue, 28 Apr 2026 08:14:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 13/15] audio: Use unsigned PCM bias
Date: Tue, 28 Apr 2026 12:13:00 +0400
Message-ID: <20260428081303.990973-14-marcandre.lureau@redhat.com>
In-Reply-To: <20260428081303.990973-1-marcandre.lureau@redhat.com>
References: <20260428081303.990973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Clang warns for the uint32_t clip_ instantiations because HALF cannot be
represented with mixeng_real:

[1115/2559] Compiling C object libqemuaudio.a.p/audio_mixeng.c.o
In file included from ../../qemu/audio/mixeng.c:147:
../../qemu/audio/mixeng_template.h:68:70: warning: implicit conversion from 'unsigned int' to 'float' changes value from 2147483647 to 2147483648 [-Wimplicit-const-int-float-conversion]
   68 |     return ENDIAN_CONVERT((IN_T)((v * ((mixeng_real)IN_MAX / 2.f)) + HALF));
      |            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
../../qemu/audio/mixeng_template.h:31:22: note: expanded from macro 'HALF'
   31 | #define HALF (IN_MAX >> 1)
      |                      ^
../../qemu/audio/mixeng.c:146:28: note: expanded from macro 'ENDIAN_CONVERT'
  146 | #define ENDIAN_CONVERT(v) (v)
      |                            ^
In file included from ../../qemu/audio/mixeng.c:152:
../../qemu/audio/mixeng_template.h:68:70: warning: implicit conversion from 'unsigned int' to 'float' changes value from 2147483647 to 2147483648 [-Wimplicit-const-int-float-conversion]
   68 |     return ENDIAN_CONVERT((IN_T)((v * ((mixeng_real)IN_MAX / 2.f)) + HALF));
      |            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
../../qemu/audio/mixeng_template.h:31:22: note: expanded from macro 'HALF'
   31 | #define HALF (IN_MAX >> 1)
      |                      ^
../../qemu/audio/mixeng.c:151:36: note: expanded from macro 'ENDIAN_CONVERT'
  151 | #define ENDIAN_CONVERT(v) bswap32 (v)
      |                           ~~~~~~~~~^~
/Users/person/v/qemu/include/qemu/bswap.h:10:39: note: expanded from macro 'bswap32'
   10 | #define bswap32(_x) __builtin_bswap32(_x)
      |                                       ^~
2 warnings generated.

HALF is not the right value here anyway. IN_MAX is odd, so the integer
sample range has two middle codes. Unsigned PCM normally uses the upper
middle code as the "bias": 0x80, 0x8000, or 0x80000000. HALF is instead
defined as the lower middle code: 0x7f, 0x7fff, or 0x7fffffff.

Replace HALF with BIAS, defined as the upper middle code. This fixes the
warnings, since the value can be exactly represented with mixeng_real.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260423-audio-v1-3-e1d6b65c76f9@rsg.ci.i.u-tokyo.ac.jp>
---
 audio/mixeng_template.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/audio/mixeng_template.h b/audio/mixeng_template.h
index 5b0014bdd9a..6db742188ed 100644
--- a/audio/mixeng_template.h
+++ b/audio/mixeng_template.h
@@ -28,7 +28,7 @@
  */
 
 #ifndef SIGNED
-#define HALF (IN_MAX >> 1)
+#define BIAS ((IN_T)1 << (SHIFT - 1))
 #endif
 
 #define ET glue (ENDIAN_CONVERSION, glue (glue (glue (_, ITYPE), BSIZE), _t))
@@ -43,13 +43,13 @@ static inline mixeng_real glue (conv_, ET) (IN_T v)
 #ifdef SIGNED
     return nv * (2.f / ((mixeng_real)IN_MAX - IN_MIN));
 #else
-    return ((mixeng_real)nv - HALF) * (2.f / (mixeng_real)IN_MAX);
+    return ((mixeng_real)nv - BIAS) * (1.f / BIAS);
 #endif
 #else  /* !RECIPROCAL */
 #ifdef SIGNED
     return nv / (((mixeng_real)IN_MAX - IN_MIN) / 2.f);
 #else
-    return ((mixeng_real)nv - HALF) / ((mixeng_real)IN_MAX / 2.f);
+    return ((mixeng_real)nv - BIAS) / BIAS;
 #endif
 #endif
 }
@@ -65,9 +65,7 @@ static inline IN_T glue (clip_, ET) (mixeng_real v)
 #ifdef SIGNED
     return ENDIAN_CONVERT((IN_T)(v * (((mixeng_real)IN_MAX - IN_MIN) / 2.f)));
 #else
-    return ENDIAN_CONVERT(MIN((int64_t)((v * ((mixeng_real)IN_MAX / 2.f)) +
-                                        HALF),
-                              IN_MAX));
+    return ENDIAN_CONVERT(MIN((int64_t)(v * BIAS) + BIAS, IN_MAX));
 #endif
 }
 
@@ -79,7 +77,7 @@ static inline int64_t glue (conv_, ET) (IN_T v)
 #ifdef SIGNED
     return ((int64_t) nv) << (32 - SHIFT);
 #else
-    return ((int64_t) nv - HALF) << (32 - SHIFT);
+    return ((int64_t) nv - BIAS) << (32 - SHIFT);
 #endif
 }
 
@@ -94,7 +92,7 @@ static inline IN_T glue (clip_, ET) (int64_t v)
 #ifdef SIGNED
     return ENDIAN_CONVERT ((IN_T) (v >> (32 - SHIFT)));
 #else
-    return ENDIAN_CONVERT ((IN_T) ((v >> (32 - SHIFT)) + HALF));
+    return ENDIAN_CONVERT((IN_T)((v >> (32 - SHIFT)) + BIAS));
 #endif
 }
 #endif
@@ -150,5 +148,5 @@ static void glue (glue (clip_, ET), _from_mono)
 }
 
 #undef ET
-#undef HALF
+#undef BIAS
 #undef IN_T
-- 
2.53.0


