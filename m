Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35232E98E06
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRSc-0000rD-2I; Mon, 23 Feb 2026 03:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSV-0000g9-DQ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:27 -0500
Received: from p-east2-cluster4-host4-snip4-10.eps.apple.com ([57.103.78.151]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRST-0002I0-Ld
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:27 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 C10D4180021F; Mon, 23 Feb 2026 08:38:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835905; x=1774427905;
 bh=IYoDu1Lf/5IVuiCOr/JCatr7nNqgDdTH9YXn2YCe0wI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Iu1JMpEiX0KUElA4Xzgk/B+VbohRFjeA14RALqaPDeH1bYQRRQTObPbirLwx+1tRRz5dStsX0Sel8CNiYVMtK/wC2qZS1F6WVke8FA2zEmz1zLpHjQVpE2ty4ivQgd42zRmxwdunKpnk5JECgzYiYyiQiQl9KkLU/kwZtd/D6KnX2ZvTF8bVagC4SiVEZcx6r4NDr/FFXGvTdlwm8efdYK2hnA308cuBOVGMoar4DStWeyzVL8f9Loos+ocMrrNtfRc7hsk0JoGbRKnyiWkUCTTzcP9gHo2bqv84ginbBLPsM43wqv7RjAo+aRhCcHwUSf4GmwZ/QrjEQLfSua9gFg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 09CD1180022B; Mon, 23 Feb 2026 08:38:19 +0000 (UTC)
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
Subject: [PATCH v5 18/27] target/i386: emulate: 5-level paging for the page
 table walker
Date: Mon, 23 Feb 2026 09:37:24 +0100
Message-ID: <20260223083734.48533-19-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wsYI_q74itjnoY1Y9n-LcBXOCKd8rKsO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfXw47CegKWW7cG
 pIXsp+bSBgE4aQdsr/3D3PlDInK7wiYeurTSZzLJ3JU9fraNBN7BG0fnrt9nlkK58FhaJmKG/N7
 WqpNv0DoG7EOtAq/8n53w0RPAOrs1ZiKvFZLxRa+RBC7jj5VlABU8FmyGOiWsYUx3QqxTEmdwCb
 vjrw4AJTwGNYWfG2zfgFoq16ZoB+GsXUcfU5Z0szoQKbf+DJ436V2ZRuLwb9ijtOA+P8T6FA2w2
 HDEF1UxN8UkHcbA2w/Dc65H9uz6ea0esil023AfYIPrpAbmcEFo1Uhbb6kx76bjwkE71sV31dOM
 yqYQuAA202LbYDaWYclolIK227p8LlNweoMTKrRPQXb3lPJetDGysKFs8rxZnM=
X-Proofpoint-ORIG-GUID: wsYI_q74itjnoY1Y9n-LcBXOCKd8rKsO
X-Authority-Info-Out: v=2.4 cv=N9Uk1m9B c=1 sm=1 tr=0 ts=699c11ff
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=A61MTNvy9Chr7HSFv3YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 clxscore=1030 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABD9ZuAxgszkzcgbiOIEP2/zg+CLLg/DaBK5YGRPKZg8GLo4QIucTJaWGj29Sz9pCRlqyt/+fc2Rs2KVsGbgJ25ezbr17KMMXl/6k0fO36XLQH/7N25qIGDwV73Sw7NpmsESp0tEgv5N8V4BOOpc2puXZmHtZSyWh2OSB9ptGE5BrwhQ6cOsAmzX+jRLaeSd3hq+p7KTQ5JZ2soMLbNsIADFQrTLxdYYwtrcIgcjAauYJElaPImXlG+AEKi1eBxJiFTgf78finNshE+Vd+/o51htjKZj8cGunCjtWi7UQL61HmVaYTMcSnz5sllHvsfgxu+VrY1YmkWfM5XWahWQH+rIPbiRKhmij5MtkfYjsZWUFKfnXaVURGufQXuOc1RYrklqq8brCzwQfDLYJ9FdvJtcJcavLLbSFkPHaRD/nZo7MPHE+zvRFPcPMCkz/qaFFBNYyylgpgHgoe7BOtbjXlUyBpgAl1dScHzxWaqpHrXxcUerVMY6j4qMtBfj4RAhjBY2fbhFwS8U3SQ3tchzXcJakU6v2+M03qV4zSHtwXWXd/ZjTKWVN7w3z40CBnSE2jCJCYscWwirqST1Bkp1Dc7bnLvh+VpH4wSpS3aNKXgKcYhepntxhcYAgr/4V9zylyYyFchyNl5/3lI0R2NbnLethQyHfGvb6Slexu3zjHHrUxiDiz3mj/1hGktNph9RwO9W8r8wWh0YA3eJFS9H0w47ZE9mKMfWSB6ha9jaGAt3YoLypbA8OrJ+ROvowulF7XNRpZxTr+Ie7EBPZfFPwWR1aBgCgvKMH71VhHYAeuXGeZV/5cllU=
Received-SPF: pass client-ip=57.103.78.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86.h         | 1 +
 target/i386/emulate/x86_helpers.c | 8 ++++++++
 target/i386/emulate/x86_mmu.c     | 3 +++
 target/i386/hvf/x86.c             | 5 +++++
 4 files changed, 17 insertions(+)

diff --git a/target/i386/emulate/x86.h b/target/i386/emulate/x86.h
index 73edccfba0..caf0e3be50 100644
--- a/target/i386/emulate/x86.h
+++ b/target/i386/emulate/x86.h
@@ -263,6 +263,7 @@ bool x86_is_protected(CPUState *cpu);
 bool x86_is_real(CPUState *cpu);
 bool x86_is_v8086(CPUState *cpu);
 bool x86_is_long_mode(CPUState *cpu);
+bool x86_is_la57(CPUState *cpu);
 bool x86_is_long64_mode(CPUState *cpu);
 bool x86_is_paging_mode(CPUState *cpu);
 bool x86_is_pae_enabled(CPUState *cpu);
diff --git a/target/i386/emulate/x86_helpers.c b/target/i386/emulate/x86_helpers.c
index 0700cc05ef..7bdd7e4c2a 100644
--- a/target/i386/emulate/x86_helpers.c
+++ b/target/i386/emulate/x86_helpers.c
@@ -236,6 +236,14 @@ bool x86_is_long_mode(CPUState *cpu)
     return ((efer & lme_lma) == lme_lma);
 }
 
+bool x86_is_la57(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    uint64_t is_la57 = env->cr[4] & CR4_LA57_MASK;
+    return is_la57;
+}
+
 bool x86_is_long64_mode(CPUState *cpu)
 {
     error_report("unimplemented: is_long64_mode()");
diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index b82a55a3da..35987a897a 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -56,6 +56,9 @@ static int gpt_top_level(CPUState *cpu, bool pae)
         return 2;
     }
     if (x86_is_long_mode(cpu)) {
+        if (x86_is_la57(cpu)) {
+            return 5;
+        }
         return 4;
     }
 
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index 2fa210ff60..e98f480f41 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -138,6 +138,11 @@ bool x86_is_long_mode(CPUState *cpu)
     return rvmcs(cpu->accel->fd, VMCS_GUEST_IA32_EFER) & MSR_EFER_LMA;
 }
 
+bool x86_is_la57(CPUState *cpu)
+{
+    return false;
+}
+
 bool x86_is_long64_mode(CPUState *cpu)
 {
     struct vmx_segment desc;
-- 
2.50.1 (Apple Git-155)


