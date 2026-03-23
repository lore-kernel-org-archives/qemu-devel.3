Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BA9F483E7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4l5R-0005qg-NU; Mon, 23 Mar 2026 15:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5O-0005oW-4L
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:15 -0400
Received: from p-west3-cluster3-host10-snip4-7.eps.apple.com ([57.103.72.248]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4l5J-0004YE-Mk
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:37:12 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 2443F1800130; Mon, 23 Mar 2026 19:37:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774294626; x=1776886626;
 bh=smBsWnev5xk/yGxYEYZGOEvcw9uuZ3xnQx5lHO3QAy0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=O4VN1N9SkKlTG3GQNC4agsa39hKDxOQH2P/UhwkxE7/KcgY6/MiJg1/80q0j5k5Fva7P9oLsX268mZZ0NNBMwrKAHRO+fYo/clySS29AGA89MrDpphM7YtKtI24pvAdYcl+o3yhPSvTvXy1O9UjhyZKjP8o5drAX71Pgbewspvs87KwQeb9erUi6CJmRdEWg/bhW6OeCFf24YWwObL8VYZCwpE7UxAxEzdxzJWBDlhOuKw7xCkncI3EpZKtUgcMtYrYkk6p0AFaZm+pvD0upbezjRynmck0zXU2y/qB7lX2YTWOfOspxw3yTmGviEAUtOH6Zd05pNCfkmXPDDVhO3w==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 08A39180013A; Mon, 23 Mar 2026 19:37:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 08/12] target/i386: emulate: indirect access to CRs
Date: Mon, 23 Mar 2026 20:36:41 +0100
Message-ID: <20260323193645.82602-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323193645.82602-1-mohamed@unpredictable.fr>
References: <20260323193645.82602-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZCBhnlyDN-MaZm1K4pyDYkNJMKegtO0m
X-Authority-Info-Out: v=2.4 cv=fKA0HJae c=1 sm=1 tr=0 ts=69c19661
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ToLE8C9ZhuJGCwTcI3oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0NSBTYWx0ZWRfX+vZtCV/RrdYw
 hvLNA2scrTDP6kILpDJ63oQN4SSV+RWgro+yo+Ut7VGajwIBmEgh8ZDJjp9/maTmj3sKCCFVXaI
 TcAN4PzpN5VqWdU+nuyVtLJqItIfDWtAfmGe4TI/W1XEZxtOmESoVIHmC6AjNY++DDgKh5s6vyX
 oAsmm/KmVZZaqbBgFSQA9sG6H0QFn2Lm4fkq8esPZpo5hNe6P3jH9L3k+mV6vDqS78OJ5+/de5p
 Ri96rceepgDOMDy5EVdRonfSEidxTCPoI7qPlvGE6tC657fLLSduS3B3dSuq+3kaOT+ZQNVgZT0
 bFQTSOA90kEiesbyZruxceHi1x6M6w7IXZfDg/3zNTnMdlNFAO9pqwWb+7uYIc=
X-Proofpoint-GUID: ZCBhnlyDN-MaZm1K4pyDYkNJMKegtO0m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=822 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230145
Received-SPF: pass client-ip=57.103.72.248;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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

Prepare to have on-demand fetch of registers from the backend during
faults

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_emu.h     |  3 +++
 target/i386/emulate/x86_helpers.c | 28 ++++++++++++++++------------
 target/i386/emulate/x86_mmu.c     |  8 ++------
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index 4ed970bd53..a8d4c93098 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -28,6 +28,7 @@ struct x86_emul_ops {
     MMUTranslateResult (*mmu_gva_to_gpa) (CPUState *cpu, target_ulong gva, uint64_t *gpa, MMUTranslateFlags flags);
     void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
                                     enum X86Seg seg);
+    target_ulong (*read_cr) (CPUState *cpu, int cr);
     void (*handle_io)(CPUState *cpu, uint16_t port, void *data, int direction,
                       int size, int count);
     void (*simulate_rdmsr)(CPUState *cs);
