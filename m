Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D27EB7EAC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 09:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxiHk-00014G-Ic; Wed, 04 Mar 2026 04:12:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vxiHa-00010l-1j
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:12:43 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vxiHX-0000IJ-B3
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:12:41 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-483bd7354efso88409655e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 01:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1772615554; x=1773220354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTBRdCe4EKhZ7QFgzj0snqvNaQKXZdaqV+19ND1Hpu0=;
 b=JEMIQTkxcNFbViMZZuM6etBjv2XFFbd2KKEQqsy3PM81A7ikHo2d86EIsi9bL3qgP6
 SQzCaik6czem7wG+qgubtpBqh/w5DIbhyb2fw+iBvcfe8WyYV4/31dqWJmKhFPHfUb42
 Ybijd6jWICI4ee1Q5ulNq/s26Kv2Ua63q/dT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772615554; x=1773220354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZTBRdCe4EKhZ7QFgzj0snqvNaQKXZdaqV+19ND1Hpu0=;
 b=jgpUFWGlW6EUHF0jb71fw/G80bkBCrn8VVCfALsjmV6My0Tfxel/Ts9wLKlYRr6w0N
 WDgyFEciRkxwNxeERF97n+stcCvIFMn9PJhqNnnbFsD0DvfI8tPAeMlp7iDC6I2hWYnJ
 rX/GuVZ19c2I4ErzfB3841czWjvH79ZZbObz8QGKFT0le7LBrbtZkjxC5RM2EbNSC0Oe
 bmIBs1oD9azyKUXpiqDkmE88c7e+u1sI09tHloSMulxEAw+e4pwtZ0mtJiiPtq7ccSva
 I1Uizw9XvzblAJhyxHHdMYRGm7m0fC8LD9mf36s+3UKQr1aIicbLovtyctyxIYFE/Tcn
 uchw==
X-Gm-Message-State: AOJu0YwARjQTnqOLSTNaiVJlAVE8qNK9pwNTK9jGBwVzbvfewBfI5KOK
 Ao9pB4cxDdZTqkBP+GNhAfRFVY2FShLIRI8d6UeF7uFMGJ4ZTMH9GXEPGVUYMWf7STZvam8+n3H
 HWO59xfU=
X-Gm-Gg: ATEYQzwZd0wbTpUYHzrEmZQoN/xPn5JOa+ZrQjK5BuzRNAnflS9SlxtiPLy6Y85Ppgf
 lFLs9i3xY6/QCWlm+ARe3zku8JQ5xgRJEwxxpY9AgAM/E1QVwYAaWs583MSPqH2Ce0w5Cxybov6
 EDf1UtK3vnnQbTcXmzHd+/5TISncgV5Xa7iZw6P2/kitaCAwQl0O5edivX1/CFkv/yjpd60dUYs
 o0bh9IpTDS+EbLif/Bj42wEHnGKJw64ZhfJ0hi924QMMuPKScLQKG5/uDPV+fryHFXzkoI2oaEa
 dgYQKE6aWENusEpKcmv/zDlOY0JBRz+Qsc9Tpr9bxE8jFRioeB7bpL5F12sqonlv5X/UlEkP/YT
 biGRfdsBj+CJLfW8B7eR/d9Xpbtp/6DfWgaAOmN8cOiYtSVFbBX7PWUYBQ7NXWh9JH6hoQQn3vN
 oniP98gUtkkOEizz4Ai1qIwko+47Ntv5/nDAikqD/2bKSiR80eXAxwvRKZLk696vHgVXMCiXfqA
 hqGhDW5ELHLiysuuZp+n4k=
X-Received: by 2002:a05:600c:a03:b0:47d:264e:b35a with SMTP id
 5b1f17b1804b1-48519854e97mr23177625e9.13.1772615553822; 
 Wed, 04 Mar 2026 01:12:33 -0800 (PST)
Received: from alex-laptop.lan
 (p200300cf57228c00bac66d1b6d99e025.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:bac6:6d1b:6d99:e025])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439c4489279sm9674234f8f.20.2026.03.04.01.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 01:12:32 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Keith Busch <kbusch@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 qemu-block@nongnu.org,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v2 1/4] hw/nvme: add migration blockers for non-supported cases
Date: Wed,  4 Mar 2026 10:12:26 +0100
Message-ID: <20260304091229.80725-2-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304091229.80725-1-alexander@mihalicyn.com>
References: <20260304091229.80725-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Let's block migration for cases we don't support:
- SR-IOV
- CMB
- PMR
- SPDM

No functional changes here, because NVMe migration is
not supported at all as of this commit.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c | 35 +++++++++++++++++++++++++++++++++++
 hw/nvme/nvme.h |  3 +++
 2 files changed, 38 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index cc4593cd427..4694bdb4d02 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -207,6 +207,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_sriov.h"
 #include "system/spdm-socket.h"
+#include "migration/blocker.h"
 #include "migration/vmstate.h"
 
 #include "nvme.h"
@@ -8962,6 +8963,14 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     pcie_endpoint_cap_init(pci_dev, 0x80);
     pcie_cap_flr_init(pci_dev);
     if (n->params.sriov_max_vfs) {
+        if (n->migration_blocker == NULL) {
+            error_setg(&n->migration_blocker,
+                       "Migration is disabled when SR-IOV capability is set");
+            if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
+                return false;
+            }
+        }
+
         pcie_ari_init(pci_dev, 0x100);
     }
 
@@ -9025,6 +9034,14 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     if (pci_dev->spdm_port) {
         uint16_t doe_offset = PCI_CONFIG_SPACE_SIZE;
 
+        if (n->migration_blocker == NULL) {
+            error_setg(&n->migration_blocker,
+                       "Migration is disabled when SPDM responder is used");
+            if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
+                return false;
+            }
+        }
+
         switch  (pci_dev->spdm_trans) {
         case SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE:
             if (n->params.sriov_max_vfs) {
@@ -9053,10 +9070,26 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     }
 
     if (n->params.cmb_size_mb) {
+        if (n->migration_blocker == NULL) {
+            error_setg(&n->migration_blocker,
+                       "Migration is disabled when CMB feature is used");
+            if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
+                return false;
+            }
+        }
+
         nvme_init_cmb(n, pci_dev);
     }
 
     if (n->pmr.dev) {
+        if (n->migration_blocker == NULL) {
+            error_setg(&n->migration_blocker,
+                       "Migration is disabled when PMR feature is used");
+            if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
+                return false;
+            }
+        }
+
         if (!nvme_init_pmr(n, pci_dev, errp)) {
             return false;
         }
@@ -9365,6 +9398,8 @@ static void nvme_exit(PCIDevice *pci_dev)
     }
 
     memory_region_del_subregion(&n->bar0, &n->iomem);
+
+    migrate_del_blocker(&n->migration_blocker);
 }
 
 static const Property nvme_props[] = {
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index d66f7dc82d5..457b6637249 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -666,6 +666,9 @@ typedef struct NvmeCtrl {
 
     /* Socket mapping to SPDM over NVMe Security In/Out commands */
     int spdm_socket;
+
+    /* Migration-related stuff */
+    Error *migration_blocker;
 } NvmeCtrl;
 
 typedef enum NvmeResetType {
-- 
2.47.3


