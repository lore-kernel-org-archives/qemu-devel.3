Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3686CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPMRs-0008U2-AG; Tue, 19 May 2026 11:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>) id 1wPMRc-0008OA-Gv
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:33:25 -0400
Received: from mail-07.mail-europe.com ([188.165.51.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>) id 1wPMRY-0002ft-BG
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779204791; x=1779463991;
 bh=W+BGqpzXNd9QawnVgBG/CnE2Yr1j4Ig9F9/QpkEif4g=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=dJU/6pxGWp+BKMUdcuOnHq4/iC4hKLa/1wvdtyiYklA0cgCma5XwBayhatBoIeCnR
 YK9toYw7iPG1bEpvOoQfWn2HKoA7mQUcuTNtCGPcE7QkC/n3cEkbZoxeY2pubACZCT
 ZS7on4epxJae5cTR5/LfhQpV8EbXgFT3wYFjsrojtRsoT4sVl1hBLsv6hqWP/pAyhZ
 vIjGbn7tqJv5RACqjHDcakeW+7qcUoYGHkGr2qM7+hzSLrytZmtUGRRvG59kay0W9R
 EymGLYQBhE9wvcFoUXsnCi90D0gZ1eMX3Aj6iE4jRULkzy3UxAfY8KZVzRqkRgl+BA
 SWvX3oGMkhMRg==
Date: Tue, 19 May 2026 15:33:09 +0000
To: Peter Maydell <peter.maydell@linaro.org>
From: Jason Wright <wrigjl@proton.me>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/arm: advertise FEAT_RNG_TRAP on cortex-max
Message-ID: <20260519153249.31100-3-wrigjl@proton.me>
In-Reply-To: <20260519153249.31100-1-wrigjl@proton.me>
References: <20260519153249.31100-1-wrigjl@proton.me>
Feedback-ID: 198029889:user:proton
X-Pm-Message-ID: 2c4eb3eadc1cd6e18bda07b73588ceb45150b5c5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=188.165.51.139; envelope-from=wrigjl@proton.me;
 helo=mail-07.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Set ID_AA64PFR1.RNDR_TRAP=3D1 on the max CPU model so guests and
firmware detect FEAT_RNG_TRAP, per the Arm Architecture Reference
Manual for A-profile architecture (DDI 0487).

Signed-off-by: Jason Wright <wrigjl@proton.me>
---
 target/arm/tcg/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 649d854a65..8caa06ecb7 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1291,6 +1291,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t =3D FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t =3D FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     t =3D FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
+    t =3D FIELD_DP64(t, ID_AA64PFR1, RNDR_TRAP, 1); /* FEAT_RNG_TRAP */
     SET_IDREG(isar, ID_AA64PFR1, t);
=20
     t =3D GET_IDREG(isar, ID_AA64MMFR0);
--=20
2.50.1 (Apple Git-155)



