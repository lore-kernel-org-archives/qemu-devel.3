Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F0ACDD1D2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 18:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suFss-0006zE-Mo; Fri, 27 Sep 2024 14:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1suFso-0006pT-ST; Fri, 27 Sep 2024 14:40:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1suFsk-00025U-NC; Fri, 27 Sep 2024 14:40:01 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RHMZFt032210;
 Fri, 27 Sep 2024 18:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :reply-to:mime-version:content-transfer-encoding; s=
 corp-2023-11-20; bh=tWvsQ/gKmJg974nVfDan3aoG7E8GrdiSyQqpdRsN2YE=; b=
 K83QIj71qeXnJt6Tw6rYncLiNG4kF6MNJDUvPguNbL1+e9aSYrMbiVDUuoRfAP4z
 6PfXIckk2pZYQYei2baL+Ttsj6/McHRkivKJE2u/M0Tss0AkwD024mWLetLbb/lV
 D4wp3/S9kHoqkIXQboEtCVqITODfW4hl9VpdO/pMMiy7omiktYOOSj7ZxGu6OU7k
 +9Xc37LVEIxacrxjgqtnrGainmQS7XrVT4Hk9P2xNGx+iNM7lnpqFb3Hb7OYoFw2
 ZO4ZqKWxNAkTSTRDraUKx3I827xlDuahLzuOSUmL5BSwy01XL71UevOIUxOPLtcw
 +qP1dKvpKM2Q2VCv0/2ryQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1ar9dc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 18:39:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48RHD0xW032835; Fri, 27 Sep 2024 18:39:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41smkm8fus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 18:39:50 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48RIdIod009004;
 Fri, 27 Sep 2024 18:39:50 GMT
Received: from localhost.localdomain (dhcp-10-175-14-34.vpn.oracle.com
 [10.175.14.34])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 41smkm8ff6-6; Fri, 27 Sep 2024 18:39:49 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com
Cc: dave@treblig.org, mst@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eblake@redhat.com, armbru@redhat.com,
 annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC V2 PATCH 05/11] tests/acpi: Update DSDT tables for Control
 method sleep button
Date: Fri, 27 Sep 2024 14:39:00 -0400
Message-ID: <20240927183906.1248-6-annie.li@oracle.com>
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
X-Proofpoint-ORIG-GUID: cX11ysq7ifehmA_gok2CdHH3SsZ6PK7_
X-Proofpoint-GUID: cX11ysq7ifehmA_gok2CdHH3SsZ6PK7_
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

Below is the sample iASL difference,

  *     Signature        "DSDT"
