Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AAAC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxXo-0000Dz-0n; Mon, 17 Aug 2026 09:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxXe-00005M-Oh; Mon, 17 Aug 2026 09:38:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxXV-0007mp-Ie; Mon, 17 Aug 2026 09:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=o5SosBKHdHzyqQqD8OysfU0fn/md8/76TZPc1P04/7w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BmRO0UabGpe3Uh96UVKVljiG1EQUusvyNV0m/3C/peyMIibZ7rwyKvs4w6RMSsEy4
 uRex+G8MCq4OqdA1MUo3jKj2FFw0YaYBLHDzAJYdO2lhGXHBkxTc98RqjWcXWDJ73S
 DFNnVW+YxDQ0gqa7f4UDydSCH4pH5ozZRsPqvyP0kaVItblzN6CQvEQK2QMNzjuir2
 8SleORW5YSby4LNIpcrR3rMFRItvq4hSdhZRNaJnlPP+mv3voWyHNu206Jo+IRC5da
 Dx/zMahU8EiY+LEEOORnKnnAZKjuyWH6n8mDzICs+VDWlZHiOWlp5OqTtWIyK7dIcA
 Lgm52M1JQGXGw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8C1101CBCD2;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C5F8640D42F;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DC6B230FAE; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v2 131/135] hw/net/rtl8139: Fix handling of VLAN tags
 on incoming short packets
Date: Mon, 17 Aug 2026 16:34:41 +0300
Message-ID: <20260817133451.2384630-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

The rtl8139 receive code handles VLAN tags in incoming packets by
copying the VLAN tag to a special field in the receive descriptor,
and copying only the actual payload data to the receive buffer.  This
code tries to ensure that it pads out the payload to at least
MIN_BUF_SIZE bytes.

In commit 63b901bfd30 we removed the main "pad short frames" code
from this device because we switched to requiring net backends to do
the padding.  However we didn't notice that this broke the VLAN tag
handling, which relied on the old code making the buffer at least
MIN_BUF_SIZE + VLAN_HLEN bytes so that it could copy MIN_BUF_SIZE
bytes into the receive buffer even after removing the VLAN tag.  The
result is that the guest can make us read 4 bytes off the end of a
buffer by feeding itself a suitable short packet in loopback mode.

The old behaviour is actually not correct, because the IEEE802.1Q
standard says that the minimum ethernet frame size remains 64 bytes
including the 4 checksum bytes, and so when a tag is present the
payload data only needs to be 56 bytes.  (A bridge implementation can
choose to pad tagged frames out to 68 bytes, but it doesn't have to,
and so all devices have to correctly handle incoming tagged frames
that are 64 bytes long.)

The RTL8139 datasheet isn't very communicative on this topic, but
there's nothing that suggests it adds extra padding on receive that
didn't exist in the incoming packet.

Drop the last remnants of the padding handling from this device;
this avoids overcopying into the guest when we receive a short
VLAN tagged packet.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3518
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Message-ID: <20260731093618.2961031-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 59fc7b747d56652e09708adff3afaca326e85a2a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index fb78b1184f8..e00201991ae 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -777,7 +777,6 @@ static void rtl8139_write_buffer(RTL8139State *s, const void *buf, int size)
     s->RxBufAddr += size;
 }
 
-#define MIN_BUF_SIZE 60
 static inline dma_addr_t rtl8139_addr64(uint32_t low, uint32_t high)
 {
     return low | ((uint64_t)high << 32);
@@ -1005,10 +1004,6 @@ static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t
             lduw_be_p(&buf[ETH_ALEN * 2]) == ETH_P_VLAN) {
             dot1q_buf = &buf[ETH_ALEN * 2];
             size -= VLAN_HLEN;
-            /* if too small buffer, use the tailroom added duing expansion */
-            if (size < MIN_BUF_SIZE) {
-                size = MIN_BUF_SIZE;
-            }
 
             rxdw1 &= ~CP_RX_VLAN_TAG_MASK;
             /* BE + ~le_to_cpu()~ + cpu_to_le() = BE */
-- 
2.47.3


