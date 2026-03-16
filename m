Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C170BEFCBBB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w226W-00080c-Rl; Mon, 16 Mar 2026 03:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w225k-0007VL-I3; Mon, 16 Mar 2026 03:10:25 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w225d-0007kf-Tp; Mon, 16 Mar 2026 03:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773645002; bh=yS6wJVRyK2NZzmnCyDXLV5GJr4GKcXKiMWKEFsAE4xo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IIG0MwG5Ld9LXWYQB4q+4UVxcU1f0N4lKjmPlfoYP6hANS04Qc77LwXA5A/obFsOr
 BCfyBp/HaR42qG/2sQSYym0gNUHw/yHMefLqUuAHN+qBZDLMJl7wL/wgxljig/rEgk
 TvwMTV59WZItjtWCrSYO8tHqmQC83NZRMBK54VgjSGG8xh7ht+ap22V0bMseF4eDkw
 bVBD5RkPPzKaXlx8VQX6a0Z2zRDMm+0Uw7yNkxgft/fu8NWH8rVrSxLhhj77E2GkIR
 i54Wwo3/wBQMovEDh7j9V67A0VpfiD4O26ECahG6qOs4ChuBP56FYB1KehBTVNohhr
 My4NTHhizUiqg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9A015193C25;
 Mon, 16 Mar 2026 10:10:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 97E6138004D;
 Mon, 16 Mar 2026 10:10:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Sergei Heifetz <heifetz@yandex-team.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 03/14] dump/dump.c: reorder usage and assertion of block
Date: Mon, 16 Mar 2026 10:09:51 +0300
Message-ID: <20260316071005.91624-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316071005.91624-1-mjt@tls.msk.ru>
References: <20260316071005.91624-1-mjt@tls.msk.ru>
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

From: Sergei Heifetz <heifetz@yandex-team.com>

Reorder the code so the assertion of block occurs before it is
used in the subsequent lines.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 dump/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dump/dump.c b/dump/dump.c
index f7a99a7af2..80ed6c8d21 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1288,6 +1288,7 @@ static bool get_next_page(GuestPhysBlock **blockptr, uint64_t *pfnptr,
     /* block == NULL means the start of the iteration */
     if (!block) {
         block = QTAILQ_FIRST(&s->guest_phys_blocks.head);
+        assert(block);
         *blockptr = block;
         addr = block->target_start;
         *pfnptr = dump_paddr_to_pfn(s, addr);
@@ -1295,7 +1296,6 @@ static bool get_next_page(GuestPhysBlock **blockptr, uint64_t *pfnptr,
         *pfnptr += 1;
         addr = dump_pfn_to_paddr(s, *pfnptr);
     }
-    assert(block != NULL);
 
     while (1) {
         if (addr >= block->target_start && addr < block->target_end) {
-- 
2.47.3


