Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7DDCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRq2S-0007vr-FT; Tue, 26 May 2026 07:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wRq2G-0007sc-QQ
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:33:26 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wRq2B-0002GH-0P
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:33:23 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-687d82dd690so4534487a12.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1779795196; x=1780399996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypSkvCgKChX8xCJjZ8z4M9qxsiXUJZOoGadv//QNwsU=;
 b=TY2RnMkOYIXArXi84TLqaMPQoadRgOWfqzQjp6LyisIxpS5bcLEkGudSWJV4KF3QfG
 xplvWIy1n1GzyF59iDx+AkjrjuyJ4zrSZhGh04/dafRr3Cu8BLXbKcBbvHXfzsQK6BDo
 ySAeqXTKQEN76ifCxQhb4rQZOUgcIr0660rb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779795196; x=1780399996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ypSkvCgKChX8xCJjZ8z4M9qxsiXUJZOoGadv//QNwsU=;
 b=is2LP7OuFohGrqN8gUOJohaXtOEl02QRS632axzBrbq/SHGUJ+fNXcdGn/tmcJXnc+
 vIP3eM2zJCSxn0iFeiHK0GOlOr7eTZjldGIqJnGOdr6Zi+1vkvE9Pr7+6E6gkiWhibMS
 YZD3c83CbGGLqZzxSjn1bcIcKKp+7zyvpYFqZ/f7nGLl0Qq3yhf9mZYbwIrEg5LV7I30
 TEiNbkiwwcmaGnLvkgYmtw0oiQ5ez9yUdwOVLbhCzb3RfOorKwgenXAQemkRSYgYHrqB
 rke4uuio3VfXdsYRQ4PoyJ5js5i6tbKAIgGoe52UxMx55C0H/XWlYEGNEEk6ifcetjVQ
 eRoA==
X-Gm-Message-State: AOJu0Yy0D4oCTdUFnINpZ9A/A5LQVkBoUEe7X6Moa4S/d+/XFIHWZhrD
 ek1C5H9/lhrZDCqHVlL/YG3YMFZR/lj0U78PyHrN1V1HWmfKFAKpUWg8ozpuZ7ptKXm1pOffbkE
 zWMnLSjs=
X-Gm-Gg: Acq92OEKi35+04PzN/lBTVS0sN3FPKRMHai2TMs09W3b5fXBHZokcUwnDlfLl5q53o4
 L4BR13WI8Mh+E2wvKQMTXZrQrKRO+PCsoTEsuUb6wClR4wihiPvz/S6jRQ7XvCR1xPMx1CPrDCQ
 GnKTcj1/upEWunfiR4vfFh7uEd03jnD9NNz1q+GN8Gr0mf0XeN6qHecBBhbjMQDlAw1m9iebKVd
 nmVOxvy5646LiLTsKCKEcPNEywhRpqEmSbnBImWRWnTHszqUYvDtCt3K/74Z6o0FnpeoE/WX1lx
 NPMWedvd2kWdL3/r76c0a0ldSzLoq4RolDWDu+Z4r7aeMyHjRiaXB4D6mJNlx9w3ldj4UQYwEiL
 eTRT+rpc63CHgzmA+u4e8H7v5eTgMXC3807e0LEGFN/LHlRdNjfA5sauZ5UUFTvJRmv9thyxBZC
 VtyXc2XE41h/2/xKcrCxa3WyN5riRg+PEaJ+2F1j6o6c4a16lFtGHEFUW0mhA7zHVdTm7wfjeAl
 giXbLS2G+aMvb1wuUMQKUQ=
X-Received: by 2002:a05:600d:644d:20b0:490:3cb4:f1b3 with SMTP id
 5b1f17b1804b1-490426c5a3dmr217972515e9.16.1779795185629; 
 Tue, 26 May 2026 04:33:05 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00840292fb31d0d80a.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:8402:92fb:31d0:d80a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4ca0dsm34366870f8f.18.2026.05.26.04.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:33:05 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>, Laurent Vivier <lvivier@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v8 2/8] hw/nvme: add migration blockers for non-supported cases
