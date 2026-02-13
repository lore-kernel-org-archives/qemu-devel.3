Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27CBEF48C6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 03:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqk8H-0008Eu-A1; Thu, 12 Feb 2026 22:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqk8F-0008E9-2p
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:46:15 -0500
Received: from p-west1-cluster5-host8-snip4-6.eps.apple.com ([57.103.66.247]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqk8D-0005A9-0h
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:46:14 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPS id
 E1D8718000BF; Fri, 13 Feb 2026 03:46:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770954369; x=1773546369;
 bh=pDdswD4Xub7IE+kNZc1mjsSEBI8ZIi+2CDn72stJol0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ILdscb1kM/tDeesmZbu2JvoMrZiS0o64WIk7RPh6HW0IjIKGRBvLCArBCjCMLrSF9tnrxOT6zxPyrYzrQtrLYNlHjuT0TEEj5XiYg2i69TBnQvFChDTf71/9u0kWkrgSr8eEJRnjcRnXNdtxeSNe+LkEa21cUHrsDvkmPg3ZEb4v2hoorl383xEjwJaBJqbd+aCT8n9ZdHWMUjoAq9f8IJE93LF3btCs9rK7YRJhpJXOigdqyMYuKohr11X57I1shXt/Zyu9XFxde0vYtYnS9Jr7ovZnqTS34Usyy9J5jrTeJGXhQeuPqKpLAFe7uaZ4xYujaRRyUAQk4I6EVk1MTw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPSA id
 60DA318000A3; Fri, 13 Feb 2026 03:46:04 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 01/10] target/i386: emulate,
 hvf: move x86_mmu to common code
Date: Fri, 13 Feb 2026 04:45:44 +0100
Message-ID: <20260213034556.13471-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260213034556.13471-1-mohamed@unpredictable.fr>
References: <20260213034556.13471-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WEGHwlj-INwMP_fB0eqnFiPfO-aklu6P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDAyNSBTYWx0ZWRfX0DJurA441ZAe
 sbIrYarwS0b0oJC+w7q4/AJ4XCfjRH8TbVpJ1AEbzHO5/tD1uxKc412C//ZoDGeCcAYefYi95XG
 q6aIoKyIX/6m1LsIgxOp82sGW2YWyz2DBmcbcz8N6+d8zO6BFNYKGmNLM8OAJii1i+VU1Gu4dYm
 3TFGkTir5Y3AeG3waRCfE+QsWW+fnnniTIAL3lJPmikfjn9egLoXupDad9OzFhvgPrCDCXkqteo
 v01vPXjDF/eX87NiJwmTYzG1e+zaEcx7unrSP3VIJntBr6TDNEX3hGe+EOIF5OR0e0s0q0Kk+tq
 ub0Zxi3URbTBFYKHM4w9OoSFyFoDovWJmz/bpVRS/kz5dscSkUZdqtleU2YN3o=
X-Authority-Info-Out: v=2.4 cv=Lv6fC3dc c=1 sm=1 tr=0 ts=698e9e80
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=j-fo9BjxNM0Z7X-A5OoA:9
X-Proofpoint-GUID: WEGHwlj-INwMP_fB0eqnFiPfO-aklu6P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1030 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130025
X-JNJ: AAAAAAABJf74yhZYx7mDBQ8nApoM607M0KqYPKSlsvqJIAw5XWIoxJCHy2R0r3Z9ZsN+c8XCZVBVicLO8QqbfBCsy4g9qhRSFZ4ESqVtiXKWCttzQtNV86hw1HKwkOkSHhWCdX2NXA2YC/shHbOAEZvmxl+vjaB71I83q+w9xXLwDUZA9qK+3XOudaGAqB9rt26EuPRnSiqU/O44mqeHwbWCp3bPNEQIYHEX0bOq6FqZoT0448VZ5YFyVTsgLbQpFdetixJEnbrrGCVCFHTtmIzX+qxLwfNcK5I0QFt92U/ihrOed7m6cVuos98iT2NJJgnoaZ5fxH+hi31oWlP54aj67vRSjWfTd1vKLPzb88j2L/NKzVtHrnihiG7FDp5WUfn6nMbBO8f5BycXBvGULUgZmnihfPBaiQo/4aGutVv0DwfHoJxTDCKLuMm0kGmfKzdzQRJ+YKfCgT+5cKYpTKObbtGgraG8Db/es0G9g5gFV+oEDGW5N1VHfxQ2BICaRUZgxWQI5xV/Gsw/y2muxEwnPC/WxYt4Zo0w81o/9T+WOydce79xH2YJ3K08uAGWnAdpa6ikv3M7QzARhJFWy0oEgCurPcx/57dnwo0nUXbZCzphH0ELOYNVzmySNcR0Q78E80i5FVmCaqXzaOG+zQ7pZri/AlrPtJTXMc7urwUslA9SCL/ZgVhJ013JCDylPDiRStt3IVfjgNi7WPUCjJqgvxJ+HPURLy/ICn/H4L9K8XR7B80G5JokECSnP9WnM5RgZXpPM9ayYG1iNcqguw==
Received-SPF: pass client-ip=57.103.66.247;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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
 target/i386/emulate/meson.build        |  1 +
 target/i386/{hvf => emulate}/x86_mmu.c | 14 +++++++++-----
 target/i386/{hvf => emulate}/x86_mmu.h |  0
 target/i386/hvf/hvf.c                  |  6 +++++-
 target/i386/hvf/meson.build            |  1 -
 target/i386/hvf/x86.c                  |  2 +-
 target/i386/hvf/x86_task.c             |  2 +-
 7 files changed, 17 insertions(+), 9 deletions(-)
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
index afc5c17d5d..7d069a172a 100644
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
index ce54020f00..9c5d85453d 100644
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
@@ -254,6 +254,10 @@ static void hvf_read_segment_descriptor(CPUState *s, struct x86_segment_descript
 
 static void hvf_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
+    env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
     vmx_read_mem(cpu, data, gva, bytes);
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


