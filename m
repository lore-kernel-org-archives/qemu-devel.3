Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193EAC44517
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whkPx-0002Sl-I1; Thu, 09 Jul 2026 04:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1whkPv-0002SN-LB
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:47:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1whkPt-0005nL-Md
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:47:35 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493d1e8aa46so12313145e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783586851; x=1784191651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tWykkhUvZImzKk7PMKYU/gQ1ZJJOoPXOpglztp/ahl8=;
 b=J3dpbayXHZFn0Z47OSxBivgRCCT38OUBLf6bjsTm1tfYxCQdDGlwkV5YQ41WbMG2Ez
 B4at/8vOFepr2jmOjSIwSf2Tlc5cIjvMQbbfoyS0t59ZatuGZGYXVbILdQaYqQZ/tN+z
 a4LhVv6y9E137PD1ovXfpzlxR1F3NZ2xYl9m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783586851; x=1784191651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tWykkhUvZImzKk7PMKYU/gQ1ZJJOoPXOpglztp/ahl8=;
 b=rFLTO0ls5uS6PxsiIgEcX1Qii62UNe5KyUdaF4oyR0KdGspq3BcyZrgNbAGej9E9gf
 hpAfriWzlS8E1aD4Vi243jjC+165YWQ5o2AdwJ562CZsS2pt+OKRdnHakouks7OIqPIo
 VXpdmzHlAbH0fO6qDZmK9jtIjj0MFq1fEARv2XL4y9EFfxdHdqQpHFEl2/OJr6OdfLQk
 6RBMfoBZR7buHV64w+XbGXZdUbUwwNLBA2lX1WEv1vMQ2lrBiy8NkuornPpXnbg/yG28
 elYlqqAvW/khzx514+XPmoHxznzp+7w/nVo52xepxyWHr6g+OftESspbLdLYehPK18zU
 OvaA==
X-Gm-Message-State: AOJu0YzCMK185zyc3Ivk7ofCUgvpVUBLZ1v7PXUvx/pxtGQBjS/WimEF
 WRgdR2SitEdjAPLWISAsJXSctSU5lpBhj+1RmgAOI/2zOpRj87JZvqWB3VcC+HylJVIHmPFfg39
 IFe1Lb4x+pg==
X-Gm-Gg: AfdE7clh5smhAPqIN682bNTO64EQR02dDL27SwxE1hXsxWJgH7NNUgLDqxZo33Hdq4w
 d+jSRMUXcn+gUwMTjkdD7XkGHYJXmdfGuoBQTUjJZcJJnwNMwI0GmKB2Eb/pWmjdbVotGmNjrIX
 1jJt77p6w0OadhDGyAI6IlfY1UKQMlV/aUq9ueXx9/kjJvrN5HpYVRoxIJkXVrZY4q+UNqJ9oK5
 AbV1hhs/PbiKcLi7+St24ActoZZoWz7Yaor+4gwFXXqDWveA+KEv7UloqkHIb/2KzqTQEWa71td
 vCkWgXaKhUsacSD002xmFkFHiVOHrcYW55gm1wjde2BiLNQ9ZdSWX0WrYHfJifVOYa64atPPHNH
 fSFQ/E5x0cJuGz/i2pdARRRNdtWaPgeo1RbmVCUbKB/ppt6hkt6RFszzhAlmArwa8tTV9FtsTnJ
 uEUOKOznuCIqnSOB7mm31IIArRuDtIiLWRCs9y6tdKiom9HZDkUhXyAGEKOAuzhRoU3kvh9h9E3
 OTovObuNtha
X-Received: by 2002:a05:600d:8498:20b0:493:d115:d835 with SMTP id
 5b1f17b1804b1-493e68b8094mr47441755e9.8.1783586850644; 
 Thu, 09 Jul 2026 01:47:30 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a72003e9c5bb9189c1bc2.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:3e9c:5bb9:189c:1bc2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6d4f9fsm44791685e9.4.2026.07.09.01.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 01:47:30 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 alexander@mihalicyn.com, Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH] hw/nvme: use GPtrArray for blocker_features
Date: Thu,  9 Jul 2026 10:47:28 +0200
Message-ID: <20260709084728.92862-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Let's use GPtrArray to build a list of blocker features and then
g_strjoinv() to build a final comma-delimited string.

While previous approach was technically correct, it is fragile
(because we need to take care of static buffer size choice) and
Coverity dislikes it too.

