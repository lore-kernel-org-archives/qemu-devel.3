Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646AFCF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDrM-0003P7-Cz; Tue, 24 Sep 2024 18:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrK-0003HG-6t
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:14 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrI-0001bv-D4
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:13 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71b0722f221so577317b3a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216290; x=1727821090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhZO+94GaT1byduM0n2KThYqhoa0Ze0i19VYeIMvM8E=;
 b=kBsbnGrqHg5gbQchsJmrqYldITOI5b6YOW4UWWAUX4uQvU8ebfyFX3/NQZ3SyCBScz
 YCmkUiaMpOEXC7QhBr9u11ba0XytiSEMfK4LujkEKy6ossKsLidccPATBekB6tZPi2GD
 ijbTy33N38/sA7E0hX4urITEVjLDuHWdn/sDvTQ72AoZ52a1jbX202awO+p9W270KK/M
 RsRhBEXmyBgdKiFYmr8iKgQHn1cXuQJSAi7//OpZj0/oFpuHwagw52MOoNwwAIgdOQjo
 TXxFw0D6yrxqxcuOO2JONlBv9Tz5Z4Gl85p5VNyjBj3NUiKFfye9ZuniF3zqIZGyywaT
 pxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216290; x=1727821090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhZO+94GaT1byduM0n2KThYqhoa0Ze0i19VYeIMvM8E=;
 b=vm3bAwnHs+W0VezGmLsbZwOAmdERtikBmbm63s6bA0Lupd/jHx8HAVSU5Cc/XnixxC
 zS5OJNfK1QtZWV62uEOkkQiw/fhF44YwacHbprOjs3ukVrcS2FnViIrkgxckUTulcUg4
 ohF1hXCCJUflqbcJpqxtJIzxOuYBKYNQqk0+f8I4HZ6BoKvEYMQebTSlWk4/65E7Lo8Q
 6Xp3CBGCVnozjEI0VzeUMV9X9HEXzaujqKF64Iul9ltSHOn4NlN5VBbhxmPl/acpJBP1
 gGpofnBJsUwssR2LVUT3KjVpI8ApSAjUm3i4KCHhoOmMjcM8qc/6OG+ceU7++YA+ixfT
 U7rw==
X-Gm-Message-State: AOJu0Ywsa/GLFpYWJA0WJ0vQgj3zCRwsYoKTtZVElmAi1J9prKDGhK3B
 srYLFlG2W2x/g9aS/G2sgTDwOIkiOqD+YDADguM25ij8vBwFYaICLefq8w==
X-Google-Smtp-Source: AGHT+IGDkLcenMMlzHXL1wqEEhw3icqQ/N4bTtC/99WA5uuAciI8V1ehkswBnbTk1k/Ymph1XfzA+A==
X-Received: by 2002:a05:6a00:99f:b0:714:21f0:c799 with SMTP id
 d2e1a72fcca58-71b0aab1563mr1174877b3a.12.1727216290474; 
 Tue, 24 Sep 2024 15:18:10 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:18:09 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 03/47] tests/qtest/bios-tables-test.c: Enable numamem
 testing for RISC-V
Date: Wed, 25 Sep 2024 08:17:04 +1000
Message-ID: <20240924221751.2688389-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
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

From: Haibo Xu <haibo1.xu@intel.com>

Add ACPI SRAT table test case for RISC-V when NUMA was enabled.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <a6f7e1a4b20ff7eb199e94ca0c8aa2e6794ce5b2.1723172696.git.haibo1.xu@intel.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/bios-tables-test.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 36e5c0adde..e79f3a03df 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1706,6 +1706,32 @@ static void test_acpi_microvm_ioapic2_tcg(void)
     free_test_data(&data);
 }
 
+static void test_acpi_riscv64_virt_tcg_numamem(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "riscv64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2",
+        .ram_start = 0x80000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+    };
+
+    data.variant = ".numamem";
+    /*
+     * RHCT will have ISA string encoded. To reduce the effort
+     * of updating expected AML file for any new default ISA extension,
+     * use the profile rva22s64.
+     */
+    test_acpi_one(" -cpu rva22s64"
+                  " -object memory-backend-ram,id=ram0,size=128M"
+                  " -numa node,memdev=ram0",
+                  &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_aarch64_virt_tcg_numamem(void)
 {
     test_data data = {
@@ -2466,6 +2492,8 @@ int main(int argc, char *argv[])
     } else if (strcmp(arch, "riscv64") == 0) {
         if (has_tcg && qtest_has_device("virtio-blk-pci")) {
             qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
+            qtest_add_func("acpi/virt/numamem",
+                           test_acpi_riscv64_virt_tcg_numamem);
         }
     }
     ret = g_test_run();
-- 
2.46.1


