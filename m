Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B02C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJvq-0003n6-NT; Tue, 18 Aug 2026 09:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wwJvo-0003mM-BE
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:32:44 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wwJvl-00008R-Ls
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:32:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso37214035e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787059958; x=1787664758; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kgrW8OZDk5QNSaiA2O4xvFjcLjIOIf5np0GuegvjZV0=;
 b=WAeLczO4C/b9hTNHAXTfsUPs9x2ROeULQIIrd7wPj6SDYCQOEY/4qZKNZz4PvDPgN5
 a9dkdlEDXXJut55ygh+wfjQbGCmMYaT45vgsOU11BC45hvL3Sz0K1lFl3SOdOcJa/kWj
 q97OVh/xC/HZVQIsPTv7I5Ao9vEDjfJVgq1/OLG6EBvZ6jLXAqsfGguR0/2XzUIJFU3b
 Uu+riEGJXqAAiVOFnaLAW7P42Njjh69pcQcWCb4FikzPio8hNWYojBseruMezS1zLJit
 GmcE9uU/FttEndavvt4ndFQUcngoWT3QAF/HNWczqRa9yKIXe7plwjmsyeOlhqfu9+Hy
 bPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787059958; x=1787664758;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kgrW8OZDk5QNSaiA2O4xvFjcLjIOIf5np0GuegvjZV0=;
 b=fYwgtiF9EI6VwTy2Ax4KeMjZX4uLCTbL0yVEglyGHHwCp5XWwui7wlvZ0MR7VSwfCK
 zcjmg8NboC7Wcdd9ZNaA506y6+YiRDUzNf5UgoHNiiTxgCorCeO5Qyyg1Qu84IEdzwyf
 aD4Fh8gZClafRxjw6sFBme0i6rxuS0adV4npkuittw5oOuwOFrsj2mHlOF7DCVXestWQ
 c1IatxbwD78F3hZL/ib3QaqsOGKM2NDuWE5UGFa7nPlc4fFwmPUlpww9Qtx/XqTUJWnj
 6WVxY8TC86mXQFgSMJ1hfHFMK/QX36I9JcUTjCiCNKpU54gszmNlIpN1BCmOSWAxzJlo
 7pzQ==
X-Gm-Message-State: AOJu0YyjpoLuihf/xZuxf6q0yjfX4iX7L7mBrdU3d9+Ve0T+xdZPSIwd
 GthZH+xP2jwHJWIIZq1Fb+Mbv/Xhq5xsKJ/utRwa3hKCrVQPmN0UpTJy3+11W/rgGsfqc/7scRo
 oCtI1y/I=
X-Gm-Gg: AR+sD13Jh1vYLZskFav8vb7Y4rSzpqjrPNijWxSJi5SH7CQT6sSpvtf+XrhYUtE42j6
 c8/DUARaB/LsbTdazjQEjgX2BzLvwyhGHEYigOfNBhOi9vH6T5UFGSRhYN7LOMTQawhAuxzCzBQ
 IoeTAH/l6B9+kRbqIXySJ+CmOC1bO1E2ygZTUqqLqqeJiolK2d5uCwKTonwndWgQ6uVuxqYCW6Q
 SRvWgR59SImqgxefX1LENt6yJ+Kv0+FB1MZR+dKBC8EtenAFtiAHeio6x6gVmaOqbHTTJMggbAc
 YgH3OC5DRLgJenTWZSmLB9oloxsO7K6vdaSTFFuhgbrqPksNDNSSO0Kcf2tT13defjj6tw7lsX0
 51EjeOaMq7TyeDXpqZWh1KPMdJjlZ8mbTLhlP+FWVtPmUC8hdl2co2etlotfJE4Nmcdqy9r/mdF
 RcKEP08z7EXL3axkFga3s0GRAo0FfprBsAhO7LWy/x2HlnN0971BV6V2xx32zSj/4pyGy+ZQVFF
 3E=
X-Received: by 2002:a05:600c:1c21:b0:499:90f3:13b8 with SMTP id
 5b1f17b1804b1-49990f315e9mr315450255e9.12.1787059957468; 
 Tue, 18 Aug 2026 06:32:37 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:c289:2687:e46c:f7e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b203cfsm298360625e9.3.2026.08.18.06.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:32:37 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Tue, 18 Aug 2026 14:31:59 +0100
