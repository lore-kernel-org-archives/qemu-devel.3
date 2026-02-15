Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6566FEF586A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 05:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrUaw-0000MG-WB; Sun, 15 Feb 2026 00:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUar-0000Ji-Gp
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:22:53 -0500
Received: from p-west2-cluster2-host5-snip4-10.eps.apple.com ([57.103.68.233]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUaq-0004rx-1c
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:22:53 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 D2FA818006A4; Sun, 15 Feb 2026 05:22:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771132971; x=1773724971;
 bh=g4l1jVkhlHtyjTxoP0r17Oazu+fhT089N6+xSJMvRqw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=XAhNxkPveYSk0Fn3vUn6r+n8a3yELLak2Tuj8Kb5FCkFWdHV/i2ZmWnLCbXVFIVG0KxjRWaL936A2UD9MgIszDLPpXdd+kuTuvzqfGbid9VDzQlU01oK5wL3ZVVl1InS17PQDBDZdqRK35AAFu67HhFYGYXl/zIL0JRZ/OW3q/gtGTGZP6XqY6njqOPz2XaXUB4doxMEfKoTU0pucd1K8GKMGURrKV1Y9FaR1BB4uoI0fw/3SV+IjrUEcCvNd839uOKylv+pkcbhD/KDrNYQIFRMbGmDDYxGH/7q0ZctPl2VdOb29/kJB5z0r0GuEiVPEPyb2wif7GWoRTdNv5nFYg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 5B86A1800139; Sun, 15 Feb 2026 05:22:46 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 05/14] whpx: i386: re-enable guest debug support
Date: Sun, 15 Feb 2026 06:22:16 +0100
Message-ID: <20260215052225.22513-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215052225.22513-1-mohamed@unpredictable.fr>
References: <20260215052225.22513-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XiaA0KN2AdxkcZLlcoKsPDlDaWX24kWB
X-Proofpoint-ORIG-GUID: XiaA0KN2AdxkcZLlcoKsPDlDaWX24kWB
X-Authority-Info-Out: v=2.4 cv=bIEb4f+Z c=1 sm=1 tr=0 ts=6991582a
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=VEyhEb3DslDlV8q9E0oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDAzNiBTYWx0ZWRfXxVMNMWmAw4wL
 WNV0WwhtjBWrqg4o43rmsnuN1khRVRyDrADR4QZs7U1aUGdf3exkIqNxjriszRaa0nhljUFdVQr
 MVedGZSWlNv3yc9jnOUM3AnpWdbAsuGocSgMvan00do1trq+JBG/uNR038OJjmjG0KywcYpRZb+
 LU3rz8xYPkLB8p3Hk3RUUb8vTj67OAvHu7vOzRfcwt9lhVQxIRstwOzaW5cbnyYpEozactz+gLU
 UYe5MYutvCKSIPCZPI6FxKmduUv11RXiPaSkcEO/fr2ewqNJlr7lFxLBDQtqhMQaEjQKEZrUwWd
 DaqpX3j9hwYGXBWRgrPluXWYMGnCT5Y41OUJjz44jsc7FASKAOK+0W/qhO6gv4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 clxscore=1030 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150036
X-JNJ: AAAAAAAB2Q1SF7T/eYbl7XszjmMKONTONKbrkuRT+NP3EtdzSIB6E9GHz3cJOn7HxxKcrUUEzveq6cIhuM2t5ZUO2HAzuZMSJIMp9Vy3yKPIqrYmsLLZiR3+gDjHD8IHfOTxtSAzzCJPNH/4bnwL+i3caCgYnUmoksU837VgccTZ1EVNiXtAyec/xUM8MFyGy0TS6vUNbzDgspm35Dv9Jy8qWLaqkZekEnNDb1ltbKhpaExJR4eJOP6EE0mqLyJgwx7UziWm39BIk8sq2lKOKpGWNFf1rl8H9ldBDmAVuuPCwjP4YuyOqqd90uo4J4J0m7peYE7dKs9SbNQR0XeySJP9IKlqfEvM+sPr74I/Kb6UbOBVwblJSG09vEbgHTz/L0P8P5glqZobesNINx7FgYXxhTmhwTBLKE6djO64xNiknbOOWfofPM4lUhXhIVU6mLBCpHAZtZOSfZUzh/3ngPHWmFotVvWEWpYhGhNTQjzHRXQaR7frN4DFDYFccB13Cy4u3xGn54OSUHzahz3bINEEhR/Bk21YuPDzDI3F0OqYqhYqgpj1O9DHWqa54tdbkiK4EtFsduIm5g7vix50vVnZwoq1X7tlqIVG6ywbYX7HbC21oNwi6ECv3C5BW1pPHCO00GQnvigu2KTV2y/zR/JKjs2egTJHDbuYrhyNA6qHxrgLfKd+zeFQb0tBZM+ZlI2mIPyYvMoHfmB43HqtvLbmV5VRIoFXD9i0TfDLx5d9Oi/bKV8ELbjpPI66Tc4XfG+92mLAoAEJ2CSEmX4P8COcdAhzPDFkLQXAc1N6ougAnAZIXeMTls7Q77e2vsI=
Received-SPF: pass client-ip=57.103.68.233;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


