Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E853D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0cu-00056K-CT; Sun, 28 Dec 2025 18:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0cs-000529-T2
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:56:42 -0500
Received: from p-west1-cluster4-host10-snip4-3.eps.apple.com ([57.103.65.164]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0cn-0007AH-Sx
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:56:39 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 076141800751; Sun, 28 Dec 2025 23:56:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=1CjKM6KDEmf5eo7QDBOx5N5scvQteXKGcwrcKL+2vCA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LAc4znXfQbXvtnHRxjnjmD3r1JY73JOEbc3WY3g/vlgg6rPRoFchnju8/XXVxJB8ns8T5TrRVtNs5MJpWE/yxLlELHoFMXDdqKe6on9tB4N63FDiH+u2GSx4Lx1/I3aSYvD7Y5FzgKIYMRw1uZGw9VPK1cNylkOBIi1Mo23das99T9UwnFRpWTCkdeqNsy9kiNNLiDJUKrEhoGpSo/OxqOlIvaVLsqIVyTSrulEV4OdBlx86tY6Tgq8wTjERbVhCCzVj9K8L5nQ+EMkaNNzFBPE8jqTJA4NSnA+egZkIzKeqqAPW7XZiKkdsdlQC/mEAl7ODpuvS1pJr0Wyiq/mQyQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 B3ED318000B9; Sun, 28 Dec 2025 23:56:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v12 08/28] hw: arm: virt-acpi-build: add temporary hack to
 match existing behavior
Date: Mon, 29 Dec 2025 00:54:02 +0100
Message-ID: <20251228235422.30383-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDIyMyBTYWx0ZWRfXzrTr5EsRZPYj
 QXxB6Y6/+7lKl8AoIuseWMBO6m45XWgAWzNGySC3hy/QqstbtaGquaMET0A4uFoQ3x372RhOjxA
 Uv2jDhfi6uVObAj4jhtRmM08dJqKHyGyG8oq0aWCkoX4uy2hL7C9oZYz6o2RO4qViONQemMh7kI
 9ki/K0PMyA5jUPd3OMCT1QbSvVaDJGsBfrUaabNkWFi0dXkghsiT8WSM8qeCAJ9LH0TWA2XaxUf
 O6nUSUixZIEVb9EpQRrpfv4xv/h2kS8YkpkgdmgegFCv5dOac9GEYkKGU/9z7a9PNKHxmDYczVt
 tn6s7CSPw87WzNo3Js1
X-Proofpoint-GUID: Fadwj1TMWmJSLQzJeE44ZuSqq06F9ZMJ
X-Proofpoint-ORIG-GUID: Fadwj1TMWmJSLQzJeE44ZuSqq06F9ZMJ
X-Authority-Info: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=6951c3b3 cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=HMNHyw_DGvBsvbusI_IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_07,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 suspectscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512280223
X-JNJ: AAAAAAABTeNfovWtPCnelYkI7Whkwav5cIsnvyD1YFj4+gLpYVM6erlHd1gMDCCuCfmkEetazzj4nuv3JEo4cZwiqirqzD8NR1vbLAYl92rNJe9TQ2aZNA47LxKZSuv6zHU4miCEfLVvq0Q0Lhqbb9qQ38ezOqCquPR8vxK0Ow7I2o2XKTPcq1NI1HunJ8+7vPG31VBtaXRXCz6vGPxOkbxo/bcQO3/y0aBryR1AqeB5kN3JxamlC6fvoqrlbwRgv1MCiXSBGFb0m3KqKQyGTlXlYC4HqUhb4rue//i8iJ7yjR+Le3q/p7z+kkHEjShMEISTcYr7RwytweZ6m02oIFryUuBZjI6/QfjiDR7FE9mFO5rGIAa257ujXrzoOvycdl+tbes/5GzbzZc4TTq95DhR+MrPZFh5SEcx/nhLePGaXO8B5XluPxeMPzWAJbp1TqsLA2oLoOygGrcurZh7PLZXEsyJgVzxdHo/GkmM59Cys+i8Rm7qN5Ob5Oy/TUSHXOjKIvBvCYTOybyP/agg5IMvxUZ4Sjdiugjh9XPt1IU3wDxDtPcGzP+E2Hz9Y7FQuoXTr/d1hVS1oqEXmBwUu0xieqLdmQGGMGKqDiyQvrjHCLkejfFdXWh6SeWZihEyQFdnAj4B1SPMxqdyIhz/yPLKOR/lYOyU9Z+jiu1RY/2yn2ty/kRw8ICmmcRJakzJPIzjGP9Qw+4xboX4RwIiZGEsGcVhgcNFx5SeankJwbp2AUrQubkCX1zj6AZsd5aUxgby+ZRBNa1GX2U6imeA8htmep0wx48/qcZgSwMdYYzZBBCvT2LGysAIyr4fWsEjhftDKb/Geg+28xROcnS5KdQCAUHcZHGmzKTD6BXqMcARJ7viTgQuGyRIgDFKKQhXPgylUZTOeMfRG37JnACAhiCH5iY8oGekaizpEaAy6dVqlI9PhRaU90r24MajTfrqYoA=
Received-SPF: pass client-ip=57.103.65.164;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

In the prior Qemu ACPI table handling, GICv2 configurations
had vms->its=1... That's broken.

Match that assumption to match the existing ACPI tables that
have been shipping for quite a while.

And see what to do for older releases. Likely don't
want this to be carried around indefinitely.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt-acpi-build.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f3adb95cfe..2b217e8681 100644
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


