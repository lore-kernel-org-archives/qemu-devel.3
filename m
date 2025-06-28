Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F11BC7EE39
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 19:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVbh3-0003TD-Ki; Sat, 28 Jun 2025 15:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbgo-0003LL-JH
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:58:18 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbgm-0000P8-QL
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:58:18 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7d3dd14a7edso141983785a.2
 for <qemu-devel@nongnu.org>; Sat, 28 Jun 2025 12:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751140695; x=1751745495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+F6nN8jVuJ9x9ikMI93e1pxkuyZDDe/xC+x/t6zowT4=;
 b=QvJQIi0LYlts4Idm5czlUjI22CIbKklXFkl2UUjWAsHnsAhyVlo6zw/RyotC3ZJ4dH
 /mJu3uTge0xa3oBvYoRhInyLcb6KUaJsqdBPbj0YYM7Kg2cH7zeCxxJVg7Vg5yBpBg0H
 vDQMZcv6ATA5nwLi7e9zAmegnfBVRCKRJU1aTC5D92ldidYuVjJINkrduzUldeTiyWFZ
 nfH4qxjgPnBAhbd8lFuGxCWHug3w8idi+1wFwYb2kiewhlfoyctgW1/boDDmUfGCyQYh
 9XBBlxN7u84D3PyETOvkcxHFrek/XHiHHxRGSzJLUqN5E77eQYIqmVhIvP3GeP5dhcai
 asnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751140695; x=1751745495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+F6nN8jVuJ9x9ikMI93e1pxkuyZDDe/xC+x/t6zowT4=;
 b=QyQmiBQkbWKuWOG7tnb/uoO1FlhiBTNpBru8RHEEfsEUg7WiNfmr6DPYOAWW1eJwk2
 zeU+f32T8Naqf5ucjukBVujJ2pKjy2wb2+t94F+lQjMZIxJX7C+0lDuZf15uMc2wRJp3
 +7HAM0gLjv7aiDPQ74gk9KUHJggaW9sAule5rbT+PMQOwTmvwc3fxTDAKb0Ug0boKIfO
 7yNYFu3/x53tqG/icgZ/8V9VCCA41VcEzwaSaF1Uv+vC2U2sumaF/2hUqAZyETefwcoF
 son8oq3yCMhg96UYtFdCi37GN+qUxk+mdVYVl7QUZ/7bf5CnZ6nD+3B0JWTU7jP7aN4j
 yRKg==
X-Gm-Message-State: AOJu0YznFU6Q298R4UMz7N8SLU11X3uObQsB7cNVwk16cBO0kDLsQjzY
 jk1FzmrdsCnXnzLRFRWgB/8922LqMYz4NPw48g6YEiqLp3s3hzV7A9Ht+ZNOtr5WXUtg4rJYEZR
 /crxj
X-Gm-Gg: ASbGnct2OHYKCt1qPqa5X5yYoHfu0zgl1e57/iXmedFcRXqN6+ao2B5LfFhfqlGKBbt
 UlT66Zd/2LlkY/DSIhsh/bYZdGdTeCMfQFCmKzKe7VLBofVPQXnJN879NlUXvJLuACUhzjIZvi1
 k739DlDpx0SIKOQVZkds5rcQuzj6hc4FFk07KmMr01T/Vg6Ppwj6GMMy5Zx5YKitdtNWlbkwAPL
 YogbzARz4WqNBNAvlu7xiHCZ15Ia6kCfUxAxO9/13xdOXWPSE+uVKgrrKcOKFamwevC9r8nKwR1
 xQgst6FgSxtnihniGrfd7PjkobQYLRQwZl4gos5+4TuMVKDMDNzfJesGm2pJF2rwTcE=
X-Google-Smtp-Source: AGHT+IEM2K2QwZG0uMnpZVZqVPWCYCy4HGDusOH2tzw4wWfbrvz1DcFZ29qe2fqn5sFPZU6Ra8On5Q==
X-Received: by 2002:a05:620a:444d:b0:7d4:4596:d6a5 with SMTP id
 af79cd13be357-7d44596dcabmr1050929385a.55.1751140695521; 
 Sat, 28 Jun 2025 12:58:15 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443136907sm334395585a.14.2025.06.28.12.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 12:58:14 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH v6 9/9] qtest/bios-tables-test: Update blobs for its=off test
 on aarch64
Date: Sat, 28 Jun 2025 19:57:22 +0000
Message-Id: <20250628195722.977078-10-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250628195722.977078-1-gustavo.romero@linaro.org>
References: <20250628195722.977078-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qk1-x731.google.com
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

Update blobs for the its=off test on aarch64 after fix.

Basically, all structs related to ITS are gone in MADT and IORT
tables after the fix (previously ITS was not properly disabled
when "its=off" option was passed to the machine).

MADT diff:

 [000h 0000   4]                    Signature : "APIC"    [Multiple APIC Description Table (MADT)]
-[004h 0004   4]                 Table Length : 000000B8
+[004h 0004   4]                 Table Length : 000000A4
 [008h 0008   1]                     Revision : 04
