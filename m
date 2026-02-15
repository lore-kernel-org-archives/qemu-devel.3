Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0325EF586B
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 05:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrUbN-0000TK-DR; Sun, 15 Feb 2026 00:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUbG-0000RC-GO
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:23:19 -0500
Received: from p-west2-cluster1-host12-snip4-9.eps.apple.com ([57.103.68.42]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUbE-0004vC-T4
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:23:18 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 31DC118003A7; Sun, 15 Feb 2026 05:23:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771132995; x=1773724995;
 bh=O7pcpgfwM6ECBoMunj3RQ37ql2fZKOaaMfhrgMDZZG8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=V+H3EiIHq4ceFbiZlKzllaTMFafv9RxpgXbfuq7MXlbcpNkugft882HcYf3CbfH+XXX57z7Vy+D/DNRP+4P9YclPPzBs6zhEmSRbIBZemzD9N6ZryHJumNdiFJhoPlkoZwn7Kk5vYXmC7plMRXoiwMHKtZBbFYmjrX1MfkjOWTKaPcEApAccZ55nhR+9hR2pscQKFHKjBpEyE/a6xM48rnfjxIYr1CWDOV+PyD9Azq59ysvhjmDkEZw+/6aIHYVd3+a6OnY0Ne9A1uJAX6OSIEytJP20REWENsu3liYBhHVtvUcSZogOWHKeupsAjGiGA6frPXUFf7rzEGkwyHfaYA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 AF9C61800130; Sun, 15 Feb 2026 05:23:10 +0000 (UTC)
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
Subject: [PATCH v3 12/14] whpx: i386: remove CPUID trapping
Date: Sun, 15 Feb 2026 06:22:23 +0100
Message-ID: <20260215052225.22513-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215052225.22513-1-mohamed@unpredictable.fr>
References: <20260215052225.22513-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0yhWO3b1wymaNyFh3BYtVTMRrhoiHykv
X-Authority-Info-Out: v=2.4 cv=aKv9aL9m c=1 sm=1 tr=0 ts=69915843
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Gk9p9Fe9aJpBGj35TJ8A:9
X-Proofpoint-GUID: 0yhWO3b1wymaNyFh3BYtVTMRrhoiHykv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDAzNiBTYWx0ZWRfX8p7gwqrpbIkj
 1eIB2G5IoboIxDVCTYuo9twvVtqce/oLyqwKhQGapqrxzmi3M/TT9ArHq4jrRC1qTgIWHWIvc9t
 cDcOYHJ25qzx7Yu+oSFfEMsF6cbAuURTj8elGWTdFY3OuvDPRvJ/YmlFh8kDCprHc6/bX9AhMSY
 nJPVwwhA1TElRL0dW+HIQmDoasY974vnmeXT5jPDmhuH3cGURBsx9EPJ3NxbxV9Wooxl6W5XbGW
 vSOJZRc89Xv0MKvX9GIiQYm37jjy0ktc/LGTDOkwb4BSAfvYTrJNql14xkhavF9/xuTnMkJX+UM
 JyiS81BE+sWIsKqvPcsXLfVskrt0CCfl6vw2QQU7Zz+vgodIh5vMXRfNj99IUI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 clxscore=1030
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602150036
X-JNJ: AAAAAAABEyOedJHujD+k9CKdEUXNGA9xV8hhQUo29GgJvcl15sjUKPJbZgBegLGUC+gC8K3zZW0fTzeAcir5pmDR21boHPZsKbxF2OuT+MI8dsfo9JvbE2EjrldqFU1d1onznLrGw05MXI4ZjCkQubmD4TzHpMe3kluz8aAVI0Bep0ifb3LOkrhZSfA9zZ6x64mP1+kGQhg94o4+bmGhSchsbNL1zTkeEN8oRq3xx75fjTaxTk29iBb3xXgHaKd6qFA0sJcrzSy16OzLqMCguAwZjcvEICaX2Wj+6+uqobgNPMpnqAxDwNF1ikBNZLqb7zhSTuW83T1MuFSSAxIfxi6JBYtX3lN72QlWOb4XRh/y1zwluoJE8jVojxMaRP1Q+v3uDDWkoxSGqKn5uRdWJIHCcr2mXfmJdIhYmRWhO85wytbDX7cMpU2e8bNE2fpYf5hQ4cFsTDx21iIsW62GZGObCqf7cFoL29fp0jqg2Lns869Xtq9hv+NuOdirDzM3fL0eCjT3TB8nl0OYahq6uksQAY1zzT3mUG76+7tQwCInWjl6AAglHLfSMET68sKQaCxv+0/laRvuqi4PpZcZacRN6ggmiqJ4V1TDVFKZfLXjxAfdcIm51pzenuDtgPSdxWlW1ZOOW+eXRJx7Df1ATK71C22CugRdmmT4ta4W0wgM4yfVPhJUmokaL0S7LIw80YyEcEg0b8bTHmPcA5/FaJRFaIwS/YhhEBlwiqPP0GS8EgnEzvqOXuVVSaMtVSchL4WNeYQ/hL3PkcjV+3R7uv7AycjgFQWuivgcTagTS1putTlWuHSptIi50F7lktoM4jZXbv5V
Received-SPF: pass client-ip=57.103.68.42;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Very partial in its current state and results in significantly inconsistent
CPUID data. Remove it until it's reimplemented later.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 104 ------------------------------------
 1 file changed, 104 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e815ca9bfa..0e8fb0e72e 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1793,75 +1793,6 @@ int whpx_vcpu_run(CPUState *cpu)
             ret = 0;
             break;
         }
