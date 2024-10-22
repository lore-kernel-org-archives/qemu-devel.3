Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF667D1CDB8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3APK-00040u-L9; Tue, 22 Oct 2024 04:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AP6-0003sy-OC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:38:13 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AP4-0001aT-TM
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:38:12 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20cd76c513cso44606365ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729586289; x=1730191089;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MV0l046maJwkqtz/pbKbRih2e1ce6szoak1X0m0d4Rs=;
 b=3WN47AxWfKQGogoUbaHNsvh/HcYjJ4FGaf0yVfnWo+moKO5oHJVY5KitXpV76ld5fy
 RDRtwtW3EoGv4LDqvNRqF4g8Favr+u7X80h+O+Ag+RAEg3h9uUterE7u75CTvTnn3ykz
 MOim05mfJ6/MbkUT04u8npDhvgQ/OIZDegvViqO9VsVppxTepmVwyaqmDIT4EEPqGlpq
 LMrWPfgZ4pvpWu7Dfc+FubGGd7A/uelPaBDzr62u+IAy80l7lq9M4dOwlQAuJlP9zP24
 SM83PBTSLeNDk/HfyO9hmEvIUojgc3khqoDnuRTsENqHfRuOLII/W3pEGQ7wBDdpQl8S
 ZR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729586289; x=1730191089;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MV0l046maJwkqtz/pbKbRih2e1ce6szoak1X0m0d4Rs=;
 b=Mn3vDagspJU0lEVq4SlIZHikuf4gKSi/x2VdN20qoqQ1ZB6whgAgM08rb2gxpSWB+q
 ZW9skwas0AUaA1XMcO4zGqoBfcrgbSa73zwG936IKQ2kzg+QT3/a+dcY68TcvaVJPJfE
 QJ3fvYD8COM9M6hOnPs3oOWxuUwipaxN7MpsTkof8EJWLzsj8fG/CCpV4IcuY43NwZ/E
 K17JdNZwUbHs2+a0mO2GlZScW4e7ZO+Ks0XmNB269g0WRnrAujSxLX8g8WV97inJ0fL3
 ni8Jtr3Drp5gZV/we4i6gqmXqiIBxPjOIq3dla6EAhu32qIKE1qnQHQw8vxJI7UIGfNy
 B4nQ==
X-Gm-Message-State: AOJu0YyzAxH9RN5rDbNdazsKJckriTYpF5zAvON3OjAoSNCeiuTzQWHf
 I5Mec6hkyzOVCyyAFvQPngqgoB0yIU3rDHGLTMuH2NXHMmpSK4wQxFlnOY5ob5w=
X-Google-Smtp-Source: AGHT+IEqL46JraT+D71kkk1lHx7Z9c3l5O+1D6oqfCRmVWHI+tKOniiPLNdh1+Uz7Hi4mg7ml1kv0A==
X-Received: by 2002:a05:6a20:289c:b0:1d9:6c07:6481 with SMTP id
 adf61e73a8af0-1d96c07650bmr2861055637.42.1729586289495; 
 Tue, 22 Oct 2024 01:38:09 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2e5ad4ee3b0sm5462860a91.42.2024.10.22.01.38.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 01:38:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 22 Oct 2024 17:36:49 +0900
Subject: [PATCH v17 12/14] pcie_sriov: Register VFs after migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-reuse-v17-12-bd7c133237e4@daynix.com>
References: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
In-Reply-To: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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
index 7ea751fb869d..8120d7c4c5a3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -735,10 +735,17 @@ static bool migrate_is_not_pcie(void *opaque, int version_id)
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
index 69609c112e31..1eb4358256de 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -248,6 +248,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
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
2.47.0


