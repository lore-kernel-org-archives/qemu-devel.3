Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A7DC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 09:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQdj-0003vB-4v; Tue, 05 Mar 2024 03:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhQdg-0003tr-WA
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:59:09 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhQdf-0003gm-Gb
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:59:08 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c1ea5e54d3so1208279b6e.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 00:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709629146; x=1710233946;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cIQOQVYqY0DEobqSlWtvEDM6sg4WeMXNv2XNh/AB3Us=;
 b=rlc+2hnse5zsfJQ69VSNIyp8t0NgMiBUK/0gVH0JmlmlvTgHTkNHwwV1obuwbvlHmW
 O29QVl0FQWcQBbRhGSFhRBaB1VPRfY+4ZGzBuNUkEp8OZJ8um4cJpxVpESVopOeEkgMV
 cgFATlkie/eK3W52uQp1Fc4c88s5HYYwA/aJa21RBVH49XtW7J8nwKAAfKwVdeHLHTkB
 65wxjBXfUaZU1sHHV72P84pKVWr+d3463mMrLVwEEazwRkGlcsZoV3HM0BaDMmXOcgUg
 +B/Qxm7jTczta7bJZbB9thuv+5t9tTT2Vj+jVciZ77+LospJjXeJ7XMtot9ND0IKYxqO
 s2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709629146; x=1710233946;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cIQOQVYqY0DEobqSlWtvEDM6sg4WeMXNv2XNh/AB3Us=;
 b=EsC6yiowJFjlN1Oa6LNxy3qrS/G+WLi2VIeZ9I3sntBCDygobN+mPfBKD9C3E86xnK
 5wcvpsz4UKn4z6AIfUafrX3c5DufwClOWaPk1/AJHPaWmPDkRvn6qr/+7CrlS7u25/1p
 P8cldVAs+MxSU56UZZtMxBGSXksO24G5+qLSyGvy2Kf+sn8dFg3Whj0zvFRSW2X7VjHb
 yOCbrO73Mg0FkifCxctbroJbPJYKm8nnf4wHjQq6Kon558ZAth+IVctF3kdIp/mXFM1R
 in5Cbq4aJUQPlq2OKlUdg33TUwUk1BlWzgpMfZYUtmnVK4EYp81Pd84l9q50LkliNyWN
 tCZA==
X-Gm-Message-State: AOJu0YxtKcywdaf0JAeCAOaXE3tuLjub3HhA82slKc1VX4i57xV0cQsG
 5KyLIvckuLLpAbAwmMU9q/51T5DYpEfbx4pRxOFuaCbsBcaxKUZTItD4r2KcLe4=
X-Google-Smtp-Source: AGHT+IHaEIXxVTn9V25tFDYy8qk2ZpPmEsmn/nkR3cjZFqkRYTgQbxZsAqb9CliQHK1PYJDM9gRTwQ==
X-Received: by 2002:a05:6808:2186:b0:3c1:e699:4cc0 with SMTP id
 be6-20020a056808218600b003c1e6994cc0mr1595758oib.7.1709629146527; 
 Tue, 05 Mar 2024 00:59:06 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 q12-20020a63504c000000b005df58c83e89sm8716599pgl.84.2024.03.05.00.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 00:59:06 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 17:58:49 +0900
Subject: [PATCH RFC v3 2/6] pcie_sriov: Ensure PF and VF are mutually exclusive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-sriov-v3-2-abdb75770372@daynix.com>
References: <20240305-sriov-v3-0-abdb75770372@daynix.com>
In-Reply-To: <20240305-sriov-v3-0-abdb75770372@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 20240228-reuse-v8-0-282660281e60@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::229;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A device cannot be a SR-IOV PF and a VF at the same time.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 09a53ed30027..aac12e70f122 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -41,6 +41,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (pci_is_vf(dev)) {
+        error_setg(errp, "a device cannot be a SR-IOV PF and a VF at the same time");
+        return false;
+    }
+
     pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;

-- 
2.44.0


