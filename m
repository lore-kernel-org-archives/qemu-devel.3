Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED936C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 22:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzNNE-0000Vs-NW; Mon, 31 Mar 2025 18:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzNNC-0000Tv-PM
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:12:50 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzNNB-00075N-29
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:12:50 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso46322385e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 15:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743459167; x=1744063967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=obHKoIEOzkL/pFU0m16gFeNK6bbRhAdAffgtXHxHseE=;
 b=BXN7QIqt45YswU09uZsYJI5tS6nK5zSpoKyl8M+l5FOazBRPOysvok7NQRASjY1fWj
 VKj6fok/NfNDij2EaHe/EgPDLhbp85GDYROKnXmfj7GvvRlHlzFn7cJpGcShLMmJXo5A
 o1wgivurTPqWTc/trT79TGFaNvgyXftwmZDGfBO87EQ9hhIj2tg1zRCNKN+dqb3p3AlG
 AN/3Imow0ZPXqIRV2PJ199YBf/M1uVDTrunymlNydOKbMLXqCKbiJ+SNuDjEK0VrP+MJ
 dnyeb0wzZgiZfM2wDXbjPTlPwr+I+KlqaF7SQvn0u34cgDIVgFlDHBzeHdo8wwHpBJEW
 6B6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743459167; x=1744063967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=obHKoIEOzkL/pFU0m16gFeNK6bbRhAdAffgtXHxHseE=;
 b=dJy7H08iDVmbXoaDNmVcuZvEIbLx75/fMLZqh2Rj2507T6JtQYk718n0dCjic885Mz
 59SgV2rwMvl1jaChMVut6ZTk6AfVDDEFD8b701CKrVweL3RA6pnuqr1cFwCdBcVzz0V3
 L/NZC7ItXt1SE6G6YUUE+qfihRJlciveLtcEUM6JsZwstfKtPOp+5A/ae77je0U1rJxN
 QKcstFiaHMFwf3uur3YHGB/iGrQqf2LW7gqi8pg65JgtLrTZ6HAfVjSbmqduHYHZo7ag
 MtK5i2bXLiymlJORQlevq6lC+CDNlrFZm8RiCrIJ0sp9pOYqa0CpBZJF2e8QvT9M4XI0
 Bugw==
X-Gm-Message-State: AOJu0YxPGQoKoXPikY/O1Bc32XG6s5S0CO7je2u8bpJh7O9iS1ZLErPJ
 4TaQYpaeyl0JFABMaEVrNDtJuZitAM8GM/JYWAEK6Vftotx/eBy3ULX0fiWo4xNgCFYMTsE50dC
 4
X-Gm-Gg: ASbGncuonDifn6PD8FLWGDtXGD96jbpfdl3WN5xgDXtmPXmF4KyevJ7V2Fdw1gEi5Mq
 deKCWo4o85BVeSuDJArMHWHmJE6MR/EKs+8EG2BggFMHqLW9GvcEze0RLIKTupa1oQxsd5dHuL4
 m68og39nfJc2nwRkpTWMUiH6K5kD5xHoF4dTtQJjiU9S8KaxhMo/vuLg5k4CxACj64gdmwK9jzb
 ig3SITKBAVpWGNAsUi9Gk56+8p/E8ELhF2yNEbPZRWcekse+TIxRtRck9PRKTH5c3vKZBhq3RhA
 UoEFd8IzGnQoaaZ/46+Q26iNOc3ULZ0syFj+7cuuxwujAvw0+4u34OYBr0j0vLVrREPwICOogp1
 p4oJHoti7dJZn3jRIsec=
X-Google-Smtp-Source: AGHT+IFLWZeXaFFwycXElWHhvS80gvUXEOoZE4AWcLxqrZ0KsBxZ0m5GNE2o1IrSo7UvodHtYCCZFQ==
X-Received: by 2002:a05:6000:1862:b0:390:f6aa:4e7c with SMTP id
 ffacd0b85a97d-39c120e0bc1mr8515397f8f.28.1743459167214; 
 Mon, 31 Mar 2025 15:12:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4200sm12533268f8f.96.2025.03.31.15.12.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 15:12:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 1/5] qtest/bios-tables-test: Add test for -M virt,
 its=off
Date: Tue,  1 Apr 2025 00:12:35 +0200
Message-ID: <20250331221239.87150-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331221239.87150-1-philmd@linaro.org>
References: <20250331221239.87150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/bios-tables-test.c            |  22 ++++++++++++++++++++++
 tests/data/acpi/aarch64/virt/APIC.its_off | Bin 0 -> 184 bytes
 tests/data/acpi/aarch64/virt/FACP.its_off | Bin 0 -> 276 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off | Bin 0 -> 236 bytes
 4 files changed, 22 insertions(+)
 create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
 create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0a333ec4353..55366bf4956 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2146,6 +2146,26 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
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
+                  "-M virtualization=on,secure=off "
+                  "-M gic-version=max,its=off,iommu=smmuv3", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_viot(void)
 {
     test_data data = {
@@ -2577,6 +2597,8 @@ int main(int argc, char *argv[])
                            test_acpi_aarch64_virt_tcg_acpi_hmat);
             qtest_add_func("acpi/virt/topology",
                            test_acpi_aarch64_virt_tcg_topology);
+            qtest_add_func("acpi/virt/its_off",
+                           test_acpi_aarch64_virt_tcg_its_off);
             qtest_add_func("acpi/virt/numamem",
                            test_acpi_aarch64_virt_tcg_numamem);
             qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/acpi/aarch64/virt/APIC.its_off
new file mode 100644
index 0000000000000000000000000000000000000000..c37d05d6e05805304f10afe73eb7cb9100fcccfa
GIT binary patch
literal 184
zcmZ<^@O0k6z`($=+{xeBBUr&HBEVSz2pEB4AU24G0Uik$i-7~iVgWL^17JJ`2AFzr
bgb+@aBn}xq0gwb2)Q)cq{30-g9B_L93G4|0

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/aarch64/virt/FACP.its_off b/tests/data/acpi/aarch64/virt/FACP.its_off
new file mode 100644
index 0000000000000000000000000000000000000000..606dac3fe4b55c31fd68b25d3a4127eeef227434
GIT binary patch
literal 276
zcmZ>BbPf<<WME(uaq@Te2v%^42yj*a0-z8Bhz+8t3j|P&V`N}P6&N^PpsQ~v$aVnZ
CVg~^L

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/acpi/aarch64/virt/IORT.its_off
new file mode 100644
index 0000000000000000000000000000000000000000..0fceb820d509e852ca0849baf568a8e93e426738
GIT binary patch
literal 236
zcmebD4+?q1z`(#9?&R<65v<@85#X!<1dKp25F11@1F-=RgMkDCNC*yK9F_<M77!bR
zUBI%eoFED&4;F$FSwK1)h;xBB2Py`m{{M%tVD>TjFfcO#g+N#Zh@s|zoCF3AP#UU@
R!2`+%Dg6Hr$N|zYvjDIZ5CH%H

literal 0
HcmV?d00001

-- 
2.47.1


