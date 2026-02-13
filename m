Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AE5EF48C8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 03:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqk8I-0008FH-H7; Thu, 12 Feb 2026 22:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqk8G-0008ET-89
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:46:16 -0500
Received: from p-west1-cluster5-host6-snip4-10.eps.apple.com ([57.103.66.151]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqk8E-0005AL-FR
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:46:16 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPS id
 6AB5A1800104; Fri, 13 Feb 2026 03:46:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770954373; x=1773546373;
 bh=mOYNtTveKjr+KZigxP71eIiTh5kyqDuwACrDmj+VmsE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=JJEwWWSq3syIFgK4RBQlhXt+Dh73qUMuQwwF7DKU/w7CWAvXLKMZGJmGHbgQ5fku7ehyWtfvP0rc596Brg1zSivShkqA0b9dg0CkFKaDJL6KsZorbwp9ZTBnp0M2jgcLEf4z9W9McnhlIsKJugnKhufVuo+CxYUHR3aJuwgwUBnsXskkUmxpfPaShdb5w6WKWHk4F9pUZxf6SBsu0V/RVidt7h6tHeiz5tQ2dY8BEd/fC++Aqg/yxNdEfCot/fQPm7hBxqHk6QfUJ25gHoA4w3atzYIr4EGNYSiw50+2SgyQu+XzF9mGpKfFV+AkOmvSR0Txl1rQb0ImEiN+Pxo5KQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPSA id
 E49CB1800135; Fri, 13 Feb 2026 03:46:07 +0000 (UTC)
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
Subject: [PATCH v2 02/10] whpx: re-enable guest debug support on x86
Date: Fri, 13 Feb 2026 04:45:45 +0100
Message-ID: <20260213034556.13471-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260213034556.13471-1-mohamed@unpredictable.fr>
References: <20260213034556.13471-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7Bdch6XXe5ToAIUFipNn4Igp9tqsiPzX
X-Proofpoint-GUID: 7Bdch6XXe5ToAIUFipNn4Igp9tqsiPzX
X-Authority-Info-Out: v=2.4 cv=BtSQAIX5 c=1 sm=1 tr=0 ts=698e9e84
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=TBIg4pHv79D69QLdSdkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDAyNSBTYWx0ZWRfX7GynOkYCn4nP
 sddzfRnREd7/3oDZr5iyfNNcM1gQmTHsdnNVNO5NCa4UlufT5mifmSYl9xiTF9P6uYxnLcYxGwm
 etyWq0LGVn39ya57VrE9MiOL/Z+ZvMsoFYkNO/s6voGqeqjeq5VW1/bK9gOGhKBFRiG6wbkLPia
 xo0EgG1mfnT24y3NbFZOpF6O/Nmp+AIjwpU69iGC/uW6TcgIYm68A+6wEqDm9mPAoKlNwi8OXHM
 CMt5jH/tPdGwtHEKsoZAxD0ZUyjxXpZWsMghBg5pSPNPWgDE0HNAcrj0Xz80VeDiac5tsRYv6/o
 mWBo1zr7/YAzX3DC2klCdSSK0kgA2JuimvCnjlasgHM0JSe1uZkoNKpbQ97uys=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 clxscore=1030
 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130025
X-JNJ: AAAAAAAB6nTUR1xGXANIy01QQin19GDRyc/xZhL1XDkr1YdJn9EOeHeg16kNLA8k42hHtByUtGC58jvfMZlBsWS7YzO5YTqaH1NWI37eR4I6/9udijsTrx/3UfqLwlu0CmW6MD7+LTJsZNp2XGxLt4JQel8pwORES1g8wbwS31w7NI/yA9Onoeo91cXpQr2GyVCsmfsaAzQPY3N7og0/muhdYARnxvWsr72nnRipARzmixHLLbM5dlMOFiCoPxd2vDUvtNXiTQrkEM5Uo3gPVQQ5czM8Wb/vpxx6StQPXW6nVLH0NYF9l8tA4ihEccIdTXVlnyBM8MZ00RBr7BE2CkvGJ5teE9Wq+M+A+Ub9GUOWQH8KHEIMDbQ7eRUpUA8PvNBj6slpy8AxDldoH+P1MKeFgKOZLemJz7FaBnP3h5ESVsHmRHa/YrAibMYdWiVPnVqUWJ9RT4J7S8fYRANHAJHNMM+0fLvHoT1o5GZWFvHwGa6ZSoE5HsYNRcGF/RMcz9yjb1jqLS3gZQn6Agmqh6p8brhgPygDFZsLl0lPJovyd7Q9d/ckZd9jB2tW6vEFs3RVVQLwFk4TOeRWhSZGfwqQ79UES/lSSOseE8LpiAjT4K4l095uho4cjwi2i0ftQKKAlyZaXA+9ayjwxLJMWUD4qY4C0Jc9KOLJ4spD1rW+nvgkBgFRVK887en2OYt4YxToeWQ+uRR9ui9RyPmM0N1mZma7V/yjz+5L4JsuuPTlEpy3Ws2Cv9lnuw8cz3wb+4DVbMS9FQabxbWCCk02leZ9mXhggWMfu05dkdva/bJVtqJH6w==
Received-SPF: pass client-ip=57.103.66.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fix what got broken several years ago by adding ops->supports_guest_debug
support as an architecture-specific function.

arm64 WHP doesn't currently provide support needed for this.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
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


