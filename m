Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EEBCAC59B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya60-0005YB-8l; Tue, 16 Sep 2025 14:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya51-0003EO-EN
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:06 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4v-0001ee-ST
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:02 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3c46686d1e6so4003983f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758046014; x=1758650814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UkARRwZyoo7H6bF6Vk8t98197iZiJFfH3aRXFYrYnPo=;
 b=FQ/qzUoUUQHZW1+8vPZXEfvm3LF4Ykydm1KXOIJituaWmzT8Rwksb++kSVstkM7ZAs
 DZIX3pyHBpNpINUfMG0Myc8wljMZ/RAVdShrM99CiQjFdj2OiUsQW/uzvrqyj4aMYjvq
 yQz8XIsITKafMqEEd+hrkl5QFrE2n7hpxO85YeRcE4sd++pZYSSrnjpf1x+L3CnspobX
 GRGmivHb2gVGdC1zhA/rAB0BH2FPsftB+4YZymyERMUkEM/DUuyRWqlHmdCJnEPDLsCO
 NbYb1z0D3b2UwpS22QxlawpzybPvPDLzPHDMYA3aZ6+brGyVDd0bCHVaYuFyG9dzgvgx
 vchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758046014; x=1758650814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UkARRwZyoo7H6bF6Vk8t98197iZiJFfH3aRXFYrYnPo=;
 b=uvFN8Mk9zf51eRtlrxtKc9HaNUV4xIAAdNBKaAmGjtoxmplYeDDLBfhbU88IYDit8k
 g5gppWVxUx2BWD+ItsP4mEDWgBjMyjvpPdV0X3RSwLfRL+HcXx7oqMtow05AS8Aq5wzu
 eOXDTzK8JJO8uizz889d5tPlkS4IT6jWjvXBugfmK2o201Ird2uGT+U/jHNltFz/lTf/
 gxXf6lwOdnAnCiirNJWamE444SYQRijdpMG0Bohu3EGkZTDeIrF4BoUulKnHk5Xta8iK
 MzarPaAcmpB3ugjkM9eW06ebAWv4argCaxu5zz2mw5gBKeGkhuTx4QNxHjqa0BKy6yo2
 O4dQ==
X-Gm-Message-State: AOJu0Yz0HugLrmyTmNKZ4FvOxLZX/z2ieTI7TLGBKI+XqDyr2pqZN7NM
 gcjQkaRj4AZ7ktKORq3A32PYya/mExKCPgdhfo+/1e0gyIRWRUjPzR8xBGCDXrxmUKb8uzSw7dB
 S+j+b
X-Gm-Gg: ASbGncv2PcV7qXfA41BXEJ7ZNCkBGG3fus388k5FMp07maL1gaPt9TwwtRnTCQpIUr2
 DiQauAdosyMD4HmhB+ils2VTCjB+cXxV/rY8nTUsmk41N+iSeomRAzmTm+qCmr7usr425rbw/Hu
 mB0Ua24kf2ANtJQRP4n7oNhn/0WvcXQB7Xc9ASFcCV+3KR2lHm5/rzVnCudYQp7/yZ7ZtBvbO2D
 0QHVNCVL1+oZH6vKmmm5Uw56nqRhUMNLJ6obm+XhIGyTgH7ZPvfCzUxUDBevYcy3XFQLuc2j1m3
 LVcXyy2gizMM9LZtK/cH1lNGyouS/GX1cvW2avRil1MzE93aK0EeMNN+O/+aMjlCspBp3N02ej2
 kZzEwXIYT2yliq9F8oaexgVH6NG2/
X-Google-Smtp-Source: AGHT+IGP7Qj2eoo+9LCmzCnFsCuaS2bg0DG8h2q/nqKydQZd77DrkYsX3UCGf2dYljKBCS40uV1tng==
X-Received: by 2002:a05:6000:2586:b0:3e4:1e29:47db with SMTP id
 ffacd0b85a97d-3e765a25836mr16860951f8f.43.1758046013534; 
 Tue, 16 Sep 2025 11:06:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/36] qtest/bios-tables-test: Update tables for smmuv3 tests
