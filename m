Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CDBC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3TD-0002k9-MC; Tue, 28 May 2024 16:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TA-0002jc-6X
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:30:53 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3T6-0003Z3-44
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:30:50 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f69422c090so1083498b3a.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928246; x=1717533046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ndZM1rWGoFFrniz4pC8YiK5TWwndu3mYDdskay9v+ao=;
 b=rOsYl69hzYO5XRCRGYz1YNEY8ff7mp/QsG0HgHD77+VmtCJB/iE/Batt1MFT61ZAPN
 Oikiu6MOUDwJzKYn+mMAJdbAC/YliU9VgvQiD/AWJ7DCViIlWfgY6awFjG+6o13qY8CW
 FnCbrzvvpF/+KJ9f9glmE6w+fwfKEbxRSOgnhkzE1zpxG9OjmoT0hKwHrNBQI68uxNA7
 E2jVtC1F3NoBnzqhnK2oC7+yNB1Pp5QAYBAGsm4vfu4ENHsdVYXiMQJGMlRWPdUiH76J
 CVXEUWyjqUi9v6AIeuXRj12rADJjlU7Mrm6gkgmE17sqnu3PKeLJm3smP+V3VDiyKLx3
 BTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928246; x=1717533046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ndZM1rWGoFFrniz4pC8YiK5TWwndu3mYDdskay9v+ao=;
 b=Txm1RfQrk+BV2/WxQta/wpXZ6Z/U4wxg8dDsh3EDsfj/arJ9QMubHoGGhGY+W4EcmL
 LXJXZqcZQBPFvQj07EZYwwuZPrRYceZgdgTJ/TZCOvmBfi+gAAobUvRJ848Wu5DUSabH
 fAhGC+mXXq626jzmTcC+Vv1eUlcxOnElXQDyetay3EuMBale1nXlAWLouec8E9Ag2D5X
 kLU5w9jhycZQvTzbjs8awNtSpwlQFlt+0/opK+nlWba/fj9XusAAxpFb9LDZN1kUqFzO
 RlHCm0E2dqsEFoeOolD3nJOhKxizsFPrzxJtFSk97gF9FLzg1/kfH3fNzNI6lmh2uF8T
 CdeA==
X-Gm-Message-State: AOJu0YysnIMkGBeo8XthxN/f+WWJ+jN+6Dexqf4rDetrZ65ZRQN6aQ06
 thm7ZZXT+3GCfMRqUN7To65H5FA9VVPT1J1dSFhV9HPRdxXRyKW/yra2zZ6YxrEwQX13FT9qCDC
 A
X-Google-Smtp-Source: AGHT+IGOczZwjDQMjCi5MDvfMiV1fgX4BmPJ7O8IUtF9tSTjLk9sqsLlg5WwDjpbQdkxNXrA2LvClA==
X-Received: by 2002:a05:6a00:3311:b0:6e7:32a0:806a with SMTP id
 d2e1a72fcca58-6f8f3f9708fmr13329222b3a.28.1716928245949; 
 Tue, 28 May 2024 13:30:45 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:30:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 00/33] target/arm: Convert a64 advsimd to decodetree (part
 1b)
Date: Tue, 28 May 2024 13:30:11 -0700
Message-Id: <20240528203044.612851-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Changes for v3:
  * Reword prefetch unpredictable patch.
  * Validate vector length when qc is an implied operand.
  * Adjust some legacy decode based on review.
  * Apply r-b.

Patches needing review:
  01-target-arm-Diagnose-UNPREDICTABLE-operands-to-PLD.patch
  03-target-arm-Assert-oprsz-in-range-when-using-vfp.q.patch
  04-target-arm-Convert-SUQADD-and-USQADD-to-gvec.patch
  10-target-arm-Convert-SRSHL-and-URSHL-register-to-gv.patch
  12-target-arm-Convert-SQSHL-and-UQSHL-register-to-gv.patch
  31-target-arm-Convert-SQDMULH-SQRDMULH-to-decodetree.patch
  32-target-arm-Convert-FMADD-FMSUB-FNMADD-FNMSUB-to-d.patch


r~


Richard Henderson (33):
  target/arm: Diagnose UNPREDICTABLE operands to PLD, PLDW, PLI
  target/arm: Improve vector UQADD, UQSUB, SQADD, SQSUB
  target/arm: Assert oprsz in range when using vfp.qc
  target/arm: Convert SUQADD and USQADD to gvec
  target/arm: Inline scalar SUQADD and USQADD
  target/arm: Inline scalar SQADD, UQADD, SQSUB, UQSUB
  target/arm: Convert SQADD, SQSUB, UQADD, UQSUB to decodetree
  target/arm: Convert SUQADD, USQADD to decodetree
  target/arm: Convert SSHL, USHL to decodetree
  target/arm: Convert SRSHL and URSHL (register) to gvec
  target/arm: Convert SRSHL, URSHL to decodetree
  target/arm: Convert SQSHL and UQSHL (register) to gvec
  target/arm: Convert SQSHL, UQSHL to decodetree
  target/arm: Convert SQRSHL and UQRSHL (register) to gvec
  target/arm: Convert SQRSHL, UQRSHL to decodetree
  target/arm: Convert ADD, SUB (vector) to decodetree
  target/arm: Convert CMGT, CMHI, CMGE, CMHS, CMTST, CMEQ to decodetree
  target/arm: Use TCG_COND_TSTNE in gen_cmtst_{i32,i64}
  target/arm: Use TCG_COND_TSTNE in gen_cmtst_vec
  target/arm: Convert SHADD, UHADD to gvec
  target/arm: Convert SHADD, UHADD to decodetree
  target/arm: Convert SHSUB, UHSUB to gvec
  target/arm: Convert SHSUB, UHSUB to decodetree
  target/arm: Convert SRHADD, URHADD to gvec
  target/arm: Convert SRHADD, URHADD to decodetree
  target/arm: Convert SMAX, SMIN, UMAX, UMIN to decodetree
  target/arm: Convert SABA, SABD, UABA, UABD to decodetree
  target/arm: Convert MUL, PMUL to decodetree
  target/arm: Convert MLA, MLS to decodetree
  target/arm: Tidy SQDMULH, SQRDMULH (vector)
  target/arm: Convert SQDMULH, SQRDMULH to decodetree
  target/arm: Convert FMADD, FMSUB, FNMADD, FNMSUB to decodetree
  target/arm: Convert FCSEL to decodetree

 target/arm/helper.h              |   96 ++-
 target/arm/tcg/translate-a64.h   |   14 +
 target/arm/tcg/translate.h       |   44 +
 target/arm/tcg/a32-uncond.decode |    8 +-
 target/arm/tcg/a64.decode        |  115 +++
 target/arm/tcg/neon-dp.decode    |   37 +-
 target/arm/tcg/t32.decode        |    7 +-
 target/arm/tcg/gengvec.c         |  689 +++++++++++++++-
 target/arm/tcg/gengvec64.c       |  181 ++++
 target/arm/tcg/neon_helper.c     |  506 +++---------
 target/arm/tcg/translate-a64.c   | 1321 ++++++++++--------------------
 target/arm/tcg/translate-neon.c  |  118 +--
 target/arm/tcg/translate.c       |   58 ++
 target/arm/tcg/vec_helper.c      |  128 +++
 14 files changed, 1829 insertions(+), 1493 deletions(-)

-- 
2.34.1


