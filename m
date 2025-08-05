Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955CCC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 17:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujLWN-0008Tx-AN; Tue, 05 Aug 2025 13:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLWE-0008On-Dl
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLWC-0004ut-P2
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:10 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-459ddb41539so9215965e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754415127; x=1755019927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFhz2sQyXixc1I4PYJPHju8JCIN1+OF459KzUdGj17s=;
 b=RW4m4Epvvmh1PdiuG9rLmduQubctzimpgDnhWjRpUxtutewYu1PdrQ3ZhFvSPtzoIv
 8kBiSwjLpk9+9khMqrHn7HBDNtIkokzCCW8itR7R3GrKxp6Sg5k6H+s+rodJYvpITwyo
 VIR09cC4wcF5NLPaQqjj3c8Trva1iANbI1v5gTXyPxHupQndR5M4b082Z2amQstJpYlI
 aFNWM9ah6Y66qCxkfmxu2YllHtPhw90WZiBZCUR6o66qF2tigKdljWxoUnLrPHhJlkfC
 +eckmNP8SC09aEdw49r+nuqYgKpb07rSYKhsSu0/qeaTjHSB4igL1aBywfxM4b7BRxge
 vtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754415127; x=1755019927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aFhz2sQyXixc1I4PYJPHju8JCIN1+OF459KzUdGj17s=;
 b=WMGIJ5LWQWRtJ7ZlKNNvP/s5c8sprNEvh5xZHA7ZPkdZIWpn0wN1cT4/v8fbPOj/br
 CQXPo6J9e2BrQMskquw4hz1FzjxvWVIuGCSgUbXBfU/HK4+8Qg/1zYoUz09jZGmG4Hnd
 wlCtjE1sgYzN7r1wzTK9fYbSgT1d14IaREp5RPal8Q9gD0jV2DHLmQze+W386yqbIMfz
 v+fzrJxNz4yVlN0OpnN3aFNKMD8Drxd7sJEZVWHmMeTnjPhlT7Am0zgM6FsukYAq9lml
 QxVOrdVIlRRIixiCBqaw5HPopeTvDgwr2kTi+6pEet2DIh/MEa/XhQb2CO4jPKPo/FlG
 WVfQ==
X-Gm-Message-State: AOJu0YwisneQ88Z3x2VhDtoKFBVJqanVrsHhA39tpoSGSyUc6Y17HfTC
 VmQ65rhu0G+gAZWSM1GnTPt0i6O5eL3sBo1WdGh+PCyvd9EVkZ01yok4Q11z7vg1mz7mziNSpZE
 rEMK6
X-Gm-Gg: ASbGncuVsgzokeiVztn6YbdLly5WhzBk4RTZLzBqovdAscDrc17fL0zIElKb67PQTYx
 lg1bS8TGYfq/VI8F9VfABH39hmvDjd/JHzAoxUNoC5BzqRNdhz0w8n7XvOfJ7OnRphILpmMHxpq
 OvBSF0/VDHbWv5D1nGkRgd432ZQNLm4EF2+nijml/UCdOY/Yy1KfX8iBGDlKLz3t5bp4QBi7JrW
 50TRpSprRb7B7VAYZzRM9+afPe52d17pXlwoPc+HGY+IMn5NSP3TgWUDbOYKDi6kgIPqp7MtTaW
 tgXVSv8j//DrJnZspNgQenoyFcjewcA0gjnNztPmaC3kCzqA/uz5qRqQNK30On1NKo6e6Qp1eDe
 WrlJT21OP3NrX/qCKHVYTfb4c1Q+Ao4JQwmMdg6AhAIkjFnapD8VUtFKagKIFnrixdZ6rRZqPwy
 cd5WNq5xI=
X-Google-Smtp-Source: AGHT+IF4JaOiY4GLdS/dDodcBV9hNsw9XcH5JQOUofwZRX4ud99hBG6H0dpmhvVtfgt+omsv30Ym3g==
X-Received: by 2002:a05:600c:a43:b0:456:1b93:76b with SMTP id
 5b1f17b1804b1-458b69cbdd9mr109507305e9.4.1754415126815; 
 Tue, 05 Aug 2025 10:32:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c485444sm20043786f8f.66.2025.08.05.10.32.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Aug 2025 10:32:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: [PULL 06/13] hw/sd/sdcard: Use complete SEND_OP_COND implementation
 in SPI mode
Date: Tue,  5 Aug 2025 19:31:27 +0200
Message-ID: <20250805173135.38045-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805173135.38045-1-philmd@linaro.org>
References: <20250805173135.38045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

While spi_cmd_SEND_OP_COND() is incomplete, sd_cmd_SEND_OP_COND()
is, except it doesn't return the correct value in SPI mode.
Correct and use, removing the need for spi_cmd_SEND_OP_COND().

Fixes: 775616c3ae8 ("Partial SD card SPI mode support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250804133406.17456-7-philmd@linaro.org>
---
 hw/sd/sd.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 01ec6d951c8..df2a272c6a2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1414,14 +1414,6 @@ static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
     return sd_is_spi(sd) ? sd_r1 : sd_r0;
 }
 
-/* CMD1 */
-static sd_rsp_type_t spi_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
-{
-    sd->state = sd_transfer_state;
-
-    return sd_r1;
-}
-
 /* CMD2 */
 static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
 {
@@ -2046,6 +2038,9 @@ static sd_rsp_type_t sd_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
         sd->state = sd_ready_state;
     }
 
+    if (sd_is_spi(sd)) {
+        return sd_r1;
+    }
     return sd_r3;
 }
 
@@ -2590,7 +2585,7 @@ static const SDProto sd_proto_spi = {
     .name = "SPI",
     .cmd = {
         [0]  = {0,  sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
-        [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
+        [1]  = {0,  sd_spi, "SEND_OP_COND", sd_cmd_SEND_OP_COND},
         [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
         [6]  = {10, sd_spi, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
         [8]  = {0,  sd_spi, "SEND_IF_COND", sd_cmd_SEND_IF_COND},
@@ -2626,7 +2621,7 @@ static const SDProto sd_proto_spi = {
         [13] = {8,  sd_spi, "SD_STATUS", sd_acmd_SD_STATUS},
         [22] = {8,  sd_spi, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
         [23] = {8,  sd_spi, "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
-        [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
+        [41] = {8,  sd_spi, "SEND_OP_COND", sd_cmd_SEND_OP_COND},
         [42] = {8,  sd_spi, "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
         [51] = {8,  sd_spi, "SEND_SCR", sd_acmd_SEND_SCR},
     },
-- 
2.49.0


