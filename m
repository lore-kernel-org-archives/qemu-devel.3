Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FEACCF9F2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtRr-0002Hb-Pk; Tue, 28 Oct 2025 19:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtRd-0002Cb-Lk
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:42 -0400
Received: from p-east1-cluster6-host3-snip4-9.eps.apple.com ([57.103.90.160]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtR1-0004p3-N4
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:41 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 9B89118034F1; Tue, 28 Oct 2025 23:48:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=yaziaz//KfkV1qB+UvLaS9dqmb7Qx8vSQ/YVwpl0DrQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ARmLsXqA2fiJ6QPaumzzuGiaLXUBnZMPFor/V68tRss2aFp8mfR6wlXW1cqJzo6jTV0nRIkNvuEqQReF5UJEWyRdwjDqAkjUnApC767Cl6e6NFIB9h8FSKLEysAuo5rGAPDJTYFLdhseGB8wIj/P0gQ5+N+NaTt6cElWXsecpwjEmbA2UgBidsUjAzmQ+TQKusrahesHBZ3IoxHERQ7W3PMyPhXMTSHCzX+paVzmHBsB6Dw6t6y0R3o6S+cdJGA1R6jj2VAJbYJWdaAvHpg8BRgBJAZqJLXlUqx82pH7hdP2LOs4DJmcDIxH3fGNDXhur6ZVgMbcNF5tAf795uTvPQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 0F3A618034F2; Tue, 28 Oct 2025 23:48:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v9 22/27] target/arm: whpx: instantiate GIC early
Date: Wed, 29 Oct 2025 00:47:52 +0100
Message-ID: <20251028234757.39609-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 35946c8eb1QmUWqEIx5Twq_zDx4XwmVu
X-Proofpoint-ORIG-GUID: 35946c8eb1QmUWqEIx5Twq_zDx4XwmVu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfX8akkavycZcfT
 yWh/KOj8WUg2Pooa5U0+OzvhpQGX1kVfuWkp7bbddLP7oFo91D4dR6gd6eqPi545t/VDgEzT2kd
 2YrLUbEql4K/YDYkK8nKrGzNQPQbWmr6/y8whRyDIaWBEMTj/VpVxqJV6YGLNyw25YNPNFzA1R4
 NN7kqlUMCx73ar10718yx54Q4XmdY3UVWg/dyPSbmITvhDsuNQp8P/5yffkQXEhpUxkpiakebIb
 +UiwUsKrGy90trLh695R20otdbCWYvyxbcpmLSFhKEgzSAXEsFLWb0A8+E8i6kbxleG8BGR3Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=639 malwarescore=0
 clxscore=1030 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABvLHspUapxdX5xLfTRniPsQxdgwdywd3f3shUuvSFG4/4SBc6LVnfI+mNqa/uRaDs05JdwN1fPvpW2HdMKd57dy6p2FSL9KJ+1p08l0BtfvedFOBpViLqUjRyGSKpWEFuhPtOn4u45otleKGZbUQhdm4gv3dD/atwE5bf0uSNJYKLluzRwcndeRy43hkgMxc/aXA52INqYZiMyPeF3lc7VH4BwVuz5AI6VItqDe0iJe7bKqhO4t1+Zbi9M9TeVw/I9kuk6q6dzg3UKcKlSXN8Tgmm7SNq2esB9CRa4CQl6/zHbBwFbmMjbpfx2HeVtXyCAGyNhx4JCd2mYH/tz8kk0hsu8MohiOXcGvkCsbOC/YOW8DtahbAyi5S1KhO9nGQ/V2HPTgxFQ+OPlQizKEbZbNkjMhHzWHSUpkX3uHH3ShEIJpPRsCAxC2fsctlY/Br6or5LxktenHJO4f/KEXKYBwrLCnsDdiQvdsdgZk3Hh48z7nX1c1tVoXcqNRGK5vSemg7cQhZsriQ0i66EuxsTxSZbAdw4R1HhfuH2ZVpF+krsUI7hvIE6KEC0k/drypvxDPrc7B0pa5pyyWnO4SIt8dtO89asHgs4myS/Mn1Ra23apDbOcdyMJsgZWOnqDhxurH/GCkfIF1BOEghjETLpT959fuXGPwlendARp9QMtoo5dNcC/LcIcDcr7KK944ctgEoYHfZ8I7mZL6l//4OFk3Qa4KNeqd6sR8hizLT5zmGbTZoPx7PwZw2YrVgJ5m5LqDyA3e8=
Received-SPF: pass client-ip=57.103.90.160;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

While figuring out a better spot for it, put it in whpx_accel_init.

Needs to be done before WHvSetupPartition.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/whpx/whpx-all.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 8f0a54f080..4d58e5e939 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -973,6 +973,29 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
 
+    WHV_ARM64_IC_PARAMETERS ic_params = {
+        .EmulationMode = WHvArm64IcEmulationModeGicV3,
+        .GicV3Parameters = {
+            .GicdBaseAddress = 0x08000000,
+            .GitsTranslaterBaseAddress = 0x08080000,
+            .GicLpiIntIdBits = 0,
+            .GicPpiPerformanceMonitorsInterrupt = VIRTUAL_PMU_IRQ,
+            .GicPpiOverflowInterruptFromCntv = ARCH_TIMER_VIRT_IRQ
+        }
+    };
+    prop.Arm64IcParameters = ic_params;
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeArm64IcParameters,
+            &prop,
+            sizeof(WHV_PARTITION_PROPERTY));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to enable GICv3 interrupt controller, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     hr = whp_dispatch.WHvSetupPartition(whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
-- 
2.50.1 (Apple Git-155)


