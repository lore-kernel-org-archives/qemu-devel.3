Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4522C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQ4Q-00071j-Af; Mon, 27 Jan 2025 09:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ44-0005ph-0d; Mon, 27 Jan 2025 09:26:17 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ3z-0003J8-Ep; Mon, 27 Jan 2025 09:26:09 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id 9A92DE0F82;
 Mon, 27 Jan 2025 17:25:41 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 98F9051D99; Mon, 27 Jan 2025 17:18:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yuan Liu <yuan1.liu@intel.com>,
 Jason Zeng <jason.zeng@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 26/41] multifd: bugfix for incorrect migration data
 with QPL compression
Date: Mon, 27 Jan 2025 17:17:40 +0300
Message-Id: <20250127141803.3514882-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Yuan Liu <yuan1.liu@intel.com>

When QPL compression is enabled on the migration channel and the same
dirty page changes from a normal page to a zero page in the iterative
memory copy, the dirty page will not be updated to a zero page again
on the target side, resulting in incorrect memory data on the source
and target sides.

The root cause is that the target side does not record the normal pages
to the receivedmap.

The solution is to add ramblock_recv_bitmap_set_offset in target side
to record the normal pages.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Jason Zeng <jason.zeng@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20241218091413.140396-3-yuan1.liu@intel.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit 2588a5f99b0c3493b4690e3ff01ed36f80e830cc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index bbe466617f..88e2344af2 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -679,6 +679,7 @@ static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
         qpl->zlen[i] = be32_to_cpu(qpl->zlen[i]);
         assert(qpl->zlen[i] <= multifd_ram_page_size());
         zbuf_len += qpl->zlen[i];
+        ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
     }
 
     /* read compressed pages */
-- 
2.39.5


