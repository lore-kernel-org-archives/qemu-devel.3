Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0964CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBgo-0006Bv-Nn; Tue, 09 Apr 2024 09:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBgJ-00061e-L8
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBgG-0008EZ-JB
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:34 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-343f62d8124so2801384f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712669910; x=1713274710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbfyIBf/SQJfbeKOCdEpbKAjf0YIAs4J/ih0RuWwHfw=;
 b=A5olmGq+DqVVVxLXaoPRzZOpkl3+bcx6X/tP30ChgWYesXDu5TFuooy0CuRwrNc9jm
 I3Wed44qyzFmJK+uJlCYRIE14nxvFfK9dOec23W/u5HXaBIYGaeoyZT3zdGqRbfdW1Im
 wAxIi9Wx6c7qVFP50YAfsUDKRlWXkPYzUvHMb77hFHRspm4e2p+WZbNHEm5SWNK3/u49
 LK+Az1IT5t5lBH7Fvnio5HK4pR0n+qduf3Ew0rMRsoKh084WDevMpMarfeiphl4h34FB
 ZzbwoPfjLhoDAIlS8CaYqcZrtzzdmkS4BJ5faWewFpoD/JVnHRr+kS/P8jgbrrIOOr0G
 +wXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712669910; x=1713274710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lbfyIBf/SQJfbeKOCdEpbKAjf0YIAs4J/ih0RuWwHfw=;
 b=gxbqfP5dwwtKcQit8hcoP6mkKfsyVLN2OUmQ0w03cwuUGFITcE5PiawR5t+GNfyhD3
 Sjh1dM31HIm50pGxjfEKvxHJoKPSDf5gf7Uo+bdiB+7e+cYhGemlMZOGdgHTAf9+CtJt
 rgPeFCPp3rP3lpx7A2WFucB+y+s8OFLhnm3nUlzqtlWSHnYz45CIqygE769Jk12tjWC6
 GGgZdzNB1ctjyOCOC7iM58uze5KGTL5VNpHKno4Vt/8kusDKhA5IWEfVqlgbF0H3m3bw
 J1D12uK9KweqN40+D4YNk+jH5mdBk5sLHrN3GQybVCR625OnfrIyvX29OcCYVZ6uK40y
 xiMA==
X-Gm-Message-State: AOJu0Ywt0xsnqG6qLQXctQ8zO63GJDHMac87P1u7y9oEIQKRS2r24w8j
 6835bzNqRVC9HyK8LmGBnFVBUSmnemScPmKlEE81a7KaXXVdyStzCmPfFJcELneIAqGlAcwW9Kp
 n
X-Google-Smtp-Source: AGHT+IELHMkr0CokRWJgSz7ychYXKu0gObaub5U19RTlVolwHBUf/EsheTqX+6tZdDi2fRPkLRFoiQ==
X-Received: by 2002:a5d:5233:0:b0:341:bfe2:4509 with SMTP id
 i19-20020a5d5233000000b00341bfe24509mr8216775wra.42.1712669910719; 
 Tue, 09 Apr 2024 06:38:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a5d5242000000b00343c0c24a65sm11460005wrc.89.2024.04.09.06.38.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 06:38:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chuhong Yuan <hslester96@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 05/11] hw/net/lan9118: Add definitions for FIFO
 allocated sizes
Date: Tue,  9 Apr 2024 15:37:54 +0200
Message-ID: <20240409133801.23503-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240409133801.23503-1-philmd@linaro.org>
References: <20240409133801.23503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Add definitions for the TX_FIF_SZ=5 case, per TABLE 5-3
"VALID TX/RX FIFO ALLOCATIONS".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/lan9118.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index a6a869de32..00409927fe 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -158,6 +158,17 @@ do { printf("lan9118: " fmt , ## __VA_ARGS__); } while (0)
  */
 #define MIL_TXFIFO_SIZE         2048
 
+/*
+ * TX and RX FIFO space is configurable through the TX FIFO Size (TX_FIF_SZ)
+ * field in the hardware configuration (CSR HW_CFG) register. These are the
+ * default configuration settings for TX_FIF_SZ = 5
+ * (see TABLE 5-3: VALID TX/RX FIFO ALLOCATIONS).
+ */
+#define TX_DATA_FIFO_BYTES      4608    /* 1152 words */
+#define TX_STATUS_FIFO_BYTES    512     /* 128 words */
+#define RX_DATA_FIFO_BYTES      10560   /* 2640 words */
+#define RX_STATUS_FIFO_BYTES    704     /* 176 words */
+
 enum tx_state {
     TX_IDLE,
     TX_B,
-- 
2.41.0


