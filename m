Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832BECAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFd-0003NW-IJ; Sun, 05 Oct 2025 15:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEP-0007y0-Hq
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEK-0006Ti-PX
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MCh7a2KtkUaaSGsInrqfUkf7JBaKZj7e2ekOGZtPcVA=;
 b=K53j4IFaspCg8JIIn7js9K+hWxs5X0ytzXNxh5UOqwc28V9ic4p5CjleQzFCUjjyXhPXSZ
 iw55+Ez8R3QgZbRySexD67JxXUl1k9L35KsrsugsI9HnP+yosHcjZoXq71V9yz/4sT5OVP
 7w2QfTucPglRaiQZuBzxgLZh6/l4plg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-cD2Ro_DNO3mFYSEHTLXeaQ-1; Sun, 05 Oct 2025 15:17:10 -0400
X-MC-Unique: cD2Ro_DNO3mFYSEHTLXeaQ-1
X-Mimecast-MFC-AGG-ID: cD2Ro_DNO3mFYSEHTLXeaQ_1759691829
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ed9557f976so2674242f8f.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691829; x=1760296629;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCh7a2KtkUaaSGsInrqfUkf7JBaKZj7e2ekOGZtPcVA=;
 b=Ag/KpG2WBS+Gugm5vyN9yn2Je8wmEXLDCIvUf/0nmdNdsgFX1zzqTKJhkizucukeLe
 pxPfcghfaDaS72TfDiylJusTGoQ1NJXnUx6FbpvvZKj8Wkaxsk8sXkmBccr0bkq6ax/Y
 7vKu6dYkanH+XNgUH+nc5Vh5amj3UOKDWRG6WvHn24v/jQ/yhi+TMwSHAuZ0g794bCOo
 rTpR7rf8sOHB6n2TYpqrGT3NhxGmmBQBk5RyTXTiIAtuqw17smMHXetPWF+mb49/7Yrg
 kumeiYGcSF8o+NE/HS7s6VuUwJl0HnN3p1mmLK/IhXyF2IWRKQioTXdMO+hKiSoQrQI7
 CsIw==
X-Gm-Message-State: AOJu0Yxads8pXqajyT1CLDBnG3wPO2mvn+aNZVRa4U/IPbcu5sJprMan
 cUaN5AM9uk1+Xwg10/RncxDMLtqF6p2rXIX5VuXltfioVYzaRpz3e9g7vVYbEnjV5wsccv7cE1O
 trU3GRVKkhC8a80j9BoBQDD/hofFoOuxRPTpokvoLe9nq6xBo30yyLdQcqPDUEhunQoaPyeYInU
 8b3OVDQMM0xPU7+8azvGDWcWyt4/0jDPeFDg==
X-Gm-Gg: ASbGncuHsmDUgGTQELBMMNNemr5+b3GMYee5T2BJN32OAeUbAJLUSDQdKgKxrTFi8cV
 3tVzDs88ndUo3BxWFpgU8EBEQ2lyy2IynzFMTBY5ZKa8TwCcLqGAjOUOs1xGz3KZnCZvn5h1AgC
 2+5Mwrcwqr5eaq6cYELJ3C2rQsDgBpo7NqXPM/OncKKqPmXMdUilM/ti9ut/xzXkdltWw6Ed6YB
 Bb862BmcUhe+M0RNYZ0jED80iFkt3VSQlw53FsD37cg9l5+FCF1Jo5Kgf5WnnQ6uhL92C654dx/
 3rn152F1/LVOi7TD/yER1PplBrbBBOqlGzioi2M=
X-Received: by 2002:a05:6000:2910:b0:3ee:1118:df7d with SMTP id
 ffacd0b85a97d-425671c0c93mr6123612f8f.47.1759691828921; 
 Sun, 05 Oct 2025 12:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmvAo0c00EdoK7uv/IYZud2I4A7bP4NWzWFLBlJlbr3yWAXE9XXIpsdk13hA4iN6S7JDG+Nw==
X-Received: by 2002:a05:6000:2910:b0:3ee:1118:df7d with SMTP id
 ffacd0b85a97d-425671c0c93mr6123596f8f.47.1759691828309; 
 Sun, 05 Oct 2025 12:17:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9780sm17257442f8f.29.2025.10.05.12.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:07 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 29/75] tests/acpi: virt: update HEST and DSDT tables
