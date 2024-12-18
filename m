Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98858E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2b1-0004og-4t; Wed, 18 Dec 2024 17:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Zk-0003Tn-PX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:32 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Zf-0003Iq-TX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:25 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-218c80a97caso1724915ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561082; x=1735165882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+u/esspkIM84/pIeM30BE8iVEgZ0neo/04y/t2IyJ4=;
 b=ONxvZzvEUu1hjB61duMjLN3TznUnD+n2QmhL4C+TtAd/b5wWpmFudOfEAF88CD5Hf2
 eLz3RwDWPX65ptkkwAyJjDY/T8u+DneQXTveU1IIhnssroZUoXJRu0zhBxxd4ZXQzTxI
 o6jq5JTRrPpprpqLCW/ZqARqks9Gk0lrL8C8bShUYe6GyjcPkrzSfSY4eRk5uAk7/WQ8
 jY4iq2coZQmmkEg3iiXRGjPwhvBtdQ6wi3w078N3q+1y0odUa/64Y2G0JcrzvrqfrK4e
 2FsvB7mD1n7P20U4wHve9nY2ucvehBU9i2IosBiptbtbiesj0lkT0LVNxdL2mWD89qi2
 Y1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561082; x=1735165882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+u/esspkIM84/pIeM30BE8iVEgZ0neo/04y/t2IyJ4=;
 b=avrNFm8dV9mPTnC6Q85+usvX9EFVxoTMKzn2WEb1JXqcoL7XDyqal973azoHO24iRn
 YWrwUdhM5NMs3GLeC5qDnEQUpcP1yLcfNI+XoPCWtVg5ZvUbjI7hSEMTeLZnkJWzLHXc
 3iVOIa9hvE/ViHnaVt29SedXqh7VFzlhBhfkBoEEftCsdzO3klum+5oa1CL7Hgd4Btga
 gWOXeqns/BwRibppPhI2Fir2hzbw5Qb4eenbS+3z/9yP89u5h7P3uh/hByRGPBeCpM8H
 NWAWMdk9wkDbrYvEbu9iPJo0mlffr/qm0I6DtxddWVc3qWIqN9AZkBanSvKNcX1uITkr
 yvRg==
X-Gm-Message-State: AOJu0Ywy4T73WBrwghK1/fjZ4dnR6txE6q8WGIVdAPKkARhLzmE6SrlH
 eqQ0Kdf8EJ5xVvnLLgYTgupQBHFcI7OL/d/oZhPfkLodhITRtyGszqMPIcRu
X-Gm-Gg: ASbGnctM2tHcY8nFakGZqTEJsZAUbccdZOYtDp6RjVPLDKZi0nO0EPJ7wHbyYtOj6Wt
 eWhTa8aPoIjYmIuNU44v4H28sb0S4ZUT5/1/KARk8NbXVctYsD5pXsgvvCNhx+i795efvmcgzea
 DQkIRs4ojWQAMe6Uc1GUSKw3Pv0vA8l+eFufTDtgP41lDVR6mH3rEAgu4z5Mh/cemqVXtT0fWl/
 tq4SPy+2yJw99xzTIKrvmX3vsjKEsu6DLHk8gC80uxJtmHS9eoylj9F8WnDAyMIsQ6yDKiAzf4n
 RiKlZgySI+ff+i4fR77/6j5r2bm8ARZOCIWxU2ykZCN24nbegfGZSQhC/z9+hOw=
X-Google-Smtp-Source: AGHT+IF2gREV/TlbKp6Vl3Ec8pUV06mz6PbeDfwmWIpiMGTjEGvxYCV+qz7ygCT16/3htdY5uVX77g==
X-Received: by 2002:a17:903:1cb:b0:216:501e:e314 with SMTP id
 d9443c01a7336-218d710111bmr54130895ad.20.1734561082405; 
 Wed, 18 Dec 2024 14:31:22 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:31:21 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/39] tests/qtest/bios-tables-test: Update virt SPCR golden
 reference for RISC-V
Date: Thu, 19 Dec 2024 08:29:52 +1000
Message-ID: <20241218223010.1931245-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

