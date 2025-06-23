Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247E8C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 14:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uThhc-0008WO-1Q; Mon, 23 Jun 2025 09:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uThhC-0008HD-4g
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:58:51 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uThh8-0007Ia-1x
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:58:49 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7406c6dd2b1so3233670b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750687124; x=1751291924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ad2Ktqpr9QplRBLnhaKfV79oFe1du+hxPOeNvvhDj1A=;
 b=JS5c5B86BIYZmNM6yvij/Ze8pzHgJdf22ZvxggSKMNfzlATmnadziJUcPuujNtFaVW
 0QHqVeS4JWnsJYdOkXmBXsAvFR47fmVju7/Iw7A6c+vbG0kecYjUfzQwCLpFITfP19i9
 19yfKqQjK+5RAKrSgkC12K5YsPIYVmtsk1fozSni9Rvw5qvFnZuuNUBcywzsAyLr3acl
 IBj+cPBNmKmhRU3zZqsVNNLWBALEg5l05kfC6PI6W8oRvTQlw08RU9d1KxVkVOYClDBR
 qSJ6ywLZmBl0RC3ds8Zs9P6gn52WPlhhQg9XxgqQvaqVVV6h2gbWzN95dmscb7ZMMSCn
 34Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750687124; x=1751291924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ad2Ktqpr9QplRBLnhaKfV79oFe1du+hxPOeNvvhDj1A=;
 b=rLqqx7QCis5EGlc6FDUavtMtJZ70F1OOfEo6fAUkbQ5STRjO6W9CjKhR0RWoMV8BKB
 7ukVaC7vRS9aL6UGl+eucWjVtC+ILjVw8ONWK4h9JnHVPG9t8stNv6pS6Is8y83gfMOh
 Y/MpU2OfV1qpL72DrsqwfXhDmsog9HSrN9/2CL3NHbzb+lg0JmeKTQMRIqX3WhxpVJAg
 AGfNPLo8YQ+pSIB2Dy0TjJ1r12CToEpLYuPuoDmUzUC6ErHTQlhsU/uASDhEPpPe6SH5
 zq6/IlbhHLogampAcATa20jOnQVs26b0QrOrE7PpwToyQp4Cuaxz1j2CC2YX3pj9ODqV
 PgQg==
X-Gm-Message-State: AOJu0Yylei2iBZ5z+NnhyxeCKhOjiPvjwgQb6Kr5bKoU/nlDdrEmkHBW
 HVbxLGrgJmerhumibFJ6dlj1vw2npby3uXOVKfjHeTjfDq4U0UzjYPZ1rmfAy9m9KSUvO6JLZ4z
 EyMJd
X-Gm-Gg: ASbGncupi4FYDlhrOkiBuwJ2pUEVyZTt9/+DzdESo1tr2PO9bAHOoxRiMYLzW+zBCs+
 AW6+fyrkIedu3Qdn4oYuqsu+hR7dCwAj+yaL9gUIYy7EuKJnrs3s23xckrcu5ofdCORjyfo1tXM
 4IMeUnZ+T8PfsnhJvu8RdoX/q2a+l8552T3HGU5YL7iKJ4Kg4JLKuOy5SMQVLJP2RNTYwqwu/Dz
 OgStJz5/GRJU4pm9P5QStO5vZzwymbAROt9GEpAsYtyqP5Kok2evBWemipkeJz/4b/AGs39AZ1D
 ja9nkX3ScUxr7aGTPgFphSYHTf3pifXFaYyy2CLj1blf1h1+0VEkDlO3dbxad11t2SA=
X-Google-Smtp-Source: AGHT+IE+A2RXkl1fsGxBWrMkhEYdvlQZUcrsUy1N77xAoHF9Tti6WGIFDvE++UYLoNNJyoOBrxVgQg==
X-Received: by 2002:a05:6a20:a106:b0:21c:fa68:9da6 with SMTP id
 adf61e73a8af0-220291cdb15mr18609786637.8.1750687124354; 
 Mon, 23 Jun 2025 06:58:44 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f119eb64sm8063490a12.31.2025.06.23.06.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 06:58:43 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH v5 6/9] qtest/bios-tables-test: Add test for when ITS is off
 on aarch64
Date: Mon, 23 Jun 2025 13:57:46 +0000
Message-Id: <20250623135749.691137-7-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623135749.691137-1-gustavo.romero@linaro.org>
References: <20250623135749.691137-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x430.google.com
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


