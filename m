Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F8F606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=Z60E0rRb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHze-00074V-Ef; Mon, 09 Nov 2026 00:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHzK-0006uf-JD; Mon, 09 Nov 2026 00:32:15 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHzG-0006HV-I8; Mon, 09 Nov 2026 00:32:13 -0500
Received: from [10.42.0.1] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A95VLta046789
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 9 Nov 2026 14:31:36 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=4csluYBe25LxuCIDQT3Str+SAhEBk6uukTzsRZyTsaE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1794202296; v=1;
 b=Z60E0rRb+IUzmw2H+VDfungn3Ec6YcxvswHdu5tVqnYRD36NJ/BGh9eDBNYv2ugA
 Tpm+HoYz3rctjuiZEQUIciO4i7qikQ+3S985m6M/rInw0+jRSLfpRNWxO8kjwo4R
 6P4sxsopzWGciJNpif08LUe9VEzFsJatssKP8n6+kVDH/KZx2QZeQSY7r0eNYQsw
 NoFWFaoESm3Ztmce2EVHLM54oSHWwTGAjfiogSaKX+8pcVIkZ8mzRUXUkwTtXaXj
 U6uMq2VHrd+bH7hCQnk6wFEqUy8lM1uXBXr6v5b5XCFMXeWmqgvj8mdlWVTGcIAG
 r9HE6zFs9CIB+ReYwQGLTg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 09 Nov 2026 14:23:57 +0900
Subject: [PATCH v2 12/14] hw/net/net_tx_pkt: Sanity check virt hdr len in
 net_tx_tcp_fragment_init
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-eth-v2-12-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=eIT70pmjipb26muzAUE6SmrBPX8sPqDAYTmow90qy2Y=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bHqOXn9qZw9yWzfJM6nm90/7rn/lyfBRI/VzYF/7gnv
 iGyJCeso5SFQYyLQVZMkSWlaDe3RnTtp8KE+BaYOaxMIEMYuDgFYCKbLRgZVmxVqS7W6v5+y8yO
 5Rfv+p0WJQ+VrmXsjRWbNadrSfj/3wz/40rWemYaxYs12n3aU7d+i9LlLTe6VVtV5m1I4k4ROHC
 CEQA=
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
---
 hw/net/net_tx_pkt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index b2935900fe7f..dc2563721e84 100644
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
2.56.0