Date: Tue, 16 Sep 2025 19:06:09 +0100
Message-ID: <20250916180611.1481266-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

For the legacy smmuv3 test case, generated IORT has a single SMMUv3 node,
a Root Complex(RC) node and 1 ITS node.
RC node features 4 ID mappings, of which 2 points to SMMU node and the
remaining ones points to ITS.

       pcie.0 -> {SMMU0} -> {ITS}
{RC}   pcie.1 -> {SMMU0} -> {ITS}
       pcie.2            -> {ITS}
       [all other ids]   -> {ITS}

...
[030h 0048   1]                         Type : 00
[031h 0049   2]                       Length : 0018
[033h 0051   1]                     Revision : 01
[034h 0052   4]                   Identifier : 00000000
[038h 0056   4]                Mapping Count : 00000000
[03Ch 0060   4]               Mapping Offset : 00000000

[040h 0064   4]                     ItsCount : 00000001
[044h 0068   4]                  Identifiers : 00000000

[048h 0072   1]                         Type : 04
[049h 0073   2]                       Length : 0058
[04Bh 0075   1]                     Revision : 04
[04Ch 0076   4]                   Identifier : 00000001
[050h 0080   4]                Mapping Count : 00000001
[054h 0084   4]               Mapping Offset : 00000044

[058h 0088   8]                 Base Address : 0000000009050000
[060h 0096   4]        Flags (decoded below) : 00000001
                             COHACC Override : 1
                               HTTU Override : 0
                      Proximity Domain Valid : 0
[064h 0100   4]                     Reserved : 00000000
[068h 0104   8]                VATOS Address : 0000000000000000
[070h 0112   4]                        Model : 00000000
[074h 0116   4]                   Event GSIV : 0000006A
[078h 0120   4]                     PRI GSIV : 0000006B
[07Ch 0124   4]                    GERR GSIV : 0000006D
[080h 0128   4]                    Sync GSIV : 0000006C
[084h 0132   4]             Proximity Domain : 00000000
[088h 0136   4]      Device ID Mapping Index : 00000000

