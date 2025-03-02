Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53BFC19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 08:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toeb7-0006E1-C6; Sun, 02 Mar 2025 03:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1toeat-0005tC-IL; Sun, 02 Mar 2025 03:22:39 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1toeap-0005n6-Hn; Sun, 02 Mar 2025 03:22:39 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5DB9E5C5479;
 Sun,  2 Mar 2025 08:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140B0C4CEEA;
 Sun,  2 Mar 2025 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740903737;
 bh=Q1zDiSHru5jx36/kOab37P7ct0bkOD8/N7NTNjERrqs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UO4TtxsUVvD9+gl4sTKv1Y9C3FpJic2NXngEkk2DqWWvXI1hI51hZZrrLyl3gJl3k
 IXgus0o2JsnLwpW/j+xLVbmLzUzjhLYiQJ+7o8WnasDrI1k/rX3s9SjQ3Gy16eNDY7
 GrX+6Pn/FMe/IQnbc9aT2y+zkJner+/JsQOVDonCfseqAe4wXEokfRfufARJInG5Uj
 gAKUpTUita2CXsFZH4AJZI/cU7KFw939ygEwAld4tKiX1/GvA3mTZVWdVBKamI2uTv
 km/8kET3Swz82YnlSFm7B/SLNJE1j2t0n4Bvdo0aNu6eXQpKKcpxho8jdzDHEWFl67
 0op/cs5Vpg48Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1toeaU-000000043Sa-3tYk; Sun, 02 Mar 2025 09:22:14 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 17/19] tests/acpi: virt: update HEST and DSDT tables
Date: Sun,  2 Mar 2025 09:22:04 +0100
Message-ID: <4c264f403cc2b35811e9121bf4bb2c1339e0c63c.1740903110.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740903110.git.mchehab+huawei@kernel.org>
References: <cover.1740903110.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

@@ -1,39 +1,39 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/HEST
+ * Disassembly of /tmp/aml-DMPE22
  *
  * ACPI Data Table [HEST]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
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
 [02Ch 0044 002h]           Related Source Id : FFFF
 [02Eh 0046 001h]                    Reserved : 00
 [02Fh 0047 001h]                     Enabled : 01
 [030h 0048 004h]      Records To Preallocate : 00000001
 [034h 0052 004h]     Max Sections Per Record : 00000001
 [038h 0056 004h]         Max Raw Data Length : 00000400

 [03Ch 0060 00Ch]        Error Status Address : [Generic Address Structure]
 [03Ch 0060 001h]                    Space ID : 00 [SystemMemory]
 [03Dh 0061 001h]                   Bit Width : 40
 [03Eh 0062 001h]                  Bit Offset : 00
 [03Fh 0063 001h]        Encoded Access Width : 04 [QWord Access:64]
 [040h 0064 008h]                     Address : 0000000043DA0000
@@ -42,32 +42,75 @@
 [048h 0072 001h]                 Notify Type : 08 [SEA]
 [049h 0073 001h]               Notify Length : 1C
 [04Ah 0074 002h]  Configuration Write Enable : 0000
 [04Ch 0076 004h]                PollInterval : 00000000
 [050h 0080 004h]                      Vector : 00000000
 [054h 0084 004h]     Polling Threshold Value : 00000000
 [058h 0088 004h]    Polling Threshold Window : 00000000
 [05Ch 0092 004h]       Error Threshold Value : 00000000
 [060h 0096 004h]      Error Threshold Window : 00000000

 [064h 0100 004h]   Error Status Block Length : 00000400
 [068h 0104 00Ch]           Read Ack Register : [Generic Address Structure]
 [068h 0104 001h]                    Space ID : 00 [SystemMemory]
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

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT
+ * Disassembly of /tmp/aml-TNQ912
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x0000144C (5196)
+ *     Length           0x00001478 (5240)
  *     Revision         0x02
- *     Checksum         0x1B
+ *     Checksum         0x04
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -1876,27 +1876,38 @@
                     0x00000029,
                 }
             })
             OperationRegion (EREG, SystemMemory, 0x09080000, 0x04)
             Field (EREG, DWordAcc, NoLock, WriteAsZeros)
             {
                 ESEL,   32
             }

             Method (_EVT, 1, Serialized)  // _EVT: Event
             {
                 Local0 = ESEL /* \_SB_.GED_.ESEL */
                 If (((Local0 & 0x02) == 0x02))
                 {
                     Notify (PWRB, 0x80) // Status Change
                 }
+
+                If (((Local0 & 0x10) == 0x10))
+                {
+                    Notify (GEDD, 0x80) // Status Change
+                }
             }
         }

         Device (PWRB)
         {
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
 }

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5240 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5326 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6601 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7723 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5442 bytes
 tests/data/acpi/aarch64/virt/HEST             | Bin 132 -> 224 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |   6 ------
 7 files changed, 6 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
