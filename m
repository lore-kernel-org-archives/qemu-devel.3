Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA9ECF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdQO-0003Pt-3b; Fri, 21 Nov 2025 21:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdQJ-0003M2-Pl; Fri, 21 Nov 2025 21:32:27 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdPQ-0008Ie-I0; Fri, 21 Nov 2025 21:32:23 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5784216C70C;
 Fri, 21 Nov 2025 16:51:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AED343219A9;
 Fri, 21 Nov 2025 16:52:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 52/76] hw/net/e1000e_core: Adjust
 e1000e_write_payload_frag_to_rx_buffers() assert
Date: Fri, 21 Nov 2025 16:51:30 +0300
Message-ID: <20251121135201.1114964-52-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

An assertion in e1000e_write_payload_frag_to_rx_buffers() attempts to
guard against the calling code accidentally trying to write too much
data to a single RX descriptor, such that the E1000EBAState::cur_idx
indexes off the end of the EB1000BAState::written[] array.

Unfortunately it is overzealous: it asserts that cur_idx is in
range after it has been incremented. This will fire incorrectly
for the case where the guest configures four buffers and exactly
enough bytes are written to fill all four of them.

The only places where we use cur_idx and index in to the written[]
array are the functions e1000e_write_hdr_frag_to_rx_buffers() and
e1000e_write_payload_frag_to_rx_buffers(), so we can rewrite this to
assert before doing the array dereference, rather than asserting
after updating cur_idx.

Cc: qemu-stable@nongnu.org
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit bab496a18358643b686f69e2b97d73fb98d37e79)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 58a34125e9..a2df627119 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1392,10 +1392,13 @@ e1000e_write_payload_frag_to_rx_buffers(E1000ECore *core,
                                         dma_addr_t data_len)
 {
     while (data_len > 0) {
-        uint32_t cur_buf_len = core->rxbuf_sizes[bastate->cur_idx];
-        uint32_t cur_buf_bytes_left = cur_buf_len -
-                                      bastate->written[bastate->cur_idx];
-        uint32_t bytes_to_write = MIN(data_len, cur_buf_bytes_left);
+        uint32_t cur_buf_len, cur_buf_bytes_left, bytes_to_write;
+
+        assert(bastate->cur_idx < MAX_PS_BUFFERS);
+
+        cur_buf_len = core->rxbuf_sizes[bastate->cur_idx];
+        cur_buf_bytes_left = cur_buf_len - bastate->written[bastate->cur_idx];
+        bytes_to_write = MIN(data_len, cur_buf_bytes_left);
 
         trace_e1000e_rx_desc_buff_write(bastate->cur_idx,
                                         ba[bastate->cur_idx],
@@ -1414,8 +1417,6 @@ e1000e_write_payload_frag_to_rx_buffers(E1000ECore *core,
         if (bastate->written[bastate->cur_idx] == cur_buf_len) {
             bastate->cur_idx++;
         }
-
-        assert(bastate->cur_idx < MAX_PS_BUFFERS);
     }
 }
 
-- 
2.47.3


