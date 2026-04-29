Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF4FFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIB7w-0003WU-CT; Wed, 29 Apr 2026 16:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QX-0008KF-DE
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QU-0007iW-EQ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:08 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso128830365e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777471084; x=1778075884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPS8B/0ftELxPYBJPOi/Jw2N6PyAu4qwVtoZHd48FII=;
 b=jsKAgWblGo17yKNZPtv6njNOEEO1oQbqEahzK8KLNZs/W38NLxT5Q7LYTylPMQqn/w
 mRKVR9F7e/gQAx+hdHDH+IX32ZlVDMzJUi7AzLiLkK1FkkLmCDXCg72Yp1/kJN9ooZ+b
 6GoK6jfzUO15SZQsyZ7jd+dPI6HLU6b/q8ISoz4ZSbxBKSVzX/A555QOMIc9w4kXFJs+
 MzltzdLsTgZuanKJ4jox4a5wXuF6MZm3NJnOu0cMlbWHucQcKQZ77sWpTJf8Sxz/6KsE
 C9kcCJmOuvjQLXN+PuGQtIOM6Hyt9UwYfQIN09tL7bhko7fR5gkDdppOIP4KsoVAYtvp
 MVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471084; x=1778075884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dPS8B/0ftELxPYBJPOi/Jw2N6PyAu4qwVtoZHd48FII=;
 b=jPJMHyZq4dIZJToPN/b9uLu643kf5YUtngxFgOexarUBMvFzxXch1Wv6l6ppaa1zpx
 ZoznHsVEja176tniC2Yvm1dpH5v5GE+Osy9DPz164eRZO+8mgXnJueSzLTH+RnyvSsep
 FmtE9lD/ySYgXJ4C1Lm0iLLgBDn4mk/Mf12lC3C8+k5ZsNbbFFy6r66zGpUs+ko+IhsR
 AvOJY86eQ/dE6cfGso3OkzeL0R+PEW3qFxXid2o0wTKgdwzPvqfc4Zv13Kn3tphFuSdE
 dkbr585eYbKI56ONa/ThWARDiYyQ5wpJ+8PR9Mdcsm17j4khFZqqvcHb9MEiTuIm3dQ8
 TvfA==
X-Gm-Message-State: AOJu0Yy5kfkklPG/TPr0LRQxEi8vCL1Oii5qHR/b+k7QIGOvj1ziECuQ
 i7vwZP6m0we8L4QjaLBSNb9vFs9xScjDn3qxuQ2/0t70+sG4ho7pLaxY
X-Gm-Gg: AeBDieukf8ZDui0sX2Nkg0UXum4BzS0ftVDqLkgCV3oYM9HTAw+gNAHTX+nCWbzWUAk
 S+xzG9BwOgg1vEJWrtJaHWJvKVbehLElG+Jz8ppQJeVE2CYy3gW1j7SHCLHOUgbUxBwMHPgBKZj
 +FEKHEGQTQyGMnGW2Yvg+BqXbGOfPdQMnnnUW7maXmgv1MAdFzCDmXgBRi1abxZklDfGEGohsvA
 q3bLGs/riLXfx5UTKsPWTEJyPlqMfzm+CGjC0R9NGf/QPHEU8qlfihBfRey77Js41DspWL+GbX8
 VrhM74t9OTEj2udps+EdRUsiXy11ChABS2M8iKgXo16yM8+gLJbc9oqqYtLty4EjIulYits9oQy
 rcFhySbVTsV00Y/6NV9Duqun2v8sQR47kmmmLWPTMEamfvklo1nzc3DH7VqeNkJr5RQH8g0Ovh7
 rDWpEJYVBgJo86RGjBRt241eNFv0QUNZB9u1IVcGMEaxWrmFdfU6mbrTuEnrMth7C6qu2Q9q2i
X-Received: by 2002:a05:600c:c4a3:b0:488:fd7e:1063 with SMTP id
 5b1f17b1804b1-48a7b54eb83mr71355305e9.29.1777471084202; 
 Wed, 29 Apr 2026 06:58:04 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk.
 [130.88.198.135]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:58:03 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 arpit1.kumar@samsung.com, Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 07/10] cxl-downstream-port: Add support for VCS
 switching
Date: Wed, 29 Apr 2026 14:48:41 +0100
Message-ID: <20260429135717.3048713-8-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429135717.3048713-1-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=joshualant@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 16:03:16 -0400
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

When a downstream port is connnected to an upstream port which is
defined as a VCS within a cxl-vcs-switch, the port will automatically be
instantiated as a VPPB within that VCS. This downstream port will then
appear normally to the guest, but can be connected to a real downstream
PPB at runtime when the switch is issued a bind command by the Fabric
Manager.

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/pci-bridge/cxl_downstream.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 5322c46900..5e7ce6410d 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -14,11 +14,14 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/pci-bridge/cxl_downstream_port.h"
+#include "hw/pci-bridge/cxl_upstream_port.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_port.h"
 #include "qapi/error.h"
+#include "hw/cxl/cxl_vcs_switch.h"
+
 
 typedef struct CXLDownstreamPort {
     /*< private >*/
@@ -199,6 +202,14 @@ static void cxl_dsp_realize(PCIDevice *d, Error **errp)
                          PCI_BASE_ADDRESS_MEM_TYPE_64,
                      component_bar);
 
+    PCIDevice *parent = pci_bridge_get_device(pci_get_bus(PCI_DEVICE(d)));
+    if (parent && object_dynamic_cast(OBJECT(parent), TYPE_CXL_USP)) {
+        CXLUpstreamPort *usp = CXL_USP(parent);
+        if (usp->vcs_name) {
+            cxl_vcs_register_vppb(usp->swcci.vcs, usp, dsp, errp);
+        }
+    }
+
     return;
 
  err_chassis:
-- 
2.47.3