-        case WHvRunVpExitReasonX64Cpuid: {
-            WHV_REGISTER_VALUE reg_values[5];
-            WHV_REGISTER_NAME reg_names[5];
-            UINT32 reg_count = 5;
-            UINT64 cpuid_fn, rip = 0, rax = 0, rcx = 0, rdx = 0, rbx = 0;
-            X86CPU *x86_cpu = X86_CPU(cpu);
-            CPUX86State *env = &x86_cpu->env;
-
-            memset(reg_values, 0, sizeof(reg_values));
-
-            rip = vcpu->exit_ctx.VpContext.Rip +
-                  vcpu->exit_ctx.VpContext.InstructionLength;
-            cpuid_fn = vcpu->exit_ctx.CpuidAccess.Rax;
-
-            /*
-             * Ideally, these should be supplied to the hypervisor during VCPU
-             * initialization and it should be able to satisfy this request.
-             * But, currently, WHPX doesn't support setting CPUID values in the
-             * hypervisor once the partition has been setup, which is too late
-             * since VCPUs are realized later. For now, use the values from
-             * QEMU to satisfy these requests, until WHPX adds support for
-             * being able to set these values in the hypervisor at runtime.
-             */
-            cpu_x86_cpuid(env, cpuid_fn, 0, (UINT32 *)&rax, (UINT32 *)&rbx,
-                (UINT32 *)&rcx, (UINT32 *)&rdx);
-            switch (cpuid_fn) {
-            case 0x40000000:
-                /* Expose the vmware cpu frequency cpuid leaf */
-                rax = 0x40000010;
-                rbx = rcx = rdx = 0;
-                break;
-
-            case 0x40000010:
-                rax = env->tsc_khz;
-                rbx = env->apic_bus_freq / 1000; /* Hz to KHz */
-                rcx = rdx = 0;
-                break;
-
-            case 0x80000001:
-                /* Remove any support of OSVW */
-                rcx &= ~CPUID_EXT3_OSVW;
-                break;
-            }
-
-            reg_names[0] = WHvX64RegisterRip;
-            reg_names[1] = WHvX64RegisterRax;
-            reg_names[2] = WHvX64RegisterRcx;
-            reg_names[3] = WHvX64RegisterRdx;
-            reg_names[4] = WHvX64RegisterRbx;
-
-            reg_values[0].Reg64 = rip;
-            reg_values[1].Reg64 = rax;
-            reg_values[2].Reg64 = rcx;
-            reg_values[3].Reg64 = rdx;
-            reg_values[4].Reg64 = rbx;
-
-            hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
-                whpx->partition, cpu->cpu_index,
-                reg_names,
-                reg_count,
-                reg_values);
-
-            if (FAILED(hr)) {
-                error_report("WHPX: Failed to set CpuidAccess state registers,"
-                             " hr=%08lx", hr);
-            }
-            ret = 0;
-            break;
-        }
         case WHvRunVpExitReasonException:
             whpx_get_registers(cpu);
 
@@ -2015,26 +1946,6 @@ int whpx_init_vcpu(CPUState *cpu)
         }
     }
 
-    /*
-     * If the vmware cpuid frequency leaf option is set, and we have a valid
-     * tsc value, trap the corresponding cpuid's.
-     */
-    if (x86_cpu->vmware_cpuid_freq && env->tsc_khz) {
-        UINT32 cpuidExitList[] = {1, 0x80000001, 0x40000000, 0x40000010};
-
-        hr = whp_dispatch.WHvSetPartitionProperty(
-                whpx->partition,
-                WHvPartitionPropertyCodeCpuidExitList,
-                cpuidExitList,
-                RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
-
-        if (FAILED(hr)) {
-            error_report("WHPX: Failed to set partition CpuidExitList hr=%08lx",
-                        hr);
-            ret = -EINVAL;
-            goto error;
-        }
-    }
 
     vcpu->interruptable = true;
     cpu->vcpu_dirty = true;
@@ -2071,7 +1982,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_CAPABILITY whpx_cap;
     UINT32 whpx_cap_size;
     WHV_PARTITION_PROPERTY prop;
-    UINT32 cpuidExitList[] = {1, 0x80000001};
     WHV_CAPABILITY_FEATURES features = {0};
 
     whpx = &whpx_global;
@@ -2181,7 +2091,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     /* Register for MSR and CPUID exits */
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
-    prop.ExtendedVmExits.X64CpuidExit = 1;
     prop.ExtendedVmExits.ExceptionExit = 1;
     if (whpx_irqchip_in_kernel()) {
         prop.ExtendedVmExits.X64ApicInitSipiExitTrap = 1;
@@ -2198,19 +2107,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    hr = whp_dispatch.WHvSetPartitionProperty(
-        whpx->partition,
-        WHvPartitionPropertyCodeCpuidExitList,
-        cpuidExitList,
-        RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
-
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to set partition CpuidExitList hr=%08lx",
-                     hr);
-        ret = -EINVAL;
-        goto error;
-    }
-
     /*
      * We do not want to intercept any exceptions from the guest,
      * until we actually start debugging with gdb.
-- 
2.50.1 (Apple Git-155)


