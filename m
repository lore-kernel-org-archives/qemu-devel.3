Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12993C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Kta-0001cN-Ej; Fri, 25 Apr 2025 11:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8KtZ-0001c0-5B
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:23:17 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8KtX-0002oV-Ed
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:23:16 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7376dd56f60so1820188b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594593; x=1746199393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XsIdeYda1erw7LbBUV6axRJk82z+kY+iFWtGvqMba+A=;
 b=cJFM2zlyQ8Sgso5vfrxb8uLqdH7SkwGH3bUGHpR/H3bHH7PHflvRAUZ+0WIa+kKu83
 qsyGacH+h08EDrx1RadxooUjHke7ZxsOfuxcgj9iF37vDAAfNHtWpNDV8x7Dg06v4kty
 1SMfsTW1fkePs1MzBqtQ8vmDCVdFnPiHQD9xrqfqMHtXDoxaWlx+S7TJNvLegq0yCfBv
 m2r/Zad8vpEpKWmy1E06ReMhj07zW4aGsdXoBYwlapUvypUQNFYkvZsW2T5kTG9+0H1L
 P/IOHoj6yLqrTlAQlCvJuFuJe9gQFV+U/WRILUshCdWRg2d25rrYnPymgb+UfJMBF1pp
 sAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594593; x=1746199393;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XsIdeYda1erw7LbBUV6axRJk82z+kY+iFWtGvqMba+A=;
 b=mDz8Vr5U7L4iW7J6L14Ppaw1ZftMMPtQ3V7B0lCxjH7i5WX4iBvn2ThmWEDgDRgaGb
 PbL8L3AKf8YEpPhrK326gULHfRcoVOve7LtVcK/67aF3PBzcv12GB5KvPKOvRYECK3yb
 7zsE6SyT421DAU3yz1g3pe/JWaOK1uhOqp/lxDTEuUGsw+OPc5fgmVfLpTc1PMbGE2b6
 Z7SBtWtT/Xkfwzl3pAF6nEkxIL2mz3ePP2ARTk+OTrZueiSHUlPZPfF8tvXtav6gQqAL
 dmz2m0nf1D+H8DDM823Ai6mIizC9wiIHrloQjKjYoG9LAiqf02uLkm/mPGvvN2BADgbW
 yqFQ==
X-Gm-Message-State: AOJu0YxWhYSPbRHodx9Kas7L3QM6ZCLcdAPbidfTVwJrDjuOUATFmQtW
 P+7hAm6FZfyIzYQePbB40GexwEGTaJFXKpNrNU9CFcU0pC+Y2XqHayBjLfNdB9NgqLiCwioapVQ
 W
X-Gm-Gg: ASbGncuzTqt9fh2rSNUq+LIhqgmRlyrau3LiEBtidmgrtMdw8KuTBVmgAQ7Mawf668v
 ahdUnOfkxVRzAlgLDblKXtWtIHlNz27OHElsx/EGM2WJtGdQraerJFHz5SK2qqW+9iMqfDK0/MN
 VDzSsU/eesneHk9oTnsZ1SUWaFzX3WIXkzNAu+HXqewvXhOa4d1Yf5Kj3C5B908ocI+DNSkYT35
 DmTqzsuT9z1TGUn6JNBRjdhVZZaWVEppF4M7qmnn0JVLgsh+rc7Q3n/iJVL5BZjjXc/I9u2dU3n
 gWGCp7NxScXT3P+77NVXfL2gZuQnS5omy4g2gJDUeJiGSyoBjafae+sAuraSI3CqWLqPNg1t12A
 =
X-Google-Smtp-Source: AGHT+IG5v//cncY6cjtb4Wpg6QILbJyWY+jch8sq3RxRUvkqBoR7RkAm8vRtzB3aVtLMa7gplqG4QA==
X-Received: by 2002:a05:6a00:acc:b0:736:6151:c6ca with SMTP id
 d2e1a72fcca58-73fd6807122mr4010391b3a.4.1745594593121; 
 Fri, 25 Apr 2025 08:23:13 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3390466b3a.106.2025.04.25.08.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 08:23:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, dbarboza@ventanamicro.com
Subject: [PATCH 0/7] target/riscv: Fix write_misa vs aligned next_pc
Date: Fri, 25 Apr 2025 08:23:04 -0700
Message-ID: <20250425152311.804338-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

As discussed, the use of GETPC() within write_misa is wrong.
I've done just enough plumbing to get the helper return address
piped down to write_misa, so that we can make use of unwind data.

AFAIK, nothing in check-tcg or check-functional would test this.
It shouldn't be too hard to write a test akin to issue1060.S,
but I'm going to leave that to someone else.


r~


Richard Henderson (7):
  target/riscv: Pass ra to riscv_csr_write_fn
  target/riscv: Pass ra to riscv_csrrw_do64
  target/riscv: Pass ra to riscv_csrrw_do128
  target/riscv: Pass ra to riscv_csrrw
  target/riscv: Pass ra to riscv_csrrw_i128
  target/riscv: Move insn_len to internals.h
  target/riscv: Fix write_misa vs aligned next_pc

 target/riscv/cpu.h       |  15 ++-
 target/riscv/internals.h |   5 +
 hw/riscv/riscv_hart.c    |   2 +-
 target/riscv/csr.c       | 278 +++++++++++++++++++++------------------
 target/riscv/op_helper.c |  13 +-
 target/riscv/translate.c |   5 -
 6 files changed, 169 insertions(+), 149 deletions(-)

-- 
2.43.0


