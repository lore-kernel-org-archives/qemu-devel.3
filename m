Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCEAD6AAFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 19:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Nlx-0000Vb-Ab; Thu, 02 Apr 2026 15:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8NlI-0000Kx-F7
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 15:31:34 -0400
Received: from pv-2002j-snip4-4.eps.apple.com ([57.103.64.145]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8NlE-0008Gs-Af
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 15:31:27 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPS id
 206E71800582; Thu, 02 Apr 2026 19:31:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775158283; x=1777750283;
 bh=lxRT/MfPZMC+jhFCpDh3RcQX68IqDeAGB+EFtduJgL0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Wl4N6iJUnBel3aw6kI6kxIAXeqwjPIsIyDtn/MJpcAg6wptDComyaVYw0FqbvHnryd0jRZyEOkD2tnL88Toet5FvloL+nd/iM6DhxbjlDAU2TNv0Iw0IykDl2jHK+TXcmTeKFAu+n5Eue+aXBbL1HX7s/e4dmhD/qVXEleBo0m7mNDnUKCNEGaKymMI4uq2SlBBoHFmzuYup/6zk9DXiJDheNTjr1iCX/V2++2VH8FNnf4ZzN5RILAhVoZV4rskXqofBTR3Xp2PG4tojAwGRAVmXE3rmFwG3OUADLjN+09X0uUj4zXHF2reiHK7Yjawz5Kztkkn2PcnodwTtcteXQg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPSA id
 CA14D1800228; Thu, 02 Apr 2026 19:31:19 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 5/6] whpx: i386: enable x2apic by default for user-mode
 LAPIC
Date: Thu,  2 Apr 2026 21:31:03 +0200
Message-ID: <20260402193104.56331-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402193104.56331-1-mohamed@unpredictable.fr>
References: <20260402193104.56331-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=QJ1lhwLL c=1 sm=1 tr=0 ts=69cec40a
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uAk9FrDoCeqUxh5yT_MA:9
X-Proofpoint-GUID: DznYdAdlKYuTcNPgmKApUxPP_QttwAHo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE3NSBTYWx0ZWRfX71TzYGoUXq+k
 Vp1BAB4LL0268BPbeCtXMm1PBia/ylBlAOLmjkWtYRemRbA/Dk82zMOfpS8a1Qvv1wIjUZH7iOd
 i4ptVHbc3WwlZUZC4AY5FeRFU3yEkw4xwQkA1fKtjskHiZjQZ/UOO6ZnkKXjeaRlCRhF2VcdRNE
 mIdi2Lyunb5cWPOr0uUQ+f/FAqwunBlWJGhwGKSWMzV/LJ8wbtFcfrRQC6Yoec/rXFHW0MbrgrQ
 5kVHEx7LlcEB3hAMe2CWaUaLUzoC5TLwJ1lgl3GprhBsNJpHnR0g0vzRWPSLmcAxGIZVYwchg2f
 m7+Hm55VhUmmbtA/44ZXjr4WW/TftjREkVLWAXSxWoOasDEE0unpdbUrtSs/3E=
X-Proofpoint-ORIG-GUID: DznYdAdlKYuTcNPgmKApUxPP_QttwAHo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1030 bulkscore=0 malwarescore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020175
Received-SPF: pass client-ip=57.103.64.145;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
---
 target/i386/whpx/whpx-all.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 3cd83b506b..b8f53ca532 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2275,11 +2275,18 @@ error:
     return ret;
 }
 
+static PropValue whpx_default_props[] = {
+    { "x2apic", "on" },
+    { NULL, NULL },
+};
+
+
 void whpx_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
 
     host_cpu_instance_init(cpu);
+    x86_cpu_apply_props(cpu, whpx_default_props);
 }
 
 /*
-- 
2.50.1 (Apple Git-155)