Subject: [PATCH RFC 1/4] hw/pci: add IDE + TEE capability to PCIe root port
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-jmac-rme-da-prep-v1-1-30fab951bc75@linaro.org>
References: <20260818-jmac-rme-da-prep-v1-0-30fab951bc75@linaro.org>
In-Reply-To: <20260818-jmac-rme-da-prep-v1-0-30fab951bc75@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x330.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/pci-bridge/gen_pcie_root_port.c |  8 ++++++++
 hw/pci/pcie.c                      | 15 +++++++++++++++
 include/hw/pci/pcie.h              |  3 +++
 include/hw/pci/pcie_regs.h         |  4 ++++
 4 files changed, 30 insertions(+)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 5434d693d9..452ebf69b3 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -26,6 +26,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(GenPCIERootPort, GEN_PCIE_ROOT_PORT)
 #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
 #define GEN_PCIE_ROOT_PORT_ACS_OFFSET \
         (GEN_PCIE_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
+#define GEN_PCIE_ROOT_PORT_ACS_END \
+        (GEN_PCIE_ROOT_PORT_ACS_OFFSET + PCI_ACS_SIZEOF)
 
 #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
 #define GEN_PCIE_ROOT_DEFAULT_IO_RANGE          4096
@@ -100,6 +102,12 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
         d->wmask[PCI_IO_BASE] = 0;
         d->wmask[PCI_IO_LIMIT] = 0;
     }
+
+    uint32_t offset = GEN_PCIE_ROOT_PORT_ACS_END;
+    pcie_ide_init(d, offset);
+    offset += PCI_IDE_SIZEOF;
+
+    pcie_cap_tee_init(d);
 }
 
 static const VMStateDescription vmstate_rp_dev = {
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 4622c75e48..b9ead826ed 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -968,6 +968,12 @@ void pcie_cap_flr_write_config(PCIDevice *dev,
     }
 }
 
+void pcie_cap_tee_init(PCIDevice *dev)
+{
+    pci_long_test_and_set_mask(dev->config + dev->exp.exp_cap + PCI_EXP_DEVCAP,
+                               PCI_EXP_DEVCAP_TEE);
+}
+
 /* Alternative Routing-ID Interpretation (ARI)
  * forwarding support for root and downstream ports
  */
@@ -1371,6 +1377,15 @@ uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev)
     return pci_get_long(dev->config + dev->exp.pri_cap + PCI_PRI_ALLOC_REQ);
 }
 
+/* IDE */
+void pcie_ide_init(PCIDevice *dev, uint16_t offset)
+{
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_IDE, PCI_IDE_VER,
+                        offset, PCI_IDE_SIZEOF);
+    uint32_t cap = PCI_IDE_CAP_SELECTIVE;
+    pci_set_byte(dev->config + offset + PCI_IDE_CAP, cap);
+}
+
 bool pcie_pri_enabled(const PCIDevice *dev)
 {
     if (!pci_is_express(dev) || !dev->exp.pri_cap) {
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 71ba94874b..db66678252 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -123,6 +123,8 @@ void pcie_cap_flr_init(PCIDevice *dev);
 void pcie_cap_flr_write_config(PCIDevice *dev,
                            uint32_t addr, uint32_t val, int len);
 
+void pcie_cap_tee_init(PCIDevice *dev);
+
 /* ARI forwarding capability and control */
 void pcie_cap_arifwd_init(PCIDevice *dev);
 void pcie_cap_arifwd_reset(PCIDevice *dev);
@@ -161,6 +163,7 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
                      bool exec_perm, bool priv_mod);
 void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,
                    bool prg_response_pasid_req);
+void pcie_ide_init(PCIDevice *dev, uint16_t offset);
 
 uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev);
 bool pcie_pri_enabled(const PCIDevice *dev);
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 33a22229fe..aa21177411 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -182,4 +182,8 @@ typedef enum PCIExpLinkWidth {
 #define PCI_DOE_VER                     0x1
 #define PCI_DOE_SIZEOF                  24
 
+/* IDE */
+#define PCI_IDE_VER                     0x1
+#define PCI_IDE_SIZEOF                  12
+
 #endif /* QEMU_PCIE_REGS_H */

-- 
2.43.0


