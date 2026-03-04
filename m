Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1653EEDEC15
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 06:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxfu4-0004yk-TV; Wed, 04 Mar 2026 01:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfu2-0004yJ-FV
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:40:14 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxftz-0000qL-Fv
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:40:14 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6246dwEr074749
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Mar 2026 15:40:05 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=uiDAyBXouj22eUWFhokQX4KFXK1lSSIaDtmLd84yPQE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772606405; v=1;
 b=Y54ZN6wxCP1o1DgNFOMtGnok6BVG5FFIT7GBBkAdb5CIFLIwcd0pI31svbLh4wNg
 zqLHpOvazVX8pP5O1c+n6+Dnlq4iQlJDW6jj1K+txbZcNfflOqGacGC1CvyMgpWA
 mTlPO+4UoFOP+kt86gNjREItFT0H5irPVa03XTWeeYhI4i+0tRUE4OiIdyyZZAeO
 zhSmus8/PVdKl/dV0bcTFOpU60A18e/LS3HhchRRsZXMWkEUaFSqVUzCdeIEUlHz
 IkEfGSfF5I+VWiiwuMKEv4QSP3CI0ytQWZ3UczGLpBToWFLIuheM18K/GgOBryJQ
 LLQ3isKyP66hS2vc9MMRXw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 04 Mar 2026 15:39:53 +0900
Subject: [PATCH v2] ui/cocoa: Do not automatically zoom for HiDPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-zoom-v2-1-2eebf2b51106@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIALjTp2kC/13MQQ7CIBCF4as0sxbDUKzVlfcwXSAMdhYtBgxpb
 bi72KXL/+Xl2yBRZEpwbTaIlDlxmGuoQwN2NPOTBLvaoKTSssVefEKYhPPadX2r6dQ9oF5fkTw
 vO3Mfao+c3iGuu5rxt/4BGQUKeTYOtbeO8HJzZp15OdowwVBK+QKvFoSLmQAAAA==
X-Change-ID: 20240318-zoom-df4d6834e56b
To: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
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

Cocoa automatically zooms for a HiDPI display like Retina and makes
the display blurry. Revert the automatic zooming.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v2:
- Rebased.
- Link to v1: https://lore.kernel.org/r/20240318-zoom-v1-1-07ad14fcde19@daynix.com
---
 ui/cocoa.m | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 23b7a736d700..7c46a16968ed 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -627,7 +627,10 @@ - (void) resizeWindow
     [[self window] setContentAspectRatio:NSMakeSize(screen.width, screen.height)];
 
     if (!([[self window] styleMask] & NSWindowStyleMaskResizable)) {
-        [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
+        CGFloat width = screen.width / [[self window] backingScaleFactor];
+        CGFloat height = screen.height / [[self window] backingScaleFactor];
+
+        [[self window] setContentSize:NSMakeSize(width, height)];
         [[self window] center];
     } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) {
         [[self window] setContentSize:[self fixAspectRatio:[self screenSafeAreaSize]]];
@@ -685,8 +688,8 @@ - (void) updateUIInfoLocked
 
     info.xoff = 0;
     info.yoff = 0;
-    info.width = frameSize.width;
-    info.height = frameSize.height;
+    info.width = frameSize.width * [[self window] backingScaleFactor];
+    info.height = frameSize.height * [[self window] backingScaleFactor];
 
     dpy_set_ui_info(dcl.con, &info, TRUE);
 }

---
base-commit: afe653676dc6dfd49f0390239ff90b2f0052c2b8
change-id: 20240318-zoom-df4d6834e56b

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


