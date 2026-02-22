Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0998EC636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 18:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDnX-00005t-RO; Sun, 22 Feb 2026 13:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnS-0008Tj-1L
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:11 -0500
Received: from qs-2007g-snip4-8.eps.apple.com ([57.103.84.199]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnP-0000Rw-31
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:03:08 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPS id
 5654C18004D4; Sun, 22 Feb 2026 18:03:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771783386; x=1774375386;
 bh=Yw2iHtZGO16hdnJZFWAJ0heEY7g82L70ivWsP1jY3Mc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=LhWGOz2ug1WqUYGigucvC6ZjGrAY0IP7kqNjT4dgqisX81GZCjCVV9NxjgKlfrfF8tK9kceoxB81oBH307YFmWtg27Oh6kk2CgVv/uCSyTc2icaz4NYE956ZjPcrNHwMdun+8pqdzAFnIUj70kULnEfybW5R99SkPjygHuKX0Gq6UaPr9OPojxdQmfh4KsWsuii7sG7cBMH5GNzXq1J0Dv5pmfuQlW5t3lQUNb0g6hExQO4OhKkkqe/YQM4lM5nz0A/QJenIipXI4Fu5HSG5HpTovcZ9Jj2l4LwVZKsjUmXU2a3ChR5AiqHhYW5QzMHjeEBVbVmhIeTTYu038nBmbQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPSA id
 838061800508; Sun, 22 Feb 2026 18:02:59 +0000 (UTC)
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
Subject: [PATCH v4 08/16] whpx: refactor whpx_destroy_vcpu to arch-specific
 function
Date: Sun, 22 Feb 2026 19:02:32 +0100
Message-ID: <20260222180241.14621-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260222180241.14621-1-mohamed@unpredictable.fr>
References: <20260222180241.14621-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RJgT_wtmp5wjN70385Tvgz44fC-9ECaX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE3NCBTYWx0ZWRfXyU2jJ178zLvs
 7oTcdamSfdsfZhI1Lig6URp/Q4LD+4ZygB4Kzn5VNrl6UflzZORXXya2iHb9AgcmQP1TKP3ktQx
 z/nP8DK6ag6GJUYlgjly4M2tfj9e9OQvj4u5PusMJddUazg2Nfgp5HrNFW6zT6L3GNe2IRBOjDl
 OpyDEJowTnALzWa0SeMB9cDhl0YMOv01f8Eb1ilL51NLFjcmZsFrINSi8Jhi8766Ton2zags3Q+
 MkVPyXDB2xAU05+/j6zrPjZC58NaaxGEEBRdApp7nxHqEjQrylbKrGrqzIfo4tHGYgGVvU1iMS2
 nn53Z8twiVb73eVAosW5nMs/sI6KG+1LsZjONO9kDrxpFq0F4zHzpvEvfU8Lzw=
X-Authority-Info-Out: v=2.4 cv=AN8t5o3d c=1 sm=1 tr=0 ts=699b44d8
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=MnziPJL1nimGiMRD7rAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: RJgT_wtmp5wjN70385Tvgz44fC-9ECaX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 clxscore=1030 malwarescore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220174
X-JNJ: AAAAAAABjiFL0WdCnxL3ekKfRbE4q8HA6rGTFnk5XM8JKINHKyH8iYTUSb3Uhq+c5s4OOhF46AyakQo82/BaFKqNwc/lNNkt4JuNQanIvhmR+o3KbusFAGHDLYrIdvzjEbJaXJE8yTJqpFIAmHyDt1V95vG59I7PEFWqVb4BAlMaRoJc22M/zoVcXjJRSQzOECcDDZ46a+3OpGJUoPamjpgG3ACIr6XZ3/kIhMlg0AXNCn8GhPZwrEhPhauqEFFu1y9GEXpdMwcGtGk8ftCuWtAZ8KzmSmh1YIe9pDtTeb3n84ph8Vm6++VyolBh8ExzJwg1ci8G8X7xxpmf5fBLaPaTeJUvhumuvbtgYSjhrcczGtZW1yQvLuD+vmp0wfxc66In5i7l5GM/Cj+GwAEz31X25b3yjMWRUqvoqmiR7+PCsRafPzVs0q7wPDeRcfINwZwsYQTwOs9kT4qnOkAX5KQKWoD5j2u2z8R0fc2cSB0J74TICsLBBB2mcLG7KG99yboHCBXMG/2WoI4wUKHRpUC/rOMufBXVieeqHLAmdciBZlNuQl3Ke7bo597j1VMW8vjaCBPolwB2wVwQaZwFVMvBt8Nbb1JkftPd2xffFtYrtMYO6LXxHD6a+HeGwfidiUkB/dJGosJxRiDbxgLOBbNygy7id+kTrad4A+3nZ87N4lxXpxRDcoeZi1h0KFRtDJIkd5h2sDs9b76BlWYddUr9iNYN0UA/OYE2Q/OxSIfe/auBU71lhAafXTI0GPgrnggXVboDL/VuhCRmNccWd/4stiZv0oLYuPRbg7nrm/3o58CbqQ==
Received-SPF: pass client-ip=57.103.84.199;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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