Message-ID: <237ca3d57898e4438bc3af6cd87f0a3279198bae.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The following changes for DSDT affecting all files
under tests/data/acpi/aarch64/virt/DSDT* :

    -"tests/data/acpi/aarch64/virt/DSDT",
    -"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
    -"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
    -"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
    -"tests/data/acpi/aarch64/virt/DSDT.memhp",
    -"tests/data/acpi/aarch64/virt/DSDT.pxb",
    -"tests/data/acpi/aarch64/virt/DSDT.topology",
    -"tests/data/acpi/aarch64/virt/DSDT.viot",
    -"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
    -"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",

    --- /tmp/DSDT_old.dsl   2025-09-05 15:03:18.964968499 +0200
    +++ /tmp/DSDT.dsl       2025-09-05 15:03:18.966968470 +0200
    @@ -1886,6 +1886,11 @@
                     {
                         Notify (PWRB, 0x80) // Status Change
                     }
    +
    +                If (((Local0 & 0x20) == 0x20))
    +                {
    +                    Notify (GEDD, 0x80) // Status Change
    +                }
                 }
             }

    @@ -1894,6 +1899,12 @@
                 Name (_HID, "PNP0C0C" /* Power Button Device */)  // _HID: Hardware ID
                 Name (_UID, Zero)  // _UID: Unique ID
             }
    +
    +        Device (GEDD)
    +        {
    +            Name (_HID, "PNP0C33" /* Error Device */)  // _HID: Hardware ID
    +            Name (_UID, Zero)  // _UID: Unique ID
    +        }
         }

         Scope (\_SB.PCI0)

