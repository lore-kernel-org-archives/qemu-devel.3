Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF360F99C9B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEFG-0007Zo-Id; Sat, 18 Apr 2026 18:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEFC-00077j-IN
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:30 -0400
Received: from p-east2-cluster1-host4-snip4-10.eps.apple.com ([57.103.76.23]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEFA-0005Df-Vz
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:30 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 8BCB418000E2; Sat, 18 Apr 2026 22:34:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551668; x=1779143668;
 bh=kGhBK4LCPtYSYe6aojWD51bIwGxqBS+1pxUsdaVHLfk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=HWWz826Phui9dviZ5wpRDaIsKTOPsi6eLmN/PAta3epWjFjdLUtUGx35YdAgYTIpuTDW+PE6WCWZauRsNVjGO3J1qBbFy50fDLF5//DjUu9vDXixFFg6o4AiVN997BO+nDTIOEcyOt8AuTpm02WgRbXulGPnDtwW3wNXrtasyvqv4MbLt3GeVVbU7IiJBRxeJ315cCa9hGvAhB6nUerm1U6EgWxXGdj4GxFLgQRCm2fc6CR7KZO042RA3OCGWJoziiRYzJsM6jMvlJ1uZiNCWEHm3FTjFr/DJ6LRsXOsby6wtlcSzXFAVaZQoGDgpFmXXRBtEWLuj68PmjzIc0zRmA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 89DF71800219; Sat, 18 Apr 2026 22:34:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 34/38] whpx: i386: don't increment eip on MSR access raising
 GPF
Date: Sun, 19 Apr 2026 00:33:16 +0200
Message-ID: <20260418223320.51330-35-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=OoNCCi/t c=1 sm=1 tr=0 ts=69e406f4
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=N0YEvnU7VqbRQIRMxcMA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
X-Proofpoint-GUID: GDJvuNSI7pJlzRThvRB8l-5JT5pKqFIe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOSBTYWx0ZWRfXxDg/Xy1RFHX0
 UIqif8DSy91Y8yqNykv0f5nAx3ixDpoUB24ozRp80wAge5tht174LiA0MS2POVLuy0CXr2VIF6R
 XGMmq4K/7YkbouBr1dw2hJO0Otbt27UAmln1DAPq9yeKu+8Cq4OvlO6kOFXwtebfNXlfy6U0jNt
 Ifx8JH9/LrKRXZFxJUuKpzkX/4HRxEbrAaEkR1IjSjPG32LEBfiRqAVpAgvOmVX9lGrdUBZ+T/A
 IvlYsDdIq24slYS5xSfwrq07Ayo30y6ZP6CUyTj9CH2gqwoUDc/TI+Rg3O0CLCMFV5w3anlu6GO
 I1llOrI+ykTb36tydkwZShmCxPaE08yme8d4qW9IUNOTfgfF2qX3orX1Lws+bE=
X-Proofpoint-ORIG-GUID: GDJvuNSI7pJlzRThvRB8l-5JT5pKqFIe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 clxscore=1030 phishscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=757 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180229
Received-SPF: pass client-ip=57.103.76.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 98b13676ba..de254e236b 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2178,6 +2178,7 @@ int whpx_vcpu_run(CPUState *cpu)
             WHV_REGISTER_NAME reg_names[3];
             UINT32 reg_count;
             bool is_known_msr = 0; 
+            bool raises_gpf = false;
             uint64_t val;
 
             if (vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
@@ -2210,6 +2211,7 @@ int whpx_vcpu_run(CPUState *cpu)
                 is_known_msr = 1;
                 if (val & MSR_IA32_APICBASE_RESERVED) {
                     x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    raises_gpf = true;
                 }
                 if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
                     /* Read path unreachable on Hyper-V */
@@ -2219,6 +2221,7 @@ int whpx_vcpu_run(CPUState *cpu)
                     int msr_ret = cpu_set_apic_base(X86_CPU(cpu)->apic_state, val);
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                        raises_gpf = true;
                     } else {
                         whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
                     }
@@ -2238,6 +2241,7 @@ int whpx_vcpu_run(CPUState *cpu)
                     reg_values[1].Reg64 = val;
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                        raises_gpf = true;
                     }
                 } else {
                     bql_lock();
@@ -2245,6 +2249,7 @@ int whpx_vcpu_run(CPUState *cpu)
                     bql_unlock();
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                        raises_gpf = true;
                     }
                 }
             }
@@ -2294,6 +2299,13 @@ int whpx_vcpu_run(CPUState *cpu)
 
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


