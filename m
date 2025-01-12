Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AF2E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Hu-0007ot-2L; Sun, 12 Jan 2025 17:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Hs-0007mv-Et
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:28 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Hq-0006RV-Nd
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:27 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso1929149f8f.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720305; x=1737325105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKRlKfb7zopcYrD4FgGjVB3vpdu4ZxJ/hnGTdUI9hkE=;
 b=vXwUyyS8y728nz+0DTj1RhxAZimXUaPy1KM8CB7yzzjmf+0JNrdSJI7+X+f186Et+n
 0k1MJeLEKwbD+3iFxVjRoW5gb9XxwvhorLCtEDorjZoqCvQFetXXzMLtecBj/zE7bEle
 O2eDgmm6jXCtHDK6azTnkBwQKzVq7UNgw0fYM1bP3hjLn1s/kWvRLq6XCVRU8B1hFR28
 mReRYBF1ClHtN+V9dydTo5/kY9JexYiUynqvRi/tsTFSC/uZsbBXpZVOZfiHnEwWBiT0
 bU/BefdpnfKcHnooSfRwsV2sVIgScM8b855SUjQY+uEcRAmuxO+JjM5raV30kvGoRvxj
 W6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720305; x=1737325105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKRlKfb7zopcYrD4FgGjVB3vpdu4ZxJ/hnGTdUI9hkE=;
 b=kaGi+RK0aJKrsrPE+lHSMOUTTuj5yKAPu96Fg6PN3M5U2wSqxQhNicWVTovV5caL8Q
 WTYWV63eER9OAi2GuBxomT41XfrrTuV1VAIUIre3YmqjCjxAo/z2R1koscZ+fqAt7MmC
 hotXbwsm88EjmSRRdoUSiY9o1HnTlYB7AsM90pBy7MIJfHKYbF0eD94600sDZExm9yrV
 Vs2MJrMe3KdItSP/m1/YHk4jdu/UcBD4XlyRMvMQAcLJcFbj9AS4QlId+qXuAYB85wq9
 HZljJkBexMMlHjYbKA6JKdkf0I2U079p2zTyv/mzlMSjgW/YIBHvSjZ54lUsxEkDQBsM
 IIpA==
X-Gm-Message-State: AOJu0YydX8ENdJF+qEsFGZ2OXGi0y72nXOPzn9ItY/33JeKzN6FHxR7i
 TcKfHM5FK6EZqZFDgStGDnDRiW8FITwL0EWfGAwJ4/oKtnBJvHYDXKKAd8waKc5KW5b2Y2ifmLq
 kKi4=
X-Gm-Gg: ASbGncsWzLGUBibct9763I+8Thvpmr9vBvqLfEGFIazPm/jw/x1lfWG2whTLW8LBrF+
 HbUJGQIaBRhqC60iN75n8evfNKac70J1vg9d6FxOx5GLFZPf9QTWo6TA4/BdyUib6El29R6g3XP
 W/pFd4trR23eUVaU72fQM67H/j0jbRski78oFTsAC1c1rtKr3gy+aH1lYwQc8NYLSBG4RHu+Pip
 MnWEfAEdFngwKQ7T4iLSvKLgJ68TnEo2eddT5ccPcEDYUY8LkHzvJd8ALmKNbjwx8u8D7xIJ4HZ
 aEjBKy/Ub5M3uQjfkbpF4vSpyzThdZo=
X-Google-Smtp-Source: AGHT+IHkE8l34yvWCYpoqLhSd1ZOOIEx9VB/MdmEYcectpMdM+lYBelQHJZQ2agvqZkhe/h+cqm8pw==
X-Received: by 2002:a5d:64a1:0:b0:38a:4b8a:ffec with SMTP id
 ffacd0b85a97d-38a872ef24cmr16298372f8f.33.1736720304863; 
 Sun, 12 Jan 2025 14:18:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38d013sm10779861f8f.58.2025.01.12.14.18.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:18:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 11/49] hw/net/xilinx_ethlite: Access TX_GIE register for each
 port
Date: Sun, 12 Jan 2025 23:16:47 +0100
Message-ID: <20250112221726.30206-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Rather than accessing the registers within the mixed RAM/MMIO
region as indexed register, declare a per-port TX_GIE. This
will help to map the RAM as RAM (keeping MMIO as MMIO) in few
commits.

Previous s->regs[R_TX_GIE0] and s->regs[R_TX_GIE1] are now
unused. Not a concern, this array will soon disappear.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20241112181044.92193-13-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 67adecc0883..3252c9d508a 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -62,6 +62,8 @@
 
 typedef struct XlnxXpsEthLitePort {
     struct {
+        uint32_t tx_gie;
+
         uint32_t rx_ctrl;
     } reg;
 } XlnxXpsEthLitePort;
@@ -90,7 +92,7 @@ struct XlnxXpsEthLite
 static inline void eth_pulse_irq(XlnxXpsEthLite *s)
 {
     /* Only the first gie reg is active.  */
-    if (s->regs[R_TX_GIE0] & GIE_GIE) {
+    if (s->port[0].reg.tx_gie & GIE_GIE) {
         qemu_irq_pulse(s->irq);
     }
 }
@@ -126,6 +128,9 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
     switch (addr)
     {
         case R_TX_GIE0:
+            r = s->port[port_index].reg.tx_gie;
+            break;
+
         case R_TX_LEN0:
         case R_TX_LEN1:
         case R_TX_CTRL1:
@@ -190,10 +195,13 @@ eth_write(void *opaque, hwaddr addr,
 
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
2.47.1


