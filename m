Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A63CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 18:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSfKa-0005bD-Cs; Thu, 28 May 2026 14:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>) id 1wSfKW-0005Zl-Tb
 for qemu-devel@nongnu.org; Thu, 28 May 2026 14:19:41 -0400
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>) id 1wSfKU-0001sM-Iw
 for qemu-devel@nongnu.org; Thu, 28 May 2026 14:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=wxejefidabatxfx55bdynfwede.protonmail; t=1779992372; x=1780251572;
 bh=EsEjBe+Uo221kUJngYwBd24gAWSBdnMCEUvdozcNXxA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=dw4iRpZtYsY3RnJCTpBqsqf5MgwuWakVFhnY6cVz8IRgk9YfOdmudcJguwJjNdR2l
 O5qLOnVMonBFeiBnkv6sJzd4gSsfYxorGWc5sKh27IGu7p48wS6PM1jNQRub1ytiGN
 v4ojP2E9oqGpzyD3tpF/aywykKwDzRTQlEKwFTLz9XkuTr0L45jVQZc3iUospvwzbY
 zdggJy4U5OQ/7YWf30ToayfLYXhKFAB8+06svJidJQgZqYIGkmBrNUMm7aYNfM0BX2
 tTDxA/Aq01mHPsXIstMOqqfj6IShdDZM2aZ3GaoMiXywU2Zx4VP8bSnlcT7Ol8YNPv
 jTD2DabDvbQ0A==
Date: Thu, 28 May 2026 18:19:25 +0000
To: peter.maydell@linaro.org
From: Jason Wright <wrigjl@proton.me>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org
Subject: [PATCH v3 2/2] target/arm: advertise FEAT_RNG_TRAP on cortex-max
Message-ID: <20260528181857.92087-3-wrigjl@proton.me>
In-Reply-To: <20260528181857.92087-1-wrigjl@proton.me>
References: <20260519153249.31100-1-wrigjl@proton.me>
 <20260524002617.69593-1-wrigjl@proton.me>
 <20260528181857.92087-1-wrigjl@proton.me>
Feedback-ID: 198029889:user:proton
X-Pm-Message-ID: 40075adcd0e13d2f878c9bd9c7baeb83e242334c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=57.129.93.249; envelope-from=wrigjl@proton.me;
 helo=mail-08.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Set ID_AA64PFR1.RNDR_TRAP=3D1 on the max CPU model so guests and
firmware detect FEAT_RNG_TRAP, per the Arm Architecture Reference
Manual for A-profile architecture (DDI 0487), and document the feature
as emulated in docs/system/arm/emulation.rst.

Signed-off-by: Jason Wright <wrigjl@proton.me>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index e44b3016be..9ccc20b696 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -135,6 +135,7 @@ the following architecture extensions:
 - FEAT_RME (Realm Management Extension) (NB: support status in QEMU is exp=
erimental)
 - FEAT_RME_GPC2 (RME Granule Protection Check 2 Extension)
 - FEAT_RNG (Random number generator)
+- FEAT_RNG_TRAP (Trapping support for RNDR/RNDRRS)
 - FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
 - FEAT_S1PIE (Stage 1 permission indirections)
 - FEAT_S2PIE (Stage 2 permission indirections)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index a377f67b9c..6d82139015 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1292,6 +1292,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t =3D FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* FEAT_MTE3 */
     t =3D FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* FEAT_RASv1p1 + FEAT=
_DoubleFault */
     t =3D FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
+    t =3D FIELD_DP64(t, ID_AA64PFR1, RNDR_TRAP, 1); /* FEAT_RNG_TRAP */
     t =3D FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t =3D FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     t =3D FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
--=20
2.50.1 (Apple Git-155)



