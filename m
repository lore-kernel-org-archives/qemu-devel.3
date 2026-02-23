Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32390E98E06
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRSS-0000TG-P0; Mon, 23 Feb 2026 03:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRS5-0000Eo-Ls
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:03 -0500
Received: from p-east2-cluster4-host5-snip4-5.eps.apple.com ([57.103.78.196]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRS3-0002Cy-JA
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:00 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 0C4451800202; Mon, 23 Feb 2026 08:37:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835878; x=1774427878;
 bh=g4l1jVkhlHtyjTxoP0r17Oazu+fhT089N6+xSJMvRqw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Hl/f0/TR2RyxwKDB+wN0gyGt0Sbwls/juEj5dqkOjCFb2qLtUHugbW7XQIC7Y1mGDC3gfvfygGotd4t2zRlWUW0FOWgDVjCoN7DO4wWgSt1wbDGUfah8O9rBKNVaY2edjd833fqyf6oCLpXSGWO38bV7Nr3QkIbCQsOwYOQ2N0lLgK7FSh4v99o9iQoNN5exsfaGYWRv1QFbbpWKNXI9zJkglPoQxrww9wo6no+l3gJ1dsWZVQFbtlFmYTELezDX+3EED/doHHNlNxxAAU++mrjKvpSADpueEmF9VcFkTweD1Ir0/wf0pNmmS2Rq874PQ9QCvXhz6GIITu/q3pfSEg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 F2A401800222; Mon, 23 Feb 2026 08:37:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 06/27] whpx: i386: re-enable guest debug support
Date: Mon, 23 Feb 2026 09:37:12 +0100
Message-ID: <20260223083734.48533-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jHSHs8El1oWdprxvUKHk3JIaz_2J926Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfX/nwYGnCMoAcx
 GEEvZbAKyxu1jFMzIXISq/oR8a93MGqzJGsj76/saBvmY0CYunD+EIMVzhQoBRpn9KHc0w0vVjJ
 9rYzxfCm1eXKGwMnu6BFOmjzW/cdN14MBQM1TrehBdYsoXpGTzpvVs9a7F+mrf/aGOuvcyzcKI1
 illPlymJIcXzNrnvg8bSxyvoNuwoWxYWGP9VrpCGmOjQh/wXTdnZ+GuotXaSgm3MCvkxh3YGIdu
 KyyWvZ1QuWVU8oxKYC7IWCiFsEvRUqG6j2gDTDY6+fbB3yHjtBtHxQrnWHaOUN36RY80C/NuFSU
 tNXixCD8XxEIYEr23gQ7o3fXZ6vzwmK8txf2g3MR6hCEPVfP8hsBhOys0hedRU=
X-Authority-Info-Out: v=2.4 cv=AN8t5o3d c=1 sm=1 tr=0 ts=699c11e4
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=VEyhEb3DslDlV8q9E0oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: jHSHs8El1oWdprxvUKHk3JIaz_2J926Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 clxscore=1030 malwarescore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAAB6VlcgSAo5tcBswhTkfVlMB36k8PKTJnUik6xwW0JakX2p8IVpH0BuqSSAmxOSme3C1Xvjy8hQgvrm1as41H6aegVMjJH7e3yC8UHU+TwGZbfSINX64ZS8NdDy0N55J9WPH2xlqzypj4yYMZKbDHPFgiihSxT40chp742kF6dridGgN94BHwz7/i/TFKWcYZ30wFu3XRwnfKoE3J1I6MPTd5GqG+0kHf8Y4qkXa6fKAjT32uTQM+6iUMdrsl8PrAS16a9Il0qTDV7Tp/skqVDvnTtfpe7l6e3cbeLazkVqtHSy6P5vQpbw/zTi21H7cfShibyWEHTWqdeWfPVfNZ339fHX8RNkfRvq54qq9day2V/F2OpB3mnq6h4imPW+SjiE3GNCUzt5o59jjLzm36dqNh2hYE4UVsAQVHYvdB0lfBX9e3roSKdWg91gnNlA7mR5n3xGhwx5q4nvl3ilkpef2feRWjklADdvx2XglqjfaKHhYWBQFpYnqvqnTzEhC5WMndZH8LERGEaN8Hlx8VcogiTtGUpcPgZw03utFwEQXJI+VKPh0BjWiYVPb3xGJTZuPQ7BSZAmrJPkBpCM8Acpl1QmsXi9Sxjpvcl1Yogfe174B6dgysw9q1f0G7+47T1mSDJHBmQEBvgzisB4xhSAGiEYk1PtPL6re/s5jYPnU1AweqGBEt9GMytkrvNKPJsuN6F4Gibzd0zsLpuYVcWtC0nwbQMMKj1g+lDMxYRlWmJjf4ctPiBHNqW5KG+cAOw48W6m3RhleFiXNX5YkyqKapeBjtSFqzstGq+wXK5hTWUuxXt96HMVJg=
Received-SPF: pass client-ip=57.103.78.196;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Fix what got broken several years ago by adding ops->supports_guest_debug
support as an architecture-specific function.

arm64 WHP doesn't currently provide support needed for this.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/whpx/whpx-accel-ops.c | 8 ++++++++
 include/system/whpx-all.h   | 4 ++++
 target/arm/whpx/whpx-all.c  | 5 +++++
 target/i386/whpx/whpx-all.c | 5 +++++
 4 files changed, 22 insertions(+)

diff --git a/accel/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
index 50fadea0fd..b8f41544cb 100644
--- a/accel/whpx/whpx-accel-ops.c
+++ b/accel/whpx/whpx-accel-ops.c
@@ -17,6 +17,7 @@
 
 #include "system/whpx.h"
 #include "system/whpx-internal.h"
+#include "system/whpx-all.h"
 #include "system/whpx-accel-ops.h"
 
 static void *whpx_cpu_thread_fn(void *arg)
@@ -81,6 +82,12 @@ static bool whpx_vcpu_thread_is_idle(CPUState *cpu)
     return !whpx_irqchip_in_kernel();
 }
 
+static bool whpx_supports_guest_debug(void)
+{
+    return whpx_arch_supports_guest_debug();
+}
+
+
 static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
@@ -89,6 +96,7 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->kick_vcpu_thread = whpx_kick_vcpu_thread;
     ops->cpu_thread_is_idle = whpx_vcpu_thread_is_idle;
     ops->handle_interrupt = generic_handle_interrupt;
+    ops->supports_guest_debug = whpx_supports_guest_debug;
 
     ops->synchronize_post_reset = whpx_cpu_synchronize_post_reset;
     ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index f13cdf7f66..3db074c38c 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -17,4 +17,8 @@ void whpx_translate_cpu_breakpoints(
     struct whpx_breakpoints *breakpoints,
     CPUState *cpu,
     int cpu_breakpoint_count);
+
+/* called by whpx-accel-ops */
+bool whpx_arch_supports_guest_debug(void);
+
 #endif
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 36c5e30a03..8d0ca794af 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -304,6 +304,11 @@ void whpx_translate_cpu_breakpoints(
     /* Breakpoints aren’t supported on this platform */
 }
 
+bool whpx_arch_supports_guest_debug(void) 
+{
+    return false;
+}
+
 static void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val)
 {
     struct whpx_state *whpx = &whpx_global;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8210250dc3..e1f0fa5e77 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1272,6 +1272,11 @@ void whpx_apply_breakpoints(
     }
 }
 
+bool whpx_arch_supports_guest_debug(void) 
+{
+    return true;
+}
+
 /* Returns the address of the next instruction that is about to be executed. */
 static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
 {
-- 
2.50.1 (Apple Git-155)


