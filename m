Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBD4CCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI6W5-0002FZ-DX; Sun, 09 Nov 2025 09:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6W3-0002FK-OJ
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6W1-0001ow-NN
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762698937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LFArUVOXUNIre6IYeQ7+Je+E4A2RV5Gu/4n3yh1Oct4=;
 b=ZV1n1TgKrwplpa02y7XHbQdWZ99F01l/qEkcNNmIvzHot+xmmUGzYV0dpzgwNY1x7dUKcC
 XMTl/zgIF8ZrpzPIUVA05pr0vvcmQ2t4v4NJVhyvii3a93sPsQb/2R8n8EYZD6PTo/r82e
 BYmjtIEB68RJSzIMYMcFRCLxr50W9n4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-CemaqsCpNjW33PppkWWxcg-1; Sun, 09 Nov 2025 09:35:35 -0500
X-MC-Unique: CemaqsCpNjW33PppkWWxcg-1
X-Mimecast-MFC-AGG-ID: CemaqsCpNjW33PppkWWxcg_1762698935
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b2f79759bso913791f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762698934; x=1763303734; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LFArUVOXUNIre6IYeQ7+Je+E4A2RV5Gu/4n3yh1Oct4=;
 b=OTIZDAPrA3y+tW8TzfjYg6DyxHVqVD9xkJC51O+fEiPuyQG4AkTBIJeiZ78Z2itO9p
 IPkbtnAVLfMN35hNwQS0C6F9bdB9OkjVwqyz9DgOCANN9SGwC/t9w6gOA1QabLni9NIz
 9iRv6tSYZzL6wUtlR2UgMVwk8PtEvq8OombHX2bLP9AlbOEbjh0Zs9p6rAYy+6cLwdwn
 C35KYN5Vh3XOGTyZgXx85mW9SzW5v0YaSYGz0Kpv08GwMfMXdaAJKo6lSbgjAhEhkf66
 4TwPKsKSgjoKgKyHjHILWBi6ONtdrCxMqwgACknkMnTeC6azTYLe7+vKLZTNuQxhCMY4
 FDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762698934; x=1763303734;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LFArUVOXUNIre6IYeQ7+Je+E4A2RV5Gu/4n3yh1Oct4=;
 b=dv7m5Ii3eR4u711p90zqbFmU3flgKHSwszrWtzKdsH3h4iDvYlHR1WxPivTb4lK+ud
 sEbL2Mgr4pUKB4Noi5BdB+ATqo8EaoVaZd/hGuEh9m5dUunXMG3QkkDhY5S2FOoBAVBF
 pAV2ujcx3rylFJ5b0PTZ0ACmi5EmttSswBzlBzabaQPx4RZpG5DU816Tyo1CUbAGGvwB
 vCKvqzx2lOVDtWUAv5cwpF6pPBrM5tiKujBCEayjGOUm0EYqJaSRnnMBxkiL9LJgrpM8
 6jMWS8AMWb2UsHrSYaKa5hnb5ESCtCchoA2F6AwQ9XBTkIKFjC0MifUxverTt05vs9bc
 Ohug==
X-Gm-Message-State: AOJu0YzHbLwRpxOkRGPO57nu2vbYBtOBahKsUKAC2WLhCBeCXnbxEQyP
 tdNOoOXrcs9TLF94C8HgPLMuTxeETNDy83lvjfQyoDSzeZVas8joKPizoYmDZZtQlZ+O0AkWUNM
 62FLzI3bfF0Cxy4o1UHRY89Q8wgRrT4ncpSml8/IcPGinMWpKzXJGPegN5dMCVN8quqoq40Cah0
 iXsSMD+e+2+LGpUEhP3+0IogAbpn3UPiXbkg==
X-Gm-Gg: ASbGncugj6GlZSAPp9pVugt/FFx5KSE+cRrpNECcGiYHtFicxIgmrn4UhyL9Difi7SJ
 4x7n0kdAu7jYcGVvzNzBOEt039nmQ6ir5QxVoBzPRSTfsWKyYVdy6lirEQG2SzaYqoyU3fgl5nW
 hJ69OW5V+RaBbYQvBotbURZ64D6Al+7BAyyHZ/hRdrRkq/0EKnFTMCE/vIu0fuyYwRfbCBBqRh8
 Hir/4UopQYtRgOj9zdz6Lq7ZNU/qCqBqLycsft/R+AWj53CRVwwPcqTAfrlEDyHmD/c25a35aZ5
 e/d3+2tdc3paPF1me0AsiGdWWnhAuNoA8mgLabgHrTbMgadlUAlMQwaiR0zz4JGfGrE=
