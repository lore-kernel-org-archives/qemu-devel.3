Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D3EC7EE39
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 19:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVbgu-0003La-5f; Sat, 28 Jun 2025 15:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbge-0003JF-Fw
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:58:09 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbgb-0000Mj-St
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:58:08 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7d3cc0017fdso95385385a.3
 for <qemu-devel@nongnu.org>; Sat, 28 Jun 2025 12:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751140685; x=1751745485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lB7c3Kr8+0cTXK0lkJO2kLrKNcdVcOOBVGzv/SMQzE4=;
 b=OI0jXfhZSqCvpNd60AQ6c3GJVtcYj39qNckzK/LHeGBNoUNH0zMgbjVwvV91b/C09T
 6f/YH5crkH+qCWXUBu0V7l2M799UsBdibQjImLmS/7/yTbFGOJ06b+bCurBZ7+oUOHQS
 3M3jiu2vif3UKkt21mu12mUa90EKgcb3tq09pLJ/q9SlftAc+KO1FoYQZyv5Erst6lxs
 vR4dM0U50Fb4CBXv+UmgNgnzzzAK5MstBG9h8W60N47JUOV9dlf32rnwr1oN7ozw+dN3
 w3gpR8Ok2aukVMtBrIiUECaqMBTdOOLsaZPjdUFCozN7JbUAypRJzA58iOS3f3vC8QbS
 VZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751140685; x=1751745485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lB7c3Kr8+0cTXK0lkJO2kLrKNcdVcOOBVGzv/SMQzE4=;
 b=LE8i1o7RJ5Cr3UphFEX+8yjqIemthGB6BlN3jzPnzUwLYLK7sFtBcH4Yw7UxiVfxu4
 LTXxvZH6uc2idjYMZDrCnCuk2X9CncBHb+JwfxTf3pEAazIR0kbQkJZs+6s312C6mkwb
 DaSOrbu0XSj6n1YTZH6k2ZCQhaejJlmsw5xhWZ18mbOegnuvA4K7WALkDS4Ffzr/RqR4
 lPW3a0nEc0Q1cd+O72qAx/YiWqOBkDeKC7dxFQ5qEx8ukaKj4G1jwrm+ezBgrZkw6eCb
 KJGerugoDhpD+9QBoi/l7J1WJCXr2mvoFXSGk5S8cumifvwG4C9rXTADf55Ge1g1sykx
 V6oQ==
X-Gm-Message-State: AOJu0Yy8fNPbQ9lyJhQpYy0zhL5oOUwr+hiqrJGOxmTQlO7PP122E8Ag
 GUMVhqcbbwkZC4bFhqVNYg3f1OZm7YP1SMJse1yJZF3TS2JUbH8M8T0raAKhQ4N5wYqELadpoZY
 vfsxR
X-Gm-Gg: ASbGnctkbNCtAb6PSKg/MrufAjARqx13CZ8eebsuvbRtbsdQi9DwAji/GaAo3HDP3BF
 YYJSwr/u9yIwsl54hPr353GV9KhHrvXRxSQ8Xkas1laR/jjvAZbD+0dJJJZkWaECJLbHKOkkCpS
 byAScP6RhNlAdT/NSjm4VPqX/UG8BQNEK7D865c70t72b8HhjKRAbq3XbGRI2r0bCNV/atzCu2n
 xq1vZqevhMpvwsMrVYY4BJSKg9+rTTYPNxuW/Sbjmld59RJJab1E99L7EHBvtU+eCR4E0aSJTo5
 txOVJ8zoMCGljmOP8uX8qda5Xw6hLofVNQ3oMhGlPKRm/1RWi1EB8Ihf4t4OXAY9Gu+hJuZuVOg
 9lw==
X-Google-Smtp-Source: AGHT+IHnu3i6MW3fE35Bkn4EIlOIi/1uoVXmPZ+BBcRxKbR1IdEgKhrKFsVr1ba8qeD9LxLpJtKZgw==
X-Received: by 2002:a05:620a:410e:b0:7d4:492a:31fe with SMTP id
 af79cd13be357-7d4492a3caamr850917385a.52.1751140684680; 
 Sat, 28 Jun 2025 12:58:04 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443136907sm334395585a.14.2025.06.28.12.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 12:58:04 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH v6 6/9] qtest/bios-tables-test: Add test for when ITS is off
 on aarch64
Date: Sat, 28 Jun 2025 19:57:19 +0000
Message-Id: <20250628195722.977078-7-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250628195722.977078-1-gustavo.romero@linaro.org>
References: <20250628195722.977078-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qk1-x72f.google.com
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

Arm64 GIC ITS (Interrupt Translation Service) is an optional piece of
hardware introduced in GICv3 and, being optional, it can be disabled
in QEMU aarch64 VMs that support it using machine option "its=off",
like, for instance: "-M virt,its=off".

In ACPI, the ITS is advertised, if present, in the MADT (aka APIC)
table, while the ID mappings from the Root Complex (RC) and from the
SMMU nodes to the ITS Group nodes are described in the IORT table.

This new test verifies that when the "its=off" option is passed to the
machine the ITS-related data is correctly pruned from the ACPI tables.

The new blobs for this test will be added in a following commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  2 ++
 tests/qtest/bios-tables-test.c              | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..a88198d5c2 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/APIC.its_off",
+"tests/data/acpi/aarch64/virt/IORT.its_off",
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0b2bdf9d0d..4dbc07ec5e 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2146,6 +2146,25 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
     free_test_data(&data);
 }
 
+static void test_acpi_aarch64_virt_tcg_its_off(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .variant = ".its_off",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+    };
+
+    test_acpi_one("-cpu cortex-a57 "
+                  "-M gic-version=3,iommu=smmuv3,its=off", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_viot(void)
 {
     test_data data = {
@@ -2577,6 +2596,8 @@ int main(int argc, char *argv[])
                            test_acpi_aarch64_virt_tcg_acpi_hmat);
             qtest_add_func("acpi/virt/topology",
                            test_acpi_aarch64_virt_tcg_topology);
+            qtest_add_func("acpi/virt/its_off",
+                           test_acpi_aarch64_virt_tcg_its_off);
             qtest_add_func("acpi/virt/numamem",
                            test_acpi_aarch64_virt_tcg_numamem);
             qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
-- 
2.34.1


