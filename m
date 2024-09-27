Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E149ACDD1D2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 18:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suFtW-0008Sa-Mz; Fri, 27 Sep 2024 14:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1suFtO-0007x0-5i; Fri, 27 Sep 2024 14:40:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1suFtM-0002Kx-3x; Fri, 27 Sep 2024 14:40:37 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RHMaeg032276;
 Fri, 27 Sep 2024 18:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :reply-to:mime-version:content-transfer-encoding; s=
 corp-2023-11-20; bh=h61Gm34lZnRD9yK0JNtobZVXv9um/pHmr3hWMI6anxQ=; b=
 iX9kGP2ZGTEhoTOU3oc/YsRvA+ildsCGN57lQOZOn4VbJRpUzOVOuqi1+neJsEv4
 pd3xbFVQjh/Tqlr+Rw9rh5qPRC5qO9S4bXjCKHwLKXzoH7zyGI2YqGvKLNA4SY2M
 /rbTofNuGyuseU86zqBWmjN8TYpYemx++rmFxRjjKVW0GbPNLnHIFbBK2TOWZEqZ
 joyvan5T6UsxXqCTNHEBROVKn5WgyzPT09fAzAKZL7NX5YEf7bcpyYjbezTz2BMl
 Pt23Htl9Hp3n7ERJAxWOK4RtgHbQRPsyeLYQj7O/+onIKiBbLpHb6JD87wWNrqwA
 FC/TAECiBIuFW+VMKvquKg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1ar9ek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 18:40:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48RH67Nd032904; Fri, 27 Sep 2024 18:40:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41smkm8gvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 18:40:26 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48RIdIon009004;
 Fri, 27 Sep 2024 18:40:26 GMT
Received: from localhost.localdomain (dhcp-10-175-14-34.vpn.oracle.com
 [10.175.14.34])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 41smkm8ff6-11; Fri, 27 Sep 2024 18:40:25 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com
Cc: dave@treblig.org, mst@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eblake@redhat.com, armbru@redhat.com,
 annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC V2 PATCH 10/11] tests/acpi: Update FACP and DSDT tables for
 sleep button
Date: Fri, 27 Sep 2024 14:39:05 -0400
Message-ID: <20240927183906.1248-11-annie.li@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240927183906.1248-1-annie.li@oracle.com>
References: <20240927183906.1248-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409270135
X-Proofpoint-ORIG-GUID: 549awtULSwg0gET17eDMHkDPXHh6nYH3
X-Proofpoint-GUID: 549awtULSwg0gET17eDMHkDPXHh6nYH3
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: miguel.luis@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Miguel Luis <miguel.luis@oracle.com>

 [000h 0000   4]                    Signature : "FACP"    [Fixed ACPI Description Table (FADT)]
 [004h 0004   4]                 Table Length : 00000114
 [008h 0008   1]                     Revision : 06
-[009h 0009   1]                     Checksum : 12
+[009h 0009   1]                     Checksum : DF
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

 [024h 0036   4]                 FACS Address : 00000000
 [028h 0040   4]                 DSDT Address : 00000000
 [02Ch 0044   1]                        Model : 00
 [02Dh 0045   1]                   PM Profile : 00 [Unspecified]
 [02Eh 0046   2]                SCI Interrupt : 0000
 [030h 0048   4]             SMI Command Port : 00000000
 [034h 0052   1]            ACPI Enable Value : 00
 [035h 0053   1]           ACPI Disable Value : 00
 [036h 0054   1]               S4BIOS Command : 00
 [037h 0055   1]              P-State Control : 00
@@ -148,50 +148,50 @@
 [0DCh 0220   1]                     Space ID : 00 [SystemMemory]
 [0DDh 0221   1]                    Bit Width : 00
 [0DEh 0222   1]                   Bit Offset : 00
 [0DFh 0223   1]         Encoded Access Width : 00 [Undefined/Legacy]
 [0E0h 0224   8]                      Address : 0000000000000000

 [0E8h 0232  12]                   GPE1 Block : [Generic Address Structure]
 [0E8h 0232   1]                     Space ID : 00 [SystemMemory]
 [0E9h 0233   1]                    Bit Width : 00
 [0EAh 0234   1]                   Bit Offset : 00
 [0EBh 0235   1]         Encoded Access Width : 00 [Undefined/Legacy]
 [0ECh 0236   8]                      Address : 0000000000000000

 [0F4h 0244  12]       Sleep Control Register : [Generic Address Structure]
 [0F4h 0244   1]                     Space ID : 00 [SystemMemory]
