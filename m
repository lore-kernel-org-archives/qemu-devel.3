Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECB4CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAEb-0001oA-2a; Wed, 29 Apr 2026 15:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEZ-0001n9-EL
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:07 -0400
Received: from p-west3-cluster3-host8-snip4-5.eps.apple.com ([57.103.72.206]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEW-0000Nk-JH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:07 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPS id
 501DA18002E8; Wed, 29 Apr 2026 19:06:01 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAE1fDl4fBBdGGVUERx5dVl4eGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCAEkKXQJYAF4LTgZeD0YLXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777489563; x=1780081563;
 bh=1/v/2pEP4nLxYkH1Z43qTSg56sckGJLMILFhZ9ygbpU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=GHvgYPUZ7tZ2cjCzZnPiDgPFeO88hhi7vFOhs0xZZsAZwLZcPA0nWPAggRAOOSwFOxQLxduaMWt1gDyCboShKLTOi3kEytOq9jdxR67mk10WUL9B6rXEzNho4mroC4imHW6WNlKLZ0W8wrFkecm0g9McHHVjcVBmd6ul4hI0ocKPRZXNUtF51vJqcEetvJb45PukqF17Fj7xFP+tXsdRWCQof7cfPmJJL9/O/NhckjCAKxl1c6awAkUff+SS0/KNCKL0HdMwDibHntQsWeUZ1XiMZp9Q/Ss8PQjK48FFDBlFyb12VMnNVli2HdSFqvmz/DRuevsYtotwFkuYOwIIgA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPSA id
 78D5618005CA; Wed, 29 Apr 2026 19:05:58 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v21 08/15] hvf: arm: allow exposing minimal PMU for
 kernel-irqchip=on
Date: Wed, 29 Apr 2026 21:05:25 +0200
Message-ID: <20260429190532.26538-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260429190532.26538-1-mohamed@unpredictable.fr>
References: <20260429190532.26538-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=TPRIilla c=1 sm=1 tr=0 ts=69f2569a
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=DcFNSUfH6uGOuzfjeGAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 82PdqqcEDhyBpJcOvbi3Qll_ac4Mly3A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE5MCBTYWx0ZWRfX0m+bBDluozrR
 poHjYG0mMq50hMlw4rAqdln5JKNrkOu/eB0nuZ3nNeUmMkmpApmsCWX3DoQ134dsRAZQtVW5Gsk
 134U7/1xwJbUquOPdbsx4IvFfZCxomGNfdFdLAQ5gYCvsNLxs/QY3SMkrI4lTgZUetwzuosXIqj
 E0SYWhLL3i0B+uWoAhk+HnmO4II0U3TZOMhLbDclBWkckaSFLvhcaJiBDV5PeMa65gGW8KHjKZp
 WvUPE7sbfo0cIAHdRyuYcvlekLeRiFz6Svp4Qy93PxGQZeEGLa72NV7mkN5QAPv7b48AKVrFOsm
 rWe1xycw5L+UgzUx0nTWEBTwv+JcL/XrzxBZqliwgUKKCu5CFYtlqIxX+4iW9I=
X-Proofpoint-ORIG-GUID: 82PdqqcEDhyBpJcOvbi3Qll_ac4Mly3A
Received-SPF: pass client-ip=57.103.72.206;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 9d64f2e1a5..390a3529ff 100644
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


