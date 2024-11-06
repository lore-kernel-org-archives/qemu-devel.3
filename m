Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82398D44D62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8gB7-0001gl-IB; Wed, 06 Nov 2024 08:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t8gB5-0001gD-6J
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:34:31 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t8gB3-0001aV-Ki
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:34:30 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e5a62031aso5457187b3a.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 05:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730900067; x=1731504867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pf2EjqyLwqwTOez3ga3+F5Pahm+OzloPlTLYuNjieFM=;
 b=ZzxWhADqt7ZVVuHWP7my0eBftigVZoPjKpq0XWRYPchYxpD3j2774Fj7JoX9ws+Abe
 QEazPbp6qu1veiRF0YImYjXVGGsRlWQ1EnenWQuJSl7qFZoouEvSgVbcOfo0/83JwtS+
 HOZ/zeCLc7myR6FHsbeHUv7XmwGFcI/2ei8OjF0WkLJK4SbntXzMlp4Q7vij0YwX73th
 IX3BpbhPfIGCSNLuyJpfNKpGe0seossnuk04LoDSXQq5MN0jJPwGZ0xHGw/vsDePzs3s
 VkC/nAZm/sfhBuTU0gUKsECSMl/1A/o7YlKuBTvHfhNzimC3xlQiEvoZJ70/2ZRboGC8
 IaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730900067; x=1731504867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pf2EjqyLwqwTOez3ga3+F5Pahm+OzloPlTLYuNjieFM=;
 b=bGsUFrqgA+F+TAD4Sk8fFPrhnya7IJDmPvziFMLHf7fVDkViAhpVpgZKnm3P4qbOIW
 s8PMQ0LiYzrNgaRQWTzZO+UWU4ZvgHSOHt08gjNRhmYIApC4krga0TjZxMLCTwXuqqyf
 86qxsHp4rFSeDlS9UVn896OgA+AJreybLGh2oNfSC77405vq8b/2Ztvs+T5gtFIjPt7l
 gq5t6SbRmYhXi3/+1TiVx0n9QtuyOBd4utmXyDS34pKh+5PCUUSXit1Nb2f0W8p61TZ/
 81boyoTTAWSdJyH8ul8cD12qgY+Ju8KGuAWupQAzvh0Eda45UGlKdQT/Hm6mm+Coy2nq
 DZag==
X-Gm-Message-State: AOJu0YxpIFKf2fXtfahG0DBiPcJfRxIgm0glnVBayQFotezmdKfWGiFZ
 BpvVOQg7gUZNyiY+nLwpHE7WJPKRewTkVtMkeBVUwS/YJB2enfo9OkPmS8KgDReiUvIgxIL0IC2
 R
X-Google-Smtp-Source: AGHT+IGvpBZeKDdfyohdAZ7akkklUaDWZfMd8PB+00HtZySuwPdgiYSsgPz9HPvZkS42TRtsUnptOw==
X-Received: by 2002:a05:6a00:1708:b0:71d:f423:e6cc with SMTP id
 d2e1a72fcca58-720c98d5c3dmr28187651b3a.8.1730900067539; 
 Wed, 06 Nov 2024 05:34:27 -0800 (PST)
Received: from grind.. ([189.79.22.174]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2eb64esm11749765b3a.168.2024.11.06.05.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:34:27 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 2/7] hw/riscv/riscv-iommu: parametrize CAP.IGS
Date: Wed,  6 Nov 2024 10:34:02 -0300
Message-ID: <20241106133407.604587-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241106133407.604587-1-dbarboza@ventanamicro.com>
References: <20241106133407.604587-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
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

Interrupt Generation Support (IGS) is a capability that is tied to the
interrupt deliver mechanism, not with the core IOMMU emulation. We
should allow device implementations to set IGS as they wish.

A new helper is added to make it easier for device impls to set IGS. Use
it in our existing IOMMU device (riscv-iommu-pci) to set
RISCV_IOMMU_CAPS_IGS_MSI.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/riscv-iommu-bits.h | 6 ++++++
 hw/riscv/riscv-iommu-pci.c  | 1 +
 hw/riscv/riscv-iommu.c      | 5 +++++
 hw/riscv/riscv-iommu.h      | 4 ++++
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
diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index a42242532d..4ce9bf6b78 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -155,6 +155,7 @@ static void riscv_iommu_pci_init(Object *obj)
     qdev_alias_all_properties(DEVICE(iommu), obj);
 
     iommu->icvec_avail_vectors = RISCV_IOMMU_PCI_ICVEC_VECTORS;
+    riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_MSI);
 }
 
 static Property riscv_iommu_pci_properties[] = {
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 1893584028..d95b4b95d8 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2096,6 +2096,11 @@ static const MemoryRegionOps riscv_iommu_trap_ops = {
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
 
-- 
2.45.2


