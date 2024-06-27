Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41062C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 15:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMr5x-0007yt-JL; Thu, 27 Jun 2024 11:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMr5r-0007vP-P8; Thu, 27 Jun 2024 11:31:28 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMr5p-0003xq-CV; Thu, 27 Jun 2024 11:31:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c16:1680:0:640:d42f:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C85F860A8A;
 Thu, 27 Jun 2024 18:31:13 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:227::1:3a])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0VTS9M01TCg0-X2UxXmfK; Thu, 27 Jun 2024 18:31:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719502273;
 bh=zUl8pu8xHNgdvWEHH+WAqVh92HQPTBSqB5JMxY64YIo=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=yz5m74QOrL1n/Bb+cTz1hHOt9zyKKGEqbtRHLG8rxMgjPo4Vwqxt9triaBhyr5CqB
 iRASiZogoELAfd3SBPOJKmNExDMU8krx++Q+qpxnNiaBOiMG/UgMcY/WQpPNZqLgBl
 ODFBk3y6uzS0sGpdEiWbNmXjb/uHhSg46LRIFRns=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, hreitz@redhat.com,
 kwolf@redhat.com, qemu-trivial@nongnu.org
Subject: [PATCH] block/curl: explicitly assert that strchr returns non-NULL
 value
Date: Thu, 27 Jun 2024 18:30:59 +0300
Message-Id: <20240627153059.589070-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

strchr may return NULL if colon is not found. It seems clearer to
assert explicitly that we don't expect it here, than dereference 1 in
the next line.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/curl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/curl.c b/block/curl.c
index 419f7c89ef..ccfffd6c12 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -219,7 +219,9 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
         && g_ascii_strncasecmp(header, accept_ranges,
                                strlen(accept_ranges)) == 0) {
 
-        char *p = strchr(header, ':') + 1;
+        char *p = strchr(header, ':');
+        assert(p != NULL);
+        p += 1;
 
         /* Skip whitespace between the header name and value. */
         while (p < end && *p && g_ascii_isspace(*p)) {
-- 
2.34.1


