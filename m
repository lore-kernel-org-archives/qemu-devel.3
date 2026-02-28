Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4FEFD0046
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 22:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwSUd-0002Wf-TB; Sat, 28 Feb 2026 17:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUa-0002UT-Co
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:08:56 -0500
Received: from qs-2004l-snip4-1.eps.apple.com ([57.103.84.114]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUZ-0005ns-1l
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:08:56 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 61DF11800385; Sat, 28 Feb 2026 22:08:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772316534; x=1774908534;
 bh=fXwYscBvvtHt1b3c45aaMrtykZ4/ZWPzlwZ5Y4HBqO4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=B/SH/YzMbEFSBW2OH6rYgqc0mSVB6IBZhYU6ags34Xtr/T1VeuXzSM/s2iC2qZrRb4RzR/yryhknCtefaNHJFNoUV5kKiicRQWpV0U+qL0JstSSQwVDxyZi0+3HGzYvKUXTsAsaJTvkcFzav7G9j+fEetGhtjjp77ZhaUsU22R8dln3U7ulk2erW27hm7EAiBmxNH/ZzKb5dvOTE1vLgOA/qgAJ2SZszBjRRzIQnLKi6rVt4sDElIWTvxHtLTnHzl1vN/3wcB87LnFzXNKBSjVS+z7CxsozOQBWp0sxcPWxVI5ozYFY1l8q+bPwsmbFaNri5bMtF/kNHvZB8kzEAwg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 CBC1718000A2; Sat, 28 Feb 2026 22:08:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v11 08/12] hvf: arm: allow exposing minimal PMU when running
 with nested virt on
Date: Sat, 28 Feb 2026 23:08:33 +0100
Message-ID: <20260228220837.35275-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228220837.35275-1-mohamed@unpredictable.fr>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7P18IvlC9nFEvwFcF1ZFtLAoh7f0oxFW
X-Proofpoint-GUID: 7P18IvlC9nFEvwFcF1ZFtLAoh7f0oxFW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwNyBTYWx0ZWRfX2dSCV3lLx46t
 h2F55vEdWtCws9KcpPfcGK4Bv/OUEW/Y8XI1BxFmTGDGLmtvyHetotBXX+DP0bcL6JdwFbkMiei
 Km0EGc2e321hSBlLgrtx4KCuvvTXU9t0CQernJPTV6EI1TvUS1nV8TATDxCemET3V5EQzQgixJF
 +fpE9CKqGKpWYMaF38t43AbKfSZTHnhk7I3fEpnBvi0QkWfevsUhhIi/fbhikHe0gnjwvm0Xm6t
 Q2N+QBPkV1I3FA3lkdGKjzLLt4IxQ3rcaW/y56KH4ONYC1RGDnKON8Qu/03KlvXlpxFzdbDkUEt
 Q72zEj/iLqWibpcWIttk0X2wDfypYEJTwODgLsjQJBYDQk1kun/8eNE9ZnssG4=
X-Authority-Info-Out: v=2.4 cv=Vpkuwu2n c=1 sm=1 tr=0 ts=69a36775
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=z0ix_qRbhGH81XwssrYA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 clxscore=1030
 mlxlogscore=660 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602280207
X-JNJ: AAAAAAAB1uY+4np86Dqz9E9mo8eK/1a+sKnhL8jXTuEBRpHD5d52rCrisEEmawhU22jX17DohBMtWv26JEDt5pdbAeEqxCjg8tiRWtckyDfIjQVAzFADahK3D0x9BiMFw/zpmHrE1wgfGSf0wQizaLeUKyyySaGerxR3CyOAD6T1WuY/LbbCdsXOh5h3FicFDaDGBK2xxxYfZRBDI+M0UQyw7GN2geqmk72UH9djBG8hrqNh8t3gqHrqLHM3vHazTtK5ltVJGjGRU5xI4IUh7b5c3r6B6wD94E7IeEqBJzjPkozfSrDK2jplHyYw1WF5E1MNh3J3oRH94qh8uhV1/S4uH94OOU++xGDJ7AU3BQFkrT78CEV+hIIChNYHEWEzvfhlh/H21I6+3DINwxdupliwzpGybgbMPe3+g7713vUlNQ5C1SGe6p/72R/Jx8VAMbueZ97gMXaPLWTw+PTmq3bqlim1/C+IpN08FpXmVFllZNZygJpMzE+uiNUi4oYpqQOogmM/T9R/hN8QlZSKqtdA/hUDYia6vZuMHRT9XxKfq4UiGbNYc3/Hh2sQzkp0WeaA2/1x0tdQ8Kk++wjqWuoIXIxJjElFevi/wdPnJKDTpykPoCdb7Ti3IiYCzat7IZ1Vx3r6NyhIjqxN7eJ6YE0lgvkBldFsTBBqcbJehpBlPHpV4jTcAoCu1fJWNdq5POKIS6DDJjZkyfk/Sv3nvf2+VvqeEDuGSeQ=
Received-SPF: pass client-ip=57.103.84.114;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
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

When running with nested virt on, a minimum PMU is exposed by Hypervisor.framework
if a valid PMUVer register value is set. That PMU isn't exposed otherwise.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index be1ff93e0e..0f45e22221 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -879,6 +879,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     SET_IDREG(&host_isar, ID_AA64PFR1,
               GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
 
+    if (hvf_nested_virt_enabled()) {
+        FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+    }
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.50.1 (Apple Git-155)


