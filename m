Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D58AC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMe5-0001X5-KW; Mon, 14 Jul 2025 13:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubLZo-00030T-Gn
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:58:52 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubLZl-0007my-Sn
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:58:48 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7481600130eso5119104b3a.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752508722; x=1753113522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KMNWfHsHfT7JS3J16C37mYApwqHr9KmhSe3YnGv0CSQ=;
 b=oFkGtwaAcGmsrc1ovBzAIBOLDaITbCge8UwiDXlTRJbKBZk1PXYBZSxPvo4KpMAOIl
 v7hlTxmlPYcZt1/694W25oADgN+1g+zNfLhduhbIr7aptgxinaVjxA9Os2YMpVW3A1MB
 MKHeJiIUZKKzeH2OhfIiLNSeRuOC88whqgBgoVispcBG8oBL7WRUjbJETVnCn24+E2CH
 DtNsrW6Xf9/ktOSMABOSQaQ80+lrmOURiAdT/sHdf+QmhPmHDfXWKkmYCx3uD5pd9QwK
 QIYbkpz1DncWzeeYq96YD7uRqLcN6746wKq7HwnRDLDJJut/nX3ogdCLukvb+ApqB1lv
 0sZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752508723; x=1753113523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KMNWfHsHfT7JS3J16C37mYApwqHr9KmhSe3YnGv0CSQ=;
 b=OTg/9HsZAA1vSl+/GOsXmfRrdoo+txAIM1q0FH2M2eUMfbgq2FLL4w7CIYYAD/bjQG
 cs2aFyR6C7H1wBFjT9BNExLKT0g5V9qC6XL6kKzyFEFf5maLOUPlizZXkX8D7wHMPzSF
 eKtdm/eUYkJhwfKHgIyEA3XPBHP79LuIw5zb+eEmNhMyg94Z3suZJ3WqxP4k3Xzw7TpY
 dB6cwQDeDWBu43zj/PArViX5ceXbezukO/N7zVZuQluv/Fh6Q4/VU0jqIhe2E7DJkY+5
 mHqQZBt/nYiIrvFUN9pZrKM1NJl4rZM5qrTT/29qX3EP1sHsuaZszSV2AH5//ZdoQTtq
 +VGg==
X-Gm-Message-State: AOJu0Yw3BOGa9Ar/B1cwyG2HDe4A6887SHf84v6opXx1utq1x8dVwU0E
 aMxec0YajQKP9LCr37h0upwtTK/r3hyrPuSbYWd7BllQFhodAcSdQw6sVIpva1GzZgBGABCyvwg
 QN00PeWU=
X-Gm-Gg: ASbGncubKiDGTOkPDWrufyEsS+PmcvvTueL3YODMWz47cq33VKcLl4lmvi5FfZSubIz
 Q0SRRrrrg9/b2d86qQ23RCMwDWLi34auFmRPm5fKiJ20R5EWlFehjCGGolEZ9yyvgJIpfANQuZb
 OyDJQWToFK/efgTPx8R+7rpOMTy2uMaF7Shv1iBfrW7zmd4tUbRA2zPj+71eHOvTz8UGoOiIX4K
 P/IEG7Y5hXpYFs9+AAKl24F92F6IE5qrj+r9ToiDcvWyGgjM3ACaYjY5L6GAzT+8Reje2LnD1Pp
 pwXvZp19RXZCPr8V+zawqf6xMoF/IlEhDAeIBCFveYmLdR2rva7mIwqaRrRTDf8NQVLKhJbfc1N
 7yldk6u4d/IAkWfzcJXpUBTUHxEuf76jMnznf0Oi7j62cZHNAQQ1r
X-Google-Smtp-Source: AGHT+IFSH1B6XZQUO5yPzIBTQBwyD1679zlSjgnP21Ho9Y82x99QSTIJRSc7gpHTGfpWT+syEXDz1w==
X-Received: by 2002:a05:6a00:6b93:20b0:749:bb6:3a8e with SMTP id
 d2e1a72fcca58-74ee04ae709mr14196753b3a.1.1752508722466; 
 Mon, 14 Jul 2025 08:58:42 -0700 (PDT)
Received: from stoup.. ([172.56.179.167]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f8f24dsm10265805b3a.156.2025.07.14.08.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 08:58:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org, pierrick.bouvier@linaro.org
Subject: [PATCH v8 0/4] target/arm: Add FEAT_MEC to max cpu
Date: Mon, 14 Jul 2025 09:58:31 -0600
Message-ID: <20250714155836.1514748-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Changes for v8:
  - Re-order SCTLR2 and TCR2 so that they are independent of MEC.
  - Enable the SCTLR2 and TCR2 enable bits.
  - Squash 3 smaller MEC patches together.

This still fails the RME tests, because we still need TF-A rebuilt
with ENABLE_FEAT_SCTLR2 and ENABLE_FEAT_TCR2.  Pierrick, since you
have just done such a build, could you re-test with this series?


r~


Gustavo Romero (4):
  target/arm: Implement FEAT_SCTLR2 and enable with -cpu max
  target/arm: Implement FEAT_TCR2 and enable with -cpu max
  target/arm: Implement FEAT_MEC registers
  target/arm: Enable FEAT_MEC in -cpu max

 target/arm/cpu-features.h     |  15 ++
 target/arm/cpu.h              |  27 ++++
 target/arm/internals.h        |  23 +++
 target/arm/cpu.c              |   9 ++
 target/arm/helper.c           | 259 +++++++++++++++++++++++++++++++++-
 target/arm/tcg/cpu64.c        |   7 +-
 docs/system/arm/emulation.rst |   5 +
 7 files changed, 339 insertions(+), 6 deletions(-)

-- 
2.43.0


