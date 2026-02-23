Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C44EEC2AB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXR-0006uH-2P; Mon, 23 Feb 2026 18:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXP-0006sX-88
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:27 -0500
Received: from qs-2002d-snip4-1.eps.apple.com ([57.103.87.162]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXM-0004Pd-Ah
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:26 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 7C63E18003AF; Mon, 23 Feb 2026 23:40:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890023; x=1774482023;
 bh=op64aUwd3kHeSL+XTt7uxWfJ6n/JYbXZSlN/Ec+uOgk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Py80wF9lv9we2yFYzggr1T5vKIy0WZxh1WZOzmB4UFKvlKwlQBBSCKVR59gUCQi+ossbX2j/9FpjQa2vet8y+oG5KCGJTjMax8fyNyPXHjdV6uBuY1paQqpuCJo8CDU3khsi31iJl+AUBFbuuD7eYNQeRsxAXGKqakIWyKO96ikQec3HfZbOHuaCjTkbAR70qrcnly29Tpi40Uwg9cjgFAkDsonoLyq9tt78VNskR64olvO90Z+WM2aHWfSFHsBp86Zca6+BHKejxF9Gd53cEUYVjFXGHZ9UvWBv3rYdUWuezXO6F/bmwuqrojgNhEQ5runXw2F/tBkbgBlgJjZmKA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 7C74618003B5; Mon, 23 Feb 2026 23:40:20 +0000 (UTC)
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
Subject: [PATCH v6 14/28] whpx: i386: remove CPUID trapping
Date: Tue, 24 Feb 2026 00:39:36 +0100
Message-ID: <20260223233950.96076-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=MvxfKmae c=1 sm=1 tr=0 ts=699ce566
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Gk9p9Fe9aJpBGj35TJ8A:9
X-Proofpoint-ORIG-GUID: tT-_xX84vP4_F9XOoBvPZ5coTHQKJHbE
X-Proofpoint-GUID: tT-_xX84vP4_F9XOoBvPZ5coTHQKJHbE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX8TllSzLAVdkW
 jjCTdHL89a70gw4t1eqdc3K7+ZVX7aMARR3OT5iV9/+/s8HXA6wdvMKLrzlzswu3m9a76MVvn2T
 FAcqmRR/DaZ34adSH/VIrUE2S425Eaacpj39cTeVwnuImUlpwVUsPV3zajMjJ6ZEwBj5LAgwKjw
 75VYQruII2DwiVLyvALHHF69ux+bzQ7rqGNvHOsDRL651D9PSHvss7nf7shZ2j6gUOwOUqr1Ux0
 eqx6W53ZiHQJ3W/zZs9UWo9tEDBeyReI3tbWeoKQEln7b9Abpi5kUMzFSlh9EjEo9MV2zULFmWG
 RXAninelg236rzHYbDwoFWUaDeLoIVKaKRQf2FZSavE07E0rMmXK4BIDBtzaNo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1030 phishscore=0 malwarescore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABGvinVmvP9FEW6x0ZHISKU6UIcm+nNCMLHgYt0RGekh0PY2AuY+f51rlduD8DGXeKU6onrOgdcyyYPAdBgei6U660dwS9xWg0kDaP77ChyTMRU8Qc6zDsvikmi6y3BIa2h5pvhfGuBmgIeLVmLkgu/EBKsa8JrHkmAnsuZLApkEPmfLlX6Mc0CWMTCImXeo12d/qswyR4mQoVEXA6xWOm09xbIxKvOygtMgswvgnKyH4mfJOyzJ6P9IcAzyqY71VZVwAZiOpj0TnzgUp4dxvNYYEhEso59JKnfubq2LsjR3847sKzzVLNNj1rsBce1XZvnCvKmw5v/Y3/ZGxUj++rCkThWc5zn6vJZ3cniHowLcSYq9zNb8fIg/TcQIRz5pIyCMzGA9Jo4eYMq5ADQo+0yEF4BSLKJy46U86yZAOKnSYa1OWMSFu3SvFC+V8vmbhRUQmZJTB1SBJfef0PBT/PQ0tORmw5iAu9OOWUUGx51JZs6ZOhUb+Rn0AUAJuLfTyMug/emuqvzI/xRi9T6t5BlLeBp0qpWlO76NtvKPyL+hMXpmXuUtcisKcLXpWAg1nKs3Md6AOdgq7gh3Ph9KWZPc7jZWdzamunGOcbTi/GmPA7HUysjS/JDpNSjSb2JRN7SH1/PHq+bzTdB3fIcqbBlq63ZeSIGgLhowLa0WtINBpYU9IcT3dKwbtnonFMl0mT04Xa4GgBzUIxotLvYxDu1prEqXYYg8O8+yhxE8HDfQh5aTsVek2W6g4+4/ZlHQ056QWHeGU4I8sho7rZsO5SX6hZDJQEaBEKjqIMJe0Yz7Cnow==
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

Very partial in its current state and results in significantly inconsistent
CPUID data. Remove it until it's reimplemented later.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 104 ------------------------------------
 1 file changed, 104 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2f2c613eda..baa3169c55 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1795,75 +1795,6 @@ int whpx_vcpu_run(CPUState *cpu)
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
 
@@ -2017,26 +1948,6 @@ int whpx_init_vcpu(CPUState *cpu)
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
@@ -2073,7 +1984,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_CAPABILITY whpx_cap;
     UINT32 whpx_cap_size;
     WHV_PARTITION_PROPERTY prop;
-    UINT32 cpuidExitList[] = {1, 0x80000001};
     WHV_CAPABILITY_FEATURES features = {0};
 
     whpx = &whpx_global;
@@ -2183,7 +2093,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     /* Register for MSR and CPUID exits */
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
-    prop.ExtendedVmExits.X64CpuidExit = 1;
     prop.ExtendedVmExits.ExceptionExit = 1;
     if (whpx_irqchip_in_kernel()) {
         prop.ExtendedVmExits.X64ApicInitSipiExitTrap = 1;
@@ -2200,19 +2109,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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


