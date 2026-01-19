Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DE7D29C36
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqa9-0008PC-Cs; Mon, 19 Jan 2026 09:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhqZm-0008Aq-6h; Mon, 19 Jan 2026 09:49:56 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhqZi-0008Na-Ej; Mon, 19 Jan 2026 09:49:53 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5a81:0:640:624e:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 583188075C;
 Mon, 19 Jan 2026 17:49:48 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gnaGbV0CCKo0-jRPRKwp5; Mon, 19 Jan 2026 17:49:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768834187;
 bh=tWlEr4VB+A84CJ6NriO4igIgJBFZIudrt/R/OVGsGNI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Rr1K0dD/8mvhE+kVZZtrdzx7bLaB6hKNRwQJRfUVsNOeMU7AhNr5OF2pDTvQetQ3Y
 e+i3QFbRRjBILCnda5HXJ5fpQFGW7jMKYNmSj0kiCb/GSYnfJy3qAgfVEgWK49QpVB
 P8Tb+ohavvPpJ5WoE6VqyGUsg6hJ8nDOtkBtcFgs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH v10 5/8] block: bdrv_get_xdbg_block_graph(): report export ids
Date: Mon, 19 Jan 2026 17:49:38 +0300
Message-ID: <20260119144941.87936-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119144941.87936-1-vsementsov@yandex-team.ru>
References: <20260119144941.87936-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Currently for block exports we report empty blk names. That's not good.
Let's try to find corresponding block export and report its id.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block.c                     |  4 ++++
 block/export/export.c       | 13 +++++++++++++
 include/block/export.h      |  1 +
 stubs/blk-exp-find-by-blk.c |  9 +++++++++
 stubs/meson.build           |  1 +
 5 files changed, 28 insertions(+)
 create mode 100644 stubs/blk-exp-find-by-blk.c

diff --git a/block.c b/block.c
index b13d06f709..8254d57212 100644
--- a/block.c
+++ b/block.c
@@ -6354,7 +6354,11 @@ XDbgBlockGraph *bdrv_get_xdbg_block_graph(Error **errp)
     for (blk = blk_all_next(NULL); blk; blk = blk_all_next(blk)) {
         char *allocated_name = NULL;
         const char *name = blk_name(blk);
+        BlockExport *exp = blk_exp_find_by_blk(blk);
 
+        if (!*name && exp) {
+            name = exp->id;
+        }
         if (!*name) {
             name = allocated_name = blk_get_attached_dev_id(blk);
         }
diff --git a/block/export/export.c b/block/export/export.c
index d11beb900f..9169b43e13 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -60,6 +60,19 @@ BlockExport *blk_exp_find(const char *id)
     return NULL;
 }
 
+BlockExport *blk_exp_find_by_blk(BlockBackend *blk)
+{
+    BlockExport *exp;
+
+    QLIST_FOREACH(exp, &block_exports, next) {
+        if (exp->blk == blk) {
+            return exp;
+        }
+    }
+
+    return NULL;
+}
+
 static const BlockExportDriver *blk_exp_find_driver(BlockExportType type)
 {
     int i;
diff --git a/include/block/export.h b/include/block/export.h
index 4bd9531d4d..2d3a0b4a28 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -85,6 +85,7 @@ struct BlockExport {
 
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
 BlockExport *blk_exp_find(const char *id);
+BlockExport *blk_exp_find_by_blk(BlockBackend *blk);
 void blk_exp_ref(BlockExport *exp);
 void blk_exp_unref(BlockExport *exp);
 void blk_exp_request_shutdown(BlockExport *exp);
diff --git a/stubs/blk-exp-find-by-blk.c b/stubs/blk-exp-find-by-blk.c
new file mode 100644
index 0000000000..20f7ff1bdd
--- /dev/null
+++ b/stubs/blk-exp-find-by-blk.c
@@ -0,0 +1,9 @@
+#include "qemu/osdep.h"
+#include "system/block-backend.h"
+#include "block/export.h"
+
+BlockExport *blk_exp_find_by_blk(BlockBackend *blk)
+{
+    return NULL;
+}
+
diff --git a/stubs/meson.build b/stubs/meson.build
index 93a52d273e..d530a637d9 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -16,6 +16,7 @@ if have_block
   stub_ss.add(files('blk-commit-all.c'))
   stub_ss.add(files('blk-exp-close-all.c'))
   stub_ss.add(files('blk-by-qdev-id.c'))
+  stub_ss.add(files('blk-exp-find-by-blk.c'))
   stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
   stub_ss.add(files('change-state-handler.c'))
   stub_ss.add(files('get-vm-name.c'))
-- 
2.52.0