Additionally, HEST changes:
    -"tests/data/acpi/aarch64/virt/HEST",

    --- /tmp/HEST_old.dsl   2025-09-05 15:03:19.078653625 +0200
    +++ /tmp/HEST.dsl       2025-09-05 15:03:19.079511472 +0200
    @@ -3,7 +3,7 @@
      * AML/ASL+ Disassembler version 20240322 (64-bit version)
      * Copyright (c) 2000 - 2023 Intel Corporation
      *
    - * Disassembly of /tmp/HEST_old
    + * Disassembly of /tmp/HEST
      *
      * ACPI Data Table [HEST]
      *
    @@ -11,16 +11,16 @@
      */

     [000h 0000 004h]                   Signature : "HEST"    [Hardware Error Source Table]
    -[004h 0004 004h]                Table Length : 00000084
    +[004h 0004 004h]                Table Length : 000000E0
     [008h 0008 001h]                    Revision : 01
    -[009h 0009 001h]                    Checksum : E2
    +[009h 0009 001h]                    Checksum : 6C
     [00Ah 0010 006h]                      Oem ID : "BOCHS "
     [010h 0016 008h]                Oem Table ID : "BXPC    "
     [018h 0024 004h]                Oem Revision : 00000001
     [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
     [020h 0032 004h]       Asl Compiler Revision : 00000001

    -[024h 0036 004h]          Error Source Count : 00000001
    +[024h 0036 004h]          Error Source Count : 00000002

     [028h 0040 002h]               Subtable Type : 000A [Generic Hardware Error Source V2]
     [02Ah 0042 002h]                   Source Id : 0000
    @@ -55,19 +55,62 @@
     [069h 0105 001h]                   Bit Width : 40
     [06Ah 0106 001h]                  Bit Offset : 00
     [06Bh 0107 001h]        Encoded Access Width : 04 [QWord Access:64]
    -[06Ch 0108 008h]                     Address : 0000000043DA0008
    +[06Ch 0108 008h]                     Address : 0000000043DA0010

     [074h 0116 008h]           Read Ack Preserve : FFFFFFFFFFFFFFFE
     [07Ch 0124 008h]              Read Ack Write : 0000000000000001

    -Raw Table Data: Length 132 (0x84)
    +[084h 0132 002h]               Subtable Type : 000A [Generic Hardware Error Source V2]
    +[086h 0134 002h]                   Source Id : 0001
    +[088h 0136 002h]           Related Source Id : FFFF
    +[08Ah 0138 001h]                    Reserved : 00
    +[08Bh 0139 001h]                     Enabled : 01
    +[08Ch 0140 004h]      Records To Preallocate : 00000001
    +[090h 0144 004h]     Max Sections Per Record : 00000001
    +[094h 0148 004h]         Max Raw Data Length : 00000400
    +
    +[098h 0152 00Ch]        Error Status Address : [Generic Address Structure]
    +[098h 0152 001h]                    Space ID : 00 [SystemMemory]
    +[099h 0153 001h]                   Bit Width : 40
    +[09Ah 0154 001h]                  Bit Offset : 00
    +[09Bh 0155 001h]        Encoded Access Width : 04 [QWord Access:64]
    +[09Ch 0156 008h]                     Address : 0000000043DA0008
    +
    +[0A4h 0164 01Ch]                      Notify : [Hardware Error Notification Structure]
    +[0A4h 0164 001h]                 Notify Type : 07 [GPIO]
    +[0A5h 0165 001h]               Notify Length : 1C
    +[0A6h 0166 002h]  Configuration Write Enable : 0000
    +[0A8h 0168 004h]                PollInterval : 00000000
    +[0ACh 0172 004h]                      Vector : 00000000
    +[0B0h 0176 004h]     Polling Threshold Value : 00000000
    +[0B4h 0180 004h]    Polling Threshold Window : 00000000
    +[0B8h 0184 004h]       Error Threshold Value : 00000000
    +[0BCh 0188 004h]      Error Threshold Window : 00000000
    +
    +[0C0h 0192 004h]   Error Status Block Length : 00000400
    +[0C4h 0196 00Ch]           Read Ack Register : [Generic Address Structure]
    +[0C4h 0196 001h]                    Space ID : 00 [SystemMemory]
    +[0C5h 0197 001h]                   Bit Width : 40
    +[0C6h 0198 001h]                  Bit Offset : 00
    +[0C7h 0199 001h]        Encoded Access Width : 04 [QWord Access:64]
    +[0C8h 0200 008h]                     Address : 0000000043DA0018

    -    0000: 48 45 53 54 84 00 00 00 01 E2 42 4F 43 48 53 20  // HEST......BOCHS
    +[0D0h 0208 008h]           Read Ack Preserve : FFFFFFFFFFFFFFFE
    +[0D8h 0216 008h]              Read Ack Write : 0000000000000001
    +
    +Raw Table Data: Length 224 (0xE0)
    +
    +    0000: 48 45 53 54 E0 00 00 00 01 6C 42 4F 43 48 53 20  // HEST.....lBOCHS
         0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
    -    0020: 01 00 00 00 01 00 00 00 0A 00 00 00 FF FF 00 01  // ................
    +    0020: 01 00 00 00 02 00 00 00 0A 00 00 00 FF FF 00 01  // ................
         0030: 01 00 00 00 01 00 00 00 00 04 00 00 00 40 00 04  // .............@..
         0040: 00 00 DA 43 00 00 00 00 08 1C 00 00 00 00 00 00  // ...C............
         0050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    -    0060: 00 00 00 00 00 04 00 00 00 40 00 04 08 00 DA 43  // .........@.....C
    +    0060: 00 00 00 00 00 04 00 00 00 40 00 04 10 00 DA 43  // .........@.....C
         0070: 00 00 00 00 FE FF FF FF FF FF FF FF 01 00 00 00  // ................
    -    0080: 00 00 00 00                                      // ....
    +    0080: 00 00 00 00 0A 00 01 00 FF FF 00 01 01 00 00 00  // ................
    +    0090: 01 00 00 00 00 04 00 00 00 40 00 04 08 00 DA 43  // .........@.....C
    +    00A0: 00 00 00 00 07 1C 00 00 00 00 00 00 00 00 00 00  // ................
    +    00B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    +    00C0: 00 04 00 00 00 40 00 04 18 00 DA 43 00 00 00 00  // .....@.....C....
    +    00D0: FE FF FF FF FF FF FF FF 01 00 00 00 00 00 00 00  // ................

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <2253eb50df797ab320b4ca610bd22a38e5cfd17a.1758610789.git.mchehab+huawei@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h   |  11 -----------
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5293 -> 5337 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5379 -> 5423 bytes
 tests/data/acpi/aarch64/virt/DSDT.acpipcihp   | Bin 6202 -> 6246 bytes
 .../acpi/aarch64/virt/DSDT.hpoffacpiindex     | Bin 5347 -> 5391 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6654 -> 6698 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7768 -> 7812 bytes
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev  | Bin 10230 -> 10274 bytes
 .../data/acpi/aarch64/virt/DSDT.smmuv3-legacy | Bin 10230 -> 10274 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5495 -> 5539 bytes
 tests/data/acpi/aarch64/virt/DSDT.viot        | Bin 5310 -> 5354 bytes
 tests/data/acpi/aarch64/virt/HEST             | Bin 132 -> 224 bytes
 12 files changed, 11 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index cb4b0a9469..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,12 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/HEST",
-"tests/data/acpi/aarch64/virt/DSDT",
-"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
-"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
-"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
-"tests/data/acpi/aarch64/virt/DSDT.memhp",
-"tests/data/acpi/aarch64/virt/DSDT.pxb",
-"tests/data/acpi/aarch64/virt/DSDT.topology",
-"tests/data/acpi/aarch64/virt/DSDT.viot",
-"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
-"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
index 18d97e8f22979411a528705c0e314acb424bbfa5..38f01adb61e6e4704821cee5e397888bb6b7e46d 100644
GIT binary patch
delta 83
zcmZ3hc~g_iCD<k8rU(NA(~^l?(oDTh8`X=1nVdN$&lV15)SLWXScZRrz~t%#E(HcI
lg*JCr7njMLBC;aUO_CrsN4$rp3vYm5fPu5I@nm_CJ^<pE7PJ5W

delta 46
zcmcbqxmJ_QCD<iotq21H)2oSG(oBsG8`X=1nVi@s&lV15l%4!uSZ1<}i1g$jk#+z^
C-wmMv

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
index 2cef095bcc1bb404f8cd9ec77a879ed81c191875..37a9af713b94a3fd34907dc86c40aaa79e93239c 100644
GIT binary patch
delta 106
zcmZqHTCc_B66_M9FUr8cls}P6nyJ}iqxuP9CTEVxABBT;^x|E^LO2UtgI#?R76?qP
zPT*o<;9_bE2oG}NYJdnRFmNffxx2c!OpX_k6^U+=1hF~dJv?1_1N;IEoQ;hqmx}ZO
E01$>96aWAK