- *     Length           0x000020A3 (8355)
+ *     Length           0x00002159 (8537)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0x37
+ *     Checksum         0x40
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\)
     {
         OperationRegion (DBG, SystemIO, 0x0402, One)
         Field (DBG, ByteAcc, NoLock, Preserve)
         {
             DBGB,   8
         }

@@ -2851,32 +2851,69 @@
             {
                 Memory32Fixed (ReadOnly,
                     0xFED00000,         // Address Base
                     0x00000400,         // Address Length
                     )
             })
         }
     }

     Scope (_GPE)
     {
         Name (_HID, "ACPI0006" /* GPE Block Device */)  // _HID: Hardware ID
     }

     Scope (_SB)
     {
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
+    }
+
+    Scope (\_GPE)
+    {
+        Method (_L07, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
+        {
+            If (\_SB.SLPB.SBP)
+            {
+                \_SB.SLPB.SBP = One
+                Notify (\_SB.SLPB, 0x80) // Status Change
+            }
+
+            If (\_SB.SLPB.SBW)
+            {
+                \_SB.SLPB.SBW = One
+                Notify (\_SB.SLPB, 0x02) // Device Wake
+            }
+        }
+    }
+
+    Scope (_SB)
+    {

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 tests/data/acpi/x86/pc/DSDT                   | Bin 6830 -> 7012 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 6741 -> 6923 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 8155 -> 8337 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 13701 -> 13883 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 7294 -> 7476 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 8484 -> 8666 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 6781 -> 6963 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 3337 -> 3519 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 6902 -> 7084 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 8189 -> 8371 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 6688 -> 6870 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 6836 -> 7018 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 10623 -> 10805 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8355 -> 8537 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8372 -> 8554 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9680 -> 9862 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8634 -> 8816 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8401 -> 8583 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 11968 -> 12150 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12913 -> 13095 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33770 -> 33952 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8819 -> 9001 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 9714 -> 9896 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10009 -> 10191 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8430 -> 8612 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8443 -> 8625 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8372 -> 8554 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9714 -> 9896 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9485 -> 9667 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13208 -> 13390 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8235 -> 8417 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8213 -> 8395 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8361 -> 8543 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8456 -> 8638 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12913 -> 13095 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33770 -> 33952 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8961 -> 9143 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 8987 -> 9169 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18589 -> 18771 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 9464 -> 9646 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35718 -> 35900 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |  41 ------------------
 42 files changed, 41 deletions(-)

diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
index c93ad6b7f83a168a1833d7dba1112dd2ab8a431f..b0b15c87db646b018d8247bf2d69422ef308c731 100644
GIT binary patch
delta 207
zcmZ2y`oxUOCD<h-MVf(uQDh^RBwM{ZOMI|Xd~}n2j2?&)>=WR`5%1yY!sB>>hmRvZ
zAShgjm5GsyCAuNTDL+4+k(-f;F}hI@%yA5M3W#S6b_$PY6!2w>iFXfh6>(*Y_c1VM
sSfCf9&kQpVq^y7uO`r{Ip&8glt_C#q;ppna<00xH%9%DRvGs@m03~@i1poj5

delta 24
fcmaE2w$7BxCD<ioofHEDBlkuwNw&>5*}6plUY`dR

diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
index f643fa2d034053fa07f74f095565b64f021d4290..bba488a12192b81fa73dc075fd0b8085e03bb98c 100644
GIT binary patch
delta 207
zcmca=(rw1&66_MfEzQ8d7_*T}lC9pIB|g|GKDx<1Mi0aY_6cy}i1+Yx;c>jc!^aUH
z5EL%N%EZXU65SBvl%F5Z$j!*a7~Loc<~RmB1;jH3JB7zH3iz_c#JdN$iny}H`xuxr
rEYOS5XNDOFQdYo-CeQ}9&<t!NR|A^*aCG(I@euV8<xHEE*o;L0?VvYk

delta 24
fcmeA+yK2Ja66_KZD#gIS7`%~7l5O)%HX{)LR&xe<

diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
index 9d3695ff289036856886a093733926667a32a058..118d60fb6690e643a83b8553af491c69707b68c5 100644
GIT binary patch
delta 207
zcmca@KhcrPCD<ioq5=a0<He0!l5F+vEb+lk@zG88F?t|Iuup&!N4$rp3y<Rk9zKrv
zfS_<8RwhO+mgt5Ur~LeQMs7wX#^^>tFvl_2DIlIP*eN`oQNWiiCf+^3Rm7Do-p9b4
sVS!$ZJ~PZfkg@_sG=Vm-g=SzIxf;;ahoh?xkB6v-C}-NN#I{os0L{2L6#xJL

delta 24
gcmbQ}c-x-KCD<k8wmbs^<B5%2l5CrAvh9!r0B0@;CIA2c

diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
index 840b45f354ac14c858d0af8fbd31e97949a65d4b..49e6fe5ab3220d1338318e46992d41b1009323cb 100644
GIT binary patch
delta 207
zcmZq8-krnc66_LUZN|XBsI-wwlC9pIB|g|GKDx<1Mi0aY_6cy}i1+Yx;c>jc!^aUH
z5EL%N%EZXU65SBvl%F5Z$j!*a7~Loc<~RmB1;jH3JB7zH3iz_c#JdN$iny}H`xuxr
rEYOS5XNDOFQdYo-CeQ}9&<t!NR|A^*aCG(I@euV8<xHEE*pl@DIbk>v

delta 24
fcmdm;)0)lY66_MvYRbUCD7leKl5O)%wj_N3U-1Vb

diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
index dbc0141b2bbc77a6d806ff046dc137992c59a899..7e67a101b6df7e06299ce35bc8becc7cedd87c5f 100644
GIT binary patch
delta 207
zcmexovBiqZCD<jzM3#Ypv0@{aBwM{ZOMI|Xd~}n2j2?&)>=WR`5%1yY!sB>>hmRvZ
zAShgjm5GsyCAuNTDL+4+k(-f;F}hI@%yA5M3W#S6b_$PY6!2w>iFXfh6>(*Y_c1VM
sSfCf9&kQpVq^y7uO`r{Ip&8glt_C#q;ppna<00xH%9%DRvBii10BplJGynhq

delta 24
fcmdmD_0NLKCD<jTPKJSjF@GbMB-`ejY|&x>VsHmV

diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
index 1294f655d418dbdccc095e0d47ab220869a61a07..3d219cb4ffd801e2c1c005625053d9ccfdedb188 100644
GIT binary patch
delta 207
zcmZ4Dbjz8`CD<k8mLdZKqsvAvUAB66miS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwEMV|ynB0KPXlM*si-

delta 24
fcmccRyu^viCD<iIMUjDl(P|@?F5Bj}Y;UCiTGt0y

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
index 8012b5eb3155377dc7995b73059ecb267d19232c..a95cfee77a843a33f845781e3a5342e3f4f3a5d6 100644
GIT binary patch
delta 207
zcmexsve}HwCD<jzSek)>(PJZ*BwM{ZOMI|Xd~}n2j2?&)>=WR`5%1yY!sB>>hmRvZ
zAShgjm5GsyCAuNTDL+4+k(-f;F}hI@%yA5M3W#S6b_$PY6!2w>iFXfh6>(*Y_c1VM
sSfCf9&kQpVq^y7uO`r{Ip&8glt_C#q;ppna<00xH%9%DRu|<mj06sf6^Z)<=

delta 24
fcmdmN_Sb~VCD<jTR*Hdv(S9SBB-`ejY*8WrUxNn)

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
index 4fa0c6fe720f7859f0541b82f828c0329a3c0548..315c7b4ebf08253950974dbde2527f0dfd5bfcf2 100644
GIT binary patch
delta 207
zcmeB_+Aq!J66_MPpO=Aw(PAUl8J2o?miS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwF<%3{I+0Gio2^Z)<=

delta 24
fcmdll-6_T866_Mf$;-gNsJD^p49n&oR$~qTO*jSy

diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
index 0a891baf458abee4a772ffba7a31914ec22418ec..ad52073a1cd62f6d2349fc750529945eed912612 100644
GIT binary patch
delta 207
zcmexny2hN#CD<iojWh!T<AjY|l5F+vEb+lk@zG88F?t|Iuup&!N4$rp3y<Rk9zKrv
zfS_<8RwhO+mgt5Ur~LeQMs7wX#^^>tFvl_2DIlIP*eN`oQNWiiCf+^3Rm7Do-p9b4
sVS!$ZJ~PZfkg@_sG=Vm-g=SzIxf;;ahoh?xkB6v-C}-NN#CAml0LfuFA^-pY

delta 24
gcmZ2u{>_xjCD<k8n-l{BWBW!fNw&>5*)EF!0BJ@DGXMYp

diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
index 9b442a64cf711b33d80691fe84f1d3a6256f943b..2f0398a7c3f170a0ca70b95cc366d7ccba6f19b9 100644
GIT binary patch
delta 207
zcmexszuA$?CD<iovjPJHBilwUNw#`-miS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwEsV!JH~0EP89(f|Me

delta 24
gcmdn&_}8AxCD<k8uRH?-<KK;3l5CrAvfYvd0CAoO;{X5v

diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
index 1754c6878839fc657230e1e714cd7c5142e0a77e..be270fef6dc3ad2587020e62a94444da74eea7ca 100644
GIT binary patch
delta 207
zcmZ2ra?O;>CD<k8niK;A<Gqbs-K_QQEb+lk@zG88F?t|Iuup&!N4$rp3y<Rk9zKrv
zfS_<8RwhO+mgt5Ur~LeQMs7wX#^^>tFvl_2DIlIP*eN`oQNWiiCf+^3Rm7Do-p9b4
sVS!$ZJ~PZfkg@_sG=Vm-g=SzIxf;;ahoh?xkB6v-C}-L{g|$Zn08+a;1ONa4

delta 24
fcmca+y1<0XCD<iIL5hKa@ybT7Zr07-Y~3ONTvrDc

diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
index 9fc731d3d2bcde5e2612a8ccd81e12098134afe9..8c934dc62026695b7f865f40b2d1e560e984ffe5 100644
GIT binary patch
delta 207
zcmdmD`pS&UCD<h-OPYa!ao<KRNw#`-miS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwEsVw)ra0JHlz#{d8T

