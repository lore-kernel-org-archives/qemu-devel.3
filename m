Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9769FF99C98
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEFE-0007IL-7K; Sat, 18 Apr 2026 18:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEF3-0006TR-Ro
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:24 -0400
Received: from p-east2-cluster1-host6-snip4-3.eps.apple.com ([57.103.76.96]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEF1-00051A-0I
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:21 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 C0AB61800233; Sat, 18 Apr 2026 22:34:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551656; x=1779143656;
 bh=MoioDyw9WNCdgAnpil2qVwmsqi0G9SAnV0FrCmNrGIk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NI3VEmUvUz7djUiMd3cwYD9n27bLbVeMX/F9UgneXD2E50UZzCAcH518vEdcGSyg9otViAW3SM5A8YnD1y1KbYruC1l8ihX0QkjrNNWqZ3pHOQN/oE5KqS+2vcbS/DMz7Y7yfh6i3ak8qQ3eBocIvZW1smN1Gjw1Ho5JJ1QJHPwBDyQUAyj2KVhXNSysTUMPiSXicqhggRd4lGShFj+fOXEY5FURPHLqxRidz58rDPxOZSHD4XQb6xP9aotSUqpCL567CO1cI6eq2W4BiUogj/wfshS5rHVmHJJ0k3YC6IHSUeRcq8zypfzzlHHEJlSrMaaexeSJs0/AkRbEkKgqvg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 A40DF18000DE; Sat, 18 Apr 2026 22:34:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 27/38] target/i386: emulate: use exception_payload for fault
 address
Date: Sun, 19 Apr 2026 00:33:09 +0200
Message-ID: <20260418223320.51330-28-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfX6SKf308iUoHL
 ouXAclk8csGVPRazCJTzJ2zWH4Ezh0Zss4aulB7G0dZLV9I/6KLf3sJKchLLJ4+TmGWmU5W+ZBs
 6vtyw9EMFAn3QL/BheU+suf96pq3nObohT6GYvALQG9Yiw7RGoGT0XQb0KCwCKUyDK42OK8X1/W
 m+y6+kz2ATfLW/a3k9xD7a628chvKs/qfd1RxqK4t1s2lcQGF99sZIijrX0rPqKPbdTTmqnMPY3
 ASi7bf7rrsgohoEX2IQNyrQvHs+DfwwTTQLitjPizzYJ60vtFPZnFo7RsyO43uVs1WCYab1Rxvg
 rHAkKIZhR792Hrw1RgndvFDpsRI9kTA3VPF5O9gzpPJKpF1AuIDCyZ2IULx7Ww=
X-Proofpoint-GUID: 8ht7CBbAtdti2zpb7UEFxVqnfWlYzRJ2
X-Proofpoint-ORIG-GUID: 8ht7CBbAtdti2zpb7UEFxVqnfWlYzRJ2
X-Authority-Info-Out: v=2.4 cv=JN42csKb c=1 sm=1 tr=0 ts=69e406e7
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YcyI-53RcdBlrF1VUN8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 clxscore=1030 mlxlogscore=791
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.76.96;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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

Instead of directly putting it in cr[2], put it in exception_payload.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_mmu.c | 3 ++-
 target/i386/whpx/whpx-all.c   | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 007de582de..8d4371467f 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -277,7 +277,8 @@ static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulo
         translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, translate_flags);
         if (translate_res) {
             int error_code = translate_res_to_error_code(translate_res, true, is_user(cpu));
-            env->cr[2] = gva;
+            env->exception_has_payload = 1;
+            env->exception_payload = gva;
             x86_emul_raise_exception(env, EXCP0E_PAGE, error_code);
             return translate_res;
         }
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index dee2a203b2..02235d5391 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1818,11 +1818,11 @@ static void whpx_inject_exceptions(CPUState* cpu)
         WHV_REGISTER_VALUE reg = {};
         reg.ExceptionEvent.EventPending = 1;
         reg.ExceptionEvent.EventType = WHvX64PendingEventException;
-        reg.ExceptionEvent.DeliverErrorCode = 1;
+        reg.ExceptionEvent.DeliverErrorCode = env->has_error_code;
         reg.ExceptionEvent.Vector = env->exception_nr;
         reg.ExceptionEvent.ErrorCode = env->error_code;
-        if (env->exception_nr == EXCP0E_PAGE) {
-            reg.ExceptionEvent.ExceptionParameter = env->cr[2];
+        if (env->exception_has_payload) {
+            reg.ExceptionEvent.ExceptionParameter = env->exception_payload;
         }
         whpx_set_reg(cpu, WHvRegisterPendingEvent, reg);
     }
-- 
2.50.1 (Apple Git-155)


