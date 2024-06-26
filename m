Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E44C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMREL-0006OC-KN; Wed, 26 Jun 2024 07:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMREJ-0006NH-Am; Wed, 26 Jun 2024 07:54:27 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMRE5-0007Hx-DY; Wed, 26 Jun 2024 07:54:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id C73EA60E31;
 Wed, 26 Jun 2024 14:54:11 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id prOe6Z0rMmI0-mrNAPsry; Wed, 26 Jun 2024 14:54:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719402851;
 bh=I+QF3fGvYELrEM7l+N59iHJKrQZhPHPzowmp1e2a5tw=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Az1t7s2xJXSNg2ThBBYNl5LD5KkoPWZoz2woraYmqbv6rHNWRIjzPLJN1J5R4wud2
 AofZ5WdXYGgkoNRpfIPRVvQ7rnSTPzsC409/UL523D5t8lCr+Gq/K/99XBzQ/kwXJc
 pMT+kaSqV5LrZxzTsc0sRM9IwP3ZopynXSqTQxzg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH v9 5/7] block: bdrv_get_xdbg_block_graph(): report export ids
Date: Wed, 26 Jun 2024 14:53:48 +0300
Message-Id: <20240626115350.405778-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626115350.405778-1-vsementsov@yandex-team.ru>
References: <20240626115350.405778-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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
index f6292f459a..601475e835 100644
--- a/block.c
+++ b/block.c
@@ -6326,7 +6326,11 @@ XDbgBlockGraph *bdrv_get_xdbg_block_graph(Error **errp)
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
index 57beae7982..8744a1171e 100644
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
index f2fe0f8078..16863d37cf 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -82,6 +82,7 @@ struct BlockExport {
 
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
 BlockExport *blk_exp_find(const char *id);
+BlockExport *blk_exp_find_by_blk(BlockBackend *blk);
 void blk_exp_ref(BlockExport *exp);
 void blk_exp_unref(BlockExport *exp);
 void blk_exp_request_shutdown(BlockExport *exp);
diff --git a/stubs/blk-exp-find-by-blk.c b/stubs/blk-exp-find-by-blk.c
new file mode 100644
index 0000000000..2fc1da953b
--- /dev/null
+++ b/stubs/blk-exp-find-by-blk.c
@@ -0,0 +1,9 @@
+#include "qemu/osdep.h"
+#include "sysemu/block-backend.h"
+#include "block/export.h"
+
+BlockExport *blk_exp_find_by_blk(BlockBackend *blk)
+{
+    return NULL;
+}
+
diff --git a/stubs/meson.build b/stubs/meson.build
index 068998c1a5..cbe30f94e8 100644
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
2.34.1


