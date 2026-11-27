Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C59606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Ahy311QY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWovC-0003DC-GJ; Fri, 27 Nov 2026 00:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWov8-00036p-Se; Fri, 27 Nov 2026 00:54:55 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWov7-0007WA-2H; Fri, 27 Nov 2026 00:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758870; bh=G5tr1zBH3PbjI22EwrqkmmDdx/PF/EIOoupMkURt9Yg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ahy311QYQdhXHGFCqnW2BnSTbPb86r7OW6yZB3yB4FkyZwfYAD5C6hRLXmFV6teGS
 ilH2wWn5ekB5Db6QUCilL8YbfNlko43WOPfw8vjpOIxasjTMxF/NT1CmJL9WJGm95H
 X6UAiNZBMG+UC1tScRUH5+sB9SeEKMrmE202SVwpqhz+5qF6Vh5aFqchdeINm3KgPh
 sgaUtdq1T5Qj8HbPitmceZj6JMi4XTjpooxgRTVYFOISe+6WxZ4bNhoQIhviE0rbMo
 QRudk+QKRYilWLB+3Cn4zY0Vi4SzNZW198jhS4oHNEbtFj2O2nOlPC+l1tVUHD+2AE
 HuNbtvTCApoPg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C33121EA2CB;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C0FBD469909;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AB635CF21E; Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 068/140] net/eth.c: Harden _eth_tcp_has_data()
 against short lengths
Date: Fri, 27 Nov 2026 08:52:54 +0300
Message-ID: <20261127055421.39015-9-mjt@tls.msk.ru>
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

In _eth_tcp_has_data() we calculate the length of the rest of the
packet after the ipv4 header by subtracting the header offset from
the packet length.  If this subtraction underflows we'll return the
wrong answer. This shouldn't cause any problems if other layers of
the code are checking lengths and offsets, but defence-in-depth
suggests doing a checked-subtraction and returning "has no data"
if the subtraction underflows.

Cc: qemu-stable@nongnu.org
Fixes: eb700029c783 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-8-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit b5e0b450fc9abe70bc926c39d9d4bcb726002af4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/eth.c b/net/eth.c
index 9edb7cd7ea2..810da290651 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -118,10 +118,20 @@ _eth_tcp_has_data(bool is_ip4,
     uint32_t l4len;
 
     if (is_ip4) {
-        l4len = be16_to_cpu(ip4_hdr->ip_len) - IP_HDR_GET_LEN(ip4_hdr);
+        if (usub32_overflow(be16_to_cpu(ip4_hdr->ip_len),
+                            IP_HDR_GET_LEN(ip4_hdr), &l4len)) {
+            /* packet too short for claimed IP header: no data */
+            return false;
+        }
     } else {
         size_t opts_len = full_ip6hdr_len - sizeof(struct ip6_header);
-        l4len = be16_to_cpu(ip6_hdr->ip6_ctlun.ip6_un1.ip6_un1_plen) - opts_len;
+        uint64_t l4len_64;
+        if (usub64_overflow(be16_to_cpu(ip6_hdr->ip6_ctlun.ip6_un1.ip6_un1_plen),
+                            opts_len, &l4len_64)) {
+            /* packet too short for claimed IP header: no data */
+            return false;
+        }
+        l4len = l4len_64;
     }
 
     return l4len > TCP_HEADER_DATA_OFFSET(tcp);
-- 
2.47.3


