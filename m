Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA4BF5580D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm77-0008RV-1F; Mon, 20 Apr 2026 06:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm74-0008PV-Sy
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:22 -0400
Received: from p-west3-cluster4-host9-snip4-3.eps.apple.com ([57.103.74.234]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm73-0000nf-Dn
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:22 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 B3BAA1800449; Mon, 20 Apr 2026 10:44:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681860; x=1779273860;
 bh=rPSPa9QNEGa/mspx8muwq7AvyIqsfM0CKqiZ0OTwje8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gMeNcNdvmjD9YpMasB5IE3dRDlj+B2WRGE9GEj9KyX7LoQSQp+lCeaJVvjp4KD/YFqLONkxgCFUDenyRh4WOQwVs4qRFlxTuATeGZGlTE0gShE2gwy1/VIfnZaX5LqlL/n8tIjSn/Ff9TXcNHHGU0YjCoXE8tq8Kh50QCFbIBMqD5oWMca0vk5G/I33tOr6Y2+6fuDjZJXw8x1Z1foMaNnrrdEAbFtS7PfcyBkdTPZY2mO3cB+j9t8En98zd6RDehtXAaMnDUTN+A5KdFFgG2Ntetj816FvDk7Xbm1u9XmOEoUfw0ZL0PZ4+6YcqKo2CGT5z2502NyGsU6dsGcf+CA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 00DA2180014D; Mon, 20 Apr 2026 10:44:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 34/38] whpx: i386: don't increment eip on MSR access
 raising GPF
Date: Mon, 20 Apr 2026 12:42:44 +0200
Message-ID: <20260420104248.86702-35-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=IqQTsb/g c=1 sm=1 tr=0 ts=69e60383
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=N0YEvnU7VqbRQIRMxcMA:9
X-Proofpoint-GUID: YxoqcTplDF3fAxDC33PbX8kwXAxpEfLf
X-Proofpoint-ORIG-GUID: YxoqcTplDF3fAxDC33PbX8kwXAxpEfLf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfX4FBRlfBWzUCe
 ZhE+GPTlE8Oo4ykYyP6S5rm0z0HSvXqV+PuJr+Wg5mrGSkyO6+7QzC0u38Zt5wo9uEZByFePMg5
 gOmRv0BtCiQ3XmH+IQr+Xg7Axa44foryHGLgTWrrkNHNp3IAN40fm+WtMLS+extfSm3fQIYAMci
 GKpyDyrrcPdaA5I8nAKMOm16/DZ7nE2K3ee/aX0vZkQkWEn/OoPl/En2O6grs5VEugsJxT28mCE
 1mOcUNFja0zDbyLM2A1DgHiLj1p1CAmosKh8DxvkEWHM3PNYDnPfwaDMAgeWlBEvFony22r7vmU
 TrnYr20Hmlg5z4/AVZkXt3npmWwTtMFaLw/D1SJnqFMo88IwTKEFPoP5dZWqu8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1030 mlxscore=0
 mlxlogscore=757 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.74.234;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index f9f12484c9..b0692935e7 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2179,6 +2179,7 @@ int whpx_vcpu_run(CPUState *cpu)
             WHV_REGISTER_NAME reg_names[3];
             UINT32 reg_count;
             bool is_known_msr = 0; 
+            bool raises_gpf = false;
             uint64_t val;
 
             if (vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
@@ -2211,6 +2212,7 @@ int whpx_vcpu_run(CPUState *cpu)
                 is_known_msr = 1;
                 if (val & MSR_IA32_APICBASE_RESERVED) {
                     x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    raises_gpf = true;
                 }
                 if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
                     /* Read path unreachable on Hyper-V */
@@ -2220,6 +2222,7 @@ int whpx_vcpu_run(CPUState *cpu)
                     int msr_ret = cpu_set_apic_base(X86_CPU(cpu)->apic_state, val);
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                        raises_gpf = true;
                     } else {
                         whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
                     }
@@ -2239,6 +2242,7 @@ int whpx_vcpu_run(CPUState *cpu)
                     reg_values[1].Reg64 = val;
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                        raises_gpf = true;
                     }
                 } else {
                     bql_lock();
@@ -2246,6 +2250,7 @@ int whpx_vcpu_run(CPUState *cpu)
                     bql_unlock();
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                        raises_gpf = true;
                     }
                 }
             }
@@ -2295,6 +2300,13 @@ int whpx_vcpu_run(CPUState *cpu)
 
             if (!is_known_msr && !whpx->ignore_unknown_msr) {
                 x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                raises_gpf = true;
+            }
+
+            /* When a GPF is raised, do not change Rip. */
+            if (raises_gpf) {
+                reg_values[0].Reg64 =
+                    vcpu->exit_ctx.VpContext.Rip;
             }
 
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
-- 
2.50.1 (Apple Git-155)


