Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FFBC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuARt-0004EH-Tc; Wed, 12 Aug 2026 11:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuARa-0003va-Jp; Wed, 12 Aug 2026 11:00:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuARX-00022V-7F; Wed, 12 Aug 2026 11:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=QJ6gM7foV5Cj1HPVRC8k43X9LggidRyei93AfDsNoiA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=G1x7ngl9d8lyKa5BPi6P4H6crDaoqwgH1l/t/qd2si7K0fK3znS5+VCesQMzOMIGD
 5kVUdM7SCGZs3UaNzfWO/7CI6KNOVGqMDcI4IlO9YKPRe71PhbqSembzCtZs0TXhH/
 q/8eQE0S3uR6AbLDxOYFytZYdcUwYDfN+aM/GHWwPLrnSMeQ98Cj9Tsy6UqzmWBrWl
 8OGS4eD2NibX5av0PQkb65HnBuV19RBwm/h8tRzs145l40yVf6VUdVN5yAOfioWkjK
 pROemeT6S3eTBa9GDQeSHw4c12rK/BsklA5N8GVZptRVx9ywzC/hr/sQNgaxvsfAzQ
 QMko0qE2RqaKg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8154B1CA666;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DC2A8409DA8;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 47C072FA27; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 boy juju <agx1657748706@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 098/120] dmg: reject inconsistent UDRW chunk sector
 count and length (CVE-2026-65928)
Date: Wed, 12 Aug 2026 17:49:21 +0300
Message-ID: <20260812144955.649205-98-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The chunk metadata contains both:
- Sector count: number of 512-byte sectors in the virtual disk
- Length: number of bytes in the image file

The UDRW chunk type indicates uncompressed data that can be accessed
directly. The code is missing input validation to verify that sector
count is consistent with length.

If sector count is larger than length, then read requests can access
beyond the end of the s->uncompressed_chunk buffer. This is an
out-of-bounds heap access that could lead to a crash or an information
leak.

While we're at it, also zero the end of the last sector when length is
unaligned. This prevents information leaks from the
s->uncompressed_chunk buffer.

Fixes: CVE-2026-65928
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3846
Reported-by: boy juju <agx1657748706@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20260723144519.364701-4-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 370882d0869567e5f21b95229a763171e319d0db)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/dmg.c b/block/dmg.c
index 6f8120e0338..5d7d3b8901f 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -312,6 +312,21 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
             goto fail;
         }
 
+        /*
+         * Uncompressed chunk length must match sector count. Compressed chunks
+         * are validated during dmg_read_chunk() since the uncompressed size is
+         * not known ahead of time.
+         */
+        if (s->types[i] == UDRW) {
+            if (s->sectorcounts[i] != DIV_ROUND_UP(s->lengths[i], 512)) {
+                error_report("length %" PRIu64 " for chunk %" PRIu32
+                             " is inconsistent with sector count %" PRIu64,
+                             s->lengths[i], i, s->sectorcounts[i]);
+                ret = -EINVAL;
+                goto fail;
+            }
+        }
+
         update_max_chunk_size(s, i, &ds->max_compressed_size,
                               &ds->max_sectors_per_chunk);
         offset += 40;
@@ -722,6 +737,16 @@ dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
             if (ret < 0) {
                 return -1;
             }
+
+            /*
+             * Zero the unread part of the last sector when chunk length is
+             * unaligned to avoid exposing uninitialized memory. Valid image
+             * files may never hit this case, but cover it to be safe.
+             */
+            if (s->lengths[chunk] & 511) {
+                size_t trailing_bytes = 512 - (s->lengths[chunk] & 511);
+                memset(s->uncompressed_chunk + s->lengths[chunk], 0, trailing_bytes);
+            }
             break;
         case UDZE: /* zeros */
         case UDIG: /* ignore */
-- 
2.47.3


