Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADF5C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxVf-0003GW-6O; Mon, 17 Aug 2026 09:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxVX-00039x-Ev; Mon, 17 Aug 2026 09:36:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxVT-0007Kl-Lk; Mon, 17 Aug 2026 09:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=+pcGxmCDcd4vtwUJSLy+BZ2nzEcn7wspnH9snwbDcAw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VjpxOUtB9GKUe3pt1Vz46dtlejqKp+hIpPus+Bv6oDqYbxjhts122R7mK94HLceC9
 Atv8Yv/+/tomBqpRJ88g4iU798CRSZVu5XOQwwHLWZoIpOaPAPfvkwNpsddsk89iLF
 fFBevZplagNxISbLqisW7ZGbbgck1wRRBLQtyxp06xb8Gg6afdIv+3d+WZfAaY8gpn
 0pKh88YfOPIJO9yoB9j/jSgofllXe1O4SPcMMajD6BSmaJVNtgcVKnjSXmNCFnUVs+
 uQs5L7amQ7PkWhP9x2qhw1c55Vxgi19/XLFuaQZ9lcBYliIIsNtZi+7M2tCKZMaTBC
 70f2eHiECkorg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 288941CBCBE;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 620E840D41B;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A111330F86; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Joshua Daley <jdaley@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v2 111/135] s390x/ipl: validate num_comp against iplb
 length before iterating
Date: Mon, 17 Aug 2026 16:34:21 +0300
Message-ID: <20260817133451.2384630-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Joshua Daley <jdaley@linux.ibm.com>

In ipl_valid_pv_components(), the upper bound of the for loop,
ipib_pv->num_comp, is read from guest memory. Before iterating, verify
that its value will not cause a read beyond the end of the
IplParameterBlock.

Fixes: c3347ed0d2ee42a7 ("s390x: protvirt: Support unpack facility")
Cc: qemu-stable@nongnu.org
Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260727115052.24289-3-borntraeger@linux.ibm.com
[farman@linux.ibm.com: Added qemu-stable]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit df607fd056044e40352a43f0b4422b9a5cb015c8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 8e3882d5063..1a029e0e5c0 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -124,6 +124,12 @@ static inline bool ipl_valid_pv_components(IplParameterBlock *iplb)
         return false;
     }
 
+    if (offsetof(IplParameterBlock, pv.components) +
+        ipib_pv->num_comp * sizeof(IPLBlockPVComp) >
+        be32_to_cpu(iplb->len)) {
+        return false;
+    }
+
     for (i = 0; i < ipib_pv->num_comp; i++) {
         /* Addr must be 4k aligned */
         if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {
-- 
2.47.3


