Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B2BC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 15:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7oI-0002t8-HF; Tue, 25 Jun 2024 11:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7oH-0002pu-3V
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:10:17 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7oE-0006ox-9Y
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:10:16 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7066cba4ebbso2114732b3a.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719328212; x=1719933012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RHCVHGsnm67vgclIl82zPh5XLBIaF6XqB4NGAAUBUiE=;
 b=RViFI9hIVRh6mVRHK7WJGI0QtbzC9KL5AWXXup8n+e6HB696uD/ONv0DSe1n/MS1wS
 m9jW/U1olLWVARgBcnD3kQAyAspF+lCyDWv4muBPqvBifsGfPD547048Xj45n1fEEugz
 OmmbXkDEJMY20q0Z7DGY9vJcertuckSmxndhB0RUyWvfM1JoCqqLFLUPE7/3ZL2aAhzj
 cxa5D0SKVd5qtbO4FYWJQhEJtS+WdGYYtJkQkzMJOGlZP2V9RJfe2c/dX7zks9SOM2Xy
 veDOTiDSEnlGiMKzQLSe+rlIIwHTpToe0W36d2FFCla4ljh1y9XTwDRnJ2EqR45w8P38
 fZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719328212; x=1719933012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RHCVHGsnm67vgclIl82zPh5XLBIaF6XqB4NGAAUBUiE=;
 b=G/znuzHFaEtdLXyQDwEFFTKCeZ7/PGmrKUCL8jiE/nZoaIh1/4dg0MaGq2Cu0/4W7m
 1iHiEuxCqQP/k9cUrDuFoHcBDFMo9Ubx8YbI7bPNSzJ7k40GhrXXnHE21RwXFhn4a/ta
 /YoJySUU8ADR+y0xmHrfKEBvo6bmKdZ6yS0wsJaOaX/tA1J279Ptp8HKfWa2x2izUafC
 VRlhuibFLRueSR8Kkzm8joZPRwgHo7NaDcWKNWqGypeSgnL/fAPuoM5M1Lt/YmnM/sFZ
 ImxXI8R8D+PLq2cIgKd99MEjYpsMBXKlabUugIIpO0eaHLMNErrcX4w+yQW1BFUNNGCP
 K4NA==
X-Gm-Message-State: AOJu0YxKj6BmMvl7I6bFJiV205wGP7ATTZWZfmUmsk67rL5WeDtjXu+h
 jW8VP9PUP5dJkClwgH3hBkFvhu//Xqmy7iF6m1Hr1JvD1nFlkRuRPWyVIiUnDqWMdyiVUSKyeN9
 8
X-Google-Smtp-Source: AGHT+IGqxWGxN2prP93O2k73/4ZrZOSBNlpn1biNSm+3pdC0lM3Wfoywr20UTJMEdyEpE36kROEjog==
X-Received: by 2002:a05:6a20:2a05:b0:1bd:226e:6ce0 with SMTP id
 adf61e73a8af0-1bd226e6e9emr1428122637.48.1719328212462; 
 Tue, 25 Jun 2024 08:10:12 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70681722219sm4142636b3a.73.2024.06.25.08.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 08:10:11 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 14/16] tests/qtest/bios-tables-test: Add empty ACPI data
 files for RISC-V
Date: Tue, 25 Jun 2024 20:38:37 +0530
Message-Id: <20240625150839.1358279-15-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
References: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x434.google.com
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

As per process documented (steps 1-3) in bios-tables-test.c, add empty
AML data files for RISC-V ACPI tables and add the entries in
bios-tables-test-allowed-diff.h.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/data/acpi/riscv64/virt/APIC           | 0
 tests/data/acpi/riscv64/virt/DSDT           | 0
 tests/data/acpi/riscv64/virt/FACP           | 0
 tests/data/acpi/riscv64/virt/MCFG           | 0
 tests/data/acpi/riscv64/virt/RHCT           | 0
 tests/data/acpi/riscv64/virt/SPCR           | 0
 tests/qtest/bios-tables-test-allowed-diff.h | 6 ++++++
 7 files changed, 6 insertions(+)
 create mode 100644 tests/data/acpi/riscv64/virt/APIC
 create mode 100644 tests/data/acpi/riscv64/virt/DSDT
 create mode 100644 tests/data/acpi/riscv64/virt/FACP
 create mode 100644 tests/data/acpi/riscv64/virt/MCFG
 create mode 100644 tests/data/acpi/riscv64/virt/RHCT
 create mode 100644 tests/data/acpi/riscv64/virt/SPCR

diff --git a/tests/data/acpi/riscv64/virt/APIC b/tests/data/acpi/riscv64/virt/APIC
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/riscv64/virt/DSDT b/tests/data/acpi/riscv64/virt/DSDT
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/riscv64/virt/FACP b/tests/data/acpi/riscv64/virt/FACP
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/riscv64/virt/MCFG b/tests/data/acpi/riscv64/virt/MCFG
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..70474a097f 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,7 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/APIC",
+"tests/data/acpi/riscv64/virt/DSDT",
+"tests/data/acpi/riscv64/virt/FACP",
+"tests/data/acpi/riscv64/virt/MCFG",
+"tests/data/acpi/riscv64/virt/RHCT",
+"tests/data/acpi/riscv64/virt/SPCR",
-- 
2.40.1


