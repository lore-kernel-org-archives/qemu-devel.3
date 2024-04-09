Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC32CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBfx-0005nn-M7; Tue, 09 Apr 2024 09:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBfw-0005nT-M4
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBfv-0008B9-0Q
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41550858cabso38549225e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712669889; x=1713274689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EZB+SBD3c6Tl2ilo7C5/8FmcEWLXBUIeUjZwCbvwe1A=;
 b=RRetPFKy65vGiYnCsjFXIO0bxwFMbkXL39j00xg/mLDey/hfLYhelWEMfz9Efvacib
 yFuzEi3btgzt7kbQoVKkL2yMs4hp5/4hrmezaEW2RmG7l2/4WfGX1y1/SJmKFvHEVCkD
 xl82goS4h+Cb6Fso9HdjXxa8ZX5IrX5qjX3LivBzSOIL3jhfvDeiiJPuSfVbk2G/TEnt
 oZTIbSXiJ2WTU0LVBv9CCt+pEHiQH1sKzV5qnJQp3YxfG1NZh86HK0fhpcA0mc8cBaQe
 /gDg42BW4ZzUCp6lCtghtEDPtghqYnLaFDtZ4C/lWrAC055erQmgKJQpbb/HMONys0VR
 lLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712669889; x=1713274689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EZB+SBD3c6Tl2ilo7C5/8FmcEWLXBUIeUjZwCbvwe1A=;
 b=nkmQQaXIuyJ7HD1NevmsfyYtff/Od7nFEbQLvxyDHHaB1+4JZ+o5NRB69S+NKLfwS/
 x1Gd44vQQRiRtJ7YxJfBUCNhJLnVGG7R9Ik8wceCbysEV7+/AlsQHs4v7xjHBNsIkwUD
 oVLdudhbhCEKAWWiGGKs/EonMMfRKM4nnhVkV0WHHXvsL3aobfsBaa7+F7alCPkzsK1W
 Y7TAWWdL6XRju3vS0bSqwNIPIH6FeF4E6PUoKPJ0ipH0maCoj3jP7xhpL8ZRQKDZtH+L
 oJXDFJU+LGSQMrdIjwOGr3S+Ldmex32TdzOD19m/59ASxywrEY9zgvzBxrb2SDw6AKC+
 dQ2g==
X-Gm-Message-State: AOJu0YxzhnmRaQXKFyjprREHm75AGIeguwA+ZZwke4cKNvqbF5NFtOuy
 4w/b9cq9cA45bB8b4yGTVf6F4IO6ElZNS0Cx+jPCT31fgZFER49Qc1HIyDJGP6o1lRoYHEc1Rmh
 m
X-Google-Smtp-Source: AGHT+IEld16FAPlTMK+v5IReyddCsHOplEcnkGaWwU0kLlZ/pgWOjcNT/RB07WvpZjCkx2CAUAyGNg==
X-Received: by 2002:a05:600c:1913:b0:416:2471:e102 with SMTP id
 j19-20020a05600c191300b004162471e102mr9168921wmq.37.1712669889014; 
 Tue, 09 Apr 2024 06:38:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a05600c45cb00b004162d06768bsm18084976wmo.21.2024.04.09.06.38.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 06:38:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chuhong Yuan <hslester96@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v2 01/11] hw/net/lan9118: Replace magic '2048' value
 by MIL_TXFIFO_SIZE definition
Date: Tue,  9 Apr 2024 15:37:50 +0200
Message-ID: <20240409133801.23503-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240409133801.23503-1-philmd@linaro.org>
References: <20240409133801.23503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The magic 2048 is explained in the LAN9211 datasheet (DS00002414A)
in chapter 1.4, "10/100 Ethernet MAC":

  The MAC Interface Layer (MIL), within the MAC, contains a
  2K Byte transmit and a 128 Byte receive FIFO which is separate
  from the TX and RX FIFOs. [...]

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
(Not including Peter R-b from v1 due to semantic change)

 hw/net/lan9118.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 47ff25b441..8214569a2c 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -150,6 +150,12 @@ do { printf("lan9118: " fmt , ## __VA_ARGS__); } while (0)
 
 #define GPT_TIMER_EN    0x20000000
 
+/*
+ * The MAC Interface Layer (MIL), within the MAC, contains a 2K Byte transmit
+ * and a 128 Byte receive FIFO which is separate from the TX and RX FIFOs.
+ */
+#define MIL_TXFIFO_SIZE         2048
+
 enum tx_state {
     TX_IDLE,
     TX_B,
@@ -166,7 +172,7 @@ typedef struct {
     int32_t pad;
     int32_t fifo_used;
     int32_t len;
-    uint8_t data[2048];
+    uint8_t data[MIL_TXFIFO_SIZE];
 } LAN9118Packet;
 
 static const VMStateDescription vmstate_lan9118_packet = {
@@ -182,7 +188,7 @@ static const VMStateDescription vmstate_lan9118_packet = {
         VMSTATE_INT32(pad, LAN9118Packet),
         VMSTATE_INT32(fifo_used, LAN9118Packet),
         VMSTATE_INT32(len, LAN9118Packet),
-        VMSTATE_UINT8_ARRAY(data, LAN9118Packet, 2048),
+        VMSTATE_UINT8_ARRAY(data, LAN9118Packet, MIL_TXFIFO_SIZE),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -544,7 +550,7 @@ static ssize_t lan9118_receive(NetClientState *nc, const uint8_t *buf,
         return -1;
     }
 
-    if (size >= 2048 || size < 14) {
+    if (size >= MIL_TXFIFO_SIZE || size < 14) {
         return -1;
     }
 
-- 
2.41.0


