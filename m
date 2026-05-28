Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BF6CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 18:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSfKY-0005Zp-Tn; Thu, 28 May 2026 14:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>)
 id 1wSfKV-0005ZK-Hf; Thu, 28 May 2026 14:19:39 -0400
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>)
 id 1wSfKT-0001oa-1b; Thu, 28 May 2026 14:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779992358; x=1780251558;
 bh=0XRrMMsoQ7XtXJbVNGOtDxDGyvg6qTnfFZE016ZhZWQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=iZYUsyCTrilRGIXdcr6sBewoqerFZO9+LivTct1V84HSz5V6KWBzM7xzusLWrlgtX
 oP6Tp1bHcyKNAXPA88yISzKpFEuUiPrHZ/QgOCrZgo4UfW1docN7Z1rSE32Lu4ZlZY
 aJyjpTifkiRg+dn3M4dCDH+sFgjUnweBfwgGtJf5JW8ySmuYvJt1d79ekiEldjI3yr
 R8ru6SR1wOfoUNXyrw/hAgvb0zAYLylZlJNbBAuj/tEISmyZx+uSLzk0cNoMvToL5G
 sfPeSpks/ORaFqWHZ0cAll8GzXFaQOuMTpSqwma2zQKJl76ABZ5kjxqloML6teh2Sj
 5JjJBUaPJu0Cw==
Date: Thu, 28 May 2026 18:19:14 +0000
To: peter.maydell@linaro.org
From: Jason Wright <wrigjl@proton.me>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org
Subject: [PATCH v3 0/2] target/arm: implement FEAT_RNG_TRAP
Message-ID: <20260528181857.92087-1-wrigjl@proton.me>
In-Reply-To: <20260524002617.69593-1-wrigjl@proton.me>
References: <20260519153249.31100-1-wrigjl@proton.me>
 <20260524002617.69593-1-wrigjl@proton.me>
Feedback-ID: 198029889:user:proton
X-Pm-Message-ID: b7005035ebe28bf6102c8ee8c08727d9389abdc4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.206.169; envelope-from=wrigjl@proton.me;
 helo=mail-05.mail-europe.com
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

Implement FEAT_RNG_TRAP for RNDR/RNDRRS and enable it on cortex-max.

v3:
  - helper.c: give ID_AA64ISAR0_EL1 a readfn so that ID_AA64ISAR0_EL1.RNDR
    reads as 1 whenever SCR_EL3.TRNDR is set, regardless of whether
    FEAT_RNG is implemented (Peter Maydell)
  - cpu64.c: keep the ID_AA64PFR1 fields in register bit-field order;
    RNDR_TRAP now sits after SME and before CSV2_FRAC (Peter Maydell)
  - docs: list FEAT_RNG_TRAP in docs/system/arm/emulation.rst (Peter
    Maydell)

v2:
  - access_rndr: return CP_ACCESS_UNDEFINED when FEAT_RNG_TRAP is
    present but FEAT_RNG is not and the trap is disabled (Richard
    Henderson)
  - Register rndr_reginfo when either FEAT_RNG or FEAT_RNG_TRAP is
    implemented, not only FEAT_RNG (Richard Henderson)
  - Fix document number typo in Patch 1 commit message

Jason Wright (2):
  target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS
  target/arm: advertise FEAT_RNG_TRAP on cortex-max

 docs/system/arm/emulation.rst |  1 +
 target/arm/cpu-features.h     |  5 +++
 target/arm/helper.c           | 58 ++++++++++++++++++++++++++++++++---
 target/arm/tcg/cpu64.c        |  1 +
 4 files changed, 60 insertions(+), 5 deletions(-)

--=20
2.50.1 (Apple Git-155)



