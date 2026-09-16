Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4CBC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6leJ-0007uj-Bs; Wed, 16 Sep 2026 05:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6leG-0007gY-KW; Wed, 16 Sep 2026 05:09:48 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6leE-0007W8-Va; Wed, 16 Sep 2026 05:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549562; bh=zuJ25Qwoepx64JeLHRK8tPAAxVebrDg/Ykxpo3dxdA8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=n5Z5Xf7TzlcJKjToC0HPScVyKXfRF4Ais4omxuIEiIOTUPdzEgrv9a0zHsqbgYRWX
 Zxq2B8EJaU+jEi3CR4Wdj4BlgtsOtSKDbH7BjIBFxj7gMdF12yBZkMBaQjKOsk7OyJ
 SfVtEBZ64u5NoXCdxCSS9JWX4ZvdpWacHkaV7S09y2+zU35MAt9HgRT/CuKTZBczfB
 EbdogIz8uvrijr49eM+u/6etqa2Hx+K9N5hTW82QUaoEZF8fEzDRWbCz6elyVtaFvX
 Y4z0WTDyOzyUu7xvnKf59osZS7tSXv0ykcAYhI7aH+Wj8wDOZ/YpuHuplzCqrEICwN
 oBJdslv0hXbTg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 336EC1D56E0;
 Wed, 16 Sep 2026 12:06:02 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D35CD429E3C;
 Wed, 16 Sep 2026 12:06:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C9C455A7AF; Wed, 16 Sep 2026 12:06:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zhang Chen <zhangckid@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 43/57] qapi/misc: Fix missed query-iothreads items
Date: Wed, 16 Sep 2026 12:04:07 +0300
Message-ID: <20260916090516.677749-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
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

From: Zhang Chen <zhangckid@gmail.com>

The example is incomplete: it misses members @poll-max-ns, @poll-grow,
@poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
(monitor: add poll-* properties into query-iothreads result) and
commit 1793ad0247c (iothread: add aio-max-batch parameter).

CC: qemu-stable@nongnu.org
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit f10977073cb4ac58fce7274893e7129e7f64dcae)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qapi/misc.json b/qapi/misc.json
index 28c641fe2fe..1f5062df2a5 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -117,11 +117,19 @@
 #     <- { "return": [
 #              {
 #                 "id":"iothread0",
-#                 "thread-id":3134
+#                 "thread-id":3134,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              },
 #              {
 #                 "id":"iothread1",
-#                 "thread-id":3135
+#                 "thread-id":3135,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              }
 #           ]
 #        }
-- 
2.47.3


