Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6491AEA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniA4-00072e-Mp; Wed, 04 Feb 2026 14:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniA2-0006vy-TK
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniA0-0007mh-CT
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FASluuV0Jcb054KpKqsmGba0D+bzV9eQK8JmA6WXuug=;
 b=aIrJjGo6mtWGgCjVHhe8x4uh+e2EeFC0UeZO5uzwk4QpKF0bEKJjNwIW0wE2MzlJwIgv/l
 szJJck8U5xjgTPZVVTsnsF660moDouIPKnF/DNbDOO1ykE0bw0X+RBQu9JjLmYhF2jO6wb
 v20rLpfpCf/YkfUF7gZDbA1ZmSvvcu8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-Qgs30U1AOAS9TIS-Q1dV6A-1; Wed, 04 Feb 2026 14:03:26 -0500
X-MC-Unique: Qgs30U1AOAS9TIS-Q1dV6A-1
X-Mimecast-MFC-AGG-ID: Qgs30U1AOAS9TIS-Q1dV6A_1770231805
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42fdbba545fso1119891f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231804; x=1770836604; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FASluuV0Jcb054KpKqsmGba0D+bzV9eQK8JmA6WXuug=;
 b=hXbGoMmUjTrwQhS4rpQ4DKGM5hsTZ9JOkr3JgQ7KcQdWVRX0xLU7XKxBMUKLD5I/9s
 fgJTNEYtBjuTct1X537OkiVMrbsGmhHUw/qhbAkp5alsr/UfQrhagP8qzIxpCQkgFA+z
 bdc3ynSH/QKltShmqX0KEMG7EhDB3SfsPtDQRIKjORANZzMHMD2thaFJHWSYYwyhbFM7
 J8yuiwQvmH4yMDSrqQfO6XfbW4+2vNud52fCQqdaJmHEKbynsvIw1OYh2JE44UoRz7PW
 m6xXfw7IMIH6im7AjErg1t+qC/flKmKMaX4bnquAFvN4hAw2iaTNM3tpN/UFzXLzKeon
 RTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231804; x=1770836604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FASluuV0Jcb054KpKqsmGba0D+bzV9eQK8JmA6WXuug=;
 b=lmzKFQSUa3B1QOhOvlrsh8Kg29hSnXaoo9cIjmqzdLjOlVJZ6eCH54GrT6UcMhwVta
 tij93oP3xI8q9U7IHCd+fMX8P3vqAplTyhh2N3AEkZnL+Ag/zHyP6kka75ohsEQas5gF
 yMR/geIWerrHs1dpXpuozSQ7DCAG1sbDIctHC0F6IZTNfRCuq2lEDTEY89u4FKWk4EtL
 8CGL3i3U5sZmV9nZPr5m8vy0xGEVdE0uNsv8dwcZ/L/FYpoWienELboiJDkl0dmqaEZ8
 B7K2GK78MLWKeh6uWuf89E8J8llJeTpl9keKJhaKKC8F4nnUBsQ6ZC7YAeu9omU0jqP0
 WXDw==
X-Gm-Message-State: AOJu0YwElSMhTKvZPqfz16RTvrhCV9hli8L/v09+sTt8qEc9ZX10/bbe
 Db3L0jehvADbNB6D8fzCw5TD7Z2gGxnjGxdPBRYx10wKQtSgObqrloDlCNRQqu7GOdYZuWYqlmQ
 76hKV9bcSy0DGvBQq37ho9eb4BQG0g2nypRPPsKats19WobjfkLG1b7mGEKvtf/1oWNhgxtUeCn
 hQxSqK3XcLMQela51/PmdNcK2jg0Ero+tWHw==
X-Gm-Gg: AZuq6aJKp0BAQs5rL9OUkrjPw3e4RvlfiEz9I1GKY0Ti/xiKqXVTE3Ao+VhTpXrYbfo
 B2DbemjRdmpNP4u/kr0cNVfVPLUiQMtMfKmh5KbVmkEvSALuDb56wlfMnXsidld82+IDk9yzuBm
 DSnelAKNzLAYWw2nkWKhhU+/9wxX6rx1uSC4+MgDSqDnB66+as9MZRYvX2XSbiMtfevqh47EcGE
 vtMxQueA+lgHrE53XBUOqdH3oleI3C7rxstJtcunbSSWG0JtItd1iSHwXnkqRSlgBbEuFpDRXF6
 pSttQLbAk9euxjHtVayUv0qLoOnGhoUPGPKplDpgxJY6E+vcOBl787QGOkCv0L44OMkLiuc9Mf9
 XVVgWhV51IXBZQjBmC00NGZ0lMaUFlegCUQ==
X-Received: by 2002:a05:600c:1c22:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-483179da808mr3365795e9.16.1770231804530; 
 Wed, 04 Feb 2026 11:03:24 -0800 (PST)
X-Received: by 2002:a05:600c:1c22:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-483179da808mr3365375e9.16.1770231803992; 
 Wed, 04 Feb 2026 11:03:23 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d4a6b1sm3760595e9.11.2026.02.04.11.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:23 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 14/51] pcie: Add a function to check if pasid privileged mode
 is enabled
Message-ID: <7b775ce1e595487808620877e77d4158ada2b0ce.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251029105137.1097933-4-clement.mathieu--drif@eviden.com>
---
 hw/pci/pcie.c         | 21 ++++++++++++++++-----
 include/hw/pci/pcie.h |  1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index c481c16c0f..50fc4aa8eb 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1340,6 +1340,16 @@ void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,
     dev->exp.pri_cap = offset;
 }
 
+static inline bool pcie_pasid_check_ctrl_bit_enabled(const PCIDevice *dev,
+                                                     uint16_t mask)
+{
+    if (!pci_is_express(dev) || !dev->exp.pasid_cap) {
+        return false;
+    }
+    return (pci_get_word(dev->config + dev->exp.pasid_cap + PCI_PASID_CTRL) &
+                mask) != 0;
+}
+
 uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev)
 {
     if (!pcie_pri_enabled(dev)) {
@@ -1359,11 +1369,12 @@ bool pcie_pri_enabled(const PCIDevice *dev)
 
 bool pcie_pasid_enabled(const PCIDevice *dev)
 {
-    if (!pci_is_express(dev) || !dev->exp.pasid_cap) {
-        return false;
-    }
-    return (pci_get_word(dev->config + dev->exp.pasid_cap + PCI_PASID_CTRL) &
-                PCI_PASID_CTRL_ENABLE) != 0;
+    return pcie_pasid_check_ctrl_bit_enabled(dev, PCI_PASID_CTRL_ENABLE);
+}
+
+bool pcie_pasid_priv_enabled(PCIDevice *dev)
+{
+    return pcie_pasid_check_ctrl_bit_enabled(dev, PCI_PASID_CTRL_PRIV);
 }
 
 bool pcie_ats_enabled(const PCIDevice *dev)
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index fc02aeb169..d4e065db82 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -165,5 +165,6 @@ void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,
 uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev);
 bool pcie_pri_enabled(const PCIDevice *dev);
 bool pcie_pasid_enabled(const PCIDevice *dev);
+bool pcie_pasid_priv_enabled(PCIDevice *dev);
 bool pcie_ats_enabled(const PCIDevice *dev);
 #endif /* QEMU_PCIE_H */
-- 
MST


