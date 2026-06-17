Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3F5CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZozA-0004Xr-GD; Wed, 17 Jun 2026 08:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lobanov-vla@yandex.ru>)
 id 1wZmqR-0005v6-MH; Wed, 17 Jun 2026 05:46:03 -0400
Received: from forward100a.mail.yandex.net ([2a02:6b8:c0e:500:1:45:d181:d100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lobanov-vla@yandex.ru>)
 id 1wZmqP-0002N2-Gw; Wed, 17 Jun 2026 05:46:03 -0400
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1d:713f:0:640:12cb:0])
 by forward100a.mail.yandex.net (Yandex) with ESMTPS id 08BEDC06EA;
 Wed, 17 Jun 2026 12:45:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id ojNjJbpeaiE0-EMZIIV2J; 
 Wed, 17 Jun 2026 12:45:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1781689553; bh=EVaD91U778GPavlRVIBviv08gdBWzqmegGsObBePI6A=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=KxB5rzlEutMzwkrbWQ6HQc4LPLnA1XdfWvI4XFcfjzjUmfWd01M6EEKgfUPKHay/R
 kp+fN0TsZlnax9sjrPgXDFlY8NqZbaNKkApKA6It9QvQULOCjpsaUDUqky1LERocMP
 J4nvBAJ/nh06+hkqbBMYrRPV8wPQHgXOObuGOnFg=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Vladimir Lobanov <lobanov-vla@yandex.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 qemu-trivial@nongnu.org, Vladimir Lobanov <lobanov-vla@yandex.ru>
Subject: [PATCH] block/curl: set User-Agent header
Date: Wed, 17 Jun 2026 12:44:56 +0300
Message-ID: <20260617094456.94880-1-lobanov-vla@yandex.ru>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:d100;
 envelope-from=lobanov-vla@yandex.ru; helo=forward100a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jun 2026 08:02:38 -0400
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

Some HTTP servers and WAFs (e.g. Amazon CloudFront) reject
requests without a User-Agent header with 403 Forbidden. This
makes qemu-img info and other curl-based operations fail on
such URLs without any obvious indication of the root cause.

Set a "QEMU/<version>" User-Agent string on all curl handles
to ensure compatibility with these endpoints.

Signed-off-by: Vladimir Lobanov <lobanov-vla@yandex.ru>
---
 block/curl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index 684c677ef7..1958eb80d1 100644
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
2.50.1 (Apple Git-155)


