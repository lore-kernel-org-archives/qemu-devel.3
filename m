Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B75EC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuqQ-0001YW-JR; Mon, 17 Aug 2026 06:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqK-0001D8-DS; Mon, 17 Aug 2026 06:45:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqI-0003zY-Nh; Mon, 17 Aug 2026 06:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963486; bh=EYMdg8baSzdlaR6RUorC7XrNe/N+/5fOYuS2YyKgJms=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wEs4/MwRk8sY/dSyNWH741xq7qy0cQsr/tLzhYyZ+T0dRlfQl2Q7HR29o5Kgvw7Sa
 TPo7E6tpgltI8cabfzFg/e+RyKWigpy10obPhO+4ED/mBbp3Jfs2wEB0BYHqIjZPb7
 f/nb1tr8MXLgScxe4IF1+ZpoxL7UplYWfg6b/7hb66HzlA/Zz6j598zz0XihFxqOo4
 bi+Qe70HMCoLNlUWsVIYurdtB3CVhRMWm0rR6twWfZlsWxIj8Dpr+r1snRywahc7hL
 h1W7fOnH5Tm9aToh0wlEWz6193mtd7Zf6AKwWCCb2vp6DAceNjRmtFG6YFhrENTU3F
 42PZlTmMbG3/g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 777471CBB6F;
 Mon, 17 Aug 2026 13:44:46 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7821140D200;
 Mon, 17 Aug 2026 13:45:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0A94130E56; Mon, 17 Aug 2026 13:44:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Joshua Daley <jdaley@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 130/161] s390x/ipl: validate num_comp against iplb
 length before iterating
Date: Mon, 17 Aug 2026 13:42:44 +0300
Message-ID: <20260817104344.2047346-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
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
index 403cd08450d..33729d4be5a 100644
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


