Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00D7C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 04:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Lgd-0003mi-PV; Fri, 04 Sep 2026 00:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x2Lgc-0003mB-Ja
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 00:37:58 -0400
Received: from pv-2001d-snip6-5.eps.apple.com ([2a01:b747:3003:200::24]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x2Lgb-0003jZ-69
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 00:37:58 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id
 DBA551800218; Fri, 04 Sep 2026 04:37:53 +0000 (UTC)
X-ICL-RepId: 01a06ab5-7c26-72d5-bdf7-e240933981e5
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeSQ4dBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdDlsGQA1LBFkFRQtGD0kAQAJGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1788496676; x=1791088676;
 bh=t7Pug8Dj3tOCe5mrL4jAhj3bkg6X1ILJwVdzYu0j7Hg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=GW4azoCOP7gBa8cGKgX/Kd+doXh8UbbmeiWq8XkywXjjaFrR0xNph/4zw39svc1mStuPFcN2HEos6oDxRxoE1Qn0X9f6Ha2pa97aGWME7x8uS9Noot3cyCHnDZOW2HjPAsgJr0o+RynD9DwWgOi+4jA2+jBkbr+Qs6JtblNmCRGZeSeQZ+5minVD8TXsBN59EXu9KQtPYdJU2v6stc3xykUVYMCx1gVhQF2/JUFuCqywukcVjohJ/EfraboWPhdN9a0o6Twllz2zeqD+4QtKxBUkyhJjmGHXcUs5W0xWhmZwlPTISqEBMUs/GEDNEHiDZ0tzT2vzlRfmaYKd3A7IHA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id
 ED475180013D; Fri, 04 Sep 2026 04:37:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 4/5] hvf: arm: expose E2H0
Date: Fri,  4 Sep 2026 06:37:41 +0200
Message-ID: <20260904043742.96613-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260904043742.96613-1-mohamed@unpredictable.fr>
References: <20260904043742.96613-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfXzkzMF2MsnsvD
 /aALtgKzTdQ9sehhlAeWjevBJgavEqMxk0NSqqz9X65euT/+uwpw/EsfNPAIU8aHxjaS4vFzUaR
 0M9Z/1Z86XGY6JLdmLb8atDfCXJPfXYYIB1vqxEnxSvup0JePFg9a2xtNeZI226rLYZ1QIXeoNU
 za8c+hHeyIReseJUvSczqdoq5OEDxWAqHxAYhH1UVmByI/l0ttQTdc88QI1V1wWgRK9Juj7vsqD
 PshSfAiY8ZyIjpTxVJjiFJW339oWcADPSOQpGxf6GcCzp2Mj5MbwlDc/uBGtbP6dZb60HiHjk7P
 azYOZHn1WNhWW7Fb1zymGgoBpMrVSECcGdYFF6xiq2UrEl3q1vY20tyMVt9Cog=
X-Proofpoint-GUID: Pop-GMhWR_lDtM962gSgPqikFVYcqFrm
X-Authority-Info-Out: v=2.4 cv=JeGxbEKV c=1 sm=1 tr=0 ts=6a9a4b22
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QXQs0CC_ZiPkBA9Uy5oA:9
X-Proofpoint-ORIG-GUID: Pop-GMhWR_lDtM962gSgPqikFVYcqFrm
X-JNJ: AAAAAAABBL+oENo6sWrKbwezpabxPpgrzinJ7D6wzrgLQFxLwhxyvHDykBDPALFYebXnqidNU1H27u9V4fW1p0EUmzSKsLaSgS7DkJLP6RARk1WqWVpclWfzKVEUxXng65cukdYjlQjWaadn5Fl0yZuJLFxWvIQbdfAT/6hLMSh+PAVseH7ymYT+bewKz3u6RRiNeXsmsSDp6zEdJ9DWaPCfWmrrmnPxlEQo0qczBnqGJmjNrXT3S25hTjvXjN1AnUOaFSiGLxYOyZt5+lZsf1QpoPGaEk1rR76VCAzJbtHRDTrkNk+0GEFe8UhaaLkZroYhNTpTSbIY2br3aDV4wY4fzAlxMSH0PkhJKo8ZCdxP5FZw0RP/b+ixzgvV2XfPUyQjlhWhdlw9T0eIHzeNOjKzYJUZNhDSnE7YJeWfhCZ/HgWhrbg6/No8AkMokWXLw5s13+M5wLIrYQ8qGsPDcnMCWD+jfIfgdw4OQrYOAmwZxhXXuDegwelnOhk0fKgb4EpECmSAKzZihiRuW9AFBysHP1KNVVNpes91twGF5Kyb8OQrs1mNDym/UE+rYn+srh3w0PUtios3O5ye6dEmPWYUXKUlSin88GTO+SEukBOmeXw+FkvPRPgf8qpZI5W4metugU7fq3xz5Lnd06WMBUErdmiceePAtCLIET0WhLyDiO5CBYHYkg70NlAboiZxMp0VlnYOINUf8BAasgY3U+i0NRFfRHoHAwHgAL/7XcVjlZZOZShaWiPIsxO/K1xdITZijgm8fg==
Received-SPF: pass client-ip=2a01:b747:3003:200::24;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In the VHE mode, nVHE is not available. As such, only expose VHE.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c54a92c2aa..47eeaa0f30 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1285,6 +1285,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
         if (hvf_get_vhe()) {
             FIELD_DP64_IDREG(&host_isar, ID_AA64MMFR1, VH, 0x1);
+            FIELD_DP64_IDREG(&host_isar, ID_AA64MMFR4, E2H0, 0xf);
         }
         /* Hyper-V doesn't launch if EL3 isn't advertised. */
         FIELD_DP64_IDREG(&host_isar, ID_AA64PFR0, EL3, 0x1);
-- 
2.54.0 (Apple Git-156)


