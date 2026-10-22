Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1EE606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 00:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=y4SThmH4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2gu-0002mw-HU; Thu, 22 Oct 2026 19:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gr-0002kJ-3u
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:21 -0400
Received: from mr-2003d-snip6-11.eps.apple.com ([2a01:b747:3000:202::29]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gp-00027u-Gv
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:20 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPS id
 A261E1800562; Thu, 22 Oct 2026 23:59:16 +0000 (UTC)
X-ICL-RepId: 01a1660e-027d-75fe-bb4f-cfa565aa4c34
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQgpNC1gORQpIDk0AQA5GXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792713558; x=1824249558;
 bh=/Q7JkoSI88pgzUwwUfNZzSyu6kxg8oY4jMM3MeMnXv4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=y4SThmH4eMesx1XwlX5xpOd6MK9gn/cbrtQEECLwHGm7809zfdK22Uy5/udplBcnF90zwuKGtd6oYUddeeJW14MTjZxRfY2abYgG9LLB3VVqHDR8DH6pEBhIxzTtSJw4+chws6HjvTIKl1V4xWHHoiE+GPcMEjho7rMfc0OB3cNMhQE/qfK+K1OoxdFrsThppuI62ZEcIFYs3BCfF5y6XSHzrPOEcDZNzJUj4VmnypE/Br3Dgw/HtvEZ5HQe3037fRA4aW9PJm88eS8qNul1QQWFb8hgu4tmG8KiKdmrQHjb3FqBRfXqpJzgtuKhm/5zGNC2knkM8RiyGRNaYzFu4w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPSA id
 C15691800118; Thu, 22 Oct 2026 23:59:14 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Boden Randin <bodenrandin1@gmail.com>
Subject: [PATCH 08/11] whpx: i386: avoid updating hflags for vmexits
Date: Fri, 23 Oct 2026 01:58:56 +0200
Message-ID: <20261022235859.88753-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022235859.88753-1-mohamed@unpredictable.fr>
References: <20261022235859.88753-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX7rWKew5xvJ4I
 NggOu22nvjpnog5mgZDV3ObRT5Eg2cpsBvhRJBJgYTLvC/ocw459pP1q6GQ023GUHzgeRDE4qOL
 Q+a+RQa9OJgTYxoa2ZeTBU+d2Fk/VlkStAY+JrfXLih1vWhZb6zlknkWK/+4rk5xz/BfJOzIpCq
 E7ceH/bQIPmNUaog92ouiHAnzsJIwMgXKiebP/91VeXhUKU4Yy+tAFpeFgmSg7r/MAGhnOVvi43
 +rsgb0WJxJsK4mioLrVJ5axL2YlQvYwlpJqU1GKgbBSmqzz3sNggAHTZz7UhaYl4NdkCA6hByst
 J03QxHvygv9Y7L241HpIwWlg8x/yUkAkRt8GfWNG8y7Rf/6kQvEVt4TLkIdzWY=
X-Authority-Info-Out: v=2.4 cv=SN5PlevH c=1 sm=1 tr=0 ts=6adaa355
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=JvUqhf-O7Ua7-JxK32kA:9
X-Proofpoint-GUID: b1Ofhwu_CmCv0KHYA4vXEEzqEFi43mkR
X-Proofpoint-ORIG-GUID: b1Ofhwu_CmCv0KHYA4vXEEzqEFi43mkR
X-JNJ: AAAAAAABKoSfT4pKbP+LkaFy6CQzvi5CXOVxnVRSmcVZcRnU0l/xjsxh2Wwf4jGIMFPdDw3KW3c2sdWVGYTM0KWNgG+fewFSpt0YDrUlEqXOrVP1EWQVKJOfgqvg3GVlRYd9iZA8ziI0Jwn9o9M5RHnDiXubGj3yKollUtr3JIpT64EoDkDQUUfypfiOByzd/65XMR6OeAHZu8G8CmkVcCUI0Q/ih7CpR9dyjJCGnMPCw4Y6RXLATnRAt7IohO2LILkw58mBY3oGqgJ8b+ev06YN1oHRfWwwv18+A9BbN8eRWQbvp56c7LG/iQx0mqt5w3ZJ7pnMfnalZj5+wbc+yX5jFRiWJCnR55yLvywqYLJ43hwdrCkhr2OyiCSNmWnFMJDWNcpylfYcL2bKRziYi7JiEA6b970J7xNVspFWxfPHpPBdLYeug7CZ43OXd6aelOaGM4XOJm+hBvunsbie9MnO/kV9DDR5GxqdNQQ993wxFeQESrPw0QuoABDxOId2ZLw1+FJoLmtRd/vK4+PwMKI0sb2B338FHGTyQkk24nHSBE2D9nqO/71/mSh+c/jPvLG0Js4904aS7H5Bu/Z5YIwBh5nwloArJaLNHyeKYpPCbAavXx3W0nC6ljs9ooGb+ymHbfeygNQxJauA4wI2crEiBhsiuLveMlVRaPwZSRcv6tmhJmDsWobvru269fv+IHC8kMEbrzWLZWEG5JSSaZswfopn9uUTYcdiUgxdBKHEkCqc2woC2l0Ns49uwbnK7RmVVQ+4m0vm7uhvwSFD8mHoywfUeEq76xCaEsvjX1bXBvAVSnyCvFH/6fD+uzK0OIvK7A==
Received-SPF: pass client-ip=2a01:b747:3000:202::29;
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

From: Boden Randin <bodenrandin1@gmail.com>

whpx_get_registers_for_vmexit only refreshes GPRs, RIP and RFLAGS.

x86_update_hflags() depends on state not refreshed here, while the code
using the fast runtime state does not depend on the hflags it recomputes.

Signed-off-by: Boden Randin <bodenrandin1@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2f15d41747..478a890c9e 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -772,8 +772,6 @@ static void whpx_get_registers_for_vmexit(CPUState *cpu, WHPXStateLevel level)
     rflags_to_lflags(env);
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names_for_vmexit));
-
-    x86_update_hflags(env);
 }
 
 static void whpx_get_legacy_fp_registers(CPUState *cpu, WHPXStateLevel level)
-- 
2.54.0 (Apple Git-157)


