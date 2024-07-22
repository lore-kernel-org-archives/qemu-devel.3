Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB3AC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgmR-0007yX-Sd; Sun, 21 Jul 2024 20:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglf-0003ak-55
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglc-0005z8-Fl
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gfiaAZu1KXFxLDbrHFmgg4NXXcuygsvbvDqpALcUfu8=;
 b=QSCgA/4jUP4TnVSAY4LBUGYy89Mk3c1c6DDza0mU/DgNnyIJxnvz5yK9V5Ryrt4MD5PTeZ
 BLN59U25wrY+Fl546szTBYmXGaSMI/LuoQ2KfF32WEY4R0X19V8GF6J8Svpgc3kTAcOqvD
 +PIh2Zv8Up7MCRylFL2mrtC7Uj9HTCE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-rFGAARffOkWBiAGMMCeQ1g-1; Sun, 21 Jul 2024 20:18:57 -0400
X-MC-Unique: rFGAARffOkWBiAGMMCeQ1g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-427d92bec90so19344575e9.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607536; x=1722212336;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfiaAZu1KXFxLDbrHFmgg4NXXcuygsvbvDqpALcUfu8=;
 b=REk52AIAdJMXHVhWze92RDjWVhRs8rLXKBWgSVcLpu6YGgWEKZTU1AZjJoCgInTc/y
 zsKwQgO0qrgvPujN1RU2/dQeiDQvsckevcx6RRbUmE2YRpFljxiwIe6pusSoYP9/hvgU
 O3pt5ooi5gvKRgiO+Gb0mNkv+ygjZGUSUjw62xeDGroO2OeFh0pilPsP2DHAlyIrUBg6
 fiAx2f2S0n+k30I5Bntn8coKee+/wmncUZZyIB88FKJaEtDG4cKzF5VXpNLShThk9MqC
 CDjwmSY58YQBopoeofTXdNEV9GZ5CTn0gOBDvodCYOjuEGTbpVmzmrvKhmWw5sjP9fdV
 Vs1A==
X-Gm-Message-State: AOJu0YyYwpJyfKze7yAq5KOOoMDOhj10C+tcDsmeLw4PP3uxSgHAszhU
 4OLOgd4gyL+KBfxqMyQKdhG5peDnsK9C+O6TPmqu4ebYKhnHkl7jDoUlY7sd8N3CXnU/GmOXl1L
 IZzTghXch1fUsaztQNII2JG6iRg/9aMSAj75pgd0nnTagzqCatZY4RMi8zHwKsHjOw77+JxINdS
 x5Gg7uro7zT7f3/H+cMAl5Hv9m/vvUSg==
X-Received: by 2002:a05:600c:1914:b0:426:629f:154e with SMTP id
 5b1f17b1804b1-427daa60cf1mr33516255e9.30.1721607536327; 
 Sun, 21 Jul 2024 17:18:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMl2knGwqTLEFt9fOxumTjkU6ednkgB2W3F/vBNtIj9wtsttrx7XOVbxPHeJZWdQAITxFpxQ==
X-Received: by 2002:a05:600c:1914:b0:426:629f:154e with SMTP id
 5b1f17b1804b1-427daa60cf1mr33516135e9.30.1721607535805; 
 Sun, 21 Jul 2024 17:18:55 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a9466bsm133707985e9.41.2024.07.21.17.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:55 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 58/63] tests/qtest/bios-tables-test.c: Enable basic testing
 for RISC-V
Message-ID: <1056008c0bd9dde86f159d7259138d641408e7a4.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sunil V L <sunilvl@ventanamicro.com>

Add basic ACPI table test case for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716144306.2432257-9-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


