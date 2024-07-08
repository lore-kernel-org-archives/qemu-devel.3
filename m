Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9C3C3DA46
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 11:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQmr4-0003Fa-Mk; Mon, 08 Jul 2024 07:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sQmr3-00039B-5j
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:48:25 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sQmr1-00012B-Jz
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:48:24 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70af5fbf0d5so2311947b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 04:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720439300; x=1721044100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4tYSD3kmwvsTXZv9JDOMjH919bSCwsQC+O4tYKQ71A=;
 b=Vg786pNWngVFGMDBQ/xRkpOrYMZOeAqkk1QhV415QkEolIJlF4WYR1cgobWsMEaTGJ
 XKackv6H2z2CwPLfcn08MTbHnNMm/gcga1SGLkWF/XvgrIdbkMiB8rt/fpgss1CRcogQ
 5TiMeqLQtu7LmrLOfk1Y/vejuOH+GJc9+x5adk9E6HKN2CxSAH2de92G5UJxe01sONYs
 VF2OCTnrJg5SO6YtvTVrTIl5yuLR0rLC7skUlECRpeUJvcfsV1M4gx6lwdPEzgFgehpL
 YDjOOKS+vrXGAgtFXOrEZKwhZdbr7ukxDbD3sUzXzYfMTCI6SS/y8zpvK7pnCPqwGnVJ
 hMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720439300; x=1721044100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/4tYSD3kmwvsTXZv9JDOMjH919bSCwsQC+O4tYKQ71A=;
 b=qFePtf/J5oeOqa2OAFylHKEl1jIizAllF+s6i+aKdAzv7Ony8y0s+Z0vwnmQOrKUtm
 Bpx6F9pfMlspP/cJ//49rja3dCcz44g3slP0wF0tMHU9ReKuQysErl+LyQRLhVbnGDk8
 vpb5imYvXqJsECiqoOJwi3JnWgjbGjQ+AJHC9X07CC8UMNCGAHaeJMlr5l1wBP69FSjv
 m+XCzsCP0ANWMpV0m4EIEg0K76PQEAk79keyDcBcb/r/HeTZW5HHaBETLBxC6ikj/+rQ
 s2wyh6NqTyFmPE9RJ4iKOAMVFA8dqpKm5RyDLo1iSdHeOJ53yUr+r5B2KSmFjmlze4sT
 gGRQ==
X-Gm-Message-State: AOJu0Yzn9fGZpPzGV6H2II30B8xy8uyiP9QkGpTG0xu/RS3ewFLrElfy
 zylQTCwvHTkfnQqtupQKktBMjXke55XdomrnqXTl9cZiQ7jXVnNiY3voL+S/enZC3/iMHTeMPjk
 N
X-Google-Smtp-Source: AGHT+IE9rYOSRhcQc5gSdZdcKWqO1Ojiayn5hxBBIXlBfNmQ2DHE4H3txR8hEwR/rOVNjm6NvlrT4A==
X-Received: by 2002:a05:6a00:4b01:b0:706:1f67:64d3 with SMTP id
 d2e1a72fcca58-70b01b66715mr18830017b3a.14.1720439300155; 
 Mon, 08 Jul 2024 04:48:20 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b2a432ac6sm2769642b3a.94.2024.07.08.04.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 04:48:19 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 8/9] tests/qtest/bios-tables-test.c: Enable basic testing
 for RISC-V
Date: Mon,  8 Jul 2024 17:17:40 +0530
Message-ID: <20240708114741.3499585-9-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x433.google.com
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

Add basic ACPI table test case for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 498e0e35d9..36e5c0adde 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1963,6 +1963,28 @@ static void test_acpi_microvm_acpi_erst(void)
 }
 #endif /* CONFIG_POSIX */
 
+static void test_acpi_riscv64_virt_tcg(void)
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
+    /*
+     * RHCT will have ISA string encoded. To reduce the effort
+     * of updating expected AML file for any new default ISA extension,
+     * use the profile rva22s64.
+     */
+    test_acpi_one("-cpu rva22s64 ", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_aarch64_virt_tcg(void)
 {
     test_data data = {
@@ -2441,6 +2463,10 @@ int main(int argc, char *argv[])
                 qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_viot);
             }
         }
+    } else if (strcmp(arch, "riscv64") == 0) {
+        if (has_tcg && qtest_has_device("virtio-blk-pci")) {
+            qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
+        }
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
2.43.0


