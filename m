Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E0DC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu4K7-0007Xl-P7; Wed, 12 Aug 2026 04:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wu4K6-0007XJ-2t
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:28:30 -0400
Received: from pv-2003e-snip6-4.eps.apple.com ([2a01:b747:3003:205::2d]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wu4K4-00052o-M4
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:28:29 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-10 (Postfix) with ESMTPS id
 9F905180096C; Wed, 12 Aug 2026 08:28:26 +0000 (UTC)
X-ICL-RepId: 019ff516-4a75-7650-9445-fd7ff87a1d22
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeSQ4dBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdD1oAQAFKC1wDRQBHC0kEQAFGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1786523307; x=1789115307;
 bh=IkhvoWWMz0utjxTwPeKdYrtgPwXhsLr2rZ70Y47kU7w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=GX4tBWKPZpYZeNLxWt4oraPYEA4bhSrl9u3mdUbr9DhuEN7giXtNI+K+FtIEyjt+pbyNZKLWhEcW9/+1n64rivdPzNHwCGn6sCeX6Lgkr/x90bs3U9xMVKo9s+qeOCNYJYiLJs2x6EwXSOMvANO4sbwCnCqGXY74HdpGqWx4izTmBhuq9qhTtKHInKST6Ic3sAEixlS0b9qrhD23osgMmChXNqmtVmtkpEJpnM+6DupxiovLsDLqMbmUyUh/RCmUJXbG43ah/Bx+/mLT0bEhbgFuvgdZ4/b1M+A2nle5wb07NDCobrpuB/i02wX2JqBDy1J1JqxAVuXDREP3gGOQ4g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-10 (Postfix) with ESMTPSA id
 273CC1800969; Wed, 12 Aug 2026 08:28:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 5/6] whpx: i386: work around Hyper-V FP state oddities
Date: Wed, 12 Aug 2026 10:28:13 +0200
Message-ID: <20260812082814.27217-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812082814.27217-1-mohamed@unpredictable.fr>
References: <20260812082814.27217-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX+A3KnhI6aR9E
 vRvZV+n66oflUNJ/05cwWWWQC6RIzR9PgIG/vQZ3VCPek2P1TZ/rHaVmFq7yI6JHtI38IQk6/2p
 V/kSYCwk/CILmv6j0Wxbm9kY3Ml6nkHt8gu9uP42fKeViblG4djE29vQ4/UW2fpku8xvZSQeACP
 3Q1mXnxPOQyuBk2z7jBAcxMTYxLWU48KHIBoH+OD371dJhyjOlvM1cZPiOTXg6UIa3VZ2pMM5Xv
 ax/VW0HIuFeax68fE4EaaCafYGUfCamIrvI/ysgfoqejjR6S/cMwZrrO1NnBfo900CDq9zjX4X1
 QDkwR2EuzVyuDY/pRAV/OfiQdYE6akNRPi5vKY6fs8kmVRU7BowkcCnobLpOwA=
X-Authority-Info-Out: v=2.4 cv=As3jHe9P c=1 sm=1 tr=0 ts=6a7c2eaa
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VRRVvkFWJP6kdw74u38A:9
X-Proofpoint-GUID: Tf0cm1y7ynXG9fLvM2jT0_W2lOp8PqYn
X-Proofpoint-ORIG-GUID: Tf0cm1y7ynXG9fLvM2jT0_W2lOp8PqYn
X-JNJ: AAAAAAABV85ziyyGK5TeqR+kHHPUMaN/VoORk0Uf2LBsVu7ERLLmVBKCqJuwe3AP+nFzadafVTs4CoDYFtc5lOH3LG8vqu7jUcn5Sb5i5wUGiRICpdJJQ1oWKcfB3UkMomnUMmLD3giBKcesc4cavgzKn+aKjDUHpMPD0Nomu0xbubSeX8lROgQ36K1DYR7rpM9qaoF+HLot33WnNCsOWcBPV1LUikKxsmgklxDGY71tpCpVr4gqvQ8suaYW8Upi599m9rflRazvPPSQeUmPSDyCU+phmN7ySG2F/K5pEwO3mf87KDJt+AkAylEQWMElnsgB8YcIhkhjauw6GV/cyoEVLEG9sosgFYld3mgyKXOTzs6HJohDj3CWXtJm7B8DQwfgUws2t73g5iVJxGqSJoq29+YHkxrwA3QFb0HayZWsW9JcIr2sCRmpERJAZTIf7Y99p+1pdLHdA/HaW//mHmH7kiFrEkct8LzpcWxzdvxfwH59E7+w3ZbSKDipSyVrvb81FN4xDyNK7YJ6iuwj+JvMENOQ7Dyb/a4dTyAtCRwzRo5takHUFqBaZDvEqc1q/6SBHOiCm7Gz8opMsrgDqAudYkFFHnlmP0g5qHr218xWcUYTSVUO9HbnVUU2jNTmo3cofLintMfC9jJGX2RRzVPHTza8eq/vOMzNfx3ZJo1Bk0pgX60gFZOzEFPNBn38foFPT3J/kKk21upL6GwRq1uR90kocgLzZ9PtzDwijPD4nLokJ8WeMCf0Qpg34w==
Received-SPF: pass client-ip=2a01:b747:3003:205::2d;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Hyper-V looks like we need to fetch both the legacy
and new state instead of being able to rely on xsave.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2739a80da3..56a8b16749 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -614,9 +614,9 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 
         if (whpx_is_xsave_enabled(cpu)) {
             whpx_set_xsave_state(cpu);
-        } else {
-            whpx_set_legacy_fp_registers(cpu, level);
         }
+        whpx_set_legacy_fp_registers(cpu, level);
+
         /* MSRs */
         assert(whpx_register_names[idx] == WHvX64RegisterEfer);
         vcxt.values[idx++].Reg64 = env->efer;
@@ -950,9 +950,8 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 
     if (whpx_is_xsave_enabled(cpu)) {
         whpx_get_xsave_state(cpu);
-    } else {
-        whpx_get_legacy_fp_registers(cpu, level);
     }
+    whpx_get_legacy_fp_registers(cpu, level);
 
     /* MSRs */
     assert(whpx_register_names[idx] == WHvX64RegisterEfer);
-- 
2.54.0 (Apple Git-156)


