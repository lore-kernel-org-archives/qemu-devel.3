Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C206F589DA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuXr-0005bO-9A; Thu, 23 Apr 2026 09:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wFuX4-0005Wb-Kz
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:56:02 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wFuWt-0000cF-AI
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:55:48 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63NDtV0O080520
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 23 Apr 2026 22:55:32 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=LUD9ZuzLWd1LWP0Ys4/Osg9bdyCbmhuDYF4cvOBc8QE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1776952532; v=1;
 b=pq+a8bAK82rf1L8dNOlY+konlInhbzmOmh9OIngw9P8/A/NGl8jKANTryNWNlrXv
 i7VRHyxujS+MCkoukwzfs7DAkG8+cBFLDIpSR7QsL09mAzXC0OQiDVpIzi9BOp0i
 srIeE8mAVMLyQJHVw0zkk/CNGk/cTAH1RTfM5w8/48Zr+niJnKxlAePOVaCtWGpS
 RyPQGb35vymwCF9rYyONtLaTxNeqJwktVDdRL1/0gdr486oWDmABsj2zXmtfLVmK
 zunU8ue1HXum5JX9XxK4aB9UQ2iftObrlY2i+RJfoczAC5hYPILeCUL4KgyaFoqX
 LgWIYwcykpyJyWFZost5cA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 23 Apr 2026 22:55:23 +0900
Subject: [PATCH 3/3] audio: Use unsigned PCM bias
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-audio-v1-3-e1d6b65c76f9@rsg.ci.i.u-tokyo.ac.jp>
References: <20260423-audio-v1-0-e1d6b65c76f9@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260423-audio-v1-0-e1d6b65c76f9@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 audio/mixeng_template.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/audio/mixeng_template.h b/audio/mixeng_template.h
index 5b0014bdd9af..6db742188eda 100644
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


