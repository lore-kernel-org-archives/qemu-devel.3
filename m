Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACB4CD13D3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAFI-0002Cx-EE; Wed, 29 Apr 2026 15:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEo-00023y-IX
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:22 -0400
Received: from p-west3-cluster3-host9-snip4-10.eps.apple.com ([57.103.72.241]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEl-0000WY-NY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:22 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPS id
 8D2DF18000C6; Wed, 29 Apr 2026 19:06:17 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJB01fDl4fBBdGGVUERx5dVl4eGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCAEkKXQJYAF4LTgZeD0YDRRQVXAVWBlcUeQ1dHUUOVhlaDFIPWw4cFktGExlOG1dNWg1AGVgGbRRWFVIEWQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777489578; x=1780081578;
 bh=oFaW6jR5lddoGoGwR6tTxwA6nE1Ag8Stsv9wMgLDDpc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Eb9VAnzKcKZ8PT/4cE5BNJQg3njUrwP+jm3IkDONy9DRyxyOJ1CPKRrN4f1qjQfu6PbrMw226CQ2nau1vjDlrwXgB8n41QFFCfq3bg18YC2Mw+vFHwU/6tbv+noaf0dc06Bu+6VZMUYpQX9VholPKpKbM4OLERdRRh3KNTzSbMv5+zFof9sM0vSKhoDpb9Wm47pyvtWN87wAYzeEwJAwc9Y+1mB4WQE1qiCkylxeeKjhjvVhmHdkMLqzW1Lc7tNrw0exppTK17AFFwzTAo0U6NHLmN8MXKkxW2NTsbtcYa4vpkTP5bhjL0UlAA3rlBYG+6p4YSb7+gI8I+CTlwk/Dg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPSA id
 9FAFE18002DD; Wed, 29 Apr 2026 19:06:14 +0000 (UTC)
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
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v21 14/15] hvf: enable nested virtualisation support
Date: Wed, 29 Apr 2026 21:05:31 +0200
Message-ID: <20260429190532.26538-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260429190532.26538-1-mohamed@unpredictable.fr>
References: <20260429190532.26538-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=TPRIilla c=1 sm=1 tr=0 ts=69f256aa
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=gc5wapfoLYamzdkEL9IA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Fsw_g0Z9jSgsqejDFOy-Cj2llGkhA3li
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE5MCBTYWx0ZWRfX5Tg6wS/m+6fA
 +wJ6ZNhelT2Q4q5iUF1JPO5KuZtC7wyH67q7P+5oJzfS5Ghx3BYuYEmmt/HO2uWMymZR7p6hOf0
 e5N40SJP1yuBkRpkzOX+tDFH3WXZ3Cclf8CGHa6xUEAx8Dk/lODYtf0fStANze2CiApUx/kzZjM
 rLd4S+SDith5TvQZIM4cj9bStIwYPm9AqzfNVSCN/jMckc+Blz4tr45BbFtZL8Z0K2B53Eqv6G7
 E4QlJI/5ElUaUMWJqbWhNC3/8yIgAievY9k46S7O3C8X+Ba6krcDjuFLVE0v6Qi9E2l1wJ4tRj6
 MCHmBXhGMwPejdtLRpOO4ySO8yvsoE7a+82WlCm4fjTScuJUwluf6LF4r37zuU=
X-Proofpoint-ORIG-GUID: Fsw_g0Z9jSgsqejDFOy-Cj2llGkhA3li
Received-SPF: pass client-ip=57.103.72.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ca50411020..ad0a459987 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2719,7 +2719,8 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
+    if (vms->virt && !kvm_enabled() && !tcg_enabled()
+       && !hvf_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
-- 
2.50.1 (Apple Git-155)