-[0F5h 0245   1]                    Bit Width : 00
+[0F5h 0245   1]                    Bit Width : 08
 [0F6h 0246   1]                   Bit Offset : 00
 [0F7h 0247   1]         Encoded Access Width : 00 [Undefined/Legacy]
-[0F8h 0248   8]                      Address : 0000000000000000
+[0F8h 0248   8]                      Address : 0000000009080000

 [100h 0256  12]        Sleep Status Register : [Generic Address Structure]
 [100h 0256   1]                     Space ID : 00 [SystemMemory]
-[101h 0257   1]                    Bit Width : 00
+[101h 0257   1]                    Bit Width : 08
 [102h 0258   1]                   Bit Offset : 00
 [103h 0259   1]         Encoded Access Width : 00 [Undefined/Legacy]
-[104h 0260   8]                      Address : 0000000000000000
+[104h 0260   8]                      Address : 0000000009080001

 [10Ch 0268   8]                Hypervisor ID : 00000000554D4551

 Raw Table Data: Length 276 (0x114)

-    0000: 46 41 43 50 14 01 00 00 06 12 42 4F 43 48 53 20  // FACP......BOCHS
+    0000: 46 41 43 50 14 01 00 00 06 DF 42 4F 43 48 53 20  // FACP......BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
     0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     0040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     0050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     0060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     0070: 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     0080: 00 03 00 03 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     0090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     00A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     00B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     00C0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     00D0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     00E0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
-    00F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
-    0100: 00 00 00 00 00 00 00 00 00 00 00 00 51 45 4D 55  // ............QEMU
+    00F0: 00 00 00 00 00 08 00 00 00 00 08 09 00 00 00 00  // ................
+    0100: 00 08 00 00 01 00 08 09 00 00 00 00 51 45 4D 55  // ............QEMU
     0110: 00 00 00 00                                      // ....

  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x0000144C (5196)
+ *     Length           0x0000149E (5278)
  *     Revision         0x02
- *     Checksum         0x1B
+ *     Checksum         0x97
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

@@ -1876,27 +1876,48 @@
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
+                    Notify (SLPB, 0x80) // Status Change
+                }
             }
         }

         Device (PWRB)
         {
             Name (_HID, "PNP0C0C" /* Power Button Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }
+
+        Device (\_SB.SLPB)
+        {
+            Name (_HID, EisaId ("PNP0C0E") /* Sleep Button Device */)  // _HID: Hardware ID
+            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
+            {
+                One,
+                0x04
+            })
+            OperationRegion (\B**, SystemIO, 0x0201, One)
+            Field (\B**, ByteAcc, NoLock, WriteAsZeros)
+            {
+                SBP,    1,
+                SBW,    1
+            }
+        }
     }
 }

Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
---
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5278 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5364 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6639 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7761 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5480 bytes
 tests/data/acpi/aarch64/virt/FACP             | Bin 276 -> 276 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |   6 ------
 7 files changed, 6 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
index 36d3e5d5a5e47359b6dcb3706f98b4f225677591..348e66bcd52ca4a2c0bb751ac7fc0dd5f36f73c5 100644
GIT binary patch
delta 146
zcmX@3F;A1rCD<ioo(Ka2)AWg4(oCK18`WnBGdXiiJ}4Zltrzba7Q$KJ8tm$mus~pP
zbpjU?0~b?UKzNW7R|7;qfPqV(E!ZbuvYv>XV|0^!j9z@OQ#??>i6h>_(}l<J0uLWY
qd_YjR5GxZS7fW<Qj8lGoJR>(F6JvCvAeiGA>=Y2s80-`t&j<jVM<)CL

