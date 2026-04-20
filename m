Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC555F557FE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm6V-0007F8-II; Mon, 20 Apr 2026 06:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6S-0007Am-5Y
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:45 -0400
Received: from p-west3-cluster6-host12-snip4-5.eps.apple.com ([57.103.75.38]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6Q-0000dv-NJ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:43 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 3311F180047E; Mon, 20 Apr 2026 10:43:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681821; x=1779273821;
 bh=IShay1Ni0PZxOVHY3UdoELgY8h3uyJIPv2UhTb9vE4s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=GJ0RwysjOTKv/0vN81m9a1Xte54h1czZpPevEmUKm7EATlxZOSuJyR4GYisLnKrrPmA7zXSh1esoOI4gNck8aZ5sLywfh8gLdrZY/LcYkKY0RvZJfl0BXVmsr3qWon02gIb1TYGF2fw/ktc2rOC+XV7OCMRp6lnaX+z3H+q6Y3SVSDGeQxO32rMFEvzR2w0xTe4wFLlWNpzpC1KKtVZStsVtIyEuLH5HWf+Y/LBnA2RBUSnALbK8YNjUhrVijFeGLoFsu3e13zXZiLeqfT3t+ANJLynaWQCx0N2dBpcPxlTq/SI5qldWfxYjjq70TmmcwEcuLyZzHfwZe/aaNGKQIQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 4D6111800451; Mon, 20 Apr 2026 10:43:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 18/38] whpx: i386: enable GuestIdleReg enlightenment
Date: Mon, 20 Apr 2026 12:42:28 +0200
Message-ID: <20260420104248.86702-19-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fuvp5F2VI2h6Nxc3O-HE1SZDUDLubjzx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfX/YMFW4KNNdDF
 rHO76IAGCx1rNYSZjFGP1hRvSg345ds5l1AyI46uHColpi69WyxOs4wW9RTwRfwpuvWXqbOwwud
 c3OFI7F5W3eGPHhzN6KscK5LhFcKwk9DVCEcDYcCz1tgkeVotyoheDUvwMBHpWMGSuEFTxy91rB
 g8MZg2uLdvINifW4jVuPEROjo+vkx0AlFDaYzEduvMyW3DP2v+tYJe/ZOZV9TaMleBaJm2j2htd
 jvRI+C+se5KRD+SkhwDKa+hGwXgdycDHCmuZ8+Nl1I83IjKQWrMspbQSTtleiCch5JcVrIWdZah
 cj4fcjR4UJ0jA8DYhPECWGcyxz4vBPD/NJheg4E2jd7eLIJrhCGet4guFmd764=
X-Proofpoint-ORIG-GUID: fuvp5F2VI2h6Nxc3O-HE1SZDUDLubjzx
X-Authority-Info-Out: v=2.4 cv=TtzrRTXh c=1 sm=1 tr=0 ts=69e6035c
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=givlr1pFTcEyfNb0yRoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0
 mlxlogscore=982 lowpriorityscore=0 adultscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.75.38;
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

This corresponds to HV_X64_MSR_GUEST_IDLE (0x400000f0).

This enlightenment is only available by the HV when using the Hyper-V LAPIC.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 550f30d50a..f856022a87 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2686,6 +2686,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
         synthetic_features.Bank0.SyntheticClusterIpi = 1;
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
+        synthetic_features.Bank0.AccessGuestIdleReg = 1;
         /*
          * These technically work without the Hyper-V LAPIC
          * but behave oddly for multi-core VMs.
-- 
2.50.1 (Apple Git-155)


