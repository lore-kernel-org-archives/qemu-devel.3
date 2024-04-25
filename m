Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C638C19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWb-0002CL-RC; Thu, 25 Apr 2024 06:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWX-00022s-2v
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:17 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWU-0007Dn-UX
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:16 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-418e4cd2196so6706175e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041612; x=1714646412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PQpS8WwkI3zNhylYTqxyPFLwAk0dCYZh37pbQidxx4Q=;
 b=VD1kTuu7OVmNkNEt8g7AQlQH2zH9mYpQGBqlmWS97OVPmMyBEN08pTGxnG+2zZAAEk
 ZExSbOy/hCf4YSswDhr7H96HaOGBnF2oQGVu9cPAfcvRnGOKknPYUBnq8kCpri0yYuIG
 0Vot1yA4lL2eYCB/f8sQ8TuX4GVU9mwcaaw6aaPODDq70BGz1VbQBoghH5RF05nqs4D7
 w4Qyb40MA8i6akGTdGFZkHnE9l6rdgio0TGVOxlUtL72nFOsq2lMNAYF0Ba2bvjz4clJ
 EkzMyzTRZIwzf4Nnx6zrpGG+Ltiit1RpPYiX0GPwFHNVHcSV0oy0ugid7KG6qBcwoyQs
 X3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041612; x=1714646412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQpS8WwkI3zNhylYTqxyPFLwAk0dCYZh37pbQidxx4Q=;
 b=JX7EW7UcczsAaZsfg7Fv47k3izz4EMAZ7ja6GZ6+092oiaZ5ulwVgySqz5VZcoQQqS
 wANkwil/Nx6YZ2HiI7by1/EPbV6+rhG04XL9iceCBUAW4HDBiQSkQOf4pOijbNs/rGiE
 t7Yvvj9TvLauGKEB3D3nOsiJgYMyGPDIZYXyKqNSeJTT8bNPGrYKBVulRiX8J8TRIben
 a9HQdB7BO3V9XC9xaq+nD3/WAfAN8U5wwZLJXrDHsX6pyxVmXxitaPflENVZZoOr9MNM
 0JD/MBqjCljvIdpKAbeUnDKF3N92XE00tDT2EbF5ozjpV46zBzAwQUrC/lSs2u5Wb9xQ
 FnBw==
X-Gm-Message-State: AOJu0Yx84i42R57AXoc2/nJmt481g2LiJbTSTiTtXXc0kfHeXSi4J7y5
 aMVxPvO+TKRCJpOxHAfkQ+xyv1cZcuK/a2HiHBIjOI2FH8zLqq6lHWAKtaukOBtfQb/OB+e9Rv6
 W
X-Google-Smtp-Source: AGHT+IGgkQMxhnQkQ/6ydHVOfuoavQgQUGmIQaZgiYIIcFTtS3VCp2QlpC1xgNg+f4Xj8E31eYu9gA==
X-Received: by 2002:a05:600c:1c83:b0:41a:e995:b915 with SMTP id
 k3-20020a05600c1c8300b0041ae995b915mr4174322wms.1.1714041612495; 
 Thu, 25 Apr 2024 03:40:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/37] hw/arm/virt: Enable NMI support in the GIC if the CPU
 has FEAT_NMI
Date: Thu, 25 Apr 2024 11:39:45 +0100
Message-Id: <20240425103958.3237225-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

If the CPU implements FEAT_NMI, then turn on the NMI support in the
GICv3 too.  It's permitted to have a configuration with FEAT_NMI in
the CPU (and thus NMI support in the CPU interfaces too) but no NMI
support in the distributor and redistributor, but this isn't a very
useful setup as it's close to having no NMI support at all.

We don't need to gate the enabling of NMI in the GIC behind a
machine version property, because none of our current CPUs
implement FEAT_NMI, and '-cpu max' is not something we maintain
migration compatibility across versions for. So we can always
enable the GIC NMI support when the CPU has it.

Neither hvf nor KVM support NMI in the GIC yet, so we don't enable
it unless we're using TCG.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240407081733.3231820-25-ruanjinjie@huawei.com
[PMM: Update comment and commit message]
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c4b03b09c27..3c93c0c0a61 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -729,6 +729,20 @@ static void create_v2m(VirtMachineState *vms)
     vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
 }
 
+/*
+ * If the CPU has FEAT_NMI, then turn on the NMI support in the GICv3 too.
+ * It's permitted to have a configuration with NMI in the CPU (and thus the
+ * GICv3 CPU interface) but not in the distributor/redistributors, but it's
+ * not very useful.
+ */
+static bool gicv3_nmi_present(VirtMachineState *vms)
+{
+    ARMCPU *cpu = ARM_CPU(qemu_get_cpu(0));
+
+    return tcg_enabled() && cpu_isar_feature(aa64_nmi, cpu) &&
+           (vms->gic_version != VIRT_GIC_VERSION_2);
+}
+
 static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 {
     MachineState *ms = MACHINE(vms);
@@ -802,6 +816,11 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                               vms->virt);
         }
     }
+
+    if (gicv3_nmi_present(vms)) {
+        qdev_prop_set_bit(vms->gic, "has-nmi", true);
+    }
+
     gicbusdev = SYS_BUS_DEVICE(vms->gic);
     sysbus_realize_and_unref(gicbusdev, &error_fatal);
     sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
-- 
2.34.1


