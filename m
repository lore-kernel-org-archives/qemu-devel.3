Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FA7D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBfCB-0004ST-9a; Thu, 14 Nov 2024 14:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBfC8-0004LR-W3
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:07:57 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBfC7-0005XY-Gk
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:07:56 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so8346775e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731611269; x=1732216069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YlgtA2w+nkGpq6odlZPv7GuJkitbYlthMfvxp2Wzgbg=;
 b=dY+g/+42FyI0V6lVWCXfLwHUKYLu8J3Smt++UxBb/z3g4eLRnas8+gYBbs43NvmZ41
 Yd3WOai3BCARrmgp+MdAaGmLVlF+NJBSujO/pjMtym8IN9vSqoHffn7NdnY887x7CKkC
 C4J4AlOWust0O0zAzqDFxkXXRM8uZlyXPYGiXcaTSG3qdGPUQfSayXD5vD3CSCbZun9d
 zAcu+eHrKRqlM8/A0+CPUvWvHs4jYaIEeY7LsbH29RMiVeihEwLDlMhJe1tMUd1VRaNL
 WYQO5Fg7WZMSU1Kah5stgDOgAgifsCwTI+RNwHrFSbYGi02kG3XneUlFuHxWc1R4uwCd
 H7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731611269; x=1732216069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YlgtA2w+nkGpq6odlZPv7GuJkitbYlthMfvxp2Wzgbg=;
 b=vCk2sRmJuD/ID0/ZklxRlsyXAALcf06op4Gv7eJp9RRwE3yHQm0rYvj5t/HfIACYbL
 e8TZyAd0+iMMRRuMEELsW+ukuR/kJ8/2a+Qe73f4tE9SksiW1w5Wplqm8GUCwbyBYq9c
 RiMCaHCKsS8vPpayEUwjGYfvMR/XpipR4RrWCyvxHRC4Ecthf0FF5DXMLoVVu02vof/J
 k1kRrdMnhXzJs+63bsaWzEab68y/fljcgMHeFi57H8RHypKemjdGRprZb36d1IinXQ06
 puwJGrFc7+7/qFddXtQ7rYrWhagS6z/nsDBZpghIZPkh3Uo6d2EvKwzsPa7UQdYmFUNd
 BquA==
X-Gm-Message-State: AOJu0Yz985JgEQINdfGH3+zMHYEiJRzOfq6msIfXaCqUGN/aZXq5+Paa
 3/oBGzDNdb1u5DnNJj12ZDHRGkRHaVtNcReKzhz10KlFznhyybVddJ4leOOOUfMTVNt9Zb6oLu1
 o
X-Google-Smtp-Source: AGHT+IErhEi5rCCxsSEufjaHp4djjJhUu+iyugGyGhc+DCOVXT+2i8yDpwdwPIWNI9In4y5PTbtC8A==
X-Received: by 2002:a05:600c:5123:b0:42c:ae30:fc4d with SMTP id
 5b1f17b1804b1-432cce6805dmr97191465e9.7.1731611268857; 
 Thu, 14 Nov 2024 11:07:48 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab721efsm30627335e9.4.2024.11.14.11.07.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 11:07:48 -0800 (PST)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 02/19] hw/net/xilinx_ethlite: Convert some debug logs to
 trace events
Date: Thu, 14 Nov 2024 20:07:16 +0100
Message-ID: <20241114190733.33902-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114190733.33902-1-philmd@linaro.org>
References: <20241114190733.33902-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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


