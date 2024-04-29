Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D894DC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Km4-0001uG-My; Mon, 29 Apr 2024 02:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s1Klp-0001qZ-MU; Mon, 29 Apr 2024 02:45:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s1Klm-0006Wv-Jx; Mon, 29 Apr 2024 02:45:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EA74562CB1;
 Mon, 29 Apr 2024 09:45:39 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 01C47C33F4;
 Mon, 29 Apr 2024 09:45:37 +0300 (MSK)
Received: (nullmailer pid 238432 invoked by uid 1000);
 Mon, 29 Apr 2024 06:45:36 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 2/9] target/s390x/cpu_models: Rework the output of "-cpu help"
Date: Mon, 29 Apr 2024 09:45:29 +0300
Message-Id: <20240429064536.238392-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429064536.238392-1-mjt@tls.msk.ru>
References: <20240429064536.238392-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Thomas Huth <thuth@redhat.com>

Printing an "s390x" in front of each CPU name is not helpful at all:
It is confusing for the users since they don't know whether they
have to specify these letters for the "-cpu" parameter, too, and
it also takes some precious space in the dense output of the CPU
entries. Let's simply remove this now!

While we're at it, use two spaces at the beginning of the lines for
the indentation of the entries, and add a "Available CPUs" in the
very first line, like most other target architectures are doing it
for their "-cpu help" output already.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/s390x/cpu_models.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8ed3bb6a27..58c58f05a0 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -355,9 +355,9 @@ static void s390_print_cpu_model_list_entry(gpointer data, gpointer user_data)
     /* strip off the -s390x-cpu */
     g_strrstr(name, "-" TYPE_S390_CPU)[0] = 0;
     if (details->len) {
-        qemu_printf("s390 %-15s %-35s (%s)\n", name, scc->desc, details->str);
+        qemu_printf("  %-15s %-35s (%s)\n", name, scc->desc, details->str);
     } else {
-        qemu_printf("s390 %-15s %-35s\n", name, scc->desc);
+        qemu_printf("  %-15s %-35s\n", name, scc->desc);
     }
     g_free(name);
 }
@@ -402,6 +402,7 @@ void s390_cpu_list(void)
     S390Feat feat;
     GSList *list;
 
+    qemu_printf("Available CPUs:\n");
     list = object_class_get_list(TYPE_S390_CPU, false);
     list = g_slist_sort(list, s390_cpu_list_compare);
     g_slist_foreach(list, s390_print_cpu_model_list_entry, NULL);
@@ -411,14 +412,14 @@ void s390_cpu_list(void)
     for (feat = 0; feat < S390_FEAT_MAX; feat++) {
         const S390FeatDef *def = s390_feat_def(feat);
 
-        qemu_printf("%-20s %s\n", def->name, def->desc);
+        qemu_printf("  %-20s %s\n", def->name, def->desc);
     }
 
     qemu_printf("\nRecognized feature groups:\n");
     for (group = 0; group < S390_FEAT_GROUP_MAX; group++) {
         const S390FeatGroupDef *def = s390_feat_group_def(group);
 
-        qemu_printf("%-20s %s\n", def->name, def->desc);
+        qemu_printf("  %-20s %s\n", def->name, def->desc);
     }
 }
 
-- 
2.39.2


