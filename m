Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2CBC282D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 17:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4TV-0007nQ-TK; Fri, 28 Feb 2025 12:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1to4TA-0007VJ-Ry
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:48:17 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1to4T7-0005Nw-WC
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:48:16 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38f6475f747so1230617f8f.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 09:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740764889; x=1741369689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IrK81ur78/kd+G6F3kTwFNDWhB4gkURHyE9BpPtQ7cw=;
 b=QBOc97TGU8coZO044vEU6iTAKItSwICwtQISKtLa2GOW+8OnQ6+ul9FvydAtewPPsp
 msjB1qbA6ctTPeyqdwjcj6qHTmoibwd/UnejUaXOmmnMxDHSHbWH3teOm2kE0U/0OzI/
 xk/G6guV21LwMdpWFz+nxnJl8eIdw9lHQQSogQC7IB6mgyR79XRNqghRcx6EWnHc9G/O
 KA2MqBta7ERHat740P5iILxL+eQNIX+UkhpzxqlOqNBqmV9dzOwBfDJwb0cT0K4IO5Wj
 /8z/HY5YLKQ8SrxD/37jr8yAuGqjjnLLzU1hiV4wiA1E8olV7b1bT1wjVa+OwtXgU29c
 zADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740764889; x=1741369689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IrK81ur78/kd+G6F3kTwFNDWhB4gkURHyE9BpPtQ7cw=;
 b=BJOVfxHvQjbpQm8GmHfwFNy/vOQ5jc2hCX2qTUHabh439bGoYQmliCZiog/Peq/DLF
 ua1FDYp+SrSO/6JWaAG5gTtHQ4CA3/BC0qXQnHfGsbT8zoG8UkKtYLq/EKM65mRq/W2V
 4oUbuBFtZxLg6kc+71/gEnwMlx57wvJuXsXOsR0j9u5NYobGRDFGj2+Iu7XaBxWqf5EU
 HcWOxqgqDeENpuBTgH5WEMu+eDZMmX+KMup1FLWe9MOGOjEiWuYabdwS/cw5HfPesu0Y
 eICMrnQrYcsxP0m1xSRDnM3QUkz71PSU9mNtn8hWhi+8lggoqKq1KgZXXRUYyztroxKU
 l0kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+M5CTUyBKCBdMXBo5hlaMxodv0WtELUVPXK0hVuphpk1eIk7or6MkizudTrwgF7BYWyoIABH24zvN@nongnu.org
X-Gm-Message-State: AOJu0YyQ67+T5kFz7KkcBpTrZZiHc1kF3TFz+T9pn02/USP+JeBpiSx/
 oDzgExqmUj/J5iAGP/d1V73eCWQO7TUm7cFNkc3BqatL5l10jtQZ2fj/E4xyf6k=
X-Gm-Gg: ASbGncvMRM2YvUqAhaw+FgIN8jj2wIdwhKMV67TbIzECZ75tbdrm2vUHyUrztIygV9I
 xashbtBoBYuIrI7n/Hb2Z8wHDLawq8yMCPRDCufgnrI65hQNX2J4PUz98DivvSt4kp5LpQJtANI
 uVxT6fq0YbxiJJqFmkVyrarxrNMlpX1j90ycK2UYDM/WXwEB5hXitiZxTwWx3TbLt3XMXmXTGiT
 kFaVa1z2ZxEUJ95xmQQDYjkqZlW7Kb+ZgZ4qjL5JjMz3CQDjsyiRpl4gBeYqCaO2g48QvO8TYgn
 uKhmiAmcHEXSz8A64Z9uMfrT8lhcLf/n
X-Google-Smtp-Source: AGHT+IFfZ6GHcrxwn3SafSDm+9COzqYxaY87as062ZhALvU+4CT5Yv7PYlX2tHV3oWCLTlGuQjBqGA==
X-Received: by 2002:a05:6000:401f:b0:38f:38eb:fcfc with SMTP id
 ffacd0b85a97d-390ec7c7fefmr3526755f8f.7.1740764889367; 
 Fri, 28 Feb 2025 09:48:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795da5sm5979556f8f.15.2025.02.28.09.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 09:48:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH 3/3] hw/net/smc91c111: Use MAX_PACKET_SIZE instead of magic
 numbers
Date: Fri, 28 Feb 2025 17:48:01 +0000
Message-ID: <20250228174802.1945417-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228174802.1945417-1-peter.maydell@linaro.org>
References: <20250228174802.1945417-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now we have a constant for the maximum packet size, we can use it
to replace various hardcoded 2048 values.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/smc91c111.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 23ca99f926a..4a8f867d96e 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -58,7 +58,7 @@ struct smc91c111_state {
     int tx_fifo_done_len;
     int tx_fifo_done[NUM_PACKETS];
     /* Packet buffer memory.  */
-    uint8_t data[NUM_PACKETS][2048];
+    uint8_t data[NUM_PACKETS][MAX_PACKET_SIZE];
     uint8_t int_level;
     uint8_t int_mask;
     MemoryRegion mmio;
@@ -86,7 +86,8 @@ static const VMStateDescription vmstate_smc91c111 = {
         VMSTATE_INT32_ARRAY(rx_fifo, smc91c111_state, NUM_PACKETS),
         VMSTATE_INT32(tx_fifo_done_len, smc91c111_state),
         VMSTATE_INT32_ARRAY(tx_fifo_done, smc91c111_state, NUM_PACKETS),
-        VMSTATE_BUFFER_UNSAFE(data, smc91c111_state, 0, NUM_PACKETS * 2048),
+        VMSTATE_BUFFER_UNSAFE(data, smc91c111_state, 0,
+                              NUM_PACKETS * MAX_PACKET_SIZE),
         VMSTATE_UINT8(int_level, smc91c111_state),
         VMSTATE_UINT8(int_mask, smc91c111_state),
         VMSTATE_END_OF_LIST()
@@ -773,8 +774,9 @@ static ssize_t smc91c111_receive(NetClientState *nc, const uint8_t *buf, size_t
     if (crc)
         packetsize += 4;
     /* TODO: Flag overrun and receive errors.  */
-    if (packetsize > 2048)
+    if (packetsize > MAX_PACKET_SIZE) {
         return -1;
+    }
     packetnum = smc91c111_allocate_packet(s);
     if (packetnum == 0x80)
         return -1;
-- 
2.43.0


