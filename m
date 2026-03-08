Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1501EA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMkr-0007Qu-BX; Sun, 08 Mar 2026 18:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMkp-0007IB-HX
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:43 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMkn-0003YF-Sm
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:43 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b6d9c981so5066693f8f.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009460; x=1773614260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kiXkLBeQWQKoj7IlzFSGI43nRrJ9AlMDgSZepH8qr+E=;
 b=PeHcGVd+F/eRuIpqLSIUT1IoGdmfVgfhXqGycoWhVabI6rXvIYq5Xv/iIhHd1QAvu3
 11e48CxwMeXDLWdDZ9ryuHG4VdjvfDLkwVVvIjt7bZH+7yQQxuX1qc60KzO4BmiLyNhP
 HG0fdf7vZDiCrhFd2iO8lp6h9+px2nvHWLJ4Kp6Djz3q7bDjvE2pTaOU7/3YKtnWx8BJ
 rpnil51cua6FewIlinKOMcqrELxNdJgeyIZtBQcHtQZbs79RcnH1fsDxOSjvEGGSG51r
 w16YptUdIvNe8gLigUSZJhHDMDxNolxOdXrsHUXifUp0qSPL5wrVCmVhII3i53D7Ow4z
 OgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009460; x=1773614260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kiXkLBeQWQKoj7IlzFSGI43nRrJ9AlMDgSZepH8qr+E=;
 b=DFL/jKcGi8zu07WGye4/ySIvDqkNKoaCVqSvRJWfg+J5L0ldOjuqB/ccq83zTkfC5/
 9sBGp1TnTUaZ3/ZQIeDP6oOyBYGLgP6NLNn4LYZ1HIEMg8DvFjURvyuuk6f8vsXupkT3
 qhJNdEj/dvGPWcHZNd39OXyhPC1SiMJTBjBuzTi8PHY1gJC3FKCmxYC91gysy1HnjJ95
 Q3phTsFilKi+9bmVpV3mYDbAJtpitiFzCabDOKrF2jwWAhBHe6xMlC3Hk6bqDeioJ5Kv
 Px/KIhX01hZfp8Mx5pLE82Sv5+HBWS+p2ahhue7DndGBHGh3XDF3jP/Xbx0x8GklZUTJ
 BqNw==
X-Gm-Message-State: AOJu0Yw/c0PKSVrTxHvmuxFmWqEwRi8jlDkahDTTpVGEKZFZzKX6Ci8C
 EB6hYbhZrB8gV/gtA9uAvIqyxLOqJxuDlcdi3Nki/LIPIQ/1KrLseIyXJKPV2xE7HXJtxw+R5Ou
 qBlgeMTc=
X-Gm-Gg: ATEYQzz5mK32QwdNok3UsvGOBc39UBqMUTYj9Y3T+day1iT19U9+fZ+3GAxsqGoyZSS
 YzM9LPaaoVz8+YjbzDFSHfwg079DP9P+PszHbAcdU/z7W6Us35LNbxAS7dP1WCRDqbScdoQroER
 60cRE1ceC3SblsUOGBSLyi3nWn/oslY0K7jhDhV96ZdGjfzQri4WjKg5uVmAcpkApM0t/7PlfXJ
 b2QnS5EAkRe9ASY8wgTvwzTRBMK3IPhLQLX3V/+GLAPM2r6ZPqkp4XlwUAuSIv0leTx+BtsCC+5
 HNcJO4OjfBs/uBvYKn+Ec4f3I0aHeMTEM4SdmpiMBMGQ3Qv0QJnulQ7YGs6PN4L+Ky2A29WGXrQ
 oNW+IHe9wBrmhBhaDNh5EssKfw8UqaUVd4dg2VQE2kIGbi8F8E8CyNUeUywbDKWVsT0hDtsZARK
 o6rGxvGu4Kw9UyY9ZS3PPo4Ht3oT6iWMRjPiUwc2qbkYxWFxP1PWlvMvhPw/IKE5AvLoC4d4FIg
 Y/yCODQuAU2/mTh
X-Received: by 2002:a05:6000:2285:b0:439:cd10:192a with SMTP id
 ffacd0b85a97d-439da657cbfmr15903699f8f.26.1773009459641; 
 Sun, 08 Mar 2026 15:37:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8daf2sm22407232f8f.2.2026.03.08.15.37.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:37:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/49] ui/cocoa: Do not automatically zoom for HiDPI
Date: Sun,  8 Mar 2026 23:34:11 +0100
Message-ID: <20260308223433.25503-28-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Cocoa automatically zooms for a HiDPI display like Retina and makes
the display blurry. Revert the automatic zooming.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260304-zoom-v2-1-2eebf2b51106@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 5b21fe3aead..9093d1e408f 100644
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
-- 
2.53.0


