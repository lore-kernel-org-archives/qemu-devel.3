Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CFE606A324
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=x9t55kcl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWovf-00048C-Jg; Fri, 27 Nov 2026 00:55:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWova-0003o8-BW; Fri, 27 Nov 2026 00:55:22 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWovX-0007kw-Ts; Fri, 27 Nov 2026 00:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758870; bh=1HjoSeT0+uHbwPNPX3X5Zv/MQM31dwkvtEHjhi7N660=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=x9t55kcl8kEQ3qb3DZ4k95Tilkc2sqTiaztwC/ADpDNGNnuz6u4nC2WaQxV9A2xPh
 BX3K00taxx9mckGVI0So+aj8Qvu46JO5x3kQjh6Sb7i5kkrYbpLmOtoR4BnBGdnN6M
 pdGmsIbMw2xbRD2bLA5sEbT/zz8+vO1pumY1iFhdcT1tU/qdiAwyOCotwxkTYaX16s
 fhoUPAztEiVByHxv0O66C3oBiMeOZ/8jUwKMsd1hl0V2fhqWdH155iRWQDRg1ZGH4a
 bb5AWISuNL9m4pjNGCK2MWO8g25C9fiGxpUSSj6x3yDl25KX6SjgFe6ZASOcwW9dgF
 0Kd5dqV3oI9YQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D4E5B1EA2CF;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D2E7B46990D;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B7416CF226; Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 072/140] hw/net/net_tx_pkt: Sanity check virt hdr
 len in net_tx_tcp_fragment_init
Date: Fri, 27 Nov 2026 08:52:58 +0300
Message-ID: <20261127055421.39015-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

In net_tx_pkt_tcp_fragment_init() we calculate the l4 header size by
subtracting the packet's virt_hdr.hdr_len from its overall length,
and then we g_malloc() that many bytes.  This shouldn't underflow if
the caller has been sanity checking sizes and offsets, but as
defence-in-depth, check again here before relying on it for the
malloc size.

This change would suffice to avoid the guest self-denial-of-service
via overflowing the virt_hdr.hdr_len calculation in
net_tx_pkt_tcp_fragment_init() which we fixed in the preceding
commit.

Cc: qemu-stable@nongnu.org
Fixes: 02ef5fdc092bd4 ("hw/net/net_tx_pkt: Implement TCP segmentation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3648
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-12-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit d95e10195acaf9281efc6db2db64a50a90b233ba)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index b2935900fe7..dc2563721e8 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -604,7 +604,7 @@ static bool net_tx_pkt_tcp_fragment_init(struct NetTxPkt *pkt,
     size_t bytes_read = 0;
     struct tcp_hdr *th;
 
-    if (!pkt->payload_frags) {
+    if (!pkt->payload_frags || pkt->virt_hdr.hdr_len <= pkt->hdr_len) {
         return false;
     }
 
-- 
2.47.3


