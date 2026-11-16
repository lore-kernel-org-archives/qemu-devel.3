Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5A606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=wUa6+FLG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3O9-0003fT-Hh; Mon, 16 Nov 2026 15:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Ks-0008Aw-Dd; Mon, 16 Nov 2026 15:29:55 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Kq-0001gy-L4; Mon, 16 Nov 2026 15:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860765; bh=7+IF1Va6bkPGd+J0BQ7r8wDhE0xFCCFC/TNr4p0qzWg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wUa6+FLGiyVa99DZmqitG7FiZKwZVqc35wGSiK8tmkBZjhrGwS0UsdpD+mqGPrZJ0
 XI3+aHEJ34qlGnYkzIXnlu8XFKqsIaNfT21QPlPun2GYM6VYIj/+HTFkjH5M2hQ8nh
 9GF6KWl3cuP4Dtgw9DQ2xbUjqqDsDn81dC+c017mePv5wgLvTkDbfXFm2JgGMkyAst
 DDx0bI822lPgaSekiqqNIcDKLfKS5hAH85q8/qnPg42zZx5bGWth7AIiC0yK0Ywros
 hja9SgxTbqobb7vDDOLK7BGf6maPWXnvITRTcYahXDYLuIcer2Qmw63g51JCHV9Uh/
 d+L1E17X5UrjQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 74D1F1E71BE;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6F01845FBEA;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 3F501B8E98; Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael S. Tsirkin <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 41/63] virtio-net: validate IHL in
 virtio_net_rsc_extract_unit4 before use
Date: Mon, 16 Nov 2026 23:25:20 +0300
Message-ID: <20261116202554.535325-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
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

From: "Michael S. Tsirkin" <mst@redhat.com>

virtio_net_rsc_extract_unit4() uses the IPv4 IHL nibble from the
wire to compute the TCP header offset, but the caller's length
check only guarantees space for a minimum 20-byte IP header. A
crafted IHL of 15 causes a read 32 bytes past a 66-byte buffer
when the frame was parked in net/queue.c's exact-size allocation.

virtio_net_rsc_sanity_check4() rejects IHL != 5 on the next line,
but runs after the OOB read already happened.

Validate IHL before using it as an offset. Since
virtio_net_rsc_sanity_check4() only accepts IHL == 5 anyway, reject
anything else early and let the caller fall through to the bypass
path.

Fixes: 2974e916df ("virtio-net: support RSC v4/v6 tcp traffic for Windows HCK")
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4166
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit fa9e186ab673f0f2d08b4202f0e06367998cd75c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 310a7c2f007..3be15734809 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2103,6 +2103,14 @@ static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
     unit->ip = (void *)ip;
     ip_hdrlen = (ip->ip_ver_len & 0xF) << 2;
     unit->ip_plen = &ip->ip_len;
+
+    if (ip_hdrlen != sizeof(struct ip_header)) {
+        unit->tcp = NULL;
+        unit->tcp_hdrlen = 0;
+        unit->payload = 0;
+        return;
+    }
+
     unit->tcp = (struct tcp_header *)(((uint8_t *)unit->ip) + ip_hdrlen);
     unit->tcp_hdrlen = (htons(unit->tcp->th_offset_flags) & 0xF000) >> 10;
     unit->payload = read_unit_ip_len(unit) - ip_hdrlen - unit->tcp_hdrlen;
-- 
2.47.3


