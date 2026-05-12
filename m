Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357C3CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuM3-0006Na-HZ; Tue, 12 May 2026 17:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuLM-0002h8-Jk; Tue, 12 May 2026 17:08:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuLK-00037C-Hd; Tue, 12 May 2026 17:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619301; bh=Ndy1JinN+8dDOV0pkJ/kHNaf9TUEdkRaTYOyEzpMu4Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tqivsErfdN7YwfYtd46Lzn9uhvUKO7zsGAU4o1PM4bE91Ia1pEq1POwSSBUljpYPr
 wpvldqxluqAYX8kSz6Ta3us/xgKWVQNELGx1nRh2XIG1PADy8GLclfLDkDHji8Y+3I
 BHcoYl0oBvVJB7vB1oVj+DsjZqzvoLwCZvedW0TYw5cmDSsUzMdkZN/oFafVa9fKc5
 dRp1SRp3K1t9vBzv7lqAPipyZHA9m2lNKPcxDwDw0hNqyxtNrYXFrEj/NP+m4jm+mh
 vASv9FJbqeUohSWcF0J5yoU9oxxpH0JIWv3RS/CDScuOqAXnfqYBuH+TwnQqtfTuXh
 n6L5PszFtc6cA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9D4FA1AA35A;
 Tue, 12 May 2026 23:55:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A9F023ABCCA;
 Tue, 12 May 2026 23:55:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, GuoHan Zhao <zhaoguohan@kylinos.cn>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 029/117] block/curl: free s->password in cleanup paths
Date: Tue, 12 May 2026 23:53:31 +0300
Message-ID: <20260512205503.361097-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
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

When password-secret is used, curl_open() resolves it with
qcrypto_secret_lookup_as_utf8() and stores the returned buffer in
s->password.

Unlike s->proxypassword, s->password is not freed either in the open
failure path or in curl_close(), so the resolved secret leaks once it
has been allocated.

Free s->password in both cleanup paths.

Fixes: 1bff96064290 ('curl: add support for HTTP authentication parameters')
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Message-ID: <20260320063016.262954-1-zhaoguohan_salmon@163.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 51fc8443c122fedf4d4891bbc3a1ff25dd8bacdf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/curl.c b/block/curl.c
index 6dccf00256..a249811ed1 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -865,6 +865,7 @@ out_noclean:
     g_free(s->cookie);
     g_free(s->url);
     g_free(s->username);
+    g_free(s->password);
     g_free(s->proxyusername);
     g_free(s->proxypassword);
     if (s->sockets) {
@@ -976,6 +977,7 @@ static void curl_close(BlockDriverState *bs)
     g_free(s->cookie);
     g_free(s->url);
     g_free(s->username);
+    g_free(s->password);
     g_free(s->proxyusername);
     g_free(s->proxypassword);
 }
-- 
2.47.3


