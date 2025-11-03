Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50029CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 19:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG0cW-0001l0-Ct; Mon, 03 Nov 2025 14:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1vG0cT-0001jN-5c
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 14:53:37 -0500
Received: from cyan.elm.relay.mailchannels.net ([23.83.212.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1vG0cH-0006ra-Vl
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 14:53:36 -0500
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id D5D4378053C;
 Mon, 03 Nov 2025 19:53:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a475.dreamhost.com
 (100-121-221-249.trex-nlb.outbound.svc.cluster.local [100.121.221.249])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 74D56780B5D;
 Mon, 03 Nov 2025 19:53:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762199599; a=rsa-sha256;
 cv=none;
 b=PjSXy/vh3Q8vBFth0xQTuWqqgiqSnS/+LI8lJPIf26AmoBggCxrxFnmeUiZ1ivnyL0hvh0
 wrX3VUBay02QH2VRHdEKGBjruAGlCZWPvpSa56U2adJgdbJD1td8/PzgdzSi5Xzyx198VB
 3eBDxvhiQ69fjpByYaZlRkV7Z/hiJ/40qMBZUgK8O8B+2ojTQpckyZrPkNSxG98imGcKVD
 Hv0jGSBmL+vVj3QzNHQC4w4fivbiYRiPtTjB103hIA2GrP+mfy4l8WXhvtfws16oLxvmuU
 SgYTTDpb7AhuO3DoDIJaaV4oDuu62mk7FSu4ORZYMei3dWZrFijLUHhE9D+Ddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1762199599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=dy+16HPLQwACfYwD8nWZx5dmnnfylWeebfJGhKZEyJU=;
 b=2yCVrtpT3DcEPqnuE8UsZBLx9gVUi3xHpPRgBSCJNAaSgMwuUu04jdnrZQFGrLqiwMLcE+
 UMurD7R2My1n0XBDgDCFp2DEQPizUmEeNqJ3KLLmxk1+y3SqJ4isCU+tI8K1EMArAwUSho
 W6/XWgYpOhh3tw0jt1Ic/GOrwyyse1DpMc8iBmHgN2UrcsGIyccaWF48XYRCOjnjj9i3N4
 7wkFbTd8XMjD62AaWLVxw46kurS8OFjNGN0n4B/Cy/+Sv/8ZHzStT/MIaNjfWCk5r6w9Gb
 OQfCnf3fVqJ7uXARf0Uo0GI4a+E+/HeEMzfcuD6CVX2K/RNjGQnI1nQRCRDTCA==
ARC-Authentication-Results: i=1; rspamd-768b565cdb-k86dj;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Blushing-Cure: 11a4f7a239a2d483_1762199599768_661496187
X-MC-Loop-Signature: 1762199599768:3503063714
X-MC-Ingress-Time: 1762199599767
Received: from pdx1-sub0-mail-a475.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.121.221.249 (trex/7.1.3); Mon, 03 Nov 2025 19:53:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1762199599;
 bh=dy+16HPLQwACfYwD8nWZx5dmnnfylWeebfJGhKZEyJU=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=A4QFGTx/5+dmalhXlzIcEcU5fX7Ze/iueI2PdQt0P0ms5H/qLcr+JPyL9bCZzxg+m
 gm1n0KedmYjFC4lV0pVGWIDZk/pWZvDLzl/TCq3p2TzycIRVdd2zjlzLi8WsPqQvZo
 1Zt4+mLUfChkfsJujlcYwD4GbWWxxXgC4n4jXbSY4RN8HvSDNi53YchUNEVYQN35Sd
 7l7FeiAKy+VH4gcWhRm9eaiKphd9XC2SkDZGvEFnKSKBOzdofKttLNGPjfuLqqHdyz
 wRGsIHrDfeUvu4R8O9Rk79AiAbGWNZMEU3vX165z6gTxkzIlpElxr5wArjDLNejy7h
 o5OKrLd3qgbnA==
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a475.dreamhost.com (Postfix) with ESMTPSA id 4d0j1p1J8Zz1wdh;
 Mon,  3 Nov 2025 11:53:18 -0800 (PST)
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, alucerop@amd.com, a.manzanares@samsung.com,
 dongjoo.seo1@samsung.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 armbru@redhat.com, linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 dave@stgolabs.net, Jonathan.Cameron@huawei.com
Subject: [PATCH 5/5] hw/cxl: Remove register special_ops->read()
Date: Mon,  3 Nov 2025 11:52:09 -0800
Message-Id: <20251103195209.1319917-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251103195209.1319917-1-dave@stgolabs.net>
References: <20251103195209.1319917-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=23.83.212.47; envelope-from=dave@stgolabs.net;
 helo=cyan.elm.relay.mailchannels.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

... this is unused, unlike its write counterpart.

Suggested-by: <Jonathan.Cameron@huawei.com>
Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-component-utils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 0221479613e8..31bbedb502e7 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -69,10 +69,6 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
 
     switch (size) {
     case 4:
-        if (cregs->special_ops && cregs->special_ops->read) {
-            return cregs->special_ops->read(cxl_cstate, offset, 4);
-        }
-
         QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
 
         if (offset == A_CXL_BI_RT_STATUS ||
-- 
2.39.5


