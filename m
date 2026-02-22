Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BECC624DB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 18:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDnX-0008WL-7f; Sun, 22 Feb 2026 13:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnI-0008Oo-AP
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:01 -0500
Received: from qs-2007b-snip4-11.eps.apple.com ([57.103.84.151]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnG-0000Nk-NZ
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:00 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPS id
 F01C118004EC; Sun, 22 Feb 2026 18:02:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771783378; x=1774375378;
 bh=tOIg27vUU88mwrgezr591bqoq+9r1MOdy71woXavApE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=bfObfNgCEqC9Xe+brArtAjxz5b3iQcYW6RxHOX3ABNtOnXgf7vT6xFklxElQae/Lo93A6qYkdyMVedbJvClEkltRuI4PXUt/0He7RBnM+9IR6ErfEZ9TJEheWnkAD7H8qP/2qbVzKFX59k4dswSYW3wKx9oGghU+FVq1Jh2mt+kgd+Lem26VQ+UAp1gyRYnZsKGjdz6l2lk2Nic8VUKrN2ke2EoQXV3mKJr1ZVbyjGHXkSAaYHo65ka/JJ4UngclBIE0sRSo/B9/RpQ0A1ex3O2Z91uhuXqVhF/hMMNwzOHWiWKSbRA22He8/zjGupcac2Np2uiIf2Mj3Beut6oAow==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPSA id
 88E851800505; Sun, 22 Feb 2026 18:02:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v4 05/16] target/i386: emulate,
 hvf: move x86_mmu to common code
Date: Sun, 22 Feb 2026 19:02:29 +0100
Message-ID: <20260222180241.14621-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260222180241.14621-1-mohamed@unpredictable.fr>
References: <20260222180241.14621-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gQ3QLbjnw6TEEtSQitb16E9rHmHYAcdh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE3NCBTYWx0ZWRfXx64/mbqEeaK+
 OUbbP1OWKJcfb9ctKy2ZM8YoYjMRQBksHf71ac5j24DqOxLj6R8T+bVF1cJZysJcLXd+otxVV6n
 GusV7eUDqARNNSsSgxZ9q7d76Cf+Y17LXLXmQ9aRdWjUAVXQUeaTGxjwU86wKvws4TVhwRlJWHY
 7xywG3CmLMhvPbLz0SHgYsRL6ibFuRyH06laR9XHWyrqkes4xFiPn1pd2glkzbetGQk5GVRjMzJ
 jt0Zn5DzS/ZCPwXmQB927VAvoyQlruih+aDZAGEB5uVe9ZC0WWBKSCKs/b8bBR0lxNMT7CaXqJP
 B0QFsgvs5yI4Qeg2bLNV+ex4oh8psZUNHOlFKWNv3rTFOzeyfO7+6tFet3fkPA=
X-Authority-Info-Out: v=2.4 cv=ZJLaWH7b c=1 sm=1 tr=0 ts=699b44d1
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=NAek0MM3JjVz2OpMgrkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gQ3QLbjnw6TEEtSQitb16E9rHmHYAcdh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220174
X-JNJ: AAAAAAABuV/ay6cm1DB9Io1VJ1Z55uOLpy2uOnK73BYPa3l7qHl3sGQM4T8UIoWO6ImRlZOALFBd9rGvfRiFscUbSSJ3+D5BFBCPY6rsp5/KSMyks+r/CanBmM5oGc3+eediphEZ+CnHI6SISMvLH0MMsfECKuFbpPsUODQZkLiw+w4JmYhHsD6Uiw5vfAJZ18I29ISLfigBOsGDoRMDTmIq3XcD7hCLLd2S/PBi1ASJQg4SNkscsAmpuP96VsuXTwqQ+OVpe+4JuUiQZuVoHWUM3RK3DUYo+GNkRFfpb/6/Gf1+WVrO98R5uPmmFxXism0gRbVm6u9Gi4mPx8u2XQPpT//OrhvIJUpcKTqt+1HtnNdtm/x0z+WsLdPT7snSqEvgMpCXZF5uSzfMN6o0IvOy5j4n0vYo18IZw2ihaSFLYwaWGEuwCB1n+06K+BL4xHO03xNZSSd9o4hwONYjpaDznCCz6ee5WYhgj9A53RUtxEgZEm6AO/n4oHBWG3eIcc3z8xyxnjV2O/sgQrsY6wOXhCe77THJL3rXOyu2drewJqhQhSBSZDwCnpU4BtepmK3xe+G2g7ostC6XCXh7P218PDmG+QmLMJ9frMuQsoBGd3X5/BvAGebBXfsXAMD7tY86Bsk70dmzEWM4n8bmxkx0Ha84XxmgMTUaItdVrOqHKw7htXo/dS8nYu/V7vsCXPxicXrtANczJnX5EHKkqdpmGcmPqpvyAsSoRcJcyZi02bTQKIoI/eyOrG4kaC4ymHf4CQIRtTCdweUyffDWsdakucI+q4fn7jYw
Received-SPF: pass client-ip=57.103.84.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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


