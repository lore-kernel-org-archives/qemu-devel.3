Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B2FC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQS5-0004jx-2X; Mon, 26 May 2025 01:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJQRc-0002uz-Qx
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:32:17 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJQRU-0002K1-Sl
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:32:10 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4e290e420eeso542656137.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748237526; x=1748842326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jU5MgyvbkVOqi7hQ3tmKxY48Fkr8UfgknyiBYdR8Jdg=;
 b=wKUA7RhNWm7I1PnzHyrrcDO2RpnDJLxV2cdN7SDj+QsC1k/GsxdOjldwqMFZVuihy+
 TKgXHejo5WMiIgsfaE5ZeOWM1i1KmnMupPkfP9QKqg/bQTBQ9yrIngDQMRK5OTeOIKix
 h+T3GR5pxBxcohX0RCpOhafUNE0NKogks/ozuWLdyCzMqHujX8WktzvOi27veokAeDL6
 bpqX39L8nJpK70MRnG8B52kH5JZI0cLCeslsuyXVC4zgC7vmzH3CfUjIBj1J3ItR5N+V
 r7y54wfOLj9mNrxYiTTY83db5sLJbFLOCkdWOzADcL0x5rG0GCTaibF+jtBbuI9b6iV3
 YOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237526; x=1748842326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jU5MgyvbkVOqi7hQ3tmKxY48Fkr8UfgknyiBYdR8Jdg=;
 b=wMSyWGD+RepJ7Fy+Tf7w4zY49Z0FUqDCUuHNySQtVFIBdCMWzm31MABJqQXk2No0GC
 dPPZ6bq5+5PMk9zQ/PHg9TfsgEOneF5/dERpb3A8goChsZsh5DxeTgByz3024X7M3G48
 86yOM6Kou3zSaiuVtonEXQmBeFFqn2rpbJuR6Nm+vq9H6kucsomVqssxFNj3j+XrxbBR
 UsnsFjUPYdMTBXVnefnM9IPyzkNbUujW90oIezXFBjuiYzi/OW7XqUhPTHDI2Q8n5jRP
 F62/k2MVeN9+i1CobgyxxAz9kSqbbv4H9hGPDf6+0zMSl7K7V+UchT4lo4PKDNlxqoDL
 9+8A==
X-Gm-Message-State: AOJu0Ywq131HCMupPbUuzUygOmBUE2AJFgsLsh8tB0Zvkba1gewy0wF7
 Zp99puZ/SdrixXxICgwnU9BkkKv2zhV9Qu1FW4p5W9rWPXME1MBxHtVCa/S/a1EQKrYLSvMuwHR
 eh97TVmI=
X-Gm-Gg: ASbGnct8VICGbdOMdSQdO5qZDoxhhj30LouXEaFGv/NdLqOoxdJxERuL6jM1BfxTR/c
 BNxjuyE8BxXUFdqnJNrDy+i+s1o5TdXieHg9HiCb4GUTH3mOpDCU8vF/t7jfXXurcBorfK7pZXS
 7N+KRiBWR8GUZoqmR+9fYEllivNCM9aqtBeuBqCsNeJBxbMGpWLSjWZUzO2/acwhBWNAjQ0hA2R
 qOb5xoSKIKXc3sqf6fSw8k96EEbjcVZS1wCboWkniYc6Gsa4mmnHoushb8YacHENZCTUrr9yG2l
 HBrzG8Nkj931RbnntFEOTUI00ys3wB4+qclyiW4wklDuyO0yNSU5xlqwo7gmTyOVDiZzB9sj9dN
 /wOMsz3sxPaan/tJ4iN4WwqJqRqZlg5mn
X-Google-Smtp-Source: AGHT+IEVUDKs7I1Balg8c9FvQt+6lgKA6srxt+Gl9JUizg139pKAUhrlqHWspjdzgZw9syZ/a/lUcg==
X-Received: by 2002:a05:6102:6c4:b0:4bb:d45c:7f4b with SMTP id
 ada2fe7eead31-4e4240f9b9amr5989675137.11.1748237526611; 
 Sun, 25 May 2025 22:32:06 -0700 (PDT)
