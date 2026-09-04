Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CAAC79F81
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 04:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2LbE-0001CH-PG; Fri, 04 Sep 2026 00:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <getshell@seu.edu.cn>)
 id 1x2Koi-0004pe-6U; Thu, 03 Sep 2026 23:42:16 -0400
Received: from mail-m49197.qiye.163.com ([45.254.49.197])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <getshell@seu.edu.cn>)
 id 1x2Kof-0003BI-IC; Thu, 03 Sep 2026 23:42:15 -0400
Received: from LAPTOP-99KJFSET (unknown [36.153.54.56])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4c7fb7a24;
 Fri, 4 Sep 2026 11:33:03 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Lieven <pl@dlhnet.de>,
 Hongyan Xu <getshell@seu.edu.cn>
Subject: [RFC PATCH] nbd/server: hold an export reference during option
 negotiation
Date: Fri,  4 Sep 2026 11:33:02 +0800
Message-ID: <20260904033302.1265-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06a7a1aba03a1kunm85b2304924174
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTUtCVktKGEtCS05IHRhJS1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VTk1ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
 NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=gnws+8SrZ9qh9el7URppVuBI381g16AED2PFo9yq6Dc5JdczrbK9M1O84PCwnD+YkBYPnx/er2nAGJq+ZtI3z8o3JgwSsYbf9/Lbs76i/dYVCTEh+NXOkVC8MERZZwh0oWq5OZHeCww32lNdCP2Bs9BY3CAcuhD6XdOe9C4k8lk=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=ShThp4Pj1WfDjUiolMJV9lM58fXo7OorA2sWdh8SrfE=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=45.254.49.197; envelope-from=getshell@seu.edu.cn;
 helo=mail-m49197.qiye.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 04 Sep 2026 00:32:22 -0400
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

During NBD_OPT_GO / NBD_OPT_INFO negotiation the server runs in a
coroutine that performs blocking I/O with the client.  The handlers call
nbd_export_find(), which returns a raw NBDExport * with no reference
taken (it is a plain QTAILQ lookup), and then dereference that pointer
across multiple yields (nbd_write / nbd_negotiate_send_info etc.).

A client that is still negotiating is not yet on exp->clients, so it
holds no reference.  If the management layer runs block-export-del
(mode hard) while such a client is parked in I/O,
nbd_export_request_shutdown() removes the export from the exports list
and the BlockExport is freed; when the negotiating coroutine resumes it
dereferences a dangling NBDExport * -> use-after-free of host memory.

Take a reference right after the lookup succeeds in
nbd_negotiate_handle_export_name() and nbd_negotiate_handle_info(), and
drop it on every path that leaves the handler without having handed the
export to the client (the client takes its own reference when it is
inserted into exp->clients).  The success paths are unchanged so the
client-owned reference is not double-counted.

Known remaining spot, deliberately not changed here:
nbd_export_meta_context() stores nbd_export_find()'s result into
meta->exp (client->contexts.exp) which is expected to stay consistent
with client->exp (see the assert in nbd_co_block_status_payload_read()).
The reference semantics of contexts.exp deserve maintainer input before
changing them; this patch only covers the two handlers that run before
the client owns a reference.

This is an RFC: the block/export reference-counting semantics should be
confirmed with the NBD maintainers (notably whether a negotiating client
should be tracked so that block-export-del SAFE mode reports the export
as busy instead of racing with a hard delete).

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 nbd/server.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index e6c47f8c2e..8754236a9e 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -517,6 +517,14 @@ nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
         error_setg(errp, "export not found");
         return -EINVAL;
     }
+    /*
+     * The export can be deleted by the management layer while we are
+     * blocked in the writes below (before the client is inserted into
+     * exp->clients and takes its own reference).  Hold a reference for
+     * the whole negotiation so a concurrent block-export-del cannot
+     * free the export under us.
+     */
+    blk_exp_ref(&client->exp->common);
     nbd_check_meta_export(client, client->exp);
 
     myflags = client->exp->nbdflags;
