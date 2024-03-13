Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF14C54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 09:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKSX-0000tE-O0; Wed, 13 Mar 2024 04:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKSV-0000pZ-S7
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:59:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKSU-0002MG-Ch
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5rX1wiRaS4o6ho1ycS+cL0P6COf4Jdwl5irTlQ1l1FA=; b=RxVtQeAJ/oXuvXGs/qUSLpEVeu
 m9ChnZkM3187TBjVnckDNxQEyR0qg534xNNGZ5/dJnYEhzjcLK2w6PaADi94ssu047rYBNXKc6gzd
 M9GTmjuEJzP0/QfSrGoqz3MRAASTH6+Zr3+igt5r2WXKCGjgjLRMHwhFC8+d/KXbPoj8czhJaxDkJ
 ABHirnxml6frssRAhx5aqlBxSxyoDYiZ4iJFfOVWs9gNg0CWAtB+JZFBWhLMpqF83pKcB12NIe6X2
 np/VIQGEIM5CUfGack7Hb+n1v73oE359KmLxYoxc+lPSUk0GAKSaF8I4dtqZe/1LmMSHNKk39DWhS
 popoEixfF6kpy0QL65B2+BkEIXX2mXYDOTzZT1JEOcwcLfmMeIxKJQnRLoveys02zWfCLyf5QUwCE
 41o7R48trpvQ3blH1kVRh1NN7tdzpTNgr3iBVbafDluF11oRpJwx1ygUD8SF6fyJZIvpNx9qnNG4f
 sriCsvliGo8ERN6AFts5iJU6e5zalWd3sG4v51hRUFINh0+VGKKl6hXCQprBiRpHFLHnXxqepfk8x
 dGsVZLGKTCG95ZR5yomhqB9q0ORl7VYSY158zKE6fNUmfpK3gdncezdZDVm2wgik+bkVuESe+InTl
 tZqY85UMdkrhdwp1zY3Hd4MiavEiymNOJXRVH4nbI=;
Received: from [2a00:23c4:8bb3:1000:1218:d855:1998:7fa8]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRQ-000CUN-Ip; Wed, 13 Mar 2024 08:58:32 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Wed, 13 Mar 2024 08:58:09 +0000
Message-Id: <20240313085810.2655062-16-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:1218:d855:1998:7fa8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 15/16] esp.c: ensure esp_pdma_write() always calls
 esp_fifo_push()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This ensures that esp_update_drq() is called via esp_fifo_push() whenever the
host uses PDMA to transfer data to a SCSI device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 52a69599b2..68346ceaeb 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -276,14 +276,12 @@ static void esp_pdma_write(ESPState *s, uint8_t val)
 {
     uint32_t dmalen = esp_get_tc(s);
 
-    if (dmalen == 0) {
-        return;
-    }
-
     esp_fifo_push(s, val);
 
-    dmalen--;
-    esp_set_tc(s, dmalen);
+    if (dmalen && s->drq_state) {
+        dmalen--;
+        esp_set_tc(s, dmalen);
+    }
 }
 
 static int esp_select(ESPState *s)
-- 
2.39.2


