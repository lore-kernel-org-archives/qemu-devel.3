Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD069C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7Kd-0007TD-SR; Fri, 15 Mar 2024 09:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rl7Jp-00063y-H1
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:53 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rl7Jn-0007l6-O9
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:53 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29c75e348afso1587681a91.2
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710508189; x=1711112989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wghJI0ognSpNT0jNsCcfBxxvrERQMs64Ov5T2QzZ9+4=;
 b=K6anAFHr7efDz7d1ks7R6suPIs2Co4oZ+g/FshrMD32iBprGEtgKcOucYMTYAR789t
 JglnblDF6y7ahJpUe+mNCkO1L8QH21TZOExv2QXI7XG5pbGjhG9Fu3hQFBmiqKUPWs10
 GypUDBmEsptnH3chSKmhn/MKQcdrYkem9j4AfciiWjhaicU2M/iN0BNEiTCILBpELsHT
 3sxUH2C8bNYIkseid47XhOtkNDPbBgKEc0FBq04Lk+XDzfoQma1kX0WQ7MM1Ch/pRnqI
 WklioP1bvCCA4t8xpyftAy6IQCNfRYfRYJ+eOUj8PALc1OsfBWD2q8+edrEn8JbMlRA2
 zdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508189; x=1711112989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wghJI0ognSpNT0jNsCcfBxxvrERQMs64Ov5T2QzZ9+4=;
 b=OOzSYJ9pKwcDKFCseqm6BnQNVDPlCmzMGXfgMpxWqkWeHOCq1QkhDS4ViC/cvSMPBG
 tdMU/S2uPwcsxGTND4fnT1YwmoceYEkZ9fyXd8rjZ3SKAADJiFTRB7qQdqwNJV2KpKak
 3ir9lPe99KVvJsBNzL5Rx0UvxhmQc1+ILkKN44pEjfGJtZF5EBuhcyvmBNQSDBTb/QTP
 wD9vXm3+em/UGzBdFi353efOfmwBhGE1dJaWsKU05no7REQ9BWCp7Z37XROP/1enQJe3
 taJ5UOrtKSschIrJ3M2eWugI87RMeQjliVie9Bc8mYGOxnZAcniR0gUcSMTv4c3J+wvq
 JFYw==
X-Gm-Message-State: AOJu0YwCf/pY2PweToI6u3eR31sibyZmYHR9rix0lWYzvBk2abEZ9iCW
 eVZGpvSDpPYMsYdB73ZHg5XYPlgpJBlGytkhCXMbKLHKUXGa0mJt5Yyc9vFMDZjHVHJbziw/e7b
 D
X-Google-Smtp-Source: AGHT+IHtZP3R1LH2o6oB+Jei/hXFGCvm7DsDUt2+XkoQG3HYlR2QpWKbv3lcheKPXoBm3gaoubIX4w==
X-Received: by 2002:a17:90a:9ec:b0:29c:4598:5783 with SMTP id
 99-20020a17090a09ec00b0029c45985783mr4595223pjo.8.1710508188634; 
 Fri, 15 Mar 2024 06:09:48 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.184.12])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a17090ad40300b0029c68206e2bsm2886663pju.0.2024.03.15.06.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 06:09:47 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Haibo1 Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 06/12] tests/qtest/bios-tables-test.c: Add support for arch in
 path
Date: Fri, 15 Mar 2024 18:39:18 +0530
Message-Id: <20240315130924.2378849-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
References: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since virt machine is common for multiple architectures, add "arch" in
the path to search expected AML files. Since the AML files are still
under old path, support both by searching with and without arch in the
path.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 tests/qtest/bios-tables-test.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index ea3ba1992b..c492438ced 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -78,6 +78,7 @@
 typedef struct {
     bool tcg_only;
     const char *machine;
+    const char *arch;
     const char *machine_param;
     const char *variant;
     const char *uefi_fl1;
@@ -262,8 +263,20 @@ static void dump_aml_files(test_data *data, bool rebuild)
         g_assert(exp_sdt->aml);
 
         if (rebuild) {
-            aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
+            aml_file = g_strdup_printf("%s/%s/%s/%.4s%s", data_dir,
+                                       data->machine, data->arch,
                                        sdt->aml, ext);
+
+            /*
+             * To keep test cases not failing when the DATA files are moved to
+             * ARCH under virt folder, add this check which can be removed once
+             * the DATA files are moved.
+             */
+            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
+                aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
+                                           sdt->aml, ext);
+            }
+
             if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
                 sdt->aml_len == exp_sdt->aml_len &&
                 !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
@@ -398,8 +411,13 @@ static GArray *load_expected_aml(test_data *data)
         memset(&exp_sdt, 0, sizeof(exp_sdt));
 
 try_again:
-        aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
-                                   sdt->aml, ext);
+        aml_file = g_strdup_printf("%s/%s/%s/%.4s%s", data_dir, data->machine,
+                                   data->arch, sdt->aml, ext);
+        if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
+            aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
+                                       sdt->aml, ext);
+        }
+            exp_sdt.aml_file = aml_file;
         if (verbosity_level >= 2) {
             fprintf(stderr, "Looking for expected file '%s'\n", aml_file);
         }
@@ -1561,6 +1579,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
 {
     test_data data = {
         .machine = "virt",
+        .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
@@ -1654,6 +1673,7 @@ static void test_acpi_aarch64_virt_tcg_numamem(void)
 {
     test_data data = {
         .machine = "virt",
+        .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
@@ -1676,6 +1696,7 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
 {
     test_data data = {
         .machine = "virt",
+        .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
@@ -1749,6 +1770,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
 {
     test_data data = {
         .machine = "virt",
+        .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
@@ -1905,6 +1927,7 @@ static void test_acpi_aarch64_virt_tcg(void)
 {
     test_data data = {
         .machine = "virt",
+        .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
@@ -1924,6 +1947,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
 {
     test_data data = {
         .machine = "virt",
+        .arch = "aarch64",
         .variant = ".topology",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
@@ -2007,6 +2031,7 @@ static void test_acpi_aarch64_virt_viot(void)
 {
     test_data data = {
         .machine = "virt",
+        .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
@@ -2139,6 +2164,7 @@ static void test_acpi_aarch64_virt_oem_fields(void)
 {
     test_data data = {
         .machine = "virt",
+        .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
-- 
2.40.1


