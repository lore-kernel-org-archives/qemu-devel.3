Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F09E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyz9-000368-J5; Sat, 04 Jan 2025 02:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyym-0002f5-6d
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:53:52 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyyk-0003AF-Hs
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:53:51 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso176373105ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977229; x=1736582029;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nq5kA+rAx2s39hfKGaHhph3umAuBYnelbLPjqvJGEKM=;
 b=AaPG9Ly90LO2wr8OeF904FAJvUeJD+CrSq+lNJAIhSxa+ucNRY8FT81VuqJ9OMNevM
 5qwf8u+0wUQEWOrgWuW7M+GKwWP/8MR322u0x69SUIJGB2xuok8mixcbptWnjmeZWXYu
 cYl04Dq7/lB78hhMU6/TRv1Xt8I/fOvizW29Nis+OiTozoc9cttsDFi7kgALPgzws5a4
 iZ+XU3ETg7eg0OrBozkNH3AkSvk6EZJFjdKEHx9P93wtN321R6kj4B6SY0xq0v0T35uG
 zaW22WemfWzLwgY8CCh8kzP7RTuRhlPMIqc2K7YcFF7LrgBr6ntuvmttCEb+qZ25kWmi
 pKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977229; x=1736582029;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nq5kA+rAx2s39hfKGaHhph3umAuBYnelbLPjqvJGEKM=;
 b=iikJNvwaqRiWZf9aCMd4Ny7lOUp8jbMjfrjpTrnEAw7pTWHD2Gh2iIRUOSMhcAEHBK
 EO0k9gTj9fOzkuHakSE2XsDXB4tQQzLJtFfFXqjGUV2NKXuGShlbZtMARo4rAI0h6eYk
 l56tPjrWSLVr7N+tsk4wao5b21GW70PhIK7icovfqp2ysUxU3UZE+6n+M4RbPDpkrdtL
 R+8I4w6PnR29GLToH7A1NEshZa4TlhkSD4o9k6kVu9AZkcJmTcbKnqGvQm+vlQ7p9wKl
 wykDR82cNaadcjEVUPcaUcBSWGvc25p6ceF1RP1tUm5mbF7MG7J/3IEScp0IDSzPh9tZ
 hEIQ==
X-Gm-Message-State: AOJu0YzAKMyK6uCYMFaEOmwnzth268BriwJEveRWq7vTkaSCdS4NCzYc
 fbd1b/p1Mip5o98YKG7P4SIAOl4XzJ3GoJWtUmz/Ytnjc7G6Uc7FoTQBSkgVJ5o=
X-Gm-Gg: ASbGnctiI/lNnhhDaRyS6kONYZgNhwRFmhjyNknus6pnE5bZJeCzq0Vl+WKvhvnqCRG
 N6IFts7AQK5nwV3sTy569qXwEZjWbfuAgEy0uM/xl40b0WVZiSCDBmDY75ZPTxHj404kRRE1nWq
 wI3T0tTCAHo7lEck4VYVe4e1aiV58CrNj/RgBvOplpfI/2JGc0OEttDiU11OwdmjXt0Qz53mscJ
 J38YA3J7O4in1vYKWPaWzY3sC1c+D8uSKKbosogYPFjdtrMWFJ+39dHxl+x
X-Google-Smtp-Source: AGHT+IFSA0Cm91Hfo2b9s3W0fbZslWaAHdr0O3a3oYlX+TrKRpvIcZwgspbGH3vxth818ttd96wsDA==
X-Received: by 2002:a17:902:fc44:b0:218:a5a8:431a with SMTP id
 d9443c01a7336-219e6f26013mr809481215ad.49.1735977229290; 
 Fri, 03 Jan 2025 23:53:49 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-8427ab7830asm25218874a12.0.2025.01.03.23.53.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:53:49 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:52:32 +0900
Subject: [PATCH v18 12/14] pcie_sriov: Register VFs after migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-reuse-v18-12-c349eafd8673@daynix.com>
References: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
In-Reply-To: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index d769952e89ba..2724297ea43c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -803,10 +803,17 @@ static bool migrate_is_not_pcie(void *opaque, int version_id)
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
2.47.1


