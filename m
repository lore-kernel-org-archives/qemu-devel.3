Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0969E1125875
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PMu-0002sO-6m; Wed, 11 Mar 2026 15:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PMY-00021F-83; Wed, 11 Mar 2026 15:37:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PMU-0000Ll-BR; Wed, 11 Mar 2026 15:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257668; bh=BIze4T5aXJtgdZO5QZNHp5TBXi0hPbk13fyDU3GcPls=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=an3wEKbWLeNvHm0bipBw7aqpk1mZ+tPAQm9kqAKL29qrXLRFIbYf5SZAXy3nfbUU+
 B7Dd1jo9W/zUpESBaXPhp/YX8HVe6YoEyRQWGlJGEZBgzpvkmaqWjh158pObMh135K
 rN8pFcAXQlpvtRL7lQ6zMHmebKVNAlKNpCuky1rEcOmsmWfuPODb3I8s53ol/u7jn8
 /i6fFkGxdyY9J6SrotCMkGnzpiAKiZSDNEucXChCedE96ZQJCy55P1sZgkXNouaYKq
 ntKKP02ECREH7IF7Ht4Z3tGs8EZPNQEF/ynpr2AuLfnOAavWgusxIN+P82QZwHag0F
 8XTSaxwa+L86Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 21AAF192101;
 Wed, 11 Mar 2026 22:34:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6305237C466;
 Wed, 11 Mar 2026 22:35:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Oliver Chang <ochang@google.com>, Greg Kurz <groug@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 25/53] hw/9pfs: fix missing EOPNOTSUPP on Twstat and
 Trenameat for fs synth driver
Date: Wed, 11 Mar 2026 22:34:18 +0300
Message-ID: <20260311193449.1096110-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

Renaming files/dirs is only supported by path-based fs drivers. EOPNOTSUPP
should be returned on any renaming attempt for not path-based fs drivers.
This was already the case for 9p "Trename" request type. However for 9p
request types "Trenameat" and "Twstat" this was yet missing.

So fix this by checking in Twstat and Trenameat request handlers whether
the fs driver in use is really path based, if not return EOPNOTSUPP and
abort further handling of the request.

This fixes a crash with the 9p "synth" fs driver which is not path-based.

The crash happened because the synth driver stores and expects a raw
V9fsSynthNode pointer instead of a C-string on V9fsPath.data. So the
C-string delivered by 9p server to synth fs driver was incorrectly
casted to a V9fsSynthNode pointer, eventually causing a segfault.

Reported-by: Oliver Chang <ochang@google.com>
Fixes: https://issues.oss-fuzz.com/issues/477990727
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3298
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Link: https://lore.kernel.org/qemu-devel/E1vrbaP-000Gqb-B3@kylie.crudebyte.com/
(cherry picked from commit b72d15f47cbd2fc93580f33fa86a7e23595a68dd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 127e02a077..9062a064fb 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3516,6 +3516,12 @@ static void coroutine_fn v9fs_renameat(void *opaque)
         goto out_err;
     }
 
+    /* if fs driver is not path based, return EOPNOTSUPP */
+    if (!(s->ctx.export_flags & V9FS_PATHNAME_FSCONTEXT)) {
+        err = -EOPNOTSUPP;
+        goto out_err;
+    }
+
     v9fs_path_write_lock(s);
     err = v9fs_complete_renameat(pdu, olddirfid,
                                  &old_name, newdirfid, &new_name);
@@ -3606,6 +3612,11 @@ static void coroutine_fn v9fs_wstat(void *opaque)
         }
     }
     if (v9stat.name.size != 0) {
+        /* if fs driver is not path based, return EOPNOTSUPP */
+        if (!(s->ctx.export_flags & V9FS_PATHNAME_FSCONTEXT)) {
+            err = -EOPNOTSUPP;
+            goto out;
+        }
         v9fs_path_write_lock(s);
         err = v9fs_complete_rename(pdu, fidp, -1, &v9stat.name);
         v9fs_path_unlock(s);
-- 
2.47.3


