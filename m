Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B970D58CBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4nrR-0005yY-MX; Mon, 23 Mar 2026 18:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrP-0005xz-JZ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:34:59 -0400
Received: from qs-2001e-snip4-6.eps.apple.com ([57.103.87.49]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrO-0002w9-6m
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:34:59 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 7252A1800232; Mon, 23 Mar 2026 22:34:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774305297; x=1776897297;
 bh=NZnj8yCbumSadExeNcgwgqV2muxnORrhx0HseCqyro8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=E396Tm2mgykCbPOQiMJ9sjE+Ts16O2EtT9Do2tC12LGHaYqKzywgoc9BO3E5og9KrTXIGETtMGdSAsa76tieUBJkKtYvzqX3MjPgPbJOd76tBptcaNrSvK2UmdbRbfQQCcaW7Ywq4k+llm7wO8eZMBpEeMdQfr+02q+JX1wyErlMjuZm8Bpl1/C2HXTiXkwpPdxuHXKDvsdxeUGrfmrDoQkLfWR/bd6ZdhjbIzzIvH54XDPM9dK1QpkGwS3npx0RhGpulACTFWyzFpxohAXwnzfTH5M3HTyku+GdtGr8TJxWMinGdoPs0JRsW5C/outsSESTt/nr8ZLgQjPv9BfUhw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 4DFA81800138; Mon, 23 Mar 2026 22:34:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 06/13] target/i386: emulate: add new callbacks
Date: Mon, 23 Mar 2026 23:34:27 +0100
Message-ID: <20260323223434.81780-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323223434.81780-1-mohamed@unpredictable.fr>
References: <20260323223434.81780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2NyBTYWx0ZWRfX0IYDUM5FvIHf
 tZlvlilRcWcqUSDONYwNy29Aw9uLbDgbVA+bGze+4iR7V+7YZW2jCX6wIDqaKmQPR1ILhhMQrE+
 pNE7n7i/a1HBcf+LHXtAuWgSkDzdyWJVglxcLtzyJZD9it5HAxlJTHYrjH/W3lWNWQA9bUbMbVI
 2zL4fsqjc0NAmwjwIibKE+tRN7dG/BMKbukDh4XtV+Zley/0UaqTQMJ0DCsZeR1n+nCnw4Hrg+X
 YbpAhFaVBxvjWatCPqJZMKxKeVvNxCGiHGIFq8lUYqkDzQLZPBwiVsOzsmy3A547DbLkKcXQvzA
 4nJpqkMBb2HAUY/59xVSanHYBo/HsjsGYSdLZ3XeKSJ+8ZyS1kXwOL+TAgm4QY=
X-Proofpoint-GUID: _OY3AxAYWejgLHQpb3xUGKfgsdvmRKag
X-Proofpoint-ORIG-GUID: _OY3AxAYWejgLHQpb3xUGKfgsdvmRKag
X-Authority-Info-Out: v=2.4 cv=QuJTHFyd c=1 sm=1 tr=0 ts=69c1c00f
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AM0uniIKGEjy2BpxYl4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=854 phishscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230167
Received-SPF: pass client-ip=57.103.87.49;
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

On Hyper-V fetching some guest registers is really expensive, so
add a way to query some state from information provided by Hyper-V
to save time on vmexits.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_emu.h     | 3 +++
 target/i386/emulate/x86_helpers.c | 6 ++++++
 target/i386/emulate/x86_mmu.c     | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index 0f284b0c3d..4ed970bd53 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -32,6 +32,9 @@ struct x86_emul_ops {
                       int size, int count);
     void (*simulate_rdmsr)(CPUState *cs);
     void (*simulate_wrmsr)(CPUState *cs);
+    bool (*is_protected_mode)(CPUState *cpu);
+    bool (*is_long_mode)(CPUState *cpu);
+    bool (*is_user_mode)(CPUState *cpu);
 };
 
 extern const struct x86_emul_ops *emul_ops;
diff --git a/target/i386/emulate/x86_helpers.c b/target/i386/emulate/x86_helpers.c
index 024f9a2afc..ebbf40f2b0 100644
--- a/target/i386/emulate/x86_helpers.c
+++ b/target/i386/emulate/x86_helpers.c
@@ -211,6 +211,9 @@ bool x86_is_protected(CPUState *cpu)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
     uint64_t cr0 = env->cr[0];
+    if (emul_ops->is_protected_mode) {
+        return emul_ops->is_protected_mode(cpu);
+    }
 
     return cr0 & CR0_PE_MASK;
 }
@@ -234,6 +237,9 @@ bool x86_is_long_mode(CPUState *cpu)
     uint64_t efer = env->efer;
     uint64_t lme_lma = (MSR_EFER_LME | MSR_EFER_LMA);
 
+    if (emul_ops->is_long_mode) {
+        return emul_ops->is_long_mode(cpu);
+    }
     return ((efer & lme_lma) == lme_lma);
 }
 
diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 4e39bae025..670939acdb 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -49,6 +49,9 @@
 
 static bool is_user(CPUState *cpu)
 {
+    if (emul_ops->is_user_mode) {
+        return emul_ops->is_user_mode(cpu);
+    }
     return false;
 }
 
-- 
2.50.1 (Apple Git-155)


