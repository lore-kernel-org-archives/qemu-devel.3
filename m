Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8AA103E167
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2p8g-0006mt-BO; Wed, 18 Mar 2026 07:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2p8H-0006ig-0y
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:32:13 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2p8E-0001z1-Sy
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:32:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6D70E808B6;
 Wed, 18 Mar 2026 14:32:09 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:431::1:10])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kVLGYB2A1mI0-MnneU9bw; Wed, 18 Mar 2026 14:32:08 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773833528;
 bh=u/ALi6TS8NgyG0rOzpBeTjPnLHtu5x5sb7IprlfMiwg=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=jjT5ld4O4T/WY6ST9dY98lp0GTIlNtgdqMr+Sxr/AScZdf0hvLTjwvvefVKzfwSSw
 nbFSqj2cAyDkTXcv1RMr3GWWLyKvRSUqDxa17h8DjdJwvahe/WCTEdzMKnkn/aSrdy
 U/mK/zE3iXPP2ufIGl/wdbLfHqrLdJeERxw2SHKE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v4 13/13] net/tap: check that user tries to define zero queues
Date: Wed, 18 Mar 2026 14:31:43 +0300
Message-ID: <20260318113144.15697-14-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318113144.15697-1-vsementsov@yandex-team.ru>
References: <20260318113144.15697-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Add check for queues parameter to be non-zero, and for fd/fds
parameters to be non-empty.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c  | 4 ++++
 net/util.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/net/tap.c b/net/tap.c
index e464f62b473..57ffb09885c 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -807,6 +807,10 @@ static int tap_parse_fds_and_queues(const NetdevTapOptions *tap, int **fds,
             error_setg(errp, "queues exceeds maximum %d", INT_MAX);
             return -1;
         }
+        if (tap->queues == 0) {
+            error_setg(errp, "queues must be greater than zero");
+            return -1;
+        }
         queues = tap->queues;
         *fds = NULL;
     } else if (tap->fd || tap->fds) {
diff --git a/net/util.c b/net/util.c
index 1998a6554e0..8265f155484 100644
--- a/net/util.c
+++ b/net/util.c
@@ -94,6 +94,11 @@ int net_parse_fds(const char *fds_param, int **fds, int expected_nfds,
         return -1;
     }
 
+    if (nfds == 0) {
+        error_setg(errp, "no fds passed");
+        return -1;
+    }
+
     *fds = g_new(int, nfds);
 
     for (i = 0; i < nfds; i++) {
-- 
2.52.0


