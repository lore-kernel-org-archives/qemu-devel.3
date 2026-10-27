Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A8606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=AUTn2bgR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjYv-0000xz-7f; Tue, 27 Oct 2026 11:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYh-0000uE-9s
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:57:59 -0400
Received: from ci-2002h-snip6-11.eps.apple.com ([2a01:b747:3005:206::53]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYY-0005k5-ED
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:57:49 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 A1E8018004B8; Tue, 27 Oct 2026 15:57:43 +0000 (UTC)
X-ICL-RepId: 01a17e14-ef1c-7721-810a-23734f03db44
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQAVGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116665; x=1824652665;
 bh=5lM3M/27cmxL429SQ6zeAkdGwYl8tz0wXYP78bVYgaU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AUTn2bgRFiG+u/XrmcNXgortbeFq8X0XzIT6Ef03+30LCVVW9DEWAoBbCmjLxRHcPpr5AOahqghmZ3Hd4Q6WopwhTbjH3oFMtalHnRZsJvYAsjsNzTGkOiHEh6YQ3Bv5rQs+57vzo433SMislheCn/yopjgFu0FK4fX7NsaYDqzI8z25PyIdXoz6qS6xG4O0QVLVQQF7HvdLAGwRmbdIYrd/q3numySUPB0FRIXxNafGi2ZI2Wh/2W7tVjZybv6ZW6aw4u4hNRz2tRnagbmnTO3XQH2Z9aO+lYCNbw/z0JUJd7ETx6seNhZokB/BGLwkBQvWwPy+l9gNzNVQJf4/5w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 BA7A61800126; Tue, 27 Oct 2026 15:57:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Doug Cook <dcook@microsoft.com>
Subject: [PATCH v2 01/18] target/i386/whpx: fix VMX capability MSR values
Date: Tue, 27 Oct 2026 16:57:20 +0100
Message-ID: <20261027155737.59271-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfX1wl1C239Le0g
 oZcfOM08xyV/zL/EyHGGdfoCxRj6Jbe4FWErP5/PTgcwhzjIme5gohiFtmOj/n6P419Vz1Wtgff
 Ihh0yphUOr0zbBkcZfx68Ymh6Q1j0g1muNlDONXulzCXEjuvNvyK0QwUWDIs/qsyTnBBi7mp7bd
 Kx/NdEqC7zrdR1nyP805jujSF6WYaF7cqF66GpOgniEdvIqWyhEI9HsBt+y0EBzWwdC4voWbEWp
 uMT8aQWlCxGCUHJPfoRQIi326RgcXa1eGDfJzFAZNDT1BWFN0+Z67ClrFB+RH0iwgsl8ns3/dqU
 BeX11dlxzdnZyL+QmO+7k3qPoqioGkGAJCIZItHcQIA+1BtvtH35jYIWhhoK2Y=
X-Authority-Info-Out: v=2.4 cv=L74QguT8 c=1 sm=1 tr=0 ts=6ae0c9f8
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=34rDk-nlojoYW5TMjDsA:9
X-Proofpoint-ORIG-GUID: KxsQUukQnCl1jKnMsTCYD68cPGkRnn3G
X-Proofpoint-GUID: KxsQUukQnCl1jKnMsTCYD68cPGkRnn3G
X-JNJ: AAAAAAABXklf954F+z/Q+PleBoOZ3VDwrq/L4kNSucVhTYNYE6k1RpTcRIC+9Pi8abQqY+jgWQMJxPJJxlOAl18xGtXDOICTjx8dDebkUi7yo7umH7eG2CImRIjYxH15dYp54cmLtj7KyX3tFo3a2g7HXxtun/1aTg2jy4WGiVuPr729CwEkdCS5Uop/lXe1DPZyHvLQnqOiKXVFVYXNkI4yPr1maB8EUfdDjyTodIYZiYnpEJQY28mMoaiTLCvQTchxkKewofGhiy6T5ie23Qbpu6jx0vZeyzhrUTxoBLHipbvphsHO5aAnygVKmRNcHlaW6PZE4hrvOsAb5S1iEzc7mNMAfptisqW/LY6wDv1rAGSehNPrEUY8h3N43QZufmBhHw9y+5cIuZtEE9Od8Rmmjr5M9l8LM2Jhn42v48f9rz2P0eDV2lPVf/hjnMcFDixAc6zUOCmS3Zben/tDLBx5gGDTWGxCbrEfuYTSQa4f6wx8B488O5a05Kwg5Xv1F/yH2FGzmInkt9UQQGn+Q28WDFTKC2SRBaA7FFG1DXOem3iv3XPY0dWROjUsWduDkSmh+vpwQsXt08b1CgYNMoJKm5TuVGcjeVZjA5BLDMC694CXIvJ4W6hTt8TiKT47Ec5xAImSo9h59vZB8FHcbvn80mg14xkNU60cly1imSmp8BjViWBYhUVzHDhizyp4y0uxd4sVwqsDkzXz26uulJ7PenyIONqqkSaZp7/0Wo87/sBKbFtZBqkc+Jl52KU1b9n+3w6Z7KWQgZ9vxWIP6t+7pslSuZDBbV/9KK6T+ConytkwMHw=
Received-SPF: pass client-ip=2a01:b747:3005:206::53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Doug Cook <dcook@microsoft.com>

whpx_get_supported_msr_feature() had two bugs in how it reports the
VMX control MSRs:

- MSR_IA32_VMX_TRUE_PINBASED_CTLS and MSR_IA32_VMX_TRUE_PROCBASED_CTLS
  were queried using the non-TRUE capability codes
  (WHvCapabilityCodeVmxPinbasedCtls and WHvCapabilityCodeVmxProcbasedCtls).

- For PROCBASED_CTLS2 and the four TRUE_* control MSRs, the raw
  allowed-0/allowed-1 pair was returned. The feature-word code expects
  only the bits that may be 1 but are not required to be 1. Apply the
  same transformation as kvm_arch_get_supported_msr_feature();
  make_vmx_msr_value() adds the must-be-one bits back afterwards.

As a result, with +vmx QEMU treated many VMX features the host does
support (secondary controls, EPT, VPID, MSR bitmaps, ...) as missing,
warned about each of them, and dropped them from the CPU model. The
guest itself reads the VMX MSRs from the hypervisor, not from QEMU,
so this did not change what the guest saw.

Signed-off-by: Doug Cook <dcook@microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 113f79afb9..1386affa9c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1452,10 +1452,10 @@ uint64_t whpx_get_supported_msr_feature(uint32_t index)
         cap = WHvCapabilityCodeVmxEptVpidCap;
         break;
     case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
-        cap = WHvCapabilityCodeVmxPinbasedCtls;
+        cap = WHvCapabilityCodeVmxTruePinbasedCtls;
         break;
     case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
-        cap = WHvCapabilityCodeVmxProcbasedCtls;
+        cap = WHvCapabilityCodeVmxTrueProcbasedCtls;
         break;
     case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
         cap = WHvCapabilityCodeVmxTrueEntryCtls;
@@ -1474,6 +1474,31 @@ uint64_t whpx_get_supported_msr_feature(uint32_t index)
         if (FAILED(hr)) {
             return 0;
         }
+
+        switch (index) {
+        case MSR_IA32_VMX_PROCBASED_CTLS2:
+        case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
+        case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
+        case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
+        case MSR_IA32_VMX_TRUE_EXIT_CTLS: {
+            /*
+             * These MSRs hold the allowed-0 settings in the low half and the
+             * allowed-1 settings in the high half.  QEMU's feature words want
+             * only the bits that can be one but do not have to be one, so
+             * apply the same transformation as
+             * kvm_arch_get_supported_msr_feature(); make_vmx_msr_value()
+             * restores the must-be-one bits later.
+             */
+            uint32_t must_be_one = (uint32_t)val;
+            uint32_t can_be_one = (uint32_t)(val >> 32);
+
+            val = can_be_one & ~must_be_one;
+            break;
+        }
+        default:
+            break;
+        }
+
         return val;
     }
     return 0;
-- 
2.54.0 (Apple Git-157)


