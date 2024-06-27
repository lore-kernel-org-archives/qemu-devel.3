Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D154C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMs4o-0001UR-7Y; Thu, 27 Jun 2024 12:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs4m-0001Tb-Af
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:34:24 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs4k-0004Uz-KV
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:34:24 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3672aec418cso1316020f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506061; x=1720110861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnn8g/1r/IDbgXO0nM+fG6kuhQufIGWzDGBB4WRk/v4=;
 b=DP65HpRMXK9/XazTsYgxsxuuenuEcuZ3a9rYP03uVLZeH8DYhRT0mdHKMOCVOe7Cq5
 t5r7H5RCiMlMXRjLsoXiDx7bmdGkBwQFN/nKwU/a8Jr6hDippZpDejunb3B952Asytl4
 AbLJxgcm4sUdGUG8NWNvv1rGb5IqG7pxmxZ2gHvtekyXrYPiZgom1McWNRszU9heOrTO
 lQegG4fVAbvWd4/NyZJ2KpzCPk0IDbuFHk0jMO2jtzgfapC02Ir1NOtkdWuc8Bnt0iZQ
 k7NV2elyfX1ZCcpArh8jXVYtZuqIV8VQLMmMQKIuBABj2SkAqGi0dnO18s7lExNmHNvf
 TtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506061; x=1720110861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnn8g/1r/IDbgXO0nM+fG6kuhQufIGWzDGBB4WRk/v4=;
 b=YCmkGEF+h+8jFoVF/gkV+69sGJewBrGe+07DAT9zHAg5xO9w9u0V/i6RmJG4+gs/9I
 2hxhHlyFAzg2NnqHplM848DRfNOahgozATyfKutZoZXvDrqUek4HYMlUero0B9WebCFV
 3dwh5unKwJgUoPE7hOBJFzpocG+w6JCcxpigmz0ir2ZvK1xSptxbsmdBKt/LheH2XP+v
 R0lNVCOID7VCQJ7YuEvHY+NyUaWraVcGbcgNsgUoXQSCwNIzaBYIQ8xejNF5g2bcArYQ
 wsV2VMsM9zieC84f5+esPg28/kWzcI5QZg4psZTpjl7IzgxJLx4ImMyVeD6sfP3uUgyr
 NtGQ==
X-Gm-Message-State: AOJu0YxsO+1EOeeD2GD+hizZ3y3cjkZGkHZabX0tWs0dLNYEo70Mz7iL
 ugJ9AeJdiGHktLNaJTky3MEDXZW/Ieu2O+ngWryTwPJda1taHtYQLZT3hdQdRzQ0r+P2fFsgWQp
 BxdU=
X-Google-Smtp-Source: AGHT+IFkxB0eObbzUmDdMk7n4oHb9c6UmFKkOHtFlLVrwZMbgS3KsF1U4a6gFND4BqKzngzgGvXWGg==
X-Received: by 2002:adf:e390:0:b0:367:33b1:e82b with SMTP id
 ffacd0b85a97d-36733b1e8b7mr2566041f8f.68.1719506060714; 
 Thu, 27 Jun 2024 09:34:20 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367435852fesm2368830f8f.56.2024.06.27.09.34.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:34:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2 1/7] hw/sd/sdcard: Introduce sd_cmd_to_receivingdata /
 sd_generic_write_byte
Date: Thu, 27 Jun 2024 18:33:57 +0200
Message-ID: <20240627163403.81220-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627163403.81220-1-philmd@linaro.org>
References: <20240627163403.81220-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

All commands switching from TRANSFER state to (receiving)DATA
do the same: receive stream of data from the DAT lines. Instead
of duplicating the same code many times, introduce 2 helpers:
- sd_cmd_to_receivingdata() on the I/O line setup the data to
  be received on the data[] buffer,
- sd_generic_write_byte() on the DAT lines to push the data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index cd308e9a89..690a3f275e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1100,6 +1100,22 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+/* Configure fields for following sd_generic_write_byte() calls */
+__attribute__((unused))
+static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
+                                             uint64_t start, size_t size)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    sd->state = sd_receivingdata_state;
+    sd->data_start = start;
+    sd->data_offset = 0;
+    /* sd->data[] used as receive buffer */
+    sd->data_size = size ?: sizeof(sd->data);
+    return sd_r1;
+}
+
 /* Configure fields for following sd_generic_read_byte() calls */
 static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
                                            uint64_t start,
@@ -1953,6 +1969,19 @@ send_response:
     return rsplen;
 }
 
+/* Return true if buffer is consumed. Configured by sd_cmd_to_receivingdata() */
+__attribute__((unused))
+static bool sd_generic_write_byte(SDState *sd, uint8_t value)
+{
+    sd->data[sd->data_offset] = value;
+
+    if (++sd->data_offset >= sd->data_size) {
+        sd->state = sd_transfer_state;
+        return true;
+    }
+    return false;
+}
+
 /* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
 static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
 {
-- 
2.41.0


