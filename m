Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C898DC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxqr-0003fl-Tq; Wed, 17 Jul 2024 02:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxqm-0003a3-FH
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:16 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxqj-0002zo-Pk
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:16 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-25cba5eea69so3194475fac.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721196551; x=1721801351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nGeC9BqibeOCSkqo/96qzTdc5e22rYcjirQRxXS7nrw=;
 b=YPzuAN1Qj5I1TQ7MzH6CbQo1CER6MgTKkoetpgO/S866biPwDjFxjm1TvNEDm2Hdta
 AjmFykxyzVByIvDpZUK4n1XPK9w8HmGbc4cjI1OJ3pcD7ccF0DPc4OWnn7jLB+V1mG4p
 IseN3i5Q4jXLnQa7yluLRlR4ImXX7w+UGMuBygi3WfQlRIzu/WCmFer23qfKrYUzoPnR
 l/UfDR6ZbbWmPd/ulsTfQ199OeMvgGD11MJLSfItP33/bbBtYXEblb6osX4KR+/I7fJk
 rx2Zirb4iy//CNB8hUgptcSxVl3LEDEJdFGXpNA7vnql63T13rznhWrlN7wk/1XH8jh2
 pzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196551; x=1721801351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nGeC9BqibeOCSkqo/96qzTdc5e22rYcjirQRxXS7nrw=;
 b=u/XgcQ5O8Dx53+tZqFDljktmH009KUlmJXB9IFvnNwn5qT2C/SWi0plfTSOzaI0lqx
 +CgXZX2pr/Uj5gFvuari6mZ1z2M06pU52BsmRn7Fb/S/OHKOzIhUIxXBG5dErYLByvkb
 9wQ5//cVlt7QEXCJmf5jNVvP8a5aigt/ACYFqflUnMmIb2Hpac5fdU3UG8cHZlUzEpgb
 m21wilbY28VlospP6+IATJN0jkYeyKe+Zpf2mJ5exQrJsvOry2K6kKJMMlvA9KZMHHzL
 VxN9fZheSsvXm+qLbSjdZf58D/xY7O2K+3WbgrOt0ETU+DD6u4R5Xng6Gef3UCxhH5K4
 bwow==
X-Gm-Message-State: AOJu0YzA+LM9OSYk06qCHdxoGlMW4VcdwKVZTbacGQQxPlL+S3TFW8qo
 U8RgMeXvDlCpW4DmeskEWy6IETRIPYmYj4ebFrDgXH99hKWVLsMOymXK/aM5cLxfZFsJCmbzH7t
 ju80=
X-Google-Smtp-Source: AGHT+IG5OGt6H0BaWA91wqQQihPoM/QykjMeOzWlvmQ99RIqr1a7VqNqzAOf7SDz+1CC/NQAu7NQMA==
X-Received: by 2002:a05:6870:3046:b0:25e:c7b:ca96 with SMTP id
 586e51a60fabf-260d9144d62mr594913fac.10.1721196551001; 
 Tue, 16 Jul 2024 23:09:11 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecd603bsm7330404b3a.219.2024.07.16.23.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:09:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 00/17] target/arm: AdvSIMD decodetree conversion, part 4
Date: Wed, 17 Jul 2024 16:08:46 +1000
Message-ID: <20240717060903.205098-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Flush before the queue gets too big.
Also, there's a bug fix in patch 14.

r~

Richard Henderson (17):
  target/arm: Use tcg_gen_extract2_i64 for EXT
  target/arm: Convert EXT to decodetree
  target/arm: Convert TBL, TBX to decodetree
  target/arm: Convert UZP, TRN, ZIP to decodetree
  target/arm: Simplify do_reduction_op
  target/arm: Convert ADDV, *ADDLV, *MAXV, *MINV to decodetree
  target/arm: Convert FMAXNMV, FMINNMV, FMAXV, FMINV to decodetree
  target/arm: Convert FMOVI (scalar, immediate) to decodetree
  target/arm: Convert MOVI, FMOV, ORR, BIC (vector immediate) to
    decodetree
  target/arm: Introduce gen_gvec_sshr, gen_gvec_ushr
  target/arm: Fix whitespace near gen_srshr64_i64
  target/arm: Convert handle_vec_simd_shri to decodetree
  target/arm: Convet handle_vec_simd_shli to decodetree
  target/arm: Clear high SVE elements in handle_vec_simd_wshli
  target/arm: Use {,s}extract in handle_vec_simd_wshli
  target/arm: Convert SSHLL, USHLL to decodetree
  target/arm: Push tcg_rnd into handle_shri_with_rndacc

 target/arm/tcg/translate.h      |    5 +
 target/arm/tcg/gengvec.c        |   21 +-
 target/arm/tcg/translate-a64.c  | 1123 +++++++++++--------------------
 target/arm/tcg/translate-neon.c |   25 +-
 target/arm/tcg/a64.decode       |   87 +++
 5 files changed, 520 insertions(+), 741 deletions(-)

-- 
2.43.0


