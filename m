Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57C5C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaDg-0006i1-CG; Thu, 01 Feb 2024 11:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaAq-0002qg-Rk
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:25 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaAm-0002Sz-9a
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=7Uppd3XmmgMw4XasqXjrqhb0RWV0UlzHWXb7dMHxQkk=; b=ZZEanmBS960hi51lWxEiSCFaL2
 O1lw3xcimaMRZx+0WkPyuqi01AX6j0AOAc/Ey1lrqrV4GB+9f3tTq/hvnfTBRQ4bHksx+qzsod1Ka
 u5umNPHDAPx3qH5RquTze8WcCnjYFwUlh/P9iFyYUk2qiYJxQgAcGvLSs/QgSI/8O+C2s0pkT8Yr2
 jYFvFRxKDPU+ExKNTNpZf+QbqfUgSthoPaf8nse7F/UgRZ/9siEXo8C6Dimku4wpe/s5LiF7z3MkK
 DdPhjB2gJC8in36kkp+98XsXGpAgRdbZD+HyLooqSBjk51CcFmrULCwlGUvfV6n4CTC8dAaYDbwEz
 7d6jadIw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAg-00000009cM3-0tA8 for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAf-00000003IMi-3QZg for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:13 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/47] hw/mips/loongson3_virt: use pci_init_nic_devices()
Date: Thu,  1 Feb 2024 16:43:39 +0000
Message-ID: <20240201164412.785520-15-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/mips/loongson3_virt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 33eae01eca..caedde2df0 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -451,9 +451,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
         usb_create_simple(usb_bus_find(-1), "usb-tablet");
     }
 
-    for (i = 0; i < nb_nics; i++) {
-        pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
-    }
+    pci_init_nic_devices(pci_bus, mc->default_nic);
 }
 
 static void mips_loongson3_virt_init(MachineState *machine)
-- 
2.43.0


