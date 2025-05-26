Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E15CC54FC6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQRy-0004HL-K3; Mon, 26 May 2025 01:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJQRd-0002vt-D1
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:32:19 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJQRa-0002Kz-K1
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:32:16 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-87dfd390745so376121241.1
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748237533; x=1748842333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOCs6sIHFoENBFWNyjNWt4Qbm+G3lxVEjRLR6eqMmps=;
 b=xKjRl2LznR2O9lSI6AdoITtgWl5YPxU+TwLG8JYpKKexJhFva2OL/OAzb1WUt+uHG+
 8kYi6T0YV+n9QJLjFQir0UTmmtfKJULxZcUHnZH9WbWhhNe67m/2N9oruHobQkpBLnIb
 LjwX3AMh8xnXrHMqARnKef0FIk77Sk2h4Zg93pDHopir9PfvARgyCGnUhbCdsoSxROpy
 euSCAupULulme4VEy7IpxsOupmCLdNrNGJCS60x1lSM5I5LUOAOIscnBj4J9O/RfpA8R
 W+74T+FTEjmbbE0eGerwEPDvyFNYI1sOkcECBiUSHXPCU8h2strdbe4K/E3bih3Y0IiT
 de+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237533; x=1748842333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qOCs6sIHFoENBFWNyjNWt4Qbm+G3lxVEjRLR6eqMmps=;
 b=J6E5r1ghAvJzi080TOi5RbSq2LHlPOpWnNxYUhvVMOBo0dK++YEoYBRUbcnkl8cQEo
 90GCpuE4dKXXA9ojzCreNBF22W/+M9H2sxDlYXEf8ChSgyfY6jAUH2HmX1DN8e1YBg+C
 FsloSeI0YGtD43zEj2NITy6jExHUWLb2CPpYsuaz89KfBE7XgLOApnXDdl7ZWPSfXrms
 HS2oqnm3DUgHk+GcM4UWGaWO7DGdqLJiTdwC3ZmMVR71qm50J8VOirFCfUn+6ZTs2p9i
 M9Mu9ubUtAssXLstmq6MBqAoPqv5sQEcEwM4fCVb5HeKVl2f6DG9h61S2JyMGD8OhLgq
 njrg==
X-Gm-Message-State: AOJu0Yxbfd0Pgar5tmC/TC0Iqzy6ulRru2K7bS5M2GhSR5FFVO2uA4Ui
 oTUgCw2QJeK2e/3qquqcmAU8/CuamK3FW9m1W76hMePIXx10rRxl0MFrvkb2jdQX/qvSA+m8ZZJ
 nPg6kJ1E=
X-Gm-Gg: ASbGnctq6eNspApJTKsoZ8CFlHMHC/8Tb0zF8qFI+M5UBftsFG145oamMvPF4r74bx4
 v7ktpRSasLDUkPTpIX326q7PK4PzX/sJe5dMMlJc/agmJ8fNCwCWDoBXhbIzqw6l8KuBljAMNqQ
 q2Ii+Bva3uBkWHED3/xs1hyjDkUt1CpE+e6c3eSP2gm3WIyTQKEEqdNzdK5R3vSshmpoeUMkBJC
 hwHaTa4WItDO8+998AWbVt1uxWJsg/C9V3WuXoRxRsqGFpeCyBQD5dWZARwNPN7PNTVhi3VpNK9
 k2fJXi3PM/6+Dfh52BZtQil/Pe7QgyYoN9yhSZSLZvLxGmWODrUhd6bZ1zzUaLd0T8kiVI7I4ws
 zj4iSKJNc663FPb0gdDsciw==
X-Google-Smtp-Source: AGHT+IFT2zT3HAIPKWzDmM1J5YoKESeOMuAwH5LxDKXRnJmFa6uv20iY/UesUdYTxqQ2LSEJW3lJqQ==
X-Received: by 2002:a05:6102:3a08:b0:4bb:c24b:b658 with SMTP id
 ada2fe7eead31-4e424164587mr5887613137.18.1748237533030; 
 Sun, 25 May 2025 22:32:13 -0700 (PDT)
