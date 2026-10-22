Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8A606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 00:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=hS/GgViV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2gn-0002id-Cy; Thu, 22 Oct 2026 19:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gj-0002gc-7w
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:13 -0400
Received: from mr-2003f-snip6-2.eps.apple.com ([2a01:b747:3000:202::3e]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gh-000268-Je
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:12 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPS id
 B6191180054E; Thu, 22 Oct 2026 23:59:08 +0000 (UTC)
X-ICL-RepId: 01a1660d-e392-7148-81ff-1540d7dc9199
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQgpNC1gORQpIDk0AQANGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792713550; x=1824249550;
 bh=BMfLaruRwjS2EuVB1qFM1OkXquvXAo2QdP40DhTsI1I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=hS/GgViVlsoKD7upPLfpQyMt+p3S7ayko5FieMTNSpxi+9z5YLCojdjA8BvCGlVQFMAiIys6zDYek+Yjuh2hAUUY6UytDbT2Pnm1utFoqAzetDAQl+VN7cxQ26HT6d70lU6jqK2pSqWtMXBT7i0TJF6wc1z2Kmwlk6RgyiPvIztLvO3siVbzbX2rLL3LKOv8zvYs867gFMrkvjEX+m+vFGYB97cZ5A2xzKCgZ18GhuD/5GFpSkfMzh0FmYam6L6XJy6uP6Jf6r07QzV4ptQicY32bLUefvmci4NmWX6HktocBINtkv9T+oeazbSVc/umR8zVxDeKfoBdQGJSNs7p9Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPSA id
 1E6C6180011B; Thu, 22 Oct 2026 23:59:06 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 03/11] whpx: i386: get APIC state before VM save
Date: Fri, 23 Oct 2026 01:58:51 +0200
Message-ID: <20261022235859.88753-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022235859.88753-1-mohamed@unpredictable.fr>
References: <20261022235859.88753-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5EgcIoOm-oOJRPbDY17_Z8jOQOugws4q
X-Proofpoint-GUID: 5EgcIoOm-oOJRPbDY17_Z8jOQOugws4q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX3EgeHjgQAvb7
 h//31JVQoMddttWu0DM873T+re0ySMNnRnPQkwr1tDgx4yqV8c423GlloQ8iAuv7kG4RwybBSkO
 DlHZDxrGfuiMYLm2gE2Dh56pgsLL5CEgcE/hrE0P3xOtAhffUh5lUdpdY+MJZVLxMWNUnT9xlxw
 dikX/2hkMQGBPLmyZn7MPRtTl5XZd3nWy4dadmwVtTyltUU6QbOepw33xa1NnNIjL0W4AcjJWtJ
 R+lPLIf6iX1pHOdy27h1T5XEbROsyeL0wR9MQfyrsazUz7x/KG5HoueyfkC2JpOHYeRh77qbFte
 AdTJ7rt/xBMaflY1jK4wUxATF+3OtoqA7uZrG/sCQkzt3+A1AF1sJbMxCtpwR0=
X-Authority-Info-Out: v=2.4 cv=Ap7jHe9P c=1 sm=1 tr=0 ts=6adaa34d
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=O2XxGrO5I-fc2znLRzsA:9
X-JNJ: AAAAAAABwdu9sEeOIaClRHBgVlTAegGjbh3rx/88lqcVjw8SzD7PCXrjGkK6vsKnKvvujnRIApltyu/FZvsRdhzbb9XUe5C4MTDWsptftwijAnxUBIjgBGfCm8RQn52uDONCvE/DjpAY9z9JfZnnpr0J+g4h6VNPYMT4BSoh8r89RQT+3b5QfqUz6NPRhhEvIovcuIL/9VCkoS9ZXe+HMpMuBor+GV7o6S5k30fnAVmgESrqgD7iQ5hHZ2oc0/sFxHnvuh8m9Lpyl5HKkNqhW/QRe7eSsbPNYhxg9mSdAfWNUXt/XTnVPQZ8XHrCymsaXO1FMWp+z6f7UbyanFADC4/PNhutwoskrA2d695Dv0RmgupX/Ayi0CYKbb6HqBp31cSixNIndcMj4fhXhxzZ2Ldojo7iVMdRza7jvJSr276kl4LPXPKzVKMh/Z7Q0dxI251JZZsv9Ib/oEYLf08DpKy0i40qLxblL53mEKDaiMFLyuDKk89EqSTc0OS7sL3MJaUPBURIu5KMyhr+JKIn15UXDjPM/HkqINWu9xVK0BhJbY4g6Nd6sYyvVyTNZy5XwaTP9sY4YgKFZRTaon+3v+irEJK+XAWN3AT65cKPvz8+NggEY8HXVN4uMEWM8+mfTN91VcsOORR3ONdccjDiaa1ZQobj+ErJbdo+HlAHz0e4E2/Mv8dlsdHkMdTceLdmxLRgfCAq2nWGiS9O49bj2mctznFL9Gj0LMavbNNzORfCyTLN1VbDsNYa60RNGQdQmDy69KOT4upREZlf2cBoxSsF6RUP445FOIXp1BiC
Received-SPF: pass client-ip=2a01:b747:3000:202::3e;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Prerequisite for VM save/restore.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-apic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index cc272f82a5..efdedbcd77 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -242,6 +242,11 @@ void whpx_apic_get(APICCommonState *s)
     whpx_get_apic_state(s, &kapic);
 }
 
+static void whpx_apic_pre_save(APICCommonState *s)
+{
+    whpx_apic_get(s);
+}
+
 static void whpx_apic_post_load(APICCommonState *s)
 {
     run_on_cpu(CPU(s->cpu), whpx_apic_put, RUN_ON_CPU_HOST_PTR(s));
@@ -338,6 +343,7 @@ static void whpx_apic_class_init(ObjectClass *klass, const void *data)
     k->set_base = apic_set_base;
     k->set_tpr = whpx_apic_set_tpr;
     k->get_tpr = whpx_apic_get_tpr;
+    k->pre_save = whpx_apic_pre_save;
     k->post_load = whpx_apic_post_load;
     k->vapic_base_update = whpx_apic_vapic_base_update;
     k->external_nmi = whpx_apic_external_nmi;
-- 
2.54.0 (Apple Git-157)


