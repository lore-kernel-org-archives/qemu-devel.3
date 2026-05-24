Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BC8CD5BB8
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 00:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQwg3-0006UH-OT; Sat, 23 May 2026 20:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>) id 1wQwg1-0006Ts-59
 for qemu-devel@nongnu.org; Sat, 23 May 2026 20:26:45 -0400
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>) id 1wQwfy-0001xo-CE
 for qemu-devel@nongnu.org; Sat, 23 May 2026 20:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779582397; x=1779841597;
 bh=OjNlwpgJbL8+7DZZD4P0HhXaN+u/Jqa0DCpKw5vUkEw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=eIRRQMohn7suEza9/F4AEwNt4hAc5uuMa7I29jHNTD6D91OKLip2AoZKZvfubyBBM
 KiwOm2JwBeHCLBnHxuZhkbiUoJqfGseMYbs1H0xbcfS/nsn1EmzBEQ24Gt1JSvqKFs
 yeTTpaTVcsI8kzViCYyfw1G01KESxCCF2qp+locpOgpCkYR4YwZTHAscerB/5PzH/g
 VRCS7e65US0nZ8yYo9wBvHEJ0ZmUDX6Uwgb7zXwlwe+jnwdexV4kM0O2oPACauTMbK
 1qTK7zT8WnkMGuTl9eyVfJ//lPW/VUmk9Ns/zFDClLxqdResyleyZ6IpmQtXu7BQXH
 RSPgQ1POSoURA==
Date: Sun, 24 May 2026 00:26:32 +0000
To: peter.maydell@linaro.org
From: Jason Wright <wrigjl@proton.me>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org
Subject: [PATCH v2 0/2] target/arm: implement FEAT_RNG_TRAP
Message-ID: <20260524002617.69593-1-wrigjl@proton.me>
In-Reply-To: <20260519153249.31100-1-wrigjl@proton.me>
References: <20260519153249.31100-1-wrigjl@proton.me>
Feedback-ID: 198029889:user:proton
X-Pm-Message-ID: 39347b23010b8a2a320e0e778ed292660f06d2dd
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

Implement FEAT_RNG_TRAP for RNDR/RNDRRS and enable it on cortex-max.

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

 target/arm/cpu-features.h |  5 +++++
 target/arm/helper.c       | 26 +++++++++++++++++++++++---
 target/arm/tcg/cpu64.c    |  1 +
 3 files changed, 29 insertions(+), 3 deletions(-)

--=20
2.50.1 (Apple Git-155)



