Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E17CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 20:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEZJN-0000hP-9K; Thu, 30 Oct 2025 16:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZJC-0000fN-Jq
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:31:47 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZIw-0005v1-B6
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:31:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id B534880A81;
 Thu, 30 Oct 2025 23:31:20 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HVmKdN0F6Cg0-xSuIlzYQ; Thu, 30 Oct 2025 23:31:20 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761856280;
 bh=m3l8D6/W9LkZBZ3lH190RliJgauyjn3Sep0D+DmIu1Y=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=vyggrqc91/TXyDzkIQVn5K6CU31frztBuxGpHoxJ81PdMbSm7pDkCDwTaBgvgL3kz
 4d8wVhKW872MJlpCvCguBm6wJP2qiab2S4dChv2jQVPML6wyByNrbyUOh0BCUnzV3k
 L3ksXvnE7bZYXVgVwAORFfxefYNwxgCn/txtsI10=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, zhao1.liu@intel.com,
 qemu-devel@nongnu.org, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v9 1/8] migration: introduce .pre_incoming() vmsd handler
Date: Thu, 30 Oct 2025 23:31:08 +0300
Message-ID: <20251030203116.870742-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030203116.870742-1-vsementsov@yandex-team.ru>
References: <20251030203116.870742-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add possibility for devices to hook into top of migrate-incoming QMP
command. It's a place, where migration capabilities and parameters
are already set, but migration downtime is not yet started (source
is still running). So here devices may do some remaining initializations
dependent on migration capabilities. This will be used in further commit
to support backend-transfer migration feature for vhost-user-blk.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h |  1 +
 migration/migration.c       |  4 ++++
 migration/savevm.c          | 15 +++++++++++++++
 migration/savevm.h          |  1 +
 4 files changed, 21 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 09f1eefcfb..6ea5b212f2 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -217,6 +217,7 @@ struct VMStateDescription {
     int version_id;
     int minimum_version_id;
     MigrationPriority priority;
+    bool (*pre_incoming)(void *opaque, Error **errp);
     int (*pre_load)(void *opaque);
     int (*pre_load_errp)(void *opaque, Error **errp);
     int (*post_load)(void *opaque, int version_id);
diff --git a/migration/migration.c b/migration/migration.c
index a63b46bbef..6ed6a10f57 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1983,6 +1983,10 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
         return;
     }
 
+    if (!qemu_pre_incoming(errp)) {
+        return;
+    }
+
     if (!yank_register_instance(MIGRATION_YANK_INSTANCE, errp)) {
         return;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index 7b35ec4dd0..6e240ea100 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1268,6 +1268,21 @@ bool qemu_savevm_state_blocked(Error **errp)
     return false;
 }
 
+bool qemu_pre_incoming(Error **errp)
+{
+    SaveStateEntry *se;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (se->vmsd && se->vmsd->pre_incoming) {
+            if (!se->vmsd->pre_incoming(se->opaque, errp)) {
+                return false;
+            }
+        }
+    }
+
+    return true;
+}
+
 void qemu_savevm_non_migratable_list(strList **reasons)
 {
     SaveStateEntry *se;
diff --git a/migration/savevm.h b/migration/savevm.h
index c337e3e3d1..4ad8997f94 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -29,6 +29,7 @@
 #define QEMU_VM_COMMAND              0x08
 #define QEMU_VM_SECTION_FOOTER       0x7e
 
+bool qemu_pre_incoming(Error **errp);
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_non_migratable_list(strList **reasons);
 int qemu_savevm_state_prepare(Error **errp);
-- 
2.48.1


