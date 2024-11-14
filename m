Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B5FD6A22F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgyU-0001tz-Cy; Thu, 14 Nov 2024 16:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgy8-00010u-1m
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:01:38 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgy6-00084Z-GJ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:01:35 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso9152545e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618092; x=1732222892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0lO9X8AE/ryeO7HxuWic/CLRGMSwtdVOkVYKrQN4QhM=;
 b=uzW0K7gJAgWh3T1E18wJjujQuRgvut0dAt83GUssTjWJ9JmrGPpCKF3b/IAEGJhqnD
 eRx02FtOCbqlMNxneES+ne3xPmdQOkrTy91tnNDB6TY6Rwiq25Hagnj7zTJqroSz8q+S
 DTv2U0FrsPg6jvMFjhWf9povc3izq54z84MUV19PaelUICOpmmlEK8uvm7eWcLCfh1QF
 BiCCnw8VMaz8vers9M+rflg7vVrsyp7cSTP/1URWBNLfSfcIc94GXimyEdZE9ZeoB1kE
 aWHbPQwkyJwu+jDO7nD8SuSqcgQTVGMpn4Qr8TTYlD58GCVi1rm2EviKnmGYaJ3NIDzG
 8UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618092; x=1732222892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0lO9X8AE/ryeO7HxuWic/CLRGMSwtdVOkVYKrQN4QhM=;
 b=GrhRfEn4DDPQPqfp4hyWM4vdzwyynwvtpOynSDrbXHIGGh1vNVZh3O3RioHndoSFWf
 zaajJAwh9DfqWMMMg2DOgcTziL/AQH56tkpiBcSf54aa6GIOt0VUWDUkk7ctXPCstipr
 1Ys4CULeSDw3V076p9pjHbuxgPLEmAn5cs640J6DBYf6T7Sn5rsyJgz47rx/ZAHs5QFR
 OxIjMfVLbZKjyFUILl/YlWOE5sigoqIauUSjXt9Rgv/+3wrFLXbl7or64cAc1cWPwfo+
 6Tj6CNz/CwGXTCo4+E28lkyRHzC0jCCpBjp7LZHx8i7JFHKL+tX4Bt/0vD9CZ8xEG9k0
 droA==
X-Gm-Message-State: AOJu0YwZyPAJwrKjpLvsMFJR5hFRgx72ILpCgHueINSmAVOG+tjlEe6A
 YcPDpj9vgoCdLYxQNZVfe5GR1CAQX1zReU5D1BqZMkWBD+OnR3F4W6KUQZ4TIZrQCwHLIwiCVdl
 h
X-Google-Smtp-Source: AGHT+IHC9NpyJi99g2IKNwRVlNH17tvLjcA5E9fhfJrSPmvaFG9jczhzEWY1ylYQ0ZSVcIsgBgvhkA==
X-Received: by 2002:a05:600c:4589:b0:431:52cc:877e with SMTP id
 5b1f17b1804b1-432df77a843mr1346225e9.20.1731618091829; 
 Thu, 14 Nov 2024 13:01:31 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da244cb6sm36527525e9.0.2024.11.14.13.01.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 13:01:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Bernhard Beschow <shentey@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH RESEND v2 10/19] hw/net/xilinx_ethlite: Access TX_GIE register
 for each port
Date: Thu, 14 Nov 2024 22:00:01 +0100
Message-ID: <20241114210010.34502-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114210010.34502-1-philmd@linaro.org>
References: <20241114210010.34502-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Rather than accessing the registers within the mixed RAM/MMIO
region as indexed register, declare a per-port TX_GIE. This
will help to map the RAM as RAM (keeping MMIO as MMIO) in few
commits.

Previous s->regs[R_TX_GIE0] and s->regs[R_TX_GIE1] are now
unused. Not a concern, this array will soon disappear.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/net/xilinx_ethlite.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index a993cb8bb9..36ac8097af 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -63,6 +63,8 @@
 typedef struct XlnxXpsEthLitePort
 {
     struct {
+        uint32_t tx_gie;
+
         uint32_t rx_ctrl;
     } reg;
 } XlnxXpsEthLitePort;
@@ -91,7 +93,7 @@ struct XlnxXpsEthLite
 static inline void eth_pulse_irq(XlnxXpsEthLite *s)
 {
     /* Only the first gie reg is active.  */
-    if (s->regs[R_TX_GIE0] & GIE_GIE) {
+    if (s->port[0].reg.tx_gie & GIE_GIE) {
         qemu_irq_pulse(s->irq);
     }
 }
@@ -127,6 +129,9 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
     switch (addr)
     {
         case R_TX_GIE0:
+            r = s->port[port_index].reg.tx_gie;
+            break;
+
         case R_TX_LEN0:
         case R_TX_LEN1:
         case R_TX_CTRL1:
@@ -191,10 +196,13 @@ eth_write(void *opaque, hwaddr addr,
 
         case R_TX_LEN0:
         case R_TX_LEN1:
-        case R_TX_GIE0:
             s->regs[addr] = value;
             break;
 
+        case R_TX_GIE0:
+            s->port[port_index].reg.tx_gie = value;
+            break;
+
         default:
             s->regs[addr] = tswap32(value);
             break;
-- 
2.45.2