-[009h 0009   1]                     Checksum : C1
+[009h 0009   1]                     Checksum : 08
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

 [024h 0036   4]           Local Apic Address : 00000000
 [028h 0040   4]        Flags (decoded below) : 00000000
                          PC-AT Compatibility : 0

 [02Ch 0044   1]                Subtable Type : 0C [Generic Interrupt Distributor]
 [02Dh 0045   1]                       Length : 18
 [02Eh 0046   2]                     Reserved : 0000
 [030h 0048   4]        Local GIC Hardware ID : 00000000
 [034h 0052   8]                 Base Address : 0000000008000000
 [03Ch 0060   4]               Interrupt Base : 00000000
@@ -48,37 +48,29 @@
 [064h 0100   8]                 Base Address : 0000000000000000
 [06Ch 0108   8]     Virtual GIC Base Address : 0000000000000000
 [074h 0116   8]  Hypervisor GIC Base Address : 0000000000000000
 [07Ch 0124   4]        Virtual GIC Interrupt : 00000000
 [080h 0128   8]   Redistributor Base Address : 0000000000000000
 [088h 0136   8]                    ARM MPIDR : 0000000000000000
 [090h 0144   1]             Efficiency Class : 00
 [091h 0145   1]                     Reserved : 00
 [092h 0146   2]       SPE Overflow Interrupt : 0000

 [094h 0148   1]                Subtable Type : 0E [Generic Interrupt Redistributor]
 [095h 0149   1]                       Length : 10
 [096h 0150   2]                     Reserved : 0000
 [098h 0152   8]                 Base Address : 00000000080A0000
 [0A0h 0160   4]                       Length : 00F60000

-[0A4h 0164   1]                Subtable Type : 0F [Generic Interrupt Translator]
-[0A5h 0165   1]                       Length : 14
-[0A6h 0166   2]                     Reserved : 0000
-[0A8h 0168   4]               Translation ID : 00000000
-[0ACh 0172   8]                 Base Address : 0000000008080000
-[0B4h 0180   4]                     Reserved : 00000000

IORT diff:

 [000h 0000   4]                    Signature : "IORT"    [IO Remapping Table]
-[004h 0004   4]                 Table Length : 000000EC
+[004h 0004   4]                 Table Length : 000000AC
 [008h 0008   1]                     Revision : 03
-[009h 0009   1]                     Checksum : 57
+[009h 0009   1]                     Checksum : 97
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

-[024h 0036   4]                   Node Count : 00000003
+[024h 0036   4]                   Node Count : 00000002
 [028h 0040   4]                  Node Offset : 00000030
 [02Ch 0044   4]                     Reserved : 00000000

-[030h 0048   1]                         Type : 00
-[031h 0049   2]                       Length : 0018
-[033h 0051   1]                     Revision : 01
+[030h 0048   1]                         Type : 04
+[031h 0049   2]                       Length : 0044
+[033h 0051   1]                     Revision : 04
 [034h 0052   4]                     Reserved : 00000000
 [038h 0056   4]                Mapping Count : 00000000
 [03Ch 0060   4]               Mapping Offset : 00000000

-[040h 0064   4]                     ItsCount : 00000001
-[044h 0068   4]                  Identifiers : 00000000
-
-[048h 0072   1]                         Type : 04
-[049h 0073   2]                       Length : 0058
-[04Bh 0075   1]                     Revision : 04
-[04Ch 0076   4]                     Reserved : 00000001
-[050h 0080   4]                Mapping Count : 00000001
-[054h 0084   4]               Mapping Offset : 00000044
-
-[058h 0088   8]                 Base Address : 0000000009050000
-[060h 0096   4]        Flags (decoded below) : 00000001
+[040h 0064   8]                 Base Address : 0000000009050000
+[048h 0072   4]        Flags (decoded below) : 00000001
                              COHACC Override : 1
                                HTTU Override : 0
                       Proximity Domain Valid : 0