Received: from gromero0.. (200-100-75-183.dial-up.telesp.net.br.
 [200.100.75.183]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e454da4378sm784310137.17.2025.05.25.22.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 22:32:05 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	eric.auger@redhat.com
Cc: qemu-arm@nongnu.org, thuth@redhat.com, gustavo.romero@linaro.org,
 alex.bennee@linaro.org, mst@redhat.com, imammedo@redhat.com
Subject: [PATCH 3/5] tests/qtest/bios-tables-test: Update changed ACPI blobs
Date: Mon, 26 May 2025 05:31:21 +0000
Message-Id: <20250526053123.1434204-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526053123.1434204-1-gustavo.romero@linaro.org>
References: <20250526053123.1434204-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe2b.google.com
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

Update the aarch64 'virt' base blob and all of its variants. All of them
have the same diff, so only one is shown below. The essential changes is
in the AML code of the _OSC (OS Capabilities) method, (variable name
from 'CTRL' to 'Local0') and the scope for GED device.

DSDT table diff:

 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -1794,53 +1794,52 @@
                     0x0000000000000000, // Granularity
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
-                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
-                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
-                    CTRL &= 0x1F
+                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
+                    Local0 &= 0x1F
                     If ((Arg1 != One))
                     {
                         CDW1 |= 0x08
                     }

-                    If ((CDW3 != CTRL))
+                    If ((CDW3 != Local0))
                     {
                         CDW1 |= 0x10
                     }

-                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
-                    Return (Arg3)
+                    CDW3 = Local0
                 }
                 Else
                 {
                     CDW1 |= 0x04
-                    Return (Arg3)
                 }
