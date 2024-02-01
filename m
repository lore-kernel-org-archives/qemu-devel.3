Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C51C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaAq-0002qR-LC; Thu, 01 Feb 2024 11:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAl-0002pC-K8
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:19 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAj-0002Pr-5N
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=C7nZq/xI+tHeWx5EE1R48ZvurCMfWCSLsOC+/dyJjdk=; b=TehMQsDu/jhHwwMBE+S3qYecIw
 nhAARAec1eqZpmfNr/jZchOOFGH1y7Fnb4xka6QBfisYBXDYJZkNJj524wvbXQ3obd9FicChslbLn
 NLuF8fYQvwTlFiXsmkF/sysMeJmz6tWL88vZ6MLGAl/vDMLfrei7DRHd3MSlimAPmj5HrinbkapPd
 0k8iVSnxZNB2A73NuK5DcXtc2VeinRNR8r/DHu+kLqwCPgfzAUFtCzxqyrN75d5hBsJKJCNs4miK5
 WJyblrfFcU8/1t9G601AykuMS2rBe9Fm2vv4XskWmrPLTkxSlDaQ1C/Sal473FDuMT2ton4DwCJb/
 SjikzJ4A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAe-0000000GIcx-1gwe for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:13 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAf-00000003IMG-1yMG for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:13 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/47] hw/alpha/dp264: use pci_init_nic_devices()
Date: Thu,  1 Feb 2024 16:43:32 +0000
Message-ID: <20240201164412.785520-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
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
 hw/alpha/dp264.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 03495e1e60..52a1fa310b 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -124,9 +124,7 @@ static void clipper_init(MachineState *machine)
     pci_vga_init(pci_bus);
 
     /* Network setup.  e1000 is good enough, failing Tulip support.  */
-    for (i = 0; i < nb_nics; i++) {
-        pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
-    }
+    pci_init_nic_devices(pci_bus, mc->default_nic);
 
     /* Super I/O */
     isa_create_simple(isa_bus, TYPE_SMC37C669_SUPERIO);
-- 
2.43.0


