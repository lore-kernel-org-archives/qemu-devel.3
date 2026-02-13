Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AA6EF48C6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 03:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqk8O-0008Gm-Vd; Thu, 12 Feb 2026 22:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqk8N-0008GC-0t
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:46:23 -0500
Received: from p-west1-cluster1-host2-snip4-6.eps.apple.com ([57.103.64.79]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqk8L-0005H5-J2
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:46:22 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPS id
 79B6F18002E5; Fri, 13 Feb 2026 03:46:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770954380; x=1773546380;
 bh=SzPbZCaUO3NDYpRGPHTDqVjE5jH4BjEtis7wSjOSTkA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=d78ypU2tMvmrkuxH7ZWJBS96kOcoJRhGsKNVyQV8+oCF4d6zZJzjGPkEsrwagkJQEUPpkYA4tJPY0ZX6IGXscmuOOH1wIgKxCOdQ1pSeByd86Ud1HVP+X69MKMgCaY67wzsuJgYPS3fXyXls6+9md6cs5AS1X0snL/6k8GdJZzKJT2z8YD9PVTsWPYPE6GTbVIsNNTgOsHoB6AYhOVMEjtWkieSPOrUuisd498n2lhyi91tYf/wYc7PZrG9B2bj+SxFrzC90o89hHYlg0dPBVuRZG2TZ3sYZywPjnH8+xyN5zDW7/oZ40J9gf8zRwhclvChC3Bc5c/J+e80Di6oMxg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPSA id
 0416318002DE; Fri, 13 Feb 2026 03:46:14 +0000 (UTC)
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
Subject: [PATCH v2 04/10] whpx: refactor whpx_destroy_vcpu to arch-specific
 function
Date: Fri, 13 Feb 2026 04:45:47 +0100
Message-ID: <20260213034556.13471-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260213034556.13471-1-mohamed@unpredictable.fr>
References: <20260213034556.13471-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=M9ZA6iws c=1 sm=1 tr=0 ts=698e9e8b
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=MnziPJL1nimGiMRD7rAA:9
X-Proofpoint-GUID: Oc3yBaCx--Pz9_rryhIw1UHXUZ7avlc7
X-Proofpoint-ORIG-GUID: Oc3yBaCx--Pz9_rryhIw1UHXUZ7avlc7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDAyNSBTYWx0ZWRfXzFQX6LzvvElc
 EnT9SU5XGGQjxDxoR6sERWHtIdZI1DTLFhY4FXWDf0Zz9NQQmAvF1mZqh+ZswmGUGfJmRJhVMLy
 rVo5gFwhnmoXUkcg9IkxznGjCVCY7SyOWx16h+fNAKIkhBf8oEoOIjR+afNowpyFcuFwllpScyf
 yL5MHn9JTtViBH5OIPJvT70eSjjqP7fDns13Sbq75aAjaA/0m4Wivp6FF6FJ/JmS6pXe+x104+R
 BOJtYnKLl4Ohc54kRcLVMMqWUFG3Nf0fk2DWANh+zjMaqwQdkWOBQRYOxECoy+Atby6JTQfOer+
 AYC3XwpZZa3VZa6LQSna+na3HVb0esXVXp2K+iKlsDcNJrrfie4qerWbk2EhEQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 mlxscore=0
 phishscore=0 suspectscore=0
 spamscore=0 clxscore=1030 bulkscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130025
X-JNJ: AAAAAAABsXb4p8zMp7cYHXyCcRsbgKtCvA664Nev4tN/D58+5lCE25ht26M/r4tNzxgeytYNjdDmxi08JwOD4hdD8RDJxDyD0721oE3HWmM8GmB35A4PF1Su0dIVG1BM4jYwuytX52R1LelLQM+6AkGhg6HBfUZ16omySiPTzFxSdoPQFTWUo1SvZ4AU/lb4AxdH6dEHJQ2qJ70JIJdxcVBvSm6H1UAmKg8fPd43lHkaDPqUxBZ5uM7cGKgWmUWWZ8ix+Za5uMp8exu8ATmrrvc/zEGPJS8tsQHcOvLa6JvrCXTooycax48lg16iPrtKHJ7GzBU1PUmdNzdNst9iaG7XF8c4dejpM+vx5wVbcG2MRzrpioSjLJPTv5UGneZgmBV+s+6s+GMWU6WGHSlsonUYt2iuDdNaCL4SAoXKnqCxsv6ncN6ig/YwDEKCI8cHK2DyHnH7P+qjs5kq7Z7JdlzDb9Bb7aPtTdHuwIZZy4gOF960TrJ65IWNBWKPiEyke2od5IZCiaLo6auZS8Jxv8o9XEACbOK0bki4EImK0lnQlEHmbnLEmnQg3vNy3BNvRJU/ugJewCvXJTt55x5bEQTa0bklsz942UoyQVH9tsF60DYP14T6V8Uj5hnGBb9vn0OFEv467T0WFXo1tmEKUS41MAV9l9fc5PBligpjfA7g8vI6veidaKBQ00lTgG0KxZ0/Xfx2BhXASWb4SRjlZLXvsm1kBEu1fikTjNp90T5I+xPDbgmbuvnmhGXxHjn1WaRv5pWGXJvSFrAONzykia+GvDWWvboxWfdUBjRj
Received-SPF: pass client-ip=57.103.64.79;
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

Avoid a TARGET_X86_64 define by moving platform-specific code
away from generic WHPX support.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
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


