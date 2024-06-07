Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662D0C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 22:31:19 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf19-0005gt-B2; Fri, 07 Jun 2024 15:12:51 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf17-0005Id-Kc; Fri, 07 Jun 2024 15:12:49 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf16-0001hj-0r; Fri, 07 Jun 2024 15:12:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3929D6E536;
 Fri,  7 Jun 2024 22:13:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7362FE2736;
 Fri,  7 Jun 2024 22:12:21 +0300 (MSK)
Received: (nullmailer pid 528258 invoked by uid 1000);
 Fri, 07 Jun 2024 19:12:20 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.12 28/29] ui/sdl2: Allow host to power down screen
Date: Fri,  7 Jun 2024 22:12:11 +0300
Message-Id: <20240607191219.528194-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.12-20240607221018@cover.tls.msk.ru>
References: <qemu-stable-7.2.12-20240607221018@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

By default, SDL disables the screen saver which prevents the host from powering
down the screen even if the screen is locked. This results in draining the
battery needlessly when the host isn't connected to a wall charger. Fix that by
enabling the screen saver.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20240512095945.1879-1-shentey@gmail.com>
(cherry picked from commit 2e701e6785cd8cc048c608751c6e4f6253c67ab6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/sdl2.c b/ui/sdl2.c
index d630459b78..fc7e8639c2 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -857,6 +857,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
 #endif
     SDL_SetHint(SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4, "1");
+    SDL_EnableScreenSaver();
     memset(&info, 0, sizeof(info));
     SDL_VERSION(&info.version);
 
-- 
2.39.2


