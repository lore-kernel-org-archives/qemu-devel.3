Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EA1D2B920
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JFp-0002u1-TQ; Tue, 05 Nov 2024 08:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JFo-0002mJ-0i
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:05:52 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JFm-0002X5-Ad
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:05:51 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539ee1acb86so5437842e87.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730811948; x=1731416748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmQHqWTaQOMkWHXP0Jn/QpgcUfCH1B37UiHSpX6N2KA=;
 b=s5HPSlAwC2nA+to5RFYRJHwjdxqCcpkRZTt+rMvMVhefAgAA6uPMsU/1ILGUOCMtUL
 Sk4japgXgFTaW4BRSox/gTdrBSrXrn0iM3pFSrkrYlUjMLqk6VBjfFr2cX3ChPGLCDNk
 Uu2mUHdtrZvQhmshMSqJLQO9GMDHXwHbIdTR/EI9kQiN8x6bL+xHF7w5GuyQvvaOjAMw
 9Llwloovy8KhI7Fu8Ub71BH5Z/nmNllEZFjKvlliuLRePn0HwqrvKLLwup2Ck3FvlMhx
 2W8/o6fVYisL6Olt0uz0GYBxPmvmi4hR8aTaJV0YhTp6FURjybGWvW//u9Vi20Advcyq
 A54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811948; x=1731416748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmQHqWTaQOMkWHXP0Jn/QpgcUfCH1B37UiHSpX6N2KA=;
 b=W+CI1cfOBAyJXx5aw2ol/3jsyBlMcv6lh1RTKsT5IM9WG1OfMTQCfR5lT+szdQtHtY
 ykwKPhmxmUvQbNT++qRoqK5wacDaLGrTQWcmQKzb+cDKI90V0F6cydg52zijRHYnP9lN
 nKCfo24NanGSrz8iON8xmPGrlLXyUuXzr692RYL5MZPE59Z3D+9bQiHD4OMtZ+3NLq+b
 xR4NpfhaznWZRW63yHcA3nbQrybpzY7IvgcxdJLzlrnxGIOCqbkUiImXt3uH6gBEKpAF
 q2BnfU9MZhzjwi/4n2Cz4DQB1qpfb68/7tOdw/hLAHXrGs5GaCECQagpYDVdpiMMAas6
 5izA==
X-Gm-Message-State: AOJu0YyWsSJtuFrPyD7Qh5Nm22iPLNQmHpWgSBqUswmgQqT5PRR6PnSO
 XSgYSj5kbKSR+pObMMOoLSgMYw6olC14evhmoluKjsOXJM/3KJ0ExreD9AJoBsQBkLR4in7+EyS
 Lov4=
X-Google-Smtp-Source: AGHT+IF9LFFphDUgWLEt7s3C/xmfz8xwqCoBamUp4pLN6Hxf/UouJKv/9GK36kiEoganAkopqGhI5g==
X-Received: by 2002:a05:6512:10d1:b0:539:f10b:ff93 with SMTP id
 2adb3069b0e04-53d65df7cb4mr6726958e87.27.1730811948119; 
 Tue, 05 Nov 2024 05:05:48 -0800 (PST)
Received: from localhost.localdomain (86.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e528sm16313895f8f.78.2024.11.05.05.05.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 05:05:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/19] hw/microblaze: Restrict MemoryRegionOps are implemented
 as 32-bit
Date: Tue,  5 Nov 2024 14:04:19 +0100
Message-ID: <20241105130431.22564-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105130431.22564-1-philmd@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

All these MemoryRegionOps read() and write() handlers are
implemented expecting 32-bit accesses. Clarify that setting
.impl.min/max_access_size fields.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/xilinx_uartlite.c | 4 ++++
 hw/intc/xilinx_intc.c     | 4 ++++
 hw/net/xilinx_ethlite.c   | 4 ++++
 hw/timer/xilinx_timer.c   | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index a69ad769cc4..892efe81fee 100644
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
         .max_access_size = 4,
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 2b8246f6206..1762b34564e 100644
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
         .max_access_size = 4,
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 11eb53c4d60..ede7c172748 100644
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
         .max_access_size = 4,
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 0822345779c..28ac95edea1 100644
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
         .max_access_size = 4,
-- 
2.45.2


