Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B963CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 09:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDJ5F-0004C2-Os; Mon, 27 Oct 2025 05:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDJ59-0004Au-UK
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDJ56-0002YM-OV
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761555596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=XZUl7HRBPcEusP4+ie7ACy7kl0AnVZqiBGsnVbFuRhE=;
 b=CYOc5g+VX58y9D+WJfWoziggMt9zlPy7x+U4FaJzbtu1eyZSmCaDPuZusFYTux09ShWT3J
 2TZGMqYDQmGLvJs8HDVd+/FgBD7LAY0Td0AKGeRnSetP4OVBH8PrqwDanRhk188lhh11Z7
 PH2lG2dWr+bH6LGDAZE20fWwLfUEX88=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-NjKFreRqP36lrxkeJ9WkJQ-1; Mon,
 27 Oct 2025 04:59:54 -0400
X-MC-Unique: NjKFreRqP36lrxkeJ9WkJQ-1
X-Mimecast-MFC-AGG-ID: NjKFreRqP36lrxkeJ9WkJQ_1761555593
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7813180A225; Mon, 27 Oct 2025 08:59:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 403A91800578; Mon, 27 Oct 2025 08:59:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E7B4821E6773; Mon, 27 Oct 2025 09:59:48 +0100 (CET)
Resent-To: guobin@linux.alibaba.com, qemu-devel@nongnu.org, farosas@suse.de
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 27 Oct 2025 09:59:48 +0100
Resent-Message-ID: <87a51cpvnf.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Mon Oct 27 07:45:03 2025
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8983F21E6935; Mon, 27 Oct 2025 07:45:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 guobin@linux.alibaba.com
Subject: [PATCH 3/3] migration: Put Error **errp parameter last
Date: Mon, 27 Oct 2025 07:45:03 +0100
Message-ID: <20251027064503.1074255-4-armbru@redhat.com>
In-Reply-To: <20251027064503.1074255-1-armbru@redhat.com>
References: <20251027064503.1074255-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

qapi/error.h's big comment:

 * - Functions that use Error to report errors have an Error **errp
 *   parameter.  It should be the last parameter, except for functions
 *   taking variable arguments.

is_only_migratable() and add_blockers() have it in the middle.  Clean
them up.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/migration.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5f1c83aafd..8a06b54167 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1867,7 +1867,7 @@ static bool is_busy(Error **reasonp, Error **errp)
     return false;
 }
 
-static bool is_only_migratable(Error **reasonp, Error **errp, unsigned modes)
+static bool is_only_migratable(Error **reasonp, unsigned modes, Error **errp)
 {
     ERRP_GUARD();
 
@@ -1881,7 +1881,7 @@ static bool is_only_migratable(Error **reasonp, Error **errp, unsigned modes)
     return false;
 }
 
-static int add_blockers(Error **reasonp, Error **errp, unsigned modes)
+static int add_blockers(Error **reasonp, unsigned modes, Error **errp)
 {
     for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
         if (modes & BIT(mode)) {
@@ -1904,12 +1904,12 @@ int migrate_add_blocker_normal(Error **reasonp, Error **errp)
 
 int migrate_add_blocker_modes(Error **reasonp, unsigned modes, Error **errp)
 {
-    if (is_only_migratable(reasonp, errp, modes)) {
+    if (is_only_migratable(reasonp, modes, errp)) {
         return -EACCES;
     } else if (is_busy(reasonp, errp)) {
         return -EBUSY;
     }
-    return add_blockers(reasonp, errp, modes);
+    return add_blockers(reasonp, modes, errp);
 }
 
 int migrate_add_blocker_internal(Error **reasonp, Error **errp)
@@ -1919,7 +1919,7 @@ int migrate_add_blocker_internal(Error **reasonp, Error **errp)
     if (is_busy(reasonp, errp)) {
         return -EBUSY;
     }
-    return add_blockers(reasonp, errp, modes);
+    return add_blockers(reasonp, modes, errp);
 }
 
 void migrate_del_blocker(Error **reasonp)
-- 
2.49.0



