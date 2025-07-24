Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD2AC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetlM-0000th-0f; Thu, 24 Jul 2025 07:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uetkE-000842-Hu
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:04:19 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uetkC-0000bB-QO
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:04:14 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-75ce8f8a3a1so559335b3a.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1753355051; x=1753959851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rPwSvjo9BOLZviQoIIhyK9231AY2iUmEkjpcQiKAGx8=;
 b=SXy7CKxYNDEBnwmUrj9v5so9NwXLOL6TYZlARieUfpp0k4uGS6lj9odrHgK6bzEBPt
 Ne9bzcvaFmSFJwNWS5P5FdCStq0WWMP72haDknHsG199+784PNQusCU7QT6XQu/H833P
 DMp9T6H9gkbPQcMp8uMOeQXEmCpmxQ/jf6VIyPMGx3HfVkrWrScqW9BQcLWnZ2ksmo4c
 cfuu6YCN6nFY/UTkYFgjBKeBk3Ku2wcf4PfrDBsvHKRd8XVuv5UayQFOImnW5R4TuOdn
 gJtDP7nigtKRrpAzE5sxq3Ymc+c8sKI4XaCFjp+6RESqzx0IcyuA8TtIHNrLfrJVjIg1
 hVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753355051; x=1753959851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rPwSvjo9BOLZviQoIIhyK9231AY2iUmEkjpcQiKAGx8=;
 b=frrF5MNZYqMBy222pKd5FpVrr9RmjrpZJa3vIM9oCm5hdmFvywc3E7iDfVkXmWsVxu
 qiN85htDR3UEEJX6ce22FF5oJCHDtlRla+Kp3omFifj8yAUgCLxQw2sGAn1ZRezd4Hqf
 RemzW6gdoe6gDIN4OsQkWdWpmCjO1CoVTL7H6m5LV080MHbO409bvak7BB5Yb0eu/UW4
 tYRAfvdcXvMqi8JBFkKw/E3Ock6KXKO9pbFhj/2VXdp27NDzKBR22FLAHwUekanDDPQJ
 5PT1/00gbAE1CdvmfevWmhjhprL7iM0IdXQ/n7QLWNtbQHU0y38JmOc36Orh5pxwJRZS
 b5+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJpTwPcnC3i57ME/v+RfcwuJw2bIhM2M8EzOmSG3NieMt3DOXDzbW44C5DAVqHcVFTC3JeCXQxINGa@nongnu.org
X-Gm-Message-State: AOJu0YzHiMD5JWT99PIqZN7L/CX7RDKFYUFyTqB2buEXWweL9tMo1iRz
 Th0JorXEZ52/lftLqA16NRTD0UGvLX1iFHi0hsiaH1XF3Xk0JDyv8r0jlccnAUvMS2A=
X-Gm-Gg: ASbGncsOT1F3CSAJ72jlOhLEds6k29b3uNVeLr4FyA9eCZWwVLlQBtdm+TyOsCYyHvb
 eSs51GVROgMDOlMs8NTp0kMK5+HiCbl6kLG2AjdNByfaMhSt5zd/UrShRO73RvsViH/m/3Sg54p
 caW8cBN4wXznrgFUHgWCnJrROeyfdVjAqWIGzweYHhOn2HhnxG5kL7I6x2eCVgnUDjtMkx7ESex
 N87wNQSuuUzIon8N0znS8lPcToIi8r2V1HGAXlD4lmPKuAkQKkarxzroL81ozQPCizVuzc72e73
 KznHBEXhmt3dvVJSUYIyjRc7FIv70hp0DqplQCgtd/ZT7m6HiNDwQA3i5hIMayNZFWr/tW4mhvM
 Oi3WoLV/g5JcoS7fdd5nplLCRqAOz4+TY/HajrpWZ3avROEbl
X-Google-Smtp-Source: AGHT+IHRPbuYsge72ZBShmVxWzRoDvJl3Sj4Di6Hw0P/4dEqhQV95Hz0YisThCMYhOtAhfnqFC1q9A==
X-Received: by 2002:a05:6a00:180a:b0:74c:e253:6c83 with SMTP id
 d2e1a72fcca58-76034c50902mr8609537b3a.6.1753355051301; 
 Thu, 24 Jul 2025 04:04:11 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.219])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761add64fd1sm1430578b3a.13.2025.07.24.04.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 04:04:10 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 3/3] tests/data/acpi/riscv64: Update expected FADT and MADT
