Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271B0F589DA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuXu-0005c7-Hw; Thu, 23 Apr 2026 09:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wFuX6-0005Wf-EH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:56:06 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wFuWu-0000cN-IL
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:55:49 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63NDtV0N080520
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 23 Apr 2026 22:55:32 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=NJ8Xrq7/Gr7dXbQuNBgr3d2k02Fayw0AHQFCtvpC830=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1776952532; v=1;
 b=GclSL17061g855ue3rXOR6amc/B3nq3XfO9xZ8kr6JMX9tCpn0TXWlow0rLDnssP
 8EyP/Ss2FR3jRoPKHTyXasb2+VOsp0yRVm+Rda3pzX9EVdMRbXfv5c25OCX0ryml
 0k6A+Q85CsKD7HGr/hUXGpyKX9XU/X/4XMi9ln/4ZUtQylNxetA2OsL7ePyF6V/Q
 5oHPiWRak/N5SPvMoHxcKY1L3fGGPrJAXE2oSyYtNxB7BTrDexqs01fU+oHQAGeT
 nM6GcVUW/ph4ehtbUFaA1JPJ7YxX0GcxA6R6H2qJUIHCidOkZDq10NQjEzbDNzk1
 AAuGnMvdyYfdXsjV0mcv0g==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 23 Apr 2026 22:55:22 +0900
Subject: [PATCH 2/3] audio: Clamp unsigned sample conversion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-audio-v1-2-e1d6b65c76f9@rsg.ci.i.u-tokyo.ac.jp>
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

clip_*_uint32_t() returns 0 when v == 1.f because it computes the result
as (IN_T)((v * ((mixeng_real)IN_MAX / 2.f)) + HALF):

- (v * ((mixeng_real)IN_MAX / 2.f)) + HALF == 0x100000000.f, which does
  not fit in uint32_t.
- (v * ((mixeng_real)IN_MAX / 2.f)) == 0x80000000.f
- ((mixeng_real)IN_MAX / 2.f) == 0x80000000.f
- (mixeng_real)IN_MAX == 0x100000000.f because 0xffffffff cannot be
  represented exactly in float.
- HALF == 0x7fffffff, which is implicitly converted to 0x80000000.f.

Clamp the result to avoid the overflow.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 audio/mixeng_template.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/audio/mixeng_template.h b/audio/mixeng_template.h
index 881653c44bfb..5b0014bdd9af 100644
--- a/audio/mixeng_template.h
+++ b/audio/mixeng_template.h
@@ -65,7 +65,9 @@ static inline IN_T glue (clip_, ET) (mixeng_real v)
 #ifdef SIGNED
     return ENDIAN_CONVERT((IN_T)(v * (((mixeng_real)IN_MAX - IN_MIN) / 2.f)));
 #else
-    return ENDIAN_CONVERT((IN_T)((v * ((mixeng_real)IN_MAX / 2.f)) + HALF));
+    return ENDIAN_CONVERT(MIN((int64_t)((v * ((mixeng_real)IN_MAX / 2.f)) +
+                                        HALF),
+                              IN_MAX));
 #endif
 }
 

-- 
2.53.0


