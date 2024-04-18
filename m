Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DD8C04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVvQ-0003Nw-96; Thu, 18 Apr 2024 13:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVvB-0002s3-VS; Thu, 18 Apr 2024 13:51:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVv9-0007gi-WB; Thu, 18 Apr 2024 13:51:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A0A825FD76;
 Thu, 18 Apr 2024 20:50:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DE7F2B9350;
 Thu, 18 Apr 2024 20:50:01 +0300 (MSK)
Received: (nullmailer pid 947869 invoked by uid 1000);
 Thu, 18 Apr 2024 17:49:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 109/116] hw/net/net_tx_pkt: Fix overrun in
 update_sctp_checksum()
Date: Thu, 18 Apr 2024 20:49:39 +0300
Message-Id: <20240418174955.947730-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

If a fragmented packet size is too short, do not try to
calculate its checksum.

Reproduced using:

  $ cat << EOF | qemu-system-i386 -display none -nodefaults \
                                  -machine q35,accel=qtest -m 32M \
                                  -device igb,netdev=net0 \
                                  -netdev user,id=net0 \
                                  -qtest stdio
  outl 0xcf8 0x80000810
  outl 0xcfc 0xe0000000
  outl 0xcf8 0x80000804
  outw 0xcfc 0x06
  write 0xe0000403 0x1 0x02
  writel 0xe0003808 0xffffffff
  write 0xe000381a 0x1 0x5b
  write 0xe000381b 0x1 0x00
  EOF
  Assertion failed: (offset == 0), function iov_from_buf_full, file util/iov.c, line 39.
  #1 0x5575e81e952a in iov_from_buf_full qemu/util/iov.c:39:5
  #2 0x5575e6500768 in net_tx_pkt_update_sctp_checksum qemu/hw/net/net_tx_pkt.c:144:9
  #3 0x5575e659f3e1 in igb_setup_tx_offloads qemu/hw/net/igb_core.c:478:11
  #4 0x5575e659f3e1 in igb_tx_pkt_send qemu/hw/net/igb_core.c:552:10
  #5 0x5575e659f3e1 in igb_process_tx_desc qemu/hw/net/igb_core.c:671:17
  #6 0x5575e659f3e1 in igb_start_xmit qemu/hw/net/igb_core.c:903:9
  #7 0x5575e659f3e1 in igb_set_tdt qemu/hw/net/igb_core.c:2812:5
  #8 0x5575e657d6a4 in igb_core_write qemu/hw/net/igb_core.c:4248:9

Fixes: CVE-2024-3567
Cc: qemu-stable@nongnu.org
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Fixes: f199b13bc1 ("igb: Implement Tx SCTP CSO")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2273
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20240410070459.49112-1-philmd@linaro.org>
(cherry picked from commit 83ddb3dbba2ee0f1767442ae6ee665058aeb1093)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 2134a18c4c..b7b1de816d 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -141,6 +141,10 @@ bool net_tx_pkt_update_sctp_checksum(struct NetTxPkt *pkt)
     uint32_t csum = 0;
     struct iovec *pl_start_frag = pkt->vec + NET_TX_PKT_PL_START_FRAG;
 
+    if (iov_size(pl_start_frag, pkt->payload_frags) < 8 + sizeof(csum)) {
+        return false;
+    }
+
     if (iov_from_buf(pl_start_frag, pkt->payload_frags, 8, &csum, sizeof(csum)) < sizeof(csum)) {
         return false;
     }
-- 
2.39.2


