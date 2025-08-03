Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6B8C87FD2
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiNiF-0006i7-CZ; Sat, 02 Aug 2025 21:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNiC-0006eL-VN
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:40:33 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNiB-0004az-4a
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:40:32 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e8fe929b147so1346352276.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 18:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754185229; x=1754790029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4MW07FbLyT0yKho5UYediTDDFwRORlQQBlI1MJIT9Pk=;
 b=IX/dxSl+6PnEtF5ouxvNjlg12OIY8qCNdTNckbYI8fm89sA0Vj41P3PuyYZQmuUzuF
 qeheNJcx8qVGf30xCChQnBiro9n8+3b1PlUvGrg7GD6Mrj9iNkJ3HGhtcXLhfCqZIAjt
 VStLnW/pezP+M4FmzkxT4cCNb+A/cOnWgbCXLbWuzlCrV20UtLbDTgOvI3u+3tIKcyD1
 3RTNoBcsXz5EwxV9Ik6aAIC0VeyZ49P/W3W80TsqiOKc5iuYfkLJnGJYtmSuodfvo8Ly
 NQxOYGXzKT+IjXAM+5uuYo1u0zFCnoFxVtvc2oUIBPJSWMUCj3UN4g3+XEVuiL7t3IOE
 0zdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754185229; x=1754790029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4MW07FbLyT0yKho5UYediTDDFwRORlQQBlI1MJIT9Pk=;
 b=BKR5p1nNeu7GqdR/ACLsa2Y8TtfwsfAwwF4E7UfNvgtyvAhhFiKoBxd6xfJbDHF6T4
 gOo/j8lCeRcWNMjuWCOZB+3MyNlQbv3iOTC2cM1JKxxyaR6uz4si18DkXAOU3ZxNgXj3
 ISNHTRUcvbtN1yyYqtMgutJ0fgaZh6v+6EubVIyTGuWbCnAfA+uN0S+MJ9k5DY+ZcmIi
 h+Ge3zUXtL/DmCG4mE4rffbvFmxcu/zG8HkwDEnZpqvGRf/lgLunEQ+sMvXaY0M7cBT3
 ElBSF3SVGHdBQASYbm5OFMqNuNTy7asmTLzwJA6vbZx+yagF/A0rCD6JS7MbpJvX7pjy
 d0Vw==
X-Gm-Message-State: AOJu0YwzGr1UUuxLmJldmIITMGxO7gqZMz3w9oSjr0pF0JVZH4niQRWP
 jIGWgvRYW7kaPEs82L8lc/VfY1UEXGFaSnMlNF0QaFUMKp0JYeathO0iIWpSR97ZN3EEluG5Y3Y
 1KkEPaQQ=
X-Gm-Gg: ASbGncuUXy3pYWgKFvnIi/fRjCDB0VlpLr42XhtxkWHGjGdvxcZ++07egTOCZ7WPsyk
 oBrNMSE+ooUlkXkmgmL9Nuv/h2B2Pg4wJQY6xgl9jF8FmLX1n86AyjEiDZj5WY8uwhyWVQM/obq
 r9vitqiXANOImhDYQqpR4S5B4bkTiHqJOgrMxThaFZFJrB9eCgFE/uRtu/siICQOKp295BxnVnl
 t2ByMe3V7IyQ300ShFuF1SbFfo9eW+pxDQQygKhUfsl3pOHew94FBtfKdOxKwXcVFuOvWbHtIle
 dlAtJSUpYL9HXPKohx1+qBZ5J/QsnsgbzXfIse4YeCIP+86pOYf4IDMQPvwtc09Qa06qpHAYuol
 Rz5NaiacJoj5wsDNpYDTuWE1hAh68Q2DW+5BsJg2jo6WrHc7ROPJm
X-Google-Smtp-Source: AGHT+IEhJpvQcJBqv014DezRMUs1ohrVQsCmLneqU9HYm0ZVYJZlNzswadH3tfOyhhqhBck5+aVLzQ==
X-Received: by 2002:a05:690c:660c:b0:710:e81b:f7cf with SMTP id
 00721157ae682-71b7ed716bbmr64534277b3.13.1754185229481; 
 Sat, 02 Aug 2025 18:40:29 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a6031a1sm18753227b3.86.2025.08.02.18.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 18:40:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 00/11] target/arm: Implement FEAT_CSSC, FEAT_CMPBR
Date: Sun,  3 Aug 2025 11:40:08 +1000
Message-ID: <20250803014019.416797-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These two extensions are related due to sharing ID_AA64ISAR2.CSSC.

I had intended to test by bootstrapping gcc under emulation with
-march=native (that seemed the easiest way to test the short
range branches), but that failed for unrelated reasons.

I'll try again next week.


r~


Richard Henderson (11):
  target/arm: Add feature predicate for FEAT_CSSC
  target/arm: Implement MIN/MAX (immediate)
  target/arm: Implement MIN/MAX (register)
  target/arm: Split out gen_wrap2_i32 helper
  target/arm: Implement CTZ, CNT, ABS
  target/arm: Enable FEAT_CSSC for -cpu max
  target/arm: Add feature predicate for FEAT_CMPBR
  target/arm: Implement CB, CBB, CBH
  target/arm: Implement CB (immediate)
  linux-user: Change exported get_elf_hwcap to abi_ulong
  target/arm: Enable FEAT_CMPBR for -cpu max

 linux-user/loader.h            |   2 +-
 target/arm/cpu-features.h      |  10 ++
 linux-user/elfload.c           |  12 +-
 target/arm/tcg/cpu64.c         |   1 +
 target/arm/tcg/translate-a64.c | 219 +++++++++++++++++++++++++++++++--
 docs/system/arm/emulation.rst  |   2 +
 target/arm/tcg/a64.decode      |  26 ++++
 7 files changed, 256 insertions(+), 16 deletions(-)

-- 
2.43.0


