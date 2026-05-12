Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F5DCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuFI-0000pJ-Ru; Tue, 12 May 2026 17:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuDN-0005rl-Gx; Tue, 12 May 2026 17:00:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuDL-0006Dn-NS; Tue, 12 May 2026 17:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619277; bh=NKASA8j8e/Rz3S+oKweDj6mSgKRTbS9+ieSzwNzV7Hk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=i1zeYV0oWTGEiQdwCKbtwPgHycW/eAazO5k6OZqrwpEQB84OA5tsBLcBIA5AS/pZ9
 64G+tsrr4cKoWac8kZ6/WyCf3lbNCDAhb5dmXQC50pX6d2uulVXSP8SPQCExgw4JMR
 d8Cc8FagPlJZDGOtlV84O1I8iLppt7xqwi7BWlRK9JLIUJo5PLZDOjjPYqSuF1CoZ8
 mTZuxrjX4Iufh9a9A8qYpeYIIDCoWg2mLfrwkZsu1d0TGaNf4LU0adNu3DIfUiYMnI
 y6GIrU95TkKUrMxoMl0ZuNWm83iUzk2Kw5Mhig8AYmhreycD9b+2Kbr2/8uojUUJLe
 kkMP95xPtIhig==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 16A3F1AA306;
 Tue, 12 May 2026 23:54:37 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 22F953ABC77;
 Tue, 12 May 2026 23:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, GuoHan Zhao <zhaoguohan@kylinos.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 058/107] ui/spice-app: detect runtime directory
 creation failures
Date: Tue, 12 May 2026 23:53:45 +0300
Message-ID: <20260512205437.360850-58-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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
index 91e258a621..f6d494fddd 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -153,7 +153,7 @@ static void spice_app_display_early_init(DisplayOptions *opts)
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


