Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50CAEEEC0D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 03:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxFr-000759-Cl; Thu, 12 Sep 2024 23:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxFe-0006Mi-S5
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:45:47 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxFd-0008I2-7d
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:45:42 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-719270b7c94so368505b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 20:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726199139; x=1726803939;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FImpPBK9Cgx1Gf66dh6YNz4HB2eDE7e40q5spQfStSw=;
 b=wjsGOHwAwELGm9Y/0/xdOZRSCRr32yB9l8u1x3WJT+4s3R9pmTIncoCkTSyQdshUiE
 CbCHQElp5Qmfv9/b/uClzQLtxWlaND1z8kwGLfrvssOza1LLqDS0M8fhrS4c98yofivV
 IrCxNgUa+Xlb1kp2/2jN0GH99shK3VynzdlmrbtmgWvAA/bJ+pahIzdaWuSAVDISsVxa
 FRGZY+pg5G2l6D0qusaVGlhS9pJfcj2h9Bcjo+ZUO977Hj+2KIMxuHQcGVFz8tvS1Zpr
 C7cGJaVx1bsl9pYCjyoipKmbLFBLguWFEVUpH+xOHhJINcMy2BZq6uQ85jfLdfY+7Mxa
 xwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726199139; x=1726803939;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FImpPBK9Cgx1Gf66dh6YNz4HB2eDE7e40q5spQfStSw=;
 b=mn2DQMGoYSIkyj9eifQk34TCXzGhA5s9YCgrNc6M26v6HzcpGMzIBawlPA07HYINRY
 uTXO+2olFuYK5m8upVHb1YGFTpgPelWkC/8oFGZRjwkpCjO0f3RKoCuudUl/xZrbaPwb
 ibtv3P5snYJ0rOz8zEHmg0VH0hLZY/MX6+jKueAvtZaJt7jbj7ExzLkfzIShXS2VnxEn
 Szv4AwVNGf4icMYN++6DKr0bN9bHN+W+oUajjL6AUopiH3gMQWHHtMvKaLF7o6SGds/p
 8jvmsggcbr0gE2IV5SwEGzviOWeh7TT4nbm3C8PSADjBlvOLXhjJ7oGWJCBIA0UcW3aG
 4xsQ==
X-Gm-Message-State: AOJu0YzeSCM+b1e+1IEpqr+OXXLqgnCCcrdBG0hNEAsDLdlJWz6jMS1y
 hJ1BQuZ6Xx2nyB01wFtOimcaRHMFRsGXRTPN8eXe7YaZDYPdX/viiYGCdUVRQnI=
X-Google-Smtp-Source: AGHT+IFZ92JFgPoJR/f6JSsEiDWA+QSZP/Fpu5y3VBQKRo8vzA5OBuP7Bwn4INk/+OBAKliSivUAsA==
X-Received: by 2002:a05:6a00:1701:b0:717:8b4e:98b6 with SMTP id
 d2e1a72fcca58-71936adf4a5mr2357585b3a.21.1726199138641; 
 Thu, 12 Sep 2024 20:45:38 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71909092335sm5259232b3a.113.2024.09.12.20.45.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 20:45:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 13 Sep 2024 12:44:39 +0900
Subject: [PATCH v16 11/13] pcie_sriov: Register VFs after migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-reuse-v16-11-d016b4b4f616@daynix.com>
References: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
In-Reply-To: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
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
index 47028e150eac..a1cb1214af27 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -242,6 +242,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
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
2.46.0


