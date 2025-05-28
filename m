Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974C2C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 16:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKJqf-0006lt-Vx; Wed, 28 May 2025 12:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJqe-0006fy-EO
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:41:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJqY-0007U4-Sc
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:41:48 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SFwaeU024241;
 Wed, 28 May 2025 16:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=pkf+w
 xUx7edXlpXa66fIt3qHr+/JJG835NkMZ88NPw0=; b=cocj1VDlleLTZPAa3Zmyv
 j+aXX3dg/Q4KcrDaeA8iu+u5EvyqNEDdex2t6598+d5OwJzZn6rJdLtOr8U9ZwVg
 1Qa9vHscgvudxOz5bO8GIwpT3IlzToD8Pptk2x5TfpdcR6mOJnCi+KgVxNf6nnp7
 tYcXzuOY3mU89V1jRfMyeHr4xy0UB5nYbTDSoAbuavCuWGartLn9XVWD56ZaE1/z
 65cJL3+EQXMtDQTBJtDd0NpnplYpd+tqPnXcXUpO/efkdc5C4aLqXfAftRkGGbHZ
 I76NyrjLL2PzoEV2P+uOZW5FyHvpmyhcoEO/xF1NAPlDWJ0ms0QBVWOM/C4nmPUW
 g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ykxj4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:41:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SFGJaa028389; Wed, 28 May 2025 16:41:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4janqq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:41:33 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SGfXgU022374;
 Wed, 28 May 2025 16:41:33 GMT
Received: from localhost.localdomain (dhcp-10-43-12-51.usdhcp.oraclecorp.com
 [10.43.12.51])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46u4janqmx-1; Wed, 28 May 2025 16:41:33 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, annie.li@oracle.com, miguel.luis@oracle.com
Subject: [PATCH 10/13] tests/qtest/bios-table-tests: Update ACPI table
 binaries for microvm
Date: Wed, 28 May 2025 12:41:23 -0400
Message-ID: <20250528164123.2223-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250528163545.2143-1-annie.li@oracle.com>
References: <20250528163545.2143-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280145
X-Proofpoint-GUID: P9RBMEXOBXp2W4K0XQcrwaDQkMkzpKlR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0NSBTYWx0ZWRfXylo2yl3dNvVI
 5iK2udxSAor/PivlpfpP9C9CdsZHypTOkBv/Qw3UmoSY4PNyRNuJvJFEwBMEH+2Htgr9YA4Z/4S
 b579soPVydBLH0MxL5RtrPrNWcxltRdfJv51QvbfvtIFvT0WhRZjxybnMXgqdq2UPMkGKGS5Xxx
 Ow+T4gZ/m/122VkOYdkN/+FMmV4XiC2m3tBN70eTwlE/tflxMAf8Vn9rAL8JZl/v+ezayHrYmzq
 GjVcZjGfPoYFx5DUZJm6m9EnXXqbiUFK6vWBK/sG3tvadoPzXNheLZg2L80LICcZVoGYhny4yI1
 KwAc1m3QfTK9oqE/pQtnV5j3zdKP4hdY69A5+/QWM0hMDNgi8VRX9A34mmUvVbuM382D5s+R9Ct
 hpMa5NXhZPHbtzfGnin2C+q731qiUPiH73KhTkUpDJCdaBavaGOflzmP7gamT0NTzEWRWrPJ
X-Proofpoint-ORIG-GUID: P9RBMEXOBXp2W4K0XQcrwaDQkMkzpKlR
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=68373cbe cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=78BTCozUsJPMS2UmzM0A:9
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Following is the diff generated by the step 5 and 6 in
tests/qtest/bios-tables-test.c

Diff from iasl to show changes in DSDT table:

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20210604 (64-bit version)
  * Copyright (c) 2000 - 2021 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
  * Disassembly of tests/data/acpi/x86/microvm/DSDT, Tue May 27 16:20:08 2025
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x0000016D (365)
+ *     Length           0x000001BA (442)
  *     Revision         0x02
- *     Checksum         0x11
+ *     Checksum         0xD5
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (_SB)
     {
         Device (FWCF)
         {
             Name (_HID, "QEMU0002")  // _HID: Hardware ID
             Name (_STA, 0x0B)  // _STA: Status
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
@@ -66,56 +66,82 @@
                     0x00000009,
                 }
             })
             OperationRegion (EREG, SystemMemory, 0xFEA00000, 0x04)
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

+        Device (SLPB)
+        {
+            Name (_HID, EisaId ("PNP0C0E") /* Sleep Button Device */)  // _HID: Hardware ID
+            OperationRegion (\SLP, SystemIO, 0x0201, One)
+            Field (\SLP, ByteAcc, NoLock, WriteAsZeros)
+            {
+                SBP,    1
+            }
+        }
+
         Device (VR07)
         {
             Name (_HID, "LNRO0005")  // _HID: Hardware ID
             Name (_UID, 0x07)  // _UID: Unique ID
             Name (_CCA, One)  // _CCA: Cache Coherency Attribute
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Memory32Fixed (ReadWrite,
                     0xFEB00E00,         // Address Base
                     0x00000200,         // Address Length
                     )
                 Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000017,
                 }
             })
         }
     }

     Scope (\)
     {
+        Name (_S3, Package (0x04)  // _S3_: S3 System State
+        {
+            0x03,
+            Zero,
+            Zero,
+            Zero
+        })
+    }
+
+    Scope (\)
+    {
         Name (_S5, Package (0x04)  // _S5_: S5 System State
         {
             0x05,
             Zero,
             Zero,
             Zero
         })
     }
 }

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 tests/data/acpi/x86/microvm/DSDT            | Bin 365 -> 442 bytes
 tests/data/acpi/x86/microvm/DSDT.ioapic2    | Bin 365 -> 442 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie       | Bin 3023 -> 3100 bytes
 tests/data/acpi/x86/microvm/DSDT.rtc        | Bin 404 -> 481 bytes
 tests/data/acpi/x86/microvm/DSDT.usb        | Bin 414 -> 491 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   5 -----
 6 files changed, 5 deletions(-)

