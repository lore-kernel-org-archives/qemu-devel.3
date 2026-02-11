Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE79EB5961
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 05:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq3B6-0005W0-81; Wed, 11 Feb 2026 00:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq3B2-0005UA-5g
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 00:54:16 -0500
Received: from p-west3-cluster1-host12-snip4-10.eps.apple.com ([57.103.73.251]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq3Az-0002pq-V7
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 00:54:15 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPS id
 3DED918000A7; Wed, 11 Feb 2026 05:54:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770789253; x=1773381253;
 bh=SzPbZCaUO3NDYpRGPHTDqVjE5jH4BjEtis7wSjOSTkA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AGXIzEUHsyN+agiXpMN6GpCqxHJoDuyo2Z2VuLqy6EtNFOeiJlF/Ga49qbfoxmmuKi6T5t9EtTiLetX8eyvj7MolZ3muu4wcyaOH9eFQdNrSq7MFFFa38ardexuvyccKY74rRrEBnyaOKZQ+oPEFdEbvSudxBi2ipLIzRKlFGWl5d7lh32N+7KLu1mFsPxx+qUwx/CJdN0KlQuUKyJC4Lmx3J9p+17ezRA9vtUAEx8kib2HKUVokUWtXCKw0SN9QXa/k2aj/aZjwh7a1JS/PLtF26trOOPksw1VIDxvPjUZ8ECFFC/juo5VJlqNeSEa8YhRTz2jSukOXX8F5v4mLeg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPSA id
 2405A18000BC; Wed, 11 Feb 2026 05:54:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/7] whpx: refactor whpx_destroy_vcpu to arch-specific function
Date: Wed, 11 Feb 2026 06:53:48 +0100
Message-ID: <20260211055356.44664-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260211055356.44664-1-mohamed@unpredictable.fr>
References: <20260211055356.44664-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SXQ-93R9Brj3969dJPjsaGDZdI09jgDr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA0NiBTYWx0ZWRfXz6c6hgIphOnX
 DdaWvQJ77Po9609hSzjn5kV06EBZTwqQIgSG6CtPSXO6OZ41ybXAamCY41Ln0ucgujNNW89Vu6e
 FQ0qT9b2DZ6i//uoM3ik/GRUCM0Kqg6kL/sDQEyUbxp0pDXnQclKiRudpBKBi163dJtnsPJRlol
 15b3XaUSqa/OGoghUqUfJOguxAFZtonW6IoFIcPsp9EhoZOWjciylJ1cPgmCBb9pYzMTG7BjBj4
 aB0nlXkQOJ+kWFTM55xc9ff2NF/iljRKqauWuEcgA8aoxMww1ThwcYk+Hst+6XaLOIAafjKOFNw
 NwnMhmX+GsvcJFC9C9dNC/qusP5KphKna2EiqOit/gmfRKECA7D7XDcbOlisPY=
X-Authority-Info-Out: v=2.4 cv=Q7ffIo2a c=1 sm=1 tr=0 ts=698c1984
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=MnziPJL1nimGiMRD7rAA:9
X-Proofpoint-ORIG-GUID: SXQ-93R9Brj3969dJPjsaGDZdI09jgDr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 clxscore=1030
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110046
X-JNJ: AAAAAAABPPTIl41WYVFr5IFZDkytF57zw6Y+JlV9p1CsxNPAWom+OsTGrOXcE5kkmK15QwZVqzXzqgnF7eML5VtKDE0XwBTEUbsGijnfF40epESx7L4CIZgkl/S7diG2JEx98J9Awj4pWSJnCvq0M8U0CJAkXbnfptsvzJ2nVycBSaFtm3XZ+vMcDCHUV2CMrSiTPQ81hB4E6Cr7bomNz17v5TyDA6LlnLRKqsUNVvPU5G5r7JG/XF9OK+QvWckLai0Bl6pKFsLmO58LXX96HgRfyklfuqlT2T3upcrEmjb11KlKAuEGo2NKzxl8tnEjKye222MQhAl63xu6MVgeeB9UJfvrE/5bvMUFFBFjQCLovS9NKWPWLSWWJDE/AaRhG3ievgy331TbN1/sjzcPZp5FjPtvALhvG8PLjGrfZwFsANqN6wbUN28vHbcfPjoKNdndY8d+HdvvmnXSc9yf9S39xVoIu9WLl1+s9LHquVBp3KKTLT85LV+3oX7kjrWeDa++Z+f+8mJpOYid+PIxFZt1ScgfYa8gFZFqsL7fItBEuLjCDR2Zx016SYMe5GDXF95DGaMBXsVuhdx2vrzw8HCYHwmBeYz19aLCJAE5iAgx2p0Tg3hIg66d9ch66JmODgJ2R2tqbmNlV5q5esJ8EUfLfnWyUzARz9a8k0KCXHi1GXLBFiS0HX10eADOXrKNAuCgSt9QaPfUTXB0KHMW6lVWG4tdKyg3PaYSLDSs4s+igxckcx6YGvESywjZJudCezCHJ1LkE+Kw6EIAa+wvLuAU1g==
Received-SPF: pass client-ip=57.103.73.251;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Avoid a TARGET_X86_64 define by moving platform-specific code
away from generic WHPX support.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c    | 5 +----
 include/system/whpx-all.h   | 1 +
 target/arm/whpx/whpx-all.c  | 5 +++++
 target/i386/whpx/whpx-all.c | 6 ++++++
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index f018a8f5c7..c57a0d3f0f 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -236,10 +236,7 @@ void whpx_destroy_vcpu(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
 
     whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
-#ifdef HOST_X86_64
-    AccelCPUState *vcpu = cpu->accel;
-    whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
-#endif
+    whpx_arch_destroy_vcpu(cpu);
     g_free(cpu->accel);
 }
 
diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index 3db074c38c..b831c463b0 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -17,6 +17,7 @@ void whpx_translate_cpu_breakpoints(
     struct whpx_breakpoints *breakpoints,
     CPUState *cpu,
     int cpu_breakpoint_count);
+void whpx_arch_destroy_vcpu(CPUState *cpu);
 
 /* called by whpx-accel-ops */
 bool whpx_arch_supports_guest_debug(void);
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 8d0ca794af..d52580a082 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -309,6 +309,11 @@ bool whpx_arch_supports_guest_debug(void)
     return false;
 }
 
+void whpx_arch_destroy_vcpu(CPUState *cpu)
+{
+    /* currently empty on Arm */
+}
+
 static void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val)
 {
     struct whpx_state *whpx = &whpx_global;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e1f0fa5e77..cdcaebbe16 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1277,6 +1277,12 @@ bool whpx_arch_supports_guest_debug(void)
     return true;
 }
 
+void whpx_arch_destroy_vcpu(CPUState *cpu)
+{
+    AccelCPUState *vcpu = cpu->accel;
+    whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
+}
+
 /* Returns the address of the next instruction that is about to be executed. */
 static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
 {
-- 
2.50.1 (Apple Git-155)


