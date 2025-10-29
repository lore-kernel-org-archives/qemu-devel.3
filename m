Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4664ACCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA5y-0003qW-QW; Wed, 29 Oct 2025 13:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5k-0003id-Er
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:12 -0400
Received: from p-east2-cluster1-host8-snip4-9.eps.apple.com ([57.103.76.82]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5O-0003Pm-Oq
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:11 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 C3FED1808524; Wed, 29 Oct 2025 17:35:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=UWn29qzaNoAUhaIt83YU72VeuI8u9wWPuGGjPH2xVQg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bVB8vrO2nDt7QLrJq6/AoEUZnaNmmC7MR+4/cpQx51xWjKpbUVHn+weMNxMsiishMvvtddoZjT4Mvk1vDfVO4bQ5myONW7dawVe9WrImgS7oBjz/Z0DxD0L582o3Wu5EO4KdH+ytDRxjAJxopSqDleuQjL7XAY09IamV/yvwwLxSYL1gGOm/wiuGXLOw4vzQgW2vNqzOW0/BKnup8D6pYxNluPsHuZ3NQJgVspYU3C5RiZcVla9IthBodlwOwdngFxUoXg2u1hC28nrFm8zaGNu9zDe4upNFG8ZdDrIvEuV1mp84oHLnPBcWJUtGAMvf1GWd/f5/sX68k7AefJEiZw==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 86621180D85B; Wed, 29 Oct 2025 16:55:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 17/28] hw: arm: virt-acpi-build: add hack
Date: Wed, 29 Oct 2025 17:54:59 +0100
Message-ID: <20251029165510.45824-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX8O1qKTZgT8bV
 bFqTp84ToT+DmH5uZCCv0+xezXMGsSkFlxxKCZFU+7iRwwHhm8QH2gNhnMbpXLsFNwrzog8Ohxj
 l7IA7DVNerTUReA9dWazUaaT9NAMDyyN/7WnOeFnQrpSHC6wR6rXWTbFd9KLYH+8OHQURD7abVF
 lJtymO+Z6Q5SBeF6Ck31jT5H6DL/NRRnWnJmk6WfNnmmvopAAdjlhiRidUF9LAfvPFqLJm8RVm4
 Fr62FBpRiEBtqRCCJlCaiaD50PzRD251/hK3d2q7Hod53bq1aysiXEBrMashN6n/pth9soPLQ=
X-Proofpoint-GUID: tCH4uJp5n3WFJR6ZXqtSBKLjhyNiuLhr
X-Proofpoint-ORIG-GUID: tCH4uJp5n3WFJR6ZXqtSBKLjhyNiuLhr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=654 clxscore=1030 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAAB14yAvUwUYTOY0sCI9dfMyVvuRLMg+Lj054HfyGIyQzQyhWfH70VvSNWEXAf08TD3WLSfFuBrXeisnLqBGXcAeCxb7rW6IJNy7NNYQ0tt8oC+bpqySfekIpseVgLW4zqy5IqBihqoC1AVlFff6Y/eOsVNXkJk/i0Mchfp+8Cks/M1EWVAG1nrWKLdE6pXMSb1DObCSh9a8DPrE0vG+bHIIj49na4j+UMrVY/e/FAeI8fZsEHF/dB66KdzzwQgIaOfr2QhN8i0X67arhkWbXNMNRMeXv8uOGHnkdwJNWY9XeXgXQf23hnBMx5n3jy17ageHZzc6qBIzBrKJ1ZvIaMLXm9JXoNfw0b25N+oMCpgNKfcR/+4cpei+TX5C6B6Y5LOeqQUQCaud/sH9FSVe2fMqz5SB4jcR4cIXHfap2BzoGeMqS/YS14KSky6ZU70aaK5DCIjvD8rOIekBjnEGHzrixZXzxVyG7AT8W5l5JVXXP9EoRerMnhpQTHDm/fukid9mCX46wm8NdBeh3QJG7xs6Qz7UxszYIEaM2MnDdie2UGymesvjJLKdsUC5HLHRGJUU0Do7DATLq5MD6dFAC/BFSHEhfQ/4AgWXTPJnkH5OXyxuhC9MfTxZmc5T3HDpH9UrnAsvoGKw4RKWsVBWk9i2q/lENcGA5hFpqN+QZTYSGYV5tFfZS7IoSp5kkZ8reZQnhR9CD0AqBTY588QN2qshpnuetVk6NmWVsHCuC8h+Gayew5oMeS+5Q==
Received-SPF: pass client-ip=57.103.76.82;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


