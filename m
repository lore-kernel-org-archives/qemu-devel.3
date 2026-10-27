Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7BE60A2633
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=XP0gMCP8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjZt-0001sN-2G; Tue, 27 Oct 2026 11:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYm-0000ug-5k
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:02 -0400
Received: from ci-2002k-snip6-11.eps.apple.com ([2a01:b747:3005:206::71]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYb-0005ko-Qm
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:57:55 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 E921D180049C; Tue, 27 Oct 2026 15:57:46 +0000 (UTC)
X-ICL-RepId: 01a17e14-fc01-7b57-8679-4806ff0333da
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQANGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116668; x=1824652668;
 bh=BMfLaruRwjS2EuVB1qFM1OkXquvXAo2QdP40DhTsI1I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XP0gMCP8d4MdVrdV8WPvdUq2+4zMBT0Ibc61X8SSGSd9CnmM9Kmvu2UHwyQYAMXCfgUtVQxmmg7hJC4pxr4iOvzgZpahvUgM+QwgEN5usL91QaFomKzfD8jcr4qWSSfhFiNkG+iwid5aaZVnEXqIntaij12CYt5rWwOF3vT4Cdy8vP+aor9MBRjftUI9p9JqFycpgMFjBP+QOYc6Xe8edHu6MmYZDDNZs2PinJQYk9Uv664ZDXiy5WpJiBeBPk3wHB8xBh9ZIQEkf7rRve2AVlg2TiA+0oTfLwuIxSdORG9+06NK4ikIprqJjVtxEt4NX5gRfjYb5s1jkctuoJjhhA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 16B67180010D; Tue, 27 Oct 2026 15:57:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 03/18] whpx: i386: get APIC state before VM save
Date: Tue, 27 Oct 2026 16:57:22 +0100
Message-ID: <20261027155737.59271-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfX4niZ3dkOwVrN
 U9jrBo9JZSfUI3j3e7RF7wjo8cy4TVb5zuDak15+BVHx3GdZ0HmrqQAT8o30pPFp3SvLj+Jp7r2
 Ux1gJFa/zGAn/Cj9GTT1E6gqhZir66t43Dje+XtyzJEx5jA9bmda9FEjRfY7jvM47KB402kwdd9
 54ecloJt2ttA8wEKPdKqAfDj9FDEqcvESEivBr1Z41wfRlpeE8JAndwNW59/q8sXmv/Bc6dVJBQ
 wR1P3S2LEjbxkSeGc6fDDsCMC2Lgrm6/p0Ax7RlbMprHbPihd92MEEWUJLWKf9jK67yw8vLjgRx
 F9edPGv9AaGdUmrgse5hgY86tSdTpzpOQL1asLbZE8rSDzZszdYAfNE3oqLJ4o=
X-Proofpoint-GUID: RdqCj4BjaFhU_P9NVlhvF-Mp3tJ2dcUA
X-Proofpoint-ORIG-GUID: RdqCj4BjaFhU_P9NVlhvF-Mp3tJ2dcUA
X-Authority-Info-Out: v=2.4 cv=DvZbOW/+ c=1 sm=1 tr=0 ts=6ae0c9fb
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=O2XxGrO5I-fc2znLRzsA:9
X-JNJ: AAAAAAABSfiZy73aSjrpd1K+Vo7Ra2wOwe324cKtP8QTmdY1+k4CVrcGj+OybT6z3GGCVhRyNYgrkHXlDSFaiow3kIkYqBNlwJGEi2Hn4W3KLDshTnNWgOIMzsR2us3jkg+d4iXz82AAj6nPespXnXu07wZcTeuAlr40IEPsFkCp3/YcACTPLKcfCdNGzGDBg3xhB3jKcqhdBTLbpIq0Ld1WPInSEJAPJz6+KCkCoDMXrJac+SSjWYWWok1WFY6pZwjl/mdGtw38d+3FSnp+4zMMp6tV/fJ4JxmXTbG2z0dQndBntxdpyoQIXB4qccN4ZiG8R8VHPS4FbjjzKhuUCQPnvYYUXS3oPxU0T9O/ViHMupVfFCnl5cWqFOlu/TofZMOdjJwiaR69OiNPmOtuRnzOACX3FInNYO1amMZdj8IrL7dpQLW0S87WMDfi+VZY9pfg7ymBk1vUU+Lb/te8Hgd1bbgcAZEqrFYKbEzi2o7tCobUhSSYLsBdZ8dJXa+e1hyEVoPH3DiKvBpQyxmn5zQQsBGqc5RJYnHQvj3X4wVXqVTfoU5oOaK/Si5C+WSe8QvkYpOUsD4Lb0BwbVgKQ2oyVxVpIEtPDhN/qr/FRttEyyYtKcloGxRF8NQYARD5LolAn10bcN7eQDyeCHQ2hc0oORq4f8ASitmuyHhycBPjfixoa1kRtwNQPCKnjQluQWBEzpiFsG70wm4VzRaJhQe9lhCGzUo/0fC/6dPQ8UbPUiBfa8yMe0abGvdInMFa8KmXLJv64tkyw6rngQoNnxxPg0KsTF1OyegjRBXZT0zHhw==
Received-SPF: pass client-ip=2a01:b747:3005:206::71;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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