index 36d3e5d5a5e47359b6dcb3706f98b4f225677591..a182bd9d7182dccdf63c650d048c58f18505d001 100644
GIT binary patch
delta 109
zcmX@3@k4{lCD<jTLWF^ViDe>}G*h$dM)euOOwJsW4+;nC=*7E+g>V+Q2D|zsED)Gn
zoxsJ!z{S)S5FX^j)c_F?VBivHb9Z%dnXE4&D;?b=31V}^dw9C=2KWUSI2#)?aKwjt
Hx-b9$X;vI^

delta 64
zcmeyNaYlp7CD<jzM}&caNqQoeG*i3NM)euOOit{R4+;lM%f`Egg>V+Q2D|zsED)Gn
UoxsJ!z{S)S5FX?-*+E1W06%jPR{#J2

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
index e6154d0355f84fdcc51387b4db8f9ee63acae4e9..af1f2b0eb0b77a80c5bd74f201d24f71e486627f 100644
GIT binary patch
delta 110
zcmZ3ac}|ndCD<k8oCpI0)4_>c(oCIR8`a+lGdXii78eO-)SH|wBICY5U~+W=mjDBo
yK%2X(iwjpnbdzL2c#soEyoaX?Z-8HbfwO@#14n$Qrwc=LlO#wDl9aJAR0;r(tsHj%

delta 66
zcmX@7xk!`CCD<iokq83=(~XH-(oDVX8`a+lGdZzO78eO-l%1R{A|oB$BpDDM<irv0
W;pxH~;1^)vY~akm5g+R5!T<noi4jWx

diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
index 33f011d6b635035a04c0b39ce9b4e219f7ae74b7..10436ec87c4859fb84b3ecb7bba5788f38112e59 100644
GIT binary patch
delta 88
zcmbPheA1Z9CD<k8q$C3algUIbX{MH08`WnBGdXcjJ}4Z_<jXo)OvH<SfxzVI1TFyv
qE`c_8R~MJfaU%At($P(lAPz^oho=i~fM0-tv#~J)M|`NK3j+W#;TF9B

delta 44
zcmX?UJlB}ZCD<iot|S8klg&gfX{L_p8`WnBGdXfiJ}4Z_<ij#qOvGz*p@=Oj039?8
AE&u=k

diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
index c0fdc6e9c1396cc2259dc4bc665ba023adcf4c9b..0524b3cbe00bfe552de824dd1090bd00a208c527 100644
GIT binary patch
delta 110
zcmexwz1oJ$CD<iITaJN&sbC_PG*jDyjq2XAOwJsWOJsu?^(LQ?m2qDnFu6K`OMrn(
ypv~RY#f7UOx=Au1JjjV7-ow*{H^48zz}di=fg?WD(}f|rNfM+6Ny^w5Dg^+WYaFrw

delta 66
zcmZ2&^WU1wCD<k8zbpd-Q^!OuX{N5b8`ZsKnVi@sm&gV)%1%BZD<d7<BpDDM<irv0
W;pxH~;1^)vY~akm5g+R5!T<oNArgiF

diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
index 029d03eecc4efddc001e5377e85ac8e831294362..8c0423fe62d6950f9098983d86bfee256d7d003a 100644
GIT binary patch
delta 86
zcmbQHbx4cLCD<jzNtA(s>E%Q&X{O%5jp|7vOwJsWyG4Q-^(NmJk>Ot;Fu6K`OMrn(
opv~RY#bxqO5n1WzCP@&RBi_T)g*U)2z`)tqn1Lfc)YF9l01l28<p2Nx

delta 42
ycmX@4HBF1lCD<iIOq79viGL!OG*hGhM)f2SCMWjE-6Fw^vXk$N$V}!Dl?DLb(h64q

diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
index 4c5d8c5b5da5b3241f93cd0839e94272bf6b1486..674272922db7d48f7821aa7c83ec76bb3b556d2a 100644
GIT binary patch
delta 68
zcmZo+e89-%;TjzBfPsO5F=rx|6eH6_Rd+^#iMisuTnvm1|Nk>EGJ@nLCJHmL%S;Ru
WnV7)J#lXPAz`)?Zz#=g*R~!HcF%5eF

delta 29
lcmaFB*uu!=;Tjy$!oa}5_-G=R6eHtARriT=I3|_|004Ge2nqlI

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 0a1a26543ba2..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,7 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/HEST",
-"tests/data/acpi/aarch64/virt/DSDT",
-"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
-"tests/data/acpi/aarch64/virt/DSDT.memhp",
-"tests/data/acpi/aarch64/virt/DSDT.pxb",
-"tests/data/acpi/aarch64/virt/DSDT.topology",
-- 
2.48.1


