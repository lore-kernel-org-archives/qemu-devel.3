Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5011C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag4F-0006Fk-KC; Thu, 15 Feb 2024 13:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag4C-0005kh-F9
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:02:36 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag40-0002mF-SZ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:02:36 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-411fc50e4e9so9097455e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020143; x=1708624943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YTTtBw/s0faU+3j1Lg8q8e01VXsKvPyBNLyd6bIBBuE=;
 b=SlgQmDBAoOSWuzi8AtiCigGdia1KyzLMo5oeKHGp2I+k6boOX3Q/oT/4K+MQJcuO1v
 R8u/S57/Su5Ukxy+YQsJWXjPJIPAYu4hV4d5DH+gBCKj0Y4fXaluLxsHyXnATBfl2X7Y
 q1a4k0TEqtnBRUewtDYXMSdZlFumLacCsXGBR+Td+zMzy8ST8qlyUjPvop+CgCXApWf3
 6dNV0Fjw1jwaKsEyRoQEZoAyZIanQMhvND0fJ6xsP537L0uY1GBs2ayGD9JVEvv+uU7L
 6+jQpn75BcP8NMWViKfSd1d9dAV3IjfwdXDjc+glwyPVRAQ0uTp5oJfFEnvaUcX3FA+s
 YeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020143; x=1708624943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YTTtBw/s0faU+3j1Lg8q8e01VXsKvPyBNLyd6bIBBuE=;
 b=p9p7lrYaksoJWYsrFt1Zha2LR/c+qBHv2JCUI4JR7yqIxSsb3DA7fhxiU/R58KPNzK
 6XD+z3pNmtSMVc0Wd9ski27JmVX1GSIebnKTB++aYpVp3NXYVYwUCuR+YrpJK/ztUImI
 69xh5ayEPcJPxstQGRmZrT5TkX8b+heNahDAlbdnSxLLENHr9taLjB3NByWLAyd3MBQK
 jqDsIsXZv02RqQ3vp7MRx0ZKb1NrwbN7DyD/g/oJhz10pEvk6wrva0rvWPzbiC6S7Y6q
 vFnvSpznxz4/LPSYXRSW7HngKzPxvEvjUzh9tjJ5Zs90np71Xw51AOx0hj98oSbfIe+y
 ACgA==
X-Gm-Message-State: AOJu0YxmD6L60Wb/v+5PdujmyrjR+P314vr40AhnVUTxDhnRZREbu8e4
 Wj0hTGpKVYuhTzGtj/Vu2kVuz5Q6hQUWYTvjZX9ef26Ulk3AznkfpWCPvdzu+aVVUmxPsz4SaTB
 djlo=
X-Google-Smtp-Source: AGHT+IGTR+UWn/qltdlWZXNXNx+q5qZQ1+YpHZfUApa74kUeBrzwKQht2TqeAszYcOEtq0P/lE/xfA==
X-Received: by 2002:a05:600c:6008:b0:410:c127:62fe with SMTP id
 az8-20020a05600c600800b00410c12762femr2036267wmb.1.1708020143112; 
 Thu, 15 Feb 2024 10:02:23 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a5d67d2000000b0033cf0f5a01fsm2390836wrw.33.2024.02.15.10.02.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:02:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 40/56] hw/sparc/leon3: check cpu_id in the tiny bootloader
Date: Thu, 15 Feb 2024 18:57:34 +0100
Message-ID: <20240215175752.82828-41-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Clément Chigot <chigot@adacore.com>

Now that SMP is possible, the asr17 must be checked in the little boot
code or the secondary CPU will reinitialize the Timer and the Uart.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240131085047.18458-9-chigot@adacore.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/leon3.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 1637900162..bea84f3ad6 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -99,12 +99,26 @@ static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
 
 /*
  * When loading a kernel in RAM the machine is expected to be in a different
- * state (eg: initialized by the bootloader). This little code reproduces
- * this behavior.
+ * state (eg: initialized by the bootloader).  This little code reproduces
+ * this behavior.  Also this code can be executed by the secondary cpus as
+ * well since it looks at the %asr17 register before doing any
+ * initialization, it allows to use the same reset address for all the
+ * cpus.
  */
 static void write_bootloader(void *ptr, hwaddr kernel_addr)
 {
     uint32_t *p = ptr;
+    uint32_t *sec_cpu_branch_p = NULL;
+
+    /* If we are running on a secondary CPU, jump directly to the kernel.  */
+
+    stl_p(p++, 0x85444000); /* rd %asr17, %g2      */
+    stl_p(p++, 0x8530a01c); /* srl  %g2, 0x1c, %g2 */
+    stl_p(p++, 0x80908000); /* tst  %g2            */
+    /* Filled below.  */
+    sec_cpu_branch_p = p;
+    stl_p(p++, 0x0BADC0DE); /* bne xxx             */
+    stl_p(p++, 0x01000000); /* nop */
 
     /* Initialize the UARTs                                        */
     /* *UART_CONTROL = UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
@@ -118,6 +132,10 @@ static void write_bootloader(void *ptr, hwaddr kernel_addr)
     /* *GPTIMER0_CONFIG = GPTIMER_ENABLE | GPTIMER_RESTART;        */
     p = gen_store_u32(p, 0x80000318, 3);
 
+    /* Now, the relative branch above can be computed.  */
+    stl_p(sec_cpu_branch_p, 0x12800000
+          + (p - sec_cpu_branch_p));
+
     /* JUMP to the entry point                                     */
     stl_p(p++, 0x82100000); /* mov %g0, %g1 */
     stl_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
-- 
2.41.0


