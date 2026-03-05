Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7663F47CC4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 19:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyEbl-0004zU-JI; Thu, 05 Mar 2026 14:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vyEbj-0004z8-FT
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 14:43:39 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vyEbh-0001yd-LW
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 14:43:39 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a189:0:640:4da6:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 69346C01EF;
 Thu, 05 Mar 2026 22:43:33 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:b93::1:1])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VhvFMN0A1Cg0-a7Ib3pOl; Thu, 05 Mar 2026 22:43:32 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772739812;
 bh=87dUWNkHcTPzQRSbWhPCiEzsPvmojygUsu9xACani3Q=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=EQR8fDptTWODqUoVP4iTOX1IHkV7dbdA34I0Yl1g/HoR/50XGoZ2g+rNcfD1qKZ3Y
 6tJ7652EqySusz90HLEEt9njuZNRCHnJTdkUojDe7OVhzk3fBBL94u2mI45so2rFrp
 0PjDpFm7J9UUYiv9E93aHPRVG3HqoTcOkVoNyPt0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH 13/12 v3] net/tap: check that user tries to define zero queues
Date: Thu,  5 Mar 2026 22:43:29 +0300
Message-ID: <20260305194329.1470084-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
References: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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
index 1623ddff5fb..383e158d5e2 100644
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


