Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E3EC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 15:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc3bC-0000Ii-Fb; Wed, 16 Jul 2025 10:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uc3Kj-0000Y6-66
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 10:42:10 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uc3Ke-0004Dd-DG
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 10:42:07 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3122368d7cfso5443815a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 07:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1752676922; x=1753281722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vz3saWPCz9YpVOLE1qri2VksOOuVVz8IXUSKPWtWCnE=;
 b=L47A52k5ICkn5PesKHrSryfoe0FdX2Zrk3IM47kjuixSuHOuy719MLtRz4/NKBNUJd
 YJHnjHhY8hesiONWfh5sN11ZVisU5fCVj9wa9OqMrtNmUr/qeZK7YdpY6StjaNE2dg35
 yPYtKBtSJDSIJ/iKXaDAl2kZfnkRcpE7xnH/+bkmyK/1B7O7nTAFzjMxp8ALUMDG+Sh9
 2rec07vogM9I8D9eqvaG53FVaaG89S63y00qPbucTXEVemtQERmrSdaWOSMFftKr1oaK
 GnfGn/bWa0m8miu7WddgCWu2TlLm4zXMHIsQTpWocc3zq0JUreNHfwKrxv1eqeukG4Vk
 ErUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752676922; x=1753281722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vz3saWPCz9YpVOLE1qri2VksOOuVVz8IXUSKPWtWCnE=;
 b=fcfDsIK8vsg5PZDnIsl0pgVfUgSTsV5g7ZMcaLSn59L9xF5XmTXpuG53ogAs8szRNe
 +Bs5IZHCCNEZf3ZFqKJVtt1360dY8VoyGFZCEFmaRk5gP7NWxe6yOjsSA1wih3m05njF
 AoaqN47+1OoT+GujnuBIhCS0yFGBEAeoVXsfaLJRvrqGYm9ThrGR+tXPfgB557iYZ/Fb
 67BC4wpjPqL4XT5tajrVB9svXnlZd2z6k2ZCAH2sLSP5fVVxDqccn+lJhgSWTUIGp6G8
 u6hqRCugwHxDXH7yS/BoxWFdPYZsUvyci4sT6Qx9erP6Ei8uIi9+6z03sv3KKcrV1R5c
 LXag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxN+jpVwOAy1BXlyjV0tnI1eb5M+54MugVleU1mTYiMzsJuoF6In2im2lzbjdoWqas0Zh7k6X8S+4y@nongnu.org
X-Gm-Message-State: AOJu0YwM5IYW8CW6LIHE95YJI2VaAh+TF8yUW1eAPDzf0T3VJc6TWl8r
 3V8I64813ZBUaooR9TN4pdzhYjxFGx1UJLDpQRskq2m+hpO2cnb//hCeEQMI5VYoQ6g=
X-Gm-Gg: ASbGncsQkSuvR2Z1tQHh3+f+U6GQC0B7XA6N5zDbRZcqKIVf3TN1KuXHWqyLXCKw908
 V249PCo0tOc9Aora7zqo3VemI9AuTlleHDJvYBjFmlcR5m5Nejyh7dAPkXBh+RcuVHIHPMwBONG
 4v2wKU1JThNIkjsaXOffdsrIwNyCLtsNWZmAlQZ4xAYKEiBOHG31Q/3P4LIu8H9o+ve3uScCMPu
 sIr4g3fpEkfTcZSQtnpZgYkv7DS8vj3QI4Cmi4IDRu+wJS6YkkwzBvSWZh4DX4xH5tKFbEFWI+K
 UJ2ygF9twlxYUGSaQprtYYyXvbKdj+vPKClmynmfr13k9HGD5ASZejKey3awMjUGytbB8V37yRm
 of+DtExnczGu4FFfbVxA+22DbvWwZ/W+a
X-Google-Smtp-Source: AGHT+IHBVEmWmZN12RbtGvnNAql4xHYnTz8kDSoTlH35bkFz3l/0gjZi9HtYMRsS59eBio7+mM9mrQ==
X-Received: by 2002:a17:90b:2d85:b0:313:287e:f1e8 with SMTP id
 98e67ed59e1d1-31c9e6eedb3mr5595695a91.8.1752676922108; 
 Wed, 16 Jul 2025 07:42:02 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f2879fcsm1622950a91.28.2025.07.16.07.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 07:42:01 -0700 (PDT)
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
Subject: [PATCH 3/3] tests/data/acpi/riscv64: Update expected FADT and MADT
Date: Wed, 16 Jul 2025 20:11:40 +0530
Message-ID: <20250716144140.3954431-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716144140.3954431-1-sunilvl@ventanamicro.com>
References: <20250716144140.3954431-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pj1-x102b.google.com
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


