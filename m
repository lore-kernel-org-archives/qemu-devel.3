Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48349CAC583
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 11:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwJKZ-0007g2-L0; Wed, 10 Sep 2025 07:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nir@lichtman.org>) id 1uwJKY-0007fl-9i
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:49:42 -0400
Received: from lichtman.org ([149.28.33.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nir@lichtman.org>) id 1uwJKQ-0000pA-R9
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:49:41 -0400
Received: by lichtman.org (Postfix, from userid 1000)
 id 37F38176F04; Wed, 10 Sep 2025 11:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
 t=1757504969; bh=58B1Ra5FNfTKr7Jc8wrKFlBeudNQs4b+fB5zHVtiVoo=;
 h=Date:From:To:Cc:Subject:From;
 b=V5iQPGK6wMNMqCPZ2oGbnOgEu04ljRWSm6IjazT0iwPkBteXCJwIkHIeIjSnn1Kza
 h+0wn5uNHHlMN1X66fmw305TbHemOW5VCn+tbvHWl2ZYNJEbcEZPkCVWTkwNNetgqT
 t0xLZEuM/B28KT42CdNW3qVMgl8IWgTk+fDxBhxC7egFkMJmp7/YY57FYqNowmiuiV
 +AXuAGJCmvbfgjwH73pV3Te2Obe0m44CwmmhZlGjk+Wnk0CNhMfNqTm7T6tSvCwsPT
 jGmbLfWDIIopGafws6bOz00Edj+DI0gqO31Iv0M/RgWe23zrtdZusognQzNEd/1jVJ
 GUcyG+b8pgRNA==
Date: Wed, 10 Sep 2025 11:49:29 +0000
From: Nir Lichtman <nir@lichtman.org>
To: qemu-devel@nongnu.org, kraxel@redhat.com
Cc: peter.maydell@linaro.org, thuth@redhat.com, marcandre.lureau@redhat.com
Subject: [PATCH] ui/sdl2: fix reset scaling binding to be consistent with gtk
Message-ID: <20250910114929.GA1783677@lichtman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=149.28.33.109; envelope-from=nir@lichtman.org;
 helo=lichtman.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Problem: Currently the reset scaling hotkey is inconsistent between SDL
and GTK graphics modes.

Solution: Fix SDL to use MOD+0 instead of MOD+u which is in line with
GTK and generally more consistent with other apps.

This is also related to my previously sent patch fixing the docs.

Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 ui/sdl2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index b00e421..032dc14 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -421,7 +421,7 @@ static void handle_keydown(SDL_Event *ev)
                 sdl_grab_end(scon);
             }
             break;
-        case SDL_SCANCODE_U:
+        case SDL_SCANCODE_0:
             sdl2_window_resize(scon);
             if (!scon->opengl) {
                 /* re-create scon->texture */
-- 
2.39.5


