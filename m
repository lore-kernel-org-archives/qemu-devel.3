Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27F8E909D0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 15:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNMC-0002KF-DZ; Tue, 17 Feb 2026 10:51:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vsMx4-0003b7-Gq
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:25:26 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vsMx1-0005fX-IM
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:25:26 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48371119eacso40880785e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 07:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1771341922; x=1771946722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTBRdCe4EKhZ7QFgzj0snqvNaQKXZdaqV+19ND1Hpu0=;
 b=b2SHYh+JH9qpU4D4C2w+d2nSB20eD2KgQ7bFdL6FpitMi3/pDx1pyUu6YWHFM9Icyr
 Fr2/KGZSboUiwd1U50gVOmc7ognnbshBa04ER8phkPQmay38AqpD+Vl3wTWfLAbXiFMt
 gkHGVS4PswJ8nHkZ+XwMiQgxmP3gyZA3aTYh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771341922; x=1771946722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZTBRdCe4EKhZ7QFgzj0snqvNaQKXZdaqV+19ND1Hpu0=;
 b=C5NOkb+OWywmSYT3waRTFg1ozLdrGj9+7SmwD8ValQoQDj8T1PGQOItCXWDULHKM5a
 lPSxwMQ06JT4CMmuAy3UhkaMypijFw/A9tNzecGyP3gaYkP1ok2oyzJzHB8FkQgO11iw
 vpLd5s91CmiJjnvYcuXwmTMLTqfnRoXTiYhrcVVzQ/F68CUs7I6PLv8qIW1/icTdNjiT
 g8To3bXZoguqfgo+Zyz2i2LyaBvm0AiJt7g1G5ZKVco7cH+vk7GIlX5BDAkqXM0m3d//
 4rKFKLhdG3PXOda9OfGfPy8tCxfRgsYXjgK4cRrbvPiFdpgNNUhk7yI3CDJ+jG+nteDU
 XsMA==
X-Gm-Message-State: AOJu0YyLQp5mQrwaytKUpm7RlbAQHZKTilP5d++gMQ8GPKM5yoIVR1st
 Jieg9RHTI8Gay8GUuWL7KnCSeYce4O6BSQtxnWYae2NJSZCrA15pC7B18tDmqIya1r11CqNtu1t
 WBaRn
X-Gm-Gg: AZuq6aIHQLZj8fbvI9XM59ekrd7OJsFgKa9GJ+YTtXQrr8farMxt5qXUPfR/KRwFnX3
 TgR6g4P7P8znmah/Xvju0HrfMDFvYImlD6m1GKxjP1IwvFoZCg2Ga8WNrJ+OIKoXnpKXbluTlcU
 3aFbuxh6tJkFNEfgoJuC7e9D74i/xdYQjDABerDjZrCTb/5Chh+dLX5MmjeDU5283xg57dkw5xX
 Qwfk4qOAmML24TZPB9RCkNTE4ZdeT9IQsr5NStvQ11pnzBHbZwz7iflDM08JCJB69N46YLjPu1B
 kqJCW4FgqXTKsNb6KrDCwGSyRcEBHli56aSaG9YF8lVC+ib1dtF0jmjYY9bXewJRUy0OrTntwxm
 84JOjV241kFRI+rj5a57VFpNkSlWzXJ1yk2EiIRy6guwFLng9F4YCHyi3T1D73j40lhHFkqJfD+
 DOWtkLV0Fk2C95R2N952+MAqI5ltuKFGai8R2RrENbmEOa3DpiBRjj+S9bxecJGwegdlK1hI5Vw
 r7uvQT5gY7/YaXyX9QaB8UxDBIntfinJw==
X-Received: by 2002:a05:600c:1909:b0:480:4a90:1af2 with SMTP id
 5b1f17b1804b1-48373a78e7amr247299305e9.35.1771341921128; 
 Tue, 17 Feb 2026 07:25:21 -0800 (PST)
Received: from alex-laptop.lan
 (p200300cf574bcf00ffb15ba913f79a3b.dip0.t-ipconnect.de.
 [2003:cf:574b:cf00:ffb1:5ba9:13f7:9a3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm519169015e9.14.2026.02.17.07.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 07:25:20 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 1/4] hw/nvme: add migration blockers for non-supported cases
Date: Tue, 17 Feb 2026 16:25:14 +0100
Message-ID: <20260217152517.271422-2-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217152517.271422-1-alexander@mihalicyn.com>
References: <20260217152517.271422-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Feb 2026 10:51:21 -0500
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


