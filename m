Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C5DEF5859
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 05:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrUb1-0000Nl-5r; Sun, 15 Feb 2026 00:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUay-0000Mw-PD
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:23:00 -0500
Received: from p-west2-cluster2-host11-snip4-1.eps.apple.com ([57.103.68.204]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUax-0004sq-7f
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:23:00 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 0D0F218001A2; Sun, 15 Feb 2026 05:22:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771132978; x=1773724978;
 bh=Yw2iHtZGO16hdnJZFWAJ0heEY7g82L70ivWsP1jY3Mc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=cRcW6dlolpH69txuLgTqUP8AAmCKdZZm75evzNfe2EInIE89eDwm5Gh+nSXP+d6HkY8XtKSPdulU+QZp7GzvejO8+b6o/9GqAFEltvFP4trLALZrtunvQeOus8SaqU6FSvNtj8ZIEPTuvQBjgab1gaaMtM0PzlnVuFXJbZpPQ/hQrtRDqLJrvaA9WpuEVbvOK09zJFKTwU8CqLQa9hHZhh4be6C+nuK+Uqb2fCQBuFx/+3vmCYP5nHB4bfPTwko+1VA1RkoOEk00JvuvOZcdHtwlatxNzpJrVNS3nbtrnBmdpNhmJjfPQF6D0y22mjvmRswt9xUF7dNrFiLaybMAJA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 35BEE1800130; Sun, 15 Feb 2026 05:22:53 +0000 (UTC)
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
Subject: [PATCH v3 07/14] whpx: refactor whpx_destroy_vcpu to arch-specific
 function
Date: Sun, 15 Feb 2026 06:22:18 +0100
Message-ID: <20260215052225.22513-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215052225.22513-1-mohamed@unpredictable.fr>
References: <20260215052225.22513-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: N77mggXzJ-Ug3e7E5qTFfrGQXxFvqxMc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDAzNiBTYWx0ZWRfXyj4GaRS2iWCZ
 gfi0xXYu+w2roN31ksxH61oREYQOnamnDkp7S3M/tTx8kbCkkHdVYizMPjVNV8q+7AK8dSJBiLI
 mo9mwn0RbaLPY7G3KkOBxMjMDpIMIr6JqtGTOzaDcz2g/azIV/G2XUwf/cxx/4j0S7VZQyYhufl
 hS3O4edu1YEwthSgZPmR/RBm0houHMC5gftvQOrpEGFBurZ6VBPQQ1lCkLyq1jO3nXfbgjhxYlV
 TeD5q/XqRPbjKAxJop8cdKD4sp7gT8xHdCuM+MhcdbMfHJbyfHUksbL9/IZ1JizKAOikS3ESigv
 KPszZyQgTIdj0vSwgOUXpMhm9gwjqsTvAA3xihH1RUVqPlQqe4KAalpcdrgngQ=
X-Authority-Info-Out: v=2.4 cv=ZsPg6t7G c=1 sm=1 tr=0 ts=69915832
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=MnziPJL1nimGiMRD7rAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: N77mggXzJ-Ug3e7E5qTFfrGQXxFvqxMc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=998 bulkscore=0
 clxscore=1030 suspectscore=0 spamscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150036
X-JNJ: AAAAAAABI7/xSohBhjWwxQhpQoDya8Sa9rz7xzMy4GpHfxHvc8OHNuE8FS553kYzubgnIuI98zbuFiOG49yEQPaMcAuSD3P6opDqb1NNvQ2St5NdSVhdPDoNPO84RgzV3S/WTLbmvWuuTlLhpod+L9NZTSv0Yg3kyVHoJYK/2d/gIKWOU5WG0Bpv3IAdtZAeBW5C1AJpEXmr+gL7x9nEy0Nm6Fp7gl/jGJfTlBZoJTl51OvIhaRnaTTIKN/OB6u7r0NqPy2knz/TRPcHQHK5SunGLChozNvLjSrE5T6GIHj28y75IBCvofasRpZVhysCj6C+a3eH7EeoHY+nsYlct5LAh7gMgFa1h2MBn70dAD/oppSm8OtxHzKvI4qEPLohzCZD9FeioU2hhM6NhPxTKfGpFtKM8C9RjIUJDzRIfKpOIszcqI7cXUwTrHDwzXgk07FfOk+4+KsT57KVXCuhkMqR5xS/mzD5c+D9SPgCaaQx1w3yYukhrz/kQxu91T3TgPXGRUrc0ymLxbLxs8G4uMYWIW+/3P041gXhGd6txpGL8BIxkJiRJR/0wfUkAJ+GgsOkeVN+3Awu0Y9Bkhd25IAI1pmrAczXKJimJD7reNIPpmGCr7GEbFmHaokWnKS4Jd3ygW0oQySf2S30yeuygfMReOVPtVg5k14qn1xLp19qZvQM9uzJ36xFyQAhGv+S2gWYjBUdNzGRMQaDTckHGGi49U0t7cV5ZmXpZNMILzOuu1z8C+R2ht5gnQy4CbH8hwR5+94wNyoqz28JWm8AVQ/H6NaHhJNmqVNXvpxToxDr2uJh2+PuvjaRrA==
Received-SPF: pass client-ip=57.103.68.204;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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


