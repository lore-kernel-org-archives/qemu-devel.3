Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA87606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=IK7P52lB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWov9-000373-UZ; Fri, 27 Nov 2026 00:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWov6-00032f-Ca; Fri, 27 Nov 2026 00:54:52 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWov4-0007Vt-Fx; Fri, 27 Nov 2026 00:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758870; bh=b2gb9kGswGq4ku7SEwr3c52bB6DZvnn24PV7nxG3+GU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IK7P52lBkc6UpCSeZTiZjBcFZZgcNjx8JX+87LLuYj7NKuMhYCGm/GeXorvoBCt5P
 SWmEs7v4eTa3gC8mKPGBYfeT3wXryihTRT9NQ44G515RYtV2UFdcZTIKLWZ3SAvgxJ
 oWvMqJbQo9udSktu5bij8BDv2uLKLI/towq+mciEgUT+4klpsAWrQZltKfAsx0AmQD
 cIS4d1Vw4IqKO/cFYaDnDFj9Uw6dfGYByV26Xba8XWG0wgW1Zs84LhysdvCaCiMpip
 H2/baz/coyYaH0lPG53TWQ6STitAmEJFmCBH28G9oXOatbXPB2wN77EcJpfpymu12E
 3q6RYUdpBqwvw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BEB0E1EA2CA;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BC877469908;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A877FCF21C; Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 067/140] net/eth.c: Move the Routing Header Hdr
 Ext Len check
Date: Fri, 27 Nov 2026 08:52:53 +0300
Message-ID: <20261127055421.39015-8-mjt@tls.msk.ru>
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

RFC 8200 - Internet Protocol, Version 6 (IPv6) Specification section
4.4 [1] says the Routing Header length depends on the Routing Type, so
place the checks of the Hdr Ext Len and the Routing Type together.

[1] https://datatracker.ietf.org/doc/html/rfc8200#section-4.4

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261109-eth-v2-7-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 34bca6376984d75713cf1a87e31188fee3e39a30)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/eth.c b/net/eth.c
index 1e279787f39..9edb7cd7ea2 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -407,7 +407,8 @@ _eth_get_rss_ex_dst_addr(const struct iovec *pkt, int pkt_frags,
     bytes_read = iov_to_buf(pkt, pkt_frags, ext_hdr_offset,
                             &rt_hdr, sizeof(rt_hdr));
     assert(bytes_read == sizeof(rt_hdr));
-    if ((rt_hdr.rtype != 2) || (rt_hdr.segleft != 1)) {
+    if (rt_hdr.len != sizeof(struct in6_address) / 8 ||
+        rt_hdr.rtype != 2 || rt_hdr.segleft != 1) {
         return false;
     }
     bytes_read = iov_to_buf(pkt, pkt_frags, ext_hdr_offset + sizeof(rt_hdr),
@@ -518,12 +519,10 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
 
         switch (curr_ext_hdr_type) {
         case IP6_ROUTING:
-            if (ext_hdr.ip6r_len == sizeof(struct in6_address) / 8) {
-                info->rss_ex_dst_valid =
-                    _eth_get_rss_ex_dst_addr(pkt, pkt_frags,
-                                             ip6hdr_off + info->full_hdr_len,
-                                             &ext_hdr, &info->rss_ex_dst);
-            }
+            info->rss_ex_dst_valid =
+                _eth_get_rss_ex_dst_addr(pkt, pkt_frags,
+                                         ip6hdr_off + info->full_hdr_len,
+                                         &ext_hdr, &info->rss_ex_dst);
             info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
             break;
 
-- 
2.47.3