Received: from gromero0.. (200-100-75-183.dial-up.telesp.net.br.
 [200.100.75.183]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e454da4378sm784310137.17.2025.05.25.22.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 22:32:12 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	eric.auger@redhat.com
Cc: qemu-arm@nongnu.org, thuth@redhat.com, gustavo.romero@linaro.org,
 alex.bennee@linaro.org, mst@redhat.com, imammedo@redhat.com
Subject: [PATCH 5/5] qtest/bios-tables-test: Update aarch64/virt 'acpipcihp'
 variant blob
Date: Mon, 26 May 2025 05:31:23 +0000
Message-Id: <20250526053123.1434204-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526053123.1434204-1-gustavo.romero@linaro.org>
References: <20250526053123.1434204-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ua1-x929.google.com
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

Update the .acpipcihp blob variant for the aarch64 'virt' machine. Since
this is a new blob, the diff is large and not particularly useful, so
below is the diff against the base DSDT blob with ACPI PCI off.

Main changes include:

a) The _OSC method, which now allows the platform to control PCIe
   hotplug (masking Local0 against 0x1E), whereas previously it was
   controlled by the OS;
b) New regions in _SB.PCI0 to handle bus selection and device ejection;
c) Addition of a PDSM method (invoked by _DSM);
d) A new device PHPR, which reserves the memory regions used by QEMU's
   acpi-pci-hotplug mechanism;
e) A new event in the GED device used to notify PCI device hotplug and
   unplug.

DSDT diff against base aarch64/virt machine with acpi-pcihp=off:

 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -1795,33 +1795,33 @@
                     0x0000008000000000, // Range Minimum
                     0x000000FFFFFFFFFF, // Range Maximum
                     0x0000000000000000, // Translation Offset
                     0x0000008000000000, // Length
                     ,, , AddressRangeMemory, TypeStatic)
             })
             Name (SUPP, Zero)
             Name (CTRL, Zero)
             Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
             {
                 CreateDWordField (Arg3, Zero, CDW1)
                 If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                 {
                     CreateDWordField (Arg3, 0x04, CDW2)
                     CreateDWordField (Arg3, 0x08, CDW3)
                     Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
-                    Local0 &= 0x1F
+                    Local0 &= 0x1E
                     If ((Arg1 != One))
                     {
                         CDW1 |= 0x08
                     }

                     If ((CDW3 != Local0))
                     {
                         CDW1 |= 0x10
                     }

                     CDW3 = Local0
                 }
                 Else
                 {
                     CDW1 |= 0x04
                 }
@@ -1852,53 +1852,217 @@
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                         0x0000000000000000, // Granularity
                         0x0000004010000000, // Range Minimum
                         0x000000401FFFFFFF, // Range Maximum
                         0x0000000000000000, // Translation Offset
                         0x0000000010000000, // Length
                         ,, , AddressRangeMemory, TypeStatic)
                 })
             }
         }
     }

