Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3278AC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 09:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdoHu-0007F4-TR; Sat, 24 Feb 2024 04:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHs-00079b-Hg
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:40 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHq-0002tb-RR
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:40 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so1521903a12.2
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 01:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708766736; x=1709371536;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=53XyZW+eFVvoAPfI8083D4zbyq4zLHK5w/Vl/6iTbj0=;
 b=kRg5w/IzmQzpHHM2l3aVD/AapVeRToZlgbT/HjkRGhxy1HvXn6qdh7GO4ZR06tcQb8
 RLuK1UZtg2xQazqfvecov+YuEvyFET2s4RYkULynwtytmg1lPBDUhVnOBcvvDneQfCz5
 UjXGnxuTEFmUAsuMNEN3u8urHwxZ1guRGQxO0JMa/AF/ZnIBaSU4Pr6i2GfJ92emZdJq
 ARYQm8n7qTgBLKapcFB4uIo0zrq4eRNgMBB6mhtKtKG5HrX6Khl5srgxXWps+Zdw/K18
 u3ob42+z7ua993UuWJE/NTJeN2+ZGX7PAUVKauvA5dXaw5UgMtziPhXABC7cLg9GNAmI
 kKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708766736; x=1709371536;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53XyZW+eFVvoAPfI8083D4zbyq4zLHK5w/Vl/6iTbj0=;
 b=mMxZszbeiNBH7y2PbJOSeEVRdAE9aj2aiBVfUhm1Mx3Y/iTX3EE70Gm2fe9Ruk9x84
 h7EvFZrRnTUz9emr4r+yFj75jklR+t5WR0cOYtISf1nPIlxyHiNoNgy91P/RiqzDuojw
 xEjxrmUfvlodVHKf3TBkVtuNSGnAms6I5nNcrRg+WvVQW/lQozsPJOFCV8fu1CXC2ZPG
 5SQiNaoBRz4XAh8payQd9XxSTCO57JkHKiRtel+sQ/fdt0W5bNix76FLuGo1EgrTAmo9
 /luPJR+W+gqOxDULIjMhCTMUBd7kBxPPpLNiSpK+YvF6lmVYn5sOqmbbCiutGiWlHFEV
 zy+A==
X-Gm-Message-State: AOJu0Yy5SBGRBFhSDWSyzGHmwxUEdMJVGCaeHOvurN3hbW3dz4M29+Oi
 Mt8KYC5huUEKf5YxuHQNuq4HsdF1UR4Xdm/7phRV0Al4q5mjMqePMZggr2LY9G8=
X-Google-Smtp-Source: AGHT+IGqDqvo/u0iRU0Wc0/FCIqu9x5HRXEjgtt+Txz9d/kt9sb1c7Llbsi9bMLlNGIiiaoxPUW7QQ==
X-Received: by 2002:a17:90a:1b82:b0:299:41de:9fea with SMTP id
 w2-20020a17090a1b8200b0029941de9feamr1649181pjc.15.1708766736474; 
 Sat, 24 Feb 2024 01:25:36 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 dt15-20020a17090afa4f00b0029954a48c38sm847129pjb.38.2024.02.24.01.25.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 01:25:36 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 18:24:43 +0900
Subject: [PATCH v7 11/16] pcie_sriov: Register VFs after migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-reuse-v7-11-29c14bcb952e@daynix.com>
References: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
In-Reply-To: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

pcie_sriov doesn't have code to restore its state after migration, but
igb, which uses pcie_sriov, naively claimed its migration capability.

Add code to register VFs after migration and fix igb migration.

Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pcie_sriov.h | 2 ++
 hw/pci/pci.c                | 7 +++++++
 hw/pci/pcie_sriov.c         | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 793d03c5f12e..d576a8c6be19 100644
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
index 750c2ba696d1..54b375da2d26 100644
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
index fb48c1a18c9a..09a53ed30027 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -239,6 +239,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
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
2.43.2


