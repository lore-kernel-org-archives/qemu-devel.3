Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B98CFA770
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMO0p-0005Y6-F1; Fri, 21 Nov 2025 05:05:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzo-0004t7-9s
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:05 -0500
Received: from p-east3-cluster4-host5-snip4-5.eps.apple.com ([57.103.84.48]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzc-0007xc-Qu
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:02 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 1B3AA18006C5; Fri, 21 Nov 2025 10:03:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=hHqWKswAAt+3frWsas47NH9gPJrZtbs2m+TXuJ34Bpw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Vi0hAxwvqvP0yFXx+lTge725ViolqPr0LLQeKeit4O2b/4Bl1Qxb73sp/Ycr/wBp+wVb/rA7d7/dogCXyzHZKC+rS1ZmHVUnvDTMkP+vXiLm5bSgVX+rlhcY4oHhmXnko6dOF7suVccyaVXr5DKHdROdDVQaQSEHhnTTTcT/8jsoJNT54oz2WfU8CKRZVcHfAAYprlwTf7ZZj7LN245WrUvWVYcMKLKM6ZfDHWTx8+93IZGUx4ec5YUEiLEGJiorWK/xO+/7ZKctaKHjvj6QF3E39tiuFfNgiwgN9AXqH+PXMlOPYujpLk2MMjfgZKkCdLxAzWam1ZHAuI+xagk4TA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 0634118010FD; Fri, 21 Nov 2025 10:03:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v11 18/28] hw: arm: virt-acpi-build: add hack
Date: Fri, 21 Nov 2025 11:02:30 +0100
Message-ID: <20251121100240.89117-19-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=d/b4CBjE c=1 sm=1 tr=0 ts=692038e5 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=rhw6ylMp1rZ08I-IW0sA:9
X-Proofpoint-GUID: c3zaQ7lKzUxQq5U_f20nz04kwCxvO-SB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX0Els786mVlNp
 7vonJ4Xi5KvagKCiO+57uYR17bTZm8NGsr2dwCUVLt2sMPlQefC42UaawaRZAItpX0BjItz12lf
 61/wGYUJcA6bbunZtWQhDvfjhQZLh1cT6NxxmDQU1gh55nFvW9qvCpDkCw186A8L5H7E4huWhNH
 oqW+a4+xY2UZ3so3CO3XNrRFG0gGWC35prJiFEsUyhSbIZ5Ftff6nTUHzJBRyFIyT632Af7+0pG
 b7hUr39t0mYWFWLTt0+Ktswy9RFk5YVsLj0BHzpIxefCzSQ1NY0NVj01yWPyYqIPVxz12VGwKsR
 inl2o0UL8D6oCRJP5sn
X-Proofpoint-ORIG-GUID: c3zaQ7lKzUxQq5U_f20nz04kwCxvO-SB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=853 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAABN1bKBUKJk/P0DHsw3MLBtDgyFDEVg8DsgHYz08ogRmLpbeJ98QJfU30ZEXIKEYgUh4dRPALk5txUcfkxSUITpI9dEE7/1giqFGel+vCDS0KfrItHeN8Qj6hVCaF99Lc9+Cump/tIqChBgpd3xrwr5jVViu+A2uJaM/eWSxJvbUhPKDEw1AiE6/epYqkUx5v6CR5r0A51HySaTyzHQLAI21yIcZgs1xvwLLRWCxGlE3QCVqrqf7K4GyccRXieNWRo3F1S0YbKu30a/O0AxYQah3xgmzY1D9+ZK248KQrNkqEwgkiXOYNcoIMRjKGudMcpl4FMpVfOORFKPHAgaPKzDOpSmrX/w1hKJ+ijWDh0stFTKBmleXPp3PgGaXVrZ/TGrbsez/Jn1dSsR1T78TmiKHifKn84XwNzibIlu/bmKYY52wbJ1pSPwC8zQfcAqRsPjETiIAACFSPRJt681s7Kis4NLojkVkZOJYwcqbu/ObQtGC7SKti1iVMUEU8W7bkydOGqL9w3tasl+F59bcBszBQTqJ8uTouzprqycqZ+1S2zT5zIVaTDukOA0kMKDXtdM2UeaF1TbqWa6sxSzhK4JagRQYXpXiHYAo6Y5sZtIVS96A0RgBN0Tpkc39mqdZiQ38SeGkHkETh1lOYV/dtqLzPSiUmT1iXPZpfYrAtr8Q5OeCvkrMYGQaTH/atDCueo2gZifZ0dn+V/IGBkt2Pcu4UN47OtF2UXo2tX7xs=
Received-SPF: pass client-ip=57.103.84.48;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index 15e6239e5f..f7309cb06f 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -473,7 +473,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         nb_nodes = num_smmus + 1; /* RC and SMMUv3 */
         rc_mapping_count = rc_smmu_idmaps_len;
 
-        if (virt_is_its_enabled(vms)) {
+        if (virt_is_its_enabled(vms) || vms->gic_version == 2) {
             /*
              * Knowing the ID ranges from the RC to the SMMU, it's possible to
              * determine the ID ranges from RC that go directly to ITS.
@@ -484,7 +484,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             rc_mapping_count += rc_its_idmaps->len;
         }
     } else {
-        if (virt_is_its_enabled(vms)) {
+        if (virt_is_its_enabled(vms) || vms->gic_version == 2) {
             nb_nodes = 2; /* RC and ITS */
             rc_mapping_count = 1; /* Direct map to ITS */
         } else {
@@ -499,7 +499,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
     build_append_int_noprefix(table_data, 0, 4); /* Reserved */
 
-    if (virt_is_its_enabled(vms)) {
+    if (virt_is_its_enabled(vms) || vms->gic_version == 2) {
         /* Table 12 ITS Group Format */
         build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
         node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
@@ -518,7 +518,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         int smmu_mapping_count, offset_to_id_array;
         int irq = sdev->irq;
 
-        if (virt_is_its_enabled(vms)) {
+        if (virt_is_its_enabled(vms) || vms->gic_version == 2) {
             smmu_mapping_count = 1; /* ITS Group node */
             offset_to_id_array = SMMU_V3_ENTRY_SIZE; /* Just after the header */
         } else {
@@ -611,7 +611,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
             }
         }
 
-        if (virt_is_its_enabled(vms)) {
+        if (virt_is_its_enabled(vms) || vms->gic_version == 2) {
             /*
              * Map bypassed (don't go through the SMMU) RIDs (input) to
              * ITS Group node directly: RC -> ITS.
-- 
2.50.1 (Apple Git-155)


