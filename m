Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C16CCCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtRa-0002BR-JT; Tue, 28 Oct 2025 19:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtRU-00029I-LR
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:32 -0400
Received: from p-east1-cluster6-host8-snip4-10.eps.apple.com ([57.103.90.211]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQw-0004oM-Na
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:32 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 4A8B418034C1; Tue, 28 Oct 2025 23:48:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=UWn29qzaNoAUhaIt83YU72VeuI8u9wWPuGGjPH2xVQg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OgrTeQxb2VBJpq3SeiYXQQ9Kuu9AtXQ7CJL5crwCClDuNpSZZ/2xYY6Nt4Yupp1ScIf1Jtb1aiLboRSJ7M16HwufuM8/jUsagCtuFepeXwiUeGF5iKC3K6uLy3nmtxw/0q6PlM8iahpnPvCzmDuTSP9nXjfqwNccQginO6+LtOOGHGkT2CT+oBSw0itbJMT1Twz7m+QOEKi0zcla1sTkJpqJxk7DOxwhAzZ5YphwNMxSK8wulX8i3aSMP1HABzl3+HXs/yObku0IVSt6sGpDG+Wz4SSUGvyFjlyeTzQBtPWiHvsh4C2tV/V/1OdH1gIi4lQxUCwQfv8NGz7HN66+sQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 2410818034F7; Tue, 28 Oct 2025 23:48:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v9 17/27] hw: arm: virt-acpi-build: add hack
Date: Wed, 29 Oct 2025 00:47:47 +0100
Message-ID: <20251028234757.39609-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfX5FSfsaFpjqun
 3NL8d5JINExjDUJCX6ZKTgWuK8YsWSpeB4l5Mhh0WL1Qz5dNBXIsYvd9S7YeBcTBd3FdaKH5UoC
 wa4j63bkCIodWZJoelgQOnWyV3CIIdp+IWj3OMio6H0at26JuZIGqvLWxhL8YgUU3h5IfEbeOe1
 +SPLvTq+Cz3bCFwXM0HnsvUnpVndi3W5LIMijbcp6/KKbpo9bUAvKBrUMiJlqQRI+KbsKsLOoxY
 xc8YY8qfnu/4IhE2xHiZrTqMlw3hJe5T1CWrVA5LjaPHGutyYlk+SbYSVApvXxp2Kx44r2Las=
X-Proofpoint-GUID: -KZW-3ZAZ2DwX7vK9_9OuppIu_gX4RJM
X-Proofpoint-ORIG-GUID: -KZW-3ZAZ2DwX7vK9_9OuppIu_gX4RJM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=788 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABxlC5k/+AgJ5vIBtexjrJa/367FqVyI1tteYc5yYUDbj/mk4AaW568vpIW3Qf1PswpAHFpSYmRTcIoqCFGy+hu0NOhGtMq63rVeLegmWSZsxM8TTCu+TeaZyQJCR2lGcXDqFR3Q88mVyekJQ/gIahAN4BlSzVf+ZdEUlDOkXzbUdKHLKp6jL5LGrNh5Rh15XQ66wUKiLA7fMwrWexUriqeCqaoGMsTgf7+bImOz+FzzzG81JEfTcJ1qtHHa3WIwuQCgFfstBluBGbezoT68Vcf9Ft8w6OyacnAVmul13kE+dkO+8Rbsm9YrBJUSCe03kaaDtWCQlIN69sgKmQ6b7XMXsB7/r9SsyVKG1VVLOo2JqS1rQ1qf87zmlzKwLMCt0Ng1VwoxVWtIVTpaE5lxLSp6oiakppJ4oVjM++r1jxMe7k7pz2wZqbTA0FDGI8Mjey1kIk7ytem8jj5l9zawJH1i/niJ7yTc4OLo9BN5xiSFqSFkznk7+W1RwLPdQNANl8D6vmhjkp/oH2G6JgzCkT+l2qXf6LF90oCFiJq+HHZP3YvNFIaGu/vU00EBrAe7c3t0lrzgii9wrAlrBEpk1YyvR7GE9h9zwEqRDblG5LobhyHENT5rRFAX7MrEbSlX6BsWW+/ZGJOjpD8BN8ihfxYd3BGnSEwwTLymEGe5+6OnzdcVdop/R5cGNEDF1kt+YmpouZP89iv5vM2CM=
Received-SPF: pass client-ip=57.103.90.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Looks like in the prior Qemu ACPI table handling, GICv2 configurations
had vms->its=1...

Match that assumption to not make the test suite fail. Probably not merge-worthy...

And then maybe see what to do for older releases too?

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt-acpi-build.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index a6a56455a9..39dd3d1020 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -472,7 +472,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         nb_nodes = num_smmus + 1; /* RC and SMMUv3 */
         rc_mapping_count = rc_smmu_idmaps_len;
 
-        if (virt_is_its_enabled(vms)) {
+        if (virt_is_its_enabled(vms) || vms->gic_version == 2) {
             /*
              * Knowing the ID ranges from the RC to the SMMU, it's possible to
              * determine the ID ranges from RC that go directly to ITS.
@@ -483,7 +483,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             rc_mapping_count += rc_its_idmaps->len;
         }
     } else {
-        if (virt_is_its_enabled(vms)) {
+        if (virt_is_its_enabled(vms) || vms->gic_version == 2) {
             nb_nodes = 2; /* RC and ITS */
             rc_mapping_count = 1; /* Direct map to ITS */
         } else {
@@ -498,7 +498,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
     build_append_int_noprefix(table_data, 0, 4); /* Reserved */
 
-    if (virt_is_its_enabled(vms)) {
+    if (virt_is_its_enabled(vms) || vms->gic_version == 2) {
         /* Table 12 ITS Group Format */
         build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
         node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
@@ -517,7 +517,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         int smmu_mapping_count, offset_to_id_array;
         int irq = sdev->irq;
 
-        if (virt_is_its_enabled(vms)) {
+        if (virt_is_its_enabled(vms) || vms->gic_version == 2) {
             smmu_mapping_count = 1; /* ITS Group node */
             offset_to_id_array = SMMU_V3_ENTRY_SIZE; /* Just after the header */
         } else {
@@ -610,7 +610,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             }
         }
 
-        if (virt_is_its_enabled(vms)) {
+        if (virt_is_its_enabled(vms) || vms->gic_version == 2) {
             /*
              * Map bypassed (don't go through the SMMU) RIDs (input) to
              * ITS Group node directly: RC -> ITS.
-- 
2.50.1 (Apple Git-155)


