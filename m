Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F976C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeST-0005Zg-Ri; Tue, 01 Jul 2025 13:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSQ-0005W4-Eg
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:46 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSK-0003Sj-5q
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:45 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so2172505f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389658; x=1751994458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yGrl9aNeRGVvk2bktaVqb3xXDuq3A1i3mnww3L1qfrQ=;
 b=KaKJLXZt1hJfwbR46PAhB3N3zv4Hze6BdU7bo5QECbd6iPWurg/HqicBsGhhnbSCHi
 GTdips4aBeAJY0PaQ9g1WpHmxh2TPvw48mI+d14kiqP5tSwImR/msRUa093WMt0EXuIM
 KLtZXXRTlnD9pUmsuXOPcmAwS7vVOGN8igNGQcAkKe449CKSpE1ydlAY2wLnpKsBKiul
 RSuD1SHMF9FKoNrcD2ZRBDlMzKvJHWI4ar2E2yEEIMP9en60VFCdKinQi5Sz390VkCkM
 6x8tle77iDMcmqjbFV4TvgQeWgln4+CFm/Dbre5kJeYsS2LKgHHS2+zK+8qpQuTLUrpR
 q0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389658; x=1751994458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yGrl9aNeRGVvk2bktaVqb3xXDuq3A1i3mnww3L1qfrQ=;
 b=lrcyZKBJPFyyO9P8ZHvHOfqdSe53j8W5O8j+IBgK+4ssyCMwCI3OxibUv/ZOyhFpS3
 TergjPAerXKS+JbXUDBY//3ImOuJ/fu5rzT/cDNO1mD3RIDK9MwG86ZwnoNmUnIRQWOz
 5sNiCifwH90z7TOHjOW3iIRw1JlP0sqLGq/ZoxUuAz7LAyuLGImUgW1srfdAxJe47XVE
 KhSWJ3L5fhDnAXOt20IyKZ13E0gwJUbnJvGYMlnUO1ecu4Gn+kUpkeQwKXtDi4udQnh6
 sFVz8pk93KX7yEeFq0SsiSFR2nP/Vad0Jo8J3zVLwCk/Wrimu2J24eYMK3uAoZC3/Kdr
 W4UQ==
X-Gm-Message-State: AOJu0YyqnrRNqMte3EaYJLBg+pawqwvX6r6geiOQdvQuHtG3mRtSp8vd
 asVCJAuxGcxo+0FuH0Kenx5Jxu9bgtm/rxlh3AHFSB3tn4a/yuMfFczrnFwCA8BJwo5KcwbXlpZ
 wbyFB
X-Gm-Gg: ASbGncsjiT8vUcLsEfkmhcdI1IopUrbY2Ukr64FKPuUZ/irg8HTcxLNgxgyPC6p05d+
 cT9O4OylFXlOPABgbi4HerOd+7jwqVMx26NutohPVtyd/POWwc8imwAxPjASvmAtZjE1DFLAqQC
 jj1vY1qxxtceYpRTuxy1mAn2PMYPxKKVofKN0CXJuh7FlG2VCBDeCwjlwM0D7adQiOhkCKy5LLk
 bGChEmUGjY3KerlGH7dp6wSIhCVO0cJ9u/MQ6VD7dCpjBXKEvMTqIemoEBgyduJHzf9tacsAbHn
 sWfYnvwa+iSc2zWoGo9eu0j84qDDxbC6G9Zm+93R4YEdhmsIYUfFmvHpzaQtu8J6uWOp
X-Google-Smtp-Source: AGHT+IGbBFTZCFjbo4ph4l2nyZz9Qwlay26rDeNFJWCsrjae8kgKRU7fB9cJb5bwIxjoBC6xyIld/g==
X-Received: by 2002:a05:6000:250f:b0:3a4:f936:7882 with SMTP id
 ffacd0b85a97d-3a8ffcca8b2mr18209555f8f.55.1751389658079; 
 Tue, 01 Jul 2025 10:07:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/43] hw/intc/gicv3_its: Do not check its_class_name()
Date: Tue,  1 Jul 2025 18:06:51 +0100
Message-ID: <20250701170720.4072660-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commit cc5e719e2c8 ("kvm: require KVM_CAP_SIGNAL_MSI"), the single
implementation of its_class_name() no longer returns NULL (it now always
returns a valid char pointer). Hence, update the prototype docstring and
remove the tautological checks that use the its_class_name() returned
value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20250628195722.977078-2-gustavo.romero@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gicv3_its_common.h |  2 +-
 hw/arm/virt-acpi-build.c               | 32 +++++++++++---------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
index 7dc712b38d2..3c7b543b018 100644
--- a/include/hw/intc/arm_gicv3_its_common.h
+++ b/include/hw/intc/arm_gicv3_its_common.h
@@ -128,7 +128,7 @@ struct GICv3ITSCommonClass {
  * Return the ITS class name to use depending on whether KVM acceleration
  * and KVM CAP_SIGNAL_MSI are supported
  *
- * Returns: class name to use or NULL
+ * Returns: class name to use
  */
 const char *its_class_name(void);
 
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 7e8e0f0298d..9eee284c809 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -737,20 +737,18 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        if (its_class_name()) {
-            /*
-             * ACPI spec, Revision 6.0 Errata A
-             * (original 6.0 definition has invalid Length)
-             * 5.2.12.18 GIC ITS Structure
-             */
-            build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
-            build_append_int_noprefix(table_data, 20, 1);   /* Length */
-            build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
-            build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
-            /* Physical Base Address */
-            build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
-            build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
-        }
+        /*
+         * ACPI spec, Revision 6.0 Errata A
+         * (original 6.0 definition has invalid Length)
+         * 5.2.12.18 GIC ITS Structure
+         */
+        build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
+        build_append_int_noprefix(table_data, 20, 1);   /* Length */
+        build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
+        build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
+        /* Physical Base Address */
+        build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
+        build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
     } else {
         const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
 
@@ -969,10 +967,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
                           vms->oem_table_id);
     }
 
-    if (its_class_name()) {
-        acpi_add_table(table_offsets, tables_blob);
-        build_iort(tables_blob, tables->linker, vms);
-    }
+    acpi_add_table(table_offsets, tables_blob);
+    build_iort(tables_blob, tables->linker, vms);
 
 #ifdef CONFIG_TPM
     if (tpm_get_version(tpm_find()) == TPM_VERSION_2_0) {
-- 
2.43.0


