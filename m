Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AABF01808
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQ4v-0007Ym-Pl; Fri, 06 Mar 2026 02:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ4t-0007XO-Ly
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:31 -0500
Received: from p-west2-cluster1-host5-snip4-10.eps.apple.com ([57.103.68.53]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ4s-00068g-3m
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:31 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id
 0873E1800193; Fri,  6 Mar 2026 07:58:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772783909; x=1775375909;
 bh=qAVaZtJuZJH9uX/VVXHmkmsjUQo1XpfNBC4AOqSB4uA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=gWIl8l17mVEh+GMhITYujqbSVvTUl1DMrB4z9TQ7n/m5kELFsjP6f0D+slcxciMSp0qAb930s5Kzwxp+VtEx8Z/Cl8FfoXeD0/iXph8qG2bK20HCBoFJrSktcRuzvqCWjxbM/RT/0pbUD5X1w19zD3wdwDJnaHkHglrKMy5SzMnkAyi7CkZZXQIq1Vib6dJNUrzgl0Ml7w8HzTnm1nIoSVF3HdVE4igBRW3p23+0XYebPljgcd38gbRLRd40GDGiDtwYDCmGAhZOgOzSkdw6zfkpNxW3M0mMEK7MnA6wUqqbZ3ykxOXlFMYlOfhGvNA9KrPXKwjk5Xs6aETcEGE1Vw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id
 A9D3718001A8; Fri,  6 Mar 2026 07:58:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v13 10/17] hvf: gate ARM_FEATURE_PMU register emulation behind
 not being at EL2
Date: Fri,  6 Mar 2026 08:57:49 +0100
Message-ID: <20260306075756.88922-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306075756.88922-1-mohamed@unpredictable.fr>
References: <20260306075756.88922-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gUReKH9zc4B5gnQYvDMEhqmCePIJ3n9s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3NSBTYWx0ZWRfX91DdaBLkDZEZ
 gOO+s3VK18hzls8jBPZO3ZiGpkniFsGwOt/LZrKDMWXZWuRga2EcnzVXVm2JZ4x7DLw7dZ7ak6D
 7c5I6oYtJKOFEcAkDK9UyANLO1AIBUlafMF0BOpfExyBOrKENC+YTw55jspOYU732UpVD9JjqZC
 e+MzTmpaw2AIvsegwb1PBw+38k9oIBaVcy/eIUMRreAekD1rd2mgv0Gq9RAiEd3JBbVC+m3UzqV
 zGmHT1izs0Cwf40dWfU9l4Ex0I5oQu4F502Q/M0h0UJxJsNPCanGWIu9HUGGPSHdDeXWUYxtxTZ
 fYgXYmDLArk+P1DmI1Vfhe225qCOcs+rw+hYTPRcxArhs0BLkaTntk6bfkAXCA=
X-Authority-Info-Out: v=2.4 cv=SuGdKfO0 c=1 sm=1 tr=0 ts=69aa8924
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=lOv7bB1OiAV5i3s2B4UA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gUReKH9zc4B5gnQYvDMEhqmCePIJ3n9s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=762 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1030 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060075
X-JNJ: AAAAAAABNbZMC1utbIE4S1MXxaNer6tqTH+CNL4PCIZqPQipJ3tkZKIy6ev8IdFwvkm8yiCuOjgEQIZdnZQCigmbg5zSj8nNXZ7zwy79QMFuDMnsg2EC5KX12mLCE4BwneM6XJDWS5okpo3DvyrQUdMqc1GyTB5jCl1iDKYIeXWUrvxD3CNBHcGWOXQwYwcmly0A4wHMpgI84N5vx7n/Lm3OPpV0yF1CqGPW93E+UZcYR686eIr0sf/Ye7C+/D3hK8umxIEK1j3xEUblNzWcZu5y/wp9uFUjPcbPErE9OQLqfptEvOpPxujBE0BpoHrmkD6g9EIrDyRRAYfIHiGzpGrhrVMvPlaqvoi03zSjCVtfqtfVspCHcOSX8fz1gNdkLtS/l08s5KsCEmE8Juafk9gCraVztVCTNCFK0oWL+y0Bmr4OAs4uEvEkO8/TABvnG/2jdvhrIcdQmGWv7NgRldlKZViARooexxukJxfi9xO18hj0AGwGA44VFN0NwjHT4+RSftz8+4WD9Y2MNyTI7RNzry6bs7AC85S5dP79kSGTDDAm/Ge+1cTmyPVu34JoMcIP3p78HVDky+5FKoN2LB4xc3QmTrykiBq/Huvr8uawgVQcYi8TcKmNo/s6Xv67pXxhJ/HDmCrkl7NggB/zKsKC19FidkXocyZDQrlxxIaVERAGzOaKJm/8FoYUXAnfFLSoPxz8XBZxXt6bgdkcsjtO4mR4RD+gBAPaWdte1zwNMpza93BruHiq/Koc4R3TpA==
Received-SPF: pass client-ip=57.103.68.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

From Apple documentation:

> When EL2 is disabled, PMU register accesses trigger "Trapped MSR, MRS, or
> System Instruction" exceptions. When this happens, hv_vcpu_run() returns, and the
>  hv_vcpu_exit_t object contains the information about this exception.

> When EL2 is enabled, the handling of PMU register accesses is determined by the PMUVer
> field of ID_AA64DFR0_EL1 register.
> If the PMUVer field value is zero or is invalid, PMU register accesses generate "Undefined"
> exceptions, which are sent to the guest.
> If the PMUVer field value is non-zero and valid, PMU register accesses are emulated by the framework.
> The ID_AA64DFR0_EL1 register can be modified via hv_vcpu_set_sys_reg API.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 047b3601c9..da6b548880 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1567,7 +1567,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCR_EL0:
             *val = env->cp15.c9_pmcr;
@@ -1828,7 +1828,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                            SYSREG_OP2(reg),
                            val);
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCCNTR_EL0:
             pmu_op_start(env);
-- 
2.50.1 (Apple Git-155)


