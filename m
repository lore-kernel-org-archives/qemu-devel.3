Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3160C10BA421
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 02:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5xOa-00011M-7Y; Thu, 26 Mar 2026 22:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1w5xOY-00010f-ID
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 22:57:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1w5xOW-0000TD-KS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 22:57:58 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxjsMx8sVpsCgfAA--.23910S3;
 Fri, 27 Mar 2026 10:57:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCx_8L78cVppX5eAA--.49748S5;
 Fri, 27 Mar 2026 10:57:01 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org,
	lixianglai@loongson.cn
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Huacai Chen" <zltjiangshi@gmail.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH V4 3/4] tests/qtest/bios-tables-test: Update DSDT blobs after
 loongarch rtc change
Date: Fri, 27 Mar 2026 10:31:24 +0800
Message-Id: <20260327023125.3802140-4-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260327023125.3802140-1-lixianglai@loongson.cn>
References: <20260327023125.3802140-1-lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx_8L78cVppX5eAA--.49748S5
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We add acpi RTC table for loongarch
The following are the changes in the DSDT table:

+     Device (RTC)
+     {
+         Name (_HID, "LOON0001")  // _HID: Hardware ID
+         Name (_UID, Zero)  // _UID: Unique ID
+         Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+         {
+             QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
+                 0x0000000000000000, // Granularity
+                 0x00000000100D0100, // Range Minimum
+                 0x00000000100D01FF, // Range Maximum
+                 0x0000000000000000, // Translation Offset
+                 0x0000000000000100, // Length
+                 ,, , AddressRangeMemory, TypeStatic)
+         })
+     }

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Song Gao <gaosong@loongson.cn> 
Cc: Bibo Mao <maobibo@loongson.cn> 
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com> 
Cc: "Huacai Chen"<zltjiangshi@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com> 

 tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4689 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5910 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4695 bytes
 .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4991 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |   4 ----
 5 files changed, 4 deletions(-)

diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
index 09aa903c4e875f541223e36f59b28e101599df20..4c7354721e76c9e3813c3502a8c51b41f26a3cd7 100644
GIT binary patch
delta 90
zcmeyZd{KqVCD<h-P>6wn@x(^1bxd|HtU)2p@f`6Uo-VvT{{DUj1_p)<9Py!^E<n;b
iC|J;#%b-h}fq{pS0R|X(1whRIKzd?<$mT6f?)(7LU=rK_

delta 24
fcmcbp@>`k9CD<k8w;%%pW6VabbxfQ2n4S3nXT1kE

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.memhp b/tests/data/acpi/loongarch64/virt/DSDT.memhp
index a069d6878fb45fa6b0e6342eedb0eb3d25eb20da..c578e7fe34b2dd70b4a1a07d5a08c1ae29533b04 100644
GIT binary patch
delta 90
zcmX@0J57(vCD<iIOq_v%@$5#fbxd|HtU)2p@f`6Uo-VvT{{DUj1_p)<9Py!^E<n;b
iC|J;#%b-h}fq{pS0R|X(1whRIKzd?<$mT6fJR$(0DiRX_

delta 24
fcmbQHcR-iRCD<k8fEWV<W8y}xbxfQ2m^nlMTWtnz

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.numamem b/tests/data/acpi/loongarch64/virt/DSDT.numamem
index 78ece52f57a383db128c7d1a08526e15ab911bb7..c47629c9bc817cc152b572be3145344534ce9ba9 100644
GIT binary patch
delta 90
zcmZovxvs+H66_KZF2umV7_yOT9h034Yfy-DJV(5Trwgx-zrUY>fq@|dM|`NK3y^dU
i3KlfxGU(D~VBle7fB{Bc0TA;)ke*l|vUv-WFFyc^XA%Jb

delta 24
fcmcbv(x}4a66_MfD8#_P_<SSRI;PEh%%1!JRLBNg

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.topology b/tests/data/acpi/loongarch64/virt/DSDT.topology
index 7ab23f47cc82dd7bc1975e17893a8cd61039e66d..368e4ee41727ca521b1906be2b021a6550bdda07 100644
GIT binary patch
delta 90
zcmZ3f_Fs+5CD<jTUYLP_(PkspIwm_8)}RpQc#e1vPZwSve}6v%0|P?_j`&bd7a-{z
i6f9`WWzeO~z`(=E00WG?0wCspAU&}_Wb+oLQUL(1z!HxD

delta 24
fcmeybwo;ADCD<iIQ<#B)@%%=vbxfQ2m<t5}UKa-H

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 2ed837faee..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,5 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/loongarch64/virt/DSDT",
-"tests/data/acpi/loongarch64/virt/DSDT.memhp",
-"tests/data/acpi/loongarch64/virt/DSDT.numamem",
-"tests/data/acpi/loongarch64/virt/DSDT.topology",
-- 
2.39.1


