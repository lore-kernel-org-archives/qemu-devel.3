Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF93E98E08
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRSX-0000mJ-G3; Mon, 23 Feb 2026 03:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSP-0000Qb-UO
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:22 -0500
Received: from p-east2-cluster3-host10-snip4-1.eps.apple.com ([57.103.77.142]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSN-0002G1-07
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:21 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 126A3180021B; Mon, 23 Feb 2026 08:38:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835896; x=1774427896;
 bh=op64aUwd3kHeSL+XTt7uxWfJ6n/JYbXZSlN/Ec+uOgk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Lg9QjPe1R5NZFsyMJGBfswkyqlZz5fjDflrdjYpWuU1EwyDU5RZuM8Nsmdo159qchJpCkdd/6LaLKm87iXxKFSyTooPxflYEIWQJGc6sAOllmR8wFuwxif6wqdoiHRkTOQXQbSMNyc/QuXA3TzoctWvAvxyBl8DcfWUKsWYxoRT+BQILqehWGQT+zoBd7G6SyiQw6fsaejV4oIbjl3nwt2s05upqRKLtmfqNjJPRqUlkwIUIlHrt41RLqTVu4D1cq0iQGhPpDXuY3CLM1IdvD63pp1GWQ4ny12oSGDTHGEzZCWFYHnTkY0Est41QlMQ/dmXRFzIjwTJRrmJd2SfuYQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 53F851800210; Mon, 23 Feb 2026 08:38:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 14/27] whpx: i386: remove CPUID trapping
Date: Mon, 23 Feb 2026 09:37:20 +0100
Message-ID: <20260223083734.48533-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: l1N_nbsWPFKQYnXxjLFyLwNsq7FxTso3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfX2v8QppCai7rr
 KCoSS5VurzPICii2i1NVGOBqCgtpl/dC+Te7Owss2NqQKbfwDjlH219BqNuuiI+v/KaMuIsmbSW
 DTF2iQu46QBdSKsLjqSFdmRgx7hAa/hIfFNCRv+OZa3sWTBxM4b3KAaUUz8mjusn+pRvSfLtI/Y
 34nPN3iiu6iceSKfbj9Ifs5fW3YDmgf6Pywa/nFiqXdAKa6npX4SiwzFenVzxvXFBzB+8GAQdfq
 A/A597E5lONDAxBCkvBVPsAUuwoNX5AD00+GtApNfflbTPm2uqZAVYzq7cWR0lxPrGjJGW09LOd
 eVNi4TeBPmO9aNCdJ8UxX6io9kLkZ/8gI30WtQRpOiGevj4i0WxbtZEKXlbSjE=
X-Authority-Info-Out: v=2.4 cv=fPw0HJae c=1 sm=1 tr=0 ts=699c11f6
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Gk9p9Fe9aJpBGj35TJ8A:9
X-Proofpoint-ORIG-GUID: l1N_nbsWPFKQYnXxjLFyLwNsq7FxTso3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1030
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABjZIOkB16XhAZZZeRFP73N4EZi6JfWkD6Gi5Hx8aNHXjcpS415u1XW/iKlUcOtJGtgBgysZpXrHA2aWUygqIUsWga/O7XW74I6ynQN6F36PPDV/g1ZtM71Y+CZgEZB5aQhUpfw2TkcO/0OJJ22NJGtV7MDIGzq9Tzj6ixEQ7saJZXK4BDcWwcoq8B3nikt1hquz+YvdbgysHhsxOlJU2rpbC92Wgt0d7lF1cpFcXwztLp6O+f9Xk51Et+DrgcJvgNO4W3QCTP0I4+kVCdLHcwARiGIDDdsaRAj/wiO6B0ap+8E6CK8jdWjYsgfATYdFRNgsZ+kZ+jrdOw8yb5C1qeoX2TdcP6SSNNUvuFy7k9N3vhePEDyQ+p3RqePzU3gjPMcJo9Aki2NV0ghs/ex36wZCji1IsE0JWbnzwstm8g2FK8Vux6Lv6TLC1LMiFKyXTesuaszXiznxIkY/kL95xdc0Uo6wYwZPzEIJUgkIIZHR05RBfPvkL4ObZiqJxuCRvztJ0I0SJKXR7fjNH2y+iiLBuXHPKqk/xOKCDU7iGrDFzczuibe3mfsAmWhbVp3bFn400HyKI3puMmjsJhL8ikBE3EwxpNDeUk+j0Kq0JUvYg/kAm3EfgSUm7Y0pMzhDG6otmVu0RVQOCGIQ5+hQITW6EOFIOMN1hhpHlKWx38c4GBut5GHvd9HAaamEg144/+X77Bp/lID7Xt8UwwJkNFCQqD804qMcAhfekLQ/vacw/72/p8GwdXItqQ8KiBhtVJx+MaatRYr3GENcZD0K7BrzYEmaIBpBBKuoZK3tueLc7Jg1YFXldJDx44KHVFz/GpWg==
Received-SPF: pass client-ip=57.103.77.142;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


