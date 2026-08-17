Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE22FC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxXo-0000F8-9K; Mon, 17 Aug 2026 09:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxXg-00005X-90; Mon, 17 Aug 2026 09:38:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxXX-0007nR-Qc; Mon, 17 Aug 2026 09:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=rp0p3iY+Ku8LqX8xQ3qYpHcclVyy3d/xRLLFHtPnfzw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vt+EiyTcA+FniHVLzbFP9KuS5pe3/15PAYJVmLQwbKnUXedAhFRDhbWZ9Y0DV+dbp
 0RobJijJR5gfkvHDSJB6B2HjpCPFjNYuDCQ6qwix4ufw6SjZMwtT0bLtdobWDmrrZI
 UdjlFUbzIhFQn56zde+pnL9RZBwTZnNSFZ6wbPWmwCsfQp6xP8/Vl7fyozsLJUsGTC
 A8ufsLhTsEtAgMe/AI/yWLDby1LHhjBklSzxLp5OgZ6u4vE8geCWWkIx/NaaEkH2lk
 3FvufIcMAAVPSAx9LVh7Zm91KwhxBf00/wnCGl3Z87I4B0JLn2ZeDKFakIShTMm112
 q+5kpPYrlqcXw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9024D1CBCD3;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CB05240D430;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DF5E630FB0; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v2 132/135] hw/net/rtl8139: Send whole of vlan-tagged
 packet when doing loopback
Date: Mon, 17 Aug 2026 16:34:42 +0300
Message-ID: <20260817133451.2384630-30-mjt@tls.msk.ru>
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

In rtl8139_transfer_frame(), if we are transmitting a frame over
loopback then we do this by calling qemu_receive_packet().  If we
have an iovec rather than a simple buffer (which happens only when
we're sending a packet where we are inserting a vlan tag), we have to
convert this into a simple buffer first using iov_to_buf().  However,
when we do this we forget to also update the 'size' local variable to
the size of the new simple buffer, so we will truncate the packet by
4 bytes (the size of the vlan tag).

Correct the logic so we don't truncate vlan-tagged packets when
sending them over loopback.

Cc: qemu-stable@nongnu.org
Reported-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Message-ID: <20260731093618.2961031-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit f3a10c1c454789ad6bb0633118019f4c6544b4b3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index e00201991ae..4936dc0b82c 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -1772,6 +1772,7 @@ static void rtl8139_transfer_frame(RTL8139State *s, uint8_t *buf, int size,
             buf2 = g_malloc(buf2_size);
             iov_to_buf(iov, 3, 0, buf2, buf2_size);
             buf = buf2;
+            size = buf2_size;
         }
 
         DPRINTF("+++ transmit loopback mode\n");
-- 
2.47.3


