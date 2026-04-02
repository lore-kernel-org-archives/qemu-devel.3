Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA30D6AB1B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 23:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8RlL-0004IN-4I; Thu, 02 Apr 2026 19:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8RlI-0004HZ-DD
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 19:47:44 -0400
Received: from p-west2-cluster6-host5-snip4-1.eps.apple.com ([57.103.70.24]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8RlG-00043j-Ra
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 19:47:44 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPS id
 4093E1800140; Thu, 02 Apr 2026 23:47:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775173661; x=1777765661;
 bh=hzbB6ujnr+WppQL4ANfJ1Az9OXud6YRaLnLOvZ6LWp0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XtnBKRAvZZ6RqjKpt1FQlzkspCGzOUVemOty47EH1fJd8MeCaz7mZcTAEaUsgH83L1sr66WmeShTL8ubrN8aX4fozzv/Ll+hbX7mVFvpMKrpTfihXDCcvz4DHon2xtkttC0TGxFZfsulAF7pLP/NW5SiE44X6QBh5Hza2DCAEy+oNPTCBj7WSKv01SXP+rt99ByNIk+xcuoVVNkQV9oI0WsxzDkxJCxkbvIOOE0ZVEhXcYT0xi172QoiSQrsznsHT0qOelmTAT7u3v+NM/rzaAPhhm/u1xQLpoypN0FuePchGivbP+WNCuG1XCQ0uel4GAoqd0gbWs0qPltwdgrUow==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPSA id
 E0547180015B; Thu, 02 Apr 2026 23:47:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v3 5/7] whpx: i386: enable x2apic by default for user-mode
 LAPIC
Date: Fri,  3 Apr 2026 01:47:22 +0200
Message-ID: <20260402234724.88276-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402234724.88276-1-mohamed@unpredictable.fr>
References: <20260402234724.88276-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=OYyVzxTY c=1 sm=1 tr=0 ts=69cf001b
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uAk9FrDoCeqUxh5yT_MA:9
X-Proofpoint-ORIG-GUID: CYDnzUESbOIsCmVbAhgpCJJp33g9Ql-7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDIxMyBTYWx0ZWRfXxocbKEEOqrFa
 SMFAe55XXpgD0uY76bfFHaublY+KItYXgoA757fkP1DoxQ2zD4y6gZOS9UR3iVZrlk6NTpKJEdW
 Z/ua9rpihGcu4IR6uX43fn8o2lNnWzjzYE6tw/Mp1XBlOOVLckGI5wszuBL2zDwF5BuksvYzysb
 9KQJtDwDUzJffUa+z1x3SuNEI6CDku+p3O5xej3v2IJVx6IgBPnIZPTEQAhFCEHYK4g4TWVsXkM
 O3lDrhWRb0nNcJPyfgd1PeR+1TDXqIZ6aOGHbDkHIOk08m/3qvJJlAe2msm1en/oFWZJAVMVUwU
 njvPWiftjbAOxFt9u/Bbqp4ydUI63agfU9S54z9aoQBqYQb/4h2i42v2OQl11E=
X-Proofpoint-GUID: CYDnzUESbOIsCmVbAhgpCJJp33g9Ql-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020213
Received-SPF: pass client-ip=57.103.70.24;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 53bf71d926..2eceb2e07e 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2281,11 +2281,18 @@ error:
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


