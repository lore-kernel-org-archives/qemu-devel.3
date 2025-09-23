Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8343CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 07:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0x5b-00023O-7o; Tue, 23 Sep 2025 03:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1v0x50-0001Bi-Rq; Tue, 23 Sep 2025 03:04:52 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1v0x4v-0007Ny-1G; Tue, 23 Sep 2025 03:04:50 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D743344D04;
 Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AA4C2BCB7;
 Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758611060;
 bh=L9jxD+FZIhsxn7Pfow4s+joyvFjeOnZaLFxQf4dUfS8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WxKuBonU7cUu35eG0thLOhEcYIQW9Mc9z7HfnVNQiV8EMbnWNpMRm6h2frN5j9LCr
 AGvRA0lsZpesVoRSy7emdNEv+W18n65z3vaNc9SzCxNpQ2HGaAcHU5Nt1XAFH9ebx0
 BTPLG+ZAHeuqsIepi+RHL/p7kq3psdG4oTfVEJrz3oGpUdsFAdLSJddkMswq2QWSn7
 HM4qx+8b8sUdl/dd07l/At+Lh8b+J9x5Fc9rhdOi0YE0+lryBnxZf4UJIWIr2L8mwt
 1Z5BO8am2lVE2SaVrGgY4ZErV7eZDFib6WWRU2nv4YcPHrd7nDJj2yBuDt68QUV2iw
 pivePCjXAh5uw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1v0x4U-00000006bLI-2Sa1; Tue, 23 Sep 2025 09:04:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v12 15/17] tests/acpi: virt: update HEST and DSDT tables
