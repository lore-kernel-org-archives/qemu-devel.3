Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECE1606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=dsouWETz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp6C-0003GU-0m; Fri, 27 Nov 2026 01:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp3x-0005mg-70; Fri, 27 Nov 2026 01:04:03 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp3u-0003bS-T3; Fri, 27 Nov 2026 01:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759041; bh=/QLuDRg3OdUo/JRVq5JXXvkJ8GrqRIvir4TdTLIUqGs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dsouWETzZFGCIdJDYVF7B9pfm8lRAmmr62pQg/Fm9a2tJb2cUbFGYk2gldMi+DCuP
 sVzf+VrrnbKUIWo3isTJ2oAgv8HFEVHnZcLf44ARkqR4QheYcQ8JhXfO/tTi2A02Au
 btBwgpFOIkbvUAitOcaN99uo5hW/KANH7F1bYcrCg2KbyGw/IgOQOp//k7UWGRCvSK
 KlrdfcXptIdQZlAkdgcsGPDmJH2Koujqng8mYr9IxuWKR39hrT4LiCsZlfl4inyxqr
 h8DU8R9oUv+WPLnYkbz6Po7oankgPhuKQ1WdoNNJKEYsH3uQXjR/WH1fPeaWzlVGR2
 ZGo62lkkf+UxA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9FAEA1EA340;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9D95B46996C;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 79646CF2D0; Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 079/152] hw/net/net_rx_pkt: Check for overflow in
 _net_rx_pkt_calc_l4_csum()
Date: Fri, 27 Nov 2026 08:53:37 +0300
Message-ID: <20261127055709.39630-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

In _net_rx_pkt_calc_l4_csum() we calculate the number of bytes to run
the checksum over by subtracting the IP header length from the total
IP packet size.  This shouldn't underflow if other parts of the code
have been correctly checking and calculating sizes and offsets, but
for defence in depth check here, and don't checksum any bytes if we
would otherwise underflow.

Cc: qemu-stable@nongnu.org
Fixes: eb700029c783 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-14-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit e4236a7e877be37a676680788dbce72a66eb4307)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 03a35f03154..110496e9c81 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -501,8 +501,10 @@ _net_rx_pkt_calc_l4_csum(struct NetRxPkt *pkt)
             csl = be16_to_cpu(pkt->l4hdr_info.hdr.udp.uh_ulen);
             trace_net_rx_pkt_l4_csum_calc_ip4_udp();
         } else {
-            csl = be16_to_cpu(pkt->ip4hdr_info.ip4_hdr.ip_len) -
-                  IP_HDR_GET_LEN(&pkt->ip4hdr_info.ip4_hdr);
+            uint16_t iplen = be16_to_cpu(pkt->ip4hdr_info.ip4_hdr.ip_len);
+            uint16_t iphdr_len = IP_HDR_GET_LEN(&pkt->ip4hdr_info.ip4_hdr);
+
+            csl = (iplen >= iphdr_len) ? (iplen - iphdr_len) : 0;
             trace_net_rx_pkt_l4_csum_calc_ip4_tcp();
         }
 
@@ -517,9 +519,9 @@ _net_rx_pkt_calc_l4_csum(struct NetRxPkt *pkt)
             struct ip6_header *ip6hdr = &pkt->ip6hdr_info.ip6_hdr;
             size_t full_ip6hdr_len = pkt->l4hdr_off - pkt->l3hdr_off;
             size_t ip6opts_len = full_ip6hdr_len - sizeof(struct ip6_header);
+            uint16_t plen = be16_to_cpu(ip6hdr->ip6_ctlun.ip6_un1.ip6_un1_plen);
 
-            csl = be16_to_cpu(ip6hdr->ip6_ctlun.ip6_un1.ip6_un1_plen) -
-                  ip6opts_len;
+            csl = (plen >= ip6opts_len) ? (plen - ip6opts_len) : 0;
             trace_net_rx_pkt_l4_csum_calc_ip6_tcp();
         }
 
-- 
2.47.3


