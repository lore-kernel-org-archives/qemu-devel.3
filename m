Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474CBF9D0EC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCiPS-00066B-5a; Tue, 14 Apr 2026 14:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCiPN-00065a-Gy
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:22:45 -0400
Received: from pv-2005b-snip4-11.eps.apple.com ([57.103.66.191]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCiPL-0006TH-SP
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:22:45 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-9 (Postfix) with ESMTPS id
 795EA180139C; Tue, 14 Apr 2026 18:22:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776190959; x=1778782959;
 bh=aiXyhBzTJzaIzKx5bXgk3uW8CyShOVzrypP76mpg4o8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UNvrRU1qK4SkW1Kel/MAY56l1X/8xo6bTGeo+jhBaFCaEGxwb3u/Bru5c3/WwHI18HUo9E1SNCdi5r8nPxOb3BRlN+Hh3fS5xOWJ5QINT8DmfXxww8hNbnh8g/j1KSYV9NkUxdgxkpkLNEoRfrYyETtnYs9f48Jgce+51rrpZzxCN3c5xRQXISknerPejO0l/WzeJNZVkrwQSIAmwnyIsP1qyddxXfa+OhF/dKGXeOzHkHKYTggJutQ062aDMQL84kiieH9QxLJjtaKI8KvNiJmSzaGujX98o5L+XXKwuV55B1vTCDrioRjsPQ/hEBdvufQoJt0dBK9Z+8u8D+6seA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-9 (Postfix) with ESMTPSA id
 BD0D71801380; Tue, 14 Apr 2026 18:22:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/7] whpx: i386: set apicbase value only on success
Date: Tue, 14 Apr 2026 20:22:25 +0200
Message-ID: <20260414182231.18776-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260414182231.18776-1-mohamed@unpredictable.fr>
References: <20260414182231.18776-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=DIKCIiNb c=1 sm=1 tr=0 ts=69de85ef
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uh2sygq7LFHjsVUyvz4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE3MiBTYWx0ZWRfX5jZ6xpIQGErE
 T2WslOwqraU4WB5+r/1DQbjqm4OLPHMGcipp0OBQVIyP8hLjj1DsLkyvx3niO+cwPUw9SQflbOB
 WXzzTg/3EnTmrgWhS8r8RKdNKVOLQk1Rw46z4coGO1RBR5Wmu3VQmz6+k+qtjfeZ9IlKGnKC0cs
 gx0dao3EwfWvMie77WUapP4V+lxH8NowR2gHkjbvyoVxrjj6283gk+uQBcyOG3YMY9o4wmS3vbq
 7AmBasyJFZyLqB57ugtIW8o0XCfp2ZJiljWHzFcbygoo1bqTtBYmlA4V7AXMkErW8p1UIt5nN/z
 hqBiylIKkcvzeD2nHpB+kMgX5oEw5rzbcwWsdaUokHTQS6gI1a7FhMftGFThUs=
X-Proofpoint-GUID: ly-SOi5QhLpTXdXF3ZY4qKL9M1oaVSvN
X-Proofpoint-ORIG-GUID: ly-SOi5QhLpTXdXF3ZY4qKL9M1oaVSvN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=655 lowpriorityscore=0 mlxscore=0
 phishscore=0 clxscore=1030 suspectscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604140172
Received-SPF: pass client-ip=57.103.66.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 target/i386/whpx/whpx-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 86d2dc1df8..56a789c5fd 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2001,8 +2001,9 @@ int whpx_vcpu_run(CPUState *cpu)
                     int msr_ret = cpu_set_apic_base(X86_CPU(cpu)->apic_state, val);
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    } else {
+                        whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
                     }
-                    whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
                 }
             }
 
-- 
2.50.1 (Apple Git-155)


