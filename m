Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1A8C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAdQ-0005tr-8T; Wed, 14 May 2025 07:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdM-0005t6-TO
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdK-000698-Td
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IKAZdeC1S1a7fw9qgB21u9lSwuILgpD/qjXudGNtUBo=;
 b=Skxcvp1+YeWao0b5aXQO6t3217YYB/0P5yNGCDBn+PIasuwtyypnI3nSCIvkE01o06gRKv
 vqpboHJDbFbSjYS0s36ySb0SUVBH3sl2Q7kbm7lhwJ/lNjuVtQBvROsvPPMYsuEoPBHH4x
 HiQGpK0O7c5rFBweEB6mEOFkTXNi23c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-X9p0NMbnNqaXxO46Q1MYSA-1; Wed, 14 May 2025 07:50:44 -0400
X-MC-Unique: X9p0NMbnNqaXxO46Q1MYSA-1
X-Mimecast-MFC-AGG-ID: X9p0NMbnNqaXxO46Q1MYSA_1747223443
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d209dc2d3so33227895e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223442; x=1747828242;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IKAZdeC1S1a7fw9qgB21u9lSwuILgpD/qjXudGNtUBo=;
 b=miamk5nPyE745NfUaGYV/S9gfoTeoRMky4L78gJgote6uSZFh+AJjXcJnp0nDfE1Js
 EZxtKaL2v2JeGQLo9uNul40JlzMP43Bgy4sfC5few48YulJK2LjmIwhxqYmJluDrz+7q
 4amEroGndPatvjLV6LlGkHpIKZ1SL7oMaLb7Bbfkow8gCIKluHABc1YRky2/0Di2gG1V
 Vsjo2oHmn/crsXCD8W5QIE3Gn1mxQLx1azOHJNyJ+L5ae11mdx7c6B4OzobdJA20V1vY
 qBokUM+ZMtT2zyKThx/IirrgRwOF/Zuan3LlATEAHbMKZKZp3ZGlqdKtIS6rcpexyju0
 UQSA==
X-Gm-Message-State: AOJu0Ywa5uft4Td4S/bM5/tJOmYPyo4a1vLh+03niLigpXKnIMQl57e8
 vUE0dB/jBRWe3MCId9faWwNMtbcH6BG5SxF6bn4rjdxR2BVp+A+Y538PrUpmfuSao7WmoUDaun9
 AVlOnmjuTlYOxHeVmAAjMwQTUkUw8MGhgjTL5y9jG2vm4DiWqYfQozfBQOAOCoejFQ7yEU7C28R
 FR0k641RXqgCbUyps7pWujfeKqpppVmA==
X-Gm-Gg: ASbGnctoajoqPd9CQVQWe1mPQRJmZadngWpWADicWVXem1BhQHoOO3jWWZwofbd7WpU
 iU2Xew5TGFf+VHSeNC3DzwRXxwg2cM6YcGDKF1VFHHa0KcjCmS6mcsoRI8k98lhcGk+QMrgG8oL
 8sFoUUoGmOToeo2K4z6QF1NPBI3rAd24JB1Z4YUDxrmHCb9YlQEwKMl5yJFRqyp0Txy+IHbdCyU
 Sc/JlROCJ6CjBGeSTzC1yRzy7O338JSXeUrJbDtIe8k2lAPksH6JtFwIT/+SCvtxkAxg8mbyBt7
 NNisnw==
X-Received: by 2002:a05:600c:3d0b:b0:43d:ac5:11ed with SMTP id
 5b1f17b1804b1-442f2169637mr28554415e9.24.1747223442548; 
 Wed, 14 May 2025 04:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFAek8QV2KxEyF3x6dainSGzF5c68C+UJ4mOojewWvBDxJ2dgulkKshq5xW/wJzrkAJaJKbg==
X-Received: by 2002:a05:600c:3d0b:b0:43d:ac5:11ed with SMTP id
 5b1f17b1804b1-442f2169637mr28554145e9.24.1747223442085; 
 Wed, 14 May 2025 04:50:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39ef8c7sm26238315e9.38.2025.05.14.04.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:41 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yui Washizu <yui.washidu@gmail.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 10/27] pcie_sriov: Ensure PF and VF are mutually exclusive
Message-ID: <92b6ce3dba26bd3734b528bda7f9a9dee2ee7bb4.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A device cannot be a SR-IOV PF and a VF at the same time.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250314-sriov-v9-3-57dae8ae3ab5@daynix.com>
Tested-by: Yui Washizu <yui.washidu@gmail.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 1eb4358256..109b2ebccc 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -42,6 +42,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (pci_is_vf(dev)) {
+        error_setg(errp, "a device cannot be a SR-IOV PF and a VF at the same time");
+        return false;
+    }
+
     if (total_vfs &&
         (uint32_t)devfn + (uint32_t)(total_vfs - 1) * vf_stride >= PCI_DEVFN_MAX) {
         error_setg(errp, "VF addr overflows");
-- 
MST