[08Ch 0140   4]                   Input base : 00000000
[090h 0144   4]                     ID Count : 0000FFFF
[094h 0148   4]                  Output Base : 00000000
[098h 0152   4]             Output Reference : 00000030
[09Ch 0156   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[0A0h 0160   1]                         Type : 02
[0A1h 0161   2]                       Length : 0074
[0A3h 0163   1]                     Revision : 03
[0A4h 0164   4]                   Identifier : 00000002
[0A8h 0168   4]                Mapping Count : 00000004
[0ACh 0172   4]               Mapping Offset : 00000024

[0B0h 0176   8]            Memory Properties : [IORT Memory Access Properties]
[0B0h 0176   4]              Cache Coherency : 00000001
[0B4h 0180   1]        Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[0B5h 0181   2]                     Reserved : 0000
[0B7h 0183   1] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
[0B8h 0184   4]                ATS Attribute : 00000000
[0BCh 0188   4]           PCI Segment Number : 00000000
[0C0h 0192   1]            Memory Size Limit : 40
[0C1h 0193   2]           PASID Capabilities : 0000
[0C3h 0195   1]                     Reserved : 00

[0C4h 0196   4]                   Input base : 00000000
[0C8h 0200   4]                     ID Count : 000001FF
[0CCh 0204   4]                  Output Base : 00000000
[0D0h 0208   4]             Output Reference : 00000048
[0D4h 0212   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[0D8h 0216   4]                   Input base : 00001000
[0DCh 0220   4]                     ID Count : 000000FF
[0E0h 0224   4]                  Output Base : 00001000
[0E4h 0228   4]             Output Reference : 00000048
[0E8h 0232   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[0ECh 0236   4]                   Input base : 00000200
[0F0h 0240   4]                     ID Count : 00000DFF
[0F4h 0244   4]                  Output Base : 00000200
[0F8h 0248   4]             Output Reference : 00000030
[0FCh 0252   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[100h 0256   4]                   Input base : 00001100
[104h 0260   4]                     ID Count : 0000EEFF
[108h 0264   4]                  Output Base : 00001100
[10Ch 0268   4]             Output Reference : 00000030
[110h 0272   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

For the smmuv3-dev test case, IORT has 2 SMMUV3 nodes,
1 RC node and 1 ITS node.
RC node features 4 ID mappings. 2 of them target the 2
SMMU nodes while the others targets the ITS.

        pcie.0 -> {SMMU0} -> {ITS}
{RC}    pcie.1 -> {SMMU1} -> {ITS}
        pcie.2            -> {ITS}
        [all other ids]   -> {ITS}
...
[030h 0048   1]                         Type : 00
[031h 0049   2]                       Length : 0018
[033h 0051   1]                     Revision : 01
[034h 0052   4]                   Identifier : 00000000
[038h 0056   4]                Mapping Count : 00000000
[03Ch 0060   4]               Mapping Offset : 00000000

[040h 0064   4]                     ItsCount : 00000001
[044h 0068   4]                  Identifiers : 00000000

[048h 0072   1]                         Type : 04
[049h 0073   2]                       Length : 0058
[04Bh 0075   1]                     Revision : 04
[04Ch 0076   4]                   Identifier : 00000001
[050h 0080   4]                Mapping Count : 00000001
[054h 0084   4]               Mapping Offset : 00000044

[058h 0088   8]                 Base Address : 000000000C000000
[060h 0096   4]        Flags (decoded below) : 00000001
                             COHACC Override : 1
                               HTTU Override : 0
                      Proximity Domain Valid : 0
[064h 0100   4]                     Reserved : 00000000
[068h 0104   8]                VATOS Address : 0000000000000000
[070h 0112   4]                        Model : 00000000
[074h 0116   4]                   Event GSIV : 00000090
[078h 0120   4]                     PRI GSIV : 00000091
[07Ch 0124   4]                    GERR GSIV : 00000093
[080h 0128   4]                    Sync GSIV : 00000092
[084h 0132   4]             Proximity Domain : 00000000
[088h 0136   4]      Device ID Mapping Index : 00000000

[08Ch 0140   4]                   Input base : 00000000
[090h 0144   4]                     ID Count : 0000FFFF
[094h 0148   4]                  Output Base : 00000000
[098h 0152   4]             Output Reference : 00000030
[09Ch 0156   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[0A0h 0160   1]                         Type : 04
[0A1h 0161   2]                       Length : 0058
[0A3h 0163   1]                     Revision : 04
[0A4h 0164   4]                   Identifier : 00000002
[0A8h 0168   4]                Mapping Count : 00000001
[0ACh 0172   4]               Mapping Offset : 00000044

[0B0h 0176   8]                 Base Address : 000000000C020000
[0B8h 0184   4]        Flags (decoded below) : 00000001
                             COHACC Override : 1
                               HTTU Override : 0
                      Proximity Domain Valid : 0
[0BCh 0188   4]                     Reserved : 00000000
[0C0h 0192   8]                VATOS Address : 0000000000000000
[0C8h 0200   4]                        Model : 00000000
[0CCh 0204   4]                   Event GSIV : 00000094
[0D0h 0208   4]                     PRI GSIV : 00000095
[0D4h 0212   4]                    GERR GSIV : 00000097
[0D8h 0216   4]                    Sync GSIV : 00000096
[0DCh 0220   4]             Proximity Domain : 00000000
[0E0h 0224   4]      Device ID Mapping Index : 00000000

[0E4h 0228   4]                   Input base : 00000000
[0E8h 0232   4]                     ID Count : 0000FFFF
[0ECh 0236   4]                  Output Base : 00000000
[0F0h 0240   4]             Output Reference : 00000030
[0F4h 0244   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[0F8h 0248   1]                         Type : 02
[0F9h 0249   2]                       Length : 0074
[0FBh 0251   1]                     Revision : 03
[0FCh 0252   4]                   Identifier : 00000003
[100h 0256   4]                Mapping Count : 00000004
[104h 0260   4]               Mapping Offset : 00000024

[108h 0264   8]            Memory Properties : [IORT Memory Access Properties]
[108h 0264   4]              Cache Coherency : 00000001
[10Ch 0268   1]        Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[10Dh 0269   2]                     Reserved : 0000
[10Fh 0271   1] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
[110h 0272   4]                ATS Attribute : 00000000
[114h 0276   4]           PCI Segment Number : 00000000
[118h 0280   1]            Memory Size Limit : 40
[119h 0281   2]           PASID Capabilities : 0000
[11Bh 0283   1]                     Reserved : 00

[11Ch 0284   4]                   Input base : 00000000
[120h 0288   4]                     ID Count : 000001FF
[124h 0292   4]                  Output Base : 00000000
[128h 0296   4]             Output Reference : 00000048
[12Ch 0300   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[130h 0304   4]                   Input base : 00001000
[134h 0308   4]                     ID Count : 000000FF
[138h 0312   4]                  Output Base : 00001000
[13Ch 0316   4]             Output Reference : 000000A0
[140h 0320   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[144h 0324   4]                   Input base : 00000200
[148h 0328   4]                     ID Count : 00000DFF
[14Ch 0332   4]                  Output Base : 00000200
[150h 0336   4]             Output Reference : 00000030
[154h 0340   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[158h 0344   4]                   Input base : 00001100
[15Ch 0348   4]                     ID Count : 0000EEFF
[160h 0352   4]                  Output Base : 00001100
[164h 0356   4]             Output Reference : 00000030
[168h 0360   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

Note: DSDT changes are not described here as it is not impacted by the
way the SMMUv3 is instantiated.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Donald Dutile <ddutile@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Message-id: 20250829082543.7680-12-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h     |   4 ----
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev    | Bin 0 -> 10230 bytes
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy | Bin 0 -> 10230 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 0 -> 364 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 0 -> 276 bytes
 5 files changed, 4 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 2e3e3ccdcec..dfb8523c8bf 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,5 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
-"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..53d4c07f423886d8c4b57f1da6498eef5a08b556 100644
GIT binary patch
literal 10230
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
T>d9`i-)dK@cGVtG`#|_F_?bX?

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..53d4c07f423886d8c4b57f1da6498eef5a08b556 100644
GIT binary patch
literal 10230
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
T>d9`i-)dK@cGVtG`#|_F_?bX?

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev b/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..67be268f62afbf2d9459540984da5e9340afdaaa 100644
GIT binary patch
literal 364
zcmebD4+_a)WME)E<>c?|5v<@85#X!<1VAAM5F13Z0I>lOgMkDCNC*yK9F_<M77!bR
zT_CbNAPOcA5rU8tfYd}Fo(#m3AVP5R|9=P*W*^90CZG_)Tqd06P64W$3dGZacp4BR
z19WqlN*I`#feJu=QvqVAJ3&HV-~grnLnS<*d<Fpq2Cx%>^a7X|(1HJXfgB(Wb2oz^
MQ0yI03`oPo01?F*0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..41981a449fc306b80cccd87ddec3c593a8d72c07 100644
GIT binary patch
literal 276
zcmX|*K@NgI3`M`puy8?wi3^u3IDkhWzycE!jI!Vis5{Ti6^7s1@{>QmeVugXHa@5G
z0SNbY?1op>&X2C5h#<9Ops%#*0ztdHi8G?q;$EluQNrhn>{ys@`b&R|d8G8O{Jrdl
mkP$_?rfr{mN!3^;8w}Q?1auX1XIzvDUSRruoXA!(rn3!nx)K2Z

literal 0
HcmV?d00001

-- 
2.43.0


