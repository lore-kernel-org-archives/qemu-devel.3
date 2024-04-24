Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41CFC10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXbp-0006P3-LG; Wed, 24 Apr 2024 04:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXbY-0005te-JV
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXbW-0003oV-N1
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C0vcnHD36q3vBRtSJzWoo1mOJokKaLTmecVzyyv/5dE=;
 b=BaHFvdr0gQLd7ZW1wXT6hNtdAO+4nYj9UbUAPI3CcCXtCbUbL4iIfT2/oQ4rYdRN3FKYDC
 4824vzhRcEK/IJpu4jkEraDdYPnLOHY9IzbFZiiisvOXqpc8wdd9IReLeYTEB7uR2PmSZb
 ltPUOAXcDmBMRY3xqSq5yMeP1gsayYQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-POa6OTM0OZyIeAXV6jgEVQ-1; Wed, 24 Apr 2024 04:03:39 -0400
X-MC-Unique: POa6OTM0OZyIeAXV6jgEVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4610F812C55;
 Wed, 24 Apr 2024 08:03:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2599F1C060D0;
 Wed, 24 Apr 2024 08:03:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 512FD21E65E1; Wed, 24 Apr 2024 10:03:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 09/10] qapi: Inline and remove QERR_MIGRATION_ACTIVE definition
Date: Wed, 24 Apr 2024 10:03:36 +0200
Message-ID: <20240424080337.2782594-10-armbru@redhat.com>
In-Reply-To: <20240424080337.2782594-1-armbru@redhat.com>
References: <20240424080337.2782594-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Address the comment added in commit 4629ed1e98
("qerror: Finally unused, clean up"), from 2015:

  /*
   * These macros will go away, please don't use
   * in new code, and do not add new ones!
   */

Mechanical transformation using sed, manually
removing the definition in include/qapi/qmp/qerror.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240312141343.3168265-10-armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
[Straightforward conflict with commit aeaafb1e59f (migration: export
migration_is_running) resolved]
---
 include/qapi/qmp/qerror.h | 3 ---
 migration/migration.c     | 2 +-
 migration/options.c       | 4 ++--
 migration/savevm.c        | 2 +-
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index b723830eff..385a4876d6 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -23,9 +23,6 @@
 #define QERR_IO_ERROR \
     "An IO error has occurred"
 
-#define QERR_MIGRATION_ACTIVE \
-    "There's a migration process in progress"
-
 #define QERR_MISSING_PARAMETER \
     "Parameter '%s' is missing"
 
diff --git a/migration/migration.c b/migration/migration.c
index 86bf76e925..32cd89e13d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1956,7 +1956,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
     }
 
     if (migration_is_running()) {
-        error_setg(errp, QERR_MIGRATION_ACTIVE);
+        error_setg(errp, "There's a migration process in progress");
         return false;
     }
 
diff --git a/migration/options.c b/migration/options.c
index d7a773aea8..239f5ecfb4 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -685,7 +685,7 @@ bool migrate_cap_set(int cap, bool value, Error **errp)
     bool new_caps[MIGRATION_CAPABILITY__MAX];
 
     if (migration_is_running()) {
-        error_setg(errp, QERR_MIGRATION_ACTIVE);
+        error_setg(errp, "There's a migration process in progress");
         return false;
     }
 
@@ -729,7 +729,7 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
     bool new_caps[MIGRATION_CAPABILITY__MAX];
 
     if (migration_is_running() || migration_in_colo_state()) {
-        error_setg(errp, QERR_MIGRATION_ACTIVE);
+        error_setg(errp, "There's a migration process in progress");
         return;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index e7c1215671..3fae9f155f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1707,7 +1707,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     MigrationStatus status;
 
     if (migration_is_running()) {
-        error_setg(errp, QERR_MIGRATION_ACTIVE);
+        error_setg(errp, "There's a migration process in progress");
         return -EINVAL;
     }
 
-- 
2.44.0


