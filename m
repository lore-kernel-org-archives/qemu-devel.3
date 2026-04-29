Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF6BCD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIB7w-0003XH-Vg; Wed, 29 Apr 2026 16:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QX-0008KG-DO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:12 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QT-0007iG-3e
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:08 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso584483f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 06:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777471083; x=1778075883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfj+OEin87giEu8kZpIKXoKArfkMj1N2Z6jKqDhBiuE=;
 b=gbj3zRB4KWrjceG1CsmwwOK66pctwjHIAvR2BEVhkPPO74yzhsZ82uvCEhI1C203Ix
 AzbrX++Zj1XqzkGJG6qlf0+H9aKeA9uKkOR4ARPNnrZvybO3RPd1ATQ/2lq4hkxLdhTl
 eOIHydu/4Ia9l+Lg2hxqZlsjUP7gDvIvNrV3f+lzjVDBiQvqD6iurvS4X9IjY0eG01ew
 5ltvAQtjm+21j5uiG1aT298CHI7luRiuNhV2/G0xgVzSWNOZpEzr2zEZpthfzpPA3r0P
 xwhVYbMR77Sm2wlMFGk5fgsDHT3RLq4f08EpNHpnVGGe42iWBvBTSjyMNJ3gO+S3Zsm5
 LntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471083; x=1778075883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gfj+OEin87giEu8kZpIKXoKArfkMj1N2Z6jKqDhBiuE=;
 b=XgU6dWFTikbm4mXrmulytdOVt2M0CxQfo6g1qsDQXDdL2sYGeUGegzJqhCmorMmBDg
 iWltddScB21zpUXLSY7uXLXLPrekys2Bl/OjUbWrxQITCV088QtVAWl0SWQ9AFvtPAAH
 57qa2Lwjq4m7H2HSTzFBKHBT4Lx5Ca+2iIOf3bW2cI6uT7zJxZjWt23XnJqBcQcFKRuL
 vbibuoyZSL4aX5oqLu90EKJLvIdlwnSTp264aR4EYkM5Nm/5IsE3/yCRCgBJZrmBtytg
 la7eK4U04tt7JVYDkd2uWRk4OWR940bXOTh8SX22jNNReJYKuO7VHr6S1AjBKTeHbA4h
 g+5w==
X-Gm-Message-State: AOJu0YzT1OtQHOhE266a6IXvoHyUaBcNO9ueLlrbvYkOBWwcuxlAvob6
 aou6LI28Mv8wKfCJHNhq3Arbc7sWC2SZVm+ScE8UEUCozmixzqOOJOmQ
X-Gm-Gg: AeBDieusOcHUeSNiJ7O1KeKsxK0tzudieQdKFMwj+p1MmkBikDedYFG5NPcvIAs92P1
 jlrFaMXKcKreth5mEbh1tt99tXnv0OGHEQugFgw/WWPkgY3yk1/QxeXJ2KjI1sEKw0dyz+TmSMr
 eW/wURMnULAoS3jpoE9UaPMgUnsgCjre1QY1MBmBcXM+XVjfdPnEHVYkGB70D/pO57d6vAZmOk2
 ojrnqgyNE52a63y8NWfmbvj2MuaKTIo7zMw4EiFAyOarIxUy2K/vuRaf/C6ziPbHb4mPZsm853Q
 57lsRsQX2HVScGlD/56uj16cBW68haeXaGZ9Mp/un6rj6FblhXiSprFclpRwcStZviMu2U3DN8i
 WJ6YNPgVG5wiPmYrQ6jl4gdkuSUXBMfvv71+jp9kVk2gt0GbJbUKZ1dCzMJNuDtknqrO3NIsqSj
 SKq8s7l3ixRNiaGQlVfA8e0spzFBcQQu1q9MppokQbMFEo+7Is1CRIbPWhf++9V5jJ74fEyK3R
X-Received: by 2002:a05:6000:2102:b0:445:7f70:70d3 with SMTP id
 ffacd0b85a97d-447a3421972mr4063484f8f.5.1777471083406; 
 Wed, 29 Apr 2026 06:58:03 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk.
 [130.88.198.135]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:58:02 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 arpit1.kumar@samsung.com, Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 06/10] cxl-upstream-port: Add support for targeting a
 VCS switch
Date: Wed, 29 Apr 2026 14:48:40 +0100
Message-ID: <20260429135717.3048713-7-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429135717.3048713-1-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=joshualant@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 16:03:14 -0400
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

Allows an upstream port to be registered on the CLI as a VCS within a
cxl-vcs-switch. A VCS is defined as an upstream pci-pci bridge, and a set of
downstream virtual pci-pci bridges VPPBs, which form a single Virtual
Hierarchy within the switch.

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/pci-bridge/cxl_upstream.c              | 20 ++++++++++++++++++++
 include/hw/pci-bridge/cxl_upstream_port.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 3fcfc2cde6..a91f721c9e 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -16,6 +16,8 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/pci-bridge/cxl_upstream_port.h"
+#include "hw/cxl/cxl_vcs_switch.h"
+
 /*
  * Null value of all Fs suggested by IEEE RA guidelines for use of
  * EU, OUI and CID
@@ -346,6 +348,22 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
         goto err_cap;
     }
 
+    if (usp->vcs_name && usp->ppb != UINT8_MAX) {
+        Object *obj = object_resolve_path_component(
+                          object_get_objects_root(), usp->vcs_name);
+        if (!obj) {
+            error_setg(errp, "vcs '%s' not found", usp->vcs_name);
+            goto err_cap;
+        }
+        if (!object_dynamic_cast(obj, TYPE_CXL_VCS_SWITCH)) {
+            error_setg(errp, "'%s' is not a cxl-vcs-switch", usp->vcs_name);
+            goto err_cap;
+        }
+        cxl_vcs_register_usp(CXL_VCS_SWITCH(obj), usp, errp);
+        if (*errp) 
+            goto err_cap;
+    }
+
     return;
 
 err_cap:
@@ -372,6 +390,8 @@ static const Property cxl_upstream_props[] = {
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", CXLUpstreamPort, flitmode, false),
+    DEFINE_PROP_STRING("vcs", CXLUpstreamPort, vcs_name),
+    DEFINE_PROP_UINT8("usppb", CXLUpstreamPort, ppb, UINT8_MAX),
 };
 
 static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index ce248f3dca..05632286db 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -22,6 +22,8 @@ typedef struct CXLUpstreamPort {
 
     DOECap doe_cdat;
     uint64_t sn;
+    char *vcs_name;
+    uint8_t ppb;
 } CXLUpstreamPort;
 
 #endif /* CXL_SUP_H */
-- 
2.47.3


