Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0795C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 01:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUc5l-0002qF-Le; Thu, 18 Jul 2024 21:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc5f-0002nX-Am
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:20 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc5c-0000gc-A4
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:18 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fc60c3ead4so11488665ad.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 18:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721351234; x=1721956034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LPcrr2bAZZOdbv+u70EpAggSdOrt6lQpVBPjPm6dBzA=;
 b=eP0MVxLdvyJv3dOlhK8KwTdocUBGU8jQaY4FAZBKx5KwuINQyPpbYcH6CBPnHc+eUE
 pmoTY5P3Np9kmwOJ4yaDQFPRARzv2C6hgCZUW5E8I5c29d0ZPJdf/nsRe7b7G6TAYDX/
 0SpEBUyKLYv6EuEpO13WK6SxnUUzR3fSiwVdRA4/MSA0IV9vFTlkqwOqb3KAhA+Yxscm
 fmGo9QlIwd5sqLAnK7WlGtAVuCtpStX+6NAN8yj5xWkINWDbFFE9xIRWXRfWRZXbQcJR
 RCQFExdcv8o7qGPVC4dLGPWaw9QS0vVSaJMUiLvsS2Dtuyj2VfK99kK0JFm82CCQzuio
 6Lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721351234; x=1721956034;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LPcrr2bAZZOdbv+u70EpAggSdOrt6lQpVBPjPm6dBzA=;
 b=lw5ELJ09hkLjdy2fLyXkNyVYmtDImQ/gkUOHTBcJ0JKtmRTOjRakON9fF6Us2AspwH
 lOka9kSuqCcJ0Cdo28PEZtCmk8603PmFP2m5RxjJONgbXUOcjfB9rHZXOlrJ1A3SI4T5
 E5l45Um7fR5cs1HR26GGWmcguiz1g2WtL5KBnr/e/3K8QIQI8u6JGWAS9buqxIT9hj49
 MJQLDU7/yYkn+jdDsyy2XlL9vzrWX2EfEHFRCjykMeIYpyr7fRhoKbC602/AecoSeUSN
 eXCZIkLBNKN8pJc+5rBaJZO9lD06pevJ6ZoPx4MBZU+bkCyklOO6f1yDXjQO8XWVdXmV
 eSJA==
X-Gm-Message-State: AOJu0YyfKQxkD7aU95DdWVV2PpXcwUtqVQ9lFEdZ1Zoaex2sfXs+6x9b
 aI++8Un1GeoLsSU7ZHVFDlKwkvUXXA9qkWPbmJR/flhHCGhzwAp2EGk4/+h13z8dqQpbz2EKmlB
 0OG+OoQ==
X-Google-Smtp-Source: AGHT+IHgYX02p8ogOEHhC4Bu9QXpR10kUHjmDO9vM2TfSyz3WU0QZrvUlhzOtEgOOfgZSFxsqFNnkw==
X-Received: by 2002:a17:902:da8e:b0:1fc:58e2:82c8 with SMTP id
 d9443c01a7336-1fc58e296b9mr51652145ad.49.1721351234233; 
 Thu, 18 Jul 2024 18:07:14 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d07ad9sm2067415ad.177.2024.07.18.18.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 18:07:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 00/12] Fixes for user-only munmap races
Date: Fri, 19 Jul 2024 11:06:55 +1000
Message-ID: <20240719010707.1319675-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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
  * Fix patch 3 (sve) vs goto do_fault (pmm)
  * Fix patch 12 (rvv) vs watchpoints and goto ProbeSuccess (max chou).
  * Apply r-b.

r~

BALATON Zoltan (1):
  target/ppc/mem_helper.c: Remove a conditional from dcbz_common()

Richard Henderson (11):
  accel/tcg: Move {set,clear}_helper_retaddr to cpu_ldst.h
  target/arm: Use set/clear_helper_retaddr in helper-a64.c
  target/arm: Use set/clear_helper_retaddr in SVE and SME helpers
  target/ppc: Hoist dcbz_size out of dcbz_common
  target/ppc: Split out helper_dbczl for 970
  target/ppc: Merge helper_{dcbz,dcbzep}
  target/ppc: Improve helper_dcbz for user-only
  target/s390x: Use user_or_likely in do_access_memset
  target/s390x: Use user_or_likely in access_memmove
  target/s390x: Use set/clear_helper_retaddr in mem_helper.c
  target/riscv: Simplify probing in vext_ldff

 accel/tcg/user-retaddr.h      |  28 ---------
 include/exec/cpu_ldst.h       |  34 +++++++++++
 target/ppc/helper.h           |   6 +-
 accel/tcg/cpu-exec.c          |   3 -
 accel/tcg/user-exec.c         |   1 -
 target/arm/tcg/helper-a64.c   |  14 ++++-
 target/arm/tcg/sme_helper.c   |  16 ++++++
 target/arm/tcg/sve_helper.c   |  42 +++++++++++---
 target/ppc/mem_helper.c       |  52 +++++++++--------
 target/ppc/translate.c        |  24 ++++----
 target/riscv/vector_helper.c  |  31 +++++-----
 target/s390x/tcg/mem_helper.c | 103 +++++++++++++++++++++-------------
 12 files changed, 224 insertions(+), 130 deletions(-)
 delete mode 100644 accel/tcg/user-retaddr.h

-- 
2.43.0


