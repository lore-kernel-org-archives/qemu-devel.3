Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C856CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0z2U-000770-Ls; Tue, 23 Sep 2025 05:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0z2P-00074q-4s
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0z2K-0000Ps-Ti
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758618609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q0VhAp6VHGylwcrKaI59tCKnj8YVWze8PKh4yroPvq4=;
 b=iTcS/NQUJiM9OlfL7a35Hg+o3SwdwK60Su3y5OmCnf3z1N6i8DcnWGPntJheaTZE8/zWUe
 giGAbZhQBCKKQsBxdsDkTkORC+whYyniB7Ymr5Zh09iTBI3z1sRT11KYyFFrNm23f/KZu2
 0cFNIBNrMI3ZkB+s9tU0wh4k2Pe9gPY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-vOxletM3P1S7PZIwUSg4og-1; Tue,
 23 Sep 2025 05:10:05 -0400
X-MC-Unique: vOxletM3P1S7PZIwUSg4og-1
X-Mimecast-MFC-AGG-ID: vOxletM3P1S7PZIwUSg4og_1758618604
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D230B195604F; Tue, 23 Sep 2025 09:10:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB76819560BB; Tue, 23 Sep 2025 09:10:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B1FF21E675E; Tue, 23 Sep 2025 11:10:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org,
 vsementsov@yandex-team.ru, Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH v3 04/13] migration/cpr: Clean up error reporting in
 cpr_resave_fd()
Date: Tue, 23 Sep 2025 11:09:51 +0200
Message-ID: <20250923091000.3180122-5-armbru@redhat.com>
In-Reply-To: <20250923091000.3180122-1-armbru@redhat.com>
References: <20250923091000.3180122-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qapi/error.h advises:

 * Please don't error_setg(&error_fatal, ...), use error_report() and
 * exit(), because that's more obvious.

Do that, and replace exit() by g_assert_not_reached(), since this is
actually a programming error.

Cc: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/cpr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/cpr.c b/migration/cpr.c
index 42ad0b0d50..9848a21ea6 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -7,6 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "hw/vfio/vfio-device.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
@@ -100,10 +101,10 @@ void cpr_resave_fd(const char *name, int id, int fd)
     if (old_fd < 0) {
         cpr_save_fd(name, id, fd);
     } else if (old_fd != fd) {
-        error_setg(&error_fatal,
-                   "internal error: cpr fd '%s' id %d value %d "
-                   "already saved with a different value %d",
-                   name, id, fd, old_fd);
+        error_report("internal error: cpr fd '%s' id %d value %d "
+                     "already saved with a different value %d",
+                     name, id, fd, old_fd);
+        g_assert_not_reached();
     }
 }
 
-- 
2.49.0


