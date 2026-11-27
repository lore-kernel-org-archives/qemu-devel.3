Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916C606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=mKQKWdxK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWov1-0002u2-BL; Fri, 27 Nov 2026 00:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWouz-0002sw-Tf; Fri, 27 Nov 2026 00:54:45 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWouy-0007Uj-4E; Fri, 27 Nov 2026 00:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758870; bh=uWwwiJ/E+24KNP3sZdsvq3t3L8Imd3ZnuqXMLIROqoI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mKQKWdxK/YWU0qGGlwvw08OjRnXjKlxEnLhMR3p8Kk0XDBRsyG065BgspupBv3Gp9
 7AgE3qrkhR7f1fCGEegYhCjCGGA0jew0qG34qXDrzM2mfPlwxZ5/+NqAK/KVDL2bqF
 qzQEgFSDo9CujWpd6PBRlqEIIZmZ9q0QUE9LFp9ypubdORVPYoXG8rB7KDhY0ERC4Y
 Xht7udu9C3NNDzhe/i6xOlBeU4TdQwy3miwMHvmLBCueFaCU07yXt/DMEULu52RURh
 Do0iA83Kec0L4fwrY8eyOMEkm3nvuBJPQ5mFitgjRy+6LpslMA2BnF7WXKMpUa5Qwd
 yQKgnO7MsLP1g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AF1E41EA2C6;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AA7D8469904;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9CC02CF214; Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 063/140] net/eth.c: Check for undersized IPv4
 headers in eth_get_protocols()
Date: Fri, 27 Nov 2026 08:52:49 +0300
Message-ID: <20261127055421.39015-4-mjt@tls.msk.ru>
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

In the IPv6 path of eth_get_protocols(), eth_parse_ipv6_hdr() does
various sanity checks on the packet's IPv6 header, so we won't tell
the caller we have an IPv6 header when we have a malformed one.
However for IPv4 we only check the version and that we have at least
the minimum header size.

Harden this codepath by checking also that the header size declared
in the packet's own headers is neither smaller than the minimum nor
larger than the actual packet size.

Missing these checks shouldn't cause problems if the caller is
validating all offsets and lengths before use, but checking here
too is defence-in-depth, hence the cc to stable.

Cc: qemu-stable@nongnu.org
Fixes: 69ff5ef847457555 ("net/eth: Report if headers are actually present")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-3-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 987f5bc647a204493fa658d057e01a4bc184d361)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/eth.c b/net/eth.c
index 6315ab90cf8..d7785d80735 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -163,6 +163,8 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
 
         copied = iov_to_buf(iov, iovcnt, *l3hdr_off, iphdr, sizeof(*iphdr));
         if (copied < sizeof(*iphdr) ||
+            IP_HDR_GET_LEN(iphdr) < sizeof(*iphdr) ||
+            input_size - *l3hdr_off < IP_HDR_GET_LEN(iphdr) ||
             IP_HEADER_VERSION(iphdr) != IP_HEADER_VERSION_4) {
             return;
         }
-- 
2.47.3


