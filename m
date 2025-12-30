Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12111E92FE3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNEx-0006Uk-UN; Mon, 29 Dec 2025 19:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNER-0006DZ-1F
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:04:59 -0500
Received: from p-east2-cluster2-host10-snip4-1.eps.apple.com ([57.103.78.74]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNEP-0003iB-Jl
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:04:58 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 8A4AF1800479; Tue, 30 Dec 2025 00:04:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=HpokZuec6NXVp7nrggRT+LOBrrsSy8fFvL6oRjwDxLI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=GpWotYFxUJPw6REaSEtHHSMKNqB18vzjZQZhoEEB4I5A8LiP4kkTNYKfxYoDsGM3wshP6cRDEu7THM44mF7m3Xgs72s0dut6z7GA4k89gpba/htcnnE5g1EOfHRDUmRQEGUrL2FtDewjx1rSh+KEByHnaCMVIn/xBx6t50wSinQ/8VytP+FBvbTKu2idE0UVazMAVo3kQtBfpxEAGQ1z2Geab5uWP1jp4d7ACBBN3qSO5iCqkhDK51xDydMknt+gv3fDArRrBC6fo1OJq8xr6QJKJ3n1dxdYjlZpe8lXud1ICCYDGBbXQ6wzu/QZDggMIvQRgJK+koPlmz0Ay5Tiig==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 514DA18000BF; Tue, 30 Dec 2025 00:04:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 08/28] hw: arm: virt-acpi-build: add temporary hack to
 match existing behavior
Date: Tue, 30 Dec 2025 01:03:40 +0100
Message-ID: <20251230000401.72124-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=TdibdBQh c=1 sm=1 tr=0 ts=69531727 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=HMNHyw_DGvBsvbusI_IA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: DzDNsGcZYZJmP5lSwgwk8sJGTyGsEfDL
X-Proofpoint-ORIG-GUID: DzDNsGcZYZJmP5lSwgwk8sJGTyGsEfDL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfX0pFsB+987Uu0
 sMT0M76OzruXwo9Ah3/MYRvEmCMeaYCs9nYtaLNo5mBP62r0ywRVXSZsdBPeY+SI5U4cBpyAIOA
 jizaeLJyoClike0/8Wsw3rC6jem/+u6sbAr12FUfS7LF7FK6zBLXL2mGOa1mih64pDGtAjcSxpX
 6WO+i3oGcgorQjKqPtoxp2GXQT2OiXGXYHNureFnqMrLszWaLQqu9TYtD8+fS5jnl2U1tj5wRFb
 GNdy9P2N8wnlWOG1sM0TdhbdDmT8Hd4flNrIEAb3VFmjWfn5BWP6OkYLvKALT8AIFjE0y+lk/9n
 +f/NqIL8hqJG0WouDoi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1030 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512290222
X-JNJ: AAAAAAABzD8cmI+Mg09GICaX0qgVVu1Pzvl4X+IRehNkgoIHpvPe98tOFcNJHOv4+TCNzAUCPaqNtSUZER/c8tSbZ0M/XOQqEAnECmj//mTmLBThpsnfC2WhHbrmeoJoKH06g7zc3LW0agIsTRFVkyf5TS90dE6V4TxgovmYsWyMbM11OG6N5sOnLVVIiLdhoG052XrWIFhruAc0Xx8xq1phE2H+V+x1+i/aDTOaGUUbwqj44ZkHwqqaVaVaONO2q3FAc6275UGCblK7wcDTns920fcdxZ6YWYnddgtzbCIKQEJe7ZqVf29RgAQVQgaSn85XtG57T62UFKBxVFUujuSgk8Kj/GHlr5VCghci/Ug2PkAYsXRCHvdG5JoKMJhHKKVdlgJ2eJLiVjWOK38GnuTFIUxUGqYMDUb0nl5tKPSG7uiqLq46RvwgeUMZc24xiAHszDcTvIfSk+8uxZ/JRRwRB5j8aJNDz4grMbB1dAd7XH8Jvyw5mlDPwzs8jOZbgHhzJI8KyK+1SKgSfdntHucAWobkFPJHBmLRoA3O3tRi+yFT1u0bPoyWNt85Yjgi6hiZnV1gHXMamB4y5vlFN/GsXAXbqXloWihn6ygeTaHA7Ql2I0lOyiQ/9GsR61R0ylVEtCZ17tnSxHAQHqryujXYCpufAugJ+1JZlsRUoyci5194DyHni1wEbP5gizt5k99UlocTLjH9QF9FtwsXoR/tcSNG9qqCqgqMtXOLCNx5zVUgc+sqREkUme9cSYrAhYCWijtR2O9sYbICBULrVou2dniA4CgjCsWZVu+ZQv0XECIjUQSAgS+++xxBpDoxHjfC6L0c3MWKl0g/sYUW/XXrZZy4rUqeMYjrI7+JsA15sEAJpXNd4kxrFIYA8kvSaOwEi8MzNZppot4kZpDKIb2D5bRMLNcRLH+6xDVQZppwjfJVSetsKGmsZ8SQ4HeSVwyWUz3QzN4=
Received-SPF: pass client-ip=57.103.78.74;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

In the prior Qemu ACPI table handling, GICv2 configurations
had vms->its=1... That's broken.

Match that assumption to match the existing ACPI tables that
have been shipping for quite a while.

And see what to do for older releases. Likely don't
want this to be carried around indefinitely.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


