Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAAE606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=jTWI/o2F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHzf-000758-8l; Mon, 09 Nov 2026 00:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHzK-0006ui-R4; Mon, 09 Nov 2026 00:32:15 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHzG-0006Hd-Ld; Mon, 09 Nov 2026 00:32:14 -0500
Received: from [10.42.0.1] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A95VLtW046789
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 9 Nov 2026 14:31:35 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=aEnGXpb/Ee4i8OiDpAQ1ZXhwkNY6p0+wMl0QVYOr3B8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1794202295; v=1;
 b=jTWI/o2FVpo5lXL7PzLHYOtJDf9obGRsDtbuN0uZnGCmBUdYHwC9bK6YmI7AsFEN
 iKIDxe494R0N+0T8vKnaSgwl1vkjl3SjPk1jufI6Hdc2diOi55y9Xotjz6UiG0w5
 e2jKzuIFlXVYvJUe3TYV6opt7BpqSM6wgQjflEl5OuYOJAeBsTpVV5zF0k8DQiCx
 OHCfyyTNbNv8fPNS+hrsxm4aVQpfH2jmUG0e1keTha7LcJhi5yepQ/o9pUEo4f54
 AdSFtRe58g0BZUucY04bGJE7Uj2aN9vkCz3VxyM7A/CwbrnPhQVM6ICn0o5QIrU2
 Xq0hmI2KlhsrGCwpemBzqg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 09 Nov 2026 14:23:53 +0900
Subject: [PATCH v2 08/14] net/eth.c: Harden _eth_tcp_has_data() against
 short lengths
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-eth-v2-8-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=qZ/eQ/j7cwwgbqiXWSNZLjgYeicLWHF//8GM+cIaK04=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bHqKWb62tn9v95t1BMZYK38aunXw/f3X/z5ZPC8mlvN
 5ZWhu8o7yhlYRDjYpAVU2RJKdrNrRFd+6kwIb4FZg4rE8gQBi5OAZhI3llGhku18wLjr7ns3cNw
 d/K6Bc6eflJ10w2O++le2HL1/vd+vSWMDMuONftuytxsGeV8e67g7t2Ht8z5O/XcHpaZS5Iv7yz
 Zu5gJAA==
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
---
 net/eth.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 0c3b4e784a59..749866094fa1 100644
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
2.56.0


