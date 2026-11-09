Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244F606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=KsGM6u9G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHzX-00071i-Ap; Mon, 09 Nov 2026 00:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHzK-0006ug-Jj; Mon, 09 Nov 2026 00:32:15 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHzG-0006Hb-JF; Mon, 09 Nov 2026 00:32:13 -0500
Received: from [10.42.0.1] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A95VLtb046789
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 9 Nov 2026 14:31:36 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=J/catv4i+XykkaGfTRi16jYEyYVpACUaiqWRJZxJ5xQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1794202296; v=1;
 b=KsGM6u9G6YxIKjB94kYqgUMX3IjIPMVBk1TMmPLcTMfQAR5aT8NHDl4Am3dr5pg/
 3J/tNT7I1bfqJFymV3w7prkY+xcpBuyhs9v1AiQaGEEa2XrQ+KUpb2RASIVKISGu
 HZH4v8Moqatxbenj3+AeKd7A/6AzcQBKuLnx/KerZuf7rhDqyot5c51qKRgf5ldi
 JjEmei1DcE7/M/1s+xJJyiL4E6JE7QwBHxibHSmgzviq06uxJuD1AXonorkE8zfV
 fv3qghJtV1WBtbHNsd9NT7l05spsYY/1LMagN5FBdL2HFpGls7bj2LQ7Nn60lp2Y
 mDJpDNT8udPGRHdAyIzUuA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 09 Nov 2026 14:23:58 +0900
Subject: [PATCH v2 13/14] hw/net/net_tx_pkt: Sanity check L2+L3 header len
 in net_tx_pkt_parse_headers()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-eth-v2-13-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=CfOoWANB/lfJxIKzoDtjEy92SfgWDreJBU7vQu4HMjI=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bHqOWTXAveP57nnzJt5ucX267cOLjK3MOv/rXyjqtCH
 DMsD/Tu6ShlYRDjYpAVU2RJKdrNrRFd+6kwIb4FZg4rE8gQBi5OAZjIRleGf6pJ1ecPJQZsb8uL
 ztFf/ZrPS3jzVue8qb/0XKO7f5T/qWVkOPGQLXaj7O+pU5IU/rEs81NI5RZWF1nPe3Wlw4ZzkxP
 ncgEA
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

In net_tx_pkt_parse_headers() we examine the L2 and L3 headers one
after the other.  Add a sanity check that the two together don't
exceed the packet length or the maximum IP packet size.  This
shouldn't happen if the L3 parsing was done right, but is worth doing
for defence-in-depth.

Cc: qemu-stable@nongnu.org
Fixes: e263cd49c73c595 ("Packet abstraction for VMWARE network devices")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/net/net_tx_pkt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index dc2563721e84..c331628134e7 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -267,6 +267,14 @@ static bool net_tx_pkt_parse_headers(struct NetTxPkt *pkt)
         break;
     }
 
+    if (l2_hdr->iov_len + l3_hdr->iov_len > ETH_MAX_IP_DGRAM_LEN ||
+        l2_hdr->iov_len + l3_hdr->iov_len >
+        iov_size(pkt->raw, pkt->raw_frags)) {
+        l2_hdr->iov_len = 0;
+        l3_hdr->iov_len = 0;
+        return false;
+    }
+
     net_tx_pkt_calculate_hdr_len(pkt);
     return true;
 }

-- 
2.56.0


