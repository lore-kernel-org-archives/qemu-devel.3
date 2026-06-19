Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF23CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWJ9-0006Ip-1d; Fri, 19 Jun 2026 06:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1waWJ6-0006Hu-Qe
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:18:40 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1waWJ5-0000ex-8N
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=z0+VW17wfJS3shuNYwL5tr2zZ2QgOCrT0q6hQjfLvuU=; b=q1dMBvR/kBfF
 uVeBVTh/ETQHx73+BEoAXaYAp5zZ25w/xLcfMMFncdXoy122gBWuSQoYdVG4ruW43eURuIEwdynZy
 X6/q4BO99grG7w3N3uQo44vKsf0jqu4MKgPikkK8WzoOuiPCP8RAYPYsEfBz7qrsTfWjYsGLpW1xT
 jRH45lzNXUS67lcH9BCfCcKg0mWMTBJJ25C3eTatZqqXabzTEyCd7i+0V2fKFrSEwoBuufCyRlGnp
 PI8OYK+90ssAy9pIdGML1kn5y7GtcYk58pi5JXOtYjQlyd59YWNkSx2JVrxMTNJjkV9pv4sFeQB+3
 09MfOgmsNR4FHWgEjh7MfQ==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1waWIS-006QLJ-2q;
 Fri, 19 Jun 2026 12:18:32 +0200
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, anisinha@redhat.com, berrange@redhat.com,
 peterx@redhat.com, farosas@suse.de, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v5 1/7] migration: add migration_guest_ram_loading() helper
Date: Fri, 19 Jun 2026 12:18:28 +0200
Message-ID: <20260619101834.228432-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619101834.228432-1-den@openvz.org>
References: <20260619101834.228432-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Operations that read guest RAM (dump-guest-memory, memsave, pmemsave)
must refuse to run while the destination of a migration is still
receiving that RAM: during precopy it is incomplete, and during postcopy
a read faults the page in from the source. Provide a single predicate
they can share instead of open-coding the runstate and postcopy checks.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 include/migration/misc.h | 3 +++
 migration/migration.c    | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 3159a5e53c..d3d6e1f50d 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -117,6 +117,9 @@ void migration_file_set_error(int ret, Error *err);
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
 bool migration_in_incoming_postcopy(void);
 
+/* True while the destination still receives guest RAM (precopy or postcopy) */
+bool migration_guest_ram_loading(void);
+
 /* True if incoming migration entered POSTCOPY_INCOMING_ADVISE */
 bool migration_incoming_postcopy_advised(void);
 
diff --git a/migration/migration.c b/migration/migration.c
index 074d3f2c69..095c55fdae 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1643,6 +1643,12 @@ bool migration_in_incoming_postcopy(void)
     return ps >= POSTCOPY_INCOMING_DISCARD && ps < POSTCOPY_INCOMING_END;
 }
 
+bool migration_guest_ram_loading(void)
+{
+    return runstate_check(RUN_STATE_INMIGRATE) ||
+           migration_in_incoming_postcopy();
+}
+
 bool migration_incoming_postcopy_advised(void)
 {
     PostcopyState ps = postcopy_state_get();
-- 
2.53.0


