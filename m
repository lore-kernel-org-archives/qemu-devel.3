Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D5CC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiJh-0005DF-SG; Thu, 27 Jun 2024 02:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMiJd-0004p9-Vo
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:09:06 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMiJb-0003gT-TO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:09:05 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fa55dbf2e7so29600395ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719468542; x=1720073342;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BD2+P7n2MltpPV9NbpDQhfkqtNBJBJKWoF3oTQTpA+U=;
 b=N5WAgiaRfl7ebOaHl2yu5llTgX4xbCIyx9wvJ1U1bflnTHTIp/5PTKEaAe5sG0lUiE
 v+DmNhG0pcVsOiomu+UG2HbPXHEs8qgvgF049HZygD2NeDbrcD2lR2wZTqTPzVf6Vrzu
 B+q9JDJSGDGHAJuKQLkNg0rDoC/pMIRbZTnMfmP5pNkehSKCrMeYHCWOheiNLh3ODCeF
 NxXc7uIT9lbeZ1bpJZBApbJg9PRQDF/PacrvjWUCGAvAJ8ZU2k853WnAkdb9AfBRG9eG
 sBaGsD/6u2USkqIRj0JtFNBvRnsTWuWwzi2VKO8YGb9d9uFu43mvzwBXRQnNkLmK2azi
 1fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719468542; x=1720073342;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BD2+P7n2MltpPV9NbpDQhfkqtNBJBJKWoF3oTQTpA+U=;
 b=rBl0K2VXxAlpQHJE+fzr4ka/38qD9mrgJeENjrGafG1PbMjI5DgJ+8XaXk4ShRNXUg
 99ZshEJFCiRCBPGnJ7UpoOdgpxtVDMs0DdFF2FFOljubWEKNt6A8OUoTE83HBje78fZH
 EuRwJK+cAeInt+6wHAn77+za7sMZYD29awSM4NN/khOVdzzvt4JHOSpStRmXGABAmWw9
 +Xqeq1JymaD2pJr8dMynMwxH4dvUjrQOc+N/UpF14N1H1k31GgZFgHAR0cUZRverVNyE
 i7GR3+A0eq1Ogp+W+9bPR4DQMjWsqej9hG/LiW2BDKCW/uq+v5vmL2KnwMmpmbRuwZck
 Ex9g==
X-Gm-Message-State: AOJu0YwagXqyLRRDV/SvYdSgrWLwA9TjYpvrt27ZRJP/4Tgl2N8fcH20
 AmIL6SxCIeY/ExcDzQVhS+z0TRgyw+awnRSrB+X+1jMXL54Xry0BgHGhlJqIeLw=
X-Google-Smtp-Source: AGHT+IG9QuCGdvgFO/wQTloEvdW89/n46Kf0289NynkI+nwKSgnHuv2wCkFp9AFO5LiydnF6thaDeg==
X-Received: by 2002:a17:902:d505:b0:1f9:ec64:fd44 with SMTP id
 d9443c01a7336-1fa158e3c8emr137677545ad.27.1719468542528; 
 Wed, 26 Jun 2024 23:09:02 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac9806a4sm4913955ad.166.2024.06.26.23.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 23:09:02 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 15:07:58 +0900
Subject: [PATCH v10 09/12] pcie_sriov: Register VFs after migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-reuse-v10-9-7ca0b8ed3d9f@daynix.com>
References: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
In-Reply-To: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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
index c682c3dcb68e..af1c743611af 100644
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
index fae6acea4acb..56523ab4e833 100644
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
2.45.2


