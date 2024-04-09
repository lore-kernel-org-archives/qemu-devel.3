Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D0AC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBhF-0007ZE-J1; Tue, 09 Apr 2024 09:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBgr-0006Y4-EJ
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:39:11 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBgk-0008HD-Fh
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:39:04 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41649860cecso17808135e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712669937; x=1713274737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUMgonNV5vOyAHp4tN1LAQ2kYLBDrcDQNXezZFX8ne0=;
 b=p8bOXGQOuKgwte04ATus/EVw/yQ8wfLPYg1GjcnVJd3+GjcPLpnm8AZkogpMZftjSv
 TaE4sTC3UlO1eGETwZXHrnbAv8EuRkVaWdznE3W7/NZurQ/AxZV6fSvdIIXYvL1WRUO+
 cti/K5EMyN9PKd07mBXMRMDXHxOZNkBrc9w/7I08Y/IUN0E+tbPUwpz6c8Lkv1l4erc1
 jEowID4GCAUByDorBWzW3tDK1PIMoRBPq+i3OHWA2pTT9QzNieohc0RzENySN2cDgFP0
 ZJGx79+kzdd4RGi16AgR2XefcGwwLQII0extAW2wCIJYkQfis/K9IOQrbdgl1T72Btk1
 nOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712669937; x=1713274737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BUMgonNV5vOyAHp4tN1LAQ2kYLBDrcDQNXezZFX8ne0=;
 b=JdsHfoHVmenzSDtRiFjMNhfPbORx0NG+88TruKVncStrAuMZZtw4riHxE3IywId4Km
 l7/zzFt8XhoaI+5GQbg0QuWvA5FLurmzyKcaYN2Lpg5Mj5kAfROjwGAfiqV1UGN0IGMm
 /dfYC55iOUG2i92irbvcVUyvRU/F44iDhZyhYgLwvGwOl13eYR7eWIZVqAn7dSjkim58
 hVrdhDki42r7kP2yEPJXnHNHV0UdeCJivRf0ISBh4RH/zUMlzkdnirDTeYnaRPYsyiXy
 yLeWvUkMU5bSeXsWVU3UpLF2j3TIryUa7HgGBYr9crOPKekHq0ZBsUKvs3ncBov1S6Hk
 4Qvg==
X-Gm-Message-State: AOJu0YyU7L4Lw8m+lh6dgbgSSn5P2oW5Id1hj+8at4ZrH4PBORhKso8Y
 gPkd9m5WWXCwPDoDWhEYNOsBU9oRbblKQ3/KlIKtIuTtcddPhc+Kis/+SDmXPU2HoO4PHQKS+y/
 h
X-Google-Smtp-Source: AGHT+IFoWrIGHt2SW5wE8A9zU9OrOKW5/1vE7Nylo7hN6pKti2TH4DFlSQHg7tnkc/4J51ft3Omnng==
X-Received: by 2002:a05:600c:1d81:b0:416:7b2c:df0f with SMTP id
 p1-20020a05600c1d8100b004167b2cdf0fmr4921965wms.7.1712669937543; 
 Tue, 09 Apr 2024 06:38:57 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a05600c4f0f00b004166b960469sm8107944wmq.38.2024.04.09.06.38.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 06:38:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chuhong Yuan <hslester96@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 10/11] hw/net/lan9118: Use RX_DATA_FIFO_BYTES
 definition
Date: Tue,  9 Apr 2024 15:37:59 +0200
Message-ID: <20240409133801.23503-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240409133801.23503-1-philmd@linaro.org>
References: <20240409133801.23503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

rx_fifo[] is an array of words,
rx_fifo_size is a word count.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/lan9118.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 663776f575..56cc52d450 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -266,7 +266,7 @@ struct lan9118_state {
     int32_t rx_fifo_size;
     int32_t rx_fifo_used;
     int32_t rx_fifo_head;
-    uint32_t rx_fifo[3360];
+    uint32_t rx_fifo[RX_DATA_FIFO_BYTES / 4];
     int32_t rx_packet_size_head;
     int32_t rx_packet_size_tail;
     int32_t rx_packet_size[1024];
@@ -338,7 +338,9 @@ static const VMStateDescription vmstate_lan9118 = {
         VMSTATE_INT32(rx_fifo_size, lan9118_state),
         VMSTATE_INT32(rx_fifo_used, lan9118_state),
         VMSTATE_INT32(rx_fifo_head, lan9118_state),
-        VMSTATE_UINT32_ARRAY(rx_fifo, lan9118_state, 3360),
+        VMSTATE_UINT32_ARRAY(rx_fifo, lan9118_state,
+                             RX_DATA_FIFO_BYTES / 4),
+        VMSTATE_UNUSED(3360 * 4 - RX_DATA_FIFO_BYTES),
         VMSTATE_INT32(rx_packet_size_head, lan9118_state),
         VMSTATE_INT32(rx_packet_size_tail, lan9118_state),
         VMSTATE_INT32_ARRAY(rx_packet_size, lan9118_state, 1024),
@@ -460,7 +462,7 @@ static void lan9118_reset(DeviceState *d)
     s->txp->fifo_used = 0;
     s->tx_fifo_bytes = TX_DATA_FIFO_BYTES;
     s->tx_status_fifo_used = 0;
-    s->rx_fifo_size = 2640;
+    s->rx_fifo_size = RX_DATA_FIFO_BYTES / 4;
     s->rx_fifo_used = 0;
     s->rx_status_fifo_wordcount = RX_STATUS_FIFO_BYTES / 4;
     s->rx_status_fifo_used = 0;
-- 
2.41.0