+
+                Return (Arg3)
             }

             Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
             {
                 If ((Arg0 == ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
                 {
                     If ((Arg2 == Zero))
                     {
                         Return (Buffer (One)
                         {
                              0x01                                             // .
                         })
                     }
                 }

                 Return (Buffer (One)
@@ -1851,33 +1850,36 @@

             Device (RES0)
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
+    }

+    Scope (\_SB)
+    {
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

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5178 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5264 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6539 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7635 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5380 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |   5 -----
 6 files changed, 5 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
index 36d3e5d5a5e47359b6dcb3706f98b4f225677591..5c73e64e0c29d3cea5299929afd00e9a1238e559 100644
GIT binary patch
delta 125
zcmX@3u}g!?CD<jzN`!%dNoFFKG*h4XMs+tXCb!9(^SP`!1bx`!{ezuZy0RIZUBV3)
z__0pjEu>{)oKT&>C7-ZBVAAAF##)dJ7YA5gc+zAbZJYoR699=7B!EN~@=P`s?&1(|
P<BW+9c8Z_8SGXSlZJ{Hk

delta 142
zcmdm`aYlp7CD<jzM}&caNqQoeG*i3NMs+tXCWon;^SP`!1l>5}{ezuZy0RIZUBV3)
zc(702Eu`gV6dW25PyiG$b`A;hsRj{T@*r}7z@*8UjI|)OTpVB>Vv{Dr)Io#=K*9we
U#USw|*$eq5OA2>QUM<`Y00vhni~s-t

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
index e6154d0355f84fdcc51387b4db8f9ee63acae4e9..b0a875d8da3592b5927095304ca31ceb001b2fdf 100644
GIT binary patch
delta 125
zcmZ3aIYE=lCD<iof(Qcx(~F5*(o8M38`bA<F}Y3Ne3Z+YL(qpk-apuxr7N4k*(Ka?
zfgkH+L18Tu<Amx2F8PE70+S|ZGS-4*xH!P_!jmQgY2yTlm;gwuAOR$@kY{qIa2JPw
P8)r;>uv7eGVUd0S*;^zc

delta 142
zcmbQBxk!`CCD<iokq83=(~XH-(oDVX8`bA<F*!`#e3Z+YL(q*g-apuxr7N4k*(Ka?
zfd~6!L18UFqu|hhfC8Y1v2#d}Pc?|(k_V9s1SU<+WUK|L<>CPA5Sug^rVb)301_?$
UDF%rz$zI4eIbXPIGNVX80DOQd2mk;8

diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
index 33f011d6b635035a04c0b39ce9b4e219f7ae74b7..21a6b086cbf72298d125d8bfc4c4b7ec9315267b 100644
GIT binary patch
delta 126
zcmbPh+-=O|66_MvEy=*ZWIK^dnyJrxqq-XxliTFY`CQf<f<El={=v>HUD*uIF5!j?
z{8%UN7Sb{?PN+`cl22G5FllloV=YLAivuh#JZUnJHco(u34p{35<nsgc_teRcX0@~
Q$Hl}4JH>C_EBt^J0I0kqp#T5?

delta 143
zcmeA+o@>nI66_K(SCWB&$z~##G*id)jp}Y(Ob$~w=W|(e2)c2``v*I-bY(L*yM!Aq
z@L-?3TS&{#C^$4Apa3Xh>>Lv0Qw<`x<U!;Dfk~4y8EZjmxj4W&#3oIKse=d$fP@P`
Vib3K_vKR7AmK5&Vyju7HD*$j8Du)07

diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
index c0fdc6e9c1396cc2259dc4bc665ba023adcf4c9b..c8548a5e5d41a843142c7bbe64580025e006445d 100644
GIT binary patch
delta 217
zcmexwec77JCD<k8vMd7w)AEU2(oF3aH>$gFF?qIa&ga_8F6hG^?;q^U(v{8N>=JIc
zz>jruo{W}>aYA(hmwdtkfk~4y8EZi@TpVC|;YpK$v~dDNOaLTSkN^@{$TRtwjP2%6
gLVAo$Zj(1FiCA+`*X%A10XNQ=_+Y2_$py0g04PO4(EtDd

delta 260
zcmca?{ok6)CD<k8zbpd-Q^!OuX{N5b8`a&on4CK{=X3347j)x{_YZbv>B?qsb_q9J
z;K4rGR!GawC^$4Apa3Xh>>Lv0Qw<`x<U!;Dfk~4y8EZjmxj4W&#3oIKse=d$fP@P`
oib3K_vKR7go-LHk$mB3}Glz&Z2VHEOJX^?i@_QNI$u6?}0Luzao&W#<

diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
index 029d03eecc4efddc001e5377e85ac8e831294362..73aa833317627204aef7ac858d178445bcd37a54 100644
GIT binary patch
delta 125
zcmbQH)uP4a66_MfBFezPBruUnnyJHOqq+b$liTFYmfY4Hf<El={=v>HUD*uIF5!j?
z{8%Tq3Tv4dCsZeJ$tNrjm^3+)u@)r5#Q~NVo-`Rq8z(@-1VCa12_TV$Jd^(lcX0@~
PamK_4JH=0K7wHE8^splO

delta 142
zcmZqCnx@6&66_KpCd$CT#6OWsnyJx$qq+b$lf%@_mfY4Hf^MAg{=v>HUD*uIF5!j?
zJlH3<3Tycp1&0O%6aYnxokN0rszC&oJcwK%FllloV=YK67YA5}*rdrYbr4|zkZ=J=
UF-Uw#_CmhNkA=G?mx}ZQ0C4*#-~a#s

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index abe00ad4ee..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,6 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/DSDT",
-"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
-"tests/data/acpi/aarch64/virt/DSDT.memhp",
-"tests/data/acpi/aarch64/virt/DSDT.pxb",
-"tests/data/acpi/aarch64/virt/DSDT.topology",
-- 
2.34.1


