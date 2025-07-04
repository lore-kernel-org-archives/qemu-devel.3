Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89496C83F12
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeMr-00049o-Hi; Fri, 04 Jul 2025 07:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMK-0002od-Ln
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:38 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMG-0003hu-5o
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:34 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-23636167b30so8771315ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627610; x=1752232410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SfgYizL3Nti5AIlWXmYjR2yepmyv1s+FueD5D7oVVKY=;
 b=DuE8TaIYBhPhibPZFPtvrAOvD3t0wAjNpKRHFK62a6Uj32VM/aivyZVbhMW52OwOaD
 CStt4kr/VGD4pkoXqMmAbCoypWwES+xIwZKSWfgiYBq/1VyNYGTNroIuuXqdhH5ITnrp
 3QAoYpYDL2NXdlkbCG81BFmjTgznb5dboSCs10oRF1wLjuwiOd7UCaE49lHaxLAgI9Nj
 VPQyWvDS4jUjYmNXHP6k7bgO9+P8YxzPxc5vdPQ+ZPMn8EvbVGg6QUhRYQhvdK3+HeR+
 OqTUSq8f0NWH7akN2mXcg8fG4i/FYBYI6VGI+wszQIp/m6E+WyC4YC6+il4rrTmmfabX
 dTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627610; x=1752232410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SfgYizL3Nti5AIlWXmYjR2yepmyv1s+FueD5D7oVVKY=;
 b=vlM1c9Ge5I4dCqdxeKYBKHGWbL3bcXSQQhT48cUS+BBmS0vwKhdy3SZExwcO/PpKtG
 FxuIdL+yhRvEw/hNNPqK3xB79XcpxMlxmtmXNAhlRxp0mpzx8/4d6kzHUPANDQQDkwWn
 6J0aJtZMHlpH6Zm+H5FdOAxwYv3GjPblnIlvIrlSQEG2UTQiOuo7qjNAKAmDClYei51f
 OZHta0eSBDuNgn0eyiIEZtASzQ5nLbVG/ovZEm/+UowljPpCYbDTnPSjFnWJBwJ0D14K
 puoewd5MzfyDvy/Y73QmIt4yrp/3Qx0lDi1bEXHBmbHJnVhO9UpMIDClvfTtwnKZeb8J
 XHNw==
X-Gm-Message-State: AOJu0Yy995bVGzD7rq3Qx7cvrblbJC0YLuU149lbSdaboQJOUkt0nVxs
 WV648P11qENZ31yzkM3qAgyeGr1Chza8MBWR1PXIxDR2XbA8R1TgG0XwxsSDWQ==
X-Gm-Gg: ASbGnctw5tWiXpfQe2DgZHSQS63xeho1YiHqDXWhqRSMySrAwN4ZT1yNbnzvZGWReiV
 TIV2723M2xzOtP3e5h1sdNsBI+JQlI2zGQ3mYPo21uqnDTLi2tzapg3Fl11/jT/0Z6RqxhQEUl2
 mCPFLKc2sB94Ud9/pLcldb8+msSSCDzCnCqapiNQPqT3VIYp5BGt3Uw/i48PYvP+9LcJ4W0cKFX
 1WeYN8YyuxTWu5w/KxJ8QIchuXQcZWtTA4m462VmJNfP6MgwjvnpS02OvlbtAMnTDgMm2ICccr2
 zf/D/vRlFhUAc/MhHUHX6+/uPbIjTK/xrg00UmSEeoEcW9mTbxyEwo/1rpSxTBK3nLol1xsgkxr
 L+ZCaYodAqqzgG9oG4dno/cabHfHuExxxHYxuOaZFRY8gLP5rI7nWNJ41Ar0BMq4yRuw=
X-Google-Smtp-Source: AGHT+IFUnENo47JM81cL/SFxQLnOlrBkgwo/xvBuXr8pK6rVpvRfOJC2XUrT7CLxtLwKccq81gweEQ==
X-Received: by 2002:a17:903:acb:b0:234:d7b2:2ac5 with SMTP id
 d9443c01a7336-23c85dff02bmr42380275ad.21.1751627610072; 
 Fri, 04 Jul 2025 04:13:30 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Florian Lugou <florian.lugou@provenrun.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/40] hw/char: sifive_uart: Avoid infinite delay of async xmit
 function
Date: Fri,  4 Jul 2025 21:11:47 +1000
Message-ID: <20250704111207.591994-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Florian Lugou <florian.lugou@provenrun.com>

The current handler for TXFIFO writes schedules an async callback to
pop characters from the queue. When software writes to TXFIFO faster
than the async callback delay (100ns), the timer may be pushed back
while the previous character has not be dequeued yet. This happens in
particular when using -icount with small shift values. This is
especially worrysome when software repetitively issues amoor.w
instructions (as suggested by SiFive specification) and the FIFO is
full, leading to the callback being infinitly pushed back.

This commit fixes the issue by never pushing back the timer, only
updating it if it is not already active.

Signed-off-by: Florian Lugou <florian.lugou@provenrun.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250605101255.797162-1-florian.lugou@provenrun.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/sifive_uart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 0fc89e76d1..9bc697a67b 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -128,8 +128,10 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
         s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
     }
 
-    timer_mod(s->fifo_trigger_handle, current_time +
-                  TX_INTERRUPT_TRIGGER_DELAY_NS);
+    if (!timer_pending(s->fifo_trigger_handle)) {
+        timer_mod(s->fifo_trigger_handle, current_time +
+                      TX_INTERRUPT_TRIGGER_DELAY_NS);
+    }
 }
 
 static uint64_t
-- 
2.50.0


