Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D7EC52D7B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 20:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbnGr-0001dl-JN; Wed, 07 Aug 2024 16:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbnGp-0001YD-W2
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:28:32 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbnGo-0006tz-2L
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:28:31 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-368663d7f80so98112f8f.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 13:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723062508; x=1723667308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64V2wCrrYmQb5TKOeGR5XbQEWlSQEIaOZkBcAH6L56E=;
 b=qYOa2xoCjjcofywzBJvPEsG4kUCgPi6vTeyxn4vDQmXCn6Q1wlfCuLZEjuEM31VdT1
 A+4xkja2avrRw7mxVCgY+N/WcjpYi8NWLE8zQNwlEpPmlYtcogQoGMLL2e9umSLN7KrM
 g7Hj0NXTY5FTVV58932/xfjXqXJRLir8Yb6Bm3S33u9xdlgEymjY2AeQQksrSE7NZu8d
 XSxgHKE4jYbgkTlc5z218aw1Plk1UnUCazvBgX3G1Eh4y2WL80OVaCzHHphJF1o5Z/3D
 qYCMiHFHoVqoKeuuAOXIGMbSfrZAy91P4pVDlsVBPpMOzDIF8+AMDCpybfoBa8B7R4q4
 GQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723062508; x=1723667308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=64V2wCrrYmQb5TKOeGR5XbQEWlSQEIaOZkBcAH6L56E=;
 b=riLhreh0bdCKUHk3Mw4gRtSVZXDk0NwOZZWGlXFF58zIWl83kUKrXP/liHQ2dKq+c3
 n2DMoAB1DSDMU+vIWoLa5yozwmW508mCAd2uxkxr2MLM9VFEa4VPgRNZVJh4UXqqnw/T
 in8t9fDPPXtUgDS6kadRg65oW95awb5xVyXgeBqjjpp0tWTgl8M5rdKLeP2PvEdDgwsh
 dXQtNN2rdHCZgzKauBX9ChFp3hUzFWKNglyvf/Bro9XKnyFvqAu3J5TCHwb0BZrPw21o
 vdLy6AdFIQT0NswXPjSLN06QKjaljrRpGXnI6P1CB0x67+Zz61k1BGdMkS4czXFc2t5M
 T3KQ==
X-Gm-Message-State: AOJu0YwXAzZQ2dxaUkurGmm7jWHNmwQ674s1Wm9NrRt7OsOBxMTurOYY
 9eK2XD9l/7X6f85vZ9S3Rh/MqsBKFIEx/5ybYyArLSzC+WQlPrNXaA1ZeKkdsA9xRxmE7x9PXNL
 U
X-Google-Smtp-Source: AGHT+IF6EVqFQ62pSG19zvVCjx6YsEtR7MuubzLMXC/MVgAuhBvZKH0S9QdDlNTK2rJnUhwDglEiEw==
X-Received: by 2002:a05:6000:d2:b0:368:71fa:7532 with SMTP id
 ffacd0b85a97d-36bbc0e7225mr11786735f8f.31.1723062507881; 
 Wed, 07 Aug 2024 13:28:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf1e0bcsm16946687f8f.30.2024.08.07.13.28.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 13:28:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 3/4] hw/ssi/pnv_spi: Return early in transfer()
Date: Wed,  7 Aug 2024 22:28:03 +0200
Message-ID: <20240807202804.56038-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807202804.56038-1-philmd@linaro.org>
References: <20240807202804.56038-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Return early to simplify next commit.
No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ssi/pnv_spi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 13a47f07e7..05e6afc11e 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -217,6 +217,9 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payload)
     PnvXferBuffer *rsp_payload = NULL;
 
     rsp_payload = pnv_spi_xfer_buffer_new();
+    if (!rsp_payload) {
+        return;
+    }
     for (int offset = 0; offset < payload->len; offset += s->transfer_len) {
         tx = 0;
         for (int i = 0; i < s->transfer_len; i++) {
@@ -235,9 +238,7 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payload)
                     (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
         }
     }
-    if (rsp_payload != NULL) {
-        spi_response(s, s->N1_bits, rsp_payload);
-    }
+    spi_response(s, s->N1_bits, rsp_payload);
 }
 
 static inline uint8_t get_seq_index(PnvSpi *s)
-- 
2.45.2


