Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C693D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 12:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaC4N-000889-Pk; Mon, 29 Dec 2025 07:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1vaC4C-000828-9T
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 07:09:41 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1vaC4A-0005CP-PH
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 07:09:40 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1767010134; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JMeTRdngsOjXP41ZeM0ftEVP9993mpQBwj1wB11zI9loknX29Nq6sTJEmTC5d9KEwFvnf54EOo2W5kaa4JvBPMydAmVg//QcVaEKAMvv3AHmYkttKWJtOiggOBQZ6XhuUySrmT6tkPocKVnGt/iMqanoOIyWdqaL2TptzaFLvzk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1767010134;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HxLFsoVDmsqRvELTh+BEpbqJgwtq55Gc8sai31DAemU=; 
 b=TZrUz2bF06VGb4cQO/W/6gAyRx1Mj7KNQ1vfxjG2y6RcCLdP+PnpjDevjDBiVltgHKocsrQMVrvBjltBmJEJJwFFmDDDo7FJ7OmlcMOFyKI8VYYd7BHnVnwQ6tkVxk56K2dQfvJRQ0Rn0/9ovheRq6wH0FNX2EtwJbQHiezbpGo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767010134; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=HxLFsoVDmsqRvELTh+BEpbqJgwtq55Gc8sai31DAemU=;
 b=sj2R9RuFyC7Q4VK2ZzTgEAfVgeJ40T98/C6lHWkOz+EyMuZIO5Dyi1uHz15C45b2
 IAflGzAFMJWLsHG1RheBleFWZXLGy1HOOMjQHiCFKI/iUlr29EWugJ9EeUC4fJvoePD
 Fv/leEA9g00fMLQqZMtlxqnkOSRMam3CkJDrEqbU=
Received: by mx.zohomail.com with SMTPS id 1767010131227743.6672530480084;
 Mon, 29 Dec 2025 04:08:51 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>, qemu-devel@nongnu.org,
 Li Chen <me@linux.beauty>
Subject: [PATCH 3/3] tests/qtest: cpr-reboot: check ignore-shared transfer
Date: Mon, 29 Dec 2025 20:08:37 +0800
Message-ID: <20251229120839.89817-4-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229120839.89817-1-me@linux.beauty>
References: <20251229120839.89817-1-me@linux.beauty>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112; envelope-from=me@linux.beauty;
 helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add a cpr-reboot qtest that enables x-ignore-shared and asserts the amount
of RAM transferred stays far below the guest RAM size.

This covers the shared RAM behavior: device state is saved while shared
RAM is preserved in place.

Signed-off-by: Li Chen <me@linux.beauty>
---
 tests/qtest/migration/cpr-tests.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 5eafc4d678..6fa09b54ee 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -52,6 +52,23 @@ static void test_mem_backend_file_fdset(void)
 }
 #endif
 
+static void test_ignore_shared_end(QTestState *from, QTestState *to,
+                                   void *opaque)
+{
+    int64_t transferred;
+    int64_t total;
+    int64_t limit;
+
+    transferred = read_ram_property_int(from, "transferred");
+    total = read_ram_property_int(from, "total");
+    limit = total / 32;
+    limit = MIN(limit, 8 * 1024 * 1024);
+    limit = MAX(limit, 2 * 1024 * 1024);
+    g_test_message("ram.transferred=%" PRId64 " ram.total=%" PRId64
+                   " limit=%" PRId64, transferred, total, limit);
+    g_assert_cmpint(transferred, <, limit);
+}
+
 static void *migrate_hook_start_mode_reboot(QTestState *from, QTestState *to)
 {
     migrate_set_parameter_str(from, "mode", "cpr-reboot");
@@ -69,6 +86,7 @@ static void test_mode_reboot(void)
         .connect_uri = uri,
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_mode_reboot,
+        .end_hook = test_ignore_shared_end,
         .start = {
             .caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true,
         },
-- 
2.52.0


