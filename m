Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCCDE77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSER-00066m-68; Thu, 19 Dec 2024 20:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEP-00066D-V1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:10 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEO-0004D8-8u
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:09 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-725ef0397aeso1168154b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659706; x=1735264506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HqifVR41qT8QBk7MxQ2h7FqesyXFqyjsxZmtL55tQyQ=;
 b=Q1s1EqYGTPn4vAj0i7M3SfU+J8Cpt3/TSVWm+An60cEDVk/T0OWk4YNIvipamAtbko
 dUoPMu0NvFeX+2W0WiD2kRtpOLNlCB27x8wcf0stBDVoi/Tdo0LGI0ph0TWRcZtma3kI
 Nfi9yWP1ye3cduSwB+s1Hl3q+Feh2o7bM3r94FcE1k8UXfle3pBw7elshawLFfA3jbzO
 PBpkRQWHuWIEZOfSrjZuccjktalCe5BeGAJDo+uOVQ2/ncKUN/6xa3qgh1ygUGWGoZGK
 H7Vs4UKPp47cPskYAqoVN1IxIy3gePGeb4xix+3aGfwbQ1FB4zIFcv2wQZ9Mf0xP4qNj
 JiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659706; x=1735264506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HqifVR41qT8QBk7MxQ2h7FqesyXFqyjsxZmtL55tQyQ=;
 b=neRjKvqBcnSd9GK4kTyTUikayC58+q2viK+JlokIyFovHRemw9gmoOLSneqzzWFGUX
 HnMU1/fw4703hQxfFswsy5fhx25OLKCImKtreDq5KYp3H0rdX7cBHRcn/G2LXlhgfd5p
 Bj4iCMOc/RIG9Py1SO0AxhTynwOaKdHTVY/2Zn3lHjKP8V/xipFvdjfuMpAXR97E1Ayk
 pBP+pkoPTfSipOEOIAPLsa2rnC/e90vRQKEMXSLbcEV3oyBYrhk4ul9H9/b+Ij3s3VJ7
 380IFeh3zoyR95OSSgTezffd2pjqvsQ1VRD91+1RVq1j+z7qr0JKJUiGZ1tGyI+pHmBf
 wL5w==
X-Gm-Message-State: AOJu0YzVr02/wpzD/89EDY3P/dTyW3fbxyyp2I9F82luwcuaSilTN+xW
 2zNeeppqUpSC/6M1h7tnq4fBD9H5VWIDZz5Img1XLySXoh6WNzLG/kKZfpN+
X-Gm-Gg: ASbGncs+bi0PH66qFN61x9bBAvpimOg7rRNhF3vC2T7goC1EBfbLHP/yvCAwDbx9+4X
 j3SVOX049PQjQ44Al3Sysr59LlKAFHW1dlCw6GArfFbGQQytx1f1Cj1+tid9nj0srdyep9ujzUy
 7HbuRcqYhMcrzSDUfCqtLIITxkbSDY7D3q/VKJSmaj/vWgvrtnqVf3mQ07p3VTsvac/HefXHQOb
 H03YopDrhiSMa70sjN8D7jYdDsM2t3RFkqMdFPvUDieTfKwkLQdZcb/5Mlf/kR+dDHGUQPWeQfe
 LHTvXvNs6QCXuOtIGQdK3f0Na4aVJ8SmgF1LxB4RjfSywcEQKevC8eE6DicwoeA=
X-Google-Smtp-Source: AGHT+IHrPnZjKPU63x80jxPBnba/5PMHgtiJThgkynD0bFWegHPWsa+JtXfffsG+fwsGhwQgoe3PDQ==
X-Received: by 2002:a05:6a00:1309:b0:725:e015:9082 with SMTP id
 d2e1a72fcca58-72abdd502d5mr1357044b3a.5.1734659706135; 
 Thu, 19 Dec 2024 17:55:06 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:05 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 04/39] hw/riscv/riscv-iommu: parametrize CAP.IGS
Date: Fri, 20 Dec 2024 11:54:04 +1000
Message-ID: <20241220015441.317236-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
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


