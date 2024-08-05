Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60B0C52D70
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 10:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sauVt-00061u-0q; Mon, 05 Aug 2024 06:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sauVm-0005eG-OU
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:00:22 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sauVj-0001ea-LF
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:00:18 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fd6ed7688cso83416275ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 03:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722852013; x=1723456813;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=To+Ctud3IiVbBDGeLTlPr7QPErynCEwbUoWpPwlxWjU=;
 b=MfQD87xb0ZFC0m7vw/cqclGfSfBd2//K5mleQ+C92ux1AMrZEsEJOA05wWeMiJKsph
 FO4u/NeS8xIf0V205yLhe5JqeQG/dcZ/PqrKS0u4Hi7izPb+j3KfOnCWlQFMKiwASqu9
 W84NxXtxu6en6sgOsiU6+Eta+MKpwVmRA4Qxr5j/EJDAbQ1aLwArR6f2N+MHSXTc4hET
 QVS8Xz5HT8BaDeRKw9Bt5W1KaLJNTvSQ2jUohdRXTE4NMQCh8Kowm9VEEf0Qnhfjkw2m
 MwZTdg5AJlFFL1/KYE5tfJYERPlgT2EWnYJ/Vi5gsbNIHZe3U16qS0H7mCqO4jiiLCt6
 A0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722852013; x=1723456813;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=To+Ctud3IiVbBDGeLTlPr7QPErynCEwbUoWpPwlxWjU=;
 b=J11nGFeUQ7Wkk3Ijp5seUP4MKEzWZzzmcn54hMjHxwoRooyAb9dMi7f7wJLRlpN5RI
 FdPLaJwjCQw/q8HhezOWs6WlUcUBV5DXvlZVEl5w45v2KdF8KxCQK+J3B0aa+qKxVQJ5
 mFHLiP5YgtsXVoQ7pQrLsV9vZ2ru4OvomYYHYfwiHb+pViuNJnyTBnqe43QSHmeJpFO2
 VnNpF0EENpWIt58iusbYYDljxCi9KBB4Ei6s4oXdAH5iDolUYN2OmdVciwMsyvgkmk84
 FG1NDzqsI4g0cFF3gPOIIMewQS9ialxCQ2wb7ZhDEc1/G2LtTTZLgFw+CXgHCmOopP25
 fNBw==
X-Gm-Message-State: AOJu0Yz2KTVQbWVWar0t4vLF1E0ria1WXF1FqGbdIJorcNqkE5zm7Y4w
 KfBcW89WkknLRhGgYYtaN9gSeZwqGQ1rTQRTPHiZIFsW3V1nmGSjzWIGFqXGlJM=
X-Google-Smtp-Source: AGHT+IEWO+amb9QWF5YS5JTUjbvkpwD+WkE3hYlSaIg5RY2zqq4XYUN+my/OSAQKlUXAUQIMaKItNA==
X-Received: by 2002:a17:902:c402:b0:1fd:d4c2:a2ef with SMTP id
 d9443c01a7336-1ff572910d9mr124199815ad.21.1722852013232; 
 Mon, 05 Aug 2024 03:00:13 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff58f29e02sm63801855ad.18.2024.08.05.03.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 03:00:12 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 05 Aug 2024 18:59:07 +0900
Subject: [PATCH for-9.2 v13 10/12] pcie_sriov: Register VFs after migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-reuse-v13-10-aaeaa4d7dfd2@daynix.com>
References: <20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com>
In-Reply-To: <20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


