Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D70EDA6B2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 17:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxTX1-0007h3-TL; Tue, 03 Mar 2026 12:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxTWr-0007fO-2j
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:27:31 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxTWn-0004Kj-V9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:27:28 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-483bd7354efso78693845e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 09:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772558841; x=1773163641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mwLvQGHgXGM1rvifsMff8ixiuGcvGo9Ki/3I2UOm1yg=;
 b=cEtZBZfQ55bFiDdLNT7ZDwZQB+YeFDByqNBbXMBL8GbqrCIgpq2DvWln6h52fcwyKG
 dwFyOQNsTSbKA/XP8tlc2tp8s2lGAOLeRdud5m8kGKGJFXTChJyJ1Szy3lWF8j4rIZEG
 IXuKEvFQD9Exy+UMYPmTGxlNj+imFen9YyO5asYdP6MX+23V0nql57ABiTC4/s1scPNk
 TvEFN0nOAJzgdCJ8G1LfAKcJImEv09qjvOYlLw753UinBTu60ufwfDdt/oTkYxiIbO41
 hbbTSwnWNygZtJP12aJwJEp2H2X+0EjJR0yjfYrt9uOOfC5/y5tDYfwWgHrDjSrBYtjk
 Xlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772558841; x=1773163641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwLvQGHgXGM1rvifsMff8ixiuGcvGo9Ki/3I2UOm1yg=;
 b=YtXTQuM9LyWA1G+BI8bqckNM+tCUuLUQQdt3CTAADu8Mc6PyicwSHtUvmBuXeAwXeB
 CN5xXyVDb2be2sTTi45Uts8bWUDUBagI90gRdOG2P9G9wWsUTuN81luB/C80iyK26fWY
 YzbJZTrxM18aoNw4JM9TVghjt7mm9zeJquz4Y+HTugUScXbcQ+Fvi2IJtofO+MtYyoEa
 3fYdgSDFzlELmfYvCYhkPEtTBRoq3sSQf6ipugWJz2J8Ry4w38Z+JMdiuYg5fmyxCwQW
 QXCdZM9eIjFiZNNuku2eYUoqhKXpkCpqo7ZgojnbP5xk9LGFkMBt56RIDLpVRIcCFylg
 QW8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQEB3gutkdBoBlbmh2dPvf3AeInVWrNJXJ+D5zYavVhIFqojoLPFwd+F77UOVKXnNU1l9NYza4knVA@nongnu.org
X-Gm-Message-State: AOJu0YyC5PXHr7W3xMxR5BAdMfTJgCWX5VVajzvyCbfU+RaExff9dSb1
 ySZEE5i0iuBwsb2pd/agR+bsqmbA46MWLJFNw6z9thg2S+LE+CFmX+HaxuCmzrcENG4=
X-Gm-Gg: ATEYQzx3L1rEQ+QRHvgvQLkn/tWUFAfhK2Nk6txDGK2wkJ8nXztYcGL4SlCGmZSO6pE
 uJuahPIh1Zyd4xfRwl6jS5JFhuUpO8bgt/Sy7pJI6OwSQzJD2kfJxKUe9bKSqENcm6kg+mUevJ2
 kI0mYrvZuUE5yMpC8gV2yeeRKS1MWBTz5LoKVEbo4S4Qu3jUL17BBh2LKYPNsV2DtIiSyRpP5Qt
 297VIcFMqiiVQojtT2Afa7dJep95gp8yrx1QVZvJr2anDoPn2eX2tVtg0yBcU/RgLnfBNrfhwmB
 mz3BVoN+ly++cogouJjOAWw6JuVZIIPbCXWtdpiZXQQA+Shbujl+0U7/7OxOotrBJCyyg+Xdalq
 RV52xENabOOy70Z/Hdca6ZFhyfblFV8t8ic4K7QGiDIxZ76HtGFjEvhxDI0jzLDBHexSljdpzgV
 UCOki60BJCZ2YPZwS7CYXS1iO3kqImBiVmGmM7ZM2Db0vb/G0RLeoSghMZUiKx5zETM37Bko2kS
 kazg1pulDHgybG/+INxMejQqPWuqQk=
X-Received: by 2002:a05:600c:8106:b0:483:badb:618e with SMTP id
 5b1f17b1804b1-483c9b9e39dmr271918715e9.8.1772558840497; 
 Tue, 03 Mar 2026 09:27:20 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd7507adsm536539465e9.9.2026.03.03.09.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 09:27:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH] hw/net/xilinx_ethlite: Check for oversized TX packets
Date: Tue,  3 Mar 2026 17:27:18 +0000
Message-ID: <20260303172718.437015-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The xilinx_ethlite network device wasn't checking that the TX packet
size set by the guest was within the size of its dual port RAM, with
the effect that the guest could get it to read off the end of the RAM
block.

Check the length.  There is no provision in this very simple device
for reporting errors, so as with various RX errors we just report via
tracepoint.

This lack of length check has been present since the device was first
introduced, though the code implementing the tx path has changed
somewhat since then.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3317
Fixes: b43848a1005ce ("xilinx: Add ethlite emulation")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/trace-events     |  1 +
 hw/net/xilinx_ethlite.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/net/trace-events b/hw/net/trace-events
index 23efa91d05..001a20b0e2 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -527,3 +527,4 @@ xen_netdev_rx(int dev, int idx, int status, int flags) "vif%u idx %d status %d f
 # xilinx_ethlite.c
 ethlite_pkt_lost(uint32_t rx_ctrl) "rx_ctrl:0x%" PRIx32
 ethlite_pkt_size_too_big(uint64_t size) "size:0x%" PRIx64
+ethlite_pkt_tx_size_too_big(uint64_t size) "size:0x%" PRIx64
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index ba3acd4c77..75e6520569 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -162,9 +162,15 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
         break;
     case TX_CTRL:
         if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
-            qemu_send_packet(qemu_get_queue(s->nic),
-                             txbuf_ptr(s, port_index),
-                             s->port[port_index].reg.tx_len);
+            uint32_t size = s->port[port_index].reg.tx_len;
+
+            if (size >= BUFSZ_MAX) {
+                trace_ethlite_pkt_tx_size_too_big(size);
+            } else {
+                qemu_send_packet(qemu_get_queue(s->nic),
+                                 txbuf_ptr(s, port_index),
+                                 size);
+            }
             if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
                 eth_pulse_irq(s);
             }
-- 
2.43.0