delta 24
gcmaE5w#AgoCD<ioixdL`<JOH_l5CrAvP~2L0A{@h*Z=?k

diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
index e654c83ebe40c413b204c711adcefe3f04655e8c..b51fd1e94b0b9c63ed4cb7360b63ec843cb82ccc 100644
GIT binary patch
delta 207
zcmew#v^9jwCD<jzREvRualu9|Nw#`-miS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwEsVvAJ<0Kow`t^fc4

delta 24
fcmdlQ@;`{nCD<jTUXy`=ar#CsNw&>5*<zFdX?h30

diff --git a/tests/data/acpi/x86/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
index fb89ae0ac6d4346e33156e9e4d3718698a0a1a8e..2a566507daaa72fd978be9928c1def349a151a55 100644
GIT binary patch
delta 207
zcmZ4Nc+-i?CD<h-Qjvjy(P1MOyJWpPOMI|Xd~}n2j2?&)>=WR`5%1yY!sB>>hmRvZ
zAShgjm5GsyCAuNTDL+4+k(-f;F}hI@%yA5M3W#S6b_$PY6!2w>iFXfh6>(*Y_c1VM
sSfCf9&kQpVq^y7uO`r{Ip&8glt_C#q;ppna<00xH%9%C`NKR%407T+ADgXcg

delta 24
gcmccVwAhi$CD<iou>u1FqxnWIcFE1hB`2{10AK<KI{*Lx

diff --git a/tests/data/acpi/x86/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
index 46fd25400b7c00ee9149ddb64cb5d5bd73f6a82b..cebd8d296b6c68ab647a622ff3fcd6fde25ae2ca 100644
GIT binary patch
delta 207
zcmdnu_{xdPCD<h-OOb(r@xewecFB5omiS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwD>kX*tJ0Olq+4gdfE

delta 24
gcmaFmw8fFjCD<ioivj}!<MoYP?2?<0OD<*y0BUgv9{>OV

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
index 61c5bd52a42242e85090934e8e45bf01642609d6..35168cd8b1af3aca861350a1fd8d6513005cb47f 100644
GIT binary patch
delta 207
zcmccM-R8^X66_MvrpCa)_;({0yJWpPOMI|Xd~}n2j2?&)>=WR`5%1yY!sB>>hmRvZ
zAShgjm5GsyCAuNTDL+4+k(-f;F}hI@%yA5M3W#S6b_$PY6!2w>iFXfh6>(*Y_c1VM
sSfCf9&kQpVq^y7uO`r{Ip&8glt_C#q;ppna<00xH%9%C`NFLw;0PP_;IsgCw

delta 24
gcmZqkz2ME|66_LkL6w1l@ykXocFE1hCHM0H0BDg2O8@`>

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
index 3aaa2bbdf54a0d0cade14421e84c6ec5a42f96fa..66b8c54802028a1817699aa61464ff3b24f3e672 100644
GIT binary patch
delta 207
zcmdnx{K19GCD<jTK#75Y@z_Q#cFB5omiS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwD>kX*$90OZ~|5&!@I

delta 24
gcmez1vdfvvCD<iomm&iL<KB&2?2?<0ORnSq0BcSNBLDyZ

diff --git a/tests/data/acpi/x86/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
index 944209adeaa5bbb722431161c404cb51b8209993..01eceb0596f51077bda38bcda1ca34ed3c3608fc 100644
GIT binary patch
delta 207
zcmccU*zU~b66_MvuE@Z^Xt0rsU9#StB|g|GKDx<1Mi0aY_6cy}i1+Yx;c>jc!^aUH
z5EL%N%EZXU65SBvl%F5Z$j!*a7~Loc<~RmB1;jH3JB7zH3iz_c#JdN$iny}H`xuxr
sEYOS5XNDOFQdYo-CeQ}9&<t!NR|A^*aCG(I@euV8<xHCeBoDF!06`WwQvd(}

delta 24
fcmZp7zUav166_LkQGtPhQGFv9yX5BMk_XrUUdsn$

diff --git a/tests/data/acpi/x86/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
index d9938dba8fa5d405f7696c0dbdc24f3ae42ec934..2e0bf9da001069e1b2392a755349d35776ac6400 100644
GIT binary patch
delta 207
zcmX>Q`z?;kCD<jTOrL>)F=itdyJWpPOMI|Xd~}n2j2?&)>=WR`5%1yY!sB>>hmRvZ
zAShgjm5GsyCAuNTDL+4+k(-f;F}hI@%yA5M3W#S6b_$PY6!2w>iFXfh6>(*Y_c1VM
sSfCf9&kQpVq^y7uO`r{Ip&8glt_C#q;ppna<00xH%9%C`NNx}X0M`CF4gdfE

delta 24
gcmewscOaI_CD<k8fF1(_WAH{UcFE1hCD)4r0Bzq09{>OV

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
index a24b04cbdbf09383b933a42a2a15182545543a87..8b2f64692c87800caeaddc4edefc78a3a82269f4 100644
GIT binary patch
delta 207
zcmeyEvOJB;CD<iI-I#%aamPk3cFB5omiS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwD>kW7>W0M-~d#Q*>R

delta 24
fcmZ3U_A!OaCD<jT(1?M7as5UvcFE1hB@-k8YK;fh

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
index 3a0cb8c581c8cc630a2ec21712b7f8b75fcad1c8..93e073386675dc5c8bffca451ec04f7a3148bdb0 100644
GIT binary patch
delta 209
zcmaFW&a|MDiOVI}C1gPh0|O)1MlN>AdUuxiV5j)#Ci@sY5F^+pz=<Q?!_$Sw@d6JY
zM|?m~xDYE7BNt0_LyS{?emo;LBNJnEqac{$80-`f&lv0!9?vM?%N7&w9^fkC$`<cq
uV9u~WFGimkW*|se0VA3~8`wfKu#H>|XzIh!)rZGJ)I*drZ5EKcl?4DKG&$!0

delta 26
icmZ3`$@Hq7iOVI}CFE5z0|O)DMlN>A&BrBgW&r?sY6$oM

diff --git a/tests/data/acpi/x86/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
index 20955d0aa30120553da35d5a6640055d26255cf9..b9ff78bcf6b3ebbeabba3ddbc65ee340a00210f8 100644
GIT binary patch
delta 207
zcmezDveJ#qCD<iIQ<;H*amhw5cFB5omiS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwD>kWA(T0E{d+SpWb4

delta 24
fcmZ4K_SuEYCD<jTSc!pwarQ<ocFE1hC6hP-W77v}

diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
index afcdc0d0ba8e41bb70ac20a78dcc8562ca0cb74b..cb55b14647fca8330ef7d9489e961acf036f4462 100644
GIT binary patch
delta 207
zcmez5y~3BvCD<iog&G3`<BN@4?2`5FEb+lk@zG88F?t|Iuup&!N4$rp3y<Rk9zKrv
zfS_<8RwhO+mgt5Ur~LeQMs7wX#^^>tFvl_2DIlIP*eN`oQNWiiCf+^3Rm7Do-p9b4
sVS!$ZJ~PZfkg@_sG=Vm-g=SzIxf;;ahoh?xkB6v-C}-L%Ao+*~04}3BtpET3

delta 24
gcmZ4C`^lTjCD<k8lPUuP<Nb|X?2?<0OFrZQ0B{`$z5oCK

diff --git a/tests/data/acpi/x86/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
index 228374b55bd544116e359f659e546fc66cf8a895..7efcc7fdc619d9bec6cd44e99d6db7a04efc6dcd 100644
GIT binary patch
delta 207
zcmbQ~cix}NCD<k8ygCB|W5Gr)X~}wbmiS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwEsk^IUF0NtQDYybcN

delta 24
fcmX@_KhuxPCD<iIQk{W;F>NE4wB+X7l3#cMTsjAR

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
index 45f911ada5645f158f3d6c0c430ec1d52cadc5d8..cf39dc40f1f4da9ba1d7eca6cfcf65ff502f12c2 100644
GIT binary patch
delta 207
zcmaFoxWt*uCD<ioi6R37W64G?cFB5omiS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwD>ki5qZ0J*L?3jhEB

delta 24
gcmZ4D{LYcfCD<k8odN>`WA;WacFE1hCGWBW0BDv78~^|S

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
index e5d6811bee1233d74236453c49060390d74d4416..1cc3fe668839663e748a3a41de95edcdcffceb66 100644
GIT binary patch
delta 207
zcmezExY3!*CD<ioqap(X<I{~??2`5FEb+lk@zG88F?t|Iuup&!N4$rp3y<Rk9zKrv
zfS_<8RwhO+mgt5Ur~LeQMs7wX#^^>tFvl_2DIlIP*eN`oQNWiiCf+^3Rm7Do-p9b4
sVS!$ZJ~PZfkg@_sG=Vm-g=SzIxf;;ahoh?xkB6v-C}-L%Ao-dd04@SKumAu6

delta 24
gcmdn!{M(VsCD<k8w*mtL<DHFM?2?<0OTJ<U0B|!1!2kdN

diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
index 46fd25400b7c00ee9149ddb64cb5d5bd73f6a82b..cebd8d296b6c68ab647a622ff3fcd6fde25ae2ca 100644
GIT binary patch
delta 207
zcmdnu_{xdPCD<h-OOb(r@xewecFB5omiS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwD>kX*tJ0Olq+4gdfE

delta 24
gcmaFmw8fFjCD<ioivj}!<MoYP?2?<0OD<*y0BUgv9{>OV

diff --git a/tests/data/acpi/x86/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
index 5ce081187a578ba7145a9ba20d30be36c13b7663..ee8f4837005d3a048f2a62bfda4a3011d4142746 100644
GIT binary patch
delta 207
zcmez5y~3BvCD<iog&G3`qtQk#cFB5omiS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwD>kbJ}g0Ht0y_W%F@

delta 24
gcmZ4C`^lTjCD<k8lPUuPqvl2~cFE1hB_Hwt0BHdT2mk;8

diff --git a/tests/data/acpi/x86/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
index bdf36c4d575bfc4eb2eac3f00c9b7b4270f88677..ffcd7613dfe1bbaa2b5ee20629353c56494c29bd 100644
GIT binary patch
delta 207
zcmeD6I_%Bm66_LkSe1c+@$*J5cFB5omiS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwD>ko?OH01VDKp8x;=

delta 24
fcmX@?-Rs5W66_MftIEK@_;Mo`yX5BMl7F}XT;d0?

diff --git a/tests/data/acpi/x86/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
index 1db43a69e4c2affd8bd678bbef4d3c228380288e..c7e20414146854c2c3be401dccd1c11d52a5f898 100644
GIT binary patch
delta 207
zcmbP{elCN{CD<jz&xC=2F?1sryJWpPOMI|Xd~}n2j2?&)>=WR`5%1yY!sB>>hmRvZ
zAShgjm5GsyCAuNTDL+4+k(-f;F}hI@%yA5M3W#S6b_$PY6!2w>iFXfh6>(*Y_c1VM
sSfCf9&kQpVq^y7uO`r{Ip&8glt_C#q;ppna<00xH%9%C`NOnj80EPKDg#Z8m

delta 24
fcmX??F(aMJCD<iohA{&Jqt8YzcFE1hCEKL{WyA-T

diff --git a/tests/data/acpi/x86/q35/DSDT.noacpihp b/tests/data/acpi/x86/q35/DSDT.noacpihp
index 8bc16887e1c963c61aaecf71712a09c0554f6d67..030f4429a3da37b24660b931dc8642d937e073b6 100644
GIT binary patch
delta 207
zcmZ4O@X(RVCD<k8p#lQ~<CTqEyTt3=S>l78;-j1FWAs3bV4nadj(87G7aqq8JbWDS
z0YTwHtW1ntEYS@yPWk!qjNFV&jM0sPV2)$3Q$Rdpuv2(Eqku14OuT!5tB5OGypMr7
s!veh+eP)<}AY}!NXaa3u3(debay6i-4@XxY9uH9uQO>mauy_Us0Iml*ivR!s

delta 24
fcmaFpxY~isCD<iITY-Ur@zh4HUE-UoB+@wmV@U^{

diff --git a/tests/data/acpi/x86/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
index c13e45e3612646cc2e30f00b3b7e53335da816ea..8b0954ecf4352151ed13d24383a1dc923ae94191 100644
GIT binary patch
delta 207
zcmbR0aN3c}CD<k8v;qSIBiBZ*N{M=RmiS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwE^l9<d60I?N0DF6Tf

delta 24
fcmX@@IMsp6CD<iIRDpqkkzpfOrNm}S$w}-0Q@RE_

diff --git a/tests/data/acpi/x86/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
index ba6669437e65952f24516ded954b33fe54bdedfb..4ae25f1731fa03ebdc81b2536ceacc067527f783 100644
GIT binary patch
delta 207
zcmZ4Kc;AW3CD<h-UXg);@zq8ycFB5omiS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwD>keta50MleR>;M1&

delta 24
gcmccbw9=8wCD<ior2+#3<HL<y?2?<0OU_^i0B9fw{Qv*}

diff --git a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
index 6ad42873e91c80cef5a42224cb4d31936dad59b4..e5b160f65a401adc26bf4aa87a20558438d8b6b6 100644
GIT binary patch
delta 207
zcmeBh+ULyW66_MPPmzIv@$*J5cFB5omiS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwD>ko>_80Py2Ea{vGU

delta 24
fcmdnz+~LIK66_Mfp~%3%_;Mo`yX5BMlHb_@S_=n+

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
index a24b04cbdbf09383b933a42a2a15182545543a87..8b2f64692c87800caeaddc4edefc78a3a82269f4 100644
GIT binary patch
delta 207
zcmeyEvOJB;CD<iI-I#%aamPk3cFB5omiS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwD>kW7>W0M-~d#Q*>R

delta 24
fcmZ3U_A!OaCD<jT(1?M7as5UvcFE1hB@-k8YK;fh

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
index 3a0cb8c581c8cc630a2ec21712b7f8b75fcad1c8..93e073386675dc5c8bffca451ec04f7a3148bdb0 100644
GIT binary patch
delta 209
zcmaFW&a|MDiOVI}C1gPh0|O)1MlN>AdUuxiV5j)#Ci@sY5F^+pz=<Q?!_$Sw@d6JY
zM|?m~xDYE7BNt0_LyS{?emo;LBNJnEqac{$80-`f&lv0!9?vM?%N7&w9^fkC$`<cq
uV9u~WFGimkW*|se0VA3~8`wfKu#H>|XzIh!)rZGJ)I*drZ5EKcl?4DKG&$!0

delta 26
icmZ3`$@Hq7iOVI}CFE5z0|O)DMlN>A&BrBgW&r?sY6$oM

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
index e381ce4cbf2b11f56a2d0537db4d21acc97450c9..f6028aa3db2bf393e9d8b0808031a9c5da61a1ab 100644
GIT binary patch
delta 207
zcmZp4+wRWg66_MPU73M_v2Y_7yJWpPOMI|Xd~}n2j2?&)>=WR`5%1yY!sB>>hmRvZ
zAShgjm5GsyCAuNTDL+4+k(-f;F}hI@%yA5M3W#S6b_$PY6!2w>iFXfh6>(*Y_c1VM
sSfCf9&kQpVq^y7uO`r{Ip&8glt_C#q;ppna<00xH%9%C`NPgr50EQVj;Q#;t

delta 24
fcmdn)-sr~V66_MfsLa5?n7)yVU2^kr$q$?WR1604

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
index a09253042ce4a715922027245de8a2ab7449c5b7..0f97da57b385f7603c14c9b14df5f96b75e1cdcd 100644
GIT binary patch
delta 207
zcmbR3cF~>7CD<k8qA~*mqxMEFcFB5omiS<&_~<747(Eap*eAe=Bi_T)g~#y%4<AQ-
zKv1|4D-$CZOLRkwQ+|FtBR3-xV|1e+nBy4i6cEoC>=Yi)DB#N$6Yn12D&oo(?_*%j
sus|<HpBZK#NLc|Rnm`-aLNl<9Tn%XI!_n1;$3xUZlrwD>kmTk90F8V&1ONa4

delta 24
fcmccUKHH7UCD<iITA6`?QE?*|yX5BMl3ZK>RksEe

diff --git a/tests/data/acpi/x86/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
index edc23198cdb47a981bcbc82bc8e392b815abb554..b060bcaab7df7e214d1c2a88b9dcbb92638f3383 100644
GIT binary patch
delta 209
zcmbO`k@4~*MlP3Nmylpj1_s6_8@bpe>)l!6gPr1|o9tusK#X9Y04I)k4^I~!#|u1s
z9Pt4`;X<rTj9e_y4KYsn`SFb0j7*Htje=l~W3W>|JY%p^cs!$kFI!B!dw{EmD_gve
ufjPqhy%>FFn1LW=1&n9{ZD0${z&3I<ps5c>S05e^Q4dkhv{^v1S04aYt2w9u

delta 26
icmcaSiE-{kMlP3Nmyo$03=E97H*&E{ZayyAqYnUiF9^8+

diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
index 64e81f571120e3eb2b8c6c9545293a78c75b7bbd..76623a06727ef11cce63c7f2abe0001199ca6896 100644
GIT binary patch
delta 207
zcmez2xz3x*CD<ioohkzZ<J*l~?2`5FEb+lk@zG88F?t|Iuup&!N4$rp3y<Rk9zKrv
zfS_<8RwhO+mgt5Ur~LeQMs7wX#^^>tFvl_2DIlIP*eN`oQNWiiCf+^3Rm7Do-p9b4
sVS!$ZJ~PZfkg@_sG=Vm-g=SzIxf;;ahoh?xkB6v-C}-L%Ao+qD06fMy!~g&Q

delta 24
gcmZ4I{lk;XCD<k8hYAA&<CBeC?2?<0OFriY0C8dn)c^nh

diff --git a/tests/data/acpi/x86/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
index d4acd851c62c956436a436f9fa6d08fc5f370fa7..21e0b9c63973933c7ed68c602322a940bae20e2c 100644
GIT binary patch
delta 209
zcmZph&a`I+6PHV{ONdPm0|Vo?ja=-K_3kY3!A|kfP4+Q*AV#oHfD=c&ho=jV;{_f*
zj`)C}a3NMEMlP1<h8U;({CGxgMkdDSMnN#gG1w^}o-x=dJf2a&mn|mVJ-}7Ol`Y=K
uz?@-$UW`67%s`N`0!B1}Hn4?eU>ms_(A0;cs}GNdsD~(L+AJVhRs;ZS7di3(

delta 26
icmdlpgQ;yg6PHV{OGsNc0|VpRja=-Kn~zJD76AZxDG37r

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 512d40665d..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,42 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/pc/DSDT",
-"tests/data/acpi/x86/pc/DSDT.acpierst",
-"tests/data/acpi/x86/pc/DSDT.acpihmat",
-"tests/data/acpi/x86/pc/DSDT.bridge",
-"tests/data/acpi/x86/pc/DSDT.cphp",
-"tests/data/acpi/x86/pc/DSDT.dimmpxm",
-"tests/data/acpi/x86/pc/DSDT.hpbridge",
-"tests/data/acpi/x86/pc/DSDT.hpbrroot",
-"tests/data/acpi/x86/pc/DSDT.ipmikcs",
-"tests/data/acpi/x86/pc/DSDT.memhp",
-"tests/data/acpi/x86/pc/DSDT.nohpet",
-"tests/data/acpi/x86/pc/DSDT.numamem",
-"tests/data/acpi/x86/pc/DSDT.roothp",
-"tests/data/acpi/x86/q35/DSDT",
-"tests/data/acpi/x86/q35/DSDT.acpierst",
-"tests/data/acpi/x86/q35/DSDT.acpihmat",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
-"tests/data/acpi/x86/q35/DSDT.applesmc",
-"tests/data/acpi/x86/q35/DSDT.bridge",
-"tests/data/acpi/x86/q35/DSDT.core-count",
-"tests/data/acpi/x86/q35/DSDT.core-count2",
-"tests/data/acpi/x86/q35/DSDT.cphp",
-"tests/data/acpi/x86/q35/DSDT.cxl",
-"tests/data/acpi/x86/q35/DSDT.dimmpxm",
-"tests/data/acpi/x86/q35/DSDT.ipmibt",
-"tests/data/acpi/x86/q35/DSDT.ipmismbus",
-"tests/data/acpi/x86/q35/DSDT.ivrs",
-"tests/data/acpi/x86/q35/DSDT.memhp",
-"tests/data/acpi/x86/q35/DSDT.mmio64",
-"tests/data/acpi/x86/q35/DSDT.multi-bridge",
-"tests/data/acpi/x86/q35/DSDT.noacpihp",
-"tests/data/acpi/x86/q35/DSDT.nohpet",
-"tests/data/acpi/x86/q35/DSDT.numamem",
-"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
-"tests/data/acpi/x86/q35/DSDT.thread-count",
-"tests/data/acpi/x86/q35/DSDT.thread-count2",
-"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
-"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
-"tests/data/acpi/x86/q35/DSDT.type4-count",
-"tests/data/acpi/x86/q35/DSDT.viot",
-"tests/data/acpi/x86/q35/DSDT.xapic",
-- 
2.43.5


