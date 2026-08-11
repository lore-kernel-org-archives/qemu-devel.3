Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DDBC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnak-0000ae-Nf; Tue, 11 Aug 2026 10:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnaM-0000Iu-Nt
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:36:13 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnaK-0001tE-Mm
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:36:09 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-52b6543169fso19601091cf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458968; x=1787063768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xsYLjlscox7P7BfombKX5T/LNj0yU2z7O4B/638wR0E=;
 b=H1BCb0lO4QPG6IO63OAZn8t9Ma6EzPHzp0PAIQ0O0wZK3TY4jX/XrNBs8HipKc9SJ0
 nT9SmN1fl8IviYmUWn2NluG5U2x66T5cYyB4/9IlmarSUn90FlZX1Z1Y+CyJ0lKVYbLx
 fTH6+W5k7ywsSgU1YxURbVEKBF4HeUfGuGrImrUUrJGD4qhiw7scQjGIIeARi0qypb3C
 SdsH8rKMV5rmeJ12TpzSPE/egA0v1Hcf7iZFvR7NiuV43tpsB8RDn3t4Wh/dHuXgcsf1
 rA/1XsmGmZoSPfg6/RYnwj8hafU+SNgQXi0CuhkI4/57IEp+GiTBb9IIYhuIEKeaiybr
 YW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458968; x=1787063768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xsYLjlscox7P7BfombKX5T/LNj0yU2z7O4B/638wR0E=;
 b=cxq6jBbehZReDjGfMyDGIJk27C8IJfFOXc0w16NU3crUuqRZ9If6hZuv0UkToYNYCt
 YfnRcGkKIPf5TvkqeLytLdjpZMXowrGi4046KqqCjveUWIDCXmI5pn/zFEsQwW2MTJZU
 C8gRfR4MW71wRu0a3LeSCGOPqOWR72aEmkoXJCwDnJLmCqTrZGTTG5uOnl5/BCpMLhW0
 Lqs5xNlp7GKVT8Tz6SFhUsbCthUQMkoippzqyqeMeYII0t0OKCQPeUj2Xr/kSjZVdca3
 dYXxGs6MK6qgqFH29anq3AlCeR2mLx9yQ4KYeu4rUCJHXpf8vyQgPynJt9idDGPPwTmh
 v2Lg==
X-Gm-Message-State: AOJu0YyWdisI6lRlksPlMRfMe9hL4s5FyMzvQT1SQG0KLIsDNq33mTjs
 7sEiu/h5h50aMvZu0KN1fB+xOGNLsxY6kcxvChkxZiMVzS4GpGREYhIyWGnKUg==
X-Gm-Gg: AR+sD11EGXA1SLTHQYJoPV045jltBcsKlQRXXZ938FFIGrk5IAWgVsSCDOJRl0WaHZz
 DFpmD3EiIljShy+Y4H2o3JKfN8cS45vyWilsWSu6wb0OfzcjWxgDrEkLOlfJCoUsLaizY1XxcvQ
 KcnK1pGcg2eJMB1hM24VJAA4Wr4wfm1mQZzGh0ySaTfl+LRelGT/TmP09BUpYqHS8szD0SjX+rG
 ykY5QTmPjmyyRF2EmbbVkZ/Zg2pKBwtdBzgY0Ya90DiCUwNudrTKmcvljUrdBS2AL8OSC+vGHaX
 VfSSay6hyEvPbK5FCaLSY0LL0IfpmzmqkvNK5Z9Qw4TlGHPuYkafIoxMZV9V3Ix5vEn/4hWco8q
 PxG9Z3ogp6EEPHylKgB3XdRsWVG2xt4US1Ek5dwa3UelQAKFUNCN0795LftkQrk4rCcrE8lnidH
 foPD16zSYZutI5RmGmCL/Esi/Rdl8GVuhSPUSOf7LFhae2s085x2kY/3Wot37hHT/8idDdXsvTV
 uvaUQrBEOr73ux0M4E=
X-Received: by 2002:a05:622a:15c3:b0:528:3216:b802 with SMTP id
 d75a77b69052e-52d58544b0emr33334841cf.15.1786458967672; 
 Tue, 11 Aug 2026 07:36:07 -0700 (PDT)
Received: from localhost.localdomain ([198.16.145.87])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c26e074sm681286d6.2.2026.08.11.07.36.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 07:36:07 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v2 08/19] hw/net/bcm2838_genet: add GENET register structs,
 part 4/4
Date: Tue, 11 Aug 2026 10:35:45 -0400
Message-ID: <20260811143557.7862-9-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260811143557.7862-1-marcelomanzo@gmail.com>
References: <20260811143557.7862-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Sergey Kambalin <serg.oker@gmail.com>

Add the PHY "shadow" register structs (BCM54213PE PHY-specific
clock control, RGMII mode, LED, and expansion-block registers
accessed via the AUX_CTL/EXP_SHD indirection scheme) used by the
MDIO emulation added in a later patch.

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 include/hw/net/bcm2838_genet.h | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index fedfbde066..12439b580d 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -25,6 +25,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_HFB_FILTER_CNT      48
 #define BCM2838_GENET_HFB_FILTER_SIZE     128
 
+#define BCM2838_GENET_PHY_AUX_CTL_MISC  0x7
+#define BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE 8
+
+#define BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT 256
+#define BCM2838_GENET_PHY_EXP_SHD_REGS_CNT   256
+
 typedef struct {
     uint32_t rev_ctrl;
     uint32_t port_ctrl;
@@ -273,6 +279,34 @@ typedef struct {
     uint16_t rdb_data;
 } BCM2838GenetPhyRegs;
 
+typedef struct {
+    uint16_t reserved_0_2[3];
+    uint16_t clk_ctl;
+    uint16_t scr2;
+    uint16_t scr3;
+    uint16_t reserved_6_9[4];
+    uint16_t apd;
+    uint16_t rgmii_mode;
+    uint16_t reserved_12;
+    uint16_t leds1;
+    uint16_t reserved_14_18[5];
+    uint16_t _100fx_ctrl;
+    uint16_t ssd;
+    uint16_t reserved_21_30[10];
+    uint16_t mode;
+} BCM2838GenetPhyShdRegs;
+
+typedef struct {
+    uint16_t auxctl;
+    uint16_t reserved_1_6[BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE - 2];
+    uint16_t misc;
+} BCM2838GenetPhyAuxShdRegs;
+
+typedef struct {
+    uint16_t regs[BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT]
+                 [BCM2838_GENET_PHY_EXP_SHD_REGS_CNT];
+} BCM2838GenetPhyExpShdRegs;
+
 struct BCM2838GenetState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -284,6 +318,9 @@ struct BCM2838GenetState {
 
     BCM2838GenetRegs regs;
     BCM2838GenetPhyRegs phy_regs;
+    BCM2838GenetPhyShdRegs phy_shd_regs;
+    BCM2838GenetPhyAuxShdRegs phy_aux_ctl_shd_regs;
+    BCM2838GenetPhyExpShdRegs phy_exp_shd_regs;
 
     qemu_irq irq_default;
     qemu_irq irq_prio;
-- 
2.47.1


