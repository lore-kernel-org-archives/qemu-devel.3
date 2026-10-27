Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C60606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=VtOrzxQ7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLja4-0002Q8-50; Tue, 27 Oct 2026 11:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYx-0000zn-IQ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:13 -0400
Received: from ci-2002l-snip6-5.eps.apple.com ([2a01:b747:3005:206::76]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYo-0005nA-Q1
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:05 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 019C01801A4E; Tue, 27 Oct 2026 15:57:58 +0000 (UTC)
X-ICL-RepId: 01a17e15-2afb-7669-b40a-3d611e7f6f9d
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQAZYHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116681; x=1824652681;
 bh=/Bt7hZ0a2VCu4N7RYTzyil4HINn1w0nuTQWoluniCN0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VtOrzxQ7NbqKhvV7WPu12iOEcnHiui9K8H2IHAE7FGamCpAXDkXG0BjDiqJ7qWDZ/xfCKd/qgI9TRCiw8DLOw6Cygjg65Eg26h6Sc6NEyM30cM7xwM8k1s9kv8EjyMCLOzFlJODJeJR1TYZCdbizhiCM+rA+8RM0zMRCJ9BtQeGDP+1lI0/MTZ9DvxpnfL/uxM9GMokn9C0dMRALNcglatr+PhKyMJysYpGpdFu88GOHNClDvuNMvBX2Dq7xmRmztIc1WRHTzGLIpkzf1QGRKWtsYsqnOUpAwxgXRxhQCPUVeC97y5F3W5j8gqTfa84viNxRdlY0qmBD9He+hqNZsQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 310D218010BC; Tue, 27 Oct 2026 15:57:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Kostas Chatzikokolakis <kostas@chatzi.org>
Subject: [PATCH v2 12/18] whpx: i386: forward the dynamic EBX of CPUID[0xD]
 sub-leaves 0 and 1, not 1 and 2
Date: Tue, 27 Oct 2026 16:57:31 +0100
Message-ID: <20261027155737.59271-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=acRsXBot c=1 sm=1 tr=0 ts=6ae0ca07
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DGLFwGUCAAAA:8 a=RSavJFEQRcchf7d-p6oA:9 a=4cWXuvdlNTBkoNYRywza:22
X-Proofpoint-ORIG-GUID: ud3xGrBO3B83400zzdl9KzR2DBUHVnKH
X-Proofpoint-GUID: ud3xGrBO3B83400zzdl9KzR2DBUHVnKH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfXybd5LVseX9ju
 rvjlWSxe9TrtTemuDn6k10KToEoEz6DnO0H74NbnoEdvBliJNvymscYfyZ6F9oL5NE5tQVLtHS7
 CEBExt9trQvuPgBxSHjb5p2WJ88KFyu4467UsInPyykMnCpwKBs8j7UnOvY5SKxQmu0JId+Igmz
 4T4aK0RVgkCx/zjdvP6WYLEk6n0pY3A53KDW6tszw0tDTwD2wR5r+mZIyqKpkc+ofRfNACTTFi3
 ZYalur+BsEY8y2SU56rccIjVKWqp0hnkFw6kktjQKQbdA1CASHkDBM/vE5o9HAWQGcgMidDLFE+
 UKTWqtyrrpFa+TF+VMyeZddhqyg+mEt3AHOy68XpkcVJA4KECUZbQO0BsRN89M=
X-JNJ: AAAAAAAByC0uJ+ZrCULOu1IeC5phFyj2PmSysqofUyGLC23Jp77WGTdP/QQT8iKuKPiteuJUmRjzp5O/ZDwqBvDSgdXobBG7BwFoqtSV9YzctPiUij80/tzTC9faD+1YwFuGt6kKS9DJP0oFxSmr9gnLU3BrgZHUstIpe0vqL2B0Sw88/fShtNNXnRb+lT5dGCRKgX04EdftEqnjAafWvsR90UHN104vvaLcokXKmkvmMaRTwRxHDaFSmT2kc9wSntL+hixlG9f/2+p3BxGNy1OM6cJrQkyQ3hSJ2oCEPj2yuDpsU6Iov5MrJ/NhQm6p5rWW8kaB0AlKyyV2G/y8y7VLc+W242/kZhKiTffcJ4FpsLeI/OYyhZc+ifHFKyP3hgSmY90xn7RIB7JlGf5owkwig6QU28Mh3ar0Qaak5CIZXJn5YbunqaJQsR8cs600AA3kDm5Pt073QXcrRt3PBohKjUc/KgUHqh2SDO1+CsYaJzV+S4s9Yb7RWpSV6TX0xy21zf3yi3pNNJ1JesJMEMdTTZOKkPWXGn4pdjWtIwH0rZdomFWd5JySPaNXMd35ubm7DKyK08A0eVyIgHMv3WvmEUc9WcclBJgkIs8nDPm4CFJxRducT7pZ7nik1JbiAviSEWkcMqciGbWtSH2DgWvRSZczrGMnCN6IDCS8bEvKjManjI+QZX99Tzt2OjDIE9/b2ZsYowJoE5mO2vEtN0Rz+TrAsXLbtLLFZ/k7T31B09C7C+qf1y0QofSue/I07hU3m+/95P1w+Gdl9QenDlxhbk8ML87/SmjeAHvQWAZoZX52WeAejMaLh0TKl57yu2EUgqcVL2Wj6+MB1rr09zrUGWkkqjmf2Feei93eUcssVuVfYY+QDOg3
Received-SPF: pass client-ip=2a01:b747:3005:206::76;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Kostas Chatzikokolakis <kostas@chatzi.org>

CPUID[0xD,0].EBX is the size of the XSAVE area for the guest's current
XCR0, and CPUID[0xD,1].EBX the size for XCR0 | IA32_XSS: those are the
two values that depend on guest state. For sub-leaf 2 and up, EBX is the
component's offset in the standard format, a constant.

whpx_vcpu_run() forwards Hyper-V's DefaultResultRbx for sub-leaves 1 and
2 instead. Sub-leaf 2 is harmless: QEMU's own offset was read from
Hyper-V at vCPU init. Sub-leaf 0 is not: QEMU computes it from
env->xcr0, which WHPX refreshes only in whpx_get_registers(), never on
a CPUID exit, so after the guest's XSETBV the leaf still reports the
size for the reset XCR0, 576 bytes.

A Linux guest on a host without XSAVES takes that as its kernel XSAVE
size, fails the consistency check against the size it computed from the
component offsets, disables XSAVE and panics on the fallback path:

  XSAVE consistency problem: size 832 != kernel_size 576
  WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/xstate.c:638 fpu__init_system_xstate
  x86/fpu: XSAVE disabled
  BUG: kernel NULL pointer dereference, address: 0000000000000010
  RIP: 0010:fpstate_reset+0x1a/0x90
  Kernel panic - not syncing: Attempted to kill the idle task!

Every CPU model with XSAVE is affected there (-cpu max, Haswell,
SandyBridge); models without it (Westmere, Nehalem, qemu64) boot. A host
with XSAVES boots because Linux takes the compacted size from sub-leaf 1,
which is forwarded; sub-leaf 0 is stale there too.

Reproduced on an Intel Core i5-4440 (Haswell) under Windows 11 Home
build 26300 with QEMU 11.1.2 (the code is unchanged on master), guest
Linux 6.18. With this patch the guest enables xstate 0x7 at 832 bytes
and boots with -cpu max. An AMD Ryzen 9 7900X under build 26100, not
affected before, still boots with the patch, enabling 0xe7 (compacted,
2432 bytes).

Fixes: 79b3cb1f0145 ("whpx: i386: introduce proper cpuid support")
Signed-off-by: Kostas Chatzikokolakis <kostas@chatzi.org>

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4d4ad0919f..065cfacf3b 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2733,10 +2733,14 @@ int whpx_vcpu_run(CPUState *cpu)
                 }
             }
 
-            /* CPUID[0xD,{1,2}].EBX are dynamic depending on guest features. */
+            /*
+             * CPUID[0xD,{0,1}].EBX are dynamic: the XSAVE area size for the
+             * guest's current XCR0, resp. XCR0 | IA32_XSS. For sub-leaf >= 2,
+             * EBX is the component's fixed offset, which QEMU already reports.
+             */
             if (vcpu->exit_ctx.CpuidAccess.Rax == 0xd) {
-                if (vcpu->exit_ctx.CpuidAccess.Rcx == 1
-                    || vcpu->exit_ctx.CpuidAccess.Rcx == 2) {
+                if (vcpu->exit_ctx.CpuidAccess.Rcx == 0
+                    || vcpu->exit_ctx.CpuidAccess.Rcx == 1) {
                     reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
                 }
             }
-- 
2.54.0 (Apple Git-157)


