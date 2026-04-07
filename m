Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799CDFF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABRP-0002qG-AY; Tue, 07 Apr 2026 14:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wABQt-0002em-F3
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:45:53 -0400
Received: from qs-2006f-snip4-5.eps.apple.com ([57.103.85.186]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wA7G4-00059G-HI
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 10:18:25 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 329341800180; Tue, 07 Apr 2026 14:18:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775571503; x=1778163503;
 bh=dugTy6Mycl0V8PO55M7zjkrIKW6irE2gkRf+Eg5CDxE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ckhBIy3iDjPiBdBJk87Ecs78e/79xL4wf+KFNhGA8PfTsLcNNd1majJJB6IVXdH79i2TZT+lRJ3JYui7pcwA4CdQnc1bE8ygqzzJHQJz28sMonSkPMfoZIbgeeoQLmiYt9wEs+1REiD91oyyFMUo7CukuWSxdUVEtVBJSviLPNolp9jdwVgLIiR2MsfZv4IGoyiSR9t282wwpW7deWXl9TGk4wEKbmUgOlB4T+XoR61maMTdaLTQqmbSeuUXk1ovvJYAM6GFe6Zk6jcAcd0jXC7cSkxKLnf2SIgdgTbr8B9BLkFsRo7SxyW1vxbb8TncJoCnogQ7LiWsDgRChc4OqQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 213011800109; Tue, 07 Apr 2026 14:18:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v8 05/13] whpx: i386: enable x2apic by default for user-mode
 LAPIC
Date: Tue,  7 Apr 2026 16:18:01 +0200
Message-ID: <20260407141809.16862-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260407141809.16862-1-mohamed@unpredictable.fr>
References: <20260407141809.16862-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RjACTSaADDZUR_HJNvlitdzQ1smywFn6
X-Proofpoint-GUID: RjACTSaADDZUR_HJNvlitdzQ1smywFn6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzMSBTYWx0ZWRfX7mXCM6PhnwCM
 V+amG9iAOcQa0fYFPULoaW5rXMfG/mR6VXWw3uyHfBzDXNEBLOM38t2gPwO0PzgQOq7X14a6Lx+
 skMgp96RSVcdcg/B2mvl6USn+nwFAMa651Zgm/nO8D8TwqjLb9x/qqpXkxbfqCjXTz36I+MRhZP
 GbQyKYdqVoJTW5TYRJW7gE8Wq7YlenHOQAgxM+nFGWy4BF+LI4kQZTbJLap4SNo84HPXUQEd20W
 6YH9WL17To1AVjUPqtliy6eKQ6LHi4Q4PMc9wTZEQi8hYpaXZH6aWR6Xb1jFeZ9YtFD0bGwauI9
 isVPQb7NZ9J74jZqR9/yCpdL73+4ykR3gye1EZpVsZoBEhjfMQ7MPGoMgQFSws=
X-Authority-Info-Out: v=2.4 cv=RpvI7SmK c=1 sm=1 tr=0 ts=69d5122d
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uAk9FrDoCeqUxh5yT_MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0
 phishscore=0 bulkscore=0
 clxscore=1030 malwarescore=0 mlxlogscore=999 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604070131
Received-SPF: pass client-ip=57.103.85.186;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 0908dfd134..66f263558f 100644
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