Date: Tue, 23 Sep 2025 09:04:09 +0200
Message-ID: <2253eb50df797ab320b4ca610bd22a38e5cfd17a.1758610789.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758610789.git.mchehab+huawei@kernel.org>
References: <cover.1758610789.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

    --- /tmp/DSDT_old.dsl   2025-09-05 15:03:18.964968499 +0200
    +++ /tmp/DSDT.dsl       2025-09-05 15:03:18.966968470 +0200
    @@ -5,13 +5,13 @@
      *
      * Disassembling to symbolic ASL+ operators
      *
    - * Disassembly of /tmp/DSDT_old
    + * Disassembly of /tmp/DSDT
      *
      * Original Table Header:
      *     Signature        "DSDT"
    - *     Length           0x000014AD (5293)
    + *     Length           0x000014D9 (5337)
      *     Revision         0x02
    - *     Checksum         0xEA
    + *     Checksum         0xA4
      *     OEM ID           "BOCHS "
      *     OEM Table ID     "BXPC    "
      *     OEM Revision     0x00000001 (1)
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
    --- /tmp/DSDT_acpihmatvirt_old.dsl      2025-09-05 15:03:18.979897760 +0200
    +++ /tmp/DSDT_acpihmatvirt.dsl  2025-09-05 15:03:18.980968267 +0200
    @@ -5,13 +5,13 @@
      *
      * Disassembling to symbolic ASL+ operators
      *
    - * Disassembly of /tmp/DSDT_acpihmatvirt_old
    + * Disassembly of /tmp/DSDT_acpihmatvirt
      *
      * Original Table Header:
      *     Signature        "DSDT"
    - *     Length           0x00001503 (5379)
    + *     Length           0x0000152F (5423)
      *     Revision         0x02
    - *     Checksum         0xA6
    + *     Checksum         0x6F
      *     OEM ID           "BOCHS "
      *     OEM Table ID     "BXPC    "
      *     OEM Revision     0x00000001 (1)
    @@ -1904,6 +1904,11 @@
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

    @@ -1912,6 +1917,12 @@
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
    --- /tmp/DSDT_acpipcihp_old.dsl 2025-09-05 15:03:18.993968078 +0200
    +++ /tmp/DSDT_acpipcihp.dsl     2025-09-05 15:03:18.995968049 +0200
    @@ -5,13 +5,13 @@
      *
      * Disassembling to symbolic ASL+ operators
      *
    - * Disassembly of /tmp/DSDT_acpipcihp_old
    + * Disassembly of /tmp/DSDT_acpipcihp
      *
      * Original Table Header:
      *     Signature        "DSDT"
    - *     Length           0x0000183A (6202)
    + *     Length           0x00001866 (6246)
      *     Revision         0x02
    - *     Checksum         0x98
    + *     Checksum         0x70
      *     OEM ID           "BOCHS "
      *     OEM Table ID     "BXPC    "
      *     OEM Revision     0x00000001 (1)
    @@ -1893,6 +1893,11 @@
                         \_SB.PCI0.PCNT ()
                         Release (\_SB.PCI0.BLCK)
                     }
    +
    +                If (((Local0 & 0x20) == 0x20))
    +                {
    +                    Notify (GEDD, 0x80) // Status Change
    +                }
                 }
             }

    @@ -1901,6 +1906,12 @@
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

         Scope (_SB.PCI0)
    --- /tmp/DSDT_hpoffacpiindex_old.dsl    2025-09-05 15:03:19.007967875 +0200
    +++ /tmp/DSDT_hpoffacpiindex.dsl        2025-09-05 15:03:19.009967846 +0200
    @@ -5,13 +5,13 @@
      *
      * Disassembling to symbolic ASL+ operators
      *
    - * Disassembly of /tmp/DSDT_hpoffacpiindex_old
    + * Disassembly of /tmp/DSDT_hpoffacpiindex
      *
      * Original Table Header:
      *     Signature        "DSDT"
    - *     Length           0x000014E3 (5347)
    + *     Length           0x0000150F (5391)
      *     Revision         0x02
    - *     Checksum         0x92
    + *     Checksum         0x4B
      *     OEM ID           "BOCHS "
      *     OEM Table ID     "BXPC    "
      *     OEM Revision     0x00000001 (1)
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
    --- /tmp/DSDT_memhp_old.dsl     2025-09-05 15:03:19.022215983 +0200
    +++ /tmp/DSDT_memhp.dsl 2025-09-05 15:03:19.023967643 +0200
    @@ -5,13 +5,13 @@
      *
      * Disassembling to symbolic ASL+ operators
      *
    - * Disassembly of /tmp/DSDT_memhp_old
    + * Disassembly of /tmp/DSDT_memhp
      *
      * Original Table Header:
      *     Signature        "DSDT"
    - *     Length           0x000019FE (6654)
    + *     Length           0x00001A2A (6698)
      *     Revision         0x02
    - *     Checksum         0x0B
    + *     Checksum         0xD3
      *     OEM ID           "BOCHS "
      *     OEM Table ID     "BXPC    "
      *     OEM Revision     0x00000001 (1)
    @@ -1898,6 +1898,11 @@
                     {
                         Notify (\_SB.NVDR, 0x80) // Status Change
                     }
    +
    +                If (((Local0 & 0x20) == 0x20))
    +                {
    +                    Notify (GEDD, 0x80) // Status Change
    +                }
                 }
             }

    @@ -2203,6 +2208,12 @@
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
    --- /tmp/DSDT_pxb_old.dsl       2025-09-05 15:03:19.036967455 +0200
    +++ /tmp/DSDT_pxb.dsl   2025-09-05 15:03:19.039194754 +0200
    @@ -5,13 +5,13 @@
      *
      * Disassembling to symbolic ASL+ operators
      *
    - * Disassembly of /tmp/DSDT_pxb_old
    + * Disassembly of /tmp/DSDT_pxb
      *
      * Original Table Header:
      *     Signature        "DSDT"
    - *     Length           0x00001E58 (7768)
    + *     Length           0x00001E84 (7812)
      *     Revision         0x02
    - *     Checksum         0x4A
    + *     Checksum         0x13
      *     OEM ID           "BOCHS "
      *     OEM Table ID     "BXPC    "
      *     OEM Revision     0x00000001 (1)
    @@ -3071,6 +3071,11 @@
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

    @@ -3079,6 +3084,12 @@
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
    --- /tmp/DSDT_topology_old.dsl  2025-09-05 15:03:19.050967252 +0200
    +++ /tmp/DSDT_topology.dsl      2025-09-05 15:03:19.052967223 +0200
    @@ -5,13 +5,13 @@
      *
      * Disassembling to symbolic ASL+ operators
      *
    - * Disassembly of /tmp/DSDT_topology_old
    + * Disassembly of /tmp/DSDT_topology
      *
      * Original Table Header:
      *     Signature        "DSDT"
    - *     Length           0x00001577 (5495)
    + *     Length           0x000015A3 (5539)
      *     Revision         0x02
    - *     Checksum         0xCF
    + *     Checksum         0x98
      *     OEM ID           "BOCHS "
      *     OEM Table ID     "BXPC    "
      *     OEM Revision     0x00000001 (1)
    @@ -1928,6 +1928,11 @@
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

    @@ -1936,6 +1941,12 @@
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
    --- /tmp/DSDT_viot_old.dsl      2025-09-05 15:03:19.064967049 +0200
    +++ /tmp/DSDT_viot.dsl  2025-09-05 15:03:19.067236085 +0200
    @@ -5,13 +5,13 @@
      *
      * Disassembling to symbolic ASL+ operators
      *
    - * Disassembly of /tmp/DSDT_viot_old
    + * Disassembly of /tmp/DSDT_viot
      *
      * Original Table Header:
      *     Signature        "DSDT"
    - *     Length           0x000014BE (5310)
    + *     Length           0x000014EA (5354)
      *     Revision         0x02
    - *     Checksum         0x8C
    + *     Checksum         0x46
      *     OEM ID           "BOCHS "
      *     OEM Table ID     "BXPC    "
      *     OEM Revision     0x00000001 (1)
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
---
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5293 -> 5337 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5379 -> 5423 bytes
 tests/data/acpi/aarch64/virt/DSDT.acpipcihp   | Bin 6202 -> 6246 bytes
 .../acpi/aarch64/virt/DSDT.hpoffacpiindex     | Bin 5347 -> 5391 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6654 -> 6698 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7768 -> 7812 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5495 -> 5539 bytes
 tests/data/acpi/aarch64/virt/DSDT.viot        | Bin 5310 -> 5354 bytes
 tests/data/acpi/aarch64/virt/HEST             | Bin 132 -> 224 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |   9 ---------
 10 files changed, 9 deletions(-)

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

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 45f256946751..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,10 +1 @@
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
-- 
2.51.0


