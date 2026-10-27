Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F7606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=G7eqMWrx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjaC-0002nQ-9M; Tue, 27 Oct 2026 11:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYp-0000ve-3A
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:03 -0400
Received: from ci-2002k-snip6-6.eps.apple.com ([2a01:b747:3005:206::6d]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYm-0005le-QY
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:02 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 BF6E81801A61; Tue, 27 Oct 2026 15:57:52 +0000 (UTC)
X-ICL-RepId: 01a17e15-12a1-71b7-a6c3-6ad152b83073
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQA9GXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116675; x=1824652675;
 bh=tqBV2K6n7jKIaXbCeu0UR/Tc6GJjyg9VY1NyTXxJTZ0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=G7eqMWrxEdzgx5WKPi6NtwQN7CV1P+TB9FnQIWslT42q2DcnjUCs/fSUVwJY7u5FUPT0v8GT+y+QJLWQ9CGVVdYZlEFlsvnA44WN4/eOARtThj3JYoXfyH2/1w0m0Sy2dG+rkZ5ZWli8OTCDkaNMjLsIkxv8rK13aJ+bOZxzMY7/nmt0Ws6VMhpiRsKtEi1Tz2BqP6Sb8aUITa3T4O2jOckh5aVB/Sc4ifQFrekoPjj2JtXjDAaigpqQOdgg9VX5gWNZDEj1BKRC9rbidCuVu7MzxhU/w0hp1ro5zB3eV0x934Bi532cikhk2ODBeGB+BB+faL8Ca8iuj/G3MOFavw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 1074318010B5; Tue, 27 Oct 2026 15:57:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 07/18] whpx: i386: allow migration for restricted scenarios
Date: Tue, 27 Oct 2026 16:57:26 +0100
Message-ID: <20261027155737.59271-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3okTIFlywdwoI5NUzqHOyxN8ZOcIboP9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfX1srLTJMSqfS4
 5WkgAhJcn/4CwvPHPTIxyPA9ToG2WxFbcLsaEeAiPol4vakRm7/ZsRUel0gsspa46HMhnXJn72R
 tzN0CSEDbXk2sSb2iK8sOqGKaAZn/WFHH1zUuBpoKLioawlO/ThMBSCD1pFyZLsNu5MsqpEGZix
 ccaMH43Aa/zT1eYduAEZbAjQdeHjOzach7ByPX3LbuhoO7JLnoqB3b+c1xLHQ2UecOKdoISolUF
 h7EPuYeksDxnhKrD1xHuvDQ2x66wWApIAF/HJ1rmtTFlFBGdg8rQ3+CtCwelGEuuk3N2FQX9NgZ
 OgyT86LYkVE1oIPiI/VkkpoO0udPzA1oLg+fh4/XYXAEqu7HGkDsbrrBqLKNeI=
X-Authority-Info-Out: v=2.4 cv=e8ALiKp/ c=1 sm=1 tr=0 ts=6ae0ca01
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=MerKYVpz6y7523CMNJgA:9
X-Proofpoint-ORIG-GUID: 3okTIFlywdwoI5NUzqHOyxN8ZOcIboP9
X-JNJ: AAAAAAAB9DzuoUud3DkvsSB00f6olixsn17q6dH8cixEvyqRWLnAVQ+/37yAYOSOXVeAVWbSPi6Si52X9Ld78waAkbKg370MfeIHu+cTkRH69ZnwXYinjp+bz6T5s26mDO1wrDs/WsWwuATs4GiH8u3Z9ejoa/aF9jwB/1IdAQKc0GrC3j6K04yWE8+TsfMf38CGW54nCtagKY7jTVUrScR+tUGAtM/6E0B9bF8npEdb91ttZxZu5AXk1ItP2Mat5MmS6IdncxcaVsJ6/H6p7Ch2nytIAfiau2if0FljQvFMmfNHkcTqSybqRf9OCs3QzY2Lm0qiuDsYFzr2dCKCFaXY6JwFj47TVCankd1JT4zzMC/zkMQ6UCoD2C7PFT+GurXMkJcQcSzqyVBcpNlsQyuGzXOIyzfyH2w5a5EQJBDpsJQKSioMJlVAhM41hfVx2PRzgf3dFa/SCSCF7WXvKAMdwbYSPbYOVOFTS6XLvyhckksiXaUbOdmShRcSlQOpd5fXpBsC/r7Rr1hD0+z6ZtHnJfiAsKcwHitPbIRlD3ZIV1aVtGWKcNLJNmENbIwnlSg6/LkPqEhMIt6qkmc9ZUtue4khg6o1hzGaihsmht1HUXgGYuosyirv3KzJIPAu4aLwBNzwtQq26h/xlLDFnsMXh/bRkzzpOVTTrrt4nKT9EM+9MmCoyCufOfsWVAyL5x1pL0FOGzHmah23RplNTC/JnyYU3InAavb3ad+Zr1xOvdqZW+FVCBO6HpZGEedt1Nb3eDvUTD2edGfc18kKMpqxJ+mMK6bIfQ7VgGhXdVAY
Received-SPF: pass client-ip=2a01:b747:3005:206::6d;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, nested virtualisation state is not saved/restored and
neither is Hyper-V enlightenment state.

Also, not debug register state nor MTRRs but still usable.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index d13513985c..5f14564f10 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2828,6 +2828,22 @@ static void whpx_cpu_update_state(void *opaque, bool running, RunState state)
     }
 }
 
+static bool whpx_is_migration_allowed(CPUState *cpu) {
+    struct whpx_state *whpx = &whpx_global;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    if (whpx->hyperv_enlightenments_enabled == true) {
+        return false;
+    }
+
+    if (cpu_has_vmx(env) || cpu_has_svm(env)) {
+        return false;
+    }
+
+    return true;
+}
+
 int whpx_init_vcpu(CPUState *cpu)
 {
     HRESULT hr;
@@ -2845,10 +2861,11 @@ int whpx_init_vcpu(CPUState *cpu)
     /* Add migration blockers for all unsupported features of the
      * Windows Hypervisor Platform
      */
-    if (whpx_migration_blocker == NULL) {
+    if (whpx_migration_blocker == NULL
+        && !whpx_is_migration_allowed(cpu)) {
         error_setg(&whpx_migration_blocker,
-               "State blocked due to missing dirty memory tracking support,"
-               "And some system register/state save-restore ");
+               "State blocked due to missing Hyper-V enlightenments,"
+               "save-restore and/or nested virtualisation");
 
         if (migrate_add_blocker(&whpx_migration_blocker, &local_error) < 0) {
             error_report_err(local_error);
-- 
2.54.0 (Apple Git-157)


