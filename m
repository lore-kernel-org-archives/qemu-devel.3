Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AFEE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSim0-0003Dm-PS; Tue, 31 Dec 2024 15:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSilz-00038R-AF
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:27 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSilx-0000s1-OB
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:27 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so102676625e9.1
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676604; x=1736281404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAtQI+p6Q7jzylh2/ogAG38eWfi5o3sJewecVz2TXgE=;
 b=lksDLVO8MMT2zdTou2LfD8DJx//bj3uL0V/ljn3CPhGdNd9ZEYsY7blc9bMKehGHoQ
 s1K/9KWiRmX2QWvT0kF8AZqTCLZ09JJzfrPz28FwrLDX0/wDyasfUjd2pMEuROKW0Uli
 MS87MDAaBF32jVdo2FZ/8LH0YMcShfzboPhV+hKFPQZ4Y6A1387F4DAmxktp0dMgdBt/
 FZeVi3V93rJiNY7h0js7rkuI9G35pXcN3oOxOQYAlkl/EApXiNi03aAVAt9XADX2UMZf
 2nY4Ds0S+kYlL11Xo17hJf2Gdv957u6T8legACLjtANcQMrcNf+kN0i1zI5/TzWVum4u
 y9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676604; x=1736281404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAtQI+p6Q7jzylh2/ogAG38eWfi5o3sJewecVz2TXgE=;
 b=O5lQKUeRITCIA95g2nAWv/HT7wFr9S9WX9ArrR0fm01Cq0i/4hKAsbZXIF/mHeNcOL
 ciV8lzXSy94TDcRkd3dlbA1UPNLm2lUeDfqUzqWMHr83F27RubzbRzfkxCoFlWNSAvg8
 Dc2NNbNeRcxhMG57gDeamhbjnoifw8vUcOilgLxJ+/CzY3oKdxAqxSso96S3/vyVX87K
 sfHwfjKd5wR6X3NfE53xEO9iyiAiAyGZ/RSBHKyoosu/EUgXgqBhRXj5E6C1k+Hpxak9
 bbauPantMvx3fmZ5lAJp5truAtm+PjiDIdXovk7Ob57QRm51yWiBxAufQCu/3L8bZ4Ov
 pLFw==
X-Gm-Message-State: AOJu0YyObfitvyTnvza/gN+rLK1HO/i/iTwCAb5ICyx75qPNQyk5TeHE
 i4vI6jpq1a4pHPxfukqIWBQpqWTlZGQQkFr1F/Us4+N1BQb2t1mtesjd/8XO19fiGFst8lxmTiC
 1UnA=
X-Gm-Gg: ASbGnctF6uio+mf4lwE42TJ4Y0qY2xsuPdjMJ6DDFSIRRqYDwqT7cvmUGhLsbInaG+L
 A5fQsWZc7N+eUsWQD3KjqC5L3y434qsmf33g5rRu3yybwqxEJ4ZI4iWHcLFmsX2xTim1RQlI/ZI
 wEIhomt81GMb5JRqs1yAlkaDWnVOsWwtLe2E8Je3EKOjKySJIR6ZEK9HQlJkVgRL4Qas1lIDbNN
 DVD8pOIi0rM1FTpglw/+Tu+1CxlmQYGLwUJAk+WH3wZ8nh0xOr4dm6BJ6ufYn2Yb1fF2WRVuSu+
 QK4NPcFuBgRQBfCtzHhK1WbATHbtS64=
X-Google-Smtp-Source: AGHT+IHWYRCxnw356VQ3cewjcT6+40YKbDQhbGP6HSUzP+qoMGmjlM1DU2CQL7oq0jBj05INisx44g==
X-Received: by 2002:a05:600c:4fd3:b0:436:5165:f1ec with SMTP id
 5b1f17b1804b1-43668b769f8mr360121505e9.30.1735676603868; 
 Tue, 31 Dec 2024 12:23:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656a0b361sm431655555e9.0.2024.12.31.12.23.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:23:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 11/29] hw/net/xilinx_ethlite: Convert some debug logs to trace
 events
Date: Tue, 31 Dec 2024 21:22:10 +0100
Message-ID: <20241231202228.28819-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20241112181044.92193-3-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 5 +++--
 hw/net/trace-events     | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index f3eb2af1934..c38a71c71be 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -30,6 +30,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "net/net.h"
+#include "trace.h"
 
 #define D(x)
 #define R_TX_BUF0     0
@@ -194,13 +195,13 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
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
index 6100ec324a7..c35bfb2eb8d 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -513,3 +513,7 @@ xen_netdev_connect(int dev, unsigned int tx, unsigned int rx, int port) "vif%u t
 xen_netdev_frontend_changed(const char *dev, int state) "vif%s state %d"
 xen_netdev_tx(int dev, int ref, int off, int len, unsigned int flags, const char *c, const char *d, const char *m, const char *e) "vif%u ref %u off %u len %u flags 0x%x%s%s%s%s"
 xen_netdev_rx(int dev, int idx, int status, int flags) "vif%u idx %d status %d flags 0x%x"
+
+# xilinx_ethlite.c
+ethlite_pkt_lost(uint32_t rx_ctrl) "rx_ctrl:0x%" PRIx32
+ethlite_pkt_size_too_big(uint64_t size) "size:0x%" PRIx64
-- 
2.47.1


