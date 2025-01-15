Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D733C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7p1-0006OB-EZ; Wed, 15 Jan 2025 13:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7oz-0006Ne-BB
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:08:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7ov-0006W9-El
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3FeAuh1rxp1eg5yr5tRzEYlxvGW6OBKkk6dC9Q5CjiM=;
 b=XcxRiwungcyDXSapVBO2GOgH1NKQSpv8oC3emVYK3lx/20nMQ854azv2/7WBq2IgqTmciK
 OqxCNMG05lXlCC1v0sXs+qL1bJT3PZWZ2vPRXXrsqiKeOhxPFxC8edkgY66nCvxrZh21BR
 FSNaBU2PKQt8sAhSmiEfWP4eDqMjYj0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-3QK4xvOWOi2XjVg_fbpPoA-1; Wed, 15 Jan 2025 13:08:46 -0500
X-MC-Unique: 3QK4xvOWOi2XjVg_fbpPoA-1
X-Mimecast-MFC-AGG-ID: 3QK4xvOWOi2XjVg_fbpPoA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-386333ea577so38859f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:08:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964525; x=1737569325;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FeAuh1rxp1eg5yr5tRzEYlxvGW6OBKkk6dC9Q5CjiM=;
 b=hgX2BV/EUrKnK12BKDzGOfTdByEtMzFiIpy5FSGEUA30IDBWTjW1UGUYnn8OVPcr9j
 2IXG7bubWrtW5y7cXMIeh7wSmTM7diUDn3Ew/PhpCtmNqyo6njChyiLUtrk8gYxfYleo
 mYJZsQh8NhB8LpmHD9MupmiiX4YDVL2bZA4atrJK0BUQliLU0sgKPPmAJFL5EbifGJGz
 2M3S+kLgtltmbyYTZ4ONjRUPrZr0/GsU7fUesh7VFYk6ta/B7HFZxSCOIGIqlpcfNik2
 74sXsu9LyCTeAL4pbzZUSDloQMRJ5sFTAmbTeM8J8/zh2ZmpIl9Fzx8lqI98YonJKYAP
 DboQ==
X-Gm-Message-State: AOJu0YwVe2EZpR9tp4eSkfDGEFa40xEpyHnD8/Bn8069gysCNTWMDNUH
 rxzWr4fqqF2A/kWPcsvAzXZZBLgnrYYCXU+diRaLaGNw6IUzAur0sEB6QtGiLLBsbW0vmkJPAir
 XHtDz6JGT668lC5VghJRRmHUcVXDGo8AJQKnpF0HIv8i6YpkKuMqhyTr4J+BN4pYayb/V3MzHTS
 ooiUvcqZ6zeClzWJ2516x/5T3ZwfZZDA==
X-Gm-Gg: ASbGncvTPK8OZD1dEPDP24mT7HPpXuBKiqRuzqUk7RMPRCHCPBLljWYRigUFqs4zYBh
 Z+pXVqb9W37p1Allco3UQ3a0lyNaKrujlgJkAPHVapW0zX3kBP643CwNXJ25QEoL4GZjHVLHOkp
 aRI4Mdt2D9skYBDrPnDoEdltUi5V9fIKctElKqgYQSlNmvYBiOeRVQSe5yj76tWIzdLNGVoFHgJ
 5JlTE2FIefPp5qDC3s0omW6gzn0EH6eNTPybx3iilYY5C3NXlME
X-Received: by 2002:adf:a411:0:b0:38a:87cc:fbee with SMTP id
 ffacd0b85a97d-38a87ccfd10mr20253190f8f.14.1736964524434; 
 Wed, 15 Jan 2025 10:08:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd75eugmtAzHK9kKC4FU2FyRyVn3R9Sgrt8ZjRqDvlMqDfdZa7tRuGmHRqhuEFHZBSIAvZbA==
X-Received: by 2002:adf:a411:0:b0:38a:87cc:fbee with SMTP id
 ffacd0b85a97d-38a87ccfd10mr20253158f8f.14.1736964523482; 
 Wed, 15 Jan 2025 10:08:43 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c749a127sm31754215e9.7.2025.01.15.10.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:08:42 -0800 (PST)
Date: Wed, 15 Jan 2025 13:08:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Eric Mackay <eric.mackay@oracle.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 05/48] tests: acpi: update expected blobs
Message-ID: <9ccb69df554a5204077cda101b7bcf0f19544553.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
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

From: Igor Mammedov <imammedo@redhat.com>

previous patch has changed cpu hotplug AML, expected diff:

@@ -2942,6 +2942,7 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPC    ", 0x00000001)
             {
                 Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
                 Name (CNEW, Package (0xFF) {})
+                Name (CEJL, Package (0xFF) {})
                 Local3 = Zero
                 Local4 = One
                 While ((Local4 == One))
@@ -2949,6 +2950,7 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPC    ", 0x00000001)
                     Local4 = Zero
                     Local0 = One
                     Local1 = Zero
+                    Local5 = Zero
                     While (((Local0 == One) && (Local3 < One)))
                     {
                         Local0 = Zero
@@ -2959,7 +2961,7 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPC    ", 0x00000001)
                             Break
                         }

-                        If ((Local1 == 0xFF))
+                        If (((Local1 == 0xFF) || (Local5 == 0xFF)))
                         {
                             Local4 = One
                             Break
@@ -2972,10 +2974,11 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPC    ", 0x00000001)
                             Local1++
                             Local0 = One
                         }
-                        ElseIf ((\_SB.PCI0.PRES.CRMV == One))
+
+                        If ((\_SB.PCI0.PRES.CRMV == One))
                         {
-                            CTFY (Local3, 0x03)
-                            \_SB.PCI0.PRES.CRMV = One
+                            CEJL [Local5] = Local3
+                            Local5++
                             Local0 = One
                         }

@@ -2992,6 +2995,16 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPC    ", 0x00000001)
                         \_SB.PCI0.PRES.CINS = One
                         Local2++
                     }
+
+                    Local2 = Zero
+                    While ((Local2 < Local5))
+                    {
+                        Local3 = DerefOf (CEJL [Local2])
+                        CTFY (Local3, 0x03)
+                        \_SB.PCI0.PRES.CSEL = Local3
+                        \_SB.PCI0.PRES.CRMV = One
+                        Local2++
+                    }
                 }

                 Release (\_SB.PCI0.PRES.CPLK)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20241210163945.3422623-4-imammedo@redhat.com>
