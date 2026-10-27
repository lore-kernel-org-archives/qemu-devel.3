Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82162606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=IVT3nvz/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLja6-0002YL-Hg; Tue, 27 Oct 2026 11:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYp-0000vV-1t
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:03 -0400
Received: from ci-2002g-snip6-2.eps.apple.com ([2a01:b747:3005:206::41]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYl-0005m2-Tp
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:02 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 06CF31800126; Tue, 27 Oct 2026 15:57:53 +0000 (UTC)
X-ICL-RepId: 01a17e15-1787-7794-9fba-fac826f398f9
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQA5GXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116676; x=1824652676;
 bh=QOLN4jsgU5ykGjhhvP9Y1hwC6rgQKrTieY+QThdsfNY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=IVT3nvz/PLjuL/PrxVsmp4qh3QPN1iyOhBz0i5XXA8LPAgK820G/thQIWWCfmkRVRJJIrA9gxThcs/5pOEnpAx0MwcKgx6P4KVAVBP5/+2RSJh1jUAq2vmU3iHecl2V2973ByDZNLxIZfPwtFGdk5CP+HOE9O0iDF/yfs20ytmYKXXr2hJfwwMPbnna6OIngP7021XVGnMO/9UaV035HsrMhbOn9kMDjcQMRkr9sDy5FpAq3QIk8iZejTIKu00e4IuVJeEpdwMvzqoVYfp6M6/W9hRSOHWsQkGQRFAHa5lMtZlxJdBp6+IGe34LGmzkDnkptIVGz6A3ZJx+eeFEiuA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 455391800135; Tue, 27 Oct 2026 15:57:52 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Boden Randin <bodenrandin1@gmail.com>
Subject: [PATCH v2 08/18] whpx: i386: avoid updating hflags for vmexits
Date: Tue, 27 Oct 2026 16:57:27 +0100
Message-ID: <20261027155737.59271-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8RuEgx-vYND5BY6BLuWWROt0a8shESkx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfX95yOUFUsaRXR
 070R9dxf1t9S4VCXsYk5K0YEYbj6OJJgLyzgBLXC/lZPZdt46m3vEZIJruCRo2mz6alT9ltL+fP
 65S3oZGjTszxGScUwZ2BIw/4lxsgd8K7tiSxuK//c9AkNQQRQ2NKUDK1oNhXoRs9HMff4gM7QL/
 +gStv6J9pwfyuR9tEsP/5Mot9VMJT6lRvSBXPu0lgZ3CGd6biXf+vQ30UacfWt13gQ6cMwoh4K8
 nNU6BFjX67V7y0xoP8VWoNo+NwgAyrE/MqUFPZNkXvEw6z/cnHGYKYCmPkvDHEKfDYV597zmfN3
 KBPP1qQM8VUNMI3bWsyWEA2/4vZfzD3zLY8MteXqR9hDPRHEMVBsA9axAmsDe0=
X-Authority-Info-Out: v=2.4 cv=KNxXzVFo c=1 sm=1 tr=0 ts=6ae0ca02
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=JvUqhf-O7Ua7-JxK32kA:9
X-Proofpoint-GUID: 8RuEgx-vYND5BY6BLuWWROt0a8shESkx
X-JNJ: AAAAAAABDHqtukaKIWf1iQylq853gP+9CI/3ZI0kiFUy2AG4ds1U4Kln3Sq2bzdANqmr96W2ragPArocj0PGaJx17iGw0nsXqiRqmDRnNYBPmsKgBrnu7WHSSXePt/hSwrYzbCLIiHE5clTs1Pk4T6DD/YbGJYTxC88rNZBEnn2nd8voKE+oQABKpar4o40XlbrEqbPk8Gc8QEQvPHGAtP5Aaz002dzeKGMhfeOyLkMKQGKG7g2LBzZgrsWeYE1P/LqcnWfqPpnsoTKnplyx10UWaAmLdX1w1xp08TrPs6K1urG1Mva34HpMl3fpA9QbzKh73SbOJ1OVwo926Yt4lwDkj910ipxWX3WKrMNUZgIWAJvmudfhkUcEkgEzbSzM9dUlsG6JvFeAf5+NNgZsegXS7hJVhC1+M5vt04EnnBRRo73UueTZIqKaDjtgEbPgbnIwUnUwHQlm2kzt/XmBlEcbwjolLIqK+RKjfZSVNLjUh/6PYvdhJwIB9WAKDiFwfjC0XxozGtLtkigzdPHyjDRqFtSFr7MQapk7td8k7MbAcyr19aWyRfmVKW9vV1iQEHWK/nWaK/voFrjdMa8r1HtHTfxulX4cdxWZMD/95XipAD466b+zwYczjW3UbRBX5UtE9J6aHygipN7ecB5xSjhCgDKk9Zv1xjvxgLHQ/bVS114xlAEbQuYrwqUMjMxLMlioIekyOI99IygY/bNpl8vcdcclIycHaLKcgxyCuoo3TOMPLajtcd00tChuOIc6REXHhApRYdGLTNkH6PZF2Cxx0O+RxrCNmZuFZlZ3UjLF4GQqFtURYCFVce07uZShxXCTj7HFbuArTE9Fdq/V84LkI3dq
Received-SPF: pass client-ip=2a01:b747:3005:206::41;
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
index 5f14564f10..29a630b03c 100644
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


