Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB35C88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n0o-0003iD-HC; Wed, 16 Sep 2026 06:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n0d-0003Up-G2; Wed, 16 Sep 2026 06:36:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n0b-0001gy-QW; Wed, 16 Sep 2026 06:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789554955; bh=inRrAmY1iduQgFn52/DZ7mmh8xDPO5suzTu9cKN5rdA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ivLeu+BsVbFThMDluzTUdWSS/NV8ZIFgwM/pjGWIVfYmsW2sOXF+zrpuMtKZyq8Vf
 VNirVxEe/16cj6/BUKwpV2oavWQvThga/dIraODchept+SPwXm0Wg+o0Jd99oxdxNQ
 zo9onlRJSB9Y+nYNQ+gAWy4dAsjcDAraiT65VLI0iz6U9X5wpXBk17WAsYsq8uCGTN
 su76kd2+BsPM3PlXqG8Oev4gWgM5V/15TECgZQPqVMRPfKk7+SWTXsy4QSD9NfzJR7
 KvXMUN3/18UrpHom/huDK6k8ne5OqLv06xJCO25uyMW+pfv9widk1e4Gy21PETlXEu
 Ae3j7j/eF00mA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D30661D57FF;
 Wed, 16 Sep 2026 13:35:55 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9D9BC429F5E;
 Wed, 16 Sep 2026 13:36:38 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7BB585A7F9; Wed, 16 Sep 2026 13:36:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 12/56] dirty-bitmap: fix integer overflow in
 serialization coverage
Date: Wed, 16 Sep 2026 13:35:30 +0300
Message-ID: <20260916103622.684817-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
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

From: "Denis V. Lunev" <den@openvz.org>

The chunk size is an int and is shifted left by 3 before the result is
widened, so a chunk size of 1 << 28 or above overflows.

parallels passes s->cluster_size, which parallels_open() lets reach
2 GiB. With a bitmap needing two L1 entries the bogus limit makes the
"bm_size - offset" in parallels_load_bitmap_data() underflow; both
wrong values slip past the assertions in serialization_chunk() and the
resulting index lands outside the hbitmap, so a 128 KiB image memsets
unrelated memory through hbitmap_deserialize_ones().

Widen the shift. qcow2, the only other caller, never exceeds a 2 MiB
cluster.

Fixes: 35f428ba3971 ("qcow2-bitmap: make bytes_covered_by_bitmap_cluster() public")
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Message-ID: <20260811173857.396571-4-den@openvz.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
(cherry picked from commit dc04053687ec7219a78f9b90fe2f71c9336914e1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 13a1979755d..9fda3a4b983 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -612,7 +612,7 @@ uint64_t bdrv_dirty_bitmap_serialization_coverage(int serialized_chunk_size,
                                                   const BdrvDirtyBitmap *bitmap)
 {
     uint64_t granularity = bdrv_dirty_bitmap_granularity(bitmap);
-    uint64_t limit = granularity * (serialized_chunk_size << 3);
+    uint64_t limit = granularity * ((uint64_t)serialized_chunk_size << 3);
 
     assert(QEMU_IS_ALIGNED(limit,
                            bdrv_dirty_bitmap_serialization_align(bitmap)));
-- 
2.47.3


