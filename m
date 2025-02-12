Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443ADC0219E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 03:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti3hk-00009o-Tj; Tue, 11 Feb 2025 22:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ti3hf-00008t-Hv
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:46:23 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ti3hd-0001Zj-1V
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:46:23 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220bff984a0so3916085ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 19:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739331979; x=1739936779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cdsZUFhW1GSa3hHfShsopl5Q9pSd86BGZIew4a00dDE=;
 b=AS+0hMipEI/q29VH1YYTR+8jfbPdMF+9oO+0McqIloHh/Rc7LKsReGfOTQT3xrRPpw
 7nZhpQpYuTuyiWMN4nqr73AEMhFyCXQKeiDLyanzL0iuvN9JPF9FOuHwbVX8xUpmArxC
 qII8bTIeYGujV0T+KmVvpBhyELFvYh2W1sv6oOgaPxWMfL3n7vEaXvsVj0hio3RTlV/a
 u8CKhCmlGcFRmhoWeWC/zqf2t/USUY1RjphZ+c4MVlugVN4Mw91j22bU3Li2g382NzAj
 GQ9IM0pn4X8G8GT3UN/VgyU9vwbEEwNC8GFJBuATk1NowOFOkoJy8kL/dgnLmvbxOik7
 lCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739331979; x=1739936779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cdsZUFhW1GSa3hHfShsopl5Q9pSd86BGZIew4a00dDE=;
 b=ltfhbJGT63HTeK8eC49zef1U4V5vqp5sv9YfZD8fnhC5OKvDKljnQYqp1uO76KMS0c
 QcZzBBnCSFlWpx39IP77d4kjNxcSqoiW4cW2PVJTryQy9Qq6J26N8Wmey8/idS9ZHmbH
 3KjnEcAYGiAUShjkQsugHbIZ3g8pkY05CWHNEMr/NYpXTPQ/NAXyxoTStZZzlDXIMQcw
 MR5jWdeesSsIRV2J6z0rLt4DF7pIWNdjnG6izUO8QE8UxfMue6Bfl8U/qovStkpfVTCS
 jh7wAeJPNLBUxfizIrFMNatcuCxu9FVMb2J/XxM9/5H4LzAc9JwdS1TvOnU+Xbbgw77v
 xGug==
X-Gm-Message-State: AOJu0YwMNRrTdlQuzn/0PtJkzrJBLUaBXVn1K6G6G40LvNToT0DSeEIu
 0q9xgZ6QTQBgk2LWFGiTzrJmOUqJNPtNI9u0Ae4jsBZMu2NhU3Lcn/naxE6KGAT+tYol/J3ie5E
 A
X-Gm-Gg: ASbGnctm8JMmlSxk7VZ0KGXmSADBCWBkPvl06bj7bXktFtDx8LedSASFs+eBGdSTbfp
 kKiYbs5LMl8mI/P3SvttTBlHKb+zk0Ze3qvLkud/coCLT9WbzEnfzshZRnNQB2cBdLjS/6ZHiOg
 OwaEJKLsLbFQ5PfPGZMZW5ZKTaxkLVONOipdN/PmW/hjSBEFhsZe+QYuNmCWcot989VFvYyij6K
 MioktVUxgLYQ+WK79Ev2x6qpN9V97m8IG/yoHlYg1/jd746V0SYxRhKIB9lzKfBUUW3HZtpkgcS
 9Y4jDFi3SfAs9YJtbgtvEMIwMjg9M2pNv5FpfyYh7RQQNNE=
X-Google-Smtp-Source: AGHT+IF2/1VLxr8vi5EDzWTJPYhXvQbxDOawM4jGXyFI4W2zNvpGa/RK3Sn7JxWIpsfqRtMhoUaFJA==
X-Received: by 2002:a05:6a00:2e28:b0:730:8526:5db0 with SMTP id
 d2e1a72fcca58-7322c3fe428mr2714807b3a.22.1739331979109; 
 Tue, 11 Feb 2025 19:46:19 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-730992eba96sm3482569b3a.126.2025.02.11.19.46.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 19:46:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] tcg: Introduce constraint for zero register
Date: Tue, 11 Feb 2025 19:46:11 -0800
Message-ID: <20250212034617.1079324-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Based-on: 20250205040341.2056361-1-richard.henderson@linaro.org
("[PATCH 00/11] tcg: Cleanups after disallowing 64-on-32")

Introduce a new general-purpose constraint which maps 0
to TCG_REG_ZERO, if defined.  This differs from existing
constant constraints in that const_arg[*] is recorded as
false, indicating that the value is in a register.

This doesn't make much difference to the current tree, but as a
prelude to [1], where small output functions are categorized by
register vs immediate arguments, then this provides a way to
send a constant zero as a register argument.


r~


[1] https://patchew.org/QEMU/20250107080112.1175095-1-richard.henderson@linaro.org/

Richard Henderson (6):
  tcg: Introduce the 'z' constraint for a hardware zero register
  tcg/aarch64: Use 'z' constraint
  tcg/loongarch64: Use 'z' constraint
  tcg/mips: Use 'z' constraint
  tcg/riscv: Use 'z' constraint
  tcg/sparc64: Use 'z' constraint

 include/tcg/tcg.h                    |  3 +-
 tcg/aarch64/tcg-target-con-set.h     | 12 ++++----
 tcg/aarch64/tcg-target.h             |  2 ++
 tcg/loongarch64/tcg-target-con-set.h | 15 +++++----
 tcg/loongarch64/tcg-target-con-str.h |  1 -
 tcg/loongarch64/tcg-target.h         |  2 ++
 tcg/mips/tcg-target-con-set.h        | 26 ++++++++--------
 tcg/mips/tcg-target-con-str.h        |  1 -
 tcg/mips/tcg-target.h                |  2 ++
 tcg/riscv/tcg-target-con-set.h       | 10 +++---
 tcg/riscv/tcg-target-con-str.h       |  1 -
 tcg/riscv/tcg-target.h               |  2 ++
 tcg/sparc64/tcg-target-con-set.h     | 12 ++++----
 tcg/sparc64/tcg-target-con-str.h     |  1 -
 tcg/sparc64/tcg-target.h             |  3 +-
 tcg/tcg.c                            | 29 +++++++++++++-----
 docs/devel/tcg-ops.rst               |  4 ++-
 tcg/aarch64/tcg-target.c.inc         | 46 ++++++++++++----------------
 tcg/loongarch64/tcg-target.c.inc     | 32 +++++++++----------
 tcg/mips/tcg-target.c.inc            | 44 +++++++++++---------------
 tcg/riscv/tcg-target.c.inc           | 12 ++++----
 tcg/sparc64/tcg-target.c.inc         | 12 ++++----
 22 files changed, 138 insertions(+), 134 deletions(-)

-- 
2.43.0