Tested-by: Eric Mackay <eric.mackay@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h   |  42 ------------------
 tests/data/acpi/x86/pc/DSDT                   | Bin 8526 -> 8593 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8437 -> 8504 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9851 -> 9918 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15397 -> 15464 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 8990 -> 9057 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10180 -> 10247 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8477 -> 8544 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5033 -> 5100 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8598 -> 8665 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9885 -> 9952 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8384 -> 8451 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8532 -> 8599 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12319 -> 12386 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8355 -> 8422 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8372 -> 8439 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9680 -> 9747 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12565 -> 12632 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8634 -> 8701 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8401 -> 8468 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 11968 -> 12035 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12913 -> 12980 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33770 -> 33837 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8819 -> 8886 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13146 -> 13213 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10009 -> 10076 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8430 -> 8497 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8443 -> 8510 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8372 -> 8439 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9714 -> 9781 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9485 -> 9552 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13208 -> 13275 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8235 -> 8302 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8213 -> 8280 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8361 -> 8428 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8456 -> 8523 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12913 -> 12980 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33770 -> 33837 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8961 -> 9028 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 8987 -> 9054 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18589 -> 18656 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14612 -> 14679 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35718 -> 35785 bytes
 43 files changed, 42 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index a1047913af..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,43 +1 @@
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
-"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
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
diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
index 8b8235fe79e2fa08a6f840c8479edb75f5a047b9..60d50b088a362556fd54395cb15364d6c0936be5 100644
GIT binary patch
delta 191
zcmX@-G|`#MCD<ioq9OwWqy0v%ojgoV&XbSwY+!P*m|V{Lm)%p!IoR2cW3nutxHgBg
zpKG`f(|-<US1%tSrvC*D$pwrli~L0=r!W>Uq!chF6fh(fFr+T><DR^U&zFO5;^aiG
z|C3WEGx0kpEl`;pqt6l_>=Ym1>}e1X<QnW8<Qv9VklX<>EtR1(b#ghspHu-u(jq68
psY$5?&0vWnhGgdux5#8J=E*bp)mejl!%CAT$MK16zRh1O2mpbPI&}a5

delta 140
zcmV;70CWG5L(W19L{mgmP9XpQ0co)cxeNkNK9j`^umVjplXngM2Sye{Q$tP&lN}Bh
zAP7TFMOP96|8M|fZ~<hZL=ux^0dN3hZ~<U&0AZp`43oVMO#=y&VUrRMKp>$vpf!_R
uF9csxLSIlrNia}SMN>mkO;!OzR7P223Imhz4;7Pi4^ER_4i>W>5OWbzU?~#-

diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
index 06829b9c6c6d726d955dc7c99bc9f42448e22aeb..4c434c25c0b1602f22128e352781df498fa69ddf 100644
GIT binary patch
delta 191
zcmezBxWkFdCD<jzLXm-iv3(=gP97#F=gCKTHZVC@OfKjB%kC-V9PI4JF<F*RT${t$
z&ox|#=|6|FtCx=u)Bgg7<O0T&MgF3bQy2>vQVJLo3K$X#7*ZGcaZldF=gYx2adINp
z|H-M7nfM))7N|^)(PxPdc8U*h_B03xat(G4@(p7wNbUfcmda3?I=P(RPpW_+X^|7l
p)TGpcX0SvOL$Y&-TVyg9^W>TQ>a0P&VWmlv<M_lj-{zMR1OThaI#&Py

delta 140
zcmV;70CWGiLiIrkL{mgm^&kKM0kW|QxeNkNK9j`^umVjplXngM2Sye{Q$tP&lN}Bh
zAP7TFMOP96|8M|fZ~<hZL=ux^0dN3hZ~<U&0AZp`43oVMO#=y&VUrRMKp>$vpf!_R
uF9csxLSIlrNia}SMN>mkO;!OzR7P223Imhz4;7Pi4^ER_4i>W>5E>Em)hYD=

diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
index 2fe355ebdbb858fa9247d09112e21712e3eddc45..61b7d5caa55c44dbf69d649110c6b14bb4c3fdf5 100644
GIT binary patch
delta 175
zcmezEv(J~yCD<iopBe)L<DZROJ9(HKJtrUK*}&v)ySbc~gOSNgYH}l=iZX|@tCx=u
z)Bgg7<O0T&MGj(<Qy2>vQVJLo3K$X#7*ZGcb5GvO=f}Y}adINp|H-M7`S=}_7N|^)
z(PxPdc8U*h_B03xat(G4@(p7wNbUfcmda3?I=PwOPo{t&X^|7l)TGpcX0SvOL$Y&-
ZTVyg9b3yWCM?O{NAm6af=lR!&0RY%RHrfCH

delta 117
zcmV-*0E+*<P5Vp=L{mgmdnNz?0Vc5uxeNkMM3cn~umVguvv&;$0Rl%BlYtH-7;pe%
zZ~<hZMG})_0dN3hZ~<U&0AZp{43o$XP6G*(VUr#YKm?&Tpf!_V4;2YRR7P223IlKf
XlVJ}NlYkFS0$V4O!3`6$DG-$w=m8<V

diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
index 4d4067c182a6625db1e877408eb7436113884b50..d43e148bed19160f39d88ccf3364544150a3f87f 100644
GIT binary patch
delta 191
zcmZ2l@uGsuCD<h-!-j!@(RU-)P97#F=gCKTHZVC@OfKjB%kC-V9PI4JF<F*RT${t$
z&ox|#=|6|FtCx=u)Bgg7<O0T&MgF3bQy2>vQVJLo3K$X#7*ZGcaZldF=gYx2adINp
z|H-M7nfM))7N|^)(PxPdc8U*h_B03xat(G4@(p7wNbUfcmda3?I=P(RPpW_+X^|7l
p)TGpcX0SvOL$Y&-TVyg9^W>TQ>a0P&VWmlv<M_lj-{$wy0RZuvI{*Lx

delta 140
zcmV;70CWH7c%^s>L{mgmB|HEC0e7(qxeNkNK9j`^umVjplXngM2Sye{Q$tP&lN}Bh
zAP7TFMOP96|8M|fZ~<hZL=ux^0dN3hZ~<U&0AZp`43oVMO#=y&VUrRMKp>$vpf!_R
uF9csxLSIlrNia}SMN>mkO;!OzR7P223Imhz4;7Pi4^ER_4i>W>5K1hi?<t-D

diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
index 045a52e75b7fcd4e5f840a758c548231498b96e4..9fda0b56638e02097e58dd4536c9c5955986e88e 100644
GIT binary patch
delta 167
zcmbQ|_Rx*XCD<h-QJH~(annYwojgoV36qcVY+!N--CWLV$;j>{<s9tn$1(W>ulVG1
zd>qOg&aPfQLQMY)7?KMZQx-XhO-^AfU`Q!oOekPTEMQ1o<j+0%9iJZu-^9s@T>mGh
zPPXTFU|ygydGbPjVIIbU<PMPjREE;j$y@mSqzV|47CEs@O-e0j21_I{Bs+(=MJ97G
RPrk;l&K%?$wn;!v7yuUwG#~%~

delta 134
zcmV;10D1r6MxI6rL{mgm9wPt%0nM=rxeNkNTa(2MumVj`vv&<S0S8AGLsLUe2$S#)
z7n9Bo2pDhxV{idvqD2yuWC3shWN-msZ~$SVO$?Ly4o(9JlVOuj4?qN=H=s3>kq;Fd
oLsUjtV+sRs0bDNxUsFO~P(w*DP*O!xLsCsvld%s@vqcab6Skcv^Z)<=

diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
index 205219b99d903555125c4b07fc047c42993eb338..5b6471c8db9003b39bf5e20af34061f3e71cdbd5 100644
GIT binary patch
delta 173
zcmX@&-yXo_66_MfuED^-7{8J0EDw`+$mE+m8<;#jH+S<YFfw^bO<v2VqRip!>g6NE
z^uK^1xqvZck%QRe6vhIElmf<t0*1r_hSWv=+>>AO`El?~oSew@e{$+%D}D#11uBzc
z^jYGAo#F$WJq-eaT!Wp1e8U(Ek~=`Ar81PJPF~ONCsn|Zw8)8NYEo)JGgu;tA=x>^
XEi##ldGbYmb><-7u+6{uPl^Ko(i=8M

delta 141
zcmZn<IO5Oc66_LkM4f?wapp#@vph^50h4d?Y+!P8-Q3Nqz{un-HhC?dibMfJasgw?
zB3GfwDU1aSDFuuP1q_Lce0e5+;qznWoSZn>i{HU?q4@&S$uasY@xe~<0nVNV0YR?8
e&OyFmjLso$k;z=l1&mlEC$Hi6+w354TpR%WuPVd<

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
index 8fa8b519ec65bd5099c45f4e1c85b11b47a23845..67fe28699fbb261cfc7a52b2291f9965ab93c6a8 100644
GIT binary patch
delta 191
zcmbR1^uUSBCD<h-L6L!hv3MibP97#F=gCKTHZVC@OfKjB%kC-V9PI4JF<F*RT${t$
z&ox|#=|6|FtCx=u)Bgg7<O0T&MgF3bQy2>vQVJLo3K$X#7*ZGcaZldF=gYx2adINp
z|H-M7nfM))7N|^)(PxPdc8U*h_B03xat(G4@(p7wNbUfcmda3?I=P(RPpW_+X^|7l
p)TGpcX0SvOL$Y&-TVyg9^W>TQ>a0P&VWmlv<M_lj-{yA`1OS&)I%EI<

delta 140
zcmV;70CWG~LY+biL{mgm9U%Y!0iCf5xeNkNK9j`^umVjplXngM2Sye{Q$tP&lN}Bh
zAP7TFMOP96|8M|fZ~<hZL=ux^0dN3hZ~<U&0AZp`43oVMO#=y&VUrRMKp>$vpf!_R
uF9csxLSIlrNia}SMN>mkO;!OzR7P223Imhz4;7Pi4^ER_4i>W>5JC}S!YKj(

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
index 01719462a72fd6d40ce433dac601e4b94eae574c..077a4cc988dc417a1bc9317dddd2dbd96ff1ff50 100644
GIT binary patch
delta 195
zcmZ3f{zje4CD<k8jW7cPWAa9>9Bw8j=gAe^8<-p{CTsEhW%rbF4tDnAn0$dpT${t$
z&ox|#=|6|FtCx=u)Bgg7<O0T&MgF3bQy2>vQVJLo3K$X#7*ZGcaZgU=_2uB3I60B)
z|K!xkTX`Ln7N|^)(PxPdc8U*h_B03xat(G4@(p7wNbUfcmda3?I$4X)PpW_+X^|7l
t)TGpcX0SvOL$Y&-TVyg9^W=P9vB`gV1X+W8!%CAT3-XF>?&FhY1pt{dJ23zN

delta 157
zcmaE(zEYjbCD<ior7!~nWA8?;9Bw9myU7*Y8<>2JCu{NiWp@*E4tDnAn0$dpT!F*c
z&ox|#>3;!3asgw?A{U{_DU1aSDFuuP1q_Lce0U}o@cJ@yPEMSBl-I#@q4@&S$uasY
u@xe~<0nVNV0YR?8&OyFmjLso$k;z=l1&mlEC#&=MO%~)8+kBBvniT*|<t>~5

diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
index 0ca664688b16baa3a06b8440181de4f17511c6b0..9b2e81a7bcefb5c0e2dfbd2bbc5b6ea501f86306 100644
GIT binary patch
delta 191
zcmbQ{eAAiBCD<k8rXm9a<L-@IJ9(I#oF^aU*}&vrF}a-gFT1CdbFi}?$7ESPacvG~
zKi6;}rvDtyu3kPuO#cfQk_#A97Ws=#PGKxyNGV`UC}2n|U`So$$31xypDzdB#L0<V
z|0kzTX5x2HTA(sHMxP}<*eO21+0!5($TiqG$Ty6!Ah`o%S}H?n>f~~MKdAzSq(x3F
pQ<G8)n!yrD49U(RZjs4c%#&yGtFs3AhLt8wj^h*Ce4Br_AOIIQJCXnZ

delta 140
zcmV;70CWG@LzY7dL{mgmmLUKD0p+m@xeNkNK9j`^umVjplXngM2Sye{Q$tP&lN}Bh
zAP7TFMOP96|8M|fZ~<hZL=ux^0dN3hZ~<U&0AZp`43oVMO#=y&VUrRMKp>$vpf!_R
uF9csxLSIlrNia}SMN>mkO;!OzR7P223Imhz4;7Pi4^ER_4i>W>5W5k-i7GGv

diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
index 03ff464ba4e72082fce0921815cfc09ca20b561a..9c66ccf150af1622d1b788a1ae04a6e5136cff9e 100644
GIT binary patch
delta 191
zcmbR1`@omWCD<k8ff@q?qwq$qojgn)&XbSwY+!P;m|V{Lm)%p!IoR2cW3nutxHgBg
zpKG`f(|-<US1%tSrvC*D$pwrli~L0=r!W>Uq!chF6fh(fFr+T><DR^U&zFO5;^aiG
z|C3WEGx0kpEl`;pqt6l_>=Ym1>}e1X<QnW8<Qv9VklX<>EtR1(b#ghspHu-u(jq68
psY$5?&0vWnhGgdux5#8J=E*bp)mejl!%CAT$MK16zRiC~3;@iTJ1_tM

delta 140
zcmV;70CWG~O`S~&L{mgmohASP0b8*OxeNkDKa<4_umVFglXngM2Sye{Q$tP&lN}Bh
zAP7TFMOP96|8M|fZ~<hZL=ux^0dN3hZ~<U&0AZp`43oVMO#=y&VUrRMKp>$vpf!_R
uF9csxLSIlrNia}SMN>mkO;!OzR7P223Imhz4;7Pi4^ER_4i>W>5W*IV{wdA?

diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
index b081030f0ed171e52b13e28cfdc8770a04c2806e..28dbd8d8949d1421da9312cf0440d7ae3b64916e 100644
GIT binary patch
delta 195
zcmX@$*zCmR66_MftjNH?$gz=2n}^BCd9pdr1||oK$uD{SvU^H72Rr+5Oz!6u*XD5c
za}5__`p@C)>g6NE^uK^1xqvZck-zBV6vhIElmf<t0*1r_hSWuV+>=%Kd^z|gPEO?d
zKRI=B37><~0+q=z`YiFmPVoWGo(2IyuEEYhzF~|7$sHimQW;89C%@$LlPX|HTI9qs
tH7T{A87z^+kn9}d7MaY&JXw!VZ1NsnLDnGOu+pT-7kI@s`|=kH0sxakI)4BF

delta 157
zcmZp6I^f9V66_LkK!JgQ(Rd@5HV>1(-DGo~4NShqlV9@uWp@*E4tDnAnB31RuE62!
z=Nc}=^uK^1xqvZck&Dpe6vhIElmf<t0*1szK0K54`Fxo<CnrvB;d3xuXuiO7a*RGp
ue6Uk|fU~DTK#*&&bC7QsqjQK`WHJ|X0V5X4$<O%wCSTwc+dP54SP%dOB`#_J

diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
index 2c98cafbff5db04410b35a1151eaf18723a4dad7..e256bbce790152f045247db631d9f1da81f90499 100644
GIT binary patch
delta 191
zcmccOG~JoYCD<iox*`Ju<LQlDJ9(HqoF^aU*}&vxF}a-gFT1CdbFi}?$7ESPacvG~
zKi6;}rvDtyu3kPuO#cfQk_#A97Ws=#PGKxyNGV`UC}2n|U`So$$31xypDzdB#L0<V
z|0kzTX5x2HTA(sHMxP}<*eO21+0!5($TiqG$Ty6!Ah`o%S}H?n>f~~MKdAzSq(x3F
pQ<G8)n!yrD49U(RZjs4c%#&yGtFs3AhLt8wj^h*Ce4D>g5CHdWJ0$=B

delta 140
zcmV;70CWGBL)1bFL{mgmR3QKW0TZzbxeNkDKa<4_umVFglXngM2Sye{Q$tP&lN}Bh
zAP7TFMOP96|8M|fZ~<hZL=ux^0dN3hZ~<U&0AZp`43oVMO#=y&VUrRMKp>$vpf!_R
uF9csxLSIlrNia}SMN>mkO;!OzR7P223Imhz4;7Pi4^ER_4i>W>5P1<Qdnm&I

diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
index da018dca9e3102e811107994248719ab5278c505..0557810ddc18dc280d039163c72b25428a2486c1 100644
GIT binary patch
delta 191
zcmbQA@F;=HCD<h-$$)`@@$^QnojgoV&XbSwY+!P*m|V{Lm)%p!IoR2cW3nutxHgBg
zpKG`f(|-<US1%tSrvC*D$pwrli~L0=r!W>Uq!chF6fh(fFr+T><DR^U&zFO5;^aiG
z|C3WEGx0kpEl`;pqt6l_>=Ym1>}e1X<QnW8<Qv9VklX<>EtR1(b#ghspHu-u(jq68
psY$5?&0vWnhGgdux5#8J=E*bp)mejl!%CAT$MK16zRmBV000k|J01W4

delta 140
zcmV;70CWH1V4q+LL{mgmA20v_0rjy8xeNkNK9j`^umVjplXngM2Sye{Q$tP&lN}Bh
zAP7TFMOP96|8M|fZ~<hZL=ux^0dN3hZ~<U&0AZp`43oVMO#=y&VUrRMKp>$vpf!_R
uF9csxLSIlrNia}SMN>mkO;!OzR7P223Imhz4;7Pi4^ER_4i>W>5JVulO)0zp

diff --git a/tests/data/acpi/x86/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
index fb89ae0ac6d4346e33156e9e4d3718698a0a1a8e..51ad37a351bffae8fbc9ba17f72c25ef61822f59 100644
GIT binary patch
delta 180
zcmZ4N_{@>ZCD<k8nF0d?Bkx8oc1b2D=gGp78<-p{CLfjj%kC-V9PI4JG1)*yeDVV+
z4rLB!S1%tSrvC*D$pwrli~L0=r!W>Uq!chF6fh(fFr+T><DMk#%fUBsaw6CN$*GeA
zq#cwNs7#L0XNeDXiVtx1GzbWC4R#Ll4Pz`w?f@B<%21j*`KYv?Q~^WMA}5xqNvQ?R
eV2LD#WakjK$Yd_&$<L+LnS*@8HVev3VgUdW&^H4B

delta 109
zcmV-z0FwXaL8CzmL{mgmqaXkP0XMM<2N?oSK9ds}umVjplf@bR0!9{-#2O?RZ~$X)
z0c4^?5|d;BZ~$a*0bp<dVWLb7lM5S70|}F1lVBS_1)(>fHItJ;91{ouLsUjtV+sS4
PKO7a4!W&MrRveH7+b|#D

diff --git a/tests/data/acpi/x86/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
index 46fd25400b7c00ee9149ddb64cb5d5bd73f6a82b..dbd4f858354df0f4c050fd0b914581154f340ee8 100644
GIT binary patch
delta 180
zcmdnu_}!7qCD<k8y8;6P<Jyf}?2=4Q&Xa{DH!wL^Og<|4m)%p!IoR2cW3qva_~Zvt
z9LgNdu3kPuO#cfQk_#A97Ws=#PGKxyNGV`UC}2n|U`So$$302fmxFKO<V3FjlT#-L
zNINJkP?;Q~&k`T(6d&O1X%G<P8tfe88^&0W+yOEym7z3s@=<9&sRD+iMNTYJlTr(s
e!4gRf$<85ek;z=llb=hgGY9#GZ5EVS%mM(N(>Lb;

delta 109
zcmV-z0FwXrL9{^%L{mgmv>*Tg0oSn#2N?oSK9ds}umVjplf@bR0!9{-#2O?RZ~$X)
z0c4^?5|d;BZ~$a*0bp<dVWLb7lM5S70|}F1lVBS_1)(>fHItJ;91{ouLsUjtV+sS4
PKO7a4!W&MrRve)OE4?7a

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
index 61c5bd52a42242e85090934e8e45bf01642609d6..952752e30e9dfc9e2085e8fceaa0740dda6db89c 100644
GIT binary patch
delta 159
zcmccMJ=urLCD<iISdD>!@#ID>c1b2j&&k4)8<_lUHy@ScU}W-=ntWbLMVZ6d)yqeS
z>3;!3asgw?A_uX_DU1aSDFuuP1q_J=45^F!xhHc=`*HA1oSew@e{$;N7-<Kl1uByl
zNQ-h8BzJ&xr!thLPQEDZCsV+Xw8)8NYEo)JGgu;tA=x>^Ei##lxgdFRzmzI-kZ;&#
IS((k80E*WzCIA2c

delta 141
zcmbR2bHSU-CD<k8f+_<8<Cl$G?2=4=E|Y~NH!%5FZayl>!N}w;Hu=1iibMfJasgw?
zB3GfwDU1aSDFuuP1q_Lce0e5|N&7K#PEMShBkf?i(0qaE<QRRH_+Y2_0B28wfFRdk
e=OEuOM&}T>$Yd_&0!A#7lg~-}ZBCNe$O!;@8!4;+

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
index 497706c9742a9ea5396d6c9c4cc1cc2a4a530339..e95258cbd8681103a642f8973bd1ac9ef229cff7 100644
GIT binary patch
delta 173
zcmbQ5bR&t&CD<h-!jOT1F>fOmyCjpp-(+FQ4NShyn~zG0Ffw^bO};IqqRip!>g6NE
z^uK^1xqvZck%QRe6vhIElmf<t0*1r_hSWv=+>^zn{W$n0PEO?dKRI=BhO~py0+q=z
z`YiFmPVoWGo(2IyuEEYhzF~|7$sHimQW;89C*PI!lPX|HTI9qsH7T{A87z^+kn9}d
W7MaY&Jo&%0I&+Y3*k(<cHzELbaWy#r

delta 141
zcmcbSG&PCKCD<iI)R2LJars6rc1b25ugSua8<@Q8Hy@Q0VPtX_n|xbJMWTQqxqvZc
zk*m<;6vhIElmf<t0*1szzC4qar2UvVCnrv>kajR#XuiO7a*RGpe6Uk|fU~DTK#*&&
ebC7QsqjQK`WHJ|X0V5X4$+x8aHs{H_5&-}%Gbwuj

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
index 3aaa2bbdf54a0d0cade14421e84c6ec5a42f96fa..ba2a7d0004be7cd7220716dc7e8594be87197b98 100644
GIT binary patch
delta 200
zcmdnx{MVVwCD<k8uOb5jW6MS^c1b4BkjcW58<^ZZHy@Q$VC3|Yat?O(<A_$CTqq^1
z`~N?Ov!83Y5YvASXIC#DA*TNY49NwIDT^G$CZ{kKFr*YPCKNCv7BHkP^5>qcEbYg^
zH*s<z*Z;|>lS`x>loqH=j?rg{4|a+VaP~9^2yzW}4)P6SEJ*GEnU=~>nmYNVw4YP~
yL((EAmZ?dp1<hcIB!*<?5Vy!=F6PO4(qfZ$O9`?D`G%DyO+GIrw%J!EmlXghfj&V1

delta 162
zcmezCyvv!(CD<iomm&iL<KB&2?2=4w0h5I#H!!)lZaylhz{u$?<{a$o#}TbOxll@2
z>HmKYXFu0)A*TNY49NwIDT`c%CZ{kKFr*YPCKNCvF7oA>tS9Zq%sDx6a*MQs=|b}b
zrjujzS>l78;scyL4FZB(gPntX!x)`I+#-{?m<t%ONKSqx?Kk<nl-TA8GP$e(dgCz@

diff --git a/tests/data/acpi/x86/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
index 944209adeaa5bbb722431161c404cb51b8209993..b6cb840953ea539092f601e08b7122fc999b3e1b 100644
GIT binary patch
delta 180
zcmccUIK_#}CD<iIM3I4k@y|vsc1b2D=gGp78<-p{CLfjj%kC-V9PI4JG1)*yeDVV+
z4rLB!S1%tSrvC*D$pwrli~L0=r!W>Uq!chF6fh(fFr+T><DMk#%fUBsaw6CN$*GeA
zq#cwNs7#L0XNeDXiVtx1GzbWC4R#Ll4Pz`w?f@B<%21j*`KYv?Q~^WMA}5xqNvQ?R
eV2LD#WakjK$Yd_&$<L+LnS*@8HVeueU;zLMk2fp;

delta 109
zcmV-z0FwWdLeW7AL{mgm(I5Z-0VlBv2N?oSK9ds}umVjplf@bR0!9{-#2O?RZ~$X)
z0c4^?5|d;BZ~$a*0bp<dVWLb7lM5S70|}F1lVBS_1)(>fHItJ;91{ouLsUjtV+sS4
PKO7a4!W&MrRvf+r*iaw}

diff --git a/tests/data/acpi/x86/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
index d9938dba8fa5d405f7696c0dbdc24f3ae42ec934..1939fda2507cde6fcb6f7a093897f9bd2cb987ef 100644
GIT binary patch
delta 180
zcmX>Q+Z@N`66_Mftk1x}sIifYU6RSkd9twN1||oK$wwvsvU^H72Rr+5Og4}apZq|I
zLz%<b)yqeS>3;!3asgw?B7f1zDU1aSDFuuP1q_J=45^F!xF<>ba_~)@oXGWma_Zy&
zX$PeRDwAXMS>l78;scyL4FZB(gPntX!x#&aJ3xk|GL)uHJ}T`eRltz6$cbfYQffgn
dSR#ob**U~5GMS5c@^fi*<{;m&&4M!Pg#eBZHfR6<

delta 109
zcmV-z0FwWMUcg-nL{mgmz%Bp)0aLLG2N?oSK9ds}umVjplf@bR0!9{-#2O?RZ~$X)
z0c4^?5|d;BZ~$a*0bp<dVWLb7lM5S70|}F1lVBS_1)(>fHItJ;91{ouLsUjtV+sS4
PKO7a4!W&MrRvfJo@Ma)J

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
index a24b04cbdbf09383b933a42a2a15182545543a87..41c0832ab5041ff5361598813ec28fe7442b191b 100644
GIT binary patch
delta 168
zcmeyEvL%(vCD<ioixC3@W9vpPc1fm&gvr8^8<~1THXoC$VrKV}at?O(<CxqaBR)A!
zmP47t+11NOi0OX;LvjIQ$|47`$tjEl3@HVS2?Y#^1q`W+{JAIB$@+2dO`M#_^?!2e
z<nyu)%nMW|Pd1bj=3y*I?f~geWhhOZ>>}qURltz6$cbfYQffgnSR#ob**U~5GMS5c
Ra+;hvbC7S?<_U5Sg#j0XG*JKm

delta 134
zcmV;10D1qkW$|PRL{mgmaWVh^0k5$N2N?p5TayzRu>y)vv&I>E0|!SILsLUe2$O&u
z7n5Ec2pDhxV{idvqD2yuWC3shWN-msZ~$SVO$?KX9ZmxYlVOwJ9Y6%3H=s3>As!VR
oLsUjtV+sRs0bDNxUsFO~P(w*DP*O!xLsCsvlR+L%v(+Bo6Qh?Xg#Z8m

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
index 3a0cb8c581c8cc630a2ec21712b7f8b75fcad1c8..153b45f0f7443d25cecc2a752fb6dbd921160e78 100644
GIT binary patch
delta 160
zcmaFW&a}3JiOVI}B}BJ{fr0VbMlN<qrq1%o!jc=A+Hy7@lT_nn@|K$XPEAFL!`ao#
zM~LZv0Yh>DW6B~&vB@cn1q>+#j0pt{i3JR)iyS6vst0iJO`M#_^?!2e<QjDcrUfdK
z52%ZB7bJIpG^a9@rcVB-?k7{gkhI8&WolAtK{Hq)i6PlJ#4R$Ji@6|q@;WtD<{;m&
J&9)kAqXG4WGspk{

delta 142
zcmZ46!St$~iOVI}CFE5z0|O)DMlN<qrnchA!jc=Anlm;ZlT_nn@(`Q+PEAF;fFZen
zF=dgP(Bu@x0)~_V#)JZf#6^CSP1FOJIVUGh?ooFzU1+|*baIS7OMI|Xe1Nm3K|qje
fuyc@a7^8EDTVyg9a{(h3$;t23{Wdpgtd0f%C_O9p

diff --git a/tests/data/acpi/x86/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
index 20955d0aa30120553da35d5a6640055d26255cf9..231bc23d932e832ffa12dd253bcf54245b5ef88f 100644
GIT binary patch
delta 158
zcmezDvdxvtCD<ion-T*9W5Y%+c1b3ugvr8^8<-qIHy@R>WMuM^nk22F%;D_n<s-!O
zzkngRfH7r}gV^L0#sY?v0>*>_hQtDf)J6W>lWnB^IQS+`PUQMOIdyWcv;)%umB|;S
zMY#)-J3zWq8A?+pGs*bL6fh($a$=d9lv>aXmPleqb`EiiOy*)PNS=H^N|iatH*B+?
Hj4B%dq#Q5J

delta 124
zcmV-?0E7RwMe{@oL{mgmb0Po$0h_T32N?oSTayzRumVj`v&9)X0Rl%Bk{cu#Z~$X)
z0c4^@5|d;BZ~$a*0bp<dVWLe8lSdm)0|}F1lbstt1fe&eHIv^P6&yoUMp<JD18@Oc
eF9csxLSIlrNia}SMN>mkO;(ft8&0#693uw7dL)Se

diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
index 3c34d4dcab16783abe65f6fa5e64eb69d40795fb..0f1ccdfcc3ffbf151c172015cc4bf18bc4ead218 100644
GIT binary patch
delta 180
zcmcbWHaDHiCD<iot}z1xqvJ*{c1b2D=gGp78<-p{CLfjj%kC-V9PI4JG1)*yeDVV+
z4rLB!S1%tSrvC*D$pwrli~L0=r!W>Uq!chF6fh(fFr+T><DMk#%fUBsaw6CN$*GeA
zq#cwNs7#L0XNeDXiVtx1GzbWC4R#Ll4Pz`w?f@B<%21j*`KYv?Q~^WMA}5xqNvQ?R
eV2LD#WakjK$Yd_&$<L+LnS*@8HVevliUR;Q^EU(l

delta 109
zcmV-z0FwWmXWC{8L{mgmS~CCu0c)`e2N?oSK9ds}umVjplf@bR0!9{-#2O?RZ~$X)
z0c4^?5|d;BZ~$a*0bp<dVWLb7lM5S70|}F1lVBS_1)(>fHItJ;91{ouLsUjtV+sS4
PKO7a4!W&MrRvbqc@Dv~7

diff --git a/tests/data/acpi/x86/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
index 228374b55bd544116e359f659e546fc66cf8a895..eb5b6e9f52107d9c95e38e94a67a6b5001beafc1 100644
GIT binary patch
delta 173
zcmbQ~cgK&*CD<h-MxB9yQFkMkv?P;v$YgcN4NRV%n{P@gFfw^bP5v#VqRip!>g6NE
z^uK^1xqvZck%QRe6vhIElmf<t0*1r_hSWv=+>_0v{W$n0PEO?dKRI=BhqQyz0+q=z
z`YiFmPVoWGo(2IyuEEYhzF~|7$sHimQW;89C;yf9lPX|HTI9qsH7T{A87z^+kn9}d
W7MaY&JXu~wojJ%iY_q4#1ug)C4>Y*|

delta 141
zcmccPH`9;HCD<iIQk{W;F>NE4v?P;9z+`pF4NPvXn{P@gFfzG|P5v#VB2mDQT)>#J
z$W>@^3S$97N&#a+0Yl;<U!KWM(tgaGlM^S;kajR#XuiO7a*RGpe6Uk|fU~DTK#*&&
ebC7QsqjQK`WHJ|X0V5X4$-kuiHuuS#;{pIXrYYJ0

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
index 45f911ada5645f158f3d6c0c430ec1d52cadc5d8..524fc9f4ee09fd7a5bec62818fd87b6ec300dee8 100644
GIT binary patch
delta 180
zcmaFoxY3ErCD<jzP?3Rw(P1MOyCjp7^JHPk4NMLelaEUNW%rbF4tDnAm~0>;KKX$Z
zhcbt=tCx=u)Bgg7<O0T&MgF3bQy2>vQVJLo3K$X#7*ZGcaZi%=<=~q*Ig#uC<kZOl
z(hf=sR3^vhv&08G#RoWh8UzHn20I7&hA|c-cYq8_WhhOZd{o*`s(>MBkrT_*q|}0D
eutX9=vU7-AWHJ}?<mb}r%t5|kn+0X=vH$?gzc%Cm

delta 109
zcmV-z0FwW)LheBdL{mgm?jQgF0c)`e2N?oSK9ds}umVjplf@bR0!9{-#2O?RZ~$X)
z0c4^?5|d;BZ~$a*0bp<dVWLb7lM5S70|}F1lVBS_1)(>fHItJ;91{ouLsUjtV+sS4
PKO7a4!W&MrRvg;|6`>%)

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
index e5d6811bee1233d74236453c49060390d74d4416..d04d215a1d0fbc77739084d100a35af47a1c1a62 100644
GIT binary patch
delta 180
zcmezExX+2pCD<jzPLY9uapOiVc1b2D=gGp78<-p{CLfjj%kC-V9PI4JG1)*yeDVV+
z4rLB!S1%tSrvC*D$pwrli~L0=r!W>Uq!chF6fh(fFr+T><DMk#%fUBsaw6CN$*GeA
zq#cwNs7#L0XNeDXiVtx1GzbWC4R#Ll4Pz`w?f@B<%21j*`KYv?Q~^WMA}5xqNvQ?R
eV2LD#WakjK$Yd_&$<L+LnS*@8HVewUVgUd#3pa@X

delta 109
zcmV-z0FwW{Li<4qL{mgm`yc=S0o<_)2N?oSK9ds}umVjplf@bR0!9{-#2O?RZ~$X)
z0c4^?5|d;BZ~$a*0bp<dVWLb7lM5S70|}F1lVBS_1)(>fHItJ;91{ouLsUjtV+sS4
PKO7a4!W&MrRvhRAPqrav

diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
index 46fd25400b7c00ee9149ddb64cb5d5bd73f6a82b..dbd4f858354df0f4c050fd0b914581154f340ee8 100644
GIT binary patch
delta 180
zcmdnu_}!7qCD<k8y8;6P<Jyf}?2=4Q&Xa{DH!wL^Og<|4m)%p!IoR2cW3qva_~Zvt
z9LgNdu3kPuO#cfQk_#A97Ws=#PGKxyNGV`UC}2n|U`So$$302fmxFKO<V3FjlT#-L
zNINJkP?;Q~&k`T(6d&O1X%G<P8tfe88^&0W+yOEym7z3s@=<9&sRD+iMNTYJlTr(s
e!4gRf$<85ek;z=llb=hgGY9#GZ5EVS%mM(N(>Lb;

delta 109
zcmV-z0FwXrL9{^%L{mgmv>*Tg0oSn#2N?oSK9ds}umVjplf@bR0!9{-#2O?RZ~$X)
z0c4^?5|d;BZ~$a*0bp<dVWLb7lM5S70|}F1lVBS_1)(>fHItJ;91{ouLsUjtV+sS4
PKO7a4!W&MrRve)OE4?7a

diff --git a/tests/data/acpi/x86/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
index 5ce081187a578ba7145a9ba20d30be36c13b7663..f73ade9bf6e4545f9912ed654a282884a54cec79 100644
GIT binary patch
delta 180
zcmez5z14@yCD<jzRE>dw@xewec1b1==gGp78<^ZICLfjj%kC-V9PI4JG1)*yeDVV+
z4rLB!S1%tSrvC*D$pwrli~L0=r!W>Uq!chF6fh(fFr+T><DMk#%fUBsaw6CN$*GeA
zq#cwNs7#L0XNeDXiVtx1GzbWC4R#Ll4Pz`w?f@B<%21j*`KYv?Q~^WMA}5xqNvQ?R
eV2LD#WakjK$Yd_&$<L+LnS*@8HVeu;<OBd!Z#TXG

delta 109
zcmV-z0FwW;O!7+#L{mgm@+ANO0V%Nx2N?oIKa&#~umVFglf@bR0!9{-#2O?RZ~$X)
z0c4^?5|d;BZ~$a*0bp<dVWLb7lM5S70|}F1lVBS_1)(>fHItJ;91{ouLsUjtV+sS4
PKO7a4!W&MrRvh0624*0f

diff --git a/tests/data/acpi/x86/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
index bdf36c4d575bfc4eb2eac3f00c9b7b4270f88677..f0ddb4c83cdc9afdf4f289a66ed6bf0d630fd623 100644
GIT binary patch
delta 180
zcmeD6y5Pm-66_KZpvu6&xNsvEyCjo`^JHPk4NPtplaEUNW%rbF4tDnAm~0>;KKX$Z
zhcbt=tCx=u)Bgg7<O0T&MgF3bQy2>vQVJLo3K$X#7*ZGcaZi%=<=~q*Ig#uC<kZOl
z(hf=sR3^vhv&08G#RoWh8UzHn20I7&hA|c-cYq8_WhhOZd{o*`s(>MBkrT_*q|}0D
eutX9=vU7-AWHJ}?<mb}r%t5|kn+0Y5Z~y=Y);DGV

delta 109
zcmV-z0FwXEN{vbiL{mgm4J7~o0qL;{2N?oIKa&#~umVFglf@bR0!9{-#2O?RZ~$X)
z0c4^?5|d;BZ~$a*0bp<dVWLb7lM5S70|}F1lVBS_1)(>fHItJ;91{ouLsUjtV+sS4
PKO7a4!W&MrRvh{W)LtM&

diff --git a/tests/data/acpi/x86/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
index 1db43a69e4c2affd8bd678bbef4d3c228380288e..3ad19e3f5e480db1c449b838c83833f7665186cd 100644
GIT binary patch
delta 180
zcmbP{emkAZCD<k8wlM<(qtZq$c1b2D=gGp78<-p{CLfjj%kC-V9PI4JG1)*yeDVV+
z4rLB!S1%tSrvC*D$pwrli~L0=r!W>Uq!chF6fh(fFr+T><DMk#%fUBsaw6CN$*GeA
zq#cwNs7#L0XNeDXiVtx1GzbWC4R#Ll4Pz`w?f@B<%21j*`KYv?Q~^WMA}5xqNvQ?R
eV2LD#WakjK$Yd_&$<L+LnS*@8HVewMivs{lCO2LH

delta 109
zcmV-z0FwXPXP9RSL{mgmm@@zX0Zg$92N?oSK9ds}umVjplf@bR0!9{-#2O?RZ~$X)
z0c4^?5|d;BZ~$a*0bp<dVWLb7lM5S70|}F1lVBS_1)(>fHItJ;91{ouLsUjtV+sS4
PKO7a4!W&MrRvd*F{DB}m

diff --git a/tests/data/acpi/x86/q35/DSDT.noacpihp b/tests/data/acpi/x86/q35/DSDT.noacpihp
index 8bc16887e1c963c61aaecf71712a09c0554f6d67..9f7261d1b06bbf5d8a3e5a7a46b247a2a21eb544 100644
GIT binary patch
delta 206
zcmZ4O@XmqDCD<h-Pl17faluBeUE)km&XbRcZ(wq;m|P+8m(x?qIoR2cBU*VfqolCz
z|Nk7$ey-s{O#eBYUA=sSnEn?qBo{EIEb<qfoWfYZkW#>yP{5E_z>vDgk9+cFNnd`x
ziIWq#{!dQj`d`49vb11wptSI0St&K81uBzc^jYGAo#F$WJq-eaT!Wp1e8U(Ek~=^K
zr!thLPOgyhlPX|HTI9qsH7T{A87z^+kn9}d7MaY&Jb9LsI%|+`SZUJacuBF%cclDT
E0gAanng9R*

delta 161
zcmaFou-bvkCD<iITY-Ur@zh4HUE)msc9V~ZZ(#B@o?IdEm(xwmIoR2cBU*VfqolCX
z|Nk7$ey-s{O#cfQk_#A97P$ybPGKxyNGV`UC}2oj<ij(0pQJA{=j6o6!cq>V3(Xgp
yPL9!Mi4S&)4{-K02nccwb`J6lV{{I2i%jNXE?~qWIk{BIZ*sh(*k*ZYe^vm<H!xlR

diff --git a/tests/data/acpi/x86/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
index c13e45e3612646cc2e30f00b3b7e53335da816ea..c089b5877a0f4d808abd4d8d9396ee7d2a9a78e5 100644
GIT binary patch
delta 191
zcmbR0aKnMiCD<h-LV<yS@!CeNN(m+>=gF-S8<-p{CYwwCW%rbF4tDnAn0!}KT${t$
z&ox|#=|6|FtCx=u)Bgg7<O0T&MgF3bQy2>vQVJLo3K$X#7*ZGcaZfIi^5x*0I60B)
z|K!xkhol^o7N|^)(PxPdc8U*h_B03xat(G4@(p7wNbUfcmda3?I@w&>PpW_+X^|7l
p)TGpcX0SvOL$Y&-TVyg9^W;crb=Dx?u+pT-a#CWOXG>SH008%`I?Dh6

delta 140
zcmV;70CWG?K$SoWL{mgm6(9fr0RXWIc^CpuK9hwQumVjplQ$Xt2Sye{Q$tP&lie8?
zAP7TFMOP96|8M|fZ~<hZL=ux^0dN3hZ~<U&0AZp`43m8tO#=y&VUyAtKp>$vpf!_R
uF9csxLSIlrNia}SMN>mkO;!OzR7P223Img|8x@l@8%~oR8WywO8+rsM6)9){

diff --git a/tests/data/acpi/x86/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
index ba6669437e65952f24516ded954b33fe54bdedfb..2867f5b44498d788fc0effd0bf616317821be88e 100644
GIT binary patch
delta 180
zcmZ4K_{NdTCD<k8jRFG$<IIg*?2=3#&Xa{DH!!(bOg<|4m)%p!IoR2cW3qva_~Zvt
z9LgNdu3kPuO#cfQk_#A97Ws=#PGKxyNGV`UC}2n|U`So$$302fmxFKO<V3FjlT#-L
zNINJkP?;Q~&k`T(6d&O1X%G<P8tfe88^&0W+yOEym7z3s@=<9&sRD+iMNTYJlTr(s
e!4gRf$<85ek;z=llb=hgGY9#GZ5EW7!2$q*U^lY>

delta 109
zcmV-z0FwXgL8(CsL{mgmsUQFV0pYO<2N?oIKa&#~umVFglf@bR0!9{-#2O?RZ~$X)
z0c4^?5|d;BZ~$a*0bp<dVWLb7lM5S70|}F1lVBS_1)(>fHItJ;91{ouLsUjtV+sS4
PKO7a4!W&MrRveZD8^j=y

diff --git a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
index 6ad42873e91c80cef5a42224cb4d31936dad59b4..02cc07f010f880684216ba8925c8f3f55cfd80aa 100644
GIT binary patch
delta 180
zcmeBhI_<>e66_M<t;oQ@xPK!TyCjp7^JHPk4NMLelaEUNW%rbF4tDnAm~0>;KKX$Z
zhcbt=tCx=u)Bgg7<O0T&MgF3bQy2>vQVJLo3K$X#7*ZGcaZi%=<=~q*Ig#uC<kZOl
z(hf=sR3^vhv&08G#RoWh8UzHn20I7&hA|c-cYq8_WhhOZd{o*`s(>MBkrT_*q|}0D
eutX9=vU7-AWHJ}?<mb}r%t5|kn+0XQvj715x;IP!

delta 109
zcmV-z0FwX9LWn{NL{mgm2q6Ff0qL;{2N?oSK9ds}umVjplf@bR0!9{-#2O?RZ~$X)
z0c4^?5|d;BZ~$a*0bp<dVWLb7lM5S70|}F1lVBS_1)(>fHItJ;91{ouLsUjtV+sS4
PKO7a4!W&MrRvh&N%k3a4

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
index a24b04cbdbf09383b933a42a2a15182545543a87..41c0832ab5041ff5361598813ec28fe7442b191b 100644
GIT binary patch
delta 168
zcmeyEvL%(vCD<ioixC3@W9vpPc1fm&gvr8^8<~1THXoC$VrKV}at?O(<CxqaBR)A!
zmP47t+11NOi0OX;LvjIQ$|47`$tjEl3@HVS2?Y#^1q`W+{JAIB$@+2dO`M#_^?!2e
z<nyu)%nMW|Pd1bj=3y*I?f~geWhhOZ>>}qURltz6$cbfYQffgnSR#ob**U~5GMS5c
Ra+;hvbC7S?<_U5Sg#j0XG*JKm

delta 134
zcmV;10D1qkW$|PRL{mgmaWVh^0k5$N2N?p5TayzRu>y)vv&I>E0|!SILsLUe2$O&u
z7n5Ec2pDhxV{idvqD2yuWC3shWN-msZ~$SVO$?KX9ZmxYlVOwJ9Y6%3H=s3>As!VR
oLsUjtV+sRs0bDNxUsFO~P(w*DP*O!xLsCsvlR+L%v(+Bo6Qh?Xg#Z8m

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
index 3a0cb8c581c8cc630a2ec21712b7f8b75fcad1c8..153b45f0f7443d25cecc2a752fb6dbd921160e78 100644
GIT binary patch
delta 160
zcmaFW&a}3JiOVI}B}BJ{fr0VbMlN<qrq1%o!jc=A+Hy7@lT_nn@|K$XPEAFL!`ao#
zM~LZv0Yh>DW6B~&vB@cn1q>+#j0pt{i3JR)iyS6vst0iJO`M#_^?!2e<QjDcrUfdK
z52%ZB7bJIpG^a9@rcVB-?k7{gkhI8&WolAtK{Hq)i6PlJ#4R$Ji@6|q@;WtD<{;m&
J&9)kAqXG4WGspk{

delta 142
zcmZ46!St$~iOVI}CFE5z0|O)DMlN<qrnchA!jc=Anlm;ZlT_nn@(`Q+PEAF;fFZen
zF=dgP(Bu@x0)~_V#)JZf#6^CSP1FOJIVUGh?ooFzU1+|*baIS7OMI|Xe1Nm3K|qje
fuyc@a7^8EDTVyg9a{(h3$;t23{Wdpgtd0f%C_O9p

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
index e381ce4cbf2b11f56a2d0537db4d21acc97450c9..d0330d26a54b89c02a17b06ef5f55c72e28e406e 100644
GIT binary patch
delta 180
zcmZp4JL1OW66_M<qRha+XuFY%U6RSkd9twN1||oK$wwvsvU^H72Rr+5Og4}apZq|I
zLz%<b)yqeS>3;!3asgw?B7f1zDU1aSDFuuP1q_J=45^F!xF<>ba_~)@oXGWma_Zy&
zX$PeRDwAXMS>l78;scyL4FZB(gPntX!x#&aJ3xk|GL)uHJ}T`eRltz6$cbfYQffgn
dSR#ob**U~5GMS5c@^fi*<{;m&&4Mx?*Z`l;Ho5=+

delta 109
zcmV-z0FwX2MuA2OL{mgm0V4na0cWua2N?oSK9ds}umVjplf@bR0!9{-#2O?RZ~$X)
z0c4^?5|d;BZ~$a*0bp<dVWLb7lM5S70|}F1lVBS_1)(>fHItJ;91{ouLsUjtV+sS4
PKO7a4!W&MrRvhjImmMFN

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
index a09253042ce4a715922027245de8a2ab7449c5b7..b05563deedc65df50f35b2399862d9ee8d4d1e0e 100644
GIT binary patch
delta 180
zcmbR3cF&E=CD<h-PMLv$@%u(Dc1b2D=gGp78<-p{CLfjj%kC-V9PI4JG1)*yeDVV+
z4rLB!S1%tSrvC*D$pwrli~L0=r!W>Uq!chF6fh(fFr+T><DMk#%fUBsaw6CN$*GeA
zq#cwNs7#L0XNeDXiVtx1GzbWC4R#Ll4Pz`w?f@B<%21j*`KYv?Q~^WMA}5xqNvQ?R
eV2LD#WakjK$Yd_&$<L+LnS*@8HVevdu>$~1X*S&e

delta 109
zcmV-z0FwXSMw><oL{mgm8zTS!0U@yp2N?oSK9ds}umVjplf@bR0!9{-#2O?RZ~$X)
z0c4^?5|d;BZ~$a*0bp<dVWLb7lM5S70|}F1lVBS_1)(>fHItJ;91{ouLsUjtV+sS4
PKO7a4!W&MrRvZWin{Xbx

diff --git a/tests/data/acpi/x86/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
index edc23198cdb47a981bcbc82bc8e392b815abb554..00807e7fd4d758bc2ab9c69ac8869cf6864399f7 100644
GIT binary patch
delta 200
zcmbO`k@3MqMlP3Nmyib@3=E8mHgd5`GW8sqEG)T^sdM}0W0I5D*uA8jgPr|2CNnCC
zYjZgJxrPfd{pWCY_3{y7`d`41T)>#J$U$s!3S$97N&#a+0YhQ|L+T=b?#a^>{5bd~
zPEO?dKRI>sa|H*b1uBzc^jYGAo#F$WJq-eaT!Wp1e8U(Ek~=`Ar81PJPL5IZlPX|H
zTI9qsH7T{A87z^+kn9}d7MaY&Jb9sl*knBgLG~cuu+pSx^~s3}!khOi-cthrpxZw^

delta 163
zcmaDbk#X)sMlP3Nmyo$03=E97H*&E{GIj2oEG)T^scrM-W0I5D*xkjPgPr|2CNnCC
zD{wgbxrPfd{V!lhE?`Vq<SH~dg|UDkrGPP^fFW^_FVEzK3VzI-lM^R@S8y<0XuiO7
za*RGpe6Uk|fU~DTK#*&&bC7QsqjQK`WHJ|X0V5X4$&reFOwsC-6BUFvGb!Cu0{{}w
BF&_W`

diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
index 4c93dfd5c4b362714d3f9aa606a838d4625b3369..c3d83e67660ee3fd59f6fae6242270bed4a567f1 100644
GIT binary patch
delta 180
zcmbPIbiIhnCD<h-+>(KT@%~0Gc1b2D=gGp78<-p{CLfjj%kC-V9PI4JG1)*yeDVV+
z4rLB!S1%tSrvC*D$pwrli~L0=r!W>Uq!chF6fh(fFr+T><DMk#%fUBsaw6CN$*GeA
zq#cwNs7#L0XNeDXiVtx1GzbWC4R#Ll4Pz`w?f@B<%21j*`KYv?Q~^WMA}5xqNvQ?R
eV2LD#WakjK$Yd_&$<L+LnS*@8HVeuy%K`v;Ha9H*

delta 109
zcmV-z0FwXLa+GokL{mgm6gdC@0SU1R2N?oSK9ds}umVjplf@bR0!9{-#2O?RZ~$X)
z0c4^?5|d;BZ~$a*0bp<dVWLb7lM5S70|}F1lVBS_1)(>fHItJ;91{ouLsUjtV+sS4
PKO7a4!W&MrRvZBxw>BRO

diff --git a/tests/data/acpi/x86/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
index d4acd851c62c956436a436f9fa6d08fc5f370fa7..227d421f16ed1824a87e8a91da734828f8b48cbf 100644
GIT binary patch
delta 195
zcmZph&UA7*6PHV{OUTJ?1_s7U8@bpenOZ+i7M9$|)bwogG091M?A}t&!OnghlNmL{
zwK$ypT*HN!{&P6Hdie-3{V!lhE?`Vq<R~^dg|UDkrGPP^fFZGfA$5_%<f$3~9DEZe
zCvyFtoI3f1hJ(@qmB}&sEb+lk@d3`B1_42?!OlUxVT=XI9U#L}8A?+p$7=dX6)+?%
ta$=d9lv>aXmPleqb`EiiOy**qT(7Cl9^@NVniQ=*IZ;D+^8w9ci2(KZKNSD~

delta 162
zcmX>(ovCd)6PHV{OGsNc0|VpRja=-KOigbm3rlWf>VLTTnB*irb`LS<U}ry$$&4D}
z@*K{7uHiyV{|gwB3m8)txd}~9VJu)sDPT+}U`Sl#H+g|Z05j+0#K}K2984FQFEE`P
zqt6l_>=Ym1>}e1X<QnW8<QvB59O4$4%*9;5h(&U8l%^k3wEE;k4dKnqTE`LrM+q_U

-- 
MST


