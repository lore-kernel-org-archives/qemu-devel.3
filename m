Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ADCE64A85
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 12:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIRsW-0002ie-3p; Tue, 03 Dec 2024 07:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tIRsU-0002iG-88
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 07:19:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tIRsR-0006qE-Sw
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 07:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733228377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fYbMlh2KrQvHJ8alP8dwH3CcsP4voIyLKOxOhu3uBqY=;
 b=PoS+ZepvhtXei0QrZrfDhLLiKLtxIgOUmRT/JRVHQuNtbkPUfO6Niz60BcT/0/cyz9ItHr
 KfdQYbWApzuhjac6mncdmqpCzymgZdj+v3PXYf7Y6/UUKzSvWgSrCtBIDvS0cP5bgqDees
 RS9krbRh4JyMxNN4hZ26LX06z3YDe6Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-woeL8iJYPu-RQOa7RD5lGg-1; Tue, 03 Dec 2024 07:19:36 -0500
X-MC-Unique: woeL8iJYPu-RQOa7RD5lGg-1
X-Mimecast-MFC-AGG-ID: woeL8iJYPu-RQOa7RD5lGg
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b67a8cd4d2so706601685a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 04:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733228376; x=1733833176;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fYbMlh2KrQvHJ8alP8dwH3CcsP4voIyLKOxOhu3uBqY=;
 b=OzySgG62RsE/bMuCIgivu5v7BUl8xPKmTmfTGCipHY2F8fGEBTEj0FnkZLIgwY7tMJ
 jK/DtAEmmn1onxmzWv5AhvF8O9iyRniEVBnl4FrBZoURsdZYnoazHVJacUrkeQ0uIUNf
 7v/BLDRu2M7izueQmm2gUyjsCwzUpGaRjknTIXgM8f5Ddr6N1wT+86v3WF7Eiym7Q0Va
 lw4Xn6EtEbmoQDJ3zK8P+vQL01ycEnvhg1sr+zXUP+h21FAxleVsQGS06QA0//W7U5y0
 et7rnpWViH/rj2QbJuPkScOdSXViL5BTPf/yYrCYAzvZHRd8bo7NRbesm4csDwmVkZP+
 JH/g==
X-Gm-Message-State: AOJu0YzThiTAZT291RIgNaOgwCR15VLsawz4HF8c8SptkIgpAFfilDnq
 2lpR535KCAFfH7FuzSnwHlZn0OWJJVFnu4SMGWCBgvWGpkmTQ6ihljO6hgm/ReCQwIsiNdletBd
 RDTimVltILOunn3HYSr7H6QIPGTy7cxHk+kiyP8oDoLcIFFvYZacr
X-Gm-Gg: ASbGncsqWOFmld+AYwSNJuXkC4jKEGIjiMSHwUmmG+qdpGimGvpOL+zHdoq72xCXJ3/
 4gY3Htv6fI7vz8l8WQErA6h68im5j50gaQqO9e8n0+Hsr2zqWrsP8W+TCgzNq3Y4ZHKRrOeeYQU
 F2NWXaUBFh+uGvBOqaRgzIpMPjF1OxJRdd0unptg6rJc3MTV7wVDJba4Hzzht0BrEbdXffxIorS
 B5SjC5SZOK+wtKslvyCD9h2T+RHzP7VkSEgD+V6AHo7TInleS+uAC4jjUo8OmHVmYwbMbwy0839
 WaJJlGk4LWHK7kYEM3yZaRF3OtnsyfNFUcFw
X-Received: by 2002:a05:620a:4108:b0:7b6:913f:3df3 with SMTP id
 af79cd13be357-7b6a61ca1d2mr235272585a.47.1733228376402; 
 Tue, 03 Dec 2024 04:19:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhBmOiBqlA6CAHNu/sB+PO1xSri1XTEQ42ZFtQgifXbwpHV81jboli47uspTkz+IRBWzR7Fw==
X-Received: by 2002:a05:620a:4108:b0:7b6:913f:3df3 with SMTP id
 af79cd13be357-7b6a61ca1d2mr235271285a.47.1733228376140; 
 Tue, 03 Dec 2024 04:19:36 -0800 (PST)
Received: from rh.redhat.com
 (p200300f6af0bca008282df582fad0b68.dip0.t-ipconnect.de.
 [2003:f6:af0b:ca00:8282:df58:2fad:b68])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849aac52sm504203285a.92.2024.12.03.04.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 04:19:35 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Sebastian Ott <sebott@redhat.com>,
 Zhenyu Zhang <zhenyzha@redhat.com>
Subject: [PATCH v2] pci: ensure valid link status bits for downstream ports
Date: Tue,  3 Dec 2024 13:19:28 +0100
Message-ID: <20241203121928.14861-1-sebott@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PCI hotplug for downstream endpoints on arm fails because Linux'
PCIe hotplug driver doesn't like the QEMU provided LNKSTA:

  pcieport 0000:08:01.0: pciehp: Slot(2): Card present
  pcieport 0000:08:01.0: pciehp: Slot(2): Link Up
  pcieport 0000:08:01.0: pciehp: Slot(2): Cannot train link: status 0x2000

There's 2 cases where LNKSTA isn't setup properly:
* the downstream device has no express capability
* max link width of the bridge is 0

Move the sanity checks added via 88c869198aa63
("pci: Sanity test minimum downstream LNKSTA") outside of the
branch to make sure downstream ports always have a valid LNKSTA.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
---
 hw/pci/pcie.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 0b455c8654..1b12db6fa2 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1113,18 +1113,22 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
         if ((lnksta & PCI_EXP_LNKSTA_NLW) > (lnkcap & PCI_EXP_LNKCAP_MLW)) {
             lnksta &= ~PCI_EXP_LNKSTA_NLW;
             lnksta |= lnkcap & PCI_EXP_LNKCAP_MLW;
-        } else if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
-            lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
         }
 
         if ((lnksta & PCI_EXP_LNKSTA_CLS) > (lnkcap & PCI_EXP_LNKCAP_SLS)) {
             lnksta &= ~PCI_EXP_LNKSTA_CLS;
             lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
-        } else if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
-            lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
         }
     }
 
+    if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
+        lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
+    }
+
+    if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
+        lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
+    }
+
     pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
                                  PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_NLW);
     pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA, lnksta &
-- 
2.42.0


