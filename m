Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4B5606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=NSMVufPs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHzT-0006zJ-Aw; Mon, 09 Nov 2026 00:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHzK-0006uj-R0; Mon, 09 Nov 2026 00:32:15 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHzG-0006HZ-JY; Mon, 09 Nov 2026 00:32:14 -0500
Received: from [10.42.0.1] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A95VLtc046789
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 9 Nov 2026 14:31:36 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=TfeHcxMmuRWst/+r/L4y9LOrxZi5hGJjWVr7etqScZg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1794202296; v=1;
 b=NSMVufPsNTxHsT1E/cSU2Uoq04vlx3tW3Yo1zCBCmbYxUxiRK4VDwPOJBCIhIaal
 4NbWOR3NVvgTVV76A4tCj0/hnKDzcmjr+YQwswYs/fQ858aHhQbXuEJ5zRI0ItZ0
 2Gt7cAmzax1rFzdCuj58B7cE5GJQd37bJBT2kvbdJ1+kHmvDAducO231Prj7Mcea
 U/sqQFCnWw+rYo5vpS+WmOtIv0bGM0FwnfoqqUw1yCL/S277IfW0eoh53hl9HqTZ
 d+7qFqwRniykD6RGdn9K8uHj29XxkNgurqLM8OfO7A4cEJe+bwju0LQl6LjzvddY
 +jkgsP+MS37rLHNc+ISKCA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 09 Nov 2026 14:23:59 +0900
Subject: [PATCH v2 14/14] hw/net/net_rx_pkt: Check for overflow in
 _net_rx_pkt_calc_l4_csum()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-eth-v2-14-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
References: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-stable@nongnu.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2198;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=SZZFJ0R3Dcjqw4IXPkP9KLwVZexxnp0/tEl0bNvcPvo=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bHqBXbfGc/XiXzZmVbT2+N5cngg/tZmU8dntzmoHSlL
 M3/P69MRykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwERU7zIyvE2YVnbv/vM7DV/l
 eybtrT1ytpth/bZzU/mO6ZpmBRVM28rwP3ifTqaJ+IQpZTx7H9kYZMzg2/vvysnonntOlUdv5Lu
 kMgMA
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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
---
 hw/net/net_rx_pkt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 03a35f03154d..110496e9c818 100644
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
2.56.0


