Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89085C3DA45
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 05:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTE8P-0000Pn-DC; Mon, 15 Jul 2024 01:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE87-0008Ll-N5
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:20:08 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE7y-0007RS-8Y
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:20:07 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3d9e13ef9aaso2515037b6e.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721020788; x=1721625588;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YW/hY5XCH9ysRbsD3Qw09WbyPo+KgPIedwlSdOeEQ/I=;
 b=VzZmLZmr7q2xwEIUbv44GKi5Vl6mvNijx/Ig0yyaCubVFmuaMXQZcbuZfSM5WCchTJ
 Kx9DOo8z9RODFOcTNuBfdeJ09an6OetkDNqwkL+wJUFEeHrEpdBuTPE3YTQi3oHyMj4S
 HFM6KB+giuBLPSbEMK+V2U/DNFhvzHeG4sLovs4I8O6/LmrbHCbVQaJfOGSuAheQRiqq
 KGqsj+su2FXawj4IBCrC5HPTGu+zlK/zcbndHDuPdxg0wEgmQq63TyfnN4rCqP30x2IQ
 ZboAFhPL0U9d1ASAs+g92qoOyLqOrpxBgHzPL4TDRnxNL4YYtIBkWEQiHUYWvxW0GJ8Q
 1esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721020788; x=1721625588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YW/hY5XCH9ysRbsD3Qw09WbyPo+KgPIedwlSdOeEQ/I=;
 b=klkMom2N37dAEGNZ9uRvclaqJHqpomgyp8qP4yUNzB4JrNRB+Z5yr4VAKAh1sAp6ca
 RThFI1CfIR/ZNAQXzon3En18xIyTWfsiLp4QgH8ohm0aEagQy1IDDhYUYQGuIx2DT7H+
 0pV7pSVDa5BEtq2WE/zfnyGFP7k/nie0zFZf7knXyPB4rclrufiDY9/IZekKv0cl24YS
 Qep/IReVTKn76ws5cteE2/yoMVenTsr+hbJdlSAmYsTyowKZkgUMRMWWxuyVfDnj++o9
 RPMup+hp/jO1MTpR56k7ZpS4tqYWUyM5CqG326TscthDGwLT0FY8Pq58rtyYx4n23LwS
 O4ZQ==
X-Gm-Message-State: AOJu0YxZqUF7LTc1PIRKtWjI1p04uCCeE15d6gMRrKndcTNKiseg1qm0
 Ekatpa2fxZA94xUgAoF+jCtDFkWcQymFzQnebTU9UGmwjxSuID/TVpoigIX8MLw=
X-Google-Smtp-Source: AGHT+IFN2JQLdponyCJBZ1jucvrPQlDscMYYstuf9XCTzad79EXooRWCe+QA57JVUTSx+igDfVwE5g==
X-Received: by 2002:a05:6870:82a4:b0:255:1819:b444 with SMTP id
 586e51a60fabf-25eae75ec76mr15200830fac.7.1721020788160; 
 Sun, 14 Jul 2024 22:19:48 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b7ecd301csm3437136b3a.220.2024.07.14.22.19.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 22:19:47 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 15 Jul 2024 14:19:08 +0900
Subject: [PATCH v5 2/8] hw/pci: Fix SR-IOV VF number calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-sriov-v5-2-3f5539093ffc@daynix.com>
References: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
In-Reply-To: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

pci_config_get_bar_addr() had a division by vf_stride. vf_stride needs
to be non-zero when there are multiple VFs, but the specification does
not prohibit to make it zero when there is only one VF.

Do not perform the division for the first VF to avoid division by zero.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 497a057b79f9..ae7137d70579 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1490,7 +1490,11 @@ static pcibus_t pci_config_get_bar_addr(PCIDevice *d, int reg,
             pci_get_word(pf->config + sriov_cap + PCI_SRIOV_VF_OFFSET);
         uint16_t vf_stride =
             pci_get_word(pf->config + sriov_cap + PCI_SRIOV_VF_STRIDE);
-        uint32_t vf_num = (d->devfn - (pf->devfn + vf_offset)) / vf_stride;
+        uint32_t vf_num = d->devfn - (pf->devfn + vf_offset);
+
+        if (vf_num) {
+            vf_num /= vf_stride;
+        }
 
         if (type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
             new_addr = pci_get_quad(pf->config + bar);

-- 
2.45.2


