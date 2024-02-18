Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EBFC5475B
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 04:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbZEG-0001J2-Uu; Sat, 17 Feb 2024 23:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZEF-0001IZ-FV
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:56:39 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZEC-0003zN-0l
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:56:39 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5d81b08d6f2so2114236a12.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 20:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708232195; x=1708836995;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lANSO1jXSXyyYFwdiC0HZLY18b3MvIaJNcnJD+ikwbc=;
 b=KqUVa5XORA5TVed1RvoUi9ePWV9YrPSgUs0EM4fDp7gTwkqPHru31ghcclTffarEt2
 OfxVUSTIQrXvtwNfTCvh1dCDITMuqIe11ryfcq+WYi9aRzz8vHEwWK77EFakjXG/8njA
 sbuUIdbSdWk9MEwEVN5ln0eZAzhE+iRrNyYlyg9k2Ir3WSHB2PvjRHJDQNfaHzkrjheG
 WPi85bUElTKXVc4j7Y0BR+DfvQ7JBfXXiIHw43DWmiWrzvZ87+at87rPOsMPxTsAKa5d
 raAHOwTnBzBSSbnfIbIP6JC5eqnXyVHR2dxB5lLkw197W8IHljjCD+3ls5Ss7IEVCIjP
 aRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708232195; x=1708836995;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lANSO1jXSXyyYFwdiC0HZLY18b3MvIaJNcnJD+ikwbc=;
 b=vMdLKa1TxePO6Xo3kKhzpVxTkrW9FaW/SW8+9eHh6ghu/0HkXrCh7487Yq1z1HeFRa
 fKdqfWhNEylQ8LobuXNqoGaUS1bIZNdd4RRh54grDKnh5qGHziNF/knxSrQoeHxSs0Qg
 207E0p8ER8QY6us1RMgxKQBXUTe0EyHd3T/etz3b570GNt93qQpxfzon7bfZqjgph7Cg
 2tQrscIbe/6xFVxzps195533xhIiaq6zMi5nU3mWTJ6QPUd6GYhBsv5KiErcSBIC9STu
 umXb3CS4ALY22an6ve8Sa5R+q7DimLqIFgxYGDr0gy6kPufp608PQumrPDRzE7zewQLP
 frOQ==
X-Gm-Message-State: AOJu0YyQHsi9WWcqYA3aaXvWwarLYZRc7w6xgYsSvPzNQvT7K271vfX0
 YbKfIK4bTU8baUpPBKdn1V/8Fqb3ROaS5FenYnWj/bygsIq7EHeA7J55ulXjYe4=
X-Google-Smtp-Source: AGHT+IElYIcBSLiSOm93qvIwbQ0glbg/m3UnUi6QNYsQGJar95QCMchWFq6ABpGWPvGwiwz9zFKmow==
X-Received: by 2002:a05:6a20:e92:b0:19f:8639:c24f with SMTP id
 fk18-20020a056a200e9200b0019f8639c24fmr8547478pzb.17.1708232194773; 
 Sat, 17 Feb 2024 20:56:34 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 qn11-20020a17090b3d4b00b00298f88c3e48sm2573753pjb.11.2024.02.17.20.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 20:56:34 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 18 Feb 2024 13:56:06 +0900
Subject: [PATCH v5 01/11] hw/nvme: Use pcie_sriov_num_vfs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-reuse-v5-1-e4fc1c19b5a9@daynix.com>
References: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
In-Reply-To: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::535;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x535.google.com
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

nvme_sriov_pre_write_ctrl() used to directly inspect SR-IOV
configurations to know the number of VFs being disabled due to SR-IOV
configuration writes, but the logic was flawed and resulted in
out-of-bound memory access.

It assumed PCI_SRIOV_NUM_VF always has the number of currently enabled
VFs, but it actually doesn't in the following cases:
- PCI_SRIOV_NUM_VF has been set but PCI_SRIOV_CTRL_VFE has never been.
- PCI_SRIOV_NUM_VF was written after PCI_SRIOV_CTRL_VFE was set.
- VFs were only partially enabled because of realization failure.

It is a responsibility of pcie_sriov to interpret SR-IOV configurations
and pcie_sriov does it correctly, so use pcie_sriov_num_vfs(), which it
provides, to get the number of enabled VFs before and after SR-IOV
configuration writes.

Cc: qemu-stable@nongnu.org
Fixes: 11871f53ef8e ("hw/nvme: Add support for the Virtualization Management command")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/nvme/ctrl.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f026245d1e9e..7a56e7b79b4d 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8466,36 +8466,26 @@ static void nvme_pci_reset(DeviceState *qdev)
     nvme_ctrl_reset(n, NVME_RESET_FUNCTION);
 }
 
-static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
-                                      uint32_t val, int len)
+static void nvme_sriov_post_write_config(PCIDevice *dev, uint16_t old_num_vfs)
 {
     NvmeCtrl *n = NVME(dev);
     NvmeSecCtrlEntry *sctrl;
-    uint16_t sriov_cap = dev->exp.sriov_cap;
-    uint32_t off = address - sriov_cap;
-    int i, num_vfs;
+    int i;
 
-    if (!sriov_cap) {
-        return;
-    }
-
-    if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
-        if (!(val & PCI_SRIOV_CTRL_VFE)) {
-            num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
-            for (i = 0; i < num_vfs; i++) {
-                sctrl = &n->sec_ctrl_list.sec[i];
-                nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
-            }
-        }
+    for (i = pcie_sriov_num_vfs(dev); i < old_num_vfs; i++) {
+        sctrl = &n->sec_ctrl_list.sec[i];
+        nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
     }
 }
 
 static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
                                   uint32_t val, int len)
 {
-    nvme_sriov_pre_write_ctrl(dev, address, val, len);
+    uint16_t old_num_vfs = pcie_sriov_num_vfs(dev);
+
     pci_default_write_config(dev, address, val, len);
     pcie_cap_flr_write_config(dev, address, val, len);
+    nvme_sriov_post_write_config(dev, old_num_vfs);
 }
 
 static const VMStateDescription nvme_vmstate = {

-- 
2.43.1


