Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF4CC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MNr-0001Xh-97; Thu, 03 Apr 2025 11:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MMU-0000Hp-Pk
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:20:11 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MMO-0000h8-Qx
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:20:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so734013f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743693603; x=1744298403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zTfaj2srAh7NFFgFGPtQA78JVUrBzadEZv8Wvdm4mc=;
 b=rfx/oM2LfsOQUwISGqavDYAb2c4iizn0+rZcCSTsSLjcW/My2nSfLE75V83bK8+Abf
 /jaRUvkCsyfIQ83SjLoFvOZTpnB3VWFGBTdEkgmIvMiQnJkwgnfqwPzpbZbfcr4W1ePj
 /WGS6ou8ui2Bru8LX8YK0tYTaEiy9aYjo/ZiGVg93oTEzB/2zC5sgqsCqrtiB5JsTsJ+
 8SFI4iarSd9ZnRfEFaligV9HJ1HFW3N/qFaUOLQq/2e7ohi1FS1vu7/c7QWbpMJtNz1P
 yjzG3O257xbO+SnGbAsuR7DP17RanPdpcHiUCc4tCQsEi8gJMHN9jsAmPMOP00tMQrQF
 wm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743693603; x=1744298403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5zTfaj2srAh7NFFgFGPtQA78JVUrBzadEZv8Wvdm4mc=;
 b=Cvrew3jFA86oArfiyubpInBmO1Iig1V8dFduDLZci5DrB6QzbVYYaY8mkc99ZvIr88
 G9CcmG/49Aj7Aob+hoIDeO5URNtxciDeuwG434/pv3BmVtfrmRTeXrciCXFAWvTCE9Ag
 0PU12b0y6dHYlocKbplbNTXkq92uMgTAdJt5CVBuI6U1VIHy52tqe0I8IwFUr1JP8maA
 L79H4ScPPXH20VoJqUm3Tt5epiOqrr04c0HY1A8otzRrmK+VxAvGygsdc2+uR2ybBgrg
 akZELQovjB+6hgTfn7tg2ZEAluToS+/Wd5sE7nBOUMfGE3gGgpu64GGVn1IheAd9plG8
 gOWQ==
X-Gm-Message-State: AOJu0YyMVwBoznCNcJ2re2mq/PXTUIIhu7LfkpKhp/F7kK34AWEJGx+B
 KmgYcAUcktOu4+GHqXCb9aLN8thos8ngK2awuPVpsVkZTutkU2cR3KVOffbyhp4dmSMmRusiB4r
 P
X-Gm-Gg: ASbGncvjRygMOvhUFTxUJGnxrE4L84QMj7m2kEL10yrSy/8Vt5Et61jZih/ijtA8R81
 b8gJimK3IYL8LBvnXI59hQKlzftbYHYvrgTTosSdYQ2fUTDrcK+x60HncazJ2+EeyqPKZHwzGSm
 m5vsPUUsZhTJ9qNPe9OhYQ5H5PjrZQwgLwmjKfwp85p4xD3ZBjruyhk2M6P/TG6U2dl5NVocapi
 e768iGlCJCCNotn3wdLdT2CkH/eCZjQ1PhkBppx6M9ssWn3M2EUHZ0TX38k1/4FIjZM/D8Z8FWM
 Ibw6wdH82Fk0xa4QcDswXQpK8O7qHp/zINQL2nMtkLKtpPtnHC1oYZXDGUNpe+CoUXKVhP/3xT6
 JhsCJaVlei6/DTBvd+Xs=
X-Google-Smtp-Source: AGHT+IEFCTXg032g/W4Ym0lsV1aAElg7syOVhDFSS1LPpq06asEXFSl9P7WW9PANAPFyEI9O8RecBw==
X-Received: by 2002:a5d:6d8e:0:b0:391:3aab:a7d0 with SMTP id
 ffacd0b85a97d-39c120dd0e0mr16997384f8f.19.1743693602489; 
 Thu, 03 Apr 2025 08:20:02 -0700 (PDT)
