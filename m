Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EA2CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjpm-00071A-B3; Thu, 11 Jun 2026 14:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXjpj-0006yv-Oi
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:08:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXjpg-0002Fn-4I
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:08:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so720215e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781201326; x=1781806126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TDXVKCogGTId0T5xX3GpZdgySNzo5x6/mGX55G7OmA=;
 b=X+54Lo4/JWboVxI04e3pJhIJRLGpQW57sRcsGU15YEOzLQA2K+T5LCA/V1R2ooV80n
 ExV1jNBBU24//gxNqgOn3QsUEfRXDKr7gu484aQV2uhprecOdOds00gtB4DzUSqv+g+2
 nLauKQtdq38SGoLQRrUk5gZo1ebsjkwXg1PTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201326; x=1781806126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0TDXVKCogGTId0T5xX3GpZdgySNzo5x6/mGX55G7OmA=;
 b=gopnZCH8ES7vS7kaLZmy10Tk3HVybOyS1amBIDovCwXGc9ZWireLAsFsiPomHBCY6w
 DNDInMdfOYmbEKPzfJ7Fw9kkSHseENWurzpsmGQvYklVfY4YsyDBqC9fVkdBY6tz8VOv
 fTXh1eiKxEJ5tryAX3mK4Wj4q6bWdhDQL48VmjhkIJn2lc3943qZnRDERs+z77Fiw70z
 9nhsxlMrOodA47VsgxhGnz9U/sIcXFaD4UbY40PnCJeDVvu0TMhNr2z7Ap/gY8aiH5zj
 0qZ7x6uWloGMcgNhlXvigEHummpFZ9pomsX9kYgEYjmAP+PO+JuchzkaBo5eWMkzMqsd
 y+Ag==
X-Gm-Message-State: AOJu0YyyL/mjkeKF2QJF5aFXRtrwHxyYXRFSwsb34qFXYON3QmpAkra4
 4HkY69d+5HhtZ/bLBC53HOBV1DF7PaI6LxtxwA83b109mW8l5MJOp0l75W/E+QhcEWg9RMhgCUi
 mYc0y8gc=
X-Gm-Gg: Acq92OFPnS7SxAUjfRJjoACg7/TqhfP+rQSXj+YnJDtbKkwAItRZNp5j3ia+Z4gyN+t
 V8Zs54NApNMmSilOv8i+JZnQ7fTENHaKoYPv5QIuT8Rjz1x9RDWr6wnCnhb+8ViuVBCg6mCbyEx
 ylWhxsj5vdxTDoK3Q9ZIPErkOInZvCIbE3nuTl6YeA3kZ3CXw5rtVHxLPKfk6sJHRTA2cehdGIb
 vxce1M+KaCbRTviFyMO1QdUWF6ygpth8TOkEpmcvGUAP/4Icng5mqpKed1SbkcOIKVG6fvBATee
 rqY3XDIL4zhJt9uOIh2qaAtAB3fYjwkx96UClA41wWkvDjRjp7cPvoy3o46A3y39iy1r+7ab2pV
 alwBbysJzkfsAvTzPGT/YVnIUzqXz8pfR8+l9G+/zLhnEisOi9eWaTbykkP1J3hYzcz0+uzGu3Q
 UdciVuAQ+5Pm1mqDs96KTwFnGnodjeflK9eFYFPRtc2NtgtytjGjTYDbAG3upKo+wqhCj2gbmVy
 huW/kvlaty/s+2PFhU42Ks=
X-Received: by 2002:a05:600c:3f1b:b0:490:b642:ce31 with SMTP id
 5b1f17b1804b1-490e55b7020mr54298925e9.2.1781201325963; 
 Thu, 11 Jun 2026 11:08:45 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf570ffe006f778db3bc22ef81.dip0.t-ipconnect.de.
 [2003:cf:570f:fe00:6f77:8db3:bc22:ef81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4a128csm6563345e9.0.2026.06.11.11.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 11:08:45 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v10 2/8] hw/nvme: add migration blockers for non-supported
 cases
Date: Thu, 11 Jun 2026 20:08:35 +0200
Message-ID: <20260611180842.6390-3-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611180842.6390-1-alexander@mihalicyn.com>
References: <20260611180842.6390-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x334.google.com
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
v10:
    - fix "../hw/nvme/ctrl.c:9385:13: error: label followed by a declaration "
      [ thanks to Fabiano Rosas ]
v9:
    - check-patch trivial fixes

migration blockers fixup
---
 hw/nvme/ctrl.c       | 212 +++++++++++++++++++++++++++++++++++++++++++
 hw/nvme/nvme.h       |   3 +
 include/block/nvme.h |  12 +++
 3 files changed, 227 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 815f39173c8..b4a9728e06b 100644
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
 
@@ -9233,6 +9240,205 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     }
 }
 
+#define BLOCKER_FEATURES_MAX_LEN 256
+
+static inline void nvme_add_blocker_feature(char *blocker_features,
+                                            const char *feature)
+{
+    if (strlen(blocker_features) > 0) {
+        g_strlcat(blocker_features, ", ", BLOCKER_FEATURES_MAX_LEN);
+    }
+    g_strlcat(blocker_features, feature, BLOCKER_FEATURES_MAX_LEN);
+}
+
+static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
+                                        Error **errp)
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
+    for (int opcode = 0; opcode < ARRAY_SIZE(n->cse.acs); opcode++) {
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
+        case NVME_ADM_CMD_NS_ATTACHMENT: {
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
+                nvme_add_blocker_feature(blocker_features,
+                                         "Namespace Attachment");
+            }
+
+            break;
+        }
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
+    for (int opcode = 0; opcode < ARRAY_SIZE(n->cse.iocs.nvm); opcode++) {
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
+    for (int opcode = 0; opcode < ARRAY_SIZE(n->cse.iocs.zoned); opcode++) {
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
+                    nvme_add_blocker_feature(blocker_features,
+                                             "Zoned Namespace");
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
+        error_setg(&n->migration_blocker,
+                   "Migration is not supported for %s", blocker_features);
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
@@ -9338,6 +9544,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 
         n->subsys->namespaces[ns->params.nsid] = ns;
     }
+
+    if (!nvme_set_migration_blockers(n, pci_dev, errp)) {
+        return;
+    }
 }
 
 static void nvme_exit(PCIDevice *pci_dev)
@@ -9390,6 +9600,8 @@ static void nvme_exit(PCIDevice *pci_dev)
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


