Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11AFCCD193
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Oct 2025 07:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCvUw-00065s-C2; Sun, 26 Oct 2025 03:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1vCvUu-00065I-Q5
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 03:49:04 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1vCvUs-0003c3-Ri
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 03:49:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-29301049db3so5803605ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Oct 2025 00:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761464941; x=1762069741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G/oYF7H1MNrp4EDiT8ChUrBUiR5J7jFia5NcsuMMXDQ=;
 b=Fw6iVZSg1ZxMUbwtYFxcAWBh7jeLm0HBXQOKAUki7KXIAGU94tiuxnoFCUha0o4J5a
 wn4PBmQvHhr/yGYAdOuYlH+qgtFsHI7cjQFe6xD+6sxSSWVTXDBDnOgTcCEtj8aBJveQ
 Z0yPqQx6hQSyfqU2o83G34+HKVT+mUCB0Q73T0JpkHx4eWWiOjOfXzgCaZsb6I9Lyth1
 xnC62lzfP3h1orprQQw111qlrDeA9I5BrX/bxihTpodmKWzAk4dwK6O+CQMCILC+D6eV
 o6fA8nTBa4I8yBl4YagHD8U/FFUFmgCgv1Bxz3ytCbaQ/bNArNhg/YpA93ky5j4HBpnj
 R90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761464941; x=1762069741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G/oYF7H1MNrp4EDiT8ChUrBUiR5J7jFia5NcsuMMXDQ=;
 b=Tt9ywV3JvvZ2OczsnonSQROwdchIcHGlGKvAIGxUCOn4ToRzF/0FSSemnFa7RTurC1
 WpaeYKSJidvFmQv0Fyl86guGxaWjr/b1cUMHv2nxac7W5VY+Yhmy7TqZ9Ly9yL3YlP2U
 4I8tjN/Mteiq+hN3zaee7m4gTkoN+TeDg41iJbOOYRhFZH6yg8sqLnZf1EonD48NRVYm
 +w9N/JSFt5Uitro8OvRFRj4YQL1jwrifhDRDIjF/0yeS3MCtl9dmVmFSnjjZeBVfqFQw
 pRT91AM/80gcvS75G+hk09MqNVL6Kqs1Bi9mHYWZkgcfDPST4j958eTq6xH3x0+RSy2V
 /fuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8zo3i5WEUD5gFMvDulGRSRPppCTCICU+5ztrCiCcaxugyT3vzGdLDjwMliQx/1yiWmec1GyXGQCS6@nongnu.org
X-Gm-Message-State: AOJu0Yw98zhTCgt3pGwFzCT4eh++IQsrH0oDXRwXSEC2Rhmd1LquHOJe
 +Ek7zSexq31SYepXNk9HOveAcThd8FZTYpxr6uQZOUvyw56OQQTqww9m
X-Gm-Gg: ASbGncviQsaV1ajGHKHYlkFw8uNXwUC/soveaMuR5DrdZaF11rMioXpIpzEEkrlK1ju
 a9S+EqbaRIQsbtK/X7ituZjt/j/KgHU/W/DQhye+OcFcn0dqAuqSz3U/BYefEaJN1u948c9qRPF
 Jvh0zbRLc1E2tO1PdR7SaVLftZXQeuJebt3B2kQHavukO0zZ5b7KxQJ7MegNCspmlVIabIPbZlS
 4D8ySdYPx91uOEXMdtSvYtv0kbqs+9jh8r8maOFTbF3/iVKM4Qb/L52OL7iC570ZraCJ+LsbAxK
 P9kEwtdKOm+FXfCv/SIESIvKMFZSHv6lMruwBslTR8+NtwrJc37XNHaSVtAVhJeRCxrGwNMVPWC
 EH83tnsTlMbUTN9xBLANGCWzMBfoSa1kbNOe+u8sc7JpyQSSPn8aeBlb6kzSftt7mJq/4/XS7W8
 bQG/3ePPoc
