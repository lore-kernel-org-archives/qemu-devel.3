Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961FFC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubESo-0003kb-5R; Mon, 14 Jul 2025 04:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubEDy-0006Dg-VC
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubEDx-0003BP-1c
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752480464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MWNHzW/pd6HVTyab4Vh7H4ZoFA9QKdkJWu4/veDcfKQ=;
 b=R35c+NWY0fNmU1K8AkM+woVl7nCGt2SfJWPLEi4RqszaM1cCw04pG8Sno5N19zfpoIKP9I
 Bon3SpKr6KfoOBwrwQ3AXNzu48P7pMWZoTF5Q/AbDiuz0RjbDxicCJQ7ZmvDcsgKsaSrKD
 3W4J/ZFkKnTLO+w6nvfeI/TMacBjspI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-o65EPkHCOuexneUCuxKNOw-1; Mon,
 14 Jul 2025 04:07:40 -0400
X-MC-Unique: o65EPkHCOuexneUCuxKNOw-1
X-Mimecast-MFC-AGG-ID: o65EPkHCOuexneUCuxKNOw_1752480459
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BC42195608E; Mon, 14 Jul 2025 08:07:38 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.221])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 205731977000; Mon, 14 Jul 2025 08:07:33 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v7 10/36] tests/qtest/bios-tables-test: Update DSDT blobs
 after GPEX _OSC change
Date: Mon, 14 Jul 2025 10:04:54 +0200
Message-ID: <20250714080639.2525563-11-eric.auger@redhat.com>
In-Reply-To: <20250714080639.2525563-1-eric.auger@redhat.com>
References: <20250714080639.2525563-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Update the reference DSDT blobs after GPEX _OSC change. The _OSC change
affects the aarch64 'virt' and the x86 'microvm' machines.

DSDT diff is the same for all the machines/tests:

  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00001A4F (6735)
+ *     Length           0x00001A35 (6709)
  *     Revision         0x02
- *     Checksum         0xBF
+ *     Checksum         0xDD
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
@@ -1849,27 +1849,26 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
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

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

---
v3 -> v4
- fix the commit msg: dsl reverse diff (Jonathan)
---
 tests/qtest/bios-tables-test-allowed-diff.h   |   7 -------
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5158 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5244 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6519 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7603 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5360 bytes
 tests/data/acpi/riscv64/virt/DSDT             | Bin 3576 -> 3538 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 3023 -> 2985 bytes
 8 files changed, 7 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 333e5acf63..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,8 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/DSDT",
-"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
-"tests/data/acpi/aarch64/virt/DSDT.memhp",
-"tests/data/acpi/aarch64/virt/DSDT.pxb",
-"tests/data/acpi/aarch64/virt/DSDT.topology",
-"tests/data/acpi/x86/microvm/DSDT.pcie",
-"tests/data/acpi/riscv64/virt/DSDT",
diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
index 36d3e5d5a5e47359b6dcb3706f98b4f225677591..acab6e65febbc210158d4c39be0680bbb90250f5 100644
GIT binary patch
delta 114
zcmX@3u}p)@CD<iIO@x7g>C8kfX{JVpjp}Y(OkR^V=X2?C2#NTx$NL96vvg%MIJ<-!
zF7RWWyjw`i#5kckflEGNfxx86nT)j{87>a6yzr#S&Mx7`2@o*>kXS(iNMs?;W@BMV
FMgSUfAKd@|

delta 152
zcmZ3caYlp7CD<jzM}&caNqQoeG*i3NMs+tXCWon;^SSgm<T!#u0|FR0oI`?q7)0DS
z<Nbr3S-P?roL#~V7kIEwUN5BOX9QAG;Or7^3{q7MBDmy1<N|?7lQS7>L29`;z&gYx
bO@^t12n&FO3qXoN;!Cm@@@?i7mSh9~5Tq&5

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
index e6154d0355f84fdcc51387b4db8f9ee63acae4e9..54c27e7d95b4956ed1b5dee0d299ccb08dc2a73e 100644
GIT binary patch
delta 114
zcmZ3a`A37xCD<jTMudTZsdFNiG*i3lM)f&dOkR^VALY{H5EAiWkM|FDX6ediaCQkd
zT;Rt#Sx{KZ#5kckflEGNfxx86nT)j{87>a6yzr#S&Mx7`2@o*>kXS(iNMs?;=1yTr
FMgUJNAb|h?

delta 152
zcmeyPu}G84CD<iokq83=(~XH-(oDVX8`bA<F*!`#e3VO%LyjXjG$4S1!#O0#he5=R
zGu}VgnWZb6!PzC;aDfN=WL9A<KO>Nm0%w<SW00z95Wyu6A{Piunw-g43sTF)0oEZl
bX);V5L|6bMTmVuG5?_+NkZ*Icup}b@<J&8B

diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
index 33f011d6b635035a04c0b39ce9b4e219f7ae74b7..4330bc97cba0950191c45ac833533db7a190db81 100644
GIT binary patch
delta 114
zcmbPh{N0GlCD<jTT#|u->Fq==X{M&B8`a&on7k%!&gatO5EAiWkM|FDX6ediaCQkd
zT;Rt#dAE?3iE%=80+)Qk0)a`BGZ||^GF%*BdErTuon69>6Ch#&AhCi3kjO%w&Bnr6
FYyg6XAvXX3

delta 152
zcmexvG}oBRCD<iot|S8klg&gfX{L_p8`a&om>i~V&gatOkmCpr4G3W1a1IIbVGwcS
zjQ0<AX6ediaCQkdT;RbzdA*R9pAkq&fwN1vF-TQ4h~Sb3kqZPSP0nPj1*zrY0P7H&
bG#RE2A}jzBE&wS8i7&}s$hVnSIExJcpiV0*

diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
index c0fdc6e9c1396cc2259dc4bc665ba023adcf4c9b..7fdbc03e2bf9fb7d35704779253de36e362f0bf9 100644
GIT binary patch
delta 207
zcmexwz1f<}CD<iovn&Gx)9r~|(oB6fHmbXEG5NM`&ga^|E+pc^9`7IQ%+i(3;Or7^
zxWJEfa-NKqiE%=80+)Qk0)a`BGZ||^GF%*BdErTuon69>6Ch#&AhCi3kjO%w$<JhL
aH-8e+V`TE0v{^|+kAs?qZ+<2t$p`>t?mg51

delta 282
zcmdmN{ok6)CD<k8zbpd-Q^!OuX{N5b8`a&on4CK{=W}gfm*WTy4G3W1a1IIbVGwcS
zjQ0<AX6ediaCQkdT;Rbz*-%K!&j_TXz}Y3-7^JEiL~zN2$OQtECTB9%g4A+xfOUvX
unhaA15f%Um7l0Il#Fu0*<lEdYl+DQGFm>}EVLcA|TR*v9$aeB|nL7Yd7E^Zs

diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
index 029d03eecc4efddc001e5377e85ac8e831294362..969b4f6560d3ae39f5b7e0064b7122905476fce8 100644
GIT binary patch
delta 114
zcmbQH^+A)%CD<k8g9rly)24}B(oEex8`TB4nY<=#w&d315EAiWkM|FDX6ediaCQkd
zT;Rt#xm8%p#5kckflEGNfxx86nT)j{87>a6yzr#S&Mx7`2@o*>kXS(iNMs?;=D)&{
Fi~vUbAmso6

delta 152
zcmeyMIZcbpCD<iIOq79viGL!OG*hGhMs)#hCWon;ExGkL<T!#u0|FR0oI`?q7)0DS
z<Nbr3S-P?roL#~V7kIEwt`yetGXg0oaCQkd2C1qB5nS>ha)H34$(f9`Ahlc^U>#zU
bCd1T0gatst1t7&B@g>;{`8Hn{mSh9~yBaCk

diff --git a/tests/data/acpi/riscv64/virt/DSDT b/tests/data/acpi/riscv64/virt/DSDT
index 6a33f5647ddd6de3a0f000f718b58f6fff44f0fd..527f239dab13a00ad42e5a70b8dc2b89f12aa84a 100644
GIT binary patch
delta 113
zcmew%eMy?jCD<k85-$S-lgdOcX(r!W8`WD`nA|39UdN)vAtd6%9`7IQ%+i(3;Or7^
zxWJEf@;4qW6XS&H1TMLR1p<>MXEN4;WVkrM^1_oQJG+D%CqTpmKw<?6Ad!VUlk<4H
E0ByV>p#T5?

delta 151
zcmca4{X?3|CD<k82QLEyQ_(~&X(s2p8`WD`n0%&eUdN)vA;%FM8W6z1;T#g=!yw|u
z8SfwL%+i(3;Or7^xWI#b@+%%KKO>Nm0%w<SW00z95Wyu6A{Piunw-g43sTF)0oEZl
aX);V5L|6bMTmVuG5?_+NkZ-aFZx;X$O)QlF

diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
index 8eacd21d6ecdf9a3cd3e4f03cf1b40748dcbf53e..ba258f454dc0e59ef2fd67e0ce37e270e7c122e8 100644
GIT binary patch
delta 113
zcmX>vzEYgaCD<ioB{u^D)Axy7(oD|VH>#&HG5Ji`+{YxqAtd6%9`7IQ%+i(3;Or7^
zxWJEf@*XZN6XS&H1TMLR1p<>MXEN4;WVkrM^1_oQJG+D%CqTpmKw<?6Ad!VUlTEm1
F0{}^9AprmY

delta 151
zcmZ1}eqNl*CD<k8JU0Ualj}q-X(rE|8`V>pn4BhW?qd?*kmCpr4G3W1a1IIbVGwcS
zjQ0<AX6ediaCQkdT;Rbzc>|Z0pAkq&fwN1vF-TQ4h~Sb3kqZPSP0nPj1*zrY0P7H&
aG#RE2A}jzBE&wS8i7&}s$Tyjfdo}=5#47aw

-- 
2.49.0


