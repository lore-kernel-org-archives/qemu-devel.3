Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFFDCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 18:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDRmV-0004rp-Hx; Mon, 27 Oct 2025 14:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRmD-0004ju-PU
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:17:07 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRly-0003xz-6e
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=3touB2AsZ+NL4kphMTOF47lHgSbcQCB+/KFDfK/oHRo=; b=E+NM2WZkc8RR88Z
 SMO/O9dbi8Si4rYL9WuY11s35qJpwJPGHTKDetQu+NShjT9vQDt27fCtIP/mX/DziuFR4C2MzVDdJ
 dpVlp2Ze7Asg9t9aUA6I7cOZugUKKztIUDVQAM5G8ZP1pfyjV7ER8ZcLWrvQYaSeIriSwH5A03K31
 Xg=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v4 03/33] target/riscv: Bugfix
 riscv_pmu_ctr_get_fixed_counters_val()
Date: Mon, 27 Oct 2025 19:18:00 +0100
Message-ID: <20251027181831.27016-4-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-1-anjo@rev.ng>
References: <20251027181831.27016-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From my understanding the upper_half argument only indicates whether the
upper or lower 32 bits should be returned, and upper_half will only ever
be set when MXLEN == 32.  However, the function also uses upper_half to
determine whether the inhibit flags are located in mcyclecfgh or
mcyclecfg, but this misses the case where MXLEN == 32, upper_half == false
for TARGET_RISCV32 where we would also need to read the upper half field.

Minor simplifications are also made along with some formatting fixes.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/riscv/csr.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5c91658c3d..657179a983 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -17,6 +17,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "cpu_bits.h"
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/timer.h"
@@ -1243,18 +1244,21 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
     int inst = riscv_pmu_ctr_monitor_instructions(env, counter_idx);
     uint64_t *counter_arr_virt = env->pmu_fixed_ctrs[inst].counter_virt;
     uint64_t *counter_arr = env->pmu_fixed_ctrs[inst].counter;
-    target_ulong result = 0;
     uint64_t curr_val = 0;
     uint64_t cfg_val = 0;
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+
+    /* Ensure upper_half is only set for MXL_RV32 */
+    g_assert(rv32 || !upper_half);
 
     if (counter_idx == 0) {
-        cfg_val = upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
+        cfg_val = rv32 ? ((uint64_t)env->mcyclecfgh << 32) :
                   env->mcyclecfg;
     } else if (counter_idx == 2) {
-        cfg_val = upper_half ? ((uint64_t)env->minstretcfgh << 32) :
+        cfg_val = rv32 ? ((uint64_t)env->minstretcfgh << 32) :
                   env->minstretcfg;
     } else {
-        cfg_val = upper_half ?
+        cfg_val = rv32 ?
                   ((uint64_t)env->mhpmeventh_val[counter_idx] << 32) :
                   env->mhpmevent_val[counter_idx];
         cfg_val &= MHPMEVENT_FILTER_MASK;
@@ -1262,7 +1266,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
 
     if (!cfg_val) {
         if (icount_enabled()) {
-                curr_val = inst ? icount_get_raw() : icount_get();
+            curr_val = inst ? icount_get_raw() : icount_get();
         } else {
             curr_val = cpu_get_host_ticks();
         }
@@ -1294,13 +1298,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
     }
 
 done:
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        result = upper_half ? curr_val >> 32 : curr_val;
-    } else {
-        result = curr_val;
-    }
-
-    return result;
+    return upper_half ? curr_val >> 32 : curr_val;
 }
 
 static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
-- 
2.51.0