X-Google-Smtp-Source: AGHT+IF23XD1vacgvcpD2HE01KSIzFvqT6rQ70eVYUUQn4QsHTrecd40K4MCG54mMb61iFzNDXx/vQ==
X-Received: by 2002:a17:903:94e:b0:26a:3c75:5241 with SMTP id
 d9443c01a7336-292d3fcce91mr130490955ad.9.1761464941084; 
 Sun, 26 Oct 2025 00:49:01 -0700 (PDT)
Received: from fedora ([2409:40f2:1162:986e:b8ab:55e2:7dea:929a])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29498e46664sm42987625ad.109.2025.10.26.00.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 00:49:00 -0700 (PDT)
From: Yoges Vyas <yvyas1991@gmail.com>
To: qemu-ppc@nongnu.org,
	rathc@linux.ibm.com,
	philmd@linaro.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 Yoges Vyas <yvyas1991@gmail.com>
Subject: [PATCH] ppc/spapr: Cleanup MSI IRQ number handling
Date: Sun, 26 Oct 2025 13:18:52 +0530
Message-ID: <20251026074852.53691-1-yvyas1991@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=yvyas1991@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that spapr_irq_nr_msis() returns a constant value,
lets replace it with a macro.
Ref: https://lore.kernel.org/qemu-devel/bf149815-9782-4964-953d-73658b1043c9@linux.ibm.com/

Suggested-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Yogesh Vyas <yvyas1991@gmail.com>
---
 hw/ppc/spapr_irq.c         | 7 +------
 hw/ppc/spapr_pci.c         | 2 +-
 include/hw/ppc/spapr_irq.h | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 2ce323457b..fc45a5d5d6 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -33,7 +33,7 @@ static const TypeInfo spapr_intc_info = {
 
 static void spapr_irq_msi_init(SpaprMachineState *spapr)
 {
-    spapr->irq_map_nr = spapr_irq_nr_msis(spapr);
+    spapr->irq_map_nr = SPAPR_IRQ_NR_MSIS;
     spapr->irq_map = bitmap_new(spapr->irq_map_nr);
 }
 
@@ -277,11 +277,6 @@ void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
     sicc->dt(spapr->active_intc, nr_servers, fdt, phandle);
 }
 
-uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
-{
-    return SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE - SPAPR_IRQ_MSI;
-}
-
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
 {
     if (kvm_enabled() && kvm_kernel_irqchip_split()) {
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index bdec8f0728..d596a9e38e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2279,7 +2279,7 @@ int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
     _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)));
     _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", 0x1));
     _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi",
-                          spapr_irq_nr_msis(spapr)));
+                          SPAPR_IRQ_NR_MSIS));
 
     /* Dynamic DMA window */
     if (phb->ddw_enabled) {
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 5ddd1107c3..265d43e06b 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -40,6 +40,7 @@
 #define SPAPR_IRQ_MSI        (SPAPR_XIRQ_BASE + 0x0300)
 
 #define SPAPR_NR_XIRQS       0x1000
+#define SPAPR_IRQ_NR_MSIS    (SPAPR_XIRQ_BASE + SPAPR_NR_XIRQS - SPAPR_IRQ_MSI)
 
 struct SpaprMachineState;
 
@@ -89,7 +90,6 @@ void spapr_irq_print_info(struct SpaprMachineState *spapr, GString *buf);
 void spapr_irq_dt(struct SpaprMachineState *spapr, uint32_t nr_servers,
                   void *fdt, uint32_t phandle);
 
-uint32_t spapr_irq_nr_msis(struct SpaprMachineState *spapr);
 int spapr_irq_msi_alloc(struct SpaprMachineState *spapr, uint32_t num, bool align,
                         Error **errp);
 void spapr_irq_msi_free(struct SpaprMachineState *spapr, int irq, uint32_t num);
-- 
2.51.0


