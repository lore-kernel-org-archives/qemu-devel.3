Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C29C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCVs-0003GS-0Q; Fri, 24 Jul 2026 05:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnCVo-0003Ey-SQ; Fri, 24 Jul 2026 05:48:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnCVn-000590-Ar; Fri, 24 Jul 2026 05:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784886463; bh=XNT16mHos7Uw+RJumfGsNuq2H7pOdc57nzpxpskiNe4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sjvsksSnYdXDSXAG6bFRtVzV60GMHYUR0cMq+eKljsHNBzmU6jnjOa72vHvoh+neb
 8cCRG6nIj6R/A3lA5OZbfDjJ7wrNtnJsZVf4wbdP/a53jfKicHbvp0cE5nrW/+BhLT
 CgA9+y9BnD+skMlSM3sJktY9AN+lE64Y4BMeSmiRdQXX6U5P0eAvHa4sNU0/hu+C4m
 gg//2AD8ZXx09ivn/TdEjyM22sKGPeBpnU7xJRfb7QFuK3R8LcJQQR0zMU8gZufStY
 gras+QxSnG7qWaw/ja0u/ZysimMyZeEEfuOwJfFHo+gWAn0sXpm3VsyuTRPySq7FZ2
 LpUS7ONUbzpZg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 592DD1C4574;
 Fri, 24 Jul 2026 12:47:43 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5454E3F46B3;
 Fri, 24 Jul 2026 12:48:04 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4777C18546; Fri, 24 Jul 2026 12:47:54 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Vladimir Lobanov <lobanov-vla@yandex.ru>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 3/7] block/curl: set User-Agent header
Date: Fri, 24 Jul 2026 12:47:45 +0300
Message-ID: <20260724094754.1053970-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724094754.1053970-1-mjt@tls.msk.ru>
References: <20260724094754.1053970-1-mjt@tls.msk.ru>
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

From: Vladimir Lobanov <lobanov-vla@yandex.ru>

Some HTTP servers and WAFs (e.g. Amazon CloudFront) reject
requests without a User-Agent header with 403 Forbidden. This
makes qemu-img info and other curl-based operations fail on
such URLs without any obvious indication of the root cause.

Set a "QEMU/<version>" User-Agent string on all curl handles
to ensure compatibility with these endpoints.

Signed-off-by: Vladimir Lobanov <lobanov-vla@yandex.ru>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 block/curl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index 684c677ef71..1958eb80d12 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -482,6 +482,8 @@ static int curl_init_state(BDRVCURLState *s, CURLState *state)
             }
         }
         if (curl_easy_setopt(state->curl, CURLOPT_TIMEOUT, (long)s->timeout) ||
+            curl_easy_setopt(state->curl, CURLOPT_USERAGENT,
+                             "QEMU/" QEMU_VERSION) ||
             curl_easy_setopt(state->curl, CURLOPT_WRITEFUNCTION,
                              (void *)curl_read_cb) ||
             curl_easy_setopt(state->curl, CURLOPT_WRITEDATA, (void *)state) ||
-- 
2.47.3