delta 63
zcmbQIc}9cFCD<jzM}&caNqQoeG*i3NM)euOOit{R4+;lM$;P{eg>V+Q2D|zsED)Gn
ToxsJ!z{S)S5FRwyUPKN67!MG;

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
index e6154d0355f84fdcc51387b4db8f9ee63acae4e9..919a08d1fb2aae5664d65c9e29164a2c10b261db 100644
GIT binary patch
delta 148
zcmZ3a`9+h<CD<k8iwFY)Q^-UvX{LUkjq2}&nVdN$i;Dy^>P^lTk;z>kFu6K`OMrn(
zpe@)Zz=^9Nx=Au1JjjV7-ow*{H^48zz}di=fg?WD(}f|r$v#FeKG-Q9q!O%v$MFIW
sA4hyZP`D5)6C)Q(bVH0&ettY7HzN~cbfX}c;~4A|5YHIw6dunA0JnK2!vFvP

delta 66
zcmeyOxk!`CCD<iokq83=(~XH-(oDVX8`a+lGdZzO78eO-l%1R{A|oB$BpDDM<irv0
W;pxH~;1^)vY~akm5g+R5!T<nyRS|Ij

diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
index 33f011d6b635035a04c0b39ce9b4e219f7ae74b7..9e713db27df6502c8d7a1cbd2dfddaada3863de4 100644
GIT binary patch
delta 126
zcmbPh{N9+$CD<k8y(9wz)A5O1(o9`*Hmc7MW^&@5d{8);$(MDqn1~nu0)ffZ30wjU
zTmo&uJ^@af<3#LP9iyA<WAx&Ko#H`49Pu8WE<BDGc=$Nt1A@YZSeY2PSfU$ZobvPI
Z8Mzsm7^52n!5qh6r+|3IV5jhSMgZvrA_)Kh

delta 44
zcmaEFJlB}ZCD<iot|S8klg&gfX{L_p8`WnBGdXfiJ}4Z_<ij#qOvGz*p@=Oj03*B%
AQ~&?~

diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
index c0fdc6e9c1396cc2259dc4bc665ba023adcf4c9b..95a4075dae670f6f039338ac19ac44eb8b7f6a66 100644
GIT binary patch
delta 123
zcmexwebI)?CD<h-P>z9tiFqQIG*i!`jq2XAOwJsWOJsu?^(LQ?mEl_;Fu6K`OMrn(
zpe@)ZVDdv*ImhTG`xw3WV5fMXfD=c&ho=jV;{_f*j`)C}a3NMEMlP1<h8U;({CGxg
XMkdDSMnN#gG1w^}o-x=dJf0B%TvZ_~

delta 66
zcmca;^WU1wCD<k8zbpd-Q^!OuX{N5b8`ZsKnVi@sm&gV)%1%BZD<d7<BpDDM<irv0
W;pxH~;1^)vY~akm5g+R5!T<oW?Gmg2

diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
index 029d03eecc4efddc001e5377e85ac8e831294362..5a513726f3659c2af590bf852a0ffb4c8a52d3c2 100644
GIT binary patch
delta 123
zcmbQH^+JowCD<h-LzIDmse2-qG*ffPM)f2SCTEVx-6Fw^dXw*q$nY%?m|UH}CBVQX
z&=%|yF!_gwoMUv8eT-gwuv0uxz=<Q?!_$Sw@d6JYM|?m~xDYE7BNt0_LyS{?emo;L
XBNJnEqac{$80-`f&lv0!9?u8>I`AOw

delta 42
ycmaE%HBF1lCD<iIOq79viGL!OG*hGhM)f2SCMWjE-6Fw^vXk$N$V}!Dl?DLi4hnq$

diff --git a/tests/data/acpi/aarch64/virt/FACP b/tests/data/acpi/aarch64/virt/FACP
index da0c3644cc4536a0a0141603ed470bd11492b678..d8f3658df25a63b6994ee135ad3006a3e1f48e89 100644
GIT binary patch
delta 50
tcmbQjG=+)F&CxkPgpq-P?fyir*YX?;K)}HXA{l^eMkqVb)i)F*1OU=O23r6C

delta 30
kcmbQjG=+)F&CxkPgpq-PO=u$5>xl;99D%OBp$tF(0A~>f8~^|S

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dcc7c2306d..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,7 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/virt/DSDT",
-"tests/data/acpi/virt/DSDT.acpihmatvirt",
-"tests/data/acpi/virt/DSDT.memhp",
-"tests/data/acpi/virt/DSDT.pxb",
-"tests/data/acpi/virt/DSDT.topology",
-"tests/data/acpi/virt/FACP",
-- 
2.43.5


