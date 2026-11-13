Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128C606A894
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=Cq14Y4Ya
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrjB-0001Mm-KQ; Fri, 13 Nov 2026 08:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRnta-0004Mt-Ga; Fri, 13 Nov 2026 04:48:34 -0500
Received: from smtp47.tsinghua.edu.cn ([101.6.4.71] helo=tsinghua.edu.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <w-yf22@mails.tsinghua.edu.cn>)
 id 1xRntY-00072J-7u; Fri, 13 Nov 2026 04:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=aundBwdj27rtC6OA33CJBdTLIboDzXkrGp
 1qs1FvdEc=; b=Cq14Y4Ya4Cdcq+fBy0p77h6myfZNRSLatex8OzRse/pG9sV+Ue
 rYxidQJUhQR4at/6YvhuTVtuL2nJyKihrbQzAerdc2c2eLCEnlIzU7R0yixjz75r
 15uDcbMTU6NhMzxFRQlwJlO0KOOxXp5lKb/HwdGqqFw00E865FjyaY/qA=
Received: from ubuntu (unknown [101.5.154.165])
 by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S3;
 Fri, 13 Nov 2026 17:48:25 +0800 (CST)
From: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
To: qemu-devel@nongnu.org
Cc: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 bin.meng@processmission.com, tangtao1634@phytium.com.cn,
 Chao Liu <chao.liu@processmission.com>
Subject: [RFC PATCH 01/20] hw/char/dw8250: implement the UART status register
Date: Fri, 13 Nov 2026 17:47:35 +0800
Message-ID: <b5f1bddaaa4e4d16aaba94267475140c8e6be74b.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
References: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: yAQGZQA3qzvR3PZqgA5CAg--.9318S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1rKw15Kr13Cr45WF4rXwb_yoW5AF4Dpr
 90kFZ8tF1qyw13W3s3KFW3GrsxXFWrG3W0yr43trZ8tF4UCw4kKry3Za4aqFWDZrn8Jr4U
 X34DGwsFgayjvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUHF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
 A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
 c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
 Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
 6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
 ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GFWl
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
 WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUj9a9DUUUU
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/
Received-SPF: pass client-ip=101.6.4.71;
 envelope-from=w-yf22@mails.tsinghua.edu.cn; helo=tsinghua.edu.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:52 -0500
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Liu <chao.liu@processmission.com>

The Rock 5B machine runs a vendor U-Boot and Linux that read the UART
status register to check the transmitter and FIFO state. Implement the
register.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 hw/char/dw8250.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/hw/char/dw8250.c b/hw/char/dw8250.c
index 50baeae62c..4f9a8ea989 100644
--- a/hw/char/dw8250.c
+++ b/hw/char/dw8250.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/char/dw8250.h"
@@ -14,20 +15,62 @@
 
 #define DW_UART_REGION_SIZE 0x100
 
+#define DW_UART_USR   (0x7C >> 2) /* UART Status Register */
 #define DW_UART_RE_EN (0xB4 >> 2) /* Receiver Output Enable Register */
 #define DW_UART_DLF   (0xC0 >> 2) /* Divisor Latch Fraction Register */
 #define DW_UART_CPR   (0xF4 >> 2) /* Component Parameter Register */
 #define DW_UART_UCV   (0xF8 >> 2) /* UART Component Version */
 #define DW_UART_CTR   (0xFC >> 2) /* Component Type Register */
 
+/* UART Status Register bits */
+#define DW_UART_USR_BUSY BIT(0) /* UART busy */
+#define DW_UART_USR_TFNF BIT(1) /* Transmit FIFO not full */
+#define DW_UART_USR_TFE  BIT(2) /* Transmit FIFO empty */
+#define DW_UART_USR_RFNE BIT(3) /* Receive FIFO not empty */
+#define DW_UART_USR_RFF  BIT(4) /* Receive FIFO full */
+
+/* FIFO Control Register bits */
+#define DW_UART_FCR_FIFO_EN BIT(0) /* FIFO enable */
+
+/* Line Status Register bits */
+#define DW_UART_LSR_DR   BIT(0) /* Receiver data ready */
+#define DW_UART_LSR_THRE BIT(5) /* Transmitter holding register empty */
+#define DW_UART_LSR_TEMT BIT(6) /* Transmitter empty */
+
 #define DW_UART_UCV_VALUE 0x3332332A /* "323*" -> v3.23a */
 #define DW_UART_CTR_VALUE 0x44570110 /* "DW" */
 
 static uint64_t dw8250_ext_read(void *opaque, hwaddr addr, unsigned int size)
 {
     DW8250State *s = opaque;
+    SerialState *serial = &s->serial_mm.serial;
 
     switch (addr >> s->regshift) {
+    case DW_UART_USR: {
+        bool fifo_enabled = serial->fcr & DW_UART_FCR_FIFO_EN;
+        bool thr_empty = serial->lsr & DW_UART_LSR_THRE;
+        bool tx_idle = serial->lsr & DW_UART_LSR_TEMT;
+        bool rx_ready = serial->lsr & DW_UART_LSR_DR;
+        bool tx_empty;
+        bool tx_full;
+        bool rx_full;
+
+        if (fifo_enabled) {
+            tx_empty = fifo8_is_empty(&serial->xmit_fifo);
+            tx_full = fifo8_is_full(&serial->xmit_fifo);
+            rx_full = fifo8_is_full(&serial->recv_fifo);
+        } else {
+            tx_empty = thr_empty;
+            tx_full = !thr_empty;
+            rx_full = rx_ready;
+        }
+
+        return (!tx_idle ? DW_UART_USR_BUSY : 0) |
+               (!tx_full ? DW_UART_USR_TFNF : 0) |
+               (tx_empty ? DW_UART_USR_TFE : 0) |
+               (rx_ready ? DW_UART_USR_RFNE : 0) |
+               (rx_full ? DW_UART_USR_RFF : 0);
+    }
     case DW_UART_UCV:
         return DW_UART_UCV_VALUE;
     case DW_UART_CPR:
-- 
2.53.0


