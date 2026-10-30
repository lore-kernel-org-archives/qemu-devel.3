Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61898606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=x6z.top header.i=@x6z.top header.a=rsa-sha256 header.s=lark2301040359 header.b=rsfgDkG+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnwb-0000c4-DP; Fri, 30 Oct 2026 10:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMns1-0006kv-VI
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:21 -0400
Received: from va-2-54.ptr.blmpb.com ([209.127.231.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMns0-0005Vz-Ih
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2301040359; d=x6z.top; t=1793371572; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=D23GlLY7JSR0ZpPEaJMTTq6tnz6O40yOVeSVXGcPhPY=;
 b=rsfgDkG+lZ6Alhhama2EDsC0gDAQrV2JfYkTJMqlVr70oNbqwoK/u4NTfG9fIos6WfmPrY
 Su7xsNf8P59I2Qw2RvehTlRXH8888J0IUwx3TeFSsOTxYDQ6hV1JKTw3kvJ0ktDv/lJtj+
 xAJ9GH2RwM1X8PgzP3pMm6/6aSLyqTnwxozfKZYjaGDQeUJr9yR7jmmj+x8h03lVQTrjFy
 8dhF90vcpwGym9Xn5pOwLtFcNWT8NysivVLyF7qFxGmUkxTzkEpO24wokkuSjJLuPYZHJQ
 tdHnu942NYW8wvXxIsysajJE98TogGEWAakCClGSIq6EMZrE8kCGgCIfKAoCWA==
In-Reply-To: <cover.1793370600.git.lbyxiaolizi@x6z.top>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 7bit
Received: from localhost.localdomain ([120.236.174.193]) by smtp.larksuite.com
 with ESMTPS; Fri, 30 Oct 2026 14:46:11 +0000
Content-Type: text/plain; charset=UTF-8
Cc: "lbyxiaolizi" <lbyxiaolizi@x6z.top>, 
 "Alistair Francis" <Alistair.Francis@wdc.com>, 
 "Palmer Dabbelt" <palmer@dabbelt.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Paolo Bonzini" <pbonzini@redhat.com>, <qemu-riscv@nongnu.org>
Date: Fri, 30 Oct 2026 22:45:45 +0800
Subject: [PATCH 7/9] hw/char/sifive_uart: check rx_fifo_len in post_load
Message-Id: <12acf2bec77af7b739817464ebc48f5a45d03fcd.1793370600.git.lbyxiaolizi@x6z.top>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Original-From: lbyxiaolizi <lbyxiaolizi@x6z.top>
To: <qemu-devel@nongnu.org>
From: "lbyxiaolizi" <lbyxiaolizi@x6z.top>
X-Lms-Return-Path: <lba+26ae4adb3+16929f+nongnu.org+lbyxiaolizi@x6z.top>
References: <cover.1793370600.git.lbyxiaolizi@x6z.top>
Received-SPF: pass client-ip=209.127.231.54; envelope-from=lbyxiaolizi@x6z.top;
 helo=va-2-54.ptr.blmpb.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Oct 2026 10:50:54 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_SUSPICIOUS_NTLD,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SiFiveUARTState.rx_fifo has SIFIVE_UART_RX_FIFO_SIZE (8) bytes, and
sifive_uart_read() passes s->rx_fifo_len - 1 to memmove() when reading
SIFIVE_UART_RXFIFO.

vmstate_sifive_uart loads rx_fifo_len as a raw uint8_t without bounds
checking. Reject rx_fifo_len > SIFIVE_UART_RX_FIFO_SIZE in post_load.

Signed-off-by: lbyxiaolizi <lbyxiaolizi@x6z.top>
---
 hw/char/sifive_uart.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index b9bbaae..0c552e5 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -341,10 +341,22 @@ static void sifive_uart_reset_hold(Object *obj, ResetType type)
     qemu_irq_lower(s->irq);
 }
 
+static int sifive_uart_post_load(void *opaque, int version_id)
+{
+    SiFiveUARTState *s = opaque;
+
+    if (s->rx_fifo_len > SIFIVE_UART_RX_FIFO_SIZE) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_sifive_uart = {
     .name = TYPE_SIFIVE_UART,
     .version_id = 3,
     .minimum_version_id = 3,
+    .post_load = sifive_uart_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(rx_fifo, SiFiveUARTState,
                             SIFIVE_UART_RX_FIFO_SIZE),

