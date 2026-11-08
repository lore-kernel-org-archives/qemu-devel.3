Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314B2606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=s8xNFVNx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPzd8-00076Y-9o; Sun, 08 Nov 2026 04:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbS-0005TZ-40
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:23 -0500
Received: from st-2004k-snip6-11.eps.apple.com ([2a01:b747:3001:201::6f]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbQ-000614-71
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:21 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 3622F180019B; Sun, 08 Nov 2026 09:54:15 +0000 (UTC)
X-ICL-RepId: 01a1ba94-7d8c-7713-a847-902e06dc1b40
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQRNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQAFIClgDWwFeDkgLXARGA0EUFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794131659; x=1825667659;
 bh=xAHareLqRcQoibk/pUl7iu0EJCRWnVfvRebMKQQfl6Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=s8xNFVNx8NioFqCK1VdhkoZtXNrGdYk7/yFbpCW87jhSN0L/UhDsNigX6b/5/pYZxWuoEe8y2FI7TZCNZtWe6KE61omW4+lKQQEgPPYFmustt9XfxVSL5rzmudGTi6QonhXFFAkekhLbgLheFvyQfXxbmd5Fij+XBdHLufhayuVNEqsVokWkgujccYW4tjqQgf7ANBEGAyP5viNwI2r96fj23V3+K2+OeNHLT5muCx6Fqk7WhP9EgWBBZ8ciPIbr7eMaHIhZNipZzVXL/iKeSJcbejbLan6rn8pofC1a6ffamVseYPXODTJ5xeqgbq8hVdwYq25bkIWpQ74gcrTf9g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 7F90F18001BB; Sun, 08 Nov 2026 09:54:14 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Kostas Chatzikokolakis <kostas@chatzi.org>
Subject: [PULL 10/13] whpx: i386: forward the dynamic EBX of CPUID[0xD]
 sub-leaves 0 and 1, not 1 and 2
Date: Sun,  8 Nov 2026 02:54:00 -0700
Message-ID: <20261108095403.70813-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108095403.70813-1-mohamed@unpredictable.fr>
References: <20261108095403.70813-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=D8FK6/Rj c=1 sm=1 tr=0 ts=6af046c9
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DGLFwGUCAAAA:8 a=RSavJFEQRcchf7d-p6oA:9 a=4cWXuvdlNTBkoNYRywza:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzOSBTYWx0ZWRfX9s3+L3d3Ott2
 FIeCeJpMVasXqqZgNKvAEjzyQYZLO0MtlfiUKx/rI1XF7F8zxloZwz0yDGvrZTGLU68OS3zH/ZX
 8H7LrJBSLxI1yUkd88zpsdcquazES4yiuxamKRdXlmz+HvNMYDaM/BISz8jgRJMlsEskREe32/W
 AcqreTUU75oQQay/JiZIUgZje0rCioLIPcv4UEbVHK1iROO9ljNMFRSQ6eGfP/cr5nSv7Y5xpYE
 SvoycS9wiimZIAWcKz/ITGrUP9SGJ9JDRVOyFVOeOv4PVsHmG/YlUBvgRagGgRc/ANB1UnAgsSP
 QID8HlN6qSwtn1oR7uRw7pOoiKcQBEoVg2w6CF6EFlDuLI23bnJpdjXQ2fRXcA=
X-Proofpoint-GUID: -TbaS1l7kklSBk02Wb8qnPDL35A_Rd6y
X-Proofpoint-ORIG-GUID: -TbaS1l7kklSBk02Wb8qnPDL35A_Rd6y
X-JNJ: AAAAAAABUGeBxKkGp5Mu5WSUJ/dRtdk8p1JnwEz0r560MXKYQWm/XsMbtQ7McKB+72J1V6
 sX+58gtdUtylijR/4hX/wQgOv2GzSZkqwnj13zwoWPAoxNxVaWYb79XOuOHMUlC70B90IJ
 FZqGe7tIgTKHM5itit98TGfLDsEzJz0fT8Iy36BLz9HyeNMOSHJFo/veqEklDYUM6uMKEN
 tgtowh8IwxjplSC8UdPxPodiaa+yOpeEg/p7oF+/nHnMhd568ISxB1QzXIke5hl++JFETG
 FUOVQ0PGCFNvLTxDuc/vxOsLXCXzPmshfWBK1Ll2BctDAKscft8HzYmIG8ggUS5mFOMO0t
 t3TfXpgXDjAHhXUzM8/Nd6w/MCfHja54/RrrhlUdS7N8RHZOZOEPdwABzmYDnoJjLExYWh
 PiWYPmvx2zTGySrLTbJ/U0aoN+TkMOmkEqnShbJHikgZaaXnX+/ELwGlm+ap4mbPLv13Gk
 aBQqsU5VyI69em5gPRQn6J9c2t5e89LGoCIAoZnWJ/UHf6fwb4b1k+dgMDK/4xmDX/jvD9
 zE6eIWmUWi1ysEeetfY+C/DP2jdQzOvyyx5kE/ZjlLr9BQLjLVsqXlI/SI7HF68tcoRDw7
 BIr4pwv/wdBdbqCm284M/nMAckfj5u3QSK7IkET1sa/gZ9vhJo0ywj6t55rxG3E2kjTqpb
 r4+rXGiKkb3O2Cd4pDH1L6DCpQY5w2c1sbWK4a7lnzsKll3IMhyE4P58SR/KQMRw5hDMR3
 TILYrjWWrPYpNyTd1ktHJW++TT9bdMS6Q3iKKmALW6q9V2MtcvBRPAt9ftM2gSHhjmXS+U
 cmPW9MtFaFtLxL6vmVBFJOYBpzEl9EaCnrcmy5K59Q==
Received-SPF: pass client-ip=2a01:b747:3001:201::6f;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
index 12c6c3001e..1790b1c7b6 100644
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


