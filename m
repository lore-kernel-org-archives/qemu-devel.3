Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0825FCD98CF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 00:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYYOB-00040E-TB; Sat, 13 Jun 2026 20:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan.reinauer@coreboot.org>)
 id 1wYYLM-0003YV-HT
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 20:04:53 -0400
Received: from mail.coreboot.org ([78.46.105.101] helo=coreboot.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan.reinauer@coreboot.org>)
 id 1wYYLJ-0007yb-7o
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 20:04:51 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
 by coreboot.org (Postfix) with ESMTPA id 3EB6454E375;
 Sun, 14 Jun 2026 00:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coreboot.org;
 s=dkim; t=1781395484; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:references; bh=TYDAdOJZr6nGqG8F99mrDM7OvCErUwsanrSgoOzRGuY=;
 b=Cm/63EPhbbu28U+tB029ENQM26lHDbPKfXeOP9vGiVOAvsTp/4YmPVXzsMKxjl1JnKkn0M
 3u5Hx56BJBZQrLuSbwGt3sKweZ6OtApMGhRTerXq1t95XZGuXwGDr8m/Rk7Oami86fHBU1
 J4mzGMyDB+9NCicHbfXgBLhVZZE8j5Y=
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@mailo.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com, Stefan Reinauer <stefan.reinauer@coreboot.org>
Subject: [PATCH] ui/cocoa: fix artifacts from scaled partial redraws
Date: Sat, 13 Jun 2026 17:04:09 -0700
Message-ID: <20260614000409.63735-1-stefan.reinauer@coreboot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=coreboot.org;
 s=dkim; t=1781395484; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:references; bh=TYDAdOJZr6nGqG8F99mrDM7OvCErUwsanrSgoOzRGuY=;
 b=MhhbGTT4eC3U5SmJ2wThrjJpTXA7gUgE9jkZROtFVuegMTFvV2TcXhIp7o6t+CjPIs5iFr
 Tyf9b9w9BFykHUbLgUXAs167p+hU6Q3UZs4woXDtuTKHEg/+1Po4eaSfudc3rkd2jc0Uv3
 cscSv2Xi9oSgrwEzL7+bVGumU+O0mXo=
ARC-Seal: i=1; s=dkim; d=coreboot.org; t=1781395484; a=rsa-sha256; cv=none;
 b=O6QMeWFcmZkzVJ+z70PEqgCx36DV0OoJsJdTUqKW9vnue+SkocVYRNogV1ZRKU4AWwCQWz9u7NsIrgUkfGRyAPg4Qo1Q44f7wSfv3bEeaGNJ6QBXFq0BlY70ZX6H5fl0zEC6jNLG9uSy7Rxyb7E2CKqAWteGLdqveMOlINKnq8M=
ARC-Authentication-Results: i=1; coreboot.org;
 auth=pass smtp.auth=stepan@coreboot.org
 smtp.mailfrom=stefan.reinauer@coreboot.org
X-Spamd-Bar: +++++
Authentication-Results: coreboot.org; auth=pass smtp.auth=stepan@coreboot.org
 smtp.mailfrom=stefan.reinauer@coreboot.org
Received-SPF: pass client-ip=78.46.105.101;
 envelope-from=stefan.reinauer@coreboot.org; helo=coreboot.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 13 Jun 2026 20:07:43 -0400
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
Reply-to:  Stefan Reinauer <stefan.reinauer@coreboot.org>
From:  Stefan Reinauer via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Under zoom-to-fit, Cocoa redrew each dirty rect by cropping the
guest CGImage and drawing that crop into the dirty destination
rect. With non-integer scales, adjacent partial updates could sample
the source with different phase. Moving cursor updates then showed
one-line stretch/skew artifacts at the dirty band boundary.

Keep using AppKit's dirty-region clipping, but draw the full guest
image into the view bounds. Each partial update then uses the same
source transform while drawing remains limited to invalidated
regions.

Signed-off-by: Stefan Reinauer <stefan.reinauer@coreboot.org>
---
 ui/cocoa.m | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index c5e639ab98..f294c20720 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -551,24 +551,13 @@ - (void) drawRect:(NSRect) rect
             0, //interpolate
             kCGRenderingIntentDefault //intent
         );
-        // selective drawing code (draws only dirty rectangles) (OS X >= 10.4)
-        const NSRect *rectList;
-        NSInteger rectCount;
-        int i;
-        CGImageRef clipImageRef;
-        CGRect clipRect;
-
-        [self getRectsBeingDrawn:&rectList count:&rectCount];
-        for (i = 0; i < rectCount; i++) {
-            clipRect = rectList[i];
-            clipRect.origin.y = (float)h - (clipRect.origin.y + clipRect.size.height);
-            clipImageRef = CGImageCreateWithImageInRect(
-                                                        imageRef,
-                                                        clipRect
-                                                        );
-            CGContextDrawImage (viewContextRef, cgrect(rectList[i]), clipImageRef);
-            CGImageRelease (clipImageRef);
-        }
+        NSRect imageRect = NSMakeRect(0, 0, w, h);
+
+        /*
+         * AppKit already clips drawing to the dirty region. Draw the full
+         * guest image so scaled partial updates use a stable source transform.
+         */
+        CGContextDrawImage(viewContextRef, cgrect(imageRect), imageRef);
         CGImageRelease (imageRef);
         CGDataProviderRelease(dataProviderRef);
     }
-- 
2.50.1 (Apple Git-155)


