Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF03DF506D2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w27fa-0000vY-CJ; Mon, 16 Mar 2026 09:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fY-0000uG-FB
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:40 -0400
Received: from p-west1-cluster3-host7-snip4-10.eps.apple.com ([57.103.66.53]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fW-0003dK-Vn
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:40 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPS id
 0F6751803D35; Mon, 16 Mar 2026 13:07:37 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773666457; x=1776258457;
 bh=2MBOWueBXymgR1u5yqu7yl+ijtdKxS2qe2AUhW53SuQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=QgfMl9p1X5nuB6bIHNlvgxvdLaGVZquQpDkrkH9oFOJ/FMWrUko55ZpKPYJZL40FZKkHz2ac1yGVaR5uM5GIvOIwyPt2Q5Yf37nZN2wldaJZabtjiuGVxREJtUvQm5rr5s2dB/0vMeaffh35/nSnk10oQZR1OtaQxVtkGUNHMktwVzJWAaxKJ/P3mpU3/O7CjVAL9Y7+uUgaVABR4gmJorjzbTfW/MBZQmAWVzJD7iqw9Wd8y0iv5F0qqw4HQIXSL478Qy5WkKJHJNaM2WiUXr4HihYP5+XuMtzMfvnzwFzBuTQU0v20b/YBkZdvQH2ll39Lc5X4dpLItbI36YF90A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPSA id
 8BA221800363; Mon, 16 Mar 2026 13:07:08 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v20 08/15] hvf: arm: allow exposing minimal PMU when running
 with nested virt on
Date: Mon, 16 Mar 2026 14:06:35 +0100
Message-ID: <20260316130642.13246-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316130642.13246-1-mohamed@unpredictable.fr>
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=SI9PlevH c=1 sm=1 tr=0 ts=69b80099
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uQ0TefuXNqcVeKaJm-QA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMCBTYWx0ZWRfX7PzL3Z+967Cp
 oKRPWkSXwHgjVK+HlDwMtUGS8Ez17fOGgZANIMgrHlZ+gPU/l8/EnCSW1LidfaH2SDmX6QCVUeO
 AALMV1bsFv5RyjAeLx3iEq2/vWJ5Kia7n28UjdRgnsR5wA78TEx6sFnyi4qjxVzz5dKcVgPxt2+
 qPyduvNozJQtSDvl4w1PiB/4ez0KBSL5uc61xFN4mAxw3//e9H4BxA5//EzAXA91Zp/qnZxvJXF
 vBTKVSAwci5AM4Dt6f5hLA/+0F2DvsRDO5VKwaCPcKFeuGLoFIn6dMcLQr4in9s8Zt0qAF1mJVa
 kqAXbXUCGiFWbKAkjPlq6G8U1hdQ/7SKLiC2ld/UktF6zwslFzCI/EZjlaZUIY=
X-Proofpoint-GUID: R53nnz1J-5J8V3RRi9MzZ2om59mMhAsr
X-Proofpoint-ORIG-GUID: R53nnz1J-5J8V3RRi9MzZ2om59mMhAsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1030 phishscore=0 mlxlogscore=684
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603160100
Received-SPF: pass client-ip=57.103.66.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When running with the Apple vGIC, a minimum PMU is exposed by Hypervisor.framework
if a valid PMUVer register value is set. That PMU isn't exposed otherwise.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c971aa8cce..c457e67e63 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1145,6 +1145,25 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
 
+    /*
+     * Windows wants at least the PMU's cycles counter to be available.
+     *
+     * With kernel-irqchip=off, we "emulate" the cycles counter
+     * in reference to time in QEMU. Having that, even with
+     * ID_AA64DFR0_EL1.PMUVer = 0 is enough to make Windows happy.
+     *
+     * As it's a very inaccurate implementation with its only purpose
+     * being making Windows boot, expose ID_AA64DFR0_EL1.PMUVer = 0
+     * when kernel-irqchip=off.
+     *
+     * When kernel-irqchip=on *and* ID_AA64DFR0_EL1.PMUVer = 1,
+     * the OS provides its own PMU emulation, which is currently
+     * a cycles counter only emulation.
+     */
+    if (hvf_irqchip_in_kernel()) {
+        FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+    }
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.50.1 (Apple Git-155)


