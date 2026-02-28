Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8BAFD0045
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 21:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwS9l-0004E3-Vt; Sat, 28 Feb 2026 16:47:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9h-0004CL-UU
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:21 -0500
Received: from qs-2005i-snip4-1.eps.apple.com ([57.103.86.212]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9g-0002Uz-Fg
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:21 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 F057E1800121; Sat, 28 Feb 2026 21:47:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772315239; x=1774907239;
 bh=4EzOy0DXrkiXeDxM2SQ9H3In/PP3E7F6+7cZwEXazB4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Vxg4aoNxF5NZtvYw4DaVp7jENmw1fThEwRPpSAyjaeUMKxXilK/rAEnaKM/fD+50SmstIdrRQ0tGwhRMSdevOoZXobnZVXYflb7vsMAO3+CCga0P8P2jo9JWqGHlkE7nPfeHqa3vfQM/zZifLbFzdqVpAZlJIxKqxoj1V3zKIYefu7eXAStiyIxAI/cPoKYLSdhv9t/F+LElftSaqhWR2FWd6wPnIMgzQCbyfQjLxg+W/EIR3aAP+WXmm0Os2e0/7Rmmli51fXTFKkb9EBLl0Vp8o6Czktishr7V5ZyW5IQwhsJipvS5gV0u5h+tIWSbE1EilB1XRlHqa+nLJPDTfg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 15EB01800137; Sat, 28 Feb 2026 21:47:14 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 7/8] whpx: i386: expose HV_X64_MSR_APIC_FREQUENCY when
 kernel-irqchip=off
Date: Sat, 28 Feb 2026 22:47:03 +0100
Message-ID: <20260228214704.19048-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228214704.19048-1-mohamed@unpredictable.fr>
References: <20260228214704.19048-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o6aXEiRuo1U-OL8Pzv5B1FsHgs3p8Bu-
X-Authority-Info-Out: v=2.4 cv=YsgChoYX c=1 sm=1 tr=0 ts=69a36265
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=z5tRxpAhJOApE11VFHkA:9
X-Proofpoint-ORIG-GUID: o6aXEiRuo1U-OL8Pzv5B1FsHgs3p8Bu-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwMyBTYWx0ZWRfX0CN4YkcI7hkM
 RattVJsd+gdwyWenVJUTfoJsznY/HYSzjsJ2ZF2+1DUfSDukZMpooq6zrrJKxNYko7wtUtE+/mY
 kb4nSe5m73EOVwdxQJ/pQG0BJeeNFftyXa+sCKnbeJSDR9hXuxV44/78FbcKAZKuo1DWTh/CJru
 Zb1CQ9sH21FMFXFamnSLY6Z+QloN9XfhaLN0x9y7ae/VtdvdzCQyez6Pe1LzrK0625nDDgYQEe7
 XHyUn8kRoZkyuMmJVG9GSpHMiS9ZmMfF8K/7bnYcmT3J1SrQVXighLiZY/cAtSJ6nACRh2itSOu
 IbfSpYdo1XqSRfmr8v+KjecGek+keRqFk0hFnU6tgMk9y8fjWL3Tn0VwLc2b+M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 clxscore=1030 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280203
