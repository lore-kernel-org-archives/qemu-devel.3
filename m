Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8560CC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 09:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqU5O-0000W1-5o; Fri, 07 Mar 2025 04:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <5c622067efd66dd4ee5eca740dcf263f41db20b2@kylie.crudebyte.com>)
 id 1tqU5K-0000VD-C2; Fri, 07 Mar 2025 04:33:39 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <5c622067efd66dd4ee5eca740dcf263f41db20b2@kylie.crudebyte.com>)
 id 1tqU5I-0002u5-Nv; Fri, 07 Mar 2025 04:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=HE/Kzh5V43tzdD8T3Art6OIycWgew71hLgw70s1MLto=; b=xF65K
 /aPM4fh7UdW3Fsfg+ryknOJDnym0Z7PmBflcQm1CEYgfeGPLdPoBVaHFdp21kH2Yg9nvK8LPTkyZ7
 dclsXbYp/J89XGkiGLIvXCkOHmweDz5REkzqJPdHdBPenAa+mkz8SXacpOpMn2x1DetIQLt/JP+dH
 OAZHzcOFMEnfCmXPT7DWclN6peVVk0a1wC/+3yHDGGw1d52n9ng3lNriN99irN87Tc0gkKSKgbLmo
 OzOcmq7XW6yo8wKZ7nPkbDtR8G00fgMaXmfLmhCYoctBBh7qLNxtxfkiuze3oLMQTRK0ILIsrYSeK
 i9DR3tMIPxsTxg351sZlzCA7iEfb4xQtGFBDqW77hsW0Din7FbMyvNn/Xef/p9JfUG21nT6rd8qtC
 LPVQHU6SuMBkMwAEM0ME9DL5pXFWkZeJOWhC2OzEgWNE2XnDiNLOMrBUYhprXMIVT8EcBAjgrbzWP
 xt1kkU9/hbfagpFHqv588F5qSI2y0/d3hFzEX1PNaeHhQXtJcQJyNs+k3hb5pRGPdqoFJl+my2jHp
 6mGpE8vcRXPFFszXMibNLo8RLtCPbPd5wRvlYb1ja8wflTFmCPlN7VVu/uUH39iPtNvDiB4a+8JIJ
 DW17bThB73oGghtwN9gtS9xeV4HTus6sbQYvf8nlkroHiZ9vOU2eWKra2SSEAU=;
Message-Id: <5c622067efd66dd4ee5eca740dcf263f41db20b2.1741339452.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1741339452.git.qemu_oss@crudebyte.com>
References: <cover.1741339452.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 7 Mar 2025 10:22:56 +0100
Subject: [PATCH v2 1/2] 9pfs: fix concurrent v9fs_reclaim_fd() calls
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    qemu-stable@nongnu.org
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=5c622067efd66dd4ee5eca740dcf263f41db20b2@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Even though this function is serialized to be always called from main
thread, v9fs_reclaim_fd() is dispatching the coroutine to a worker thread
in between via its v9fs_co_*() calls, hence leading to the situation where
v9fs_reclaim_fd() is effectively executed multiple times simultaniously,
which renders its LRU algorithm useless and causes high latency.

Fix this by adding a simple boolean variable to ensure this function is
only called once at a time. No synchronization needed for this boolean
variable as this function is only entered and returned on main thread.

Fixes: 7a46274529c ('hw/9pfs: Add file descriptor reclaim support')
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 10 ++++++++++
 hw/9pfs/9p.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 7cad2bce62..4f9c2dde9c 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -435,6 +435,12 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
     GHashTableIter iter;
     gpointer fid;
 
+    /* prevent multiple coroutines running this function simultaniously */
+    if (s->reclaiming) {
+        return;
+    }
+    s->reclaiming = true;
+
     g_hash_table_iter_init(&iter, s->fids);
 
     QSLIST_HEAD(, V9fsFidState) reclaim_list =
@@ -510,6 +516,8 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
          */
         put_fid(pdu, f);
     }
+
+    s->reclaiming = false;
 }
 
 /*
@@ -4324,6 +4332,8 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
     s->ctx.fst = &fse->fst;
     fsdev_throttle_init(s->ctx.fst);
 
+    s->reclaiming = false;
+
     rc = 0;
 out:
     if (rc) {
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 5e041e1f60..259ad32ed1 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -362,6 +362,7 @@ struct V9fsState {
     uint64_t qp_ndevices; /* Amount of entries in qpd_table. */
     uint16_t qp_affix_next;
     uint64_t qp_fullpath_next;
+    bool reclaiming;
 };
 
 /* 9p2000.L open flags */
-- 
2.39.5