Date: Tue, 26 May 2026 13:32:55 +0200
Message-ID: <20260526113301.91492-3-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526113301.91492-1-alexander@mihalicyn.com>
References: <20260526113301.91492-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alexander@mihalicyn.com; helo=mail-ed1-x52a.google.com
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

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c       | 206 +++++++++++++++++++++++++++++++++++++++++++
 hw/nvme/nvme.h       |   3 +
 include/block/nvme.h |  12 +++
 3 files changed, 221 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 815f39173c8..6ecaa67f3f5 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -209,6 +209,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_sriov.h"
 #include "system/spdm-socket.h"
+#include "migration/blocker.h"
 #include "migration/vmstate.h"
 
 #include "nvme.h"
@@ -252,6 +253,7 @@ static const bool nvme_feature_support[NVME_FID_MAX] = {
     [NVME_COMMAND_SET_PROFILE]      = true,
     [NVME_FDP_MODE]                 = true,
     [NVME_FDP_EVENTS]               = true,
+    /* if you add something here, please update nvme_set_migration_blockers() */
 };
 
 static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
@@ -4603,6 +4605,7 @@ static uint16_t nvme_io_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
         return 0;
     case NVME_IOMS_MO_RUH_UPDATE:
         return nvme_io_mgmt_send_ruh_update(n, req);
+    /* if you add something here, please update nvme_set_migration_blockers() */
     default:
         return NVME_INVALID_FIELD | NVME_DNR;
     };
@@ -7522,6 +7525,10 @@ static uint16_t nvme_security_receive(NvmeCtrl *n, NvmeRequest *req)
 
 static uint16_t nvme_directive_send(NvmeCtrl *n, NvmeRequest *req)
 {
+    /*
+     * When adding a new dtype handling here,
+     * please also update nvme_set_migration_blockers().
+     */
     return NVME_INVALID_FIELD | NVME_DNR;
 }
 
@@ -9233,6 +9240,199 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     }
 }
 
