Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96643C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 09:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saX8O-0001ja-90; Sun, 04 Aug 2024 05:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saX8L-0001Z2-KS
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:02:33 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saX8K-0001Dr-2w
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:02:33 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7b93883666dso296913a12.1
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 02:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722762151; x=1723366951;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=To+Ctud3IiVbBDGeLTlPr7QPErynCEwbUoWpPwlxWjU=;
 b=X/gVaYwQ+f86hpMTG+AP9cnpkkAPi/ctnXVLzupMB7cqOMICI8ji2hcZoJK1vmiME6
 UUNHweuOJjUfCxZpdvYLlS5m17FjvKslAoYAS9bZ8lMWTu41FBMNregzhNa+gN2c657s
 8LWtX4ceZ5VRDvwibvswiAtA9xb2tcL139BaZIUePbHdeeDLbxO6xr0FyDoy9rg4tvpA
 BtRN7B/5i0wCdjxd4G0qDfktnPYPdZnIbdGdYc9XmbPwLO6wutiadng7A3FUMeLydIaB
 uGY4IwxMPQ8GEd33ak+yEpP9FRoyeexAeiSNAtkKPTh3a1BhveM8dF4TOrw9TbuGykNQ
 mMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722762151; x=1723366951;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=To+Ctud3IiVbBDGeLTlPr7QPErynCEwbUoWpPwlxWjU=;
 b=e8ma9JbpF0vOxjUEEPS9/K+7KzYc9FEmg8B9UX6+QZnauDLFDODV6p83+gUEf0sd5h
 npnP++tFwtThSkyZWadVH4QXbAy8SByg2o7QM1k8+wlgh1HT4GdhvZ+oO2KJbRzzMqZP
 UsRgwLIS83om3HSOFZ+Q7vgATJZ9DdO42L8W5x+ljJjz2tR49TSWSI17vi66yo6VrEmn
 pkCYeq2d5YfWSiDpSg67zMgV2TBpfiO2OUMDeqMTOnKypuv5FOKBnH33zsE6VOsMHVCh
 WRsScVmI/4pdoXcp1L5n20TumINY134VLkNtSgpUHjnsmYSNpkldNQseRDg3F+/XrfdU
 eK/g==
X-Gm-Message-State: AOJu0YyexKo7o4WmxbLyp4GCjfwPbpwaf1KodSpiaKpbehdRiv8kPcma
 3+RxkmNPr5P/uah1j1wR72ABOXtGGzIVtnpk9pnsS8lbAkd9Vd+7SlVH+XlDm2A=
X-Google-Smtp-Source: AGHT+IGdk6jbGflR3bABmp+vzCoLrgxkt9H8nToJGshM9tg/Xr5rIyr/JKBFis37r1YqtgcrsdbUpQ==
X-Received: by 2002:a17:90b:314a:b0:2c9:a831:3b7d with SMTP id
 98e67ed59e1d1-2cff0b261abmr15563122a91.18.1722762150869; 
 Sun, 04 Aug 2024 02:02:30 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2cffb36a1c2sm4657896a91.44.2024.08.04.02.02.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 02:02:30 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 04 Aug 2024 18:01:45 +0900
Subject: [PATCH for-9.2 v12 09/11] pcie_sriov: Register VFs after migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240804-reuse-v12-9-d3930c4111b2@daynix.com>
References: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
In-Reply-To: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
index 5148c5b77dd1..c5d2d318d330 100644
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
index 5c0050e1786a..4c7be5295110 100644
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
index 91b6ed46959d..663c1d0cab00 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -254,6 +254,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
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
2.45.2


