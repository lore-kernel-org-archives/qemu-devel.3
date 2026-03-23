Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0ACCF4613E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4nrU-0005zK-HO; Mon, 23 Mar 2026 18:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrS-0005ym-Te
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:35:02 -0400
Received: from qs-2001i-snip4-11.eps.apple.com ([57.103.87.93]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w4nrR-0002wM-7O
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:35:02 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 03E111800269; Mon, 23 Mar 2026 22:34:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774305300; x=1776897300;
 bh=RaeVoGsUxhg5XOvzFErCPDaCiYTNc+RShNyqxvJnm/M=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KknLw6UGJ/SvaiMjYhKHqmyaZ48Ue/etl5e2w3WrsyrWyfLwkt9FNEYc6S5zqgX6ca1QzvmRR0fEedxySRgfz72RdF7tfBbyhmtTyAt0rQBPBSqucaUikMqd1Wfwi5uwSZ0fbWhwsLdvfpcV4QUfP/yWHPiyEIZ0whWKmEZQsK3j7ZtfNOGi37W0i/6eLUNRDYWAazNPH4YAm8uCc0oyaY6z4Akj+qv4YS2jvGQmk4s4B6h7lpBwBLwrHWyxZwHBnTPMLQeWwSzZST8CBQo89qBieLSkKWMCGSzQyr5h/2y0rR8SwXDEtfWrQ/wSxbcP4MA6eVDJEMYuLRMko2otLg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 4C20A180025A; Mon, 23 Mar 2026 22:34:58 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 08/13] target/i386: emulate: indirect access to CRs
Date: Mon, 23 Mar 2026 23:34:29 +0100
Message-ID: <20260323223434.81780-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323223434.81780-1-mohamed@unpredictable.fr>
References: <20260323223434.81780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2NiBTYWx0ZWRfX4HB+q2jpSDBf
 Y7bFmFSr7t46cCK/DRdE5Q/dS24/dXu9C2TMdHeMBNB+rkn3xbj0AJT8nYUKOZjvEOWDHTC8JQE
 ITxvW/Y19rzE4HQuiqkTrJIhLWfL9ofU9YFf/OchMDxVXcb+YNumlrVCh0gGaxLfASQAXsbi5ZS
 tSEZd9xEQR6A0LwnS7OB0ZBQY5UorQfHoqCk9U/lqUeqpmeiNCxYm1WulMo9mr4+Y5gzjlm/H/W
 C1jBaMQRG5tc5B+/xitGEgyQMDVuqNZdxqhs6rYnwnUbI87jsi2l0nX8dq9oDoe4s/TGC8tCHJN
 40nwVLFlm5JMxaffUZh16+JJm3fGxv3ooRmCrCL1Q+K0u6CNzYW0LGXEwsyXrU=
X-Authority-Info-Out: v=2.4 cv=Vq8uwu2n c=1 sm=1 tr=0 ts=69c1c014
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_XbvW0LUL-N0uKGCadMA:9
X-Proofpoint-ORIG-GUID: LK-nUDvXO_zS87Cg8ANBBrnSIIhWjuKJ
X-Proofpoint-GUID: LK-nUDvXO_zS87Cg8ANBBrnSIIhWjuKJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=894
 spamscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1030 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603230166
Received-SPF: pass client-ip=57.103.87.93;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
faults.

For x86_64 macOS, copy the function there too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_emu.h     |  3 +++
 target/i386/emulate/x86_helpers.c | 27 ++++++++++++++++-----------
 target/i386/emulate/x86_mmu.c     |  8 ++------
 target/i386/hvf/x86.c             | 11 +++++++++++
 4 files changed, 32 insertions(+), 17 deletions(-)

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
index ebbf40f2b0..c817015ef9 100644
--- a/target/i386/emulate/x86_helpers.c
+++ b/target/i386/emulate/x86_helpers.c
@@ -206,15 +206,26 @@ bool x86_read_call_gate(CPUState *cpu, struct x86_call_gate *idt_desc,
     return true;
 }
 
-bool x86_is_protected(CPUState *cpu)
+target_ulong x86_read_cr(CPUState *cpu, int cr)
 {
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
 
@@ -245,9 +256,7 @@ bool x86_is_long_mode(CPUState *cpu)
 
 bool x86_is_la57(CPUState *cpu)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-    uint64_t is_la57 = env->cr[4] & CR4_LA57_MASK;
+    uint64_t is_la57 = x86_read_cr(cpu, 4) & CR4_LA57_MASK;
     return is_la57;
 }
 
@@ -259,18 +268,14 @@ bool x86_is_long64_mode(CPUState *cpu)
 
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
     
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index 7fe710aca3..bae2f30fa2 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -143,6 +143,17 @@ bool x86_is_la57(CPUState *cpu)
     return false;
 }
 
+target_ulong x86_read_cr(CPUState *cpu, int cr)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    if (emul_ops->read_cr) {
+        return emul_ops->read_cr(cpu, cr);
+    }
+    return env->cr[cr];
+}
+
 bool x86_is_long64_mode(CPUState *cpu)
 {
     struct vmx_segment desc;
-- 
2.50.1 (Apple Git-155)


