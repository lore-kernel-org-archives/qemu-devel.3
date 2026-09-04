Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9413C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2az7-00039Y-8G; Fri, 04 Sep 2026 16:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x2az4-00038f-Ow
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:58:02 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x2az1-0007x2-Eq
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:58:02 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:43a8:0:640:574d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 08FC880A61;
 Fri, 04 Sep 2026 23:57:56 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:4d::1:17])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rvQjs41YPqM0-UooXil1Y; Fri, 04 Sep 2026 23:57:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788555475;
 bh=Dlc3dK5WOaqmo7z+t9buAmX2gat8HcjIw965WO9A260=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=aFCJE6IQeVsZRJl6yv7vJPVyaDOeihMcE1i2xYJwRBLOy+OAqg25ttfEbdwewBfIl
 GFcGpErcsRrKygFyU1ZvDJfl76GdFJBqnwlEodNaMHoTtAOQGP8UYOH++P+1PVc6ZV
 vGgqWrgWzf0I5/gPfyq9LRJZN/4JewRXr29PMplM=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH 4/6] runstate: simplify qemu_shutdown_requested_get()
Date: Fri,  4 Sep 2026 23:57:47 +0300
Message-ID: <20260904205749.510493-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904205749.510493-1-vsementsov@yandex-team.ru>
References: <20260904205749.510493-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
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

The only caller needs to know whether a shutdown request is pending,
not its reason. Return bool and rename the function to
qemu_shutdown_requested().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/xen/xen-hvm-common.c   | 2 +-
 include/system/runstate.h | 2 +-
 system/runstate.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 62d88804c43..4d01a12062d 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -610,7 +610,7 @@ static void cpu_handle_ioreq(void *opaque)
         if (runstate_is_running()) {
             ShutdownCause request;
 
-            if (qemu_shutdown_requested_get()) {
+            if (qemu_shutdown_requested()) {
                 destroy_hvm_domain(false);
             }
             request = qemu_reset_requested_get();
diff --git a/include/system/runstate.h b/include/system/runstate.h
index 929379adae4..3ed35921bb7 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -146,7 +146,7 @@ void qemu_system_debug_request(void);
 void qemu_system_vmstop_request(RunState reason);
 void qemu_system_vmstop_request_prepare(void);
 bool qemu_vmstop_requested(RunState *r);
-ShutdownCause qemu_shutdown_requested_get(void);
+bool qemu_shutdown_requested(void);
 bool qemu_force_shutdown_requested(void);
 ShutdownCause qemu_reset_requested_get(void);
 void qemu_system_killed(int signal, pid_t pid);
diff --git a/system/runstate.c b/system/runstate.c
index 01f936649b4..2b28e2a30e2 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -582,7 +582,7 @@ static NotifierList shutdown_notifiers =
     NOTIFIER_LIST_INITIALIZER(shutdown_notifiers);
 static uint32_t wakeup_reason_mask = ~(1 << QEMU_WAKEUP_REASON_NONE);
 
-ShutdownCause qemu_shutdown_requested_get(void)
+bool qemu_shutdown_requested(void)
 {
     return shutdown_requested;
 }
-- 
2.43.0


