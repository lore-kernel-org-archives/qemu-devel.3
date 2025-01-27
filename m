Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570EEC0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQ5C-00011T-Vt; Mon, 27 Jan 2025 09:27:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ54-0000lc-St; Mon, 27 Jan 2025 09:27:15 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ52-0003PK-Nu; Mon, 27 Jan 2025 09:27:14 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id DFDF2E0F96;
 Mon, 27 Jan 2025 17:26:46 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id B49FC51DAF; Mon, 27 Jan 2025 17:18:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 37/41] tests: acpi: update expected blobs
Date: Mon, 27 Jan 2025 17:17:51 +0300
Message-Id: <20250127141803.3514882-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

_DSM function 7 AML should have followig change:

               If ((Arg2 == 0x07))
               {
  -                Local0 = Package (0x02)
  -                    {
  -                        Zero,
  -                        ""
  -                    }
                   Local2 = AIDX (DerefOf (Arg4 [Zero]), DerefOf (Arg4 [One]
                       ))
  -                Local0 [Zero] = Local2
  +                Local0 = Package (0x02) {}
  +                If (!((Local2 == Zero) || (Local2 == 0xFFFFFFFF)))
  +                {
  +                    Local0 [Zero] = Local2
  +                    Local0 [One] = ""
  +                }
  +
                   Return (Local0)
               }
           }

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250115125342.3883374-4-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 9fb1c9a1bb26e111ee5fa5538070cd684de14c08)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: regenerate acpi tables for 9.2)

diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
index 8b8235fe79..7fcbecc799 100644
Binary files a/tests/data/acpi/x86/pc/DSDT and b/tests/data/acpi/x86/pc/DSDT differ
diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
index 06829b9c6c..5fb2b6376f 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.acpierst and b/tests/data/acpi/x86/pc/DSDT.acpierst differ
diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
index 2fe355ebdb..51c70746c6 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.acpihmat and b/tests/data/acpi/x86/pc/DSDT.acpihmat differ
diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
index 4d4067c182..ec920896fa 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.bridge and b/tests/data/acpi/x86/pc/DSDT.bridge differ
diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
index 045a52e75b..b4d0f151ce 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.cphp and b/tests/data/acpi/x86/pc/DSDT.cphp differ
diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
index 205219b99d..4a0a7a14e2 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.dimmpxm and b/tests/data/acpi/x86/pc/DSDT.dimmpxm differ
diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
index 8fa8b519ec..8a410533d4 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.hpbridge and b/tests/data/acpi/x86/pc/DSDT.hpbridge differ
diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
index 0ca664688b..20b1263496 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.ipmikcs and b/tests/data/acpi/x86/pc/DSDT.ipmikcs differ
diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
index 03ff464ba4..a9ccae14e3 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.memhp and b/tests/data/acpi/x86/pc/DSDT.memhp differ
diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
index b081030f0e..c1aa156a87 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.nohpet and b/tests/data/acpi/x86/pc/DSDT.nohpet differ
diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
index 2c98cafbff..d207b18c76 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.numamem and b/tests/data/acpi/x86/pc/DSDT.numamem differ
diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
index da018dca9e..947a961330 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.roothp and b/tests/data/acpi/x86/pc/DSDT.roothp differ
diff --git a/tests/data/acpi/x86/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
index fb89ae0ac6..3223604f7d 100644
Binary files a/tests/data/acpi/x86/q35/DSDT and b/tests/data/acpi/x86/q35/DSDT differ
diff --git a/tests/data/acpi/x86/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
index 46fd25400b..88dd156d95 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.acpierst and b/tests/data/acpi/x86/q35/DSDT.acpierst differ
diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
index 61c5bd52a4..fe708b4403 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.acpihmat and b/tests/data/acpi/x86/q35/DSDT.acpihmat differ
diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
index 497706c974..cc6e0a3385 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x and b/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x differ
diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
index 3aaa2bbdf5..a9a7cec8d7 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator and b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator differ
diff --git a/tests/data/acpi/x86/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
index 944209adea..bebf7d716c 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.applesmc and b/tests/data/acpi/x86/q35/DSDT.applesmc differ
diff --git a/tests/data/acpi/x86/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
index d9938dba8f..74b8553af4 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.bridge and b/tests/data/acpi/x86/q35/DSDT.bridge differ
diff --git a/tests/data/acpi/x86/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
index a24b04cbdb..d893781416 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.core-count and b/tests/data/acpi/x86/q35/DSDT.core-count differ
diff --git a/tests/data/acpi/x86/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
index 3a0cb8c581..ac87bc5db0 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.core-count2 and b/tests/data/acpi/x86/q35/DSDT.core-count2 differ
diff --git a/tests/data/acpi/x86/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
index 20955d0aa3..6b8eca2586 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.cphp and b/tests/data/acpi/x86/q35/DSDT.cphp differ
diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
index 3c34d4dcab..6d71a26fab 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.cxl and b/tests/data/acpi/x86/q35/DSDT.cxl differ
diff --git a/tests/data/acpi/x86/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
index 228374b55b..5a0ff97b9e 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.dimmpxm and b/tests/data/acpi/x86/q35/DSDT.dimmpxm differ
diff --git a/tests/data/acpi/x86/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
index 45f911ada5..a7e79e4983 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.ipmibt and b/tests/data/acpi/x86/q35/DSDT.ipmibt differ
diff --git a/tests/data/acpi/x86/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
index e5d6811bee..075ac613d2 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.ipmismbus and b/tests/data/acpi/x86/q35/DSDT.ipmismbus differ
diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
index 46fd25400b..88dd156d95 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.ivrs and b/tests/data/acpi/x86/q35/DSDT.ivrs differ
diff --git a/tests/data/acpi/x86/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
index 5ce081187a..812ed0fd18 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.memhp and b/tests/data/acpi/x86/q35/DSDT.memhp differ
diff --git a/tests/data/acpi/x86/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
index bdf36c4d57..3d5131761c 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.mmio64 and b/tests/data/acpi/x86/q35/DSDT.mmio64 differ
diff --git a/tests/data/acpi/x86/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
index 1db43a69e4..a98567b923 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.multi-bridge and b/tests/data/acpi/x86/q35/DSDT.multi-bridge differ
diff --git a/tests/data/acpi/x86/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
index c13e45e361..a550cf23c0 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.nohpet and b/tests/data/acpi/x86/q35/DSDT.nohpet differ
diff --git a/tests/data/acpi/x86/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
index ba6669437e..22b2a21705 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.numamem and b/tests/data/acpi/x86/q35/DSDT.numamem differ
diff --git a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
index 6ad42873e9..c26f9b1ba6 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa and b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa differ
diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
index a24b04cbdb..d893781416 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.thread-count and b/tests/data/acpi/x86/q35/DSDT.thread-count differ
diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
index 3a0cb8c581..ac87bc5db0 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.thread-count2 and b/tests/data/acpi/x86/q35/DSDT.thread-count2 differ
diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
index e381ce4cbf..0a91b7ba85 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 and b/tests/data/acpi/x86/q35/DSDT.tis.tpm12 differ
diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
index a09253042c..b9c83bea1f 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 and b/tests/data/acpi/x86/q35/DSDT.tis.tpm2 differ
diff --git a/tests/data/acpi/x86/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
index edc23198cd..16b4677587 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.type4-count and b/tests/data/acpi/x86/q35/DSDT.type4-count differ
diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
index 4c93dfd5c4..7cdde13b45 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.viot and b/tests/data/acpi/x86/q35/DSDT.viot differ
diff --git a/tests/data/acpi/x86/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
index d4acd851c6..5a6310f453 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.xapic and b/tests/data/acpi/x86/q35/DSDT.xapic differ
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 085dfa9ff4..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,41 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/pc/DSDT",
-"tests/data/acpi/x86/pc/DSDT.acpierst",
-"tests/data/acpi/x86/pc/DSDT.acpihmat",
-"tests/data/acpi/x86/pc/DSDT.bridge",
-"tests/data/acpi/x86/pc/DSDT.cphp",
-"tests/data/acpi/x86/pc/DSDT.dimmpxm",
-"tests/data/acpi/x86/pc/DSDT.hpbridge",
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
2.39.5