Received: from localhost.localdomain (145.171.88.92.rev.sfr.net.
 [92.88.171.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec3174cf0sm22355905e9.0.2025.04.03.08.20.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 08:20:01 -0700 (PDT)
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
Subject: [PATCH-for-10.0? v2 14/14] qtest/bios-tables-test: Update
 aarch64/virt 'its_off' variant blobs
Date: Thu,  3 Apr 2025 17:18:29 +0200
Message-ID: <20250403151829.44858-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403151829.44858-1-philmd@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Commit the blobs generated by tests/data/acpi/rebuild-expected-aml.sh.

Changes in the tables:

  @@ -1,32 +1,32 @@
   /*
    * Intel ACPI Component Architecture
    * AML/ASL+ Disassembler version 20240927 (64-bit version)
    * Copyright (c) 2000 - 2023 Intel Corporation
    *
    * Disassembly of tests/data/acpi/aarch64/virt/APIC.its_off
    *
    * ACPI Data Table [APIC]
    *
    * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
    */

   [000h 0000 004h]                   Signature : "APIC"    [Multiple APIC Description Table (MADT)]
  -[004h 0004 004h]                Table Length : 000000B8
  +[004h 0004 004h]                Table Length : 000000A4
   [008h 0008 001h]                    Revision : 04
  -[009h 0009 001h]                    Checksum : A7
  +[009h 0009 001h]                    Checksum : EE
   [00Ah 0010 006h]                      Oem ID : "BOCHS "
   [010h 0016 008h]                Oem Table ID : "BXPC    "
   [018h 0024 004h]                Oem Revision : 00000001
   [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
   [020h 0032 004h]       Asl Compiler Revision : 00000001

   [024h 0036 004h]          Local Apic Address : 00000000
   [028h 0040 004h]       Flags (decoded below) : 00000000
                            PC-AT Compatibility : 0

   [02Ch 0044 001h]               Subtable Type : 0C [Generic Interrupt Distributor]
   [02Dh 0045 001h]                      Length : 18
   [02Eh 0046 002h]                    Reserved : 0000
   [030h 0048 004h]       Local GIC Hardware ID : 00000000
   [034h 0052 008h]                Base Address : 0000000008000000
   [03Ch 0060 004h]              Interrupt Base : 00000000
  @@ -49,37 +49,29 @@
   [06Ch 0108 008h]    Virtual GIC Base Address : 0000000000000000
   [074h 0116 008h] Hypervisor GIC Base Address : 0000000000000000
   [07Ch 0124 004h]       Virtual GIC Interrupt : 00000019
   [080h 0128 008h]  Redistributor Base Address : 0000000000000000
   [088h 0136 008h]                   ARM MPIDR : 0000000000000000
   [090h 0144 001h]            Efficiency Class : 00
   [091h 0145 001h]                    Reserved : 00
   [092h 0146 002h]      SPE Overflow Interrupt : 0000
   [094h 0148 002h]              TRBE Interrupt : 100E

   [094h 0148 001h]               Subtable Type : 0E [Generic Interrupt Redistributor]
   [095h 0149 001h]                      Length : 10
   [097h 0151 002h]                    Reserved : 0000
   [098h 0152 008h]                Base Address : 00000000080A0000
   [0A0h 0160 004h]                      Length : 00F60000

  -[0A4h 0164 001h]               Subtable Type : 0F [Generic Interrupt Translator]
  -[0A5h 0165 001h]                      Length : 14
  -[0A7h 0167 002h]                    Reserved : 0000
  -[0A8h 0168 004h]              Translation ID : 00000000
  -[0ACh 0172 008h]                Base Address : 0000000008080000
  -[0B4h 0180 004h]                    Reserved : 00000000
  +Raw Table Data: Length 164 (0xA4)

  -Raw Table Data: Length 184 (0xB8)
  -
  -    0000: 41 50 49 43 B8 00 00 00 04 A7 42 4F 43 48 53 20  // APIC......BOCHS
  +    0000: 41 50 49 43 A4 00 00 00 04 EE 42 4F 43 48 53 20  // APIC......BOCHS
       0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
       0020: 01 00 00 00 00 00 00 00 00 00 00 00 0C 18 00 00  // ................
       0030: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00  // ................
       0040: 04 00 00 00 0B 50 00 00 00 00 00 00 00 00 00 00  // .....P..........
       0050: 01 00 00 00 00 00 00 00 17 00 00 00 00 00 00 00  // ................
       0060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       0070: 00 00 00 00 00 00 00 00 00 00 00 00 19 00 00 00  // ................
       0080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       0090: 00 00 00 00 0E 10 00 00 00 00 0A 08 00 00 00 00  // ................
  -    00A0: 00 00 F6 00 0F 14 00 00 00 00 00 00 00 00 08 08  // ................
  -    00B0: 00 00 00 00 00 00 00 00                          // ........
  +    00A0: 00 00 F6 00                                      // ....

   /*
    * Intel ACPI Component Architecture
    * AML/ASL+ Disassembler version 20240927 (64-bit version)
    * Copyright (c) 2000 - 2023 Intel Corporation
    *
    * Disassembly of tests/data/acpi/aarch64/virt/FACP
    *
    * ACPI Data Table [FACP]
    *
    * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
    */

   [000h 0000 004h]                   Signature : "FACP"    [Fixed ACPI Description Table (FADT)]
   [004h 0004 004h]                Table Length : 00000114
   [008h 0008 001h]                    Revision : 06
  -[009h 0009 001h]                    Checksum : 12
  +[009h 0009 001h]                    Checksum : 14
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
  @@ -82,35 +82,35 @@
                        Use Platform Timer (V4) : 0
                  RTC_STS valid on S4 wake (V4) : 0
                   Remote Power-on capable (V4) : 0
                    Use APIC Cluster Model (V4) : 0
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
  -[081h 0129 002h]   ARM Flags (decoded below) : 0003
  +[081h 0129 002h]   ARM Flags (decoded below) : 0001
                                 PSCI Compliant : 1
  -                       Must use HVC for PSCI : 1
  +                       Must use HVC for PSCI : 0

   [083h 0131 001h]         FADT Minor Revision : 03
   [084h 0132 008h]                FACS Address : 0000000000000000
   [08Ch 0140 008h]                DSDT Address : 0000000000000000
   [094h 0148 00Ch]            PM1A Event Block : [Generic Address Structure]
   [094h 0148 001h]                    Space ID : 00 [SystemMemory]
   [095h 0149 001h]                   Bit Width : 00
   [096h 0150 001h]                  Bit Offset : 00
   [097h 0151 001h]        Encoded Access Width : 00 [Undefined/Legacy]
   [098h 0152 008h]                     Address : 0000000000000000

   [0A0h 0160 00Ch]            PM1B Event Block : [Generic Address Structure]
   [0A0h 0160 001h]                    Space ID : 00 [SystemMemory]
   [0A1h 0161 001h]                   Bit Width : 00
   [0A2h 0162 001h]                  Bit Offset : 00
   [0A3h 0163 001h]        Encoded Access Width : 00 [Undefined/Legacy]
  @@ -164,34 +164,34 @@
   [0F5h 0245 001h]                   Bit Width : 00
   [0F6h 0246 001h]                  Bit Offset : 00
   [0F7h 0247 001h]        Encoded Access Width : 00 [Undefined/Legacy]
   [0F8h 0248 008h]                     Address : 0000000000000000

   [100h 0256 00Ch]       Sleep Status Register : [Generic Address Structure]
   [100h 0256 001h]                    Space ID : 00 [SystemMemory]
   [101h 0257 001h]                   Bit Width : 00
   [102h 0258 001h]                  Bit Offset : 00
   [103h 0259 001h]        Encoded Access Width : 00 [Undefined/Legacy]
   [104h 0260 008h]                     Address : 0000000000000000

   [10Ch 0268 008h]               Hypervisor ID : 00000000554D4551

   Raw Table Data: Length 276 (0x114)

  -    0000: 46 41 43 50 14 01 00 00 06 12 42 4F 43 48 53 20  // FACP......BOCHS
  +    0000: 46 41 43 50 14 01 00 00 06 14 42 4F 43 48 53 20  // FACP......BOCHS
       0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
       0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       0040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       0050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       0060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       0070: 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
  -    0080: 00 03 00 03 00 00 00 00 00 00 00 00 00 00 00 00  // ................
  +    0080: 00 01 00 03 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       0090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       00A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       00B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       00C0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       00D0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       00E0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       00F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
       0100: 00 00 00 00 00 00 00 00 00 00 00 00 51 45 4D 55  // ............QEMU
       0110: 00 00 00 00                                      // ....

  @@ -1,122 +1,111 @@
   /*
    * Intel ACPI Component Architecture
    * AML/ASL+ Disassembler version 20240927 (64-bit version)
    * Copyright (c) 2000 - 2023 Intel Corporation
    *
    * Disassembly of tests/data/acpi/aarch64/virt/IORT.its_off
    *
    * ACPI Data Table [IORT]
    *
    * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
    */

   [000h 0000 004h]                   Signature : "IORT"    [IO Remapping Table]
  -[004h 0004 004h]                Table Length : 000000EC
  +[004h 0004 004h]                Table Length : 000000D4
   [008h 0008 001h]                    Revision : 03
  -[009h 0009 001h]                    Checksum : 57
  +[009h 0009 001h]                    Checksum : A3
   [00Ah 0010 006h]                      Oem ID : "BOCHS "
   [010h 0016 008h]                Oem Table ID : "BXPC    "
   [018h 0024 004h]                Oem Revision : 00000001
   [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
   [020h 0032 004h]       Asl Compiler Revision : 00000001

   [024h 0036 004h]                  Node Count : 00000003
   [028h 0040 004h]                 Node Offset : 00000030
   [02Ch 0044 004h]                    Reserved : 00000000

  -[030h 0048 001h]                        Type : 00
  -[031h 0049 002h]                      Length : 0018
  -[033h 0051 001h]                    Revision : 01
  +[030h 0048 001h]                        Type : 04
  +[031h 0049 002h]                      Length : 0058
  +[033h 0051 001h]                    Revision : 04
   [034h 0052 004h]                  Identifier : 00000000
  -[038h 0056 004h]               Mapping Count : 00000000
  -[03Ch 0060 004h]              Mapping Offset : 00000000
  +[038h 0056 004h]               Mapping Count : 00000001
  +[03Ch 0060 004h]              Mapping Offset : 00000044

  -[040h 0064 004h]                    ItsCount : 00000001
  -[044h 0068 004h]                 Identifiers : 00000000
  -
  -[048h 0072 001h]                        Type : 04
  -[049h 0073 002h]                      Length : 0058
  -[04Bh 0075 001h]                    Revision : 04
  -[04Ch 0076 004h]                  Identifier : 00000001
  -[050h 0080 004h]               Mapping Count : 00000001
  -[054h 0084 004h]              Mapping Offset : 00000044
  -
  -[058h 0088 008h]                Base Address : 0000000009050000
  -[060h 0096 004h]       Flags (decoded below) : 00000001
  +[040h 0064 008h]                Base Address : 0000000009050000
  +[048h 0072 004h]       Flags (decoded below) : 00000001
                                COHACC Override : 1
                                  HTTU Override : 0
                         Proximity Domain Valid : 0
                                 DeviceID Valid : 0
  -[064h 0100 004h]                    Reserved : 00000000
  -[068h 0104 008h]               VATOS Address : 0000000000000000
  -[070h 0112 004h]                       Model : 00000000
  -[074h 0116 004h]                  Event GSIV : 0000006A
  -[078h 0120 004h]                    PRI GSIV : 0000006B
  -[07Ch 0124 004h]                   GERR GSIV : 0000006D
  -[080h 0128 004h]                   Sync GSIV : 0000006C
  -[084h 0132 004h]            Proximity Domain : 00000000
  -[088h 0136 004h]     Device ID Mapping Index : 00000000
  +[04Ch 0076 004h]                    Reserved : 00000000
  +[050h 0080 008h]               VATOS Address : 0000000000000000
  +[058h 0088 004h]                       Model : 00000000
  +[05Ch 0092 004h]                  Event GSIV : 0000006A
  +[060h 0096 004h]                    PRI GSIV : 0000006B
  +[064h 0100 004h]                   GERR GSIV : 0000006D
  +[068h 0104 004h]                   Sync GSIV : 0000006C
  +[06Ch 0108 004h]            Proximity Domain : 00000000
  +[070h 0112 004h]     Device ID Mapping Index : 00000000

  -[08Ch 0140 004h]                  Input base : 00000000
  -[090h 0144 004h]                    ID Count : 0000FFFF
  -[094h 0148 004h]                 Output Base : 00000000
  -[098h 0152 004h]            Output Reference : 00000030
  -[09Ch 0156 004h]       Flags (decoded below) : 00000000
  +[074h 0116 004h]                  Input base : 00000000
  +[078h 0120 004h]                    ID Count : 0000FFFF
  +[07Ch 0124 004h]                 Output Base : 00000000
  +[080h 0128 004h]            Output Reference : 00000030
  +[084h 0132 004h]       Flags (decoded below) : 00000000
                                 Single Mapping : 0

  -[0A0h 0160 001h]                        Type : 02
  -[0A1h 0161 002h]                      Length : 004C
  -[0A3h 0163 001h]                    Revision : 03
  -[0A4h 0164 004h]                  Identifier : 00000002
  -[0A8h 0168 004h]               Mapping Count : 00000002
  -[0ACh 0172 004h]              Mapping Offset : 00000024
  +[088h 0136 001h]                        Type : 02
  +[089h 0137 002h]                      Length : 004C
  +[08Bh 0139 001h]                    Revision : 03
  +[08Ch 0140 004h]                  Identifier : 00000001
  +[090h 0144 004h]               Mapping Count : 00000002
  +[094h 0148 004h]              Mapping Offset : 00000024

  -[0B0h 0176 008h]           Memory Properties : [IORT Memory Access Properties]
  -[0B0h 0176 004h]             Cache Coherency : 00000001
  -[0B4h 0180 001h]       Hints (decoded below) : 00
  +[098h 0152 008h]           Memory Properties : [IORT Memory Access Properties]
  +[098h 0152 004h]             Cache Coherency : 00000001
  +[09Ch 0156 001h]       Hints (decoded below) : 00
                                      Transient : 0
                                 Write Allocate : 0
                                  Read Allocate : 0
                                       Override : 0
  -[0B5h 0181 002h]                    Reserved : 0000
  -[0B7h 0183 001h] Memory Flags (decoded below) : 03
  +[09Dh 0157 002h]                    Reserved : 0000
  +[09Fh 0159 001h] Memory Flags (decoded below) : 03
                                      Coherency : 1
                               Device Attribute : 1
                  Ensured Coherency of Accesses : 0
  -[0B8h 0184 004h]               ATS Attribute : 00000000
  -[0BCh 0188 004h]          PCI Segment Number : 00000000
  -[0C0h 0192 001h]           Memory Size Limit : 40
  -[0C1h 0193 002h]          PASID Capabilities : 0000
  -[0C3h 0195 001h]                    Reserved : 00
  +[0A0h 0160 004h]               ATS Attribute : 00000000
  +[0A4h 0164 004h]          PCI Segment Number : 00000000
  +[0A8h 0168 001h]           Memory Size Limit : 40
  +[0A9h 0169 002h]          PASID Capabilities : 0000
  +[0ABh 0171 001h]                    Reserved : 00

  -[0C4h 0196 004h]                  Input base : 00000000
  -[0C8h 0200 004h]                    ID Count : 000000FF
  -[0CCh 0204 004h]                 Output Base : 00000000
  -[0D0h 0208 004h]            Output Reference : 00000048
  -[0D4h 0212 004h]       Flags (decoded below) : 00000000
  +[0ACh 0172 004h]                  Input base : 00000000
  +[0B0h 0176 004h]                    ID Count : 000000FF
  +[0B4h 0180 004h]                 Output Base : 00000000
  +[0B8h 0184 004h]            Output Reference : 00000030
  +[0BCh 0188 004h]       Flags (decoded below) : 00000000
                                 Single Mapping : 0

  -[0D8h 0216 004h]                  Input base : 00000100
  -[0DCh 0220 004h]                    ID Count : 0000FEFF
  -[0E0h 0224 004h]                 Output Base : 00000100
  -[0E4h 0228 004h]            Output Reference : 00000030
  -[0E8h 0232 004h]       Flags (decoded below) : 00000000
  +[0C0h 0192 004h]                  Input base : 00000100
  +[0C4h 0196 004h]                    ID Count : 0000FEFF
  +[0C8h 0200 004h]                 Output Base : 00000100
  +[0CCh 0204 004h]            Output Reference : 00000030
  +[0D0h 0208 004h]       Flags (decoded below) : 00000000
                                 Single Mapping : 0

  -Raw Table Data: Length 236 (0xEC)
  +Raw Table Data: Length 212 (0xD4)

  -    0000: 49 4F 52 54 EC 00 00 00 03 57 42 4F 43 48 53 20  // IORT.....WBOCHS
  +    0000: 49 4F 52 54 D4 00 00 00 03 A3 42 4F 43 48 53 20  // IORT......BOCHS
       0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
       0020: 01 00 00 00 03 00 00 00 30 00 00 00 00 00 00 00  // ........0.......
  -    0030: 00 18 00 01 00 00 00 00 00 00 00 00 00 00 00 00  // ................
  -    0040: 01 00 00 00 00 00 00 00 04 58 00 04 01 00 00 00  // .........X......
  -    0050: 01 00 00 00 44 00 00 00 00 00 05 09 00 00 00 00  // ....D...........
  -    0060: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
  -    0070: 00 00 00 00 6A 00 00 00 6B 00 00 00 6D 00 00 00  // ....j...k...m...
  -    0080: 6C 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // l...............
  -    0090: FF FF 00 00 00 00 00 00 30 00 00 00 00 00 00 00  // ........0.......
  -    00A0: 02 4C 00 03 02 00 00 00 02 00 00 00 24 00 00 00  // .L..........$...
  -    00B0: 01 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00  // ................
  -    00C0: 40 00 00 00 00 00 00 00 FF 00 00 00 00 00 00 00  // @...............
  -    00D0: 48 00 00 00 00 00 00 00 00 01 00 00 FF FE 00 00  // H...............
  -    00E0: 00 01 00 00 30 00 00 00 00 00 00 00              // ....0.......
  +    0030: 04 58 00 04 00 00 00 00 01 00 00 00 44 00 00 00  // .X..........D...
  +    0040: 00 00 05 09 00 00 00 00 01 00 00 00 00 00 00 00  // ................
  +    0050: 00 00 00 00 00 00 00 00 00 00 00 00 6A 00 00 00  // ............j...
  +    0060: 6B 00 00 00 6D 00 00 00 6C 00 00 00 00 00 00 00  // k...m...l.......
  +    0070: 00 00 00 00 00 00 00 00 FF FF 00 00 00 00 00 00  // ................
  +    0080: 30 00 00 00 00 00 00 00 02 4C 00 03 01 00 00 00  // 0........L......
  +    0090: 02 00 00 00 24 00 00 00 01 00 00 00 00 00 00 03  // ....$...........
  +    00A0: 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00  // ........@.......
  +    00B0: FF 00 00 00 00 00 00 00 30 00 00 00 00 00 00 00  // ........0.......
  +    00C0: 00 01 00 00 FF FE 00 00 00 01 00 00 30 00 00 00  // ............0...
  +    00D0: 00 00 00 00                                      // ....

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   3 ---
 tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 184 -> 164 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off   | Bin 236 -> 212 bytes
 3 files changed, 3 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 3421dd5adf3..dfb8523c8bf 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,4 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/APIC.its_off",
-"tests/data/acpi/aarch64/virt/FACP.its_off",
-"tests/data/acpi/aarch64/virt/IORT.its_off",
diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/acpi/aarch64/virt/APIC.its_off
index c37d05d6e05805304f10afe73eb7cb9100fcccfa..f24ac8fbff5261a52434abcfcff96dbdc7709de4 100644
GIT binary patch
delta 18
ZcmdnNxP+0*F~HM#2?GNI%e#qOvj8xy1yKM1

delta 39
jcmZ3&xPy_)F~HM#2Ll5G%kqg_vqbnsfJ`vp;DE6Jpmzmj

diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/acpi/aarch64/virt/IORT.its_off
index 0fceb820d509e852ca0849baf568a8e93e426738..25f64407c4aac11bda2d1ac24cd8999a1d84c80d 100644
GIT binary patch
delta 37
tcmaFEc!iP6(?2NW3IhWJ^WuqIYOE{~3@i*2eZv_UCoa`yG?;i%8UVn-3Gn~`

delta 61
zcmcb@_=b_o(?2NW4FdxMbNECqHCYA;21XzU4qzOX2nH6$iKgL<OcQ&x89gTMlm-Aj
CGzq}~

-- 
2.47.1


