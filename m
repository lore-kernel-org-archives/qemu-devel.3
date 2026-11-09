Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D4B606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=NwN/96Nc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDRs-0005hW-6G; Sun, 08 Nov 2026 19:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRq-0005gb-3H
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:22 -0500
Received: from ci-2005j-snip6-11.eps.apple.com ([2a01:b747:3005:202::67]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRo-0006LV-4y
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:21 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 2E0B518000A3; Mon, 09 Nov 2026 00:41:15 +0000 (UTC)
X-ICL-RepId: 01a1bdc0-8c62-7f61-ab23-0bcc6357001b
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtMHVUDRQtBF0AGTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0YZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXAEALTgJcB1ICQA1JA1UZUwdICUAeWRoGXRhYFVYJdx5cAEsdVwRUH1MSVR0dC0VVEgRACFZQVB5BBFYVbAlYBlMZVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794184876; x=1825720876;
 bh=BMfLaruRwjS2EuVB1qFM1OkXquvXAo2QdP40DhTsI1I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NwN/96Nci9+lkiFsJhCwYEadShkvWx1D3IDGKk66EzYFdkMTNSAOr9tsAlMp/049uGmRarA/gHddNwTbHBZnAL03DH7/vIJghsA5Rg7l26gtEu09SnmF64TGBTpcaDy2xcQcDdqXtJqrujILH8bwGm1YHsiRYzennRU+bm/WJB+KgBlfDbZy03AU8ihukGaHVc5fFuFdcWeLms2QbG1gSfelnssJtaPOqbb9yMJB4HJ1oX0qw/YLNLbR7vhu6pXJqzcahDCXBVZaSmUnl0foeXgXz/1MTckDDPC4cxNXGFdNPKydfszsElOMcdLNOhTZLiYel9+fXpI8yDtmQa6HEA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 284B318007C2; Mon, 09 Nov 2026 00:41:14 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org
Subject: [PULL 03/13] whpx: i386: get APIC state before VM save
Date: Sun,  8 Nov 2026 17:40:58 -0700
Message-ID: <20261109004108.85808-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109004108.85808-1-mohamed@unpredictable.fr>
References: <20261109004108.85808-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAwMSBTYWx0ZWRfXx3YdebabkSw7
 E3SsOrmjCNreH+eEMOwvPFxKwrbAQjdGy1st+AyD0zz+l06hSlHhQJyDbRcAAJeWbkEW8hNWAw2
 teXvjOgfu61rd01y10KVUbSARzkZf5XoNfe+A/OabcBOHvGUT4Q8cxDubOQKMgrQN6v+9y2oYDy
 smDzGrLL+v1N21OmHMH271+hrfBampmXBL3oVOJXuX10ltWPyDIceNPIRbuPE52ETUsrGISzozy
 lp2jMrg6KeenRl1us08l0xGSoWOuih8AXW9Ah6Ch7uy5N/nIJx31jqyxL78f56/JYYt9BCIIC1D
 9ss+jeN7NoCE2kkJzjQ84ANlP5q68oo7iDghO7HoRtg1mx3lVghf2/8c123LIM=
X-Proofpoint-ORIG-GUID: GfLqbDEOlLQq6ALG5paOhcuBb27g0y6z
X-Proofpoint-GUID: GfLqbDEOlLQq6ALG5paOhcuBb27g0y6z
X-Authority-Info-Out: v=2.4 cv=CLcnnBrD c=1 sm=1 tr=0 ts=6af116ab
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=O2XxGrO5I-fc2znLRzsA:9
X-JNJ: AAAAAAAB/S8lmttPpE7cQsYMkZWh9l4UuDTtuu20jP4ybm0Mr/AdXtoIpvCUiXMyvb59kg
 T8Y9TKIU8eN1MeEBzG8sYs4RJnuvytx9ukx6xzdOVP+6SD9c09dMPLiQAgCdziRJtEDWTU
 hy8hq006c38enS3Lt2xKjCyyCHwko6tgM9sIgCx4kcbVI98Q/fXn3AdgLyrh/OUAj8mlAz
 r3GgL9XWNuvPQsAnooI7FUUnHZCoeISpe5RiiA5Eqqe6ip7Z1jZnhEt/T5ME0LEi6L3kS0
 UgKer3zmUtDx1xX9rFCuESGkmFpxrTxhritDmMJXxbF7QCANlpdH/5hu6Na1UryN0JrSKK
 UOMQn/FrpOT4pveS02obQPQgfhVl0KR5L6ccYFpmOTz0M5pBBOodcR500Rc7530RCjtFM+
 PDFCmd5sj8ZR/x4hs75C2uBqy+9qzx43SKWICMJ7jIB9waOEsMEn/8+LCGQtl1P+3+7auq
 gQvWhHvofhMvSx/Gy74AXBtfUNUlFlddK8ZJ26QVvpHIGS2GhmCRZSvrxkS3CScbaJ5VwZ
 xM6To7iMV6qfHjk6OMNmH4jOcc22l3y0UzzbNWb8osY4YFA1LTe6RtIQrK0p/Qdc7ZYocQ
 Snf0/zv1gtGO7LYkh0a6qQHkxirEZb6MFgf07ULUp+rgiJt9nGyhYL7OPxjqUBLC6xiXME
 PJcQkmI/iWNYejRDbZmiRZ4T8eHLw6EaXkIia5wQJkUtjTI3XvV7v4wrp6Z8hV9E+hhYwG
 Mxfp9tAbvff+1lSowya+XnFWFCwSyQe98fSkR/wGDDpUC4PeVpajV2pw==
Received-SPF: pass client-ip=2a01:b747:3005:202::67;
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


