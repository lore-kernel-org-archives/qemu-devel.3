Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEFBF8A17A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 13:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDN5Z-0004bS-5f; Thu, 16 Apr 2026 09:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1wDN5X-0004aP-72
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 09:48:59 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1wDN5T-0006oW-KS
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 09:48:58 -0400
Received: from localhost.localdomain (1.general.hector.uk.vpn [10.172.192.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B775941BCF; 
 Thu, 16 Apr 2026 13:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776347330;
 bh=3b/OHn1spnQeTh+fTVR6lNFAecDdacLs/uOeL7El+1c=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=dVLfQ7gIG7Cpc0YEjRwhYd9KwIS68vxCITIyzOGwF8kh/Gi1P1G9j01dEuKdjjjsG
 lzz1ZiBFwNINnyLq80jmZrJ7ittolEnzpLFnp4/NFm0OC4aKMvnzZ2/6GBS1o7wgV9
 5B5pdPCD9IzvKi5/CixLjV75ppgu2OXDWkdcdXgU4P5Y9oQErM8Wq0Vh6YAPr8mfg7
 2HsVA6fLDEFJrHvFHLnje+UVMrxk8sKlSc060Wj1K9qJd6APGGDh8F+9Azcm7emoqd
 9u938l6YogsOMyJyRqKYIq1VZO3xK1Mr71T99ZCXVROFNUy0UZHybuFNWeQxAmUTm+
 8t3Gw9D2OeKhJU7c8JTBeTqWQ33HOwt5e49aV3Sr4A7OFEViiQRouLcynsS50PSkiT
 xx+d3tQI/S/lnnlz4XInqFvC+fmI1m8cr2HZqgnlz+zunKgpFQB6YReDeeY0q0nPOu
 6KbyhOxyxJwPeCSM5POSpvoBfVDGsJmNMaZUQJrk09CvXjc8Uq2wE0Ws6AU4bxBGhQ
 P0TF45JLUdG42Su4r5wzFXFec1uBhF7Y+JXFjuGsJmlfT0bIR0BkeixbGK1UycH+Fd
 mtompqrHZ3NNQ2la2vO4z+T2QnwGHM29rcv53T2LocrStiR/YdiAZrwJ5gwBydKAlR
 VrhsIFyUDO32hzuHHsMWUUEg=
From: Hector Cao <hector.cao@canonical.com>
To: qemu-devel@nongnu.org
Cc: Hector Cao <hector.cao@canonical.com>
Subject: [PATCH] module: fix early stop for module loading function
Date: Thu, 16 Apr 2026 15:48:42 +0200
Message-ID: <20260416134842.1726474-1-hector.cao@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.121;
 envelope-from=hector.cao@canonical.com;
 helo=smtp-relay-canonical-1.canonical.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The commit c551fb0b53d introduces a regression on the behavior
of the module load logic. Historically, if QEMU cannot load a
particular module in a folder, it keeps going and look for the
module in the remaining folders. The mentioned commit make QEMU
stop if the module exists but cannot be loaded (build mismatch
reason for example).

This causes QEMU fail to load the right module and this failure
happens usually when QEMU is upgraded and therefore QEMU has
several folders to look for the modules.

In addition to the regression on the behavior, this commit
introduces also a leak in the function module_load_dso()
that does not remove the entries from the list dso_init_list
when the the module load fails for build mismatch.

This commit has 2 folds:
 - restores the correct legacy behavior
 - fix the memory leak in module_load_dso()

Fixes: c551fb0b53d ("module: add Error arguments to module_load and module_load_qom")
Signed-off-by: Hector Cao <hector.cao@canonical.com>
---
 util/module.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/util/module.c b/util/module.c
index 32e263163c7..4d5b74fa6e4 100644
--- a/util/module.c
+++ b/util/module.c
@@ -184,6 +184,11 @@ static bool module_load_dso(const char *fname, bool export_symbols,
                 "Only modules from the same build can be loaded.\n");
         }
         g_module_close(g_module);
+        /* Clean up any dso init entries added during DSO initialization */
+        QTAILQ_FOREACH_SAFE(e, &dso_init_list, node, next) {
+            QTAILQ_REMOVE(&dso_init_list, e, node);
+            g_free(e);
+        }
         return false;
     }
 
@@ -279,29 +284,28 @@ int module_load(const char *prefix, const char *name, Error **errp)
         }
     }
 
-    for (i = 0; i < n_dirs; i++) {
+    /*
+     * Try to load module in given folders until we load it successfully or no
+     * more to look.
+     * If no module can be loaded successfully, errp is set to the last encountered error
+     */
+    rv = 0; /* module not found */
+    for (i = 0; (i < n_dirs) && (rv != 1); i++) {
         char *fname = g_strdup_printf("%s/%s%s",
                                       dirs[i], module_name, CONFIG_HOST_DSOSUF);
         int ret = access(fname, F_OK);
-        if (ret != 0 && (errno == ENOENT || errno == ENOTDIR)) {
-            /*
-             * if we don't find the module in this dir, try the next one.
-             * If we don't find it in any dir, that can be fine too: user
-             * did not install the module. We will return 0 in this case
-             * with no error set.
-             */
-            g_free(fname);
-            continue;
-        } else if (ret != 0) {
+        if ((ret == 0) && module_load_dso(fname, export_symbols, errp)) {
+            rv = 1; /* module successfully loaded */
+        }
+
+        /* The file exists but cannot be accessed -> report an error and continue */
+        if ((ret != 0) && (errno != ENOENT) && (errno != ENOTDIR)) {
             /* most common is EACCES here */
             error_setg_errno(errp, errno, "error trying to access %s", fname);
-        } else if (module_load_dso(fname, export_symbols, errp)) {
-            rv = 1; /* module successfully loaded */
         }
+
         g_free(fname);
-        goto out;
     }
-    rv = 0; /* module not found */
 
 out:
     if (rv <= 0) {
-- 
2.43.0


