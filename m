Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB089606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=CkfHUSiL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDRs-0005hV-EC; Sun, 08 Nov 2026 19:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRr-0005gt-0I
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:23 -0500
Received: from ci-2005b-snip6-2.eps.apple.com ([2a01:b747:3005:202::f]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRo-0006LL-4h
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:22 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 700F218007D8; Mon, 09 Nov 2026 00:41:15 +0000 (UTC)
X-ICL-RepId: 01a1bdc0-8d9c-785d-ad8b-147b07a3ac45
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtMHVUDRQtBF0AGTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0YZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXAEALTgJcB1ICQA1JA1UZUwdICUAeWBoGXRhYFVYJdx5cAEsdVwRUH1MSVR0dC0VVEgRACFZQVB5BBFYVbAlYBlMZVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794184876; x=1825720876;
 bh=4MtoiGWVHD1ql7ktrdOMb3tf+OVOyyTmcQKxYtuN+0U=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CkfHUSiL01XYvp6QGMipIp8NzM0Qm8gGdNybty55Goj8G0NqVrdeirYCvcgvco/PYCHTxOhYh4ngFuERcbsnzWgUKefL4DzsHeBLzIUh6vyj3BDo0NSmgvtyigiRRHt0+Nj/GGYkgOi75fp7aPJdRxOFUpX+4iHFONo9rYUp0fPEGQx2N81AH1T0KS4BH9Qx/8SCaEzPqh4BTmQGw5XALa4MQqK+3VuR9s86JPmZ2J0AVc1H+d/K0B21NztNMPoTI06wA6CcxgbpFmf96aV+isKRpVmokV5G/otaQda11KQ54zda4zsHVxG0N11C7iN3jr64aFSZFxrE/drZlvTZSg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 B123F18007F4; Mon, 09 Nov 2026 00:41:14 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org
Subject: [PULL 04/13] whpx: i386: fix TPR encodings for local APIC
Date: Sun,  8 Nov 2026 17:40:59 -0700
Message-ID: <20261109004108.85808-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109004108.85808-1-mohamed@unpredictable.fr>
References: <20261109004108.85808-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=UJLQ3Sfy c=1 sm=1 tr=0 ts=6af116ab
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YYz-tg3MKeN3tcD12NcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAwMSBTYWx0ZWRfX7aQ9h72C+yrV
 dxn2dEAskLGhikcch6pIzT7BxG9WOt6L8TsY7h122DmwwVf5jbbo41shv8eZA9xNHqk/rjPiqV5
 Ozg5Tge6r2sVwSYqNJusF0MJcAqE8IWWtkfzqyZK9pCzhwTKmbXxtqiGtMmId4gUn0HTNV1Hhy/
 FraoKf/eYUl80+Y+YAkOwnsp5r6NP9FjGVoWdxZCBjQm6FPgOv/0p19H4XbHTacLRzy2d3hDGhU
 iJp7OanHalvHtl2FTh8rleDm0a6XZfSjTfk0TkT+dyTemxL/J0QuZV96EuLkBVT36tIjEf5IO5h
 1UVy3XYbXCnaLz+ZuQBcs6fy8NLNJligWA0GnRUF9Iz/sBvh2jIH0YG8xM0spY=
X-Proofpoint-GUID: 3ZM-sBouDKnZjCNzVTgIcSCWnkRfcSBy
X-Proofpoint-ORIG-GUID: 3ZM-sBouDKnZjCNzVTgIcSCWnkRfcSBy
X-JNJ: AAAAAAAB6b2S1i9t86uGGP/ZZ6ewACoGyxYohZqO5I/jltjV3vmNU54n4XLca+eGq4MyqJ
 hm4O9sHRJYeteDbCH67gWwAwjjNiaXeGAWdJo75naMBgmuosJrpMRRp1BWmSKnCNX7+ZTc
 5MP2q1WPUCvkm8LLlhvJtlwklKUWX41jf2O1Pyn65S6tTartQCtdCvud/mB579Q9dbTMpc
 8JJgLt9qlml5OjgVvZtSIqT/CTufOXdaYtLacANU0AJIA4GMK/hlo4pTvCfjM26NaRTMG+
 hexQj68x/t/LraOifNUgQKgnmZxxL5/+Tjdb4TaYO1pGV+EY0+Jr5MwESK8MiuK9fraPco
 s1kvY3gdmI3YT3X1u7Fg3RMP4vbI5jV7VssuqukCwF6U+UC6AdLHut+sHkTwzZ3baykJmu
 p4yG0TAXQCCRQ+nnB2Jdjq2KzfJme7lXL7YP8e8a2s1hLCbmsM1/5xUlL9JTaZIuMX0VSG
 7K0+9L2O1g2pKlSD7yJUrlGJXOn6B+I8COiVRt7dK0bGMCSsK7dGqss4J/zzrY8GBZgqeL
 jjcf+abB9pKEopfiVdSjVk9Ut5sSHmlmC6uFZjG2F/o8VFFt3QeR0a0i+n8U18NPf+hEmo
 13SHozabh7QNCV+18LvrXxT3iwvCdOzVkWTrjCONqFYSlWIVWDl7FR+lrVwD0huaxZzVrS
 HWJxfVa2nZIb4vT4cVu6n4UNki6d6TbQRAajbbu/ejXGIT073O3aRERqUrkO9EcAKVMHOF
 fDUYAs2eGHuQ2aQUJ2zAiFptq/RdR+c8Ki7vu42u+22RO1F4cDC7/5ehloyA==
Received-SPF: pass client-ip=2a01:b747:3005:202::f;
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

Convert between the TPR and the APIC priority encodings.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-apic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index efdedbcd77..2d83291fae 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -184,12 +184,12 @@ static void whpx_put_apic_base(CPUState *cpu, uint64_t val)
 
 static void whpx_apic_set_tpr(APICCommonState *s, uint8_t val)
 {
-    s->tpr = val;
+    s->tpr = (val & APIC_PR_SUB_CLASS) << APIC_PR_CLASS_SHIFT;
 }
 
 static uint8_t whpx_apic_get_tpr(APICCommonState *s)
 {
-    return s->tpr;
+    return s->tpr >> APIC_PR_CLASS_SHIFT;
 }
 
 static void whpx_apic_vapic_base_update(APICCommonState *s)
-- 
2.54.0 (Apple Git-157)


