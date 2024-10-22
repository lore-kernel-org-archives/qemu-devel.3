Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C250DD1CDA1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 06:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t38BI-0005oV-HE; Tue, 22 Oct 2024 02:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t38BG-0005n7-F2; Tue, 22 Oct 2024 02:15:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t38BE-0001uZ-QI; Tue, 22 Oct 2024 02:15:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A2E119ACA3;
 Tue, 22 Oct 2024 09:15:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C19FC159B65;
 Tue, 22 Oct 2024 09:15:33 +0300 (MSK)
Received: (nullmailer pid 1304530 invoked by uid 1000);
 Tue, 22 Oct 2024 06:15:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 4/5] meson.build: Remove ncurses workaround for OpenBSD
Date: Tue, 22 Oct 2024 09:15:32 +0300
Message-Id: <20241022061533.1304493-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022061533.1304493-1-mjt@tls.msk.ru>
References: <20241022061533.1304493-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Brad Smith <brad@comstyle.com>

meson.build: Remove ncurses workaround for OpenBSD

OpenBSD 7.5 has upgraded to ncurses 6.4.

Signed-off-by: Brad Smith <brad@comstyle.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 meson.build | 2 +-
 ui/curses.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index d26690ce20..c26c417de1 100644
--- a/meson.build
+++ b/meson.build
@@ -1399,7 +1399,7 @@ iconv = not_found
 curses = not_found
 if have_system and get_option('curses').allowed()
   curses_test = '''
-    #if defined(__APPLE__) || defined(__OpenBSD__)
+    #ifdef __APPLE__
     #define _XOPEN_SOURCE_EXTENDED 1
     #endif
     #include <locale.h>
diff --git a/ui/curses.c b/ui/curses.c
index ec61615f7c..4d0be9b37d 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -38,7 +38,7 @@
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 
-#if defined(__APPLE__) || defined(__OpenBSD__)
+#ifdef __APPLE__
 #define _XOPEN_SOURCE_EXTENDED 1
 #endif
 
-- 
2.39.5