@@ -533,11 +541,15 @@ nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
     ret = nbd_write(client->ioc, buf, len, errp);
     if (ret < 0) {
         error_prepend(errp, "write failed: ");
+        blk_exp_unref(&client->exp->common);
+        client->exp = NULL;
         return ret;
     }
 
     QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
     blk_exp_ref(&client->exp->common);
+    /* Drop the negotiation reference; the client owns one now. */
+    blk_exp_unref(&client->exp->common);
 
     return 0;
 }
@@ -659,6 +671,13 @@ nbd_negotiate_handle_info(NBDClient *client, Error **errp)
                                           errp, "export '%s' not present",
                                           sane_name);
     }
+    /*
+     * Hold a reference across the whole info exchange: the export can
+     * be deleted by the management layer (block-export-del) while we
+     * are blocked sending replies below and before the client is
+     * inserted into exp->clients for NBD_OPT_GO.
+     */
+    blk_exp_ref(&exp->common);
     if (client->opt == NBD_OPT_GO) {
         nbd_check_meta_export(client, exp);
     }
@@ -668,7 +687,7 @@ nbd_negotiate_handle_info(NBDClient *client, Error **errp)
         rc = nbd_negotiate_send_info(client, NBD_INFO_NAME, namelen, name,
                                      errp);
         if (rc < 0) {
-            return rc;
+            goto out;
         }
     }
 
@@ -681,7 +700,7 @@ nbd_negotiate_handle_info(NBDClient *client, Error **errp)
         rc = nbd_negotiate_send_info(client, NBD_INFO_DESCRIPTION,
                                      len, exp->description, errp);
         if (rc < 0) {
-            return rc;
+            goto out;
         }
     }
 
@@ -707,7 +726,7 @@ nbd_negotiate_handle_info(NBDClient *client, Error **errp)
     rc = nbd_negotiate_send_info(client, NBD_INFO_BLOCK_SIZE,
                                  sizeof(sizes), sizes, errp);
     if (rc < 0) {
-        return rc;
+        goto out;
     }
 
     /* Send NBD_INFO_EXPORT always */
@@ -725,7 +744,7 @@ nbd_negotiate_handle_info(NBDClient *client, Error **errp)
     rc = nbd_negotiate_send_info(client, NBD_INFO_EXPORT,
                                  sizeof(buf), buf, errp);
     if (rc < 0) {
-        return rc;
+        goto out;
     }
 
     /*
@@ -736,17 +755,18 @@ nbd_negotiate_handle_info(NBDClient *client, Error **errp)
      */
     if (client->opt == NBD_OPT_INFO && !blocksize &&
         blk_get_request_alignment(exp->common.blk) > 1) {
-        return nbd_negotiate_send_rep_err(client,
-                                          NBD_REP_ERR_BLOCK_SIZE_REQD,
-                                          errp,
-                                          "request NBD_INFO_BLOCK_SIZE to "
-                                          "use this export");
+        rc = nbd_negotiate_send_rep_err(client,
+                                        NBD_REP_ERR_BLOCK_SIZE_REQD,
+                                        errp,
+                                        "request NBD_INFO_BLOCK_SIZE to "
+                                        "use this export");
+        goto out;
     }
 
     /* Final reply */
     rc = nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
     if (rc < 0) {
-        return rc;
+        goto out;
     }
 
     if (client->opt == NBD_OPT_GO) {
@@ -756,6 +776,11 @@ nbd_negotiate_handle_info(NBDClient *client, Error **errp)
         blk_exp_ref(&client->exp->common);
         rc = 1;
     }
+    blk_exp_unref(&exp->common);
+    return rc;
+
+out:
+    blk_exp_unref(&exp->common);
     return rc;
 }
 
-- 
2.50.1.windows.1


