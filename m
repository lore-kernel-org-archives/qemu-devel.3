Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD735C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuARh-0003vi-Rv; Wed, 12 Aug 2026 11:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuARW-0003im-Bw; Wed, 12 Aug 2026 11:00:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuART-000212-O4; Wed, 12 Aug 2026 11:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=pYg2VLJB2V50nspPn46eJTsaINJq3aho5SX24qW5Els=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lRPI9BvMWrm7bUWKR/t/nKmL7JOQ0IBGUwBIz2TPL8og9+InRdMCNMiAyR+UiGr6D
 loQ/bRRtEg0WZHRWum1df+xBBkzZ89uvQZ+n9YSMdQrkvDSm8zCt8scQ5gsPglgYRC
 8y7ZQ7FWttv1l1xYIvP5GQJh2Ucw6lHoOICpMeDNlp3h9yIQ3udRVH4/BQxQGJ9eOz
 5lS8zwOMnO+l4604v23gPNDj9RQAOzMcZl2JZnxL+AdzC5IuJUbs24P/55bPUgQ53C
 ym8dTBhfFBfiYPWL3Vm7zcHUEUyWqLwZgKgIk9xkPAfbeG9C6YzMNHq8JeMACEGN1w
 4ZjioeJXT/rUg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 754521CA664;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CEA10409DA6;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 39ED12FA23; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 boy juju <agx1657748706@gmail.com>,
 Tristan Madani <tristan@talencesecurity.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 096/120] dmg: fix out-of-bounds load in search_chunk()
 (CVE-2026-65929)
Date: Wed, 12 Aug 2026 17:49:19 +0300
Message-ID: <20260812144955.649205-96-mjt@tls.msk.ru>
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

The binary search in search_chunk() uses s->n_chunks as the (inclusive)
upper bound. Chunk indices are in the right-open interval [0,
s->n_chunks) so it is wrong to search all the way up to s->n_chunks
rather than s->n_chunks - 1.

The worst case security scenario I can see is convincing a victim to
hotplug a malicious DMG file to a running guest, potentially causing
QEMU to crash when loading from memory beyond the end of s->sectors[] or
s->sectorscounts[]. This could be a denial of service.

Fixes: CVE-2026-65929
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3844
Reported-by: boy juju <agx1657748706@gmail.com>
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20260723144519.364701-2-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 0c43f801c0d7a31ef05bc22914cca0b0e28210a8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/dmg.c b/block/dmg.c
index 33dcb3a3498..e325127d144 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -609,7 +609,10 @@ static inline int is_sector_in_chunk(BDRVDMGState *s,
 static inline uint32_t search_chunk(BDRVDMGState *s, uint64_t sector_num)
 {
     /* binary search */
-    uint32_t chunk1 = 0, chunk2 = s->n_chunks, chunk3;
+    uint32_t chunk1 = 0, chunk2 = s->n_chunks - 1, chunk3;
+    if (s->n_chunks == 0) {
+        goto err; /* should never happen */
+    }
     while (chunk1 <= chunk2) {
         chunk3 = (chunk1 + chunk2) / 2;
         if (s->sectors[chunk3] > sector_num) {
-- 
2.47.3


