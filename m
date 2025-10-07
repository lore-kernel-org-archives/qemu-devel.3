Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D054CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qs-0005zs-Sl; Tue, 07 Oct 2025 10:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QO-0005oC-UC
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Q7-0002Dr-Ci
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:20 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso39182075e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846318; x=1760451118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BnQEngb+xMAbIiQWnWTFC1lI0X2a1vA1Y0cyG5j8dEU=;
 b=mHT1kPp2Ou4qU/dwqh/nS4OBNa+jYAZ22dY2dtepocPtUFJQkZ/3hnL4hdP6p+l6Hs
 Lqltd+r1gEPzH+hmdY6uA75HvtvIbEhtw2Pho1QZvwEBnRsLkJUbv9ZcZ6b1xDVJlSTu
 MB/tqJqbKpou1+SEkHrfHeRh9sXxR3NekvfiAudHBeZnGhd0jfCpxZS0i7oA6BoKNGjN
 ZX+/NRkKCLzJXV/IDGYx4/ZEgljhvQiHxavkqlZbXhQtd0lQ65dCEU4gJPG+HhI7Vzy7
 28Yd2/jn/IfQvbV/fMgp356pmEHtRoLQ7ZjQA5RqyJHRzjq8Iz1mpTfmdM+H7tcf1DTU
 oBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846318; x=1760451118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BnQEngb+xMAbIiQWnWTFC1lI0X2a1vA1Y0cyG5j8dEU=;
 b=kbW8vpDrpGozAEiccSGX6J36tGeMlOwkQe/ugPoA/LvQJTezdztucFAVmK0vFNLjR8
 K2CCvheFk5wNCU2JU8sq3qvz9CTn6zfFP9Ci1GDWvZH+wZJSoXaZ9Y4wPaND3yl84nqH
 DTkPXPyZ90Pg96UUO/9BgEks9jiacYqaH/5VF2MgAygl47LoWy7gADXffP2+5mbWsd94
 F+sanU3auT6jOC55zmWfhnFNCVq9/Ty4l+oK0nqzgPC1Q8zMSt1CAKikR16ac8AlHv+w
 psdA+WapplYFAjrvpx6F4wNEi4jhAqY6gmbnRTO+g7ejKPZl+RM6sTwtdoIEQk35VkMq
 aNyw==
X-Gm-Message-State: AOJu0YyBAvTZTR8Sq1MU3uI6mGEs2kk5hwn2NtoAOCK9Nk0gM1pyGRp9
 iKcFX6QbRsFk8QrjVoypsLCvPLeZdZpCjIPw7C+6Irhqlwo6wIyr/kt+uoak06GN7TTSzXZ0KMT
 vk0oM
X-Gm-Gg: ASbGncs4UcRoW4qGencPzxWbLUXNEGuqv0e/DQmwxp9TEgvXmV87a/r/lkHaBItO/D6
 J/eRg3HXWc4i65xrHXFTzSkoIyYJq35bywfGGwhMAY82Hj3cRoLi1qd95Dwd6ogSb6DNrGHxiDQ
 1slriS9YjwGBqfySxxO24Qp09kaeNuMx20drYZUYO0okGMFXx52BV5l28OiJTJcE1dRrutQAxki
 NJZx83l2IKt7H6gpelVksG3YDKPn4kC15P2/KZXceqNzAisEfN4ZXX5fNbvRMK9og31clel29Fy
 Lnc+oa35ylIepZfnlPQrbpZ0q/kJbWLnsBiag/ihC9dNO5I28PNF29e8CpQMvgHiGohPsJj1sCE
 CeCHSO4RN+9PRY9U1nP4KeXl3D9Un409Il5hPGFSMfNrSXuheT23fgeMM
X-Google-Smtp-Source: AGHT+IGpnhwxktCIRDyXwHARcfsZQ4ZUHkymeJpoTNcuDW4JymWumkpkU7++iVEMUSolW1oebpRscw==
X-Received: by 2002:a05:600c:540c:b0:458:c094:8ba5 with SMTP id
 5b1f17b1804b1-46e71124468mr111965285e9.12.1759846317693; 
 Tue, 07 Oct 2025 07:11:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/62] hw/arm/xlnx-versal: add the versal_get_num_cpu accessor
Date: Tue,  7 Oct 2025 15:10:50 +0100
Message-ID: <20251007141123.3239867-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Luc Michel <luc.michel@amd.com>

Add the versal_get_num_cpu accessor to the Versal SoC to retrieve the
number of CPUs in the SoC. Use it in the xlnx-versal-virt machine.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-30-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h | 1 +
 hw/arm/xlnx-versal-virt.c    | 7 ++++---
 hw/arm/xlnx-versal.c         | 8 ++++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 39bc414c85c..7bdf6dab629 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -80,6 +80,7 @@ void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
 qemu_irq versal_get_reserved_irq(Versal *s, int idx, int *dtb_idx);
 hwaddr versal_get_reserved_mmio_addr(Versal *s);
 
+int versal_get_num_cpu(VersalVersion version);
 int versal_get_num_can(VersalVersion version);
 int versal_get_num_sdhci(VersalVersion version);
 
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index ad7b3135a67..274a7ef9889 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -346,12 +346,13 @@ static void versal_virt_machine_finalize(Object *obj)
 static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    int num_cpu = versal_get_num_cpu(VERSAL_VER_VERSAL);
 
     mc->desc = "Xilinx Versal Virtual development board";
     mc->init = versal_virt_init;
-    mc->min_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
-    mc->max_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
-    mc->default_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
+    mc->min_cpus = num_cpu;
+    mc->max_cpus = num_cpu;
+    mc->default_cpus = num_cpu;
     mc->no_cdrom = true;
     mc->auto_create_sdcard = true;
     mc->default_ram_id = "ddr";
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index f1b704175ff..2e28b807d71 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -1815,6 +1815,14 @@ hwaddr versal_get_reserved_mmio_addr(Versal *s)
     return map->reserved.mmio_start;
 }
 
+int versal_get_num_cpu(VersalVersion version)
+{
+    const VersalMap *map = VERSION_TO_MAP[version];
+
+    return map->apu.num_cluster * map->apu.num_core
+        + map->rpu.num_cluster * map->rpu.num_core;
+}
+
 int versal_get_num_can(VersalVersion version)
 {
     const VersalMap *map = VERSION_TO_MAP[version];
-- 
2.43.0


