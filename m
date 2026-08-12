Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6362C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8eX-0000EO-UI; Wed, 12 Aug 2026 09:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8eB-0008Nh-Ka; Wed, 12 Aug 2026 09:05:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8e8-0004uA-VK; Wed, 12 Aug 2026 09:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=0WzhhckKXiySYuj9vkB0s8yPv8Nv4m1x3zGNeatnL2s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AxEElnxXBqzDfHMn6+Qo6HqoI22stqkSkxepsGFFU5BeTQgQYAda3aTq6ckE/57Lp
 ReAXFx1WZJpstBGWW+sC2wOLAOjpB7RH/9fVRkScCO3tMUUFDxSkZN7zlF4J7AdGFB
 s9z/I0/vOctTaY5pgvpskdA9jWzWXAPhB14rOCfit1RXOlnyK3gT++weI/+eiRYu+7
 rzUSUkrc/qGeQHU5cQT1Nmnsb9ILgqSFWbmnWpqI3G2x2nL4yKharSPlfMk5bYYfSa
 +hFkm0fbh72XxP1anOMowd3Gs32YVTSrpULlfqBJVn7xd8sH3NUqYmHSYQuur72Gg3
 G2ZcuySgvS9mA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 974FD1CA49C;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CCEA1409B7F;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 17E052F8CE; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 029/102] net/colo: fix g_hash_table_destroy assertion
 on uninitialized filter
Date: Wed, 12 Aug 2026 16:01:04 +0300
Message-ID: <20260812130233.621965-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

colo_rewriter_cleanup() unconditionally destroys connection_track_table,
but the table is only allocated in colo_rewriter_setup(). When the
filter-rewriter object is finalized without having been set up (e.g.
during qom-test property enumeration), the pointer is NULL and
g_hash_table_destroy() fires an assertion.

Use g_clear_pointer() to skip the destroy when the table was never
initialized.

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Message-ID: <20260709111315.1108185-1-marcandre.lureau@redhat.com>
(cherry picked from commit b28778131fad008fcb79204874d926c2433e518f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index c18c4c20190..312085f9d98 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -373,7 +373,7 @@ static void colo_rewriter_cleanup(NetFilterState *nf)
         g_free(s->incoming_queue);
     }
 
-    g_hash_table_destroy(s->connection_track_table);
+    g_clear_pointer(&s->connection_track_table, g_hash_table_destroy);
 }
 
 static void colo_rewriter_setup(NetFilterState *nf, Error **errp)
-- 
2.47.3


