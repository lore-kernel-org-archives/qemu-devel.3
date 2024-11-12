Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA12D42BBA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvMK-00050w-GH; Tue, 12 Nov 2024 13:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvM7-0004xB-Rj
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:13 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvM2-0001sj-Sw
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:10 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539f72c913aso10478719e87.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435063; x=1732039863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQmPPVoGs75Oc0X7p2l9C1PUIeVlzMNRobjeBMri9rg=;
 b=Bkuy9+OPXMZT9cbrByOma1Ovv+5ysola10Jw57nqWV/59MX5oTDfkNHRdn1E+kVNLx
 FWRsYbOqaMnYaSxYg/athElhWxfT7fvNCdzQqtMyM7WptTXoKHgnxVb9Xno4cJDJ8GQx
 vLXxkLUsAV0DEz0++rWJnHXteX2V4wvO1In+6Gb/1j9NGwdXU0xFObPd+eHnJ2pSXYKi
 u1BE7u5oKPCqikc1mHHZNhtAFSszUeeP6jCwMekcaru3/XZC8PP/VQbG6rG1ZJS5uDHU
 lvo6wSyVx/R3dJBmIsRgEDCOBftewe/Mx5TLntrPwwzb5xeI3rtXsXHKiTMWVWp/puRp
 57bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435063; x=1732039863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQmPPVoGs75Oc0X7p2l9C1PUIeVlzMNRobjeBMri9rg=;
 b=KwozNpoEABOsWw6nAupyn0oyZ8gn4Yy77dJJkH2974x6yYWld+aE1+PTPFyahGYRWY
 l3gDAWXN2ilACgeMnDxJaKSWsVHuHHnC7LtDdH4zazQHwAZEy9MJ5yi5azo4f4/Gzhkq
 XPnH004/S8zsBoYqeBg94TJETgAPUiiVK49heLIKsg05qw0hQ9z0JVSo5UrPHbBLVSYL
 VpwFzR4GHpWJHrvSP5dqyqOowdqTjcAuQ+gX5X0GJL9S+Y5hexlbzFe74VNEzYrjubS/
 eSyJ2tzJNUUQRsaDXdOGf+KrK2eVXLyFv4fhXrhgBtq5zZ3iCMgzHxYAtL8HgSYaCSAm
 B3AQ==
X-Gm-Message-State: AOJu0Yyk7nb3ysU1f/cuiWCldXwrRLzFq1Dj97NoKcjC/uZB8xd+NVsw
 az4PKv225XicJ0pnOFvKDBzOAPBotlNxaugCB4FdH19S7X2jEkIdfiuoedJNr2DaRp73RzhcKm8
 3
X-Google-Smtp-Source: AGHT+IFZWKbdEW9hPzJFEVzeUgKYL+XJ6A+Y/g4rxQpqBUcX/s3/vMv6nOdTkznz39rzBBl5m4Alig==
X-Received: by 2002:a05:6512:1042:b0:539:e60a:6dd0 with SMTP id
 2adb3069b0e04-53d862f8170mr8876660e87.51.1731435061922; 
 Tue, 12 Nov 2024 10:11:01 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa737c86sm262860325e9.38.2024.11.12.10.10.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:11:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/20] hw/net/xilinx_ethlite: Convert some debug logs to trace
 events
Date: Tue, 12 Nov 2024 19:10:26 +0100
Message-ID: <20241112181044.92193-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 5 +++--
 hw/net/trace-events     | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index e84b4cdd35..bb330a233f 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -30,6 +30,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "net/net.h"
+#include "trace.h"
 
 #define D(x)
 #define R_TX_BUF0     0
@@ -198,13 +199,13 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
         return size;
 
     if (s->regs[rxbase + R_RX_CTRL0] & CTRL_S) {
-        D(qemu_log("ethlite lost packet %x\n", s->regs[R_RX_CTRL0]));
+        trace_ethlite_pkt_lost(s->regs[R_RX_CTRL0]);
         return -1;
     }
 
     D(qemu_log("%s %zd rxbase=%x\n", __func__, size, rxbase));
     if (size > (R_MAX - R_RX_BUF0 - rxbase) * 4) {
-        D(qemu_log("ethlite packet is too big, size=%x\n", size));
+        trace_ethlite_pkt_size_too_big(size);
         return -1;
     }
     memcpy(&s->regs[rxbase + R_RX_BUF0], buf, size);
diff --git a/hw/net/trace-events b/hw/net/trace-events
index d0f1d8c0fb..2b36cd967e 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -511,3 +511,7 @@ xen_netdev_connect(int dev, unsigned int tx, unsigned int rx, int port) "vif%u t
 xen_netdev_frontend_changed(const char *dev, int state) "vif%s state %d"
 xen_netdev_tx(int dev, int ref, int off, int len, unsigned int flags, const char *c, const char *d, const char *m, const char *e) "vif%u ref %u off %u len %u flags 0x%x%s%s%s%s"
 xen_netdev_rx(int dev, int idx, int status, int flags) "vif%u idx %d status %d flags 0x%x"
+
+# xilinx_ethlite.c
+ethlite_pkt_lost(uint32_t rx_ctrl) "rx_ctrl:0x%" PRIx32
+ethlite_pkt_size_too_big(uint64_t size) "size:0x%" PRIx64
-- 
2.45.2


