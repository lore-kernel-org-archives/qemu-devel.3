Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA7606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=V0zIybxK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2gt-0002la-7d; Thu, 22 Oct 2026 19:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gq-0002k7-UZ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:20 -0400
Received: from mr-2003h-snip6-11.eps.apple.com ([2a01:b747:3000:202::51]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2go-00027Z-88
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:20 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPS id
 03697180055F; Thu, 22 Oct 2026 23:59:14 +0000 (UTC)
X-ICL-RepId: 01a1660d-fbf7-79fb-bd6c-a806c3f5d938
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQgpNC1gORQpIDk0AQA9GXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792713557; x=1824249557;
 bh=0DpZpC0HXjATZL6KON6fXf7dnugkN+4ZazEaow1D9EI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=V0zIybxK3OHnALXJ5cLTT4WwrPpv7DMcMW5veHPXKbJtvar8kwYEPoLr2+16biS+BLvmYyduUwRhPb97uLU7/XEIK2TvvZBDxMxOK6ap2BV4YUqh1fdgfOKsYmf7EPg8Gv0S4oM/N9bjXlNJ2oejP90DcxNQCDLCGynRE95kaxor9tWteuBD8xXZWD8ERUvcJwGbEocQ1WvhE9ilw3tx1Qu8n4suBUOVXf7aEJIqZ5n1WYlyVDdf3Vj8ipbYmC5Qe+jb1ECs7oAjrUM1gclgXrNf5jB3ouK6dZiqplNEBbdLJaIpbG0lkiol7SdfGpAQm9Xb4ORYNWcuV1U92W1quw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPSA id
 396EA18001F2; Thu, 22 Oct 2026 23:59:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 07/11] whpx: i386: allow migration for restricted scenarios
Date: Fri, 23 Oct 2026 01:58:55 +0200
Message-ID: <20261022235859.88753-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022235859.88753-1-mohamed@unpredictable.fr>
References: <20261022235859.88753-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rZhjqsx05E9eFiPs1JpUGL7ub78PFsDv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX0RvtWpt7Gyjs
 p+puvNU57h/TZ1bCg5xX1eUIaJsikN3Wz0ytUqQAEVJl89+X2XzveVCNmr5XyEkKjZ7zDr9JUf8
 564/ygtR9tkHSRR20vu/AY+qddindwWISqTPYqHYbu5yCXHcOS7s1yUDcLTzMS0hIXZA+5cqy2v
 eXACrMwH6Ocea60ArOoaGAln1/UzgqkimClnxIsYUJgLrCTg5tIFaivrdOmEXt7HhfISmolanFX
 hj2KheryC0z4DTqjg6zibSkHk+4yAcnSUuyjIFEk6tRAosBUg8JwUGUzyyhkA63Cjk4Pi9X+yXY
 RyiMI+Ux/2NxhHei02u8ZdvsHEm1auI7sI9S/Zc9gRJqUUsQCgUGbrNurhSi4w=
X-Proofpoint-ORIG-GUID: rZhjqsx05E9eFiPs1JpUGL7ub78PFsDv
X-Authority-Info-Out: v=2.4 cv=OYeVzxTY c=1 sm=1 tr=0 ts=6adaa353
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=nwY42hrHMEqICv1IH2MA:9
X-JNJ: AAAAAAAB0Jf/z1hMnVisCY2/TW/09JzZi+T1joQYPy5M5jhJg3Bjt+9FipEL5H721IWz8h6bFCtJYaMY4XlUVOu78pU1AYPyVvQt2I1CmEtMoZmnZJmbqGaMR6CMCfSVxne0wd+KODSf8mOik7GS8kCJECmV6oFCI0QhhJDPLsYq32DVmjRjlGUfnqzPahZ4rin5+5I19oFzsPD6KxQ86hCfa4RUQEBDNgy0SdAE1VvdFn2ShpG4pU8vgGf/WgsUek97CPZdKN4Z5xxJ0EhTXQsJWLqPFWVkycJqbZhpaHzZT9tMKoMfOlVyKAnC4VhJveGbZst4DTFV6Q2gsV5GfFensCxznnCDY2eK+L/nSR3+JdDiazcqgESU6ahkKMXDy4P1+yVXQyoD7spMo7jIs2McXzZZFO8BcoB6X7YqR/SS3qF7ksbpVipjl1fjlL/9CReUu6dFH24ybG2HWasGRg2RxeSnJWxWyHLuTrC9WqZkLnqVGXSqCYrcTJcsn6JH3w5eUVzPYiA9TKkUqi1x+Z33efhn7WTYRM8/z3eWl11Dgh7rV46VUlBWU27v7iZiProaJmwsd3selIXmLxKDP/cX74Dt6qG83yV/W5/2ndvjUiTejRuViND91pdeVqfIMQ4N3RJTMuaL33tgVbfkKKdQXBKwXnN9jZCOSPbkhfe8/XcN6UkVS4XkByw4pxeXBnvLh4sHONcpAwM75jNDEoYK204EqjFFrFTPwEwKg98o5Oo2Uo+X2S54OwGN+vi5UbS0vyOjNkDhgrrOl3RFa/+Bk0AmK/JFNycyHmE=
Received-SPF: pass client-ip=2a01:b747:3000:202::51;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, nested virtualisation state is not saved/restored and
neither is Hyper-V enlightenment state.

Debug register state and MTRRs are also not saved.

Tested with Windows XP and Alpine Linux. Windows Me is known not to
work.

Why put it now? Because the Android Emulator is (finally) updating
to a newer QEMU tree and they did forward-port QEMU 2.12's WHPX
implementation because of save-restore... And their implementation
of save/restore was even more restricted than this one.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index d13513985c..2f15d41747 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2828,6 +2828,32 @@ static void whpx_cpu_update_state(void *opaque, bool running, RunState state)
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
+    /* We're relying on the LAPIC state save/restore for pending interrupts. */
+    if (!whpx_irqchip_in_kernel()) {
+        return false;
+    }
+
+    /* The state save-restore we have right now is not good enough for x2APIC */
+    if (cpu_has_x2apic_feature(env)) {
+        return false;
+    }
+
+    return true;
+}
+
 int whpx_init_vcpu(CPUState *cpu)
 {
     HRESULT hr;
@@ -2845,10 +2871,11 @@ int whpx_init_vcpu(CPUState *cpu)
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


