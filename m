Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D27C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WPw-0000yE-HZ; Fri, 04 Sep 2026 12:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x2WPm-0000pj-GV
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:05:20 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x2WPi-0006Bm-3V
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:05:17 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c25420fe973so199780966b.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788537911; x=1789142711; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kgrW8OZDk5QNSaiA2O4xvFjcLjIOIf5np0GuegvjZV0=;
 b=CPXbcQPIfafShko7ZTaD6NKWHvX1sJ2et8tW5RNpQkghUAiQOzcD77+fF9wVeuYscn
 JPEDndtVZ/0p+tdBtydbiyXdx3ZHSuzPFOtWcv+zc8t3tXGms+L7lTrk1CuQj9B1Fc+4
 SMERELuxmAM0e3gF9CpAMrWmyZN5fp3mObVOcSafIQxN4RxbIK4UwAbSDBFnWpufdMpr
 2pj7CCg32onvX7aEMVFQmvoGGxmNZCs+6Jm8vcYF/2VB2ZgcEJIY6lkFLoUEp05baVxC
 BJzD8rhfOfT7M1T5FA+gyzMR6tw63fct+gmquDH8fxQr1PyK/oKbmxyZdIRQeNEpMvX5
 +T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788537911; x=1789142711;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kgrW8OZDk5QNSaiA2O4xvFjcLjIOIf5np0GuegvjZV0=;
 b=DwKpwddAcZhP4I56jDMcQR56NU2PltP+PweZHf1eC4B5SLRxL0hKiaT0/PIYZBszbq
 LEXGbcOb+YZijR5FZGL2ZcJmuaewOIDAu5vIp7YxyOf1zwO1VVXaAJj95cKh0iGB/tfL
 Yu4xsDBvqyvbvCe2qfrBhINXMCWdluFZEqmOelfyZ5eVte3PS2Dmel2yCP3wsagAGpqw
 /l8xvgLn3VH2rTsxF4MAdWy/0oQeRiSpFpP7nXlHBdbMJNSbnPDhgAAdCx462ZuI1dWU
 qBYuYhyEV01bmPs2IzalrsTx9F9ML1Kx79Za+F/mzdZ2WM0OKRKFvdETkUYAffsKEBLq
 hpAQ==
X-Gm-Message-State: AFuF++ma+LpqRjVeW+u3EyI+vvrC4AsGm4uh1q6Fa7fOZPRpv0TAgJYR
 PQOhwl3hQoO7s/eLS4vlGjVk6R5OmTDWibE8cnWDCouLHLxWZjNFls4CfARquyFUPm8=
X-Gm-Gg: AYBFou2iDE3kw4RCxQFt9L+5BLelmogCyRPBTNEa4U93lRXViCjcjCbl0JuUhHLA+jW
 wFL+TZevPkvwvYlGts9pK5cmb6pZgPwbBnKcZgfXBQG5DsS7CPeeBi32lqFeuAHEAI5dNu7Y61P
 eXrmaZ5tTHrjYnX2MbPqOa5M4xR0JwYPfuEtYjZ+VsmMK2lz5kalWcekB5ewEJHM8lny1zViDZe
 1c3yXilS7J+rQtQ3f6jGa0DQCbC1U0uXseINgk+7FStltdIxKKWl3/vIqFIAhlbeQ90oEg9hEKE
 unRU+jyhXaxP8jBxBSI+1AEUZm23RZGdFZS26ueJy3xRZhhExQ51VapIFklXQqDcuaLvwgxY7b9
 bnTFMfh0ujmtpt3VSc+niH4SWkHO+vU7zbX3boagjUFwWjGfk1Edra8jZaEUNorsPQJTsRpVWSZ
 yvouSTSvLbImd+0KKcHfrlgWZuAm+h/VaeWVE+Z4LcNndDEBIOy5vz2leCnmrDVUsT
X-Received: by 2002:a17:907:d01:b0:c26:19de:9138 with SMTP id
 a640c23a62f3a-c2619dea192mr169951066b.43.1788537911012; 
 Fri, 04 Sep 2026 09:05:11 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:60d5:49d3:5d47:8dbd])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d036674sm133815966b.8.2026.09.04.09.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 09:05:09 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Fri, 04 Sep 2026 17:05:01 +0100
Subject: [PATCH v2 1/4] hw/pci: add IDE + TEE capability to PCIe root port
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-jmac-rme-da-prep-v2-1-fb461d78bbb2@linaro.org>
References: <20260904-jmac-rme-da-prep-v2-0-fb461d78bbb2@linaro.org>
In-Reply-To: <20260904-jmac-rme-da-prep-v2-0-fb461d78bbb2@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej1-x629.google.com
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


