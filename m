Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BE0CCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 06:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIhKp-000729-O5; Mon, 19 Oct 2026 02:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xIhKl-0006wB-GD; Mon, 19 Oct 2026 02:58:59 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xIhKi-0006lD-Hy; Mon, 19 Oct 2026 02:58:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.yp-c.yandex.net)
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 03A9080804;
 Mon, 19 Oct 2026 09:58:52 +0300 (MSK)
Received: from i115954770.yandex-team.ru
 by mail-nwsmtp-smtp-corp-main-68 with ESMTPSA id nwSS6342ba60-J69Jh7rT;
 Mon, 19 Oct 2026 09:58:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1792393131;
 bh=U+McxGX0whB/xNmAgaoCFyDpykoIgtkfN0wL4bdZxzg=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=0p5KGPu5wlTtXhRu6GslIB4LjPYJ23rbSgl8toQjsYogkyvvfnUgS5UQqGx4lc5IY
 k/4cUOcctu+iTKvvWdKzEj2XWMdButLP1fzMbD6KIZItXE5pXqjpwIOo06lUcZe4uQ
 JNdYSUQHdg+SIbtQq32AwEEY8MiUixjUkmS2ZbGA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Haoqian He <haoqian.he@smartx.com>
Subject: [PULL 2/2] block/mirror: inherit the source node discard flag in
 mirror_top
Date: Mon, 19 Oct 2026 09:58:28 +0300
Message-ID: <20261019065828.16335-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019065828.16335-1-vsementsov@yandex-team.ru>
References: <20261019065828.16335-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Haoqian He <haoqian.he@smartx.com>

mirror_start_job() inserts a mirror_top filter above the source node
for both mirror and active commit jobs. Previously, the filter was
opened with BDRV_O_RDWR only, even when the source had BDRV_O_UNMAP
enabled.

The block layer checks BDRV_O_UNMAP before invoking a node's discard
callback. Without this flag on mirror_top, discard requests return
success without reaching bdrv_mirror_top_pdiscard(). Consequently,
starting a job can silently suppress guest UNMAP/TRIM requests that
would otherwise reach the discard-enabled source.

Initialize the filter's open flags with BDRV_O_RDWR and conditionally
add BDRV_O_UNMAP from bs->open_flags. Pass the resulting flags to
bdrv_new_open_driver() so that mirror_top follows the source node's
discard setting.

This allows discard requests to reach the existing filter callback,
which forwards them to the source and either tracks the affected
range in the dirty bitmap or synchronously propagates the discard
to the target, depending on the copy mode.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
Message-ID: <20261013060549.3008438-1-haoqian.he@smartx.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/mirror.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 089856f4a84..a551d392c66 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1854,6 +1854,7 @@ static BlockJob *mirror_start_job(
     BlockDriverState *mirror_top_bs;
     bool target_is_backing;
     uint64_t target_perms, target_shared_perms;
+    int flags;
     int ret;
 
     GLOBAL_STATE_CODE();
@@ -1886,8 +1887,13 @@ static BlockJob *mirror_start_job(
     /* In the case of active commit, add dummy driver to provide consistent
      * reads on the top, while disabling it in the intermediate nodes, and make
      * the backing chain writable. */
-    mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top, filter_node_name,
-                                         BDRV_O_RDWR, errp);
+    flags = BDRV_O_RDWR;
+    if (bs->open_flags & BDRV_O_UNMAP) {
+        flags |= BDRV_O_UNMAP;
+    }
+    mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top,
+                                         filter_node_name,
+                                         flags, errp);
     if (mirror_top_bs == NULL) {
         return NULL;
     }
-- 
2.43.0


