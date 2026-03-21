Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34EE1094486
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 15:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3yXx-000387-Qq; Sat, 21 Mar 2026 11:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w3yXv-00036d-6H; Sat, 21 Mar 2026 11:47:27 -0400
Received: from m16.mail.163.com ([220.197.31.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1w3yXq-0003JR-T5; Sat, 21 Mar 2026 11:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=z5
 ePYzr5dc8VqIY13zZ5UM75pHZbjpDXm6VJI6eKyJw=; b=Edv2XNgJgDm3hagTOe
 3m7SIuSWyF8eG70buPIbVK2NErD7+0kH89oLAXMVAOKeNI8sjJOIBMS0bR/Z03ei
 9sUiXfHTm4ETho7UeaB2Qx2XujSf497OAzcAlB5pPCF1DkZhhtknGicPsl7TFjNH
 J21QP0KsIHHpIGXHY08XjJUt0=
Received: from dt-VM.localdomain (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgAH9XF2vb5p1YbwTQ--.2111S4;
 Sat, 21 Mar 2026 23:47:05 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Tao Ding <dingtao0430@163.com>
Subject: [PATCH v1 2/5] PL011 generate receive timeout interrupt
Date: Sat, 21 Mar 2026 23:46:57 +0800
Message-ID: <3411a43d161ef59db3db1d7ed0f84839d50ceb33.1774099044.git.dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1774099044.git.dingtao0430@163.com>
References: <cover.1774099044.git.dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgAH9XF2vb5p1YbwTQ--.2111S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWrWr1ktw4fAw48KFyUWrg_yoW8GFy5pr
 ZY9Fy5Gwn7Kr18Zr4ayw4kXF13Zr1vvayjkry8A34UZas8Gw1rXr9rAayag3y2kFWft3yj
 vFnIqr1UZF929aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uga9hUUUUU=
X-Originating-IP: [101.204.36.117]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4hmX1Wm+vXnWTgAA3y
Received-SPF: pass client-ip=220.197.31.2; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

After changing the read_trigger, no interrupt will be generated when the data 
in the rx FIFO of pl011 does not reach the FIFO level. This will cause input 
in the console to have no effect in Linux, until data input exceeds the FIFO level.

But UART will generate an interrupt after a timeout period after RX receives the data. 
The relevant description of this in TRM : 
    *The receive timeout interrupt is asserted when the receive FIFO is not empty, and no 
    more data is received during a 32-bit period.

To simplify this operation, pl011 immediately generates an RT interrupt upon receiving data, 
which means the period is triggered instantly. (QEMUTimer triggering is also optional)

Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/char/pl011.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index c96a706da1..58803f0fc2 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -200,6 +200,9 @@ static void pl011_fifo_rx_put(void *opaque, uint32_t value)
     }
     if (s->read_count == s->read_trigger) {
         s->int_level |= INT_RX;
+    }
+    if (s->read_count) {
+        s->int_level |= INT_RT;
         pl011_update(s);
     }
 }
@@ -281,6 +284,7 @@ static uint32_t pl011_read_rxdata(PL011State *s)
     }
     if (s->read_count == 0) {
         s->flags |= PL011_FLAG_RXFE;
+        s->int_level &= ~INT_RT;
     }
     if (s->read_count == s->read_trigger - 1) {
         s->int_level &= ~INT_RX;
-- 
2.43.0


