Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C9DC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilcx-0002ic-Uf; Sun, 12 Jul 2026 00:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcu-0002cH-KI; Sun, 12 Jul 2026 00:17:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcs-0006JF-RR; Sun, 12 Jul 2026 00:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829780; bh=iVhpOrfW5mJni5ZsXD7/88eECXnpM4z0jEKgB0xAty4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tT1oIJSM9Mi+tPWOd9ZGvEQqmXsSGNzMdlF5p2QkRyhcoFtZ3H8/LQGij2mGYySzM
 +38BTbGbxGUaZtELlXNjmWQbApG4jgGPXogCJeiUgBsf2xKVbbsagPg84Xti9gKhnb
 1YP/aMkWdeSPUFxGNOmt5z+AATGgSXCOVprvM4NRWXB7hN2p5eWcctaHvShCYxK4ES
 HrsSi/RFEjSTgHp1R8rRcZcrjf5jVGejI9cE+/48CsYJY4ld9dQ9X/M74/6wtX7JkT
 FKbHSSPQp/8t6k2RoL4BmhSXAuA7C/LcsGitINzjJK8FIIobhMMB6zpehiQ1RLvBFF
 bATORxlaDxzBA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E19BA1C0BE7;
 Sun, 12 Jul 2026 07:16:20 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2140F3EB947;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 31006133D1; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Feifan Qian <bea1e@proton.me>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 12/75] hw/9pfs: cap Treaddir allocation
 (CVE-2026-9238)
Date: Sun, 12 Jul 2026 07:14:30 +0300
Message-ID: <20260712041539.108341-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

Constrain max_count in v9fs_readdir() to transport's current, real
response buffer size before calling v9fs_do_readdir() to prevent
excessive host memory allocation for specific, crafted, huge
directories (large amount of entries) by bad clients.

Client may send a Treaddir request with a large 'count' parameter, and
while the negotiated 'msize' provides some limit, it accounts for guest
being somewhat faithful on the negotiated 'msize' value throughout the
session.

A bad guest client could have negotiated a large 'msize' but provide a
small reply buffer for Treaddir request, causing QEMU to allocate host
memory proportional to 'msize' before discovering the reply cannot fit.

Possible consequence was a potential DoS by a priviliged guest, causing
a disconnection of guest communication due to transport device being
marked as "broken", however QEMU process would have continued to run with
potentially giant host memory allocation, which might have negative
impact on other services running on host.

Fixes: CVE-2026-9238
Fixes: 2149675b195f ("9pfs: add new function v9fs_co_readdir_many()")
Reported-by: Feifan Qian <bea1e@proton.me>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/qemu-devel/f81a387a2de4f2172fd5830c5654f49d78102254.1781287774.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 64c6c7e0df726055fac9ed12b30f712b115193f3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index f0bc1d71706..a4f9544e13b 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2647,6 +2647,7 @@ static void coroutine_fn v9fs_readdir(void *opaque)
     uint32_t max_count;
     V9fsPDU *pdu = opaque;
     V9fsState *s = pdu->s;
+    size_t max_resp_sz;
 
     retval = pdu_unmarshal(pdu, offset, "dqd", &fid,
                            &initial_offset, &max_count);
@@ -2655,9 +2656,28 @@ static void coroutine_fn v9fs_readdir(void *opaque)
     }
     trace_v9fs_readdir(pdu->tag, pdu->id, fid, initial_offset, max_count);
 
+    max_resp_sz = s->msize;
+
+    /*
+     * Constrain max_count to transport's current, actual response buffer size.
+     * A bad client might provide a response buffer < msize.
+     */
+    if (s->transport->response_buffer_size) {
+        size_t buf_size = s->transport->response_buffer_size(pdu);
+        if (max_resp_sz > buf_size) {
+            max_resp_sz = buf_size;
+        }
+    }
+
     /* Enough space for a R_readdir header: size[4] Rreaddir tag[2] count[4] */
-    if (max_count > s->msize - 11) {
-        max_count = s->msize - 11;
+    if (max_resp_sz > 11) {
+        max_resp_sz -= 11;
+    } else {
+        max_resp_sz = 0;
+    }
+
+    if (max_count > max_resp_sz) {
+        max_count = max_resp_sz;
         warn_report_once(
             "9p: bad client: T_readdir with count > msize - 11"
         );
-- 
2.47.3


