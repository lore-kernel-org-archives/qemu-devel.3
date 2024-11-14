Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DB8D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBfC6-0004GS-98; Thu, 14 Nov 2024 14:07:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBfBz-0004CD-2O
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:07:50 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBfBx-0005V9-0I
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:07:46 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4315839a7c9so8979345e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731611263; x=1732216063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxalhuJA3V9Mf8DxAADrs85j1mYwG4uCtR+wwxiXnFU=;
 b=Gq5FBebUOPzHyv/KQrMpEOOseclpPCN22l+fZU+ikZucZ+wahkibEqa9FVp/B7Jn54
 wq6MiF7Zg2uLyPnJLf11YmrZzPIYpBoHOTH6/INOy3aH/3iUetJ/GtAWa3m03MEDKWQZ
 A3rgdIBUqfRWeVVrWt+UxtnOgLQsb01LY8ZJZJZDWAeDXZf6Aa62KJ4N2HpCS4+rjl2e
 rzPJfJB6drqFUlVc6msPamBCKrFOUyxAjARgPtU28jWMNFsgONx5zD2VdU1397RRAURR
 qgoKpXCoz62atGTJ1yV0jOrLjzf4YU+TUdrVX+5LgA+C9YR0Hsk6Jm1siylbKkH/x6YT
 rUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731611263; x=1732216063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dxalhuJA3V9Mf8DxAADrs85j1mYwG4uCtR+wwxiXnFU=;
 b=hZJX8nBQGcG6E31rqgQ3zgeXojKnrYGZ6jRnrC9T7f59E9YfUOAuEp3tiz3dWj/qDg
 ZOt/OoxiapdIXi3AH/vkTx6oPbJUuOwCPuer2FadZYoPZgrg7ogxySEgFvkZOxp6tt4L
 ZjatEtWXDHuorFJMhrFzntERjwchMcPDbyABFEvZoUN2ug8qWB7BkWKQ5WFWk78YXkD4
 93m30G1+UY0GJ5/OSZDj8sDPYcPNrUepD63LHUnfCfyfgQJF+asd0IeijjN5xD9hK9IY
 dkHqVs/qziw+XEiS2vc4Vdlo8KOvjSSQSLobECLkKwxw2qcJeq+4zb79r1i95kEh3wpk
 30Mw==
X-Gm-Message-State: AOJu0YzF2ajgI2VbO3SHGPyR0es1roHR/l0ylfTB6eDMGzVluocZYvb/
 tdDKhDsd+hREhVr2k3XpD7hZabJmHQaHQc4ogXhng+JgcxYM4GLXDirPHyah7TYrLlpOEHqfT/l
 Y
X-Google-Smtp-Source: AGHT+IGG6YX5cfxscYC8Gqx9eDYO8xCkNLKrvqVHnBiuiWERHUfrvwB2To77JD5EQ3E4VRb29d7rTA==
X-Received: by 2002:a05:600c:3b82:b0:42c:bb10:7292 with SMTP id
 5b1f17b1804b1-432b74fc98cmr213441365e9.1.1731611263083; 
 Thu, 14 Nov 2024 11:07:43 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821e073e0asm1721415f8f.30.2024.11.14.11.07.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 11:07:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/19] hw/microblaze: Restrict MemoryRegionOps are
 implemented as 32-bit
Date: Thu, 14 Nov 2024 20:07:15 +0100
Message-ID: <20241114190733.33902-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114190733.33902-1-philmd@linaro.org>
References: <20241114190733.33902-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

All these MemoryRegionOps read() and write() handlers are
implemented expecting 32-bit accesses. Clarify that setting
.impl.min/max_access_size fields.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 hw/char/xilinx_uartlite.c | 4 ++++
 hw/intc/xilinx_intc.c     | 4 ++++
 hw/net/xilinx_ethlite.c   | 4 ++++
 hw/timer/xilinx_timer.c   | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index f325084f8b..3022b3d8ef 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -170,6 +170,10 @@ static const MemoryRegionOps uart_ops = {
     .read = uart_read,
     .write = uart_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 6e5012e66e..8fb6b4f1a5 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -144,6 +144,10 @@ static const MemoryRegionOps pic_ops = {
     .read = pic_read,
     .write = pic_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index bd81290808..e84b4cdd35 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -170,6 +170,10 @@ static const MemoryRegionOps eth_ops = {
     .read = eth_read,
     .write = eth_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 32a9df69e0..383fc8b3c8 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -193,6 +193,10 @@ static const MemoryRegionOps timer_ops = {
     .read = timer_read,
     .write = timer_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
-- 
2.45.2


