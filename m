Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73CACA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 12:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umtWT-00013I-9g; Fri, 15 Aug 2025 08:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umtWS-000135-CG
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 08:27:04 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umtWQ-0007Ww-HH
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 08:27:04 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so1830242b3a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 05:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755260820; x=1755865620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GUnYPPDFj9Hqb/UePFns6E5LrvTEacHi8jyYmNkofOg=;
 b=Cis1F7Tcf5CaiSUbmqwiBk5LIpAsJZDrc1b0hjC+OU8vLbBVuVshmy5lBablG2I/KE
 OVUC1jNJ4kpFZxEJ9vhSfN6f8Xh30VJKyLDQT2rmhu5YrNafMF7XonBROVadrz8u/RSY
 kw5FXiJ+xG1tSGqNx9FbMS0NFZYRCbx+MaOLUUzm60/2Ra1l6NmH07MHDv80mtHdNGiH
 R0eeTbXvjfS8737K3cNpxiVH5D1gRA6dE9eA4tP8+XDyoHPaC+mF7St6YNK/M/ebW0fA
 Cj1tkz+Yn02fa19/AP82ZSzgLtg6u9t1o4pZ1ndeGGbyUJhMInvtNplg/lGIUVACZcf8
 draQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755260820; x=1755865620;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GUnYPPDFj9Hqb/UePFns6E5LrvTEacHi8jyYmNkofOg=;
 b=aC2B+gughQOKHIeDAd6TXES0b78GRuoyevGHDQend9du8asvqtGdYdeenkjiMAS3ue
 sO1noh7eb8/EFvior29/23Dex1jX7HrFYUH3ys2w6/XYwG2UKIkG4XQQnLQ/izqKwY7H
 8ThFcaAGmXHLX7Eb1zAxztwDj+6J8Arv++drlM65g0qwTYNZzjkDL6tss2IFq6pgLc62
 gX0/CciTqZ3V4m9oJ9y19fDaq8zQkWIyRVhdxwE6kryGqaKfSCdt4efCkK4RI9MqEJBP
 8QCzPLeo76LWENx2bNLJq4kcgt7EOW3cBDfsK3AXeDoXZzOFayuUynooqn5CrGELX/fL
 e7sA==
X-Gm-Message-State: AOJu0YzxQseb8bdApU7KCEJgRvkGWuk395Ib8JHE1YTQ2Yb/XPppatBj
 j5EAbZoRQ6ifVCX0romsOaylYzESaqyC0tYZ9NRK1h0DUgLQAcqI2w8jJVrWmid8W5vY4zo8Nlr
 tdkc8iGM=
X-Gm-Gg: ASbGnctugzjiqIxyb9Ro3fs5fomf73X2E8GJ1p7IT6PoyhZJdp3QgM1D4JvV04SChYR
 O0Qtwq1Ua6tzC1N5ZNqNgRPewhnYeItytWRWTaisVmrnjxbLs52ezc0mSVtzQ1fEfXc72EFjqjW
 UMkmlaXvlNj/gaAgFej9Yf6Ju8GfnLfs+dWvJb7NC39cPfGDhCeIuPYumY1VdkqXsp5gv2wXxmF
 EMM0HQgkldsSKMdk83msSP77nDVoJD8al/X7q1tYdUhwUPXSfHogUX79wdHqUVw9xjwAMoACUe9
 p6OJ96GqyBQ4luJOLv0ehE+GzapGZCUcyEDQ0gs1DbVf5dFXet6EA59Q9MDKZNKjNrXN+Rp+bLQ
 KStzTkXLN/rTEsWAMfjd6afZA5x3Kuc6sPMXJ5otXs9WeJBg=
X-Google-Smtp-Source: AGHT+IH61x7z9bMb0rsJFLFymw5NrMf+2hFNXsyuf9BBL4xJgq9sVPkqTt+IC0O/xFdUjJqAcUkktA==
X-Received: by 2002:a05:6a20:2451:b0:222:ca3f:199 with SMTP id
 adf61e73a8af0-240d297f5c3mr3266838637.18.1755260820194; 
 Fri, 15 Aug 2025 05:27:00 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e45292c86sm1053475b3a.48.2025.08.15.05.26.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 05:26:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] target/arm: Implement FEAT_LSE128
Date: Fri, 15 Aug 2025 22:26:46 +1000
Message-ID: <20250815122653.701782-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

This extension has instructions for atomic 128-bit swap, fetch-and,
and fetch-or.  This is fairly easy to implement with existing host
support for 128-bit compare-and-swap.

Unlike for 64-bit operations, I did not implement the multitude of
atomic fetch-op and op-fetch functions.  Those can wait until there
is a need for them.


r~


Richard Henderson (7):
  qemu/atomic: Finish renaming atomic128-cas.h headers
  qemu/atomic: Add atomic16 primitives for xchg, fetch_and, fetch_or
  accel/tcg: Add cpu_atomic_*_mmu for 16-byte xchg, fetch_and, fetch_or
  tcg: Add tcg_gen_atomic_{xchg,fetch_and,fetch_or}_i128
  target/arm: Rename isar_feature_aa64_atomics
  target/arm: Implement FEAT_LSE128
  target/arm: Enable FEAT_LSE128 for -cpu max

 accel/tcg/atomic_template.h                   |  80 +++++++++++++-
 accel/tcg/tcg-runtime.h                       |  12 +++
 host/include/aarch64/host/atomic128-cas.h     |  45 --------
 include/accel/tcg/cpu-ldst-common.h           |  13 ++-
 include/tcg/tcg-op-common.h                   |   7 ++
 include/tcg/tcg-op.h                          |   3 +
 target/arm/cpu-features.h                     |   7 +-
 linux-user/elfload.c                          |   3 +-
 target/arm/tcg/cpu64.c                        |   2 +-
 target/arm/tcg/translate-a64.c                |  73 ++++++++++---
 tcg/tcg-op-ldst.c                             |  97 ++++++++++++++++-
 accel/tcg/atomic_common.c.inc                 |   9 ++
 docs/system/arm/emulation.rst                 |   1 +
 host/include/aarch64/host/atomic128-cas.h.inc | 102 ++++++++++++++++++
 host/include/generic/host/atomic128-cas.h.inc |  96 +++++++++++++++++
 target/arm/tcg/a64.decode                     |   7 ++
 16 files changed, 487 insertions(+), 70 deletions(-)
 delete mode 100644 host/include/aarch64/host/atomic128-cas.h
 create mode 100644 host/include/aarch64/host/atomic128-cas.h.inc

-- 
2.43.0


