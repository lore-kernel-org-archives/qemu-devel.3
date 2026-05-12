Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4C9CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuUY-0007UQ-4F; Tue, 12 May 2026 17:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuUQ-0006uF-UX; Tue, 12 May 2026 17:18:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuUP-00074T-AT; Tue, 12 May 2026 17:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619496; bh=fKChvVL7VZ0KnMJHb6PbOKdMqxmWqdWKvYlAl7Sm5/4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M5zuhfHgFrJd7uJ5j1RBj7uNmIZVuzC/sS3Lg2+fzdirq8nREUk4AhCHBqbW4C24M
 0jDRXn8XfQR65vceLmCx8b1RBTM7bbodL8aMlYxlNItfDZkYlxgU1FT8j74woONt97
 57+WZAAT6DWg3+9d2Hw89chgVLGuvRQMyQCXKBUe+84fwU3ZMFbuo/c/DsTaP9sZmt
 bcqh4wtz7/oqKDITjZykIWiAopiTuQSdqxcjzz7HR+1vzGJGM4GlsfRh7Am2rSQHuO
 CzasrxSm61mydD/ipio3V1W2ElFOUfQjbYr5gD+Nzg7GH5qS+MBuZOj8dEUdBgPfsp
 vQNa0s6GLGFlw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DC8801AA3CD;
 Tue, 12 May 2026 23:58:16 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E96903ABD25;
 Tue, 12 May 2026 23:58:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, GuoHan Zhao <zhaoguohan@kylinos.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 02/58] ui/spice-app: detect runtime directory creation
 failures
Date: Tue, 12 May 2026 23:57:23 +0300
Message-ID: <20260512205820.361821-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

spice_app_display_early_init() creates the per-VM runtime directory
with g_mkdir_with_parents() before setting up the Spice socket. The
code checks for "< -1", but g_mkdir_with_parents() returns -1 on
failure, so the error path is never taken.

This lets spice-app continue after a directory creation failure and
defers the problem to later setup steps.

Check for "< 0" instead so the failure is reported immediately and
spice-app exits before using an invalid runtime directory.

Fixes: d8aec9d9f129 ("display: add -display spice-app launching a Spice client")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260408031725.641417-1-zhaoguohan@kylinos.cn>
(cherry picked from commit 52cf667ed2285aa2d08db6abed46cdba5c14f9aa)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/spice-app.c b/ui/spice-app.c
index 9e55f27371..0df7325e67 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -151,7 +151,7 @@ static void spice_app_display_early_init(DisplayOptions *opts)
     if (qemu_name) {
         app_dir = g_build_filename(g_get_user_runtime_dir(),
                                    "qemu", qemu_name, NULL);
-        if (g_mkdir_with_parents(app_dir, S_IRWXU) < -1) {
+        if (g_mkdir_with_parents(app_dir, S_IRWXU) < 0) {
             error_report("Failed to create directory %s: %s",
                          app_dir, strerror(errno));
             exit(1);
-- 
2.47.3


