Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D51606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=DWbNZUrk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHzY-00072C-LU; Mon, 09 Nov 2026 00:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHz9-0006u2-42; Mon, 09 Nov 2026 00:32:07 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHz4-0006HQ-EE; Mon, 09 Nov 2026 00:32:00 -0500
Received: from [10.42.0.1] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A95VLtR046789
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 9 Nov 2026 14:31:34 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=SrGQealLyH3hg42u+EWDOoemyLjrZmzhxYj9oW/6TSU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1794202294; v=1;
 b=DWbNZUrkVAJdoaW2GYb7bobpHVt3z31IvkfyRdbG7NICY1qghrBvporklc3r3EX9
 19JZ7GzLYUnLAL2hxmWVJNSQorvYioQeGUQjscu1YHSnqC1yN1K8FF0xwXeNG/z3
 Z/2+vc0iZuUULWaEYM6BrDl87ITeP6hb5kgvoVuAAuNvax6lAMTL+xUhRhdzBk+7
 P6iMrjZHNWchOmHeTuAv19dofF4BNUvJuofdmbsTL6zzKm+gU0CMa/0YaZhRQz6I
 +IWY3jek3ml4HU2OnepXJiHpRk3goFeraS1tUSfXxlXIRnulPICg7N89IDyTnBuL
 kFKtXymBFEKPZn4gcRmpKw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 09 Nov 2026 14:23:48 +0900
Subject: [PATCH v2 03/14] net/eth.c: Check for undersized IPv4 headers in
 eth_get_protocols()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-eth-v2-3-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=yESB8Zab4os/s1R62J8xq9PMyiu3eYpATt16sW8tdWY=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bHqHnfP94W5DxQyaD1iMGsOu2TB/v9XN0NF018Vsy8M
 Oe+DlNsRykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwESWbWZkuHCdxTz4YiSf8RGv
 j7KvxU6v63vJoxDV+HXFjo+n33SsUWNkWOHAFbTgqtX+hbypEaau6zUYFy1qu3FDIYyn/GDLhp9
 bWQA=
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
---
 net/eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/eth.c b/net/eth.c
index 59b278b887c1..038f7d889c33 100644
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
2.56.0


