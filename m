Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33471FCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXqG-0004Hn-Gi; Fri, 06 Mar 2026 11:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXqD-0004Gu-IP
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:53 -0500
Received: from p-west3-cluster3-host9-snip4-1.eps.apple.com ([57.103.72.232]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXqA-0007B1-9z
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:53 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id
 26ABB18007B0; Fri,  6 Mar 2026 16:15:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772813749; x=1775405749;
 bh=RdupMbasv3vfE7MWncsbZfwo8ETMcn2mJfgeWSq9R+8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=FAc0FoumzFfcidgqQCD1VTFFw+kUvK3EWgugFVELSotAav7KIj+A/OW1QjPJi5UKfkzDTAkqWUE5wUWSuFjR8ZNMPxxUvs/Fzqk6KaZBbYMvi4bKDgPHWuCmJ15zKro0Jhn4ZrzBKxmagMjaTm3Am0SLUfHWfKd7O37UB/qNATyu49M6zH/w2sPwGGdO8rbHgx2cql8vFKcrANhTOlZOqAc9XikRJsZxHfx4EbF3HBxN0UKOzrFcrTLgB29eNEG20S4yS2Si3jNwuWt9mte0VPoxZ2mdA4oeE4pNCqvLhaRaa/YR8YKmAr2cHVqlvqp8cFLfZEoiJG24yw/wnySHww==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id
 224D5180079A; Fri,  6 Mar 2026 16:15:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v16 11/17] hvf: gate ARM_FEATURE_PMU register emulation behind
 not being at EL2
Date: Fri,  6 Mar 2026 17:15:03 +0100
Message-ID: <20260306161509.79712-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306161509.79712-1-mohamed@unpredictable.fr>
References: <20260306161509.79712-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=WesBqkhX c=1 sm=1 tr=0 ts=69aafdb1
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=lOv7bB1OiAV5i3s2B4UA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: rfSlUdcftab_3CAfKoLrj3Fxxc9VrXh4
X-Proofpoint-GUID: rfSlUdcftab_3CAfKoLrj3Fxxc9VrXh4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1NCBTYWx0ZWRfX+A4T+0BilWx7
 +GoOW1Qy/mocA0PNOq3OTyT19CdXOaMtlp/y6ycTkgj1AtnoyqgdHq6an+PRKK8prKl+PMtEF/j
 C8E6PZ74sGK45epz4OL+WO109g77aGkPUqn20wAh5A2wvLDVqg4SwZEViMnfbRB2WvC89m5eoqE
 tfH+FOg63Giurepl5upPnKgjMwabUJvIAemNU6B4OTcWuv1F8UKMWKDlzzzJSLOJKyyRvr2jM1S
 vngTSE8TDnYmH3IyovjfZBNLbUeVoVVVlNUDWoL31w00VrooVjAjZcyzn79W0kBULi/l1ORDHqS
 dz6j/CWo0f9FDynnqiQtzsR9kzB8iC0ST1AjaTC6H4nZ61qu7ybNwqUQjzn4Hc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=752
 mlxscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1030 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060154
X-JNJ: AAAAAAABpXXodEuu3VR0PPxYF7W4Um3CLP9PbhpmlSMNJntfqPot1TjQqMWnOG7o8r6epdlWRNCa3mGz22ACK9j9oBhRDAlSffM5VTdZDr2Fr9/dBC2FYm03t9/XtwgC2PAqhZu05SJ5VyXckBuyJHbLV1S7Xr7q1BX2xpKLTh57T7s0XLetlyPZVxNBZlMfBMz78F5qwqP9X46LEJexuP7+uwyKXGdJlipWiCD+5q4j0kGRjBBw2Hz2LCsuEJcC9iJEkEeEnSvXuVGq4ySxu2JFosAtWkjdeTNgd3IWrWCbpZe0JOvB2TrzcENeSczOqIWsyG8UgIHjR/82F/UEq7vxSAPfDmGTY8cc4DXeIpjnD/kQv0surNWAb2355054l5cshOMRm20pal2v3c+mQceMCCMG9/E5mznHbeljFNa7dkvQiRVl7Y6BEb9BrdqEmEDKRS/m/zIYu4easOhzBlwLWAdXAHqS/3P0jMhU77ydVC6X7F3W1uPy+6EBALEIZTyJMwGu+HtnRVzZYhtkrKHyTWtJhnFjISsogwpLtEmW47mKQEmsUt7tvRJWX80PcxRnKnh38nV34/k9gU2kJ9hAJLTk8DsZCiVTxvxrv0+hsaL9n2K520U7Ac10YxEFQyR2xMwZygVJxGiJbYofREvFscvAzksRUERxE+eewgPcSC7WMa6SivLHl+5Uf83aNqF40vA0VNkDNYkV+YzL5Y1N/AmZjNDuYq275NtA7B/p0lvOQTGhno/MqlhhjVlpHzNsINh9RA2m3W1o
Received-SPF: pass client-ip=57.103.72.232;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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
index f06a3088f8..926a88ce9d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1598,7 +1598,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCR_EL0:
             *val = env->cp15.c9_pmcr;
@@ -1859,7 +1859,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                            SYSREG_OP2(reg),
                            val);
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCCNTR_EL0:
             pmu_op_start(env);
-- 
2.50.1 (Apple Git-155)


