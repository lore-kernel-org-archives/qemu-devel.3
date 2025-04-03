Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539B7C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RMi-0000P3-8b; Thu, 03 Apr 2025 16:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RMg-0000OD-ND
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:40:42 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RMd-00050l-8W
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:40:42 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39c31e4c3e5so650817f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743712837; x=1744317637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cla1lcEde+/dwIvUCkqYoXlnQEk1tsR3rIU5tsr/g9c=;
 b=AaABUsrIxq/L4VmQZ283u2WGtaBQxVATjngMGzQ9HssQlUcKpRntFvCtyqpdN06Z0L
 /K9Di+IX6JKx0ouxdE/j1aYRa4WDNBBT0JmmrQVKPjG6vIFZYrTPnyh00gc5wkBfeOpY
 mKIrHpgX1mjX/WNJilEpTxfNOtY1iOBL5SdTsj4VcfqSiJZdzVjoIPXzULkyBTdM8WUp
 Va4bHyvvNnmrtTghPufljF9czu4ajQ3WNWhJ1mwwNNpNT7xB29LDVqqlmdzoA/eVbpi4
 ufB6m6yi/Rrv6yelUEEqAOIzBzSEZKpRwDmVpbGrW4O/EJNu/vc4HFpX5a9yE8svkzso
 kyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712837; x=1744317637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cla1lcEde+/dwIvUCkqYoXlnQEk1tsR3rIU5tsr/g9c=;
 b=FiBlIgyJnNgS1K+chLU51XRijfR52RDchRXO/A3kIjZjHt5P8IP+Xouq/s4NjBstKW
 g5anCKGA8OiXxBT88nNDS6Qu+S53DjXbsb1NT49UZdtkZmszc3o2KGNnhODbzL+OadT2
 6P1jCrNwJTQ0t9FhUGoXsBxhIcLn0kJRyQmZ6eOTr9WC0vh5yugKeLYaIzrZYbqY8mMg
 Iq8BA/sC6T1TukJxzxNIQ+q/YEagWhjwgjt7KH1zU5wVr/xJy8FaV10nCWeHYICfGKiE
 JjnLYbTV2opJu/4d2YBLHwMYnn8tV28Ui/xmbcbsC+oby5OHf8savdxjc38oPL0VtghC
 Ljsg==
X-Gm-Message-State: AOJu0Yyerl51nLQrlhJVTSUBiWkVx9v5ZdcWs8qmtSz3UiumVYXwovsU
 ukSDRIBJj+zY7Ilebq2Kg0WSwSKvnR8eicwoAF6ZlGP77sKUmvxldqPWHe3rg/cBcFd3T/LNfvZ
 D
X-Gm-Gg: ASbGnctelJsOOWU72TIL9HKMxbNRafuAOHV6GKivPElyEBX4mo6F4i4o+r6doEQxX8C
 OCQgVwDXBPT19yjKjtbS5Z1sKD/2Vjn0qif2TAj3XxTinOeAqGJg0C1hAaFZHh69zSCTxekWKNW
 075/SWKIg7NFZWukLMTjBBzxCYHYf4pKOIQBHMTm/Awzua7pdQ4kTGY6/cS9HVV1ihjaGO2YmvH
 hjYJU4WY/s0pQmwaW8Rjye4nFfYByxcoEDTiJ9i9Jp1I9SehfCIOnsKeqvra2RLyB0Z/8Aa92BH
 utbCeI4y0TWI5mKeQZ+7s/hIx3ON5h7jgurTjwDx/FdoI67+I/6JOlWCu6Zt6WuLE0C4hEGKkZA
 3/Gqya6jN+Y+3z2ufJaiUUOql
X-Google-Smtp-Source: AGHT+IGq6MUAr4j6d4oFja99cnwBgM5fgWuSZdJ6FfKkZLO9wGdfJSDuz7LTmnOuzEJWijRc1JruUQ==
X-Received: by 2002:a05:6000:2489:b0:391:4873:7943 with SMTP id
 ffacd0b85a97d-39cb35aaaeamr604653f8f.32.1743712836771; 
 Thu, 03 Apr 2025 13:40:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34be2f4sm27264105e9.19.2025.04.03.13.40.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 13:40:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v3 1/9] hw/arm/virt: Remove pointless
 VirtMachineState::tcg_its field
Date: Thu,  3 Apr 2025 22:40:21 +0200
Message-ID: <20250403204029.47958-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403204029.47958-1-philmd@linaro.org>
References: <20250403204029.47958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

VirtMachineState::tcg_its has the negated logic value of
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
index a96452f17a4..177e9e0eadb 100644
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
+        if (vmc->no_tcg_its) {
             itsclass = NULL;
         }
     }
@@ -831,7 +832,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                             redist_region_count);
 
         if (!kvm_irqchip_in_kernel()) {
-            if (vms->tcg_its) {
+            VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+
+            if (!vmc->no_tcg_its) {
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


