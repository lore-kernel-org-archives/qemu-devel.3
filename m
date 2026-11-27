Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D322606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=wg0XkT3F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWovc-0003u5-Nj; Fri, 27 Nov 2026 00:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWova-0003nw-7L; Fri, 27 Nov 2026 00:55:22 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWovY-0000T4-CF; Fri, 27 Nov 2026 00:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758870; bh=/2PoZBuxQkXcxqRfHcrm9vBtjcYItTE1S5aW06zRbKs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wg0XkT3FvDywIICxX5kL9k3eAohfuy/s2Essz0i19gzPg26PHZQtOEpt04EMjRCqW
 3n40TsOTgi4Bvi8R/pKpRWTR24FT4j3OhTN0yQWLsFK+gC7+9JFQa2s6FF4EGypgCq
 VVPctua/hT812TlZ9Jsspc8XMhI6RORy41XcEkDWlKbOOwWDkOTfeMKS6k9CgGWcpN
 JKxS5sqcgH5SZi0Qyp+NgeiOQs7NUtAFEcelmIkhpSRwiPv2aufJqSTlhRnwpQ/bk7
 CkcHCvKY9i6hAAsWMzwOg/l+CzFPEp6PY4hgt8GY4ixaEqcjhc8GEkbI0devOBRnlW
 SU+Bizn3eTk+g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D90B71EA2D0;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D704646990E;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BA1CACF228; Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 073/140] hw/net/net_tx_pkt: Sanity check L2+L3
 header len in net_tx_pkt_parse_headers()
Date: Fri, 27 Nov 2026 08:52:59 +0300
Message-ID: <20261127055421.39015-14-mjt@tls.msk.ru>
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
Message-id: 20261109-eth-v2-13-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit fda35a236c96ee08e10481f585aa6bd841968395)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index dc2563721e8..c331628134e 100644
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
2.47.3


