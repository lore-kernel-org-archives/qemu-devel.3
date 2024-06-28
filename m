Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D00C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 05:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN4VD-00079W-OB; Fri, 28 Jun 2024 01:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sN4V6-00078I-GT; Fri, 28 Jun 2024 01:50:27 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sN4Ur-0006ZM-Nb; Fri, 28 Jun 2024 01:50:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:2799:0:640:ddd6:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id B1AEF60911;
 Fri, 28 Jun 2024 08:50:02 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b511::1:0])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id rnK0hT0IYuQ0-XL9II4mD; Fri, 28 Jun 2024 08:50:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719553802;
 bh=mKswfzNM7v5XXbJew6aV2d2JRhC7ll06sDQUOrQFTzE=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=Qerxdp4+/RByewkmm8BSse9BlsGUx61yFaoGv0j573IM6cQestLyMHHNt5XBXdDmY
 R86+03YmT79IZJA+xIGIucGgfCbZiYiMKxikwqrtknLqele7sSvMUhpKkMzMHBakhp
 Rje6N/Y7oRtLG2QoBoHdzLIVcJYVHaHqx/SpECuo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, qemu-trivial@nongnu.org
Subject: [PATCH] block/curl: use strlen instead of strchr
Date: Fri, 28 Jun 2024 08:49:42 +0300
Message-Id: <20240628054942.657397-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We already know where colon is, so no reason to search for it. Also,
avoid a code, which looks like we forget to check return value of
strchr() to NULL.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

This replaces my patch
  [PATCH] block/curl: explicitly assert that strchr returns non-NULL value
Supersedes: <20240627153059.589070-1-vsementsov@yandex-team.ru>

 block/curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/curl.c b/block/curl.c
index 419f7c89ef..d03bfe4817 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -219,7 +219,7 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
         && g_ascii_strncasecmp(header, accept_ranges,
                                strlen(accept_ranges)) == 0) {
 
-        char *p = strchr(header, ':') + 1;
+        char *p = header + strlen(accept_ranges);
 
         /* Skip whitespace between the header name and value. */
         while (p < end && *p && g_ascii_isspace(*p)) {
-- 
2.34.1


