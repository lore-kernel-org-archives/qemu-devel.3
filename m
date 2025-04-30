Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CD5C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 23:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAGVk-0001j5-Lc; Wed, 30 Apr 2025 19:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAGVh-0001gV-TP
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:06:37 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAGVf-0007UZ-L6
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:06:37 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7403f3ece96so623196b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 16:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746054393; x=1746659193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2F+hPsL4LbSu3gW/DCRDUJFbiar1wwWjCNPQbPWWc9A=;
 b=S/7jKUhQM22TMYuRezZs+t7ibAxtKoOdJRll/ueEq9bbSM4AR+aDPqIFsbgvm6P2lD
 BaPdTepf9lsdSWhjCqUrf8y1p0YffJjir2lzl853sVdXlf5kpnsPelHBO2PpskPrEu6e
 dkPJOTwvCeAqv9omPGzjaeoEwhqzCUP9gaVh+7lwTyYDn9gmp2qbHIz1kbYaIVeoMhrV
 dJU/rVKr6UVcAIecLheln08oE/8Iuxa2sPjXZnwyAuKdEEdQPpTpPqaPwP7wAMnG8Wl8
 DSZGulezIWSEU+3cBrBYZk451vxov9iOn0T2FlAs5FVZVt8SoI/vbAMkZBBW1+rJXyVA
 2pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746054393; x=1746659193;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2F+hPsL4LbSu3gW/DCRDUJFbiar1wwWjCNPQbPWWc9A=;
 b=cFYgHbz/wNhPF7CHJp4ZI5xM0L44zQeyvLdvZA4ZagmbqOVMUcyA9RPbDZdwXnitHv
 sJHIYZvINhJCDbptWTrren3Z1PAN9hCbs7u8VtoWCTFDy5PeofRPoIdJsnVVFJPTBker
 Lq4XHwZDqEoeFHWHaNMymDj19tzOGGBmt7DHQBBgxs0qyi4eTy0vIiHeAaRrQQIfTPeO
 Soyk3XPmLpzACRihMbjZKZgVhI5I75Fx3l11RCihICYUyupnZ5Ts2WbpJFBvrcwIowFO
 IMw8dDcoWFbPvQzhFfUmYwdNiln75xBKAtQXL4F5yVVtiS4lWYGaF63PyAgYmkD88BSk
 hVQA==
X-Gm-Message-State: AOJu0Ywb5YTSkM6X28Bohssj3k/Y3djxzBYWh6/e6LsnYjxrkVmx9usI
 RhdGIUw2HelF6iYRtqc+CLOo/lyC160YKRb4Juvlpa5oNfzAXNjGMmaOO5To7iXLQE03jtpyAdz
 S
X-Gm-Gg: ASbGnctD5rKmDNHJsJy+VJfMMPHQ9MucmVtWsGuEmfysxQ5U7J3RpQU7chJMPQzFaM0
 U89Bee36Phz9LP6PV57tSww9ufICePXyDldeE1ikGGnUAvih1TMcMONgWYcQ9MRmFQexebsN74u
 40NHG7Vstr+VYaswFnVaXBYBHBvCDrI/C/iXTQAEZd5nxqqsgzTLbhVu3sm4xxmX2L/cyHteoR8
 nx/LZvGlWJzEdpqOj6+MLYWj9rDvlCAOXgG40rBA1QoQbAa1/MxKk+wmj9sbAfpyfRyiwSOt1UI
 J32wSZSc5swN2cr8GxafIGANaiYnDVsTDMvR17nFKL/Bg7hHRPOL4ylAzbPw7ekqsBm4imaMv/G
 KfqD84dTdDA==
X-Google-Smtp-Source: AGHT+IGO50nF/qjWDo+w2pPm0lbKKEOgxQUGd/De6NSVIsEShK8ms/xkju87u25fxGtdxyM3n1wciA==
X-Received: by 2002:a05:6a00:114b:b0:736:3be3:3d76 with SMTP id
 d2e1a72fcca58-7403a80a043mr5960016b3a.17.1746054392836; 
 Wed, 30 Apr 2025 16:06:32 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a30e2fsm2323287b3a.103.2025.04.30.16.06.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 16:06:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] accel/tcg: Build translate-all, tcg-all twice
Date: Wed, 30 Apr 2025 16:06:25 -0700
Message-ID: <20250430230631.2571291-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Based-on: 20250430164854.2233995-1-richard.henderson@linaro.org
("[PATCH v2 00/16] accel/tcg: Compile cpu-exec.c twice")
Based-on: 20250403234914.9154-6-philmd@linaro.org
("RFC PATCH-for-10.1 05/19] qemu: Introduce target_long_bits()")

The finish line for accel/tcg is in sight...

r~

Richard Henderson (6):
  tcg: Define INSN_START_WORDS as constant 3
  accel/tcg: Don't use TARGET_LONG_BITS in decode_sleb128
  accel/tcg: Use target_long_bits() in translate-all.c
  accel/tcg: Build translate-all.c twice
  accel/tcg: Build tcg-all.c twice
  accel/tcg: Use vaddr in cpu_loop.h

 include/tcg/insn-start-words.h | 11 +++----
 include/tcg/tcg-op.h           | 17 +++++++++--
 include/tcg/tcg-opc.h          |  3 +-
 include/tcg/tcg.h              | 12 +++++---
 include/user/cpu_loop.h        | 12 +++-----
 accel/tcg/tcg-all.c            |  6 +---
 accel/tcg/translate-all.c      | 56 ++++++++--------------------------
 accel/tcg/user-exec.c          |  2 +-
 linux-user/signal.c            |  4 +--
 target/i386/helper.c           |  2 +-
 target/openrisc/sys_helper.c   |  2 +-
 tcg/perf.c                     |  5 ++-
 tcg/tcg.c                      | 12 +++-----
 accel/tcg/meson.build          |  6 ++--
 14 files changed, 59 insertions(+), 91 deletions(-)

-- 
2.43.0


