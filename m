Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015B4C3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MMT-00009u-84; Thu, 03 Apr 2025 11:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLd-0007kb-24
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLb-0000V4-09
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:16 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso7239405e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743693552; x=1744298352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGlb1wEFZdltIP7kYy/1AJxZQ0OAvinfht2Hxi3HH+0=;
 b=JkAeApmbCeG3wXCjnuNjwMcmFlwDPCpwCvviPjfbzLH/y7aF34wHjgkRdQ9UwuAnS/
 41oQeItOTRfIDXiToj2CY32ycurcXa6YCPjjG08vmgF4OsPP93PTf89XWtsbY7GVH6Q3
 tML6aVHP4o64lkmb1gps2P9Pk5zX5k2EGLGrKLKiQsou1lKGnTqdcK7cCJqQriYRDfPt
 gNyoUGe82pg2hC5Cio1vJDmB7LlYrPNWCtZmurop0OczQHMAn6QTh8mdRr9TlgwaB5iW
 +EGKXnnzSOLSKAAqVYt3ZjPA+O8mRgbMHIzo5avw2Mk3712ss4f0DpZgU5azn0io4ZsW
 ViqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743693552; x=1744298352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGlb1wEFZdltIP7kYy/1AJxZQ0OAvinfht2Hxi3HH+0=;
 b=tdYIt8w1WvYE7LrWDqeTgDCnYpjlaF9L4fXfdba0IyLTmk/vYumblD3S6T1WMvRwk7
 O/SIj383P7PagsU//vPwlg4TFvroQ88lylWoUEqJr2mhaMhnEFI2rPBh3Xgjl0OS+oHM
 Q+3oXxxrs0PcCnxS6O+ZRZVQo202IIZtx1Mkg0rUYvLjIQiEm5D2D/zSn4fHZW2YrnGO
 5oLxa3OaGTkpMYYEbp4UKg+yIKxZofJR1l5OQOovhtcupyfvdMjyQW6r7AqUjwb0pcjm
 d8yjM8ijFpkHyNgaRRWI3y5NpFkkfdST/+3df5qb45A07J1WWDt7yQf9LSz/yA+aRIaX
 y9yA==
X-Gm-Message-State: AOJu0YzC6oyrhFn5adpf3lZ3C5DvpPM4MJK2wUWFWiA6xCIGYkVFNlT7
 2HQayNZ2NWceil5W2wXFjhaiBzkrpS2fA/vMfGvPHShuhb94C2O8thEt27kjpmeG+MaofsDqZlF
 5
X-Gm-Gg: ASbGncuqZCMr7LVmQ9CrrwsAOL20kl0Ggl79RAaYK7dPiOagSgwRyzBm0Y2Cj62zgnW
 Wnd8gEtb8CFRDi/ByzfYD6BCJXzrQdK/6ONyp7zLDi6lHEVftnjgyXFYA/unrvMSnR/28dn7SoE
 dSnc7LhNOp7tE9b3Q3n9nhXI7+voEa1Pr0LfK7nzMhhxVImlBrUBkezsij+YzdplHmQTtEnhcwq
 THlO0CDTCH9EH/tAriWZRNCE/c7639E4ZugSEL6IvRrDNZiFrPDd6sejJJpoiJW31a13yB668MG
 ILe7vnBAkgap0r1hDOkvCJMv2ziM2PnX13U614sBylkKPcMHdV9RwlfOXJFmFiJylfOqNX/lSpH
 sGxdIF4HcxIVLMVXwkAw=
X-Google-Smtp-Source: AGHT+IEb7W4XBFmFEhZG31hXLd/jbpvC/D2LAFzvhuQzCuKj/Jx5+ik3gvNxS8uoJP/MyCfpY0IfvQ==
X-Received: by 2002:a05:600c:1f96:b0:43c:e8ba:e166 with SMTP id
 5b1f17b1804b1-43ec44368bamr23023775e9.22.1743693552453; 
 Thu, 03 Apr 2025 08:19:12 -0700 (PDT)
Received: from localhost.localdomain (145.171.88.92.rev.sfr.net.
 [92.88.171.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226e9asm2092670f8f.94.2025.04.03.08.19.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 08:19:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH-for-10.0? v2 06/14] hw/arm/virt: Remove pointless
 VirtMachineState::tcg_its field
Date: Thu,  3 Apr 2025 17:18:21 +0200
Message-ID: <20250403151829.44858-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403151829.44858-1-philmd@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

VirtMachineState::tcg_its has the same value of
VirtMachineClass::no_tcg_its. Directly use the latter,
removing the former.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h |  1 -
 hw/arm/virt.c         | 13 +++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c8e94e6aedc..17c160429ea 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -150,7 +150,6 @@ struct VirtMachineState {
     bool highmem_mmio;
     bool highmem_redists;
     bool its;
-    bool tcg_its;
     bool virt;
     bool ras;
     bool mte;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a96452f17a4..c0748cbb95a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -710,11 +710,12 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 
 static void create_its(VirtMachineState *vms)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     const char *itsclass = its_class_name();
     DeviceState *dev;
 
     if (!strcmp(itsclass, "arm-gicv3-its")) {
-        if (!vms->tcg_its) {
+        if (!vmc->no_tcg_its) {
             itsclass = NULL;
         }
     }
@@ -831,7 +832,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                             redist_region_count);
 
         if (!kvm_irqchip_in_kernel()) {
-            if (vms->tcg_its) {
+            VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+
+            if (vmc->no_tcg_its) {
                 object_property_set_link(OBJECT(vms->gic), "sysmem",
                                          OBJECT(mem), &error_fatal);
                 qdev_prop_set_bit(vms->gic, "has-lpi", true);
@@ -3357,12 +3360,6 @@ static void virt_instance_init(Object *obj)
     } else {
         /* Default allows ITS instantiation */
         vms->its = true;
-
-        if (vmc->no_tcg_its) {
-            vms->tcg_its = false;
-        } else {
-            vms->tcg_its = true;
-        }
     }
 
     /* Default disallows iommu instantiation */
-- 
2.47.1


