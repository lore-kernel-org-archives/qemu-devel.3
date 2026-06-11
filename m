Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787E0CD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXZz1-000111-Dc; Thu, 11 Jun 2026 03:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1wXZyz-00010p-U9; Thu, 11 Jun 2026 03:37:45 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1wXZyx-0005EV-LM; Thu, 11 Jun 2026 03:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781163463; x=1812699463;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rH4SlcMD71TLsO6F5PN5kqXSIvG/FRwas2PWlcLcWhY=;
 b=VbYjUDsK0a/p+Lx5Zk98gB1DLWqHVZhEloPXPx/lTtjQ5GLacHhOgraU
 keRonMpiIWszUbxSSS3ZXEP/ZXaMg1zzQvwPXp8nQdX4wzM8C6IB0guoL
 WeqQupJc9th+r7KXvBjrDVpmVga5Ad5lCxgY2GXc1FG9Fwfq/UI6e+SgR
 PQgE/jo7ObmN3F2RnhjX6adS4PGqnB4OxN6SRXWTbrLHshM1O26IIWcl8
 8wiRyFepVr+c1fBbQzvF8onk2JWcYMMo+fqqzqb1CiTbyCjx5cBJBCWlJ
 VO0hpPk46+ujtAklUmX6P6gap0EIZWr8byKfDI/lJORGKTW+LspYGoqsp A==;
X-CSE-ConnectionGUID: Z48H/nP0R2igvFFZd2l15g==
X-CSE-MsgGUID: MaTo60cTTxCqLI3eQZ/4Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="84541466"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="84541466"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 00:37:37 -0700
X-CSE-ConnectionGUID: S2g2eDtbRfWqsA0YE86LEw==
X-CSE-MsgGUID: 14RT03ahQJW7hyrzGTC32w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="251330285"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 00:37:35 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Farrah Chen <farrah.chen@intel.com>
Subject: [PATCH] qcow2: bounce merged partial-cluster COW writes for O_DIRECT
Date: Thu, 11 Jun 2026 15:37:22 +0800
Message-ID: <20260611073724.46443-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

perform_cow() can satisfy a partial-cluster COW write by merging the
preserved head, the guest payload, and the preserved tail into a single
write request. Today that merged write is submitted as a multi-segment
qiov.

With a raw data file opened with O_DIRECT, that request can violate host
DMA alignment restrictions on some setups. The COW head and tail
buffers are blocked aligned, but the guest payload may still be provided
as a separately spliced iovec with an internal offset. On affected
hosts, the resulting direct write fails which can break some
partial-cluster COW workloads.

Fix this by assembling merged partial-cluster COW writes into one aligned
temporary buffer before submitting them to an O_DIRECT data file. Keep
the existing scatter-gather path for buffered I/O.

Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3521
Reported-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>

---

Hi block/qcow2 folks,

This patch is intened to fix a reported qcow2 COW issue seen when
launching a VM from a refreshed overlay image.

I am not very familiar with this qcow2 path, so I would appreciate
feedback on both the root-cause analysis and the proposed fix. I used AI
as a debugging aid while looking into the issue, and since AI-related
project policy is still being discussed in QEMU, I am posting this patch
mainly to get feedback from people who know this code better.

I tested this change against the reported case and it does resolve the
problem for me, but I am not yet confident that this is the right fix
for upstream.
---
 block/qcow2-cluster.c | 50 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8b1e80bd0b..7129b41d68 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -893,7 +893,7 @@ perform_cow(BlockDriverState *bs, QCowL2Meta *m)
     unsigned buffer_size;
     unsigned data_bytes = end->offset - (start->offset + start->nb_bytes);
     bool merge_reads;
-    uint8_t *start_buffer, *end_buffer;
+    uint8_t *start_buffer, *end_buffer, *write_buffer = NULL;
     QEMUIOVector qiov;
     int ret;
 
@@ -982,12 +982,45 @@ perform_cow(BlockDriverState *bs, QCowL2Meta *m)
      * can write everything in one single operation */
     if (m->data_qiov) {
         qemu_iovec_reset(&qiov);
-        if (start->nb_bytes) {
-            qemu_iovec_add(&qiov, start_buffer, start->nb_bytes);
-        }
-        qemu_iovec_concat(&qiov, m->data_qiov, m->data_qiov_offset, data_bytes);
-        if (end->nb_bytes) {
-            qemu_iovec_add(&qiov, end_buffer, end->nb_bytes);
+        /*
+         * Direct I/O through the raw file backend can still hit host DMA
+         * alignment restrictions when we splice guest buffers between the
+         * COW head/tail regions. For those writes, assemble a single aligned
+         * buffer before submitting the COW write.
+         */
+        if (s->data_file->bs->open_flags & BDRV_O_NOCACHE) {
+            uint64_t write_size = start->nb_bytes + data_bytes + end->nb_bytes;
+
+            if (merge_reads) {
+                write_buffer = start_buffer;
+            } else {
+                write_buffer = qemu_try_blockalign(bs, write_size);
+                if (write_buffer == NULL) {
+                    ret = -ENOMEM;
+                    goto fail;
+                }
+
+                if (start->nb_bytes) {
+                    memcpy(write_buffer, start_buffer, start->nb_bytes);
+                }
+                if (end->nb_bytes) {
+                    memcpy(write_buffer + start->nb_bytes + data_bytes,
+                           end_buffer, end->nb_bytes);
+                }
+            }
+
+            qemu_iovec_to_buf(m->data_qiov, m->data_qiov_offset,
+                              write_buffer + start->nb_bytes, data_bytes);
+            qemu_iovec_add(&qiov, write_buffer, write_size);
+        } else {
+            if (start->nb_bytes) {
+                qemu_iovec_add(&qiov, start_buffer, start->nb_bytes);
+            }
+            qemu_iovec_concat(&qiov, m->data_qiov, m->data_qiov_offset,
+                              data_bytes);
+            if (end->nb_bytes) {
+                qemu_iovec_add(&qiov, end_buffer, end->nb_bytes);
+            }
         }
         /* NOTE: we have a write_aio blkdebug event here followed by
          * a cow_write one in do_perform_cow_write(), but there's only
@@ -1020,6 +1053,9 @@ fail:
         qcow2_cache_depends_on_flush(s->l2_table_cache);
     }
 
+    if (write_buffer != start_buffer) {
+        qemu_vfree(write_buffer);
+    }
     qemu_vfree(start_buffer);
     qemu_iovec_destroy(&qiov);
     return ret;
-- 
2.43.5


