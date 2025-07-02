Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C65C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwTu-0004px-4I; Wed, 02 Jul 2025 08:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwTr-0004pG-KR
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:27 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwTk-0007Bu-NS
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:27 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2e9071e3706so2767422fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751458936; x=1752063736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ySkdVJ0hHGep9Ajf3QmKn3ttpJmzhhtBTQDGQch3lt8=;
 b=B4TD5wxx7ZNIV4vSCaUXAqF4xljbPGqJOdRHt4K2/89uItc6wISjQIyUhkpPo2bvCg
 uDF3nAe4S4TtxW2fj4Ppk2xYEPAZHEgot2IZvCT1dlIDmdAZf7IGkK60z9VbG2Htsmit
 uqU/l4onA/cBUbFi0RMcOSflcN4a84LqE7Gwgx+kjmD3gCvLqEHbO6YHxdjdm8v9nnyH
 Jvhh+Oo1zyHzpn/ftbiuOCgukduv9+ChvYFLJq21lQ2SFXpWFHehayfUWBfUbxG8zjE7
 nUJaCFHj8Yg7tvLNx9dgoFuzYZk9n41iPY/MXM841Q/f8/+3b9IN5lcRYUmE7LFxAOiv
 IIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751458936; x=1752063736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ySkdVJ0hHGep9Ajf3QmKn3ttpJmzhhtBTQDGQch3lt8=;
 b=XWSRv6gvjEdCBBlwK6oF/FQ5ERD+tLoySrtqpMrKopqBr8288TXlyVWyI8dP86cSBo
 ML7whIZB+hpJheNErorMUymTWIbvb7Py38wvSzBPjCdGvi/pvgOwLZnc0r4D+AJOopRg
 fqA0gi3Vlsf9GxDcQs8R10rLe3BKwoTKnZcVdstw4lN2j954i/+d/Qka+gMHUE+FWYnD
 p+BQ8i9miXTjDpQOUpctWF2HJ0BtaG1vQr7bPtcpEcR4WNy3A8jkqX9hG/gvgYx03vK7
 0vRdDJod3AGS2OV3kqGudK2ZLtPcQL8hOTCvep7X5s5qXAMU7g22nBAwjX6G0e49XMEX
 FXgA==
X-Gm-Message-State: AOJu0Yz76ckCTYG/SfEVXKQIxd8kYRSZfLvjnnHTeOH0lLywZFPduzF6
 srLcx3ilZdlPGynXOVW8Nmk/NR0fRMNDFdDoN4af7Va0WhbE5BGnYc9RBAje2gmc+46h8YCOakP
 fIguUVwk=
X-Gm-Gg: ASbGncsoeTDZJ3SN3uRqntt029lu3Ee/dJPNZv9lkExo+XO+ClydYMPRuwTwJiT+4dV
 d3wg4LlWxy5xEdmfutZJUap93RitEBhYn/MoyRqYTqgzNq3uxgW4Z1UqFUH0ujSAI7GDDiEYo1l
 PD52DIDPBQNm9KNxIgK6iQpv87HUBzfVu/wBgsZM27R2MMtPq+ITY00cyOmZxR8YDGOXA6LL+qL
 YFr77MXo387owDZaQXYf0ZHxX7MQYDpfTx9821ly8RSgNo8HdDha/df9fkvfW1m8SLM1RZ/m6m3
 p142tEmG6wF2Cp3sH5sjHf+1MrTlSCSqsJPKKYYRLa7LuT+RNDUWMQPsY2znLgLxWrUPew==
X-Google-Smtp-Source: AGHT+IEZxFngmDku5hEu8CGTUHkN8aPT9PnYqd07ZjoVNr57Izz51FmTkUDaRiHiKvrFHcY4iG4hFQ==
X-Received: by 2002:a05:6870:524:b0:2e9:93c6:6e4a with SMTP id
 586e51a60fabf-2f5c79fd99emr1922933fac.38.1751458935766; 
 Wed, 02 Jul 2025 05:22:15 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1bd3sm3785013fac.28.2025.07.02.05.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:22:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 00/10] target/arm: SME1/SVE2 fixes
Date: Wed,  2 Jul 2025 06:22:03 -0600
Message-ID: <20250702122213.758588-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

- A couple of fixes for EC_SMETRAP, plus some insns that missed
  being updated for non-streaming.
  (Removed the switch (bool) that PMM commented on, and as it
  turns out our clang CI Werrors on; now perhaps clearer using
  if + goto, where the label name helps clarify things.)
- Disable FEAT_F64MM if the command-line sve vector size cannot
  support it (PMM)
- Fix a gvec assert in PSEL
- Fix NaN selection per FPDot pseudocode.

r~

Richard Henderson (10):
  target/arm: Fix SME vs AdvSIMD exception priority
  target/arm: Fix sve_access_check for SME
  target/arm: Fix 128-bit element ZIP, UZP, TRN
  target/arm: Replace @rda_rn_rm_e0 in sve.decode
  target/arm: Fix FMMLA (64-bit element) for 128-bit VL
  target/arm: Disable FEAT_F64MM if maximum SVE vector size too small
  target/arm: Fix PSEL size operands to tcg_gen_gvec_ands
  target/arm: Fix f16_dotadd vs nan selection
  target/arm: Fix bfdotadd_ebf vs nan selection
  target/arm: Remove CPUARMState.vfp.scratch

 target/arm/cpu.h               |  3 --
 target/arm/cpu64.c             |  6 +++
 target/arm/tcg/sme_helper.c    | 62 ++++++++++++++++++++--------
 target/arm/tcg/translate-a64.c | 29 +++++++++----
 target/arm/tcg/translate-sve.c | 67 +++++++++++++++++++++---------
 target/arm/tcg/vec_helper.c    | 75 ++++++++++++++++++++++++----------
 target/arm/tcg/sve.decode      | 48 +++++++++++-----------
 7 files changed, 197 insertions(+), 93 deletions(-)

-- 
2.43.0


