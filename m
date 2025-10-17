Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CB7CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kDX-0003vv-3Y; Fri, 17 Oct 2025 09:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kDN-0003oe-R1
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kD5-0004aZ-9H
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:46 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so1960386f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706567; x=1761311367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/4CR0KG3sLN16Y+p37w7dv3aFm2uWBfTJDp9n3g/Ks=;
 b=JPTa3dTsfQeZ6wRBe8Q/gEvY3c4D+a/u0Q9QbTOhZiw0OSGIxjyK6GUd9/MpK+q2pZ
 rdk2hEwlLmpl/0EpWzD+nMrGItw9asH5cNJF+q4LFe6srr1WmEdVdE7R0ZgSD2458X8I
 4uNPWnkzTP1wSAoaNy9RienFsMpYF3NPykX1HS9s7pRYkqCXCYJ8OnK4m8AMnaEjUZ8Y
 +StUlhB9owCX/JGqpd4jcoPfihgoHM+jq96UXfBdCbQcAaw5+n0fnWm6Mh6XQMRb0Kw6
 83oYDRJJpeYNAwFswdlLrt9258JL9pgbn8sQX0A4CP1UwCWs4MEn84HR1lBJvwevf7vi
 wRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706567; x=1761311367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/4CR0KG3sLN16Y+p37w7dv3aFm2uWBfTJDp9n3g/Ks=;
 b=PS3f+cDHESxFzheVphoPVzDmFCC/rsYwCHnJ+cuA3JciYJlxTz6LilnQJoIbTxOAH2
 fMUMIR20i9pqtcsIXGo/0toinWa3gNCwUnAos3v9EDrv1WPCUEBC042qSGPBPIavkijn
 d0h8DbU3bTlEsd9He28lHFqjQx0nFn2sS+pZPAi/8GfIkyM/9xQzLN6BUM3yE5haoiOB
 Pyq8mvGIFnKA00AzOzCDWM9B8l4/WmuUmf1PZlBvT+IhjuYUv25/+Nq3GjkL5xrHan0u
 AkFje3LKRJXB5SFJLLp8v8eBt+46R+ounURZA3LypkMyE/0pm6Ti8xkra82z2AQ1gDS4
 HiRg==
X-Gm-Message-State: AOJu0YyM497rQraXfejc+MV+NMCCRohKY+Rykg+Bc+9iNuLSao23IhaY
 Er2gNgZNBqbPiFGxiFTvNjxiR59HOAeXV/7IpreZiNUP9E9GdWjgX/sc5RgymyU44WmRRt9j1jH
 3Y/xUhYg=
X-Gm-Gg: ASbGncszRQgvQ6Pz+a1DZSwtEUWhg7J28/vppYB/uFdPEzDiCMoIlxbTxkfpgCswSPH
 jDWisSExF/EQKJSH1NDf+dBCCv4/pj8XCY+mbShn0vFq7MDKwH6g6mpEzwh6E4YJk908dyyOiXw
 cGwzK18JEy2z13Zlw4YtW0j7Nb5VAO6U0PRJ1j21B1V92e+qH9ADh320Gz/l6EAEn/jmZN/t5/b
 2OFdL+RXaoNzgiylIYdGFMEuzT1IErMej1TV01SYNJXZZqTeNwchPfXWdio5+8xBBir7QXOtbSa
 IZnYfs5Aw7Rdm96KtZ0UQjonnmomurhJwnM1K9QkOQzJ4vhH+xxiULf5d/yj4YGfE39bvmyD6Xp
 syN9qAqCcGnFZ4rJvIKDWIC7u6yfDzktv2Wx5Z8Y3NRjto1a6tpL73YbqLc6BdN2oFQUVlYQdIX
 4I6WqnUATvTGS85pjr1SC4WP/mo/ooY6VA94PhX8zpov0PlSTQNAWNrV2YBwvq
X-Google-Smtp-Source: AGHT+IFvecIm6L8RkVTs56+m4o4LTc760F0HVwmo5AKmOvOUfD9DqVf76mE5cKnYxwwNQoTO/ZPkxg==
X-Received: by 2002:a5d:588c:0:b0:427:83d:34b6 with SMTP id
 ffacd0b85a97d-427083d3c88mr1412162f8f.42.1760706567205; 
 Fri, 17 Oct 2025 06:09:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1024sm40333313f8f.42.2025.10.17.06.09.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:09:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 13/20] hw/arm/virt: Remove VirtMachineClass::no_tcg_its field
Date: Fri, 17 Oct 2025 15:08:12 +0200
Message-ID: <20251017130821.58388-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

The VirtMachineClass::no_tcg_its field was only used by the
virt-6.1 machine, which got removed.  Remove it as now unused,
along with the VirtMachineState::tcg_its field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h |  2 --
 hw/arm/virt.c         | 12 ++++--------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c5ccd6ec9ea..21d91a43d8b 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -121,7 +121,6 @@ typedef enum VirtGICType {
 
 struct VirtMachineClass {
     MachineClass parent;
-    bool no_tcg_its;
     bool no_highmem_compact;
     /* Machines < 6.2 have no support for describing cpu topology to guest */
     bool no_cpu_topology;
@@ -144,7 +143,6 @@ struct VirtMachineState {
     bool highmem_mmio;
     bool highmem_redists;
     bool its;
-    bool tcg_its;
     bool virt;
     bool ras;
     bool mte;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f23283e6ddd..3e7858d6e11 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -735,7 +735,7 @@ static void create_its(VirtMachineState *vms)
     DeviceState *dev;
 
     assert(vms->its);
-    if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
+    if (!kvm_irqchip_in_kernel()) {
         /*
          * Do nothing if ITS is neither supported by the host nor emulated by
          * the machine.
@@ -857,11 +857,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                             redist_region_count);
 
         if (!kvm_irqchip_in_kernel()) {
-            if (vms->tcg_its) {
-                object_property_set_link(OBJECT(vms->gic), "sysmem",
-                                         OBJECT(mem), &error_fatal);
-                qdev_prop_set_bit(vms->gic, "has-lpi", true);
-            }
+            object_property_set_link(OBJECT(vms->gic), "sysmem",
+                                     OBJECT(mem), &error_fatal);
+            qdev_prop_set_bit(vms->gic, "has-lpi", true);
         } else if (vms->virt) {
             qdev_prop_set_uint32(vms->gic, "maintenance-interrupt-id",
                                  ARCH_GIC_MAINT_IRQ);
@@ -3471,8 +3469,6 @@ static void virt_instance_init(Object *obj)
 
     /* Default allows ITS instantiation */
     vms->its = true;
-    /* Allow ITS emulation if the machine version supports it */
-    vms->tcg_its = !vmc->no_tcg_its;
 
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
-- 
2.51.0


