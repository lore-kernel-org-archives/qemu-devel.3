Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEB8EEC2AB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXB-00069k-D5; Mon, 23 Feb 2026 18:40:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXA-00067z-40
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:12 -0500
Received: from qs-2002d-snip4-2.eps.apple.com ([57.103.87.163]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufX8-0004NI-B0
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:11 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 9E80C1800171; Mon, 23 Feb 2026 23:40:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890009; x=1774482009;
 bh=tOIg27vUU88mwrgezr591bqoq+9r1MOdy71woXavApE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=eu3m+JyDDi6DuHIYfKi4sGMDCSzXfnjI1uT4A1/hh4sgm/kf+hs5TSen+b9HjmhLTKjmQHeryTzWVAsfEwcVkmBdjhO96nbudUOwqg9UycmA3F95+kLssSJM6KaHgYY7yNjakJ/GnabznxnOrVkfYXve4CDV7uMoqkfoheUN3O3BIkNDlb6RunbfUtbiP9r2HaG/txj8GVoCkJLkvNX3vqT/GQGJMlz3kqd1ihCayyU5m7axDv07qY3RcBfjajuqEdZ7FbAxqMewuAzG1M+MQVwWR1PIFdh0XANHRHo1WMRCJJ+5S55p5hBYg8ows7DW5igHK8S65SeMUhWICoAbow==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 ECB851800169; Mon, 23 Feb 2026 23:40:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 05/28] target/i386: emulate,
 hvf: move x86_mmu to common code
Date: Tue, 24 Feb 2026 00:39:27 +0100
Message-ID: <20260223233950.96076-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=faWgCkQF c=1 sm=1 tr=0 ts=699ce557
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=NAek0MM3JjVz2OpMgrkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: _BGzbT0Wl_4R_QrEy-lgbWlfUJXJFKnS
X-Proofpoint-GUID: _BGzbT0Wl_4R_QrEy-lgbWlfUJXJFKnS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX1RGS0j2XseYy
 0Q0SN77SG90xLRlr9jtyK6CHi/QV6P3QhtvmI9g8wJB82RCNhyH3j26A0BazVLC0XNSuLF4f4O0
 yiBIX5pN0RrLY8+P9w63QDd1Z3Mj2EZCXEWkT2gs75jv6P+ezj1xcV/AsiXmE7VybNkiXMTIwY3
 jmGHco/uctpJVksKUPgm+t5XJH+OkxFshBTiYdWkNe5gTu65JrX62o5Du8+J+jKUuEy36XaiNrk
 Zzj1Gis1y0WNTQN8pNY4qZgJ2StJP69XUp+Vu/gUIaJKH33v8U8YgNEY0aF9qrBE/T1soXpVnHP
 tRX1kjjF19S/+Ne/LpGy3GCAu1jD7F2hs2sPHsCobvNky/Ullt/5SyNsmheV9M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 clxscore=1030 suspectscore=0 adultscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABJd4FAek51saWFBWjSgujLjFEbW3kit21/q8j6WYbabwTY/8/t2bJU8IUO3GrcpftvxSooZuLyBYRvJ4lqGF61hTuGQCh7ADIZcZcnNuqc/8Pu9vw0uiTgSjJqzXsN0fmKpC9hDHDB1yKZiXtiWzTHInpxGanzvlw5m6umE8yvsI4DuE+qaAy/gZSwZTI9I7q3ngVMRnmW9j+P8Btp0pPy7EJn2Ip4QdBtncOJaCJheJ9IMkXtjr0yDm9CY9dIM+fW4Qvn4yf1gACFKZBQve1kP+bVTJ6Bw7Y6+u0SORhx6w5B4od9g8Vdtih0vEycFaXAKpB3aifrTdZmvLFAI1s/mpEUr5QtWrY2Vy8CRwxNCidULzACnFQZcGwjrEjyTn41gEHzMHHw2CT+GCy8D7lEzB7AaJfCJn85OK7W8X1eqHxmKGFGld5UIF/fKvte4cU5fVdQ40iIOHAFOMosUP0MkdwEMCOJh1uD0nmFA9tloWNtjCDrXT0hzJdvSw2m6ChhAnUH4MDIClYQ5f8/msD3EPniq4/ACtmNiZeUJaFVbLW8SAPItYrKOGzQg/MjbUeEZKJSNTymy7xchcsh3rEYVng2Ga53JnqqhlQbhFxYyHCsWPanYO6o3LI0va2jt6w1A9Zen04EQ4IzBNA93gRTdFZYNOQaRtivlOcKcEm8fKy+hNZYERi+cUOQ6HGDy0lUcqXembg+4L4QnI5r74Bx7EPArxjacGe846uOPd2/6qELmQKzJaMPDIoq9fya7Q6PcdW9+Y41QQzrIYHcg==