+    Scope (_SB.PCI0)
+    {
+        OperationRegion (PCST, SystemMemory, 0x090C0000, 0x08)
+        Field (PCST, DWordAcc, NoLock, WriteAsZeros)
+        {
+            PCIU,   32,
+            PCID,   32
+        }
+
+        OperationRegion (SEJ, SystemMemory, 0x090C0008, 0x04)
+        Field (SEJ, DWordAcc, NoLock, WriteAsZeros)
+        {
+            B0EJ,   32
+        }
+
+        OperationRegion (BNMR, SystemMemory, 0x090C0010, 0x08)
+        Field (BNMR, DWordAcc, NoLock, WriteAsZeros)
+        {
+            BNUM,   32,
+            PIDX,   32
+        }
+
+        Mutex (BLCK, 0x00)
+        Method (PCEJ, 2, NotSerialized)
+        {
+            Acquire (BLCK, 0xFFFF)
+            BNUM = Arg0
+            B0EJ = (One << Arg1)
+            Release (BLCK)
+            Return (Zero)
+        }
+
+        Method (AIDX, 2, NotSerialized)
+        {
+            Acquire (BLCK, 0xFFFF)
+            BNUM = Arg0
+            PIDX = (One << Arg1)
+            Local0 = PIDX /* \_SB_.PCI0.PIDX */
+            Release (BLCK)
+            Return (Local0)
+        }
+
+        Method (PDSM, 5, Serialized)
+        {
+            If ((Arg2 == Zero))
+            {
+                Local0 = Buffer (One)
+                    {
+                         0x00                                             // .
+                    }
+                If ((Arg0 != ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
+                {
+                    Return (Local0)
+                }
+
+                If ((Arg1 < 0x02))
+                {
+                    Return (Local0)
+                }
+
+                Local1 = Zero
+                Local2 = AIDX (DerefOf (Arg4 [Zero]), DerefOf (Arg4 [One]
+                    ))
+                If (!((Local2 == Zero) | (Local2 == 0xFFFFFFFF)))
+                {
+                    Local1 |= One
+                    Local1 |= (One << 0x07)
+                }
+
+                Local0 [Zero] = Local1
+                Return (Local0)
+            }
+
+            If ((Arg2 == 0x07))
+            {
+                Local2 = AIDX (DerefOf (Arg4 [Zero]), DerefOf (Arg4 [One]
+                    ))
+                Local0 = Package (0x02) {}
+                If (!((Local2 == Zero) || (Local2 == 0xFFFFFFFF)))
+                {
+                    Local0 [Zero] = Local2
+                    Local0 [One] = ""
+                }
+
+                Return (Local0)
+            }
+        }
+    }
+
+    Scope (\_SB.PCI0)
+    {
+        Method (EDSM, 5, Serialized)
+        {
+            If ((Arg2 == Zero))
+            {
+                Local0 = Buffer (One)
+                    {
+                         0x00                                             // .
+                    }
+                If ((Arg0 != ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
+                {
+                    Return (Local0)
+                }
+
+                If ((Arg1 < 0x02))
+                {
+                    Return (Local0)
+                }
+
+                Local0 [Zero] = 0x81
+                Return (Local0)
+            }
+
+            If ((Arg2 == 0x07))
+            {
+                Local0 = Package (0x02)
+                    {
+                        Zero,
+                        ""
+                    }
+                Local1 = DerefOf (Arg4 [Zero])
+                Local0 [Zero] = Local1
+                Return (Local0)
+            }
+        }
+
+        Device (PHPR)
+        {
+            Name (_HID, "PNP0A06" /* Generic Container Device */)  // _HID: Hardware ID
+            Name (_UID, "PCI Hotplug resources")  // _UID: Unique ID
+            Name (_STA, 0x0B)  // _STA: Status
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                IO (Decode16,
+                    0x0000,             // Range Minimum
+                    0x0000,             // Range Maximum
+                    0x01,               // Alignment
+                    0x00,               // Length
+                    )
+            })
+        }
+
+        Device (S00)
+        {
+            Name (_ADR, Zero)  // _ADR: Address
+        }
+
+        Device (S08)
+        {
+            Name (_ADR, 0x00010000)  // _ADR: Address
+        }
+
+        Method (PCNT, 0, NotSerialized)
+        {
+        }
+    }
+
     Scope (\_SB)
     {
         Device (\_SB.GED)
         {
             Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
             Name (_UID, "GED")  // _UID: Unique ID
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                 {
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
+                    Acquire (\_SB.PCI0.BLCK, 0xFFFF)
+                    \_SB.PCI0.PCNT ()
+                    Release (\_SB.PCI0.BLCK)
+                }
             }
         }

         Device (PWRB)
         {
             Name (_HID, "PNP0C0C" /* Power Button Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }
     }
 }

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/data/acpi/aarch64/virt/DSDT.acpipcihp | Bin 0 -> 5993 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpipcihp b/tests/data/acpi/aarch64/virt/DSDT.acpipcihp
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..1ee2699d03dd24b7f56dc6e9f88334ab5aeb3d9f 100644
GIT binary patch
literal 5993
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
Gs{aE@PSiaB

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dc3ab24d05..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
-- 
2.34.1


