Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5C8C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZmm-00034r-FW; Tue, 02 Jul 2024 05:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmf-0002uO-MP
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmc-0001ZT-Uk
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4256aee6e4dso28693435e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912401; x=1720517201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hYt9NrY8vo8112paVkmJIP0WplWJ6pspD+deTZLbMcw=;
 b=FdyQ2c+p6ljntTKi+3mndjpFxmxmJmebvjqHxdiBmPqiISgm6HVRIGPzPslAIaHEAt
 7NQjDKHueAqj9231zCpRK8HPeKvZN3cvKdVhtAD1MJ5rLHANr8K2ny3r16h1jh/8QjC9
 NHBVb0EaWfLjlOxdBD9jNS0OtMKLwtizaFC9r7EhMoZJzEwxdzUP1PbHvPx84SJf+Hpt
 BuslMu+7bR/Kjwf3ldNWsD1Kw4KVDtZiZwjqaZWrYbmGfgmQ4M9dO/IejnmmFCRDqdaM
 bbkTQxySOwdyy4yaJRFgqY6753BMhQLpLiiW81KKMSyqRG2O5kUtj6IzA7bBTrM+v2IF
 cu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912401; x=1720517201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYt9NrY8vo8112paVkmJIP0WplWJ6pspD+deTZLbMcw=;
 b=Jd8/1a80x5C4Ae8zigv2PYi4cnkyA03ZcGJPPIWP8lCMiyqb7zFtS/2SFBw7YD1WrQ
 5b0FjN+LnbCwAgJou9RVNXoNVA5SwRr7gY2VSayEh9svMDZwxeQZAfy/M8tdormjn+HM
 fZA0XIGXY5TdGfwaNE/Y90PnWucXR3zA3P3/llLsxIhHxkri68zHiJXJhF+vMKCh0rHu
 ZCG2BkCH83fbMC73dk96fnoquAk0DJNnD5YcXqNX5MXlIXluebRkYp4W5InPu8lGQPZp
 +FvEzIuLVMTK3o19b/guO2jDKeqIgpDyEKZjjU6MC8noXioY1CHo5h7lmmIVLxnKIPBN
 QoYQ==
X-Gm-Message-State: AOJu0YxKGN8wkBX1yXRoRecAsKif8LdSJisr1J62+SpRbsvVCJBS/yxO
 Sv8ujOnYV7bzRbt9xASC+Gct+5XbY2ONyjprllIT5iqAKO1sZ1KeSpCR+Y3IeVEgIdnCaaH7Mb+
 m
X-Google-Smtp-Source: AGHT+IF+T9scoik84D/u8qine16/w8ayUy2hC8Vtd5HOEMgNYnwJ0XufsF9AGP0AfgY7dglsgNtrqg==
X-Received: by 2002:a7b:ce83:0:b0:425:6327:f00c with SMTP id
 5b1f17b1804b1-4257a00ce8emr54531615e9.22.1719912401329; 
 Tue, 02 Jul 2024 02:26:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5901dsm190572775e9.14.2024.07.02.02.26.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:26:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 59/67] hw/sd/sdcard: Add spi_cmd_READ_OCR handler (CMD58)
Date: Tue,  2 Jul 2024 11:20:42 +0200
Message-ID: <20240702092051.45754-60-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-67-philmd@linaro.org>
---
 hw/sd/sd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f5548d5667..08fb3cf9d3 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1641,6 +1641,12 @@ static sd_rsp_type_t sd_cmd_APP_CMD(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* CMD58 */
+static sd_rsp_type_t spi_cmd_READ_OCR(SDState *sd, SDRequest req)
+{
+    return sd_r3;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1744,9 +1750,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
         break;
 
-    case 58:    /* CMD58:   READ_OCR (SPI) */
-        return sd_r3;
-
     case 59:    /* CMD59:   CRC_ON_OFF (SPI) */
         return sd_r1;
 
@@ -2326,6 +2329,7 @@ static const SDProto sd_proto_spi = {
         [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
         [55] = {8,  sd_spi, "APP_CMD", sd_cmd_APP_CMD},
         [57] = {10, sd_spi, "DIRECT_SECURE_WRITE", sd_cmd_optional},
+        [58] = {0,  sd_spi, "READ_OCR", spi_cmd_READ_OCR},
     },
     .acmd = {
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
-- 
2.41.0


