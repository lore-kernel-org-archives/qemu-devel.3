Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B3C606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=I6dzi/qj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHzZ-00072i-DC; Mon, 09 Nov 2026 00:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHz9-0006u0-30
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:32:07 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHz4-0006HS-1A
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:32:01 -0500
Received: from [10.42.0.1] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A95VLtV046789
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 9 Nov 2026 14:31:35 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=PPjtMe7/DOEseSjjnqmeEol8IGuh2LwrK+JxTc9S1SU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1794202295; v=1;
 b=I6dzi/qjd7YJXxws1teN/NO40ba/ve9uX+5D28Wlk74hRyBFSdMry50BCDhSF0kO
 NM/0pzzfe5rTy3Yaw5LCMUI5NAokgVTAvEitCI0N75J5+j0CTR2+kx9P/gv2mAvf
 hxXjaZhY1uzyk3baqiGtXlqU4ZppEHJtobJ1mObUmZaPe15f/kvS72HMFIbrAW82
 TpDYHqPrusqQTIMs7VyA0J5mzrzhqk2Qydvv9Nz0eC0TyzBCznt4fHOvGh8gWPZT
 7ALrO3EPtlFCP8V3iK9OKPy9+xLHDmtjxMdiGt54VJwVmtFAqQgJ9A4tR/hLTqQ9
 jm11IsT+D9Sfydkra7ysYQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 09 Nov 2026 14:23:52 +0900
Subject: [PATCH v2 07/14] net/eth.c: Move the Routing Header Hdr Ext Len check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-eth-v2-7-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
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
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1942;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=9F0P3hUuonhELThFf7z0bn/d/7sKXmyNZ4/5qZE/lL8=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bHqCVq16ZmLA1WLI9vj9TiTctYscVSdLFgcJnuk8wr/
 H7liW86SlkYxLgYZMUUWVKKdnNrRNd+KkyIb4GZw8oEMoSBi1MAJuJUysiwNGXGI25/jW12m/7b
 vL1VJhgucvvxG4v1y2Z131774dn9NQz/dCOuNIlInvM+p7vviDPvrC0rps3L8olOE/fo9pczWH6
 KDwA=
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

RFC 8200 - Internet Protocol, Version 6 (IPv6) Specification section
4.4 [1] says the Routing Header length depends on the Routing Type, so
place the checks of the Hdr Ext Len and the Routing Type together.

[1] https://datatracker.ietf.org/doc/html/rfc8200#section-4.4

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 net/eth.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index ba0e964b97b8..0c3b4e784a59 100644
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
2.56.0