diff --git a/tests/data/acpi/x86/microvm/DSDT b/tests/data/acpi/x86/microvm/DSDT
index f477668f2ee80241e47b340ad4a30f5480df2049..ee199a4fb65ab1a2d811f37d9b5bc67bccd34939 100644
GIT binary patch
delta 127
zcmaFMw2PU`CD<io7b61$)76Pw(oD|c6V<breAy>X_GQ$Y_)vy#fxzVI1TFyvE`hdS
zpMZ(K6f`w~v=c|Xho=jV;{_hR=!O`eKs+NiBNJnEBM+G480-WTnJmHREo~ex#LmLS
V%)r1PAP~dA5g%*{7GMPm005{09v1)r

delta 54
zcmdnR{FaH!CD<h-myv;iNpK>UG?TmVMD;8tAGV2;eHmpZK9rfv$0$2FjM0<JG+v0E
Kg^QJefdK$+3k%2q

diff --git a/tests/data/acpi/x86/microvm/DSDT.ioapic2 b/tests/data/acpi/x86/microvm/DSDT.ioapic2
index e5924a49962e0cff4228bcfc77ebcf48cb4a2219..7512d1527cf222d6f75a92f051f9eda402e28376 100644
GIT binary patch
delta 127
zcmaFMw2PU`CD<io7b61$Q~yLRX(ng!iRxKQzU&hx`!ecHd?>@WKwxrp0+#>-mq1&v
zPr$@q3YwZg+KD6H!_$Sw@d6KDbVCeKAfAz%k%=+7kq69i40ZyFOqO8umNt$TVrSuE
UW?*0t5Qt&mhz~Xe3$OwO0ErwO(EtDd

delta 54
zcmdnR{FaH!CD<h-myv;i>GVV{X(o5!iRxKQK5P>w`!dQ-d?+)Sk5P7V7^5ebX}l0S
K3l}Q`0|Nky8w`Q~

diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
index 8eacd21d6ecdf9a3cd3e4f03cf1b40748dcbf53e..5e3f80cbf82cab52fe310160c88d0a11ff069bf5 100644
GIT binary patch
delta 128
zcmX>vK1YJfCD<iIhKGTHiDM#{G?VMziRxKQzU&hx`!ecHd?>@WKwxrp0+#>-mq1&v
zPr$@q3YwZg+KD6H!_$Sw@d6KDbVCeKAfAz%k%=+7kq69i40ZyFY?feL%O!0bFT~Em
W#mvCKARrLKz!4v83Kn1m3IG6dDjnGX

delta 55
zcmbOuabBFuCD<k8JU0Ualj}q-X(rE|6V<breAp&V_GOfv_)umtAEWH%FvitfT&D3t
L>?~ZY3=9kauQ3gZ

diff --git a/tests/data/acpi/x86/microvm/DSDT.rtc b/tests/data/acpi/x86/microvm/DSDT.rtc
index e375473b5f033d374dd2a64a9f814fd16c3e262f..11258908703b64a835bd14307490c62c5ef7301f 100644
GIT binary patch
delta 129
zcmbQj{E(T;CD<k8AtM6=)8dI-(o9~G6V)d&`La*k<;$oynS)V=Z-Kz%>I5zU1}=fN
zV4r}=ii`@Hnm~pVN4$rp3y<Rk9=_;?7@$BrBR3-xV{{`AnBy4i1QeNU&*&{}952Mq
X!o|$Mz#t$H!@v<AYzh`&1quKFJNg{0

delta 79
zcmaFJJcXIdCD<io3L^sp)BTBD(oBA$6V)d&`LIpg<;y5LnS)VAI=V?RAUw#4Bi_T)
jg*U)2z`)tSnSmod)YFAway6qjmub8ZI|~;p0|Ns9En5;N

diff --git a/tests/data/acpi/x86/microvm/DSDT.usb b/tests/data/acpi/x86/microvm/DSDT.usb
index d63fd84620a2689120b32262f964e6a098d71632..7250d9f8ad45fca91afeda1089090eee11cd6594 100644
GIT binary patch
delta 127
zcmbQo{F<4|CD<k8H6sH9)6<Du(o8N=6V<breAy>X_GQ$Y_)vy#fxzVI1TFyvE`hdS
zpMZ(K6f`w~v=c|Xho=jV;{_hR=!O`eKs+NiBNJnEBM+G480-WTnJmFrBW)Zn#LmLS
V%)r1PAP~dA5g%*{7GMPm006!m9&i8v

delta 54
zcmaFOJdc^nCD<io9wP$-lj1}!X(kV`iRxKQK5P>w`!dQ-d?+)Sk5P7V7-JQeX}l0S
K3l}Q`0|NkddJG`|

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index bb028db137..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,6 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/microvm/DSDT",
-"tests/data/acpi/x86/microvm/DSDT.ioapic2",
-"tests/data/acpi/x86/microvm/DSDT.pcie",
-"tests/data/acpi/x86/microvm/DSDT.rtc",
-"tests/data/acpi/x86/microvm/DSDT.usb",
-- 
2.43.5


