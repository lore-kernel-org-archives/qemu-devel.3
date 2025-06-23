Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BB2C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 13:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uThgt-0008D7-JA; Mon, 23 Jun 2025 09:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uThgs-0008CE-Cg
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:58:30 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uThgq-0007G2-A3
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:58:30 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-748f54dfa5fso2896069b3a.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 06:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750687106; x=1751291906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTp8cYLG6UEglvnDlfAVLBZ5UreW7WM/U27Ywrb2bxw=;
 b=T4rJAkXWaERde7dS1Nge27V2+ssLediK5CJ+cljANpmCC12vRoQCnYe29OEIRuzZRR
 8lo5Sd92bmGugiWEGnypCsBW/w0iu6kd766srsKstGGLX1pjNLcrVa1s5tygqoQdCARZ
 u9M1J3DYorM4ktA1PPQqyPjSeafCh2OQViOJ3fQcwYrFZMxPXeJLJhTA2tWZv72EVDWd
 fsIxUuM2l/k/3+swIarOEXqqEqWvqj0Ov+gxM120i0NX9Cw2br18Ln9LhyLXVkAZUC/y
 lMRbw60rpvFlQ9NkL9LNuEMX+ePAHljQwFs07dFB0SYtC7/HSv5LkomV+E8G8ji/ts28
 6TZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750687106; x=1751291906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uTp8cYLG6UEglvnDlfAVLBZ5UreW7WM/U27Ywrb2bxw=;
 b=AbitbULWfaLrH012lkThIZFxHATpFWoUf1WAM4aifAqaJudqjADsmE6jSBl3VTkdbg
 04OQI/H9abLbXQ8VM1ueUmHkDRxr+kgAKjjq1jzyHCYE6jmT7Rdqd058GILFvt6b6xOe
 EekNkaLCUTrcyUyl47kfRsmTSEiGKvlsifom7tTD0jGgW3Orl0VKfYuWtXj+GSs3+MZu
 xfTQpMzPnwkuBBw2Pha2M0x9SaWUG9zPrP3sGwat4amDIMmZ7M9UGPoyr0kEx8fnJ6H+
 sr7i0UEcTPPV3xhp+GUKnUtFSQfZ5PpIIxZ+R9/Qz9dKPzoflSgxwP/rfhSk0boGYBQj
 E/7w==
X-Gm-Message-State: AOJu0YwhsOpI3aNcJJaDqFPDTfLfuqXKvaI+TuSk7OBYD12ie0hDfVR3
 2Oysvv/4iiDMgEompNfYpZ+ZPm4GiQ/NFiyZtJCSUraeCR6owG6kalwedleXoE2ANU4r3tg4/R3
 hOVuq
X-Gm-Gg: ASbGncuS298SIa5lasUYRDK/pR1ddFyuI9NiVtWDvcLzDU6fnlzHRjLEadbrLVosIXr
 Ny3XoJsl8ukIVWFWAPzUwKqq8GV2v6LEVfBV9ELA8zhr5SwBDkFMYGWmxuk5SOVmztV2bW4rcfI
 8x0ZkNJ3wEupdL3aSPEMdUmErS6wIbgWA0MK12lwkubAUVPu2O4b7KvGUvBSoMq9hfwf818+FUu
 85iHE6TE1MLMNHx4jAYPDJ/apJLOt3+W1sv+4r2giwmzyW19qh1mzorp3bQhmnb4KO8Rfu00jHK
 3zezqJPare4AzkzAQ7t/qb6RRhyYvlLJzEeyURSJy8dNcNXAwUJgtCAzVYrkLxoz59Q=
X-Google-Smtp-Source: AGHT+IEEiQa2+IhXySW3Jk+w8bOwu5gQ9GdPyLkWhYn94fbqI08woD1B5i1A76i9mPtaPcsSqUILXg==
X-Received: by 2002:a05:6a20:7d9f:b0:220:1215:fea7 with SMTP id
 adf61e73a8af0-22026c19994mr19958025637.9.1750687106268; 
 Mon, 23 Jun 2025 06:58:26 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f119eb64sm8063490a12.31.2025.06.23.06.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 06:58:25 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 1/9] hw/intc/gicv3_its: Do not check its_class_name()
Date: Mon, 23 Jun 2025 13:57:41 +0000
Message-Id: <20250623135749.691137-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623135749.691137-1-gustavo.romero@linaro.org>
References: <20250623135749.691137-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x431.google.com
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
---
 hw/arm/virt-acpi-build.c               | 32 +++++++++++---------------
 include/hw/intc/arm_gicv3_its_common.h |  2 +-
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 7e8e0f0298..9eee284c80 100644
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
diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
index 7dc712b38d..3c7b543b01 100644
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
 
-- 
2.34.1


