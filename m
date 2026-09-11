Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68D8C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x55ga-0005SH-Sa; Fri, 11 Sep 2026 14:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x55gP-0005Oq-Al
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 14:09:05 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x55gL-0000GX-ID
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 14:09:05 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 37D1DC0B53;
 Fri, 11 Sep 2026 21:08:58 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:641::1:4])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id u8VTLcTagiE0-nLJm2nG8; Fri, 11 Sep 2026 21:08:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789150137;
 bh=fbFSQh3QjfQiC+H+Nv8e1iQ1NC9bj9HmckG7oUuK69o=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=DojNpBeAuRbD/XCoCXJspufn9OrJdapXtNSAMUqHqxgbHZybTxvftTsDx0bDobjRw
 wiPyctSohIKGrafM+F+K55tbt4Q7VIY5WOUcBdz8kIp8BvsdjtlisKdUmGADREndoE
 CfT1J/4Yhn8DHSrDrF1c3wFgU6QFmHixiEF6uDfc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, sgarzare@redhat.com,
 mst@redhat.com, jag.raman@oracle.com, elena.ufimtseva@oracle.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 1/4] util/event_notifier: return -1 for uninitialized notifiers
Date: Fri, 11 Sep 2026 21:08:51 +0300
Message-ID: <20260911180854.123969-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911180854.123969-1-vsementsov@yandex-team.ru>
References: <20260911180854.123969-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Use initialized in event_notifier_get_fd() and event_notifier_get_wfd()
instead of exposing the descriptor fields of an uninitialized notifier.
This makes a zeroed notifier report the same absent descriptor as one
that has been cleaned up, while preserving fd 0 for initialized notifiers.

Document the accessor contract so callers can test for an absent notifier
without accessing its initialized flag directly.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/qemu/event_notifier.h | 1 +
 util/event_notifier-posix.c   | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qemu/event_notifier.h b/include/qemu/event_notifier.h
index 8a4ff308e19..de2e876cb15 100644
--- a/include/qemu/event_notifier.h
+++ b/include/qemu/event_notifier.h
@@ -37,6 +37,7 @@ int event_notifier_test_and_clear(EventNotifier *);
 
 #ifdef CONFIG_POSIX
 void event_notifier_init_fd(EventNotifier *, int fd);
+/* These accessors return -1 for an uninitialized notifier. */
 int event_notifier_get_fd(const EventNotifier *);
 int event_notifier_get_wfd(const EventNotifier *);
 #else
diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
index 83fdbb96bbc..34a2716dbf2 100644
--- a/util/event_notifier-posix.c
+++ b/util/event_notifier-posix.c
@@ -96,12 +96,12 @@ void event_notifier_cleanup(EventNotifier *e)
 
 int event_notifier_get_fd(const EventNotifier *e)
 {
-    return e->rfd;
+    return e->initialized ? e->rfd : -1;
 }
 
 int event_notifier_get_wfd(const EventNotifier *e)
 {
-    return e->wfd;
+    return e->initialized ? e->wfd : -1;
 }
 
 int event_notifier_set(EventNotifier *e)
-- 
2.43.0