Date: Thu, 24 Jul 2025 16:33:50 +0530
Message-ID: <20250724110350.452828-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724110350.452828-1-sunilvl@ventanamicro.com>
References: <20250724110350.452828-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x429.google.com
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

Update the expected tables for the version change.
 /*
  *
  * ACPI Data Table [FACP]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "FACP"    [Fixed ACPI Description Table (FADT)]
 [004h 0004 004h]                Table Length : 00000114
 [008h 0008 001h]                    Revision : 06
-[009h 0009 001h]                    Checksum : 13
+[009h 0009 001h]                    Checksum : 12
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 004h]                FACS Address : 00000000
 [028h 0040 004h]                DSDT Address : 00000000
 [02Ch 0044 001h]                       Model : 00
 [02Dh 0045 001h]                  PM Profile : 00 [Unspecified]
 [02Eh 0046 002h]               SCI Interrupt : 0000
 [030h 0048 004h]            SMI Command Port : 00000000
 [034h 0052 001h]           ACPI Enable Value : 00
 [035h 0053 001h]          ACPI Disable Value : 00
 [036h 0054 001h]              S4BIOS Command : 00
 [037h 0055 001h]             P-State Control : 00
@@ -86,33 +86,33 @@
      Use APIC Physical Destination Mode (V4) : 0
                        Hardware Reduced (V5) : 1
                       Low Power S0 Idle (V5) : 0

 [074h 0116 00Ch]              Reset Register : [Generic Address Structure]
 [074h 0116 001h]                    Space ID : 00 [SystemMemory]
 [075h 0117 001h]                   Bit Width : 00
 [076h 0118 001h]                  Bit Offset : 00
 [077h 0119 001h]        Encoded Access Width : 00 [Undefined/Legacy]
 [078h 0120 008h]                     Address : 0000000000000000

 [080h 0128 001h]        Value to cause reset : 00
 [081h 0129 002h]   ARM Flags (decoded below) : 0000
                               PSCI Compliant : 0
                        Must use HVC for PSCI : 0

-[083h 0131 001h]         FADT Minor Revision : 05
+[083h 0131 001h]         FADT Minor Revision : 06
 [084h 0132 008h]                FACS Address : 0000000000000000
[...]

 /*
  *
  * ACPI Data Table [APIC]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "APIC"    [Multiple APIC Description Table (MADT)]
 [004h 0004 004h]                Table Length : 00000074
-[008h 0008 001h]                    Revision : 06
-[009h 0009 001h]                    Checksum : B4
+[008h 0008 001h]                    Revision : 07
+[009h 0009 001h]                    Checksum : B3
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
[...]

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/riscv64/virt/APIC           | Bin 116 -> 116 bytes
 tests/data/acpi/riscv64/virt/FACP           | Bin 276 -> 276 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 3 files changed, 2 deletions(-)

diff --git a/tests/data/acpi/riscv64/virt/APIC b/tests/data/acpi/riscv64/virt/APIC
index 66a25dfd2d6ea2b607c024722b2eab95873a01e9..3fb5b753596fc7c2618b3d5210be8b00b0c177f6 100644
GIT binary patch
delta 16
XcmXRZ;c^V{bS`0FU|`=okt+)TB&q~M

delta 16
XcmXRZ;c^V{bS`0FU|`!akt+)TB&h^L

diff --git a/tests/data/acpi/riscv64/virt/FACP b/tests/data/acpi/riscv64/virt/FACP
index a5276b65ea8ce46cc9b40d96d98f0669c9089ed4..78e1b14b1d4ff0533a6a4c041f195a69b4ef114d 100644
GIT binary patch
delta 30
mcmbQjG=+)F&CxkPgpq-PO=u!lB_rF!iPaMgcqj8PasU8k76z;U

delta 30
mcmbQjG=+)F&CxkPgpq-PO?V<#B_r#^iPaMgcqj8PasU8k8wRWZ

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 0c3f7a6cac..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/APIC",
-"tests/data/acpi/riscv64/virt/FACP",
-- 
2.43.0