+#define BLOCKER_FEATURES_MAX_LEN 256
+
+static inline void nvme_add_blocker_feature(char *blocker_features, const char *feature)
+{
+    if (strlen(blocker_features) > 0) {
+        g_strlcat(blocker_features, ", ", BLOCKER_FEATURES_MAX_LEN);
+    }
+    g_strlcat(blocker_features, feature, BLOCKER_FEATURES_MAX_LEN);
+}
+
+static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
+{
+    uint64_t unsupported_cap, cap = ldq_le_p(&n->bar.cap);
+    char blocker_features[BLOCKER_FEATURES_MAX_LEN] = "";
+    bool adm_cmd_security_checked = false;
+    bool cmd_io_mgmt_checked = false;
+    bool cmd_zone_checked = false;
+
+    /*
+     * Idea of this function is simple, we iterate over all Command Sets and
+     * for each supported command we provide a special handling logic to
+     * determine if we should block migration or not.
+     *
+     * For instance, we have NVME_ADM_CMD_NS_ATTACHMENT and it is always
+     * available to the guest, but if there is only 1 namespace, then it is
+     * safe to allow migration, but if there are more, then we need to block
+     * migration because we don't handle this in migration code yet.
+     */
+    for (int opcode = 0; opcode < sizeof(n->cse.acs) / sizeof(n->cse.acs[0]); opcode++) {
+        /* Is command supported? */
+        if (!n->cse.acs[opcode]) {
+            continue;
+        }
+
+        switch (opcode) {
+        case NVME_ADM_CMD_DELETE_SQ:
+        case NVME_ADM_CMD_CREATE_SQ:
+        case NVME_ADM_CMD_GET_LOG_PAGE:
+        case NVME_ADM_CMD_DELETE_CQ:
+        case NVME_ADM_CMD_CREATE_CQ:
+        case NVME_ADM_CMD_IDENTIFY:
+        case NVME_ADM_CMD_ABORT:
+        case NVME_ADM_CMD_SET_FEATURES:
+        case NVME_ADM_CMD_GET_FEATURES:
+        case NVME_ADM_CMD_ASYNC_EV_REQ:
+        case NVME_ADM_CMD_DBBUF_CONFIG:
+        case NVME_ADM_CMD_FORMAT_NVM:
+        case NVME_ADM_CMD_DIRECTIVE_SEND:
+        case NVME_ADM_CMD_DIRECTIVE_RECV:
+            break;
+        case NVME_ADM_CMD_NS_ATTACHMENT:
+            int namespaces_num = 0;
+            for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+                NvmeNamespace *ns = nvme_subsys_ns(n->subsys, i);
+                if (!ns) {
+                    continue;
+                }
+
+                namespaces_num++;
+            }
+
+            if (namespaces_num > 1) {
+                nvme_add_blocker_feature(blocker_features, "Namespace Attachment");
+            }
+
+            break;
+        case NVME_ADM_CMD_VIRT_MNGMT:
+            if (n->params.sriov_max_vfs) {
+                nvme_add_blocker_feature(blocker_features, "SR-IOV");
+            }
+
+            break;
+        case NVME_ADM_CMD_SECURITY_SEND:
+        case NVME_ADM_CMD_SECURITY_RECV:
+            if (adm_cmd_security_checked) {
+                break;
+            }
+
+            if (pci_dev->spdm_port) {
+                nvme_add_blocker_feature(blocker_features, "SPDM");
+            }
+
+            adm_cmd_security_checked = true;
+
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    for (int opcode = 0; opcode < sizeof(n->cse.iocs.nvm) / sizeof(n->cse.iocs.nvm[0]); opcode++) {
+        if (!n->cse.iocs.nvm[opcode]) {
+            continue;
+        }
+
+        switch (opcode) {
+        case NVME_CMD_FLUSH:
+        case NVME_CMD_WRITE:
+        case NVME_CMD_READ:
+        case NVME_CMD_COMPARE:
+        case NVME_CMD_WRITE_ZEROES:
+        case NVME_CMD_DSM:
+        case NVME_CMD_VERIFY:
+        case NVME_CMD_COPY:
+            break;
+        case NVME_CMD_IO_MGMT_RECV:
+        case NVME_CMD_IO_MGMT_SEND:
+            if (cmd_io_mgmt_checked) {
+                break;
+            }
+
+            /* check for NVME_IOMS_MO_RUH_UPDATE */
+            if (n->subsys->params.fdp.enabled) {
+                nvme_add_blocker_feature(blocker_features, "FDP");
+            }
+
+            cmd_io_mgmt_checked = true;
+
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    for (int opcode = 0; opcode < sizeof(n->cse.iocs.zoned) / sizeof(n->cse.iocs.zoned[0]); opcode++) {
+        /*
+         * If command isn't supported or we have the same command
+         * in n->cse.iocs.nvm, then we can skip it here.
+         */
+        if (!n->cse.iocs.zoned[opcode] || n->cse.iocs.nvm[opcode]) {
+            continue;
+        }
+
+        switch (opcode) {
+        case NVME_CMD_ZONE_APPEND:
+        case NVME_CMD_ZONE_MGMT_SEND:
+        case NVME_CMD_ZONE_MGMT_RECV:
+            if (cmd_zone_checked) {
+                break;
+            }
+
+            for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+                NvmeNamespace *ns = nvme_subsys_ns(n->subsys, i);
+                if (!ns) {
+                    continue;
+                }
+
+                if (ns->params.zoned) {
+                    nvme_add_blocker_feature(blocker_features, "Zoned Namespace");
+                    break;
+                }
+            }
+
+            cmd_zone_checked = true;
+
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    /*
+     * Try our best to explicitly detect all not supported caps,
+     * to let users know what features cause migration to be blocked,
+     * but in case we miss handling here, everything else will be
+     * covered by unsupported_cap check.
+     */
+    if (NVME_CAP_CMBS(cap)) {
+        nvme_add_blocker_feature(blocker_features, "CMB");
+        cap &= ~((uint64_t)CAP_CMBS_MASK << CAP_CMBS_SHIFT);
+    }
+
+    if (NVME_CAP_PMRS(cap)) {
+        nvme_add_blocker_feature(blocker_features, "PMR");
+        cap &= ~((uint64_t)CAP_PMRS_MASK << CAP_PMRS_SHIFT);
+    }
+
+    unsupported_cap = cap & ~NVME_MIGRATION_SUPPORTED_CAP_BITS;
+    if (unsupported_cap) {
+        nvme_add_blocker_feature(blocker_features, "unknown capability");
+    }
+
+    assert(n->migration_blocker == NULL);
+    if (strlen(blocker_features) > 0) {
+        error_setg(&n->migration_blocker, "Migration is not supported for %s", blocker_features);
+        if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static int nvme_init_subsys(NvmeCtrl *n, Error **errp)
 {
     int cntlid;
@@ -9338,6 +9538,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 
         n->subsys->namespaces[ns->params.nsid] = ns;
     }
+
+    if (!nvme_set_migration_blockers(n, pci_dev, errp)) {
+        return;
+    }
 }
 
 static void nvme_exit(PCIDevice *pci_dev)
@@ -9390,6 +9594,8 @@ static void nvme_exit(PCIDevice *pci_dev)
     }
 
     memory_region_del_subregion(&n->bar0, &n->iomem);
+
+    migrate_del_blocker(&n->migration_blocker);
 }
 
 static const Property nvme_props[] = {
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 5ef3ebee29e..05aee24a15c 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -668,6 +668,9 @@ typedef struct NvmeCtrl {
 
     /* Socket mapping to SPDM over NVMe Security In/Out commands */
     int spdm_socket;
+
+    /* Migration-related stuff */
+    Error *migration_blocker;
 } NvmeCtrl;
 
 typedef enum NvmeResetType {
diff --git a/include/block/nvme.h b/include/block/nvme.h
index e4e7be51205..17a7c7818d7 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -141,6 +141,18 @@ enum NvmeCapMask {
 #define NVME_CAP_SET_CMBS(cap, val)   \
     ((cap) |= (uint64_t)((val) & CAP_CMBS_MASK)   << CAP_CMBS_SHIFT)
 
+#define NVME_MIGRATION_SUPPORTED_CAP_BITS ( \
+      ((uint64_t)CAP_MQES_MASK   << CAP_MQES_SHIFT)   \
+    | ((uint64_t)CAP_CQR_MASK    << CAP_CQR_SHIFT)    \
+    | ((uint64_t)CAP_AMS_MASK    << CAP_AMS_SHIFT)    \
+    | ((uint64_t)CAP_TO_MASK     << CAP_TO_SHIFT)     \
+    | ((uint64_t)CAP_DSTRD_MASK  << CAP_DSTRD_SHIFT)  \
+    | ((uint64_t)CAP_NSSRS_MASK  << CAP_NSSRS_SHIFT)  \
+    | ((uint64_t)CAP_CSS_MASK    << CAP_CSS_SHIFT)    \
+    | ((uint64_t)CAP_MPSMIN_MASK << CAP_MPSMIN_SHIFT) \
+    | ((uint64_t)CAP_MPSMAX_MASK << CAP_MPSMAX_SHIFT) \
+)
+
 enum NvmeCapCss {
     NVME_CAP_CSS_NCSS    = 1 << 0,
     NVME_CAP_CSS_IOCSS   = 1 << 6,
-- 
2.47.3


