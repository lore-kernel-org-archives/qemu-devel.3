Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83473CF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsGc-0005Wu-P8; Wed, 02 Oct 2024 01:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGX-0005WK-5M
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGU-0004q1-VW
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:12 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20b4a0940e3so46141085ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848268; x=1728453068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=617/1eGxW8JSsbGjaBrf05d+I+s82Dtx88n7iyNI4kA=;
 b=kGBZDR8OEKZ/GKv8hcKiiiQl86FeodZk1hlq82Zebc+atfFOk7ux+no+2GoBk8YbY+
 FCqaNn8LAvsb1ahO54l/mkfw3OEaAlW3gT+2JPQnbAA4bAoQjKgYrLcCuAYm1oluUoj5
 quRwZEURa5p/p0C+/Prx+5DpGojhKWtF6UpWwRt6qqf93V63iKm1rtLAHlayQtHgZGtp
 fgf02MK6K4NTO9+wc/XIjJHRSo3oSpUBMfu7xHX9iH2hv4be7ve1q7O3kTWxmv//rROO
 lvePXjRFuhEn5fqsM4ONwxr+aSfh6+rsaMmEqvtrsSE5qYnVlXAB2qWE+XRe/iM320fq
 LaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848268; x=1728453068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=617/1eGxW8JSsbGjaBrf05d+I+s82Dtx88n7iyNI4kA=;
 b=RITNt7fYGhCQ5/3/SpomskCexkbFjvrMrEVNJZJsY2P1u26KnFv7VkMIu685NTmOMR
 yYoOpAarojNOle/NYTsWT38FzVQJC/Qp7Z0knk8ZmRHdgHYkCuQWLb/lKio5hgIJp/gc
 ezViEC9p3yTJQH3u4JxSKi+Zm4SR70CgntC2xYUIBaV2cSGgyUebPjv0gCSqYziJiRut
 lt+JphrQCoHqTicfzTiA5WlSN8bcgJGSU0xGEqpQeY04LJb383Z1aSxUWuTmjbJtVhGA
 3D8e0k0y5VtcKaRanNvU8TyE3g1riEjzdoWYBbToucoi9HyCpbnU2r2uQaJaqai12yKv
 tjAA==
X-Gm-Message-State: AOJu0Yxv2xcLpGNdGEZxZNFqQavNnN2a4jfTprVczVumI9PINjQwTpSg
 JzazDMw/h5ThlMDwF0HbdQ6IxzcT/Z6jB7rLzOvXR7oZwMoFczWk8eE3UVYA
X-Google-Smtp-Source: AGHT+IEtX9t52Tz0N5zCd0OiySl8kBpDd6FmkLvYzMfMJOY4kD2fIgdlKis10r8B8B+pnuOm5ldpSA==
X-Received: by 2002:a17:902:e88e:b0:206:aac4:b844 with SMTP id
 d9443c01a7336-20bc59f1cadmr30928885ad.6.1727848268365; 
 Tue, 01 Oct 2024 22:51:08 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:07 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 03/35] tests/qtest/bios-tables-test.c: Enable numamem
 testing for RISC-V
Date: Wed,  2 Oct 2024 15:50:16 +1000
Message-ID: <20241002055048.556083-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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
2.46.2


