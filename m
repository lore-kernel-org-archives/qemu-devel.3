Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E02E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2Yw-00032Q-2F; Wed, 18 Dec 2024 17:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Yq-00031Z-6P
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:32 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Yo-0002Rb-FX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:31 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-216395e151bso1310415ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561029; x=1735165829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HqifVR41qT8QBk7MxQ2h7FqesyXFqyjsxZmtL55tQyQ=;
 b=ErVooFfht1DXlGq0fxhpxecYyh3VrMu5ta8iGUmydqD2wgaARELZIJPVRPS/WJveOt
 71QhqkeRHUWqgtw6ymxwWp20x/8xNDyk0spenDCyHfhgrLTtfdLm4pCZHDzmY4xJ2n7T
 83wuWWwx2JfF01bOs7686CN/bTuTwX92FiKJHvxFH8oV4INYlgNrvyXyD+sqzXDISQV8
 XYSgurxvutws5M9gLNlIuNPlvOHPb3mE/bguzsAtU8Or7mo8utqUvb6c3tbUFYWsgTNK
 oWDEenBCUxXO9K6b9P+7N7FWVpMwB6VRj49SYz7F6juSpi1eRSGZ1ex6tE1MSViriHxC
 wWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561029; x=1735165829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HqifVR41qT8QBk7MxQ2h7FqesyXFqyjsxZmtL55tQyQ=;
 b=n1ftPXW2OeXhrMQnO0z9iZEaFbV7cFJpMYOEu+BThIQcVt1ySkdffnoyrpyJ8+13r0
 AVx30gO2tl7qGgESVNJ4tMFTv13k5z/F7l042qEwQLdqhYhcEejuU19T9jJTdCUgg3cz
 9vNHbg/2myIeIk5MZ9SilBQnA3alR9w88r4xR8LnqHbnMmbrHuI9HQOLyN7hcUhU4VPH
 9zdsKYFTeEHvfdVp1dHcAf9IeUP+1IB3YfPewFF+D5D+ET+Wxo7+3dbE77C0IgZOmeo7
 blhyuXP3sBp5qmYF4L4jMf05aQxV7uf0Yjd9d2MWukCF8C43reNT2dEr6Oi0yLQ3Up8y
 XBOg==
X-Gm-Message-State: AOJu0Yw03ZuehPOxy02D/HPBmEtUJrXhtqYXG9cEivRz4iSraxAi4LVz
 e+zS20hwR88fykE0l1cCL10rBhXg3JkvyNm01HDlgi15od0s0kEkqHJYd1T+
X-Gm-Gg: ASbGncu2ICwYQiHkZq8j2hhHR44M3t6bY9OnSj3gl/3czizMMrM/gv5JmT+3pvWOqk0
 HflGux8HIjDNAjPYV1jS2IQvsFVtu1agmhUs/iAjRPH80eW5ZGXxb6CU7VUPcsWJoVuKL+BFRmQ
 PlhFKDr4HHheJ0WnPYWRm285xD93aXF1/tV3pjU31XHnJKuLPiEEYuUCEMWN/I4ts+qyLQ57SwM
 E+30F3mxNAfa+R1rQOqkQOJosuPKAoAd1Meqv4CDChLZK+1RKdFpjCLmgzLfYJSQomYuQYaLDjI
 YSoROK2dbOAnhVBUlaZ1+LKqlaUcBZvOg1lyqTFFYC6RXZC0TPEwAw+E4ZxDGro=
X-Google-Smtp-Source: AGHT+IFCYETqEA2t047qqXoGslopBlCvOKvFX4xJkVwj8OZS995BxWhomWxfP5MmlKqk7wL8ymnpQA==
X-Received: by 2002:a17:903:2acb:b0:215:4f99:4ef5 with SMTP id
 d9443c01a7336-219da7fd305mr14797595ad.28.1734561028753; 
 Wed, 18 Dec 2024 14:30:28 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:30:28 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/39] hw/riscv/riscv-iommu: parametrize CAP.IGS
Date: Thu, 19 Dec 2024 08:29:34 +1000
Message-ID: <20241218223010.1931245-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Interrupt Generation Support (IGS) is a capability that is tied to the
interrupt deliver mechanism, not with the core IOMMU emulation. We
should allow device implementations to set IGS as they wish.

A new helper is added to make it easier for device impls to set IGS. Use
it in our existing IOMMU device (riscv-iommu-pci) to set
RISCV_IOMMU_CAPS_IGS_MSI.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241106133407.604587-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-bits.h | 6 ++++++
 hw/riscv/riscv-iommu.h      | 4 ++++
 hw/riscv/riscv-iommu-pci.c  | 1 +
 hw/riscv/riscv-iommu.c      | 5 +++++
 4 files changed, 16 insertions(+)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 6359ae0353..485f36b9c9 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -88,6 +88,12 @@ struct riscv_iommu_pq_record {
 #define RISCV_IOMMU_CAP_PD17            BIT_ULL(39)
 #define RISCV_IOMMU_CAP_PD20            BIT_ULL(40)
 
+enum riscv_iommu_igs_modes {
+    RISCV_IOMMU_CAP_IGS_MSI = 0,
+    RISCV_IOMMU_CAP_IGS_WSI,
+    RISCV_IOMMU_CAP_IGS_BOTH
+};
+
 /* 5.4 Features control register (32bits) */
 #define RISCV_IOMMU_REG_FCTL            0x0008
 #define RISCV_IOMMU_FCTL_BE             BIT(0)
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index da3f03440c..f9f2827808 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -21,6 +21,9 @@
 
 #include "qom/object.h"
 #include "hw/riscv/iommu.h"
+#include "hw/riscv/riscv-iommu-bits.h"
+
+typedef enum riscv_iommu_igs_modes riscv_iommu_igs_mode;
 
 struct RISCVIOMMUState {
     /*< private >*/
@@ -85,6 +88,7 @@ struct RISCVIOMMUState {
 
 void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
          Error **errp);
+void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mode);
 
 /* private helpers */
 
diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index a695314bbe..a95d0f74c8 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -155,6 +155,7 @@ static void riscv_iommu_pci_init(Object *obj)
     qdev_alias_all_properties(DEVICE(iommu), obj);
 
     iommu->icvec_avail_vectors = RISCV_IOMMU_PCI_ICVEC_VECTORS;
+    riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_MSI);
 }
 
 static const Property riscv_iommu_pci_properties[] = {
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c461ebbd87..24b879822b 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2130,6 +2130,11 @@ static const MemoryRegionOps riscv_iommu_trap_ops = {
     }
 };
 
+void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mode)
+{
+    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_IGS, mode);
+}
+
 static void riscv_iommu_instance_init(Object *obj)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(obj);
-- 
2.47.1


