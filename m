Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290D3C88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n4L-0001Q3-GX; Wed, 16 Sep 2026 06:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n3Q-0007Vb-0d; Wed, 16 Sep 2026 06:39:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n3M-00026U-GI; Wed, 16 Sep 2026 06:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789554957; bh=EiCjEHBu+hQ7AFPuyTbFuH1uiPdR0MhfuSL6H69evW0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=esiteBKQ78q0J9efnqfUkj9EwIJMaynHvblKGq6mxkLh0ZPyRywZmWMf/fn66tNxN
 slVXXsi8YHjkOw4uStnNYQ+VfutDj+FgMg0fdgvat/L80zeOdlvSTiKjCKck6VqMwD
 gr3D0QU8Il0sAAvcrFWtT/m1XEx0csrJb1xnK0GwBlP0IvmxRk3JMXmQb5Aj8awDqd
 u401SskazBAFKA0fQ/5oCjRQli5IFWV47eIIvHKE0SV3yN90+AIcEr045BhovrVeji
 LCC6+gFPwHOte9yp0+eo5+JZ1PasOmeIlcPCWIJyBUA3e3FIDHcFDxPBouEuTBPVgk
 E8qskEwsbH21Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D15291D5820;
 Wed, 16 Sep 2026 13:35:57 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9B5CF429F8E;
 Wed, 16 Sep 2026 13:36:40 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8FA8F5A835; Wed, 16 Sep 2026 13:36:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 42/56] hw/net/virtio-net: check packet size before
 VLAN tag access in receive_filter()
Date: Wed, 16 Sep 2026 13:36:00 +0300
Message-ID: <20260916103622.684817-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
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

From: Laurent Vivier <lvivier@redhat.com>

receive_filter() reads ptr[14..15] to extract the VLAN ID without
checking the packet is large enough. A short frame with VLAN TPID
at bytes 12-13 but no VLAN TCI causes a 2-byte out-of-bounds read.

Add size checks before accessing the Ethernet header and the VLAN
tag fields.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3788
Fixes: f21c0ed97c97 ("qemu:virtio-net: Add VLAN filtering (Alex Williamson)")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260722115008.1570510-1-lvivier@redhat.com>
(cherry picked from commit 5d85a09554fb66e18107cfbfa4e6b637bf4e2508)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 814b99a43d2..93653581cb6 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1750,12 +1750,16 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
     }
 
     ptr += n->host_hdr_len;
+    size -= n->host_hdr_len;
+
+    if (size < sizeof(struct eth_header)) {
+        return 0;
+    }
 
     if (!memcmp(&ptr[12], vlan, sizeof(vlan))) {
         int vid;
 
-        /* Truncated vlan packet */
-        if (size < n->host_hdr_len + 16) {
+        if (size < 16) {
             return 0;
         }
         vid = lduw_be_p(ptr + 14) & 0xfff;
-- 
2.47.3


