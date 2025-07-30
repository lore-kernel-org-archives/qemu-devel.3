Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F14C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 13:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh7Bp-0003B3-R6; Wed, 30 Jul 2025 09:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1uh0We-0002ia-1u
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:42:56 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1uh0Wb-00042O-AV
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UPQiuW0X1x7ANTdAEuVpyPUsgJsVJbvUUNndNxwA91o=; b=VCmdIQ0Gp21iapOvNmP/7wn6Vk
 Kb2sDLgpqFAeRjFWCUrqO4grUxn5QgY0Zup5sZLiOZ1lPGroslDPUiSXkeELp8I3W2DOlYWqqeEXo
 mK466eFksHnuyv/V4yEN6aMhxoaqnuElscyvO0IIkE6Bropdxebfdfym98Y00X60oYXnohQkwObtF
 LtZhGaztECJx8cTKTOy0feiNIcbLJK1nH9G6ae3USte7se8JVGOEYFIDFIARDM0Js9BIccJEhVOyL
 PWNW5lNdecDfCCR2E4lCP6SorBAC4VOQFhhCUZWCofEBvJM+A0NZmNxd95E0tfOJt6z1/bpWgpwaN
 5r+c0GSA==;
Received: from 82-69-92-151.dsl.in-addr.zen.co.uk ([82.69.92.151]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uh0WO-005nOk-HC; Wed, 30 Jul 2025 08:42:40 +0200
From: Alex Bradbury <asb@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>, alex.bennee@linaro.org, erdnaxe@crans.org,
 ma.mandourr@gmail.com, pierrick.bouvier@linaro.org
Subject: [PATCH 1/5] contrib/plugins/hotblocks: Correctly free sorted counts
 list
Date: Wed, 30 Jul 2025 07:41:39 +0100
Message-ID: <cf5a00136738b981a12270b76572e8d502daf208.1753857212.git.asb@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753857212.git.asb@igalia.com>
References: <cover.1753857212.git.asb@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.97.179.56; envelope-from=asb@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 30 Jul 2025 09:05:37 -0400
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

g_list_free should be passed the head of the list.

Signed-off-by: Alex Bradbury <asb@igalia.com>
---
 contrib/plugins/hotblocks.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 98404b6885..d3dd23ed9f 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -73,15 +73,16 @@ static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) report = g_string_new("collected ");
-    GList *counts, *it;
+    GList *counts, *sorted_counts, *it;
     int i;
 
     g_string_append_printf(report, "%d entries in the hash table\n",
                            g_hash_table_size(hotblocks));
     counts = g_hash_table_get_values(hotblocks);
-    it = g_list_sort_with_data(counts, cmp_exec_count, NULL);
+    sorted_counts = g_list_sort_with_data(counts, cmp_exec_count, NULL);
 
-    if (it) {
+    if (sorted_counts) {
+        it = sorted_counts;
         g_string_append_printf(report, "pc, tcount, icount, ecount\n");
 
         for (i = 0; i < limit && it->next; i++, it = it->next) {
@@ -94,7 +95,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
                     qemu_plugin_scoreboard_u64(rec->exec_count)));
         }
 
-        g_list_free(it);
+        g_list_free(sorted_counts);
     }
 
     qemu_plugin_outs(report->str);
-- 
2.50.1


