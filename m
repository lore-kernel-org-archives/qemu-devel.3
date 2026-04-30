Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59772FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGN-00040S-2E; Thu, 30 Apr 2026 10:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1wIRNT-0002jN-Ov
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:24:27 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1wIRNR-0008C7-El
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:24:27 -0400
Received: from localhost.localdomain (1.general.hector.uk.vpn [10.172.192.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8E93F415CF; 
 Thu, 30 Apr 2026 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777555462;
 bh=24GRoT+i2ParXbW0fE7bgd7xwUnLMs1Zxrc3DSYrFEA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=W5Sd5OdeYoMNUtnS6WB5d/7/fjYKfKQASRwkACxI3a1Mv1LsjtIlnVB5WGvbRgx5M
 zBUxT2EfDr4KA673os7qgeRsBnxoKRQoafo+/mtAi4e5e6KuKFOxeTEP5KURIP8Jnb
 yWW4PvulqSvNi5D9UufLfJ814GV57Rfvju55dUis7ZtqrV8xEFYvacqQ7XLk8IUTsu
 q8+kOem+QMjgdWLQKgaEdGvs2oK7h5zRFrw5zlIZoLfm4RD3TiWySwoNKL4/0yj2ck
 c0Tfb+ocKRRoomKNNl45OdtvXVhwG/xbF0dtP2p2+g98/QFYhf0r1tFQ2vBN5fIkEH
 O4TjJdxYbdIeDeLnN6VvPgLtRKNXKeEtej1btvCYA/YH6LZ8ZQwGNPR6j4uYhDn/Mc
 mAcGtcPWYGXeXZo//7wTKzamK52XUknV2La/LqYjQ/F7NN+IVjtV9w3Xo+gyocqGra
 QWmQKb1SuCnfix6DB5bQpVQdFgOvguxN8edqWUHrq55Kc3zQn1xpv97c7ydUP9cac3
 N4eBBXX0T0/TGF1EPUPGXuK4xCCGr+rDjNAZKI9Y/PmXznkL9cc63MRUYJ8Ax4j3KH
 H9n1bXMT8RbyJ6lsZ5gw2vEmG91OhKoVtx4+HOEFUgXWT8GxQejHTbe1oO80KEbICW
 WMErn+383nOYh8ylalOfJhbI=
From: Hector Cao <hector.cao@canonical.com>
To: qemu-devel@nongnu.org
Cc: cfontana@suse.de, richard.henderson@linaro.org, pbonzini@redhat.com,
 gabriel.hartmann@netways.de
Subject: [PATCH v2 1/1] module: fix early stop for load module function
Date: Thu, 30 Apr 2026 15:24:18 +0200
Message-ID: <20260430132418.275842-2-hector.cao@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430132418.275842-1-hector.cao@canonical.com>
References: <20260430132418.275842-1-hector.cao@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.120;
 envelope-from=hector.cao@canonical.com;
 helo=smtp-relay-canonical-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Commit c551fb0b53d regressed module-loading behavior.
Historically, when loading from one module directory failed,
QEMU continued searching the remaining directories. That commit
made QEMU stop if a matching file was found but could not be
loaded (for example, due to a build mismatch).

As a result, QEMU can fail to load the correct module, typically
when the build option module-upgrades is enabled and at upgrades
multiple module directories exist.

In addition to the regression on the behavior, this commit introduces
also a leak in the function module_load_dso() that does not remove
the entries from the list dso_init_list when the the module load
fails for build mismatch.

This commit has 2 folds:
 - restores the correct legacy behavior + set rv to -1 in case
   of load failure for one found module.
 - fix the memory leak in module_load_dso()

Fixes: c551fb0b53d ("module: add Error arguments to module_load and module_load_qom")
Signed-off-by: Hector Cao <hector.cao@canonical.com>
---
 util/module.c | 51 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/util/module.c b/util/module.c
index 09dc43f51eb..435b34e354f 100644
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
 
@@ -279,29 +284,41 @@ int module_load(const char *prefix, const char *name, Error **errp)
         }
     }
 
-    for (i = 0; i < n_dirs; i++) {
+    /*
+     * Try to load module in given folders until we load it successfully or no
+     * more to look.
+     * If no module can be loaded successfully, errp is set to the last encountered error
+     */
+    rv = 0;
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
-            /* most common is EACCES here */
-            error_setg_errno(errp, errno, "error trying to access %s", fname);
-        } else if (module_load_dso(fname, export_symbols, errp)) {
-            rv = 1; /* module successfully loaded */
+        if (ret == 0) {
+            if (module_load_dso(fname, export_symbols, errp)) {
+                /* module successfully loaded */
+                rv = 1;
+            } else {
+                /* fail to load a module */
+                rv = -1;
+            }
+        } else {
+            /* The file exists but cannot be accessed -> report an error and continue */
+            if ((errno != ENOENT) && (errno != ENOTDIR)) {
+                /* most common is EACCES here */
+                error_setg_errno(errp, errno, "error trying to access %s", fname);
+                rv = -1;
+            }
         }
+
         g_free(fname);
-        goto out;
+
+        /* If we have more to look at, report the current error */
+        if ((i < n_dirs - 1) && (rv != 1) && errp && *errp) {
+            error_report_err(*errp);
+            *errp = NULL;
+        }
     }
-    rv = 0; /* module not found */
 
 out:
     if (rv <= 0) {
-- 
2.43.0


