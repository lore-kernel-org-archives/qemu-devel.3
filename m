Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932960A5BDF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=S2NmE0W6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLftt-0003gQ-M7; Tue, 27 Oct 2026 08:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLfsH-0003GG-Iq
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:01:59 -0400
Received: from ci-2007h-snip6-11.eps.apple.com ([2a01:b747:3005:207::53]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLfsE-0007z0-WF
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:01:53 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 49CA4180013B; Tue, 27 Oct 2026 12:01:48 +0000 (UTC)
X-ICL-RepId: 01a17d3c-f0e8-7ba2-bb5a-836a4b214b15
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQtIAl4CRQdDCUwLQABGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793102509; x=1824638509;
 bh=Ul1w2QYA+PK1ywHsUbqg7Wns+SkrfY97/AOuaplBPiA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=S2NmE0W6NJcCYHvgWsCO5C27Y02msK4DQ7iAifJhmFHeO4hQ8Cd8fHwWMxUeiBmugqwtwWz9tLBAArk2Lg3NU7u9WhtyJ/kceoix6sfaUKdt55GmxzjYUHrOeLM4fjiIeHLd2mNVPhwYEq2MJNA81hOyL4cLNAJc1i2TuM42tqMuiSUqNiSLeJDp5cqeK+abDvi4EZCB89iC7/ieMH1ulen9RwV2EGDGD6d3tMvbA5dPNng/PYmHlNtYIUXQn79Tn0hnR8DVJBty3AUwRKGD829XXR6Nq1PBDlUxPRPM/cKhopc5nPp2yyCt0gCEiLPao8QKJVmft0hGdsPwWu7u5w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 E63711801A6A; Tue, 27 Oct 2026 12:01:46 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 6/6] hvf: arm: sync vCPU state on PSCI reset
Date: Tue, 27 Oct 2026 13:01:35 +0100
Message-ID: <20261027120135.53048-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027120135.53048-1-mohamed@unpredictable.fr>
References: <20261027120135.53048-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfX6U2C+pkxEj99
 5MLgTRwjw934hAjsHwCNVz01jkuDaETGjr9TjOk0cBdxGdXgnVLO2uBU42FHddtMrjDL6sKqw1B
 GTW79X+V397NAKPonvhcEtFCh7X+g2hL3bYDoUjsyrmTFULoG1nhW1U3O3UgyeQj4xxQ9mjJmJq
 EKYdDX2vd46gPlydMb0thclkd4oYtzkAgVO8KLsUnC8ta2U4vz7nr1yBvhyIDsVb8upACrx5Fm+
 VkpY9RZRmmW2dcJ+o9CGFp6xUKePe5Zns1/hv1jL2ZDI4tmXRS/fKvzmnVjT3mYiGOV7d+6/Us4
 Mdy1zD1cn7+vuRkrv49cytQpZGeRLf11mIPNffNWd0Ga1Mu55ZlyQH4PXBXfWQ=
X-Authority-Info-Out: v=2.4 cv=Cp6ys34D c=1 sm=1 tr=0 ts=6ae092ac
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=n0fzTBlYLd8wZCkSMhQA:9
X-Proofpoint-GUID: 1WPZfiQSlpR9qce5FdCFARweCrLGlONL
X-Proofpoint-ORIG-GUID: 1WPZfiQSlpR9qce5FdCFARweCrLGlONL
X-JNJ: AAAAAAAB7IdtTiKjTT7dLaEaE2+zkJlX9WZBXoTjGcLqcEmmMcFU4GLNzktt+1f4VPEWGogAQZ4lVZX8R4wESj9uoG2wajMCu30x8WBkTcMoj0ZWT45IU4RRBElJT42f62e8YC2TZoKMzy8MaxtbZrhAJlBew1RhnAgAWaNknFq7Pg76W/NAYKepglKfq06hJ/IGgtw5qJN3fxoYSu+RILlI1LbmLUR596SkmcZUoGBtifYPpIeviR8OM5cmnNSeTju9KQ8lAlyVR1pmzqSrvpOb7DMfqJXE1ISBNf7m8l6fefjkXVwEs696lnAbeNaEfrG9GJfstSPuMz9gfOtBnR8MoFEow7NMq48xvLpPsQTk0PBNxtTqP/tPZ+BxCjv1xBaYFSkzBMGolHbW9B5RK/0mLe3fH5nAYePFUgATgJK6vmfXN81dnN4Bj563fL23NwXADTeLD/j5Zibi5Fnt1zO9GS0JQdnMD3nuYuNl9ECeNGOo+E/7CFxHoqvPFu+R0u/7TIDdpEVTzZUGqWDWOzlaQTNbBwo4GIlH2tqQCM0Ojpsf8oh7E3jxCnag9wPE4VpmC9KTVbnussh5W+7cRbNi+/ZreVkSISQpBHbBGsvsdL8gm/PyI6MTd4Q7ueR6rG1kDlY2e7g0IDJY6HygBMpLt5/thCeBW2ODr/WoZpoxZLxA+F7JXM6vfiEQuRhOqftDzIOFxwz48KSVa3XXi4p7WuIxcFTR6HnRplZEaFAMhmfB7/XdSKWy7ESkDFpF7jgBKEUKEnbr
Received-SPF: pass client-ip=2a01:b747:3005:207::53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In case of PSCI off followed by a PSCI on which
is a scenario that happens notably during kexec,
what happens today is that the state sync does
not happen and the vCPU becomes in an unexpected state.

Address this via marking the vCPU as dirty during a PSCI power on.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index e1ddfe14c7..7ce2e38df1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1651,6 +1651,14 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
         context_id = param[3];
         ret = arm_set_cpu_on(mpidr, entry, context_id,
                              hvf_psci_get_target_el(), target_aarch64);
+
+        /*
+         * Mark state as dirty for HVF to sync context
+         * when the vCPU runs. arm_set_cpu_on() does not
+         * do it by itself.
+         */
+        arm_get_cpu_by_id(mpidr)->vcpu_dirty = true;
+
         break;
     case QEMU_PSCI_0_1_FN_CPU_OFF:
     case QEMU_PSCI_0_2_FN_CPU_OFF:
-- 
2.54.0 (Apple Git-157)