delta 68
zcmZ3l)vU$k66_MfEXu&Zv}_`mG*i3lM)ecIOit{RKMDs+%f`Egg>V+Q2D|zsED)Gn
YoxsJ!z{S)S5FX?-xj;mA@(Pi50D|okbpQYW

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpipcihp b/tests/data/acpi/aarch64/virt/DSDT.acpipcihp
index 8d55a877a40cb4c4dffdc70378204e12d2261a75..04427e2d8eb8d2db0a7ae3dbe546d9072406d09b 100644
GIT binary patch
delta 87
zcmdmG@XUbACD<h-O@e`esbC_PG*h?RM)e|LCP$vhvxS41eAp&`5RMdFATYT)flGmb
pOQFr()y0LYVX~))v`BQ5B#6fm@8Rjf8{ijU;B0KXIacH@GXO1n7#aWo

delta 48
zcmaE6u*-nUCD<jzN`irbX~sk@X{LVXjp{|hOb*<WXA1{2d9zObARIY4N<@0|1d(gZ
E098B=djJ3c

diff --git a/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex b/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
index 970d43f68bca060361105f70dbb00b3a25646db4..43ab60496e5a06706d4626d9e7b58b2d7e809e75 100644
GIT binary patch
delta 83
zcmaE?*{{Xr66_MfFUr8c<UNr~nyJ@mqk54rlQYNU*}}n$dXwJ^%kVD{m|UH}rNF?Y
l(B|&y;xd_2L{=oaNfN~7i1+Yx;SKN$FmN_Do-8kN1OSU26}12W

delta 46
zcmeCzdaTLi66_N4ScHLrY0^Y4X{JVpjp{|hOit{RXA1{2%1(YSEHha~M0#?N$X)<I
C3=N_H

diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
index 372ca3d7fb1e2927c7c12f97eec406d597f294ab..3c391674446167bc9c79fd5dcb1c37e80cc7bbae 100644
GIT binary patch
delta 85
zcmexoyvl^jCD<iIONxPk>GDJ_X{NsE8`X=1nVh&M&lV15@@1X;LD-9bfxzVI1TF;z
nE`>ICR~MJf79#enBGFBfAPz^oho=i~fM0-tv$65y0?9rA9#a?T

delta 48
zcmZ2w^3RydCD<k8pCkhV6Zb?eX{M&B8`X=1nH;$$&lV15@?n|$LD*}vw}>t4<i(Qh
E0BCy-)&Kwi

diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
index c2779882494e16920787b8ab7b4cb3c3b70f224b..71c632cedcca63a77a4cdde53d9bc392102687b6 100644
GIT binary patch
delta 107
zcmca%(_+iz66_MvBFDhMBs`HznyKsdM)m(POwJsWHDrSs^(NQI$~Y_#m|UH}rNF?Y
z(B|&y;=<Js-6R<h9^}Lk@8Rjf8{ijU;B4T`z!4wn>B11*BneW3BxP(od5!EE06qd8
AQ~&?~

delta 46
zcmZp%y<x-U66_KZA;-YL<Ta5?nyK%`M)m(POit{RHDrSsWhd9j%1mA<D?RzX>{0+f
CX%1!p

diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
index 53d4c07f423886d8c4b57f1da6498eef5a08b556..e8c2b376df7bddc2392945ea8cbb550b3d3b5e26 100644
GIT binary patch
delta 107
zcmez7zbJsqCD<iINrQobX~je?X{Pp)jp{vWOwJsWx2gp*>P_ZUmvLAiFu6K`OM!t)
zq0QaZ#f7UOx=Au1JjjV7-ow*{H^48zz}di=fg?WD(}f|rNfM+6Ny^xGvZeZ707Eq#
A^#A|>

delta 63
zcmZ1!@XepgCD<k8n>qsn(}Rgz(oEfj8`XQ%n4H)rZ&eFsl%33}E+Z1%BpDDM<irv0
T;pxH~;1^)vY~VaORedi2dNUIB

diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
index 53d4c07f423886d8c4b57f1da6498eef5a08b556..e8c2b376df7bddc2392945ea8cbb550b3d3b5e26 100644
GIT binary patch
delta 107
zcmez7zbJsqCD<iINrQobX~je?X{Pp)jp{vWOwJsWx2gp*>P_ZUmvLAiFu6K`OM!t)
zq0QaZ#f7UOx=Au1JjjV7-ow*{H^48zz}di=fg?WD(}f|rNfM+6Ny^xGvZeZ707Eq#
A^#A|>

delta 63
zcmZ1!@XepgCD<k8n>qsn(}Rgz(oEfj8`XQ%n4H)rZ&eFsl%33}E+Z1%BpDDM<irv0
T;pxH~;1^)vY~VaORedi2dNUIB

diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
index ebbeedc1ed30d811315c350f4cb42f8aa265af73..9f22cd3dc81efe3ebcb8caf913842a8dea910627 100644
GIT binary patch
delta 107
zcmeyawOE_WCD<iou_yxr(~OB+(oF6C8`W(@n4CE#r-}qK>P_A$BIB??U~+W=mjVNq
zLYup*iwjpnbdzL2c#soEyoaX?Z-8HbfwO@#14n$Qrwc=LlO#wDl9aLW<d-6S04<Rn
AEdT%j

delta 63
zcmZ3i{auU8CD<jTT$F)<>HI`4X{K(Ujp{ZcOit{RQ$>OqWhd_xkr9b*k_-qBa^i^h
T@O0q~@Cz_-HgKLSD%uACG~E#{

diff --git a/tests/data/acpi/aarch64/virt/DSDT.viot b/tests/data/acpi/aarch64/virt/DSDT.viot
index b897d667971500da4732000091a6f0828d05d89e..dd3775a0762ae1a5ddb89dd656d81eee581dccb6 100644
GIT binary patch
delta 83
zcmdm|`AU<^CD<k8l?Vd^liNftX{KJMjp{|hOwJsWXA1{2>P>zxEW^J*U~+W=mjVNq
lLYup*i_2tA5m}MwCP@&RBi_T)g*U)2z`)tqc(T06d;r-X7McJ6

delta 46
zcmaE*xlfbJCD<iop9lj3Q_n;$X{JVpjp{|hOit{RXA1{2%1(YSEHha~M0#?N$P55O
CpAClq

diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
index 4c5d8c5b5da5b3241f93cd0839e94272bf6b1486..674272922db7d48f7821aa7c83ec76bb3b556d2a 100644
GIT binary patch
delta 68
zcmZo+e89-%;TjzBfPsO5F=rx|6eH6_Rd+^#iMisuTnvm1|Nk>EGJ@nLCJHmL%S;Ru
WnV7)J#lXPAz`)?Zz#=g*R~!HcF%5eF

delta 29
lcmaFB*uu!=;Tjy$!oa}5_-G=R6eHtARriT=I3|_|004Ge2nqlI

-- 
MST


