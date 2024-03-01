Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93504C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6Ql-0007Hc-NF; Fri, 01 Mar 2024 12:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg6QZ-00076A-OB; Fri, 01 Mar 2024 12:12:07 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg6QW-0003Lc-Ar; Fri, 01 Mar 2024 12:12:06 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:621c:0:640:f00b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1FE2C60ED4;
 Fri,  1 Mar 2024 20:12:01 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:a531::1:29])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jBfRBH2IW0U0-P4UAt0Xy; Fri, 01 Mar 2024 20:12:00 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709313120;
 bh=evquwFwzPW9xCgQIs6hUleswS73KWmV6hHOZrBNxbgk=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=0Sl5zxnTWbgmn8HxkewjitZnfb5BrXxnIw+Zi+WWpnMV74JUGuGccTCPRu6OgKWaj
 H4btOKJPwdLCJexc9TYh1NHBO9zApI+y/vlEbMaeOjf7WKVOXWg3H3viZJyol5HiIW
 yUpEm125nAt9cU62CxkgL9uYAn/6DmXCFdvWqoAc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org,
 armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v2 5/6] qapi: device-sync-config: check runstate
Date: Fri,  1 Mar 2024 20:11:42 +0300
Message-Id: <20240301171143.809835-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301171143.809835-1-vsementsov@yandex-team.ru>
References: <20240301171143.809835-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Command result is racy if allow it during migration. Let's allow the
sync only in RUNNING state.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/sysemu/runstate.h |  1 +
 system/qdev-monitor.c     | 27 ++++++++++++++++++++++++++-
 system/runstate.c         |  5 +++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 0117d243c4..296af52322 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -5,6 +5,7 @@
 #include "qemu/notify.h"
 
 bool runstate_check(RunState state);
+const char *current_run_state_str(void);
 void runstate_set(RunState new_state);
 RunState runstate_get(void);
 bool runstate_is_running(void);
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index e3107a12d7..b83b5d23c9 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -23,6 +23,7 @@
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
 #include "sysemu/arch_init.h"
+#include "sysemu/runstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
 #include "qapi/qmp/dispatch.h"
@@ -983,7 +984,31 @@ int qdev_sync_config(DeviceState *dev, Error **errp)
 
 void qmp_device_sync_config(const char *id, Error **errp)
 {
-    DeviceState *dev = find_device_state(id, true, errp);
+    MigrationState *s = migrate_get_current();
+    DeviceState *dev;
+
+    /*
+     * During migration there is a race between syncing`config and migrating it,
+     * so let's just not allow it.
+     *
+     * Moreover, let's not rely on setting up interrupts in paused state, which
+     * may be a part of migration process.
+     */
+
+    if (migration_is_running(s->state)) {
+        error_setg(errp, "Config synchronization is not allowed "
+                   "during migration.");
+        return;
+    }
+
+    if (!runstate_is_running()) {
+        error_setg(errp, "Config synchronization allowed only in '%s' state, "
+                   "current state is '%s'", RunState_str(RUN_STATE_RUNNING),
+                   current_run_state_str());
+        return;
+    }
+
+    dev = find_device_state(id, true, errp);
     if (!dev) {
         return;
     }
diff --git a/system/runstate.c b/system/runstate.c
index d6ab860eca..8fd89172ae 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -189,6 +189,11 @@ bool runstate_check(RunState state)
     return current_run_state == state;
 }
 
+const char *current_run_state_str(void)
+{
+    return RunState_str(current_run_state);
+}
+
 static void runstate_init(void)
 {
     const RunStateTransition *p;
-- 
2.34.1