@@ -45,6 +46,8 @@ void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_c
 
 target_ulong read_reg(CPUX86State *env, int reg, int size);
 void write_reg(CPUX86State *env, int reg, target_ulong val, int size);
+target_ulong x86_read_cr(CPUState *cpu, int cr);
+
 target_ulong read_val_from_reg(void *reg_ptr, int size);
 void write_val_to_reg(void *reg_ptr, target_ulong val, int size);
 bool write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size);
diff --git a/target/i386/emulate/x86_helpers.c b/target/i386/emulate/x86_helpers.c
index ebbf40f2b0..336862e2c4 100644
--- a/target/i386/emulate/x86_helpers.c
+++ b/target/i386/emulate/x86_helpers.c
@@ -206,15 +206,25 @@ bool x86_read_call_gate(CPUState *cpu, struct x86_call_gate *idt_desc,
     return true;
 }
 
-bool x86_is_protected(CPUState *cpu)
-{
+target_ulong x86_read_cr(CPUState *cpu, int cr) {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
-    uint64_t cr0 = env->cr[0];
+
+    if (emul_ops->read_cr) {
+        return emul_ops->read_cr(cpu, cr);
+    }
+    return env->cr[cr];
+}
+
+bool x86_is_protected(CPUState *cpu)
+{
+    uint64_t cr0;
+
     if (emul_ops->is_protected_mode) {
         return emul_ops->is_protected_mode(cpu);
     }
 
+    cr0 = x86_read_cr(cpu, 0);
     return cr0 & CR0_PE_MASK;
 }
 
@@ -245,9 +255,7 @@ bool x86_is_long_mode(CPUState *cpu)
 
 bool x86_is_la57(CPUState *cpu)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-    uint64_t is_la57 = env->cr[4] & CR4_LA57_MASK;
+    uint64_t is_la57 = x86_read_cr(cpu, 4) & CR4_LA57_MASK;
     return is_la57;
 }
 
@@ -259,18 +267,14 @@ bool x86_is_long64_mode(CPUState *cpu)
 
 bool x86_is_paging_mode(CPUState *cpu)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-    uint64_t cr0 = env->cr[0];
+    uint64_t cr0 = x86_read_cr(cpu, 0);
 
     return cr0 & CR0_PG_MASK;
 }
 
 bool x86_is_pae_enabled(CPUState *cpu)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-    uint64_t cr4 = env->cr[4];
+    uint64_t cr4 = x86_read_cr(cpu, 4);
 
     return cr4 & CR4_PAE_MASK;
 }
diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 670939acdb..ba0ebe4268 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -114,8 +114,6 @@ static bool get_pt_entry(CPUState *cpu, struct gpt_translation *pt,
 static MMUTranslateResult test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
                           int level, int *largeness, bool pae, MMUTranslateFlags flags)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
     uint64_t pte = pt->pte[level];
 
     if (!pte_present(pte)) {
@@ -130,7 +128,7 @@ static MMUTranslateResult test_pt_entry(CPUState *cpu, struct gpt_translation *p
         *largeness = level;
     }
 
-    uint32_t cr0 = env->cr[0];
+    uint32_t cr0 = x86_read_cr(cpu, 0);
     /* check protection */
     if (cr0 & CR0_WP_MASK) {
         if (mmu_validate_write(flags) && !pte_write_access(pte)) {
@@ -184,11 +182,9 @@ static inline uint64_t large_page_gpa(struct gpt_translation *pt, bool pae,
 static MMUTranslateResult walk_gpt(CPUState *cpu, target_ulong addr, MMUTranslateFlags flags,
                      struct gpt_translation *pt, bool pae)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
     int top_level, level;
     int largeness = 0;
-    target_ulong cr3 = env->cr[3];
+    target_ulong cr3 = x86_read_cr(cpu, 3);
     uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
     MMUTranslateResult res;
     
-- 
2.50.1 (Apple Git-155)