X-Received: by 2002:a05:6000:40c7:b0:42b:32d1:28c6 with SMTP id
 ffacd0b85a97d-42b32d12d9bmr2450897f8f.63.1762698934284; 
 Sun, 09 Nov 2025 06:35:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHduG3Rx4z6ph5zvIZVWYZ38SsEo8IiAfIHPrfeENzG77p4XIkM5V4vVrDqLPaXkIvBYlB7Q==
X-Received: by 2002:a05:6000:40c7:b0:42b:32d1:28c6 with SMTP id
 ffacd0b85a97d-42b32d12d9bmr2450862f8f.63.1762698933638; 
 Sun, 09 Nov 2025 06:35:33 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe63ba87sm17792975f8f.14.2025.11.09.06.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 06:35:33 -0800 (PST)
Date: Sun, 9 Nov 2025 09:35:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 11/14] tests/qtest/bios-tables-test: Update DSDT blobs after
 GPEX _DSM change
Message-ID: <ccf166d89dcf57c9d333f05173851f90e416097a.1762698873.git.mst@redhat.com>
References: <cover.1762698873.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1762698873.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Update the reference DSDT blobs after GPEX _DSM change. This affects the
aarch64 'virt', riscv64 "virt", loongarch64 "virt" and the x86 'microvm'
machines.

DSDT diff is the same for all the machines/tests:

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20230628 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/aarch64/virt/DSDT, Fri Oct 10 11:18:21 2025
+ * Disassembly of /tmp/aml-E6V9D3, Fri Oct 10 11:18:21 2025
  *
  * Original Table Header:
  *     Signature        "DSDT"
  *     Length           0x000014D9 (5337)
  *     Revision         0x02
