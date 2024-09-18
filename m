Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7209CCAC5AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 00:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqi9K-00006e-NK; Tue, 17 Sep 2024 20:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqi9F-0008TN-CP
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 20:02:21 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqi9D-0006Nm-71
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 20:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=bD3rvGM9bKH1LNpdoa6AoyOCSg7fPA7SsO5lOyd/K/s=; b=rC1Bd1IySEFRS370
 mNhK6WcF0pHDH1eVMWMgdPkoh5eEjA6O0SyveyCOKNBt2IQPf+gRTM5HR6LaQaWB1+wm1paAzVrK9
 y0ua0+YIt3WdH1FBUyih3TJtts+kSmhY1LXsDc2ZDeB3jDmf+api4mXHazQLMVMwN7a7Lc6zKg9Tk
 EppATigC6PX5spBUbFqLqLrjjp7S1AzQ1YEJGEXCvH/7j55raWuz3oVxoJOoUF4Ff9lKAVRutT53T
 Z8vJnbBNoDJPaicWA/DHijolIbjlIhJ9aTyX3oOaYIPaQjlpR+WfMpKh9+aH3CAq3tBTbIH9LLLN+
 2YnNmArgBMuK+P/2HQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqi9A-006Dj5-19;
 Wed, 18 Sep 2024 00:02:16 +0000
From: dave@treblig.org
To: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 1/3] migration: Remove migrate_cap_set
Date: Wed, 18 Sep 2024 01:02:05 +0100
Message-ID: <20240918000207.182683-2-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918000207.182683-1-dave@treblig.org>
References: <20240918000207.182683-1-dave@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

migrate_cap_set has been unused since
  18d154f575 ("migration: Remove 'blk/-b' option from migrate commands")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 migration/options.c | 20 --------------------
 migration/options.h |  1 -
 2 files changed, 21 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 147cd2b8fd..9460c5dee9 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -605,26 +605,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     return true;
 }
 
-bool migrate_cap_set(int cap, bool value, Error **errp)
-{
-    MigrationState *s = migrate_get_current();
-    bool new_caps[MIGRATION_CAPABILITY__MAX];
-
-    if (migration_is_running()) {
-        error_setg(errp, "There's a migration process in progress");
-        return false;
-    }
-
-    memcpy(new_caps, s->capabilities, sizeof(new_caps));
-    new_caps[cap] = value;
-
-    if (!migrate_caps_check(s->capabilities, new_caps, errp)) {
-        return false;
-    }
-    s->capabilities[cap] = value;
-    return true;
-}
-
 MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
 {
     MigrationCapabilityStatusList *head = NULL, **tail = &head;
diff --git a/migration/options.h b/migration/options.h
index a0bd6edc06..36e7b3723f 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -58,7 +58,6 @@ bool migrate_tls(void);
 /* capabilities helpers */
 
 bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp);
-bool migrate_cap_set(int cap, bool value, Error **errp);
 
 /* parameters */
 
-- 
2.46.0


