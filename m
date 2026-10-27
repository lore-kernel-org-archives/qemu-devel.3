Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B842A606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Z4WXd3Vq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjZH-00016a-VI; Tue, 27 Oct 2026 11:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYm-0000uh-5D
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:02 -0400
Received: from ci-2002h-snip6-11.eps.apple.com ([2a01:b747:3005:206::53]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYg-0005l0-4G
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:57:56 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 609BA18004B1; Tue, 27 Oct 2026 15:57:48 +0000 (UTC)
X-ICL-RepId: 01a17e15-019c-763d-858f-53626f374aae
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQAJGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116669; x=1824652669;
 bh=4MtoiGWVHD1ql7ktrdOMb3tf+OVOyyTmcQKxYtuN+0U=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Z4WXd3VqyhG44C0AU9FT5jRhHKauLezWTBKaMQFaRjXr9yG+4Hf8kxvryPueCTv8jWXcsXje2IFAjcZklhwi1FatlUht5rqS0LnXN6s7WTtixZkUc7ZK/EsYmJjmwl48UnZxkJerRAlsjoCi7c3uIby71NMTDeUS7ycojnTIK19t9u3xpUs1uI0LUntF7MIlR6mb3avk3fKe6E0Qx3k9SbbwzFtfroMmbhsjnKeVSDqrJKEd2AXy1lhKtMASebfd3Lrlb3DN7L3+Kh/GMFhFKL5hT+gl8JfEPwyUAKFLEFy1/Q1OFIKEkdwyQIgwCK04DWdRuMwR3nEolpeFnBouZA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 A2AD51800154; Tue, 27 Oct 2026 15:57:46 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 04/18] whpx: i386: fix TPR encodings for local APIC
Date: Tue, 27 Oct 2026 16:57:23 +0100
Message-ID: <20261027155737.59271-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kHXXs4L7hxYKj7V22bnhwO9oPxlYNbVr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfXz+E5sithxcKX
 tAQNj/pNKQBvGx4Xlw9yos5dmWtW/AB/0H+PD1opUBhzuVfByocfu+TgNzV5aHAaUx4SNluqlqX
 wLCbI1aIIQftghtNQvsYFcYUtTgbuPl4/8ETIQY5lx//hHoih0kKNEuDfDejb13SdIGmdBqryN3
 g5zeVyQYhVuiLKblq0IYzPMVf/wswVDwJE0iACV73ybJoiyiSCU/WkJnBMi6Yas3xfM3UIWdWXG
 o0c1w2lTD1ngM3rGfQrKZ0s9UPivCXbCPnpWwCGsiU8EAZsMvW8ARffYQksXXXDBrxv1QGaK65w
 CPuvEg9qaVDC6ePlphrFm2OTwzdnmVvliI699KGsj6eTm+V7l0CEDcumrrX/2E=
X-Authority-Info-Out: v=2.4 cv=e8ALiKp/ c=1 sm=1 tr=0 ts=6ae0c9fc
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YYz-tg3MKeN3tcD12NcA:9
X-Proofpoint-ORIG-GUID: kHXXs4L7hxYKj7V22bnhwO9oPxlYNbVr
X-JNJ: AAAAAAAByY32XFyY9/e5TZCrH1mU54CkNwcShw64FD2YEdnEeteKW7nl27aZhcLRerItU3hIpydvRS+51eM5uPvCQZa16QpRwO6zjGJSenAumTCB6W47x5Xa62CkepE5ukpXBLEkiQeKtKcnlbPzF/K4zAErJvHiygqMOXNxaBVNUI6Ap3cbbUqExIxuZtpNHyr9i2TFNDCEFRLMKTjM9GTwSgwW+wBW9cw76QTkTsetW+Ylem+9X5XOOalwVxvqF3FAVemqsh2iV8YY7phktPAwXIw+0tu6HKYYat2mB9LH1HG8GrhZfgNWYgo+Meiyva60vgEnHZJ++uewbk97mT2aDa7Q9c+cA9tjtYUzFltiDChHbnhupqMVWoGzM/tWXUIRuNNOGRr5eRiHdlodaUJcMuUpEPNHm/cFSRI2gzW87kQfD2tmCoDGkDRJcvph8ybDr3bNrvwLqYwp6q8AWPxDgzUPvAtDGtDw6xJHUXI8F7Y1wtEWPYv2+POg+UGeABSxCW/Po4rfEGsbjz/STv1ivIqHhvngOpZbr3C8x/Pxsf8aQA4sHeV8BUj/1fP6sficrjZPBIvA+7HzoCz5YhPH/NEA59Zh3FoBnGhEov7e34wL/vZwUmNB/YPLiv+AuF5f2NnUnJjXnEWi7ap/1r4IED8lE7uLYil43QYQAnmhJG0rN0+nOo//r2ippNlJ5JB4ZTAw3ACIkSyk9ygt0wkFeNtxL6KBt/BBsUED3WQJVU8JKkwd8QPFRcW6t/FSIz0V2sqkc2yHaxacjhSnt8vVks20EfcY5yaiv2Fq7F4Szoh8KhITdT6M3DO+fNw=
Received-SPF: pass client-ip=2a01:b747:3005:206::53;
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