Received-SPF: pass client-ip=57.103.87.163;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/emulate/meson.build        |  1 +
 target/i386/{hvf => emulate}/x86_mmu.c | 14 +++++++++-----
 target/i386/{hvf => emulate}/x86_mmu.h |  0
 target/i386/hvf/hvf.c                  | 10 +++++++++-
 target/i386/hvf/meson.build            |  1 -
 target/i386/hvf/x86.c                  |  2 +-
 target/i386/hvf/x86_task.c             |  2 +-
 7 files changed, 21 insertions(+), 9 deletions(-)
 rename target/i386/{hvf => emulate}/x86_mmu.c (95%)
 rename target/i386/{hvf => emulate}/x86_mmu.h (100%)

diff --git a/target/i386/emulate/meson.build b/target/i386/emulate/meson.build
index b6dafb6a5b..dd047c424a 100644
--- a/target/i386/emulate/meson.build
+++ b/target/i386/emulate/meson.build
@@ -2,6 +2,7 @@ emulator_files = files(
   'x86_decode.c',
   'x86_emu.c',
   'x86_flags.c',
+  'x86_mmu.c'
 )
 
 i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: emulator_files)
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/emulate/x86_mmu.c
similarity index 95%
rename from target/i386/hvf/x86_mmu.c
rename to target/i386/emulate/x86_mmu.c
index fe44d2edf4..b82a55a3da 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -19,10 +19,10 @@
 #include "qemu/osdep.h"
 #include "panic.h"
 #include "cpu.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
 #include "emulate/x86.h"
-#include "x86_mmu.h"
-#include "vmcs.h"
-#include "vmx.h"
+#include "emulate/x86_mmu.h"
 
 #define pte_present(pte) (pte & PT_PRESENT)
 #define pte_write_access(pte) (pte & PT_WRITE)
@@ -99,6 +99,8 @@ static bool get_pt_entry(CPUState *cpu, struct gpt_translation *pt,
 static bool test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
                           int level, int *largeness, bool pae)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
     uint64_t pte = pt->pte[level];
 
     if (pt->write_access) {
@@ -127,7 +129,7 @@ static bool test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
         pt->err_code |= MMU_PAGE_PT;
     }
 
-    uint32_t cr0 = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
+    uint32_t cr0 = env->cr[0];
     /* check protection */
     if (cr0 & CR0_WP_MASK) {
         if (pt->write_access && !pte_write_access(pte)) {
@@ -179,9 +181,11 @@ static inline uint64_t large_page_gpa(struct gpt_translation *pt, bool pae,
 static bool walk_gpt(CPUState *cpu, target_ulong addr, int err_code,
                      struct gpt_translation *pt, bool pae)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
     int top_level, level;
     int largeness = 0;
-    target_ulong cr3 = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
+    target_ulong cr3 = env->cr[3];
     uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
     
     memset(pt, 0, sizeof(*pt));
diff --git a/target/i386/hvf/x86_mmu.h b/target/i386/emulate/x86_mmu.h
similarity index 100%
rename from target/i386/hvf/x86_mmu.h
rename to target/i386/emulate/x86_mmu.h
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index ce54020f00..0b3674ad33 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -62,7 +62,7 @@
 #include "emulate/x86.h"
 #include "x86_descr.h"
 #include "emulate/x86_flags.h"
-#include "x86_mmu.h"
+#include "emulate/x86_mmu.h"
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
 #include "x86_task.h"
@@ -254,11 +254,19 @@ static void hvf_read_segment_descriptor(CPUState *s, struct x86_segment_descript
 
 static void hvf_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
+    env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
     vmx_read_mem(cpu, data, gva, bytes);
 }
 
 static void hvf_write_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
+    env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
     vmx_write_mem(cpu, gva, data, bytes);
 }
 
diff --git a/target/i386/hvf/meson.build b/target/i386/hvf/meson.build
index 519d190f0e..22bf886978 100644
--- a/target/i386/hvf/meson.build
+++ b/target/i386/hvf/meson.build
@@ -3,7 +3,6 @@ i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
   'x86.c',
   'x86_cpuid.c',
   'x86_descr.c',
-  'x86_mmu.c',
   'x86_task.c',
   'x86hvf.c',
   'hvf-cpu.c',
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index 5c75ec9a00..2fa210ff60 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -23,7 +23,7 @@
 #include "emulate/x86_emu.h"
 #include "vmcs.h"
 #include "vmx.h"
-#include "x86_mmu.h"
+#include "emulate/x86_mmu.h"
 #include "x86_descr.h"
 
 /* static uint32_t x86_segment_access_rights(struct x86_segment_descriptor *var)
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index bdf8b51ae6..b1e541a642 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -16,7 +16,7 @@
 #include "vmx.h"
 #include "emulate/x86.h"
 #include "x86_descr.h"
-#include "x86_mmu.h"
+#include "emulate/x86_mmu.h"
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
 #include "x86_task.h"
-- 
2.50.1 (Apple Git-155)