Update the virt SPCR golden reference file for RISC-V to accommodate the
SPCR Table revision 4 [1], utilizing the iasl binary compiled from the
latest ACPICA repository. The SPCR table has been modified to
adhere to the revision 4 format [2].

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
[2]: https://github.com/acpica/acpica/pull/931

Diffs from iasl:
/*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/riscv64/virt/SPCR, Wed Aug 28 18:28:19 2024
+ * Disassembly of /tmp/aml-MN0NS2, Wed Aug 28 18:28:19 2024
  *
  * ACPI Data Table [SPCR]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
  */

 [000h 0000   4]                    Signature : "SPCR"    [Serial Port Console Redirection table]
-[004h 0004   4]                 Table Length : 00000050
-[008h 0008   1]                     Revision : 02
-[009h 0009   1]                     Checksum : B9
+[004h 0004   4]                 Table Length : 0000005A
+[008h 0008   1]                     Revision : 04
+[009h 0009   1]                     Checksum : 13
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

-[024h 0036   1]               Interface Type : 00
+[024h 0036   1]               Interface Type : 12
 [025h 0037   3]                     Reserved : 000000

 [028h 0040  12]         Serial Port Register : [Generic Address Structure]
 [028h 0040   1]                     Space ID : 00 [SystemMemory]
 [029h 0041   1]                    Bit Width : 20
 [02Ah 0042   1]                   Bit Offset : 00
 [02Bh 0043   1]         Encoded Access Width : 01 [Byte Access:8]
 [02Ch 0044   8]                      Address : 0000000010000000

 [034h 0052   1]               Interrupt Type : 10
 [035h 0053   1]          PCAT-compatible IRQ : 00
 [036h 0054   4]                    Interrupt : 0000000A
 [03Ah 0058   1]                    Baud Rate : 07
 [03Bh 0059   1]                       Parity : 00
 [03Ch 0060   1]                    Stop Bits : 01
 [03Dh 0061   1]                 Flow Control : 00
 [03Eh 0062   1]                Terminal Type : 00
 [04Ch 0076   1]                     Reserved : 00
 [040h 0064   2]                PCI Device ID : FFFF
 [042h 0066   2]                PCI Vendor ID : FFFF
 [044h 0068   1]                      PCI Bus : 00
 [045h 0069   1]                   PCI Device : 00
 [046h 0070   1]                 PCI Function : 00
 [047h 0071   4]                    PCI Flags : 00000000
 [04Bh 0075   1]                  PCI Segment : 00
-[04Ch 0076   4]                     Reserved : 00000000
+[04Ch 0076 004h]             Uart Clock Freq : 00000000
+[050h 0080 004h]           Precise Baud rate : 00000000
+[054h 0084 002h]       NameSpaceStringLength : 0002
+[056h 0086 002h]       NameSpaceStringOffset : 0058
+[058h 0088 002h]             NamespaceString : "."

-Raw Table Data: Length 80 (0x50)
+Raw Table Data: Length 90 (0x5A)

-    0000: 53 50 43 52 50 00 00 00 02 B9 42 4F 43 48 53 20  // SPCRP.....BOCHS
+    0000: 53 50 43 52 5A 00 00 00 04 13 42 4F 43 48 53 20  // SPCRZ.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 00 00 00 00 20 00 01 00 00 00 10  // ......... ......
+    0020: 01 00 00 00 12 00 00 00 00 20 00 01 00 00 00 10  // ......... ......
     0030: 00 00 00 00 10 00 0A 00 00 00 07 00 01 00 00 03  // ................
     0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
+    0050: 00 00 00 00 02 00 58 00 2E 00                    // ......X...

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Message-ID: <20241028015744.624943-4-jeeheng.sia@starfivetech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/riscv64/virt/SPCR           | Bin 80 -> 90 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index aae973048a..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/SPCR",
diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
index 4da9daf65f..09617f8793 100644
Binary files a/tests/data/acpi/riscv64/virt/SPCR and b/tests/data/acpi/riscv64/virt/SPCR differ
-- 
2.47.1