- *     Checksum         0xA4
+ *     Checksum         0xA5
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\_SB)
     {
         Device (C000)
         {
             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
             Name (_UID, Zero)  // _UID: Unique ID
         }

@@ -1822,33 +1822,33 @@
                 Else
                 {
                     CDW1 |= 0x04
                 }

                 Return (Arg3)
             }

             Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
             {
                 If ((Arg0 == ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
                 {
                     If ((Arg2 == Zero))
                     {
                         Return (Buffer (One)
                         {
-                             0x01                                             // .
+                             0x00                                             // .
                         })
                     }
                 }

                 Return (Buffer (One)
                 {
                      0x00                                             // .
                 })
             }

             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251022080639.243965-4-skolothumtho@nvidia.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h   |  16 ----------------
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5337 -> 5337 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5423 -> 5423 bytes
 tests/data/acpi/aarch64/virt/DSDT.acpipcihp   | Bin 6246 -> 6246 bytes
 .../acpi/aarch64/virt/DSDT.hpoffacpiindex     | Bin 5391 -> 5391 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6698 -> 6698 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7812 -> 7812 bytes
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev  | Bin 10274 -> 10274 bytes
 .../data/acpi/aarch64/virt/DSDT.smmuv3-legacy | Bin 10274 -> 10274 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5539 -> 5539 bytes
 tests/data/acpi/aarch64/virt/DSDT.viot        | Bin 5354 -> 5354 bytes
 tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4603 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5824 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4609 bytes
 .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4905 bytes
 tests/data/acpi/riscv64/virt/DSDT             | Bin 3538 -> 3538 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 2985 -> 2985 bytes
 17 files changed, 16 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index e2fce2e972..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,17 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/DSDT",
-"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
-"tests/data/acpi/aarch64/virt/DSDT.memhp",
-"tests/data/acpi/aarch64/virt/DSDT.pxb",
-"tests/data/acpi/aarch64/virt/DSDT.topology",
-"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
-"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
-"tests/data/acpi/aarch64/virt/DSDT.viot",
-"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
-"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
-"tests/data/acpi/riscv64/virt/DSDT",
-"tests/data/acpi/loongarch64/virt/DSDT",
-"tests/data/acpi/loongarch64/virt/DSDT.topology",
-"tests/data/acpi/loongarch64/virt/DSDT.numamem",
-"tests/data/acpi/loongarch64/virt/DSDT.memhp",
-"tests/data/acpi/x86/microvm/DSDT.pcie",
diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
index 38f01adb61e6e4704821cee5e397888bb6b7e46d..35a862e44714d26ded01d40dc147e76cc73a1c84 100644
GIT binary patch
delta 26
icmcbqc~g_iCD<k8rU(NA)6$Jx7Q&1So1KNHF#-T`5(jwz

delta 26
icmcbqc~g_iCD<k8rU(NA(~^x`7Q&2-o1KNHF#-T`3<r4t

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
index 37a9af713b94a3fd34907dc86c40aaa79e93239c..7ce35f0d8606d17f3ddb9aa090c97c7ac9a38982 100644
GIT binary patch
delta 26
hcmZ3lwO)(MCD<iIUzCA?sbC{lpD-iC=9$9N7y)3m2K4{{

delta 26
hcmZ3lwO)(MCD<iIUzCA?DSsnZpD-ii=9$9N7y)3g2K4{{

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpipcihp b/tests/data/acpi/aarch64/virt/DSDT.acpipcihp
index 04427e2d8eb8d2db0a7ae3dbe546d9072406d09b..6d1765c31017dede80d1d87f8fa7c6dd055d1839 100644
GIT binary patch
delta 26
hcmaE6@XUbACD<h-O@e`esc<8gg)k$-W@lk#Rsd@^29E#$

delta 26
hcmaE6@XUbACD<h-O@e`esbC|Qg)k%IW@lk#Rsd@;29E#$

diff --git a/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex b/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
index 43ab60496e5a06706d4626d9e7b58b2d7e809e75..61cce30c7471faa4a9b7e3562dcb4ab9b3519a21 100644
GIT binary patch
delta 26
hcmeCz>eu3O33dtL7iC~z^4Z8`A<W3I*;)7uBLGsg1^WO1

delta 26
hcmeCz>eu3O33dtL7iC~z^4`d0A<W3Q*;)7uBLGsa1^WO1

diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
index 3c391674446167bc9c79fd5dcb1c37e80cc7bbae..ffc5f1c0d1090582672c60ade3eb1bc41acc5ef7 100644
GIT binary patch
delta 26
hcmZ2wvdV<ZCD<iIONxPk>B>ef3t>iv&CbHl*#KgY2MquK

delta 26
hcmZ2wvdV<ZCD<iIONxPk>GDP{3t>ja&CbHl*#KgS2MquK

diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
index 71c632cedcca63a77a4cdde53d9bc392102687b6..f98dcbfc6b823bce6d5710e8056a4e260fb92a02 100644
GIT binary patch
delta 33
pcmZp%ZL#HY33dr-kz-(B65YtPONfzS^HCu#E=GpU7i6|D0sxh>2=D*^

delta 33
pcmZp%ZL#HY33dr-kz-(B65hzQONfzi^HCu#E=I=97i6|D0sxhu2=D*^

diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
index e8c2b376df7bddc2392945ea8cbb550b3d3b5e26..6c12a7aaf8a6315bac968a685f5b6673e7248817 100644
GIT binary patch
delta 55
zcmV-70LcHMP@+%@L{mgmA}9a=0;{nKx)K2Zv&9mO2@C+F5d#4LTY^ahOfZws5=yhD
N9JL7n0JB{t#R0hw5ElRd

delta 55
zcmV-70LcHMP@+%@L{mgmA}9a=0;sVHx)K2av&9mO2@C<G5d#4LTY^ahOfZws5=yhD
N9JL7n0kd5u#R0h45ElRd

diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
index e8c2b376df7bddc2392945ea8cbb550b3d3b5e26..6c12a7aaf8a6315bac968a685f5b6673e7248817 100644
GIT binary patch
delta 55
zcmV-70LcHMP@+%@L{mgmA}9a=0;{nKx)K2Zv&9mO2@C+F5d#4LTY^ahOfZws5=yhD
N9JL7n0JB{t#R0hw5ElRd

delta 55
zcmV-70LcHMP@+%@L{mgmA}9a=0;sVHx)K2av&9mO2@C<G5d#4LTY^ahOfZws5=yhD
N9JL7n0kd5u#R0h45ElRd

diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
index 9f22cd3dc81efe3ebcb8caf913842a8dea910627..208a3163a6bf2a59cf421418dcb16ad1156285c6 100644
GIT binary patch
delta 26
icmZ3iy;z&eCD<iou_yxr)69)rOd^a7n|Vd1F#-T#9R_9q

delta 26
icmZ3iy;z&eCD<iou_yxr(~ON=Od^bon|Vd1F#-T#7Y1ek

diff --git a/tests/data/acpi/aarch64/virt/DSDT.viot b/tests/data/acpi/aarch64/virt/DSDT.viot
index dd3775a0762ae1a5ddb89dd656d81eee581dccb6..f81e3e6cc794d77ea66b7e27b1afe56e248132b6 100644
GIT binary patch
delta 26
hcmaE*`AU<^CD<k8l?Vd^llw+43t>iv&CbHh83A%X2VVdH

delta 26
hcmaE*`AU<^CD<k8l?Vd^liNlv3t>ja&CbHh83A%R2VVdH

diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
index 55aa34f988d6ef69293e91c5fe45bee0a02bc5f1..09aa903c4e875f541223e36f59b28e101599df20 100644
GIT binary patch
delta 26
icmeyZ{9BpJCD<k8w;%%pW6Vab$vlh<o9FSwvH}2l69@SK

delta 26
icmeyZ{9BpJCD<k8w;%%pWAsL@$vljVo9FSwvH}2l4F~xE

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.memhp b/tests/data/acpi/loongarch64/virt/DSDT.memhp
index c0955eb60448cc5f4d38d410abc260ae54ea2e9a..a069d6878fb45fa6b0e6342eedb0eb3d25eb20da 100644
GIT binary patch
delta 26
icmX@0dq9`VCD<k8fEWV<W8y}x$vlh<o9FQ;aRC5qod+-g

delta 26
icmX@0dq9`VCD<k8fEWV<W5PzR$vljVo9FQ;aRC5qmj^Ha

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.numamem b/tests/data/acpi/loongarch64/virt/DSDT.numamem
index 61e47e7252155dcf9c76879c4f60f4b3eef63f86..78ece52f57a383db128c7d1a08526e15ab911bb7 100644
GIT binary patch
delta 26
hcmZovX;k5I33dr#6k=dte7=!uG7lre=6O8HtN>Vb2A==`

delta 26
hcmZovX;k5I33dr#6k=dte72EmG7lr;=6O8HtN>VV2A==`

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.topology b/tests/data/acpi/loongarch64/virt/DSDT.topology
index b2afebc938ce45d798c8aa5f45a463f1617e257e..7ab23f47cc82dd7bc1975e17893a8cd61039e66d 100644
GIT binary patch
delta 26
icmZ3fwo;ADCD<iIQ<#B)@%%=v$vlh<o9FR#vjG5Njt4CO

delta 26
icmZ3fwo;ADCD<iIQ<#B)@!UqP$vljVo9FR#vjG5NhzBhI

diff --git a/tests/data/acpi/riscv64/virt/DSDT b/tests/data/acpi/riscv64/virt/DSDT
index 527f239dab13a00ad42e5a70b8dc2b89f12aa84a..968e1a15c87bb5753b3a84ddb357e26312767220 100644
GIT binary patch
delta 25
gcmca4eMy?jCD<k85-$S-lj=sUVqQju$#uLT0Ac+G$N&HU

delta 25
gcmca4eMy?jCD<k85-$S-lgdV}VqQkZ$#uLT0AcqA$N&HU

diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
index ba258f454dc0e59ef2fd67e0ce37e270e7c122e8..b646a05551c1ed902413a462442346ce246f8675 100644
GIT binary patch
delta 25
gcmZ1}zEYgaCD<ioB{u^D(~pf@mfVaClU=w|0bO|puK)l5

delta 25
gcmZ1}zEYgaCD<ioB{u^D)Ax;BmfVbtlU=w|0bO$juK)l5

-- 
MST


