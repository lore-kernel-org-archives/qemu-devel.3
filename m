Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC7DCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 13:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy9AQ-0001jl-UU; Mon, 15 Sep 2025 09:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy9AL-0001gb-EF; Mon, 15 Sep 2025 09:22:45 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy9A8-0006y3-Jo; Mon, 15 Sep 2025 09:22:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 95097807C0;
 Mon, 15 Sep 2025 16:22:20 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:130::1:7])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GMPC4o1FuGk0-QSQ7UMxK; Mon, 15 Sep 2025 16:22:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757942540;
 bh=Bsj2a9jOX7m78cJ8iWjmy3wV+irNgid7QKDe6IJBGGY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=gY3jsz2kk7ZiSLHE7eVO0Qx27xsBA0OtrNO2jtekoG+/4Qh00eoQHrBkeEIb99JEp
 O4ycfXqXPfayb3Pg8pJ1Gek6JNMT002YYEZZBjZfTHnyJqYgs4htW0Gd69b/BpdIiB
 +epIt/xlZIBZ7nGZulxah9ll3iLB6UT7rEIurpRc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 04/13] util/error: add &error_reporter
Date: Mon, 15 Sep 2025 16:22:01 +0300
Message-ID: <20250915132211.135095-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915132211.135095-1-vsementsov@yandex-team.ru>
References: <20250915132211.135095-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add a pair to &error_warn helper, to reduce the pattern like

    Error *local_err = NULL;

    ...

    if (!foo(..., &local_err)) {
        error_report_err(local_err);
        return false;
    }

to simply

    if (!foo(..., &error_reporter)) {
        return false;
    }

Of course, for new interfaces, it's better to always support and handle
errp argument. But when have to rework the old ones, it's not always
feasible to convert everything to support/handle errp.

The new helper is used in following commits.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/qapi/error.h | 6 ++++++
 util/error.c         | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 41e3816380..cea95f5c36 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -539,6 +539,12 @@ G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_cleanup);
  */
 extern Error *error_warn;
 
+/*
+ * Special error destination to report on error.
+ * See error_setg() and error_propagate() for details.
+ */
+extern Error *error_reporter;
+
 /*
  * Special error destination to abort on error.
  * See error_setg() and error_propagate() for details.
diff --git a/util/error.c b/util/error.c
index daea2142f3..5160435c86 100644
--- a/util/error.c
+++ b/util/error.c
@@ -20,6 +20,7 @@
 Error *error_abort;
 Error *error_fatal;
 Error *error_warn;
+Error *error_reporter;
 
 static void error_handle(Error **errp, Error *err)
 {
@@ -43,6 +44,8 @@ static void error_handle(Error **errp, Error *err)
     }
     if (errp == &error_warn) {
         warn_report_err(err);
+    } else if (errp == &error_reporter) {
+        error_report_err(err);
     } else if (errp && !*errp) {
         *errp = err;
     } else {
-- 
2.48.1


