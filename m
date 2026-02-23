Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D847EEC2AB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXH-0006Qs-IH; Mon, 23 Feb 2026 18:40:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXF-0006Le-2J
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:17 -0500
Received: from qs-2002d-snip4-1.eps.apple.com ([57.103.87.162]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXD-0004OF-G0
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:16 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 6C21B180038E; Mon, 23 Feb 2026 23:40:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890014; x=1774482014;
 bh=Yw2iHtZGO16hdnJZFWAJ0heEY7g82L70ivWsP1jY3Mc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=VBro4QjQQ36QDhgvPjZRr5calixSSF70thVZCPqUqf1txvs+Rd4yKTu2OuUbFOlyDidO9diYR3jZwgGrRTfcry8fa9DwkihezpmmTtZSKdNOiQi9h41ENoYLFctF3HSkhj+HOZlN0h+lS24nEfYHqpvB+Lyb7oI7OsPWT0c9/gDoGTJE5bMzxrKMY5fJe/v5hYuLm3HMnXLN/+4vS7F6k/22/9IKyLHcerBALTCWuMP5ihgEX5DB0BRlPixeDwQKw2+OBEsfya7MoGtJB8aP8pW7o3t+d587BvPcd3iNDKN0A3fiXrBh3i+LgRZwkswwrLWwRScfIzth5r9Mo5JKxg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 C13301800395; Mon, 23 Feb 2026 23:40:08 +0000 (UTC)
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
Subject: [PATCH v6 08/28] whpx: refactor whpx_destroy_vcpu to arch-specific
 function
Date: Tue, 24 Feb 2026 00:39:30 +0100
Message-ID: <20260223233950.96076-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=POQCOPqC c=1 sm=1 tr=0 ts=699ce55d
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=MnziPJL1nimGiMRD7rAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: suHMEIofTdU9-cNNiWqKWc54xBJSxzUv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfXzZ4UMacgDD9F
 PfbPr3PNMltnffyEDbPTBXPwsCDL2LKzKD/fpDO3I8re7nS4yCQ7i+VbuGrcqVd8Gc0nks4PylI
 xTr0gcUzQN3+FQJr8yWlHX90HFoCfjHRUQ6OSoOKFoVxsJbunOcV99/aES+87nRduyCNY7vJ0AV
 y0re93X5p3XOPzgI6P/W8D+MSt5bKl/9h7PymU7ndZvsUqitebQ6ZkJMrm5531oqU4dAZzsJ1oq
 vViYmYPFvwSnCUhHV0HKbwOx4CQyhziji243/F81IpYUMj5TeqCLgcaDl1UurK/5RtznWoRsloI
 OuHk3IXHvgXf5zCQjWspjB9xgo/BSei7kY35+w0NflqFonaxw9Du/kSBR5LRG8=
X-Proofpoint-GUID: suHMEIofTdU9-cNNiWqKWc54xBJSxzUv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1030 mlxscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABNrbJrszwjQJCIgN3dxSHR5D6dSat5pKBK612lwyMHnLVzzfCutvip6bB6JgfUT26tTEgqkhVsj7sJeSP9R8O9XNSvswkYv3x/GbSLCi4DYZP42HQcp9B/TNW7OtSxdyj+7k6w1ZCUxSdjrYBomf7AYsZ2ZQiXh6HKZD9AFgQRhFL8tC7qvejngpUmzxF6ySUdkqpV5xBh+JHvGXcaX4kP8Pz5eFrh+ZEgeS/whRzkFeMFskx8ZjfHKd8K/gJmVfh9B/pvbkNqyq+lBHFGuBsbafe5HgwTo/uFM7D3iJ1NINbOjjOc/WJb8Yp9m1jINQr/DEMJ6WQOT4MXDa0xXfbrs9+IFEbtgsKQzy8PirIZ2bII23ZPQWjov9y5y8oO8TK4k6u7NoNfTJGZPam2KdLIqFgQAa1/Qw6W+iOgWI5efGBdXyUrefT9EKc/K+rsWTG9jwFeiY0X7B8EaOsa+MR+DI/5bLFfOsh5cu62izATyZzfyN7wHzjKPVKtRfQEqz5gI+pcKghFz5xMSZwV4nhn5KzWQQNsmfXafG35pyY0sQg3sFDntqmTqnFCgL45N/VWqjddRfoQM6lvcWCnbzO5nyRUxO3JelpfoRtswbZDlFrA/IwTFv0Z1g98CtDuqTTUrtIub6/Q1QnOztoejTBtreNMqhz+rQWgQdcxgtNSGlq+y6yWL8RL/B1GKsquJwIx73Vvn/kgp1XmnSYn/gCGRIj40at8e2yur4BXzYRNXAe/XcqtpeSrNrp4yQPBLqGIaFZ1rEblFmH0WNNsO1eL/T5IEz/QQ==
Received-SPF: pass client-ip=57.103.87.162;
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

Avoid a TARGET_X86_64 define by moving platform-specific code
away from generic WHPX support.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/whpx/whpx-common.c    | 5 +----
 include/system/whpx-all.h   | 1 +
 target/arm/whpx/whpx-all.c  | 5 +++++
 target/i386/whpx/whpx-all.c | 6 ++++++
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index f018a8f5c7..c57a0d3f0f 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -236,10 +236,7 @@ void whpx_destroy_vcpu(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
 
     whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
-#ifdef HOST_X86_64
-    AccelCPUState *vcpu = cpu->accel;
-    whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
-#endif
+    whpx_arch_destroy_vcpu(cpu);
     g_free(cpu->accel);
 }
 
diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index 3db074c38c..b831c463b0 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -17,6 +17,7 @@ void whpx_translate_cpu_breakpoints(
     struct whpx_breakpoints *breakpoints,
     CPUState *cpu,
     int cpu_breakpoint_count);
+void whpx_arch_destroy_vcpu(CPUState *cpu);
 
 /* called by whpx-accel-ops */
 bool whpx_arch_supports_guest_debug(void);
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 8d0ca794af..d52580a082 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -309,6 +309,11 @@ bool whpx_arch_supports_guest_debug(void)
     return false;
 }
 
+void whpx_arch_destroy_vcpu(CPUState *cpu)
+{
+    /* currently empty on Arm */
+}
+
 static void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val)
 {
     struct whpx_state *whpx = &whpx_global;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e1f0fa5e77..cdcaebbe16 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1277,6 +1277,12 @@ bool whpx_arch_supports_guest_debug(void)
     return true;
 }
 
+void whpx_arch_destroy_vcpu(CPUState *cpu)
+{
+    AccelCPUState *vcpu = cpu->accel;
+    whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
+}
+
 /* Returns the address of the next instruction that is about to be executed. */
 static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
 {
-- 
2.50.1 (Apple Git-155)