Note, that we use g_ptr_array_new() to allocate array which means
that GDestroyNotify callback is not set, so we can pass pointers to
a static memory like g_ptr_array_add(..., (gpointer) "SR-IOV") without
any problems as there won't be any attempt to free that memory.

Resolves: Coverity CID 1663673
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a67e1598891..95a586d82a9 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9352,22 +9352,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     }
 }
 
-#define BLOCKER_FEATURES_MAX_LEN 256
-
-static inline void nvme_add_blocker_feature(char *blocker_features,
-                                            const char *feature)
-{
-    if (strlen(blocker_features) > 0) {
-        g_strlcat(blocker_features, ", ", BLOCKER_FEATURES_MAX_LEN);
-    }
-    g_strlcat(blocker_features, feature, BLOCKER_FEATURES_MAX_LEN);
-}
-
 static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
                                         Error **errp)
 {
     uint64_t unsupported_cap, cap = ldq_le_p(&n->bar.cap);
-    char blocker_features[BLOCKER_FEATURES_MAX_LEN] = "";
+    g_autoptr(GPtrArray) blocker_features = g_ptr_array_new();
     bool adm_cmd_security_checked = false;
     bool cmd_io_mgmt_checked = false;
     bool cmd_zone_checked = false;
@@ -9416,15 +9405,15 @@ static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
             }
 
             if (namespaces_num > 1) {
-                nvme_add_blocker_feature(blocker_features,
-                                         "Namespace Attachment");
+                g_ptr_array_add(blocker_features,
+                                         (gpointer) "Namespace Attachment");
             }
 
             break;
         }
         case NVME_ADM_CMD_VIRT_MNGMT:
             if (n->params.sriov_max_vfs) {
-                nvme_add_blocker_feature(blocker_features, "SR-IOV");
+                g_ptr_array_add(blocker_features, (gpointer) "SR-IOV");
             }
 
             break;
@@ -9435,7 +9424,7 @@ static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
             }
 
             if (pci_dev->spdm_port) {
-                nvme_add_blocker_feature(blocker_features, "SPDM");
+                g_ptr_array_add(blocker_features, (gpointer) "SPDM");
             }
 
             adm_cmd_security_checked = true;
@@ -9469,7 +9458,7 @@ static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
 
             /* check for NVME_IOMS_MO_RUH_UPDATE */
             if (n->subsys->params.fdp.enabled) {
-                nvme_add_blocker_feature(blocker_features, "FDP");
+                g_ptr_array_add(blocker_features, (gpointer) "FDP");
             }
 
             cmd_io_mgmt_checked = true;
@@ -9504,8 +9493,8 @@ static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
                 }
 
                 if (ns->params.zoned) {
-                    nvme_add_blocker_feature(blocker_features,
-                                             "Zoned Namespace");
+                    g_ptr_array_add(blocker_features,
+                                             (gpointer) "Zoned Namespace");
                     break;
                 }
             }
@@ -9525,24 +9514,28 @@ static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
      * covered by unsupported_cap check.
      */
     if (NVME_CAP_CMBS(cap)) {
-        nvme_add_blocker_feature(blocker_features, "CMB");
+        g_ptr_array_add(blocker_features, (gpointer) "CMB");
         cap &= ~((uint64_t)CAP_CMBS_MASK << CAP_CMBS_SHIFT);
     }
 
     if (NVME_CAP_PMRS(cap)) {
-        nvme_add_blocker_feature(blocker_features, "PMR");
+        g_ptr_array_add(blocker_features, (gpointer) "PMR");
         cap &= ~((uint64_t)CAP_PMRS_MASK << CAP_PMRS_SHIFT);
     }
 
     unsupported_cap = cap & ~NVME_MIGRATION_SUPPORTED_CAP_BITS;
     if (unsupported_cap) {
-        nvme_add_blocker_feature(blocker_features, "unknown capability");
+        g_ptr_array_add(blocker_features, (gpointer) "unknown capability");
     }
 
     assert(n->migration_blocker == NULL);
-    if (strlen(blocker_features) > 0) {
+    if (blocker_features->len > 0) {
+        g_autofree char *blocker_list = NULL;
+
+        g_ptr_array_add(blocker_features, NULL);
+        blocker_list = g_strjoinv(", ", (void *)blocker_features->pdata);
         error_setg(&n->migration_blocker,
-                   "Migration is not supported for %s", blocker_features);
+                   "Migration is not supported for %s", blocker_list);
         if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
             return false;
         }
-- 
2.47.3