-[064h 0100   4]                     Reserved : 00000000
-[068h 0104   8]                VATOS Address : 0000000000000000
-[070h 0112   4]                        Model : 00000000
-[074h 0116   4]                   Event GSIV : 0000006A
-[078h 0120   4]                     PRI GSIV : 0000006B
-[07Ch 0124   4]                    GERR GSIV : 0000006D
-[080h 0128   4]                    Sync GSIV : 0000006C
-[084h 0132   4]             Proximity Domain : 00000000
-[088h 0136   4]      Device ID Mapping Index : 00000000
-
-[08Ch 0140   4]                   Input base : 00000000
-[090h 0144   4]                     ID Count : 0000FFFF
-[094h 0148   4]                  Output Base : 00000000
-[098h 0152   4]             Output Reference : 00000030
-[09Ch 0156   4]        Flags (decoded below) : 00000000
-                              Single Mapping : 0
-
-[0A0h 0160   1]                         Type : 02
-[0A1h 0161   2]                       Length : 004C
-[0A3h 0163   1]                     Revision : 03
-[0A4h 0164   4]                     Reserved : 00000002
-[0A8h 0168   4]                Mapping Count : 00000002
-[0ACh 0172   4]               Mapping Offset : 00000024
-
-[0B0h 0176   8]            Memory Properties : [IORT Memory Access Properties]
-[0B0h 0176   4]              Cache Coherency : 00000001
-[0B4h 0180   1]        Hints (decoded below) : 00
+[04Ch 0076   4]                     Reserved : 00000000
+[050h 0080   8]                VATOS Address : 0000000000000000
+[058h 0088   4]                        Model : 00000000
+[05Ch 0092   4]                   Event GSIV : 0000006A
+[060h 0096   4]                     PRI GSIV : 0000006B
+[064h 0100   4]                    GERR GSIV : 0000006D
+[068h 0104   4]                    Sync GSIV : 0000006C
+[06Ch 0108   4]             Proximity Domain : 00000000
+[070h 0112   4]      Device ID Mapping Index : 00000000
+
+[074h 0116   1]                         Type : 02
+[075h 0117   2]                       Length : 0038
+[077h 0119   1]                     Revision : 03
+[078h 0120   4]                     Reserved : 00000001
+[07Ch 0124   4]                Mapping Count : 00000001
+[080h 0128   4]               Mapping Offset : 00000024
+
+[084h 0132   8]            Memory Properties : [IORT Memory Access Properties]
+[084h 0132   4]              Cache Coherency : 00000001
+[088h 0136   1]        Hints (decoded below) : 00
                                    Transient : 0
                               Write Allocate : 0
                                Read Allocate : 0
                                     Override : 0
-[0B5h 0181   2]                     Reserved : 0000
-[0B7h 0183   1] Memory Flags (decoded below) : 03
+[089h 0137   2]                     Reserved : 0000
+[08Bh 0139   1] Memory Flags (decoded below) : 03
                                    Coherency : 1
                             Device Attribute : 1
-[0B8h 0184   4]                ATS Attribute : 00000000
-[0BCh 0188   4]           PCI Segment Number : 00000000
-[0C0h 0192   1]            Memory Size Limit : 40
-[0C1h 0193   3]                     Reserved : 000000
-
-[0C4h 0196   4]                   Input base : 00000000
-[0C8h 0200   4]                     ID Count : 000000FF
-[0CCh 0204   4]                  Output Base : 00000000
-[0D0h 0208   4]             Output Reference : 00000048
-[0D4h 0212   4]        Flags (decoded below) : 00000000
-                              Single Mapping : 0
-
-[0D8h 0216   4]                   Input base : 00000100
-[0DCh 0220   4]                     ID Count : 0000FEFF
-[0E0h 0224   4]                  Output Base : 00000100
-[0E4h 0228   4]             Output Reference : 00000030
-[0E8h 0232   4]        Flags (decoded below) : 00000000
+[08Ch 0140   4]                ATS Attribute : 00000000
+[090h 0144   4]           PCI Segment Number : 00000000
+[094h 0148   1]            Memory Size Limit : 40
+[095h 0149   3]                     Reserved : 000000
+
+[098h 0152   4]                   Input base : 00000000
+[09Ch 0156   4]                     ID Count : 000000FF
+[0A0h 0160   4]                  Output Base : 00000000
+[0A4h 0164   4]             Output Reference : 00000030
+[0A8h 0168   4]        Flags (decoded below) : 00000000
                               Single Mapping : 0

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 184 -> 164 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off   | Bin 236 -> 172 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 3 files changed, 2 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/acpi/aarch64/virt/APIC.its_off
index 37d82e970b1331cb5b259f0bd2d3654bacb2d623..6130cb7d07103b326feb4dcd7034f85808bebadf 100644
GIT binary patch
delta 18
ZcmdnNxP+0*F~HM#2?GNI3&%vRSpY2+1Zw~Q

delta 39
jcmZ3&xPy_)F~HM#2Ll5G%fX3UvqbnsfJ`vp;DE6JqX7kf

diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/acpi/aarch64/virt/IORT.its_off
index 0fceb820d509e852ca0849baf568a8e93e426738..c10da4e61dd00e7eb062558a2735d49ca0b20620 100644
GIT binary patch
delta 69
zcmaFExQ3C-(?2L=4FdxM^Yn>aQj$zSmH`lh0E-I)3xowECx)7HGFdP%GXmL+6IZHp
Hz*GSMclZc%

literal 236
zcmebD4+?q1z`(#9?&R<65v<@85#X!<1dKp25F11@1F-=RgMkDCNC*yK9F_<M77!bR
zUBI%eoFED&4;F$FSwK1)h;xBB2Py`m{{M%tVD>TjFfcO#g+N#Zh@s|zoCF3AP#UU@
R!2`+%Dg6Hr$N|zYvjDIZ5CH%H

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index a88198d5c2..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/APIC.its_off",
-"tests/data/acpi/aarch64/virt/IORT.its_off",
-- 
2.34.1


