Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E8CC31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8oN-0007iA-W6; Wed, 03 Jul 2024 18:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8oM-0007UP-7r
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8oJ-0007a1-F9
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720047045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H7aKbBLrPfQyo8uVQsyzpZUHAgZT+25N0abSYuF1Pc4=;
 b=Pr+wNY/Npov9cDgCtEgot2nqs1BCakG25Z1sCIFD81i6UhxZUNWA8K6fsgBXXt/j+p5VNG
 Xh60CPYrzHl9hMq8+KYeLbJg/7VeOQ1Z2ML5PGcBntxlMfXmyaNcwbGWUSu5Qf+ViKKdVM
 d2PjFP3h77P3CjKNYTxWIc3tGAQ3A7c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-epLLlYnbMkSYBVL576DsIQ-1; Wed, 03 Jul 2024 18:50:44 -0400
X-MC-Unique: epLLlYnbMkSYBVL576DsIQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-367988464ceso40855f8f.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720047042; x=1720651842;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7aKbBLrPfQyo8uVQsyzpZUHAgZT+25N0abSYuF1Pc4=;
 b=mbQziGLCS8McYsdaVSdP1+gpDVbK5aITPhnQfenrD/dXU7NYAk3Lukje17t+4eB30L
 22jENLmCG4E8L2ifUeqTKiPW9VVCmfttFYptvUHliyON4YlB7nY+UUAEbnDufoppW2RT
 OtOYgs9Rx1NvCX4ktMbamy4empySUypxI35YGA1h3Cp4ts2DYUo5y5rVonutmtxlIxKQ
 lrVtCSQSzFDyfnG2myOQVYniil1m8UXowt/7DVn8bR7D20zrbiC6JqJ7lPQmSkwdnMgO
 huQ4jQ0snEaJpfyj9Php0v3TtFyi00yMhgDEKekKkIFHYZbMhhzSaXu0eiWyZufC+jXK
 4kOg==
X-Gm-Message-State: AOJu0YxE/S6E9Q3tcmAFhixQI16XJCweVXJ1xrxkQ4a+JWGO68x/jrRy
 AWOKyz/EE2DJkM7wjywwS8kIOoDqRR8c/VOz+Jei0N+meLQx6ZGg0nXUHCnJ8vMDxBESWtk+ilY
 sc1naIl9Utrrw33Qurw4OrjWiwmf/nL3hUJOP8d1bbk6R67b+bLBC2OHghyV0rt7MLVq8240R7d
 c3hiaNWsOGkq58cnzEh9oM6R7oVARvvA==
X-Received: by 2002:adf:f105:0:b0:367:4dc3:7943 with SMTP id
 ffacd0b85a97d-3679dd7e4demr4349f8f.71.1720047042323; 
 Wed, 03 Jul 2024 15:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu5Wrm8OprHgFlPV1jKUftykv1SlnbBuYekfIAVH8n62lAPpjkw8SVNEo1OXHM8hn/OV4F1g==
X-Received: by 2002:adf:f105:0:b0:367:4dc3:7943 with SMTP id
 ffacd0b85a97d-3679dd7e4demr4336f8f.71.1720047041791; 
 Wed, 03 Jul 2024 15:50:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36791d7a93bsm3000735f8f.81.2024.07.03.15.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:50:41 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:50:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v3 84/85] pcie_sriov: Register VFs after migration
Message-ID: <107a64b9a360cf5ca046852bc03334f7a9f22aef.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

pcie_sriov doesn't have code to restore its state after migration, but
igb, which uses pcie_sriov, naively claimed its migration capability.

Add code to register VFs after migration and fix igb migration.

Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-reuse-v10-9-7ca0b8ed3d9f@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie_sriov.h | 2 ++
 hw/pci/pci.c                | 7 +++++++
 hw/pci/pcie_sriov.c         | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 5148c5b77d..c5d2d318d3 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -57,6 +57,8 @@ void pcie_sriov_pf_add_sup_pgsize(PCIDevice *dev, uint16_t opt_sup_pgsize);
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
                              uint32_t val, int len);
 
+void pcie_sriov_pf_post_load(PCIDevice *dev);
+
 /* Reset SR/IOV */
 void pcie_sriov_pf_reset(PCIDevice *dev);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e32a69f3fa..fa85f87b1c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -733,10 +733,17 @@ static bool migrate_is_not_pcie(void *opaque, int version_id)
     return !pci_is_express((PCIDevice *)opaque);
 }
 
+static int pci_post_load(void *opaque, int version_id)
+{
+    pcie_sriov_pf_post_load(opaque);
+    return 0;
+}
+
 const VMStateDescription vmstate_pci_device = {
     .name = "PCIDevice",
     .version_id = 2,
     .minimum_version_id = 1,
+    .post_load = pci_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32_POSITIVE_LE(version_id, PCIDevice),
         VMSTATE_BUFFER_UNSAFE_INFO_TEST(config, PCIDevice,
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index fae6acea4a..56523ab4e8 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -252,6 +252,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
     }
 }
 
+void pcie_sriov_pf_post_load(PCIDevice *dev)
+{
+    if (dev->exp.sriov_cap) {
+        register_vfs(dev);
+    }
+}
+
 
 /* Reset SR/IOV */
 void pcie_sriov_pf_reset(PCIDevice *dev)
-- 
MST


