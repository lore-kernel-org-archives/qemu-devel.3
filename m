Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DACCCAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0swS-0004GW-MA; Mon, 22 Sep 2025 22:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swO-0004Ew-Ga
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:41 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swE-0003gh-JK
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:40 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so4593235b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 19:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758595164; x=1759199964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/+xCyee1OTw6/rtDYrGJJvZQnPANo5eYR55J/6NbsZQ=;
 b=NN7ft1CUePQaSw37zlRHcPA8hbnq6M/4jbquYTnZWq+aImxuDSmhd2kiqAb4lDHJyl
 co0Gmd2E+djujCXNIADXofR+6E/eagWrQeoAkLPndG0cmH44tHMdsPHDNAU2DsNzx1Zm
 Css1YPPAEcjmodBUTh5iqfceKpvIoDAQLZxU9H3+6JT6UXwj0lB6I5Xj7sEQfiBqBLKv
 /i/e2AtQFB0+FbE+VBXSz/XAjBRizFvW1U3xFeTbelVQn7PZ536kH3zmJE3tmU1MMsV7
 9w/Wbtvq9bYVPdIUihf1eAiMu/TJKSnyxEQ/LExBlAu1ryi4OOickAXn+a6rbExqtRbJ
 W7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758595164; x=1759199964;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/+xCyee1OTw6/rtDYrGJJvZQnPANo5eYR55J/6NbsZQ=;
 b=n5aiUcwDATWewZAt2SGTQyJUSeVMW6VjM0osA2AXV/kfHJaGLwy7d48vfx6nStz/5q
 ORzPtjoY32CC0q/3TKVjUm6OZE/82WxLDewRruI93+tp47X6igU10FkILj017VoT6Dfa
 Ah5KbgoBhbZF1Xm5Qz7f1pX7bRriPQdCBXPKxxOVjQRtHOOJ2mPJ0rZGxu8TB+T2sQKk
 AUP/tmKN8DfzepYtdaWLF5aHorqMaqgOlkBW6lWPxl+8naOh0ZUl9STR8ABj5ahL6GZA
 mldP1sa3WlV8/wZKxKSsIiHra8ywy2xZ4McBfvRWVsY8NDZFlEpgpnKuhbutwwevNtGh
 GPHw==
X-Gm-Message-State: AOJu0YzqkW7EFBskim5hrT8jdyPb8Tf7p4OYSXg8WVe9BUePnUFTZdRK
 sDyYdF/PU7KN9ybr0tJGgpEy2aDADVo1sFvtCo+sdVaLiRSCKvPYbbuOuZMMhJoARS/ho26dHmx
 V64OF
X-Gm-Gg: ASbGncvNfZxeDIrjqVbQjlYkcM90L4ZyujEbUR/G65UspBb1jtKA2Nxbt8B65Llj6AF
 4P4oC7ymZwLSPc01si6oT+M/AVatcsClJ7kkMLlF9un8knB4W7aXxc3ESn+2YKDiE2spaaWQ+85
 LQpS7Zd2JbnLly4zWsfgK8oiIpWu4NMErgMS5ORzywcHZZUMqisrGUbROlqJvfoW7CMAs2A/Ojt
 Vx6sT4bYMAwf0ISnWJF5IquijiHb8aDhohB0+JxLKII5VVtGPNXqwZIB9M6x1JwfkZp84UT1Rl8
 +funhxF3fNrZGZ3HP8jdzNKz69ccNtnH/fXKEYVxC4AXNp/KbOEQndzYjSkGAtg/DMM3d/UFX/9
 XTUJarA1VUyhWyNFjPReu4xWmkr91
X-Google-Smtp-Source: AGHT+IEXFKMV2+ZtgQ06veCEUqnnNSDIV/QRgdkvreswGeUJII0wAdMWXnfvKVcrVBRzXTKo9WwPjw==
X-Received: by 2002:a05:6a00:8d0:b0:772:6856:e663 with SMTP id
 d2e1a72fcca58-77f5486bee1mr979688b3a.8.1758595163901; 
 Mon, 22 Sep 2025 19:39:23 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f0da43089sm9899622b3a.90.2025.09.22.19.39.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 19:39:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/12] accel/tcg: Improve tb_flush usage
Date: Mon, 22 Sep 2025 19:39:04 -0700
Message-ID: <20250923023922.3102471-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

It is too easy to mis-use tb_flush().  For instance, because of
the cpu argument, some parts assumed that it needed to call the
global flush function for every cpu.  It is easy to forget that
the flush is not complete when the call returns: we have merely
queued work to the cpu run loop.  So: remove tb_flush and expose
only the core as tb_flush__exclusive, to be used only when we
are already within an exclusive context.

In some cases (gdbstub, alpha, riscv, ppc spapr),
we can eliminate the need for tb_flush completely.

Changes for v2:
  - Assert exclusivity in tb_flush__exclusive (pbo)


r~


Richard Henderson (12):
  gdbstub: Remove tb_flush uses
  accel/tcg: Split out tb_flush__exclusive
  target/alpha: Simplify call_pal implementation
  target/riscv: Record misa_ext in TCGTBCPUState.cs_base
  accel/tcg: Move post-load tb_flush to vm_change_state hook
  hw/ppc/spapr: Use tb_invalidate_phys_range in h_page_init
  linux-user: Use tb_flush_exclusive to start second thread
  plugins: Use tb_flush__exclusive
  accel/tcg: Introduce EXCP_TB_FLUSH
  accel/tcg: Use EXCP_TB_FLUSH in tb_gen_code
  accel/tcg: Remove tb_flush
  accel/tcg: Tighten assert in tb_flush__exclusive

 include/exec/cpu-common.h       |  1 +
 include/exec/tb-flush.h         | 18 ++++++--------
 target/alpha/helper.h           |  1 -
 accel/tcg/tb-maint.c            | 43 +++++++++++----------------------
 accel/tcg/tcg-accel-ops-mttcg.c |  7 ++++++
 accel/tcg/tcg-accel-ops-rr.c    |  9 +++++--
 accel/tcg/tcg-all.c             | 21 ++++++++++++++++
 accel/tcg/translate-all.c       |  5 +---
 gdbstub/system.c                |  4 ---
 gdbstub/user.c                  |  3 ---
 hw/core/cpu-system.c            |  8 ------
 hw/ppc/spapr_hcall.c            |  4 +--
 linux-user/mmap.c               |  4 +--
 linux-user/syscall.c            |  2 +-
 plugins/core.c                  |  6 ++---
 plugins/loader.c                |  2 +-
 target/alpha/sys_helper.c       |  6 -----
 target/alpha/translate.c        | 21 +++++-----------
 target/riscv/csr.c              |  3 ---
 target/riscv/tcg/tcg-cpu.c      |  3 ++-
 20 files changed, 75 insertions(+), 96 deletions(-)

-- 
2.43.0


