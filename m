Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA639C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSV-0005b7-TF; Tue, 01 Jul 2025 13:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSS-0005Z2-Te
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSP-0003WD-HA
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so35127985e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389663; x=1751994463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VBvxJ1cilsn9V1RB9o7d6hcyA6rSrn3aogssV0H3S/w=;
 b=cmoi+F1Y7p08f9ic11Z74om+I+vTK521iIgBHzmnPVyOz9TAd6OgJRRQgNF89uzSkQ
 JKkGRHM8aSgJkvNnD3sMiCgQMy+/NA+Zvl5foxy2AawR/a6gDzoqmsIdtb4TzdNzrhcN
 8CeTQsaZ/Daull0K556YShg7GU2kLo5XJyopsMF52iQxzs19jhLZUDPMyA9jdqh8MxS+
 3V8u7Jt1pcbBs8VJ6divfhKeJbnMv1bXGHVqmFVRQgv7IE2eARXm+BaNfAcZDKdt9txN
 2oTHH5aB2NSXCZxgDkAMNd6g/z/xBemEwUT882kLiIW2WrqzK/tVecnQfkkWKd6FQXgn
 WNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389663; x=1751994463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VBvxJ1cilsn9V1RB9o7d6hcyA6rSrn3aogssV0H3S/w=;
 b=XMINd11AB+khGP15Ey8BabDSjVctFfMyx0e3A8CRF22tJI/REmSpzRporxY8Ws7YnN
 Cs1Vykt2EhO1PgaWFr/d0qfXS84of9YC8uQr6sLtTnfsjFl3iqcEtOAtofitgwvHD3ve
 PS2YR3UbI6FbqfPSpwCx05RRHhDkpVMw8WvUfVZDReXn5HvNhJ8ug5agaMNOmAy5WQKr
 ObMIERqZRzJg8GhxNGY+ozp55SD2Ro1w14nl5U2rusB07HScPvmX6bGmmvej/QUNY0X0
 5OhFx35AnDYs4Gre1qdnxgHP4VF1QdYlyirakrLkuSSVTZAbqZK7AadHG8OR/0NVBxVl
 Z2SQ==
X-Gm-Message-State: AOJu0Yw6+iyH1h4GJk95xT9UbQgAxHSnr+ZpsrStTNPVaFYOxljhze0d
 wNw8uRLqvVBXfFsUNkmR5ROJfl6cdKHYb6kASIhA/NVHc6fnx8pWFiMeOWhhc7I8ERVMh0Cj/wp
 3XiHS
X-Gm-Gg: ASbGncueHKZjVRYEpUPboHsgODf/rYMhdPu1BzwdNwwYuBk4ZvjQOvhx7SHjMItj0Zj
 MgL+4Id5OmsDAGS9Gq4YEytKw0PSghkKXTsyfxPdCsA5bldi4GmzkDFy2Ms6p9c9vk0ax7i9ho9
 0J5tIMcC1SiMUTxyUwb0whrgAMmOOVv4qNuPTsMMgSVJp2OdkoyfGWImHhAt8MLTOXxN0vxrNrg
 EPKLxyfy/KgpHfHX0I5gFO5vSgbBPyvXFNb+XUbJsEDUAyj+waOSoijh0/X+jAOIqKC+NY0hZfP
 6/uAAAHsthfbY7n1tXrgdeeVeusTyEHzUQnjaV/FKVkpq2KbhPWkWAZPu8rAXkDqi8LU
X-Google-Smtp-Source: AGHT+IHESZ7+ZFMbLry/oN0ZLhhp2B3Vyc+k3H1jCX8eOsjHe48I6G6p10zDdR3wp0p1I/UiP+vkRA==
X-Received: by 2002:a05:600c:138a:b0:451:edc8:7806 with SMTP id
 5b1f17b1804b1-453a629bc0emr51099325e9.32.1751389662607; 
 Tue, 01 Jul 2025 10:07:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/43] qtest/bios-tables-test: Add test for when ITS is off on
 aarch64
Date: Tue,  1 Jul 2025 18:06:56 +0100
Message-ID: <20250701170720.4072660-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
Message-id: 20250628195722.977078-7-gustavo.romero@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  2 ++
 tests/qtest/bios-tables-test.c              | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf..a88198d5c2a 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/APIC.its_off",
+"tests/data/acpi/aarch64/virt/IORT.its_off",
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0b2bdf9d0d4..4dbc07ec5ea 100644
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
2.43.0


