Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07978C3601E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MOo-0002nJ-Bk; Thu, 03 Apr 2025 11:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MMB-0008AK-HW
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MM7-0000c6-2Z
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:49 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso5408745e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743693584; x=1744298384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLYRdVVgThynsCkkZUPojC5QmxuF1gOqeLFrpCloSHE=;
 b=U2rOJQ2LC5f3ixNLxE+nspJtkWChVRlxMmSwJoM6r2nVJPuILGowLa+BxzugG/PMAh
 v+We1TqEirCoxWLliqfR9J/ddmKwX3DVZtvh0zWZq6FHQ3Y5tW3NMh8lVdEYb9V5vcsR
 RNHXfpnB2UuBpt0AD7NgjGd0fe2lWY/VmmA/mhnBY6NkBDmeRyvPRUkI/DDP4KzA6GHC
 Hyr2BNd6dkrj/7S+6kUzE8fpZqW2iqiHI/oyqafbzDUybZoSsfnQC2WICiyyIfPUbRmo
 wHWa9OhCWr6MZN6Um+cVM8IA3MngzbioPZyCAjRmETQlmwhrLcKUYrjw19jfp0tyiAXV
 3D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743693584; x=1744298384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MLYRdVVgThynsCkkZUPojC5QmxuF1gOqeLFrpCloSHE=;
 b=pUsEXYwwkVwpjMljVw7wGEFCX4sPm6GxZnVmphq7lXttUs3WDiCbz7De+TJ5UZhKZx
 E6thmbKlPz+22RfxUmf9Rj38rRefa/i1vAvohm16uwSqUvnAjNflR31H/QaQ/TeTyNbP
 c9M+C6UzXrtJWydblYaIPi2X+wWZLu7NCowrlT6uEn/jvPW72KPMp0diZJXTniEyupXt
 cSluLsaLbqLn+q3E6idU/WA+opiJU5xvlLdaV4iDASEXTE6hy7+rPFsB0dtOyR6XC1nz
 WNztnzhVzRflFi7Jc0w2k3PR/ynBU0SUs30MXl5EPRD33z0tvevHOvjM0vAORmWsErmb
 Vn2A==
X-Gm-Message-State: AOJu0YwIFya9KLGISk0kpCZlNYisoX5n6bO0vazaxOoU9lOTvigGw3F5
 WpkFbHToNWW9bGR1xr/AFMZg/WNgHPJHV00qA7nu7y4GBoq8Kxdwee4+2psgncE8PHoZu776Z/V
 P
X-Gm-Gg: ASbGncsore3tIyqIpzPb5HpAn3OuD92pK4s2kMx8I/huTzEYagA4PJkKe9hPLT6U0kY
 VjssHtT9ZuUk+v7tpO+VueVRvfN+D9r6e8S0ioySEmeZzAsWnnBm4eS1MZSEQek5DBvGYsxANBa
 QEtH6FiszXlMGSolGsvQdvUuomde0WCDAKCjLNVGOVGVSFXTT5pwIkycG7N6yJlKJo7lKPr3H0a
 ecv/oqaZAE6LO91X1vI0MVnynWxjakYYfjLaCSHwTUkyl9oLXzCCUdyLftTXJj1SIVpx1a6654m
 ffoyjfGWvc82/nMhG+1C7Ey51s3pvS7mf2lJdUgot2QjeN956eHuSsIzfkJuN/P0/6DHrem1ACd
 jgQ9RnYqIF/fjfVgE2DM=
X-Google-Smtp-Source: AGHT+IENZTVyKkRY1W/b+AkkGyWGuqGp4yOMjd8Bjsjt2DdngZ1luNGpYjMfCIJLIyGZmX/C5Virpw==
X-Received: by 2002:a05:6000:4010:b0:391:2a9f:2fcb with SMTP id
 ffacd0b85a97d-39c30387633mr2572096f8f.36.1743693583885; 
 Thu, 03 Apr 2025 08:19:43 -0700 (PDT)
Received: from localhost.localdomain (145.171.88.92.rev.sfr.net.
 [92.88.171.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096b9csm2088473f8f.13.2025.04.03.08.19.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 08:19:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH-for-10.0? v2 11/14] qtest/bios-tables-test: Whitelist
 aarch64/virt 'its_off' variant blobs
Date: Thu,  3 Apr 2025 17:18:26 +0200
Message-ID: <20250403151829.44858-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403151829.44858-1-philmd@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

We are going to fix the test_acpi_aarch64_virt_tcg_its_off()
test. In preparation, copy the ACPI tables which will be
altered as 'its_off' variants, and whitelist them.

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   3 +++
 tests/qtest/bios-tables-test.c              |   1 +
 tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 0 -> 184 bytes
 tests/data/acpi/aarch64/virt/FACP.its_off   | Bin 0 -> 276 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off   | Bin 0 -> 236 bytes
 5 files changed, 4 insertions(+)
 create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
 create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf..3421dd5adf3 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/APIC.its_off",
+"tests/data/acpi/aarch64/virt/FACP.its_off",
+"tests/data/acpi/aarch64/virt/IORT.its_off",
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index baaf199e01c..55366bf4956 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2151,6 +2151,7 @@ static void test_acpi_aarch64_virt_tcg_its_off(void)
     test_data data = {
         .machine = "virt",
         .arch = "aarch64",
+        .variant = ".its_off",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
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


