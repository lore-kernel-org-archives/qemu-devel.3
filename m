Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E670CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 09:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDJ5M-0004I0-Gw; Mon, 27 Oct 2025 05:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDJ5A-0004BC-TO
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDJ56-0002YN-TN
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761555596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=zRoqSH0EYkr4DlSWvpsYRCxmS2ZL6b1Fd6WHNXgK9Vo=;
 b=CFLdbwi0LQIHyyw7xuqAgolobQE6Jl/c2Kf48u+5WBb4ueWYXlkaJScVBU8R6rwmP8evwG
 grVf3zd13A84+9GtAe0h7/cDMF1yfQh81A9iAt981vtNmgPA/VrZ4wiNgYO+xMrTeINKI7
 R9wAwO9JiuEfknS7/MIlcZZQrC2n9vQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-sVf1JulfOHypPkRPwkNAeg-1; Mon,
 27 Oct 2025 04:59:54 -0400
X-MC-Unique: sVf1JulfOHypPkRPwkNAeg-1
X-Mimecast-MFC-AGG-ID: sVf1JulfOHypPkRPwkNAeg_1761555592
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF7F719540E2; Mon, 27 Oct 2025 08:59:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B37B1800451; Mon, 27 Oct 2025 08:59:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CF9E521E6925; Mon, 27 Oct 2025 09:59:48 +0100 (CET)
Resent-To: guobin@linux.alibaba.com, qemu-devel@nongnu.org, farosas@suse.de
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 27 Oct 2025 09:59:48 +0100
Resent-Message-ID: <87ikg0pvnf.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Mon Oct 27 07:45:03 2025
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 80D6021E6924; Mon, 27 Oct 2025 07:45:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 guobin@linux.alibaba.com
Subject: [PATCH 1/3] migration: Use unsigned instead of int for bit set of
 MigMode
Date: Mon, 27 Oct 2025 07:45:01 +0100
Message-ID: <20251027064503.1074255-2-armbru@redhat.com>
In-Reply-To: <20251027064503.1074255-1-armbru@redhat.com>
References: <20251027064503.1074255-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Signed operands in bitwise operations are unwise.  I believe they're
safe here, but avoiding them is easy, so let's do that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/migration.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a63b46bbef..9f0a91b1d9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1672,9 +1672,9 @@ void migration_cancel(void)
     }
 }
 
-static int get_modes(MigMode mode, va_list ap);
+static unsigned get_modes(MigMode mode, va_list ap);
 
-static void add_notifiers(NotifierWithReturn *notify, int modes)
+static void add_notifiers(NotifierWithReturn *notify, unsigned modes)
 {
     for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
         if (modes & BIT(mode)) {
@@ -1687,7 +1687,7 @@ static void add_notifiers(NotifierWithReturn *notify, int modes)
 void migration_add_notifier_modes(NotifierWithReturn *notify,
                                   MigrationNotifyFunc func, MigMode mode, ...)
 {
-    int modes;
+    unsigned modes;
     va_list ap;
 
     va_start(ap, mode);
@@ -1876,7 +1876,7 @@ static bool is_busy(Error **reasonp, Error **errp)
     return false;
 }
 
-static bool is_only_migratable(Error **reasonp, Error **errp, int modes)
+static bool is_only_migratable(Error **reasonp, Error **errp, unsigned modes)
 {
     ERRP_GUARD();
 
@@ -1890,9 +1890,9 @@ static bool is_only_migratable(Error **reasonp, Error **errp, int modes)
     return false;
 }
 
-static int get_modes(MigMode mode, va_list ap)
+static unsigned get_modes(MigMode mode, va_list ap)
 {
-    int modes = 0;
+    unsigned modes = 0;
 
     while (mode != -1 && mode != MIG_MODE_ALL) {
         assert(mode >= MIG_MODE_NORMAL && mode < MIG_MODE__MAX);
@@ -1905,7 +1905,7 @@ static int get_modes(MigMode mode, va_list ap)
     return modes;
 }
 
-static int add_blockers(Error **reasonp, Error **errp, int modes)
+static int add_blockers(Error **reasonp, Error **errp, unsigned modes)
 {
     for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
         if (modes & BIT(mode)) {
@@ -1928,7 +1928,7 @@ int migrate_add_blocker_normal(Error **reasonp, Error **errp)
 
 int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
 {
-    int modes;
+    unsigned modes;
     va_list ap;
 
     va_start(ap, mode);
@@ -1945,7 +1945,7 @@ int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
 
 int migrate_add_blocker_internal(Error **reasonp, Error **errp)
 {
-    int modes = BIT(MIG_MODE__MAX) - 1;
+    unsigned modes = BIT(MIG_MODE__MAX) - 1;
 
     if (is_busy(reasonp, errp)) {
         return -EBUSY;
-- 
2.49.0