X-JNJ: AAAAAAABflfOo4sZR+OGFzjaDKziUOl+Tv4faDie1LDLOGjhTontsV73xIirfnVNYXKjFJ1oFCsNrXUrzWVxGtpW67FXmNbSLMXIBWr1fma+F5/vojP0+MSu/EYdNfBBbkMqCVZQPnzWtL5KRQ1HCM5Ub+i/nP0rfQiFG6HuzEe5c0O8GuWG7ZbkGB1ltEm/UhUYnpFTFPWjQMCExQ1msCtVX+U40zqJm9r9ibl/qQc5ulhbMJwyOhfBBxT7VWTcSg2Vds9sSRJJXgrAls+M7/GKOEPImsUw6uBDi3r+cLP96Rc1wdh5jIkizicooA7ATLbZGI/zlcaHX0Y1YrzZub6qha7TeD1XPESyxQlaPaqLpPYmB3SrJH9bPJA/g01JB/qUaDlMJjTcmHc9vBOBZtcFhsBx1Pc8GnIZWaHb4opIdlK6f5iE/wq0GT3GkaHjEJZft8kj+ZorJJAJBdmWjB3Thwx5TMGDlxuFQwVmmzgknVAovlwyH0D0IFRKwPU1BgyxY/E8uDGlIvXj7bEL3MAVmhwfiQql+SYeTRwTMmrxgvqZzE2oeC05yvOxI5ZAVOW79amVuLlRhBZWCnhiLbH/iSNCMqre1ps/DFbfcgQ/5tUX/GFUBa/9/dXf2aiWg3oS1uz14kuLZjrFOxz9T5XT/glvVgXNpXlq/7/vxPjhEtMFVVOMrU6asq4oEwPHQpVUB2CcFQ==
Received-SPF: pass client-ip=57.103.86.212;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
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

Now that we expose AccessFrequencyRegs, expose HV_X64_MSR_APIC_FREQUENCY as well for the case when the Hyper-V LAPIC is not used.

If the Hyper-V LAPIC is used, this will be handled by the hypervisor instead of the VMM, hence gating it on !whpx_irqchip_in_kernel().

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index da2ba36060..69a3c42ba0 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -45,6 +45,8 @@
 #include <winhvplatform.h>
 
 #define HYPERV_APIC_BUS_FREQUENCY      (200000000ULL)
+/* for kernel-irqchip=off */
+#define HV_X64_MSR_APIC_FREQUENCY       0x40000023
 
 static const WHV_REGISTER_NAME whpx_register_names[] = {
 
@@ -1787,6 +1789,7 @@ int whpx_vcpu_run(CPUState *cpu)
             WHV_REGISTER_VALUE reg_values[3] = {0};
             WHV_REGISTER_NAME reg_names[3];
             UINT32 reg_count;
+            bool is_known_msr = 0; 
 
             reg_names[0] = WHvX64RegisterRip;
             reg_names[1] = WHvX64RegisterRax;
@@ -1796,6 +1799,12 @@ int whpx_vcpu_run(CPUState *cpu)
                 vcpu->exit_ctx.VpContext.Rip +
                 vcpu->exit_ctx.VpContext.InstructionLength;
 
+            if (vcpu->exit_ctx.MsrAccess.MsrNumber == HV_X64_MSR_APIC_FREQUENCY
+                && !vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite
+                && !whpx_irqchip_in_kernel()) {
+                is_known_msr = 1;
+                reg_values[1].Reg32 = (uint32_t)X86_CPU(cpu)->env.apic_bus_freq;
+            }
             /*
              * For all unsupported MSR access we:
              *     ignore writes
@@ -1804,8 +1813,10 @@ int whpx_vcpu_run(CPUState *cpu)
             reg_count = vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite ?
                         1 : 3;
 
-            warn_report("WHPX: Unsupported MSR access (0x%x), IsWrite=%i", 
+            if (!is_known_msr) {
+                warn_report("WHPX: Unsupported MSR access (0x%x), IsWrite=%i", 
                 vcpu->exit_ctx.MsrAccess.MsrNumber, vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite);
+            }
 
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
                 whpx->partition,
@@ -1973,6 +1984,10 @@ int whpx_init_vcpu(CPUState *cpu)
         }
     }
 
+    /* When not using the Hyper-V APIC, the frequency is 1 GHz */
+    if (!whpx_irqchip_in_kernel()) {
+        env->apic_bus_freq = 1000000000;
+    }
 
     vcpu->interruptable = true;
     cpu->vcpu_dirty = true;
@@ -2186,7 +2201,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     synthetic_features.Bank0.Hv1 = 1;
     synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
-    /* if kernel-irqchip=off, HV_X64_MSR_APIC_FREQUENCY = 0. */
     synthetic_features.Bank0.AccessFrequencyRegs = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
-- 
2.50.1 (Apple Git-155)


