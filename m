Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542C5606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=bO52jyDg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDSK-0005ug-Jb; Sun, 08 Nov 2026 19:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRv-0005jh-QV
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:27 -0500
Received: from ci-2003e-snip6-10.eps.apple.com ([2a01:b747:3005:200::34]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRr-0006MP-LU
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:26 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 56386180010F; Mon, 09 Nov 2026 00:41:17 +0000 (UTC)
X-ICL-RepId: 01a1bdc0-94f0-7d9b-9534-7ad2a988e152
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtMHVUDRQtBF0AGTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0cZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXAEALTgJcB1ICQA1JA1UZUwdICUAeVRoGXRhYFVYJdx5cAEsdVwRUH1MSVR0dC0VVEgRACFZQVB5BBFYVbAlYBlMZVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794184878; x=1825720878;
 bh=msvtbRnkNcds4kjimnMrSS+ln0rONrR/84Sl5Z/Nyh8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bO52jyDg8Qs4x1JPpbdTuWLZPmkSxOUGgZjNMI7RjTLx1zzC7sB0B2Xz7Kf866Tswzjdu4KffbgbhQU7p0eopPzYFYV/iCX0xrk7UF8aY5g8WTxWBtu4pDPc1K1QIKgiLVKctXcCpJ0dTN9wslMpFTU3tJTqecuM0F6iLp+CiyegzkYdIzohsiEWIcqG3nyfBrBDU/9rf9TYXS3ZMzjfHToTWLT+yJUYaUv7XWcDNGt9ZYMNe5c7wjCZFCVULdo1T8Qrfc6l/277YrkRc9oZ3St0pPmd2L1IPzXJ0fMZqySvNSA1GIEPX/rR6rAZEPWrt/HQvrlukXi1hfMKgj8oCQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 655E318007C0; Mon, 09 Nov 2026 00:41:16 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Boden Randin <bodenrandin1@gmail.com>
Subject: [PULL 07/13] whpx: i386: avoid updating hflags for vmexits
Date: Sun,  8 Nov 2026 17:41:02 -0700
Message-ID: <20261109004108.85808-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109004108.85808-1-mohamed@unpredictable.fr>
References: <20261109004108.85808-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4ltYpodwaV1Y7shP9F1xAIpgHuDKA8n-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAwMSBTYWx0ZWRfX29ku8tMcGuZd
 9+L3ONFgPEeX7g3LyC+S9TYelJ3Fq2nhcKLLiigbsPxQbiw8c9V0toq9EyXZ9WXb8ilSHTPA7tS
 Z5QL2sCx0SG2FCCqQgXsvseAvQjW5VlxU0jezg7NB7Zkex+G1c2DO7+6u8RpWhRPFEJDjUsp5mO
 MT8sM/M9WsLikEPSyHgk6gelwipRVXU870XPIe3i7brESt2v3s6jAPYMIRv6Q+uULG2k8iVwBqJ
 C5DAe6WucumWQJCXpWho9igy0tzK8E0wUl0F4TYOwxD4I3koocIB3jM4MQRjZno4UjR46TEpDSl
 qVM+upNencx6lE0WkxGFJtVIY95Smj5dIbeY11gn9perc8vjNIBZizTbGOs0nY=
X-Authority-Info-Out: v=2.4 cv=X5Zf6WTe c=1 sm=1 tr=0 ts=6af116ad
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=XFq3rTXSGl1-eYzejacA:9
X-Proofpoint-ORIG-GUID: 4ltYpodwaV1Y7shP9F1xAIpgHuDKA8n-
X-JNJ: AAAAAAABPH02SL0Xahkvci3GYjjO9SyzWHNvoFk/qY3ZOSpcLQIqBY2+6CQ1ykQwYizJO9
 K80D/msVp6KDk5vEHxbMVbjGFYNhiCjDMnqPaLIXtRG//60RZ5WAuim4sCy6h62GtgpFbG
 X/FUdmb1AGtHQwDg7uneit55eObco7wnSSLAJEfQNSNOnq7OL1ev95k40D+hCUxRbFEq/5
 I07jV029NKCSNLjDEU9KCePMYtMDNEAaqtXw1ih7JbAw1mO1BC2SfzbLFZWKoyt4nr6nyc
 kEb3P3GvfUjuEewnGdwpKNWujXueg9THqED1LmApFyYuzSjFTX5ZXXSNllFKQr/Cc/jkNU
 zZea+zQMoNx7ATz7V/mUV8qO3hBT2zS7xzpuxRbtkiajN4Ydcq9xosSLe+UKhJmE9fQK1n
 tfMpI/qHrMufOfaFp+DqMetthRr5s725WQPSMMTJ4wRnoy+G+wy2JGCowqvu/p7QEG6PsA
 JPwoepBuI3S1z0B55Mt+0hG3TRKbBHhFaSNl2hyR30lciEnn3c0+5cfdeGqXExstw97N6m
 atY/l9g9gPt5vbR/VnoJF+XLIHt7D2rI4BkezHEiArMF3VW0DH77Wa2xgXSwqPddPTpI1L
 kTwn5F/mgzSE8ZvLa9+hapXqhIbydnpy3KTJ+oWVkcCRBwLa39a+xjf3HgKltdn0//mBh/
 rf/S0WqSwQ13VhKRjYME5ojv0iN+nqc/4Bbs7HdpVkuAjSB/PIOUIhwGno6jsE2T6HK23E
 tOk4gjSWFbKF7L4yvhOg6px9H6NbW66BBMPSMDFYPvEvh/6rk62wL501YZGeJcp/Qb8AMx
 79dLqVc4Y39zN7HBwvtU8gwYOxe3AFwpEg==
Received-SPF: pass client-ip=2a01:b747:3005:200::34;
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

From: Boden Randin <bodenrandin1@gmail.com>

whpx_get_registers_for_vmexit only refreshes GPRs, RIP and RFLAGS.

x86_update_hflags() depends on state not refreshed here, while the code
using the fast runtime state does not depend on the hflags it recomputes.

Signed-off-by: Boden Randin <bodenrandin1@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 7e418f1c91..8807a7b95f 100644
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


