Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A34DCFA743
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 15:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx6fO-0001xc-Mt; Sat, 05 Oct 2024 11:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fN-0001wa-9k
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:25:57 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fL-0002KG-4j
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:25:57 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20b49ee353cso28727765ad.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728141954; x=1728746754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qpc+gtvz4QF2D7U7hwk6I/PwDTmOhNNc5A8A2G2CqV8=;
 b=b5bH8TzNryOOwnuIPccE5c3jXQcoTLmj3rhK301DiqYSSeqiN2hywFG/BtDwp2cXFz
 qQ88SomeL5d2m86/ddrR3T1paVASX8MWN+ATOdfYr9OC7+UBQ/T4rdVcdHBIP0MHO5Ld
 ZC3wBUHZ1VisVlKtKn02HbJ49qcfXy9pijUw+FOVBgg9PTlU5ri2taTePGH+UljZRWbE
 rTpqTcWJDBIXl/c6cFj/DRkVBi1BmoFLCxyEk3Q9SkLLEofbYyZgBQdGlqGHSuHKznXI
 jdGWipLdEI8UGiqx6LYR7tIWCqXhtBvU5P+hAJYUBYF7jz57sj48w6NIaC64iRjGLNBU
 EjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141954; x=1728746754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qpc+gtvz4QF2D7U7hwk6I/PwDTmOhNNc5A8A2G2CqV8=;
 b=v8o8cF3wzBNwtSe8as87X/Z1ju8X1VnZn7REqwlDFRe8hbmaFmpruPJcJBKeBJ4ZI+
 P47QQRk8VceTQNQbvUJm3RNlQ6N8SYr9z9C6aV6Eg98/tL/f32JFDXbdqGytMZFTNoLo
 beeoPAVFuxrD81cLy07OuLPkJ+sHkbCj3qoFC1mJW3soX6dNGmazZ74P2VVjmmZpTYW5
 XAlbUceLYzjeDE/ATnn5NxRCGavHhhn6zjImF4YY6dO0KUXh7zqaHwWKUv+ECjoPmcTe
 SgWVRJomncZpHpy9ksH4GdOQ25vKIA47RCqHQHwIkjFaCfuOGrwuLVIUMgLZfLqHQ4yD
 2/CQ==
X-Gm-Message-State: AOJu0YyijW5WyFzmFXV1C5bNwcjTKHpBLBMIJBx03URX/X8LS/v/aKP8
 T789MubXKOTSZo9LPv4pO60QDhQbgH2JRhe8pnBHuYWMp82XbZHvtIxaJnEwcmq4s8roGeR+GrM
 S
X-Google-Smtp-Source: AGHT+IELKa52UOR7Ytz4WC8NdW2qQ7qz0VWYMH9P15Fb5pfsJzTN9y4328hD9lJpQGFW7j/3iwlUjQ==
X-Received: by 2002:a17:902:f68f:b0:20b:54cc:b34e with SMTP id
 d9443c01a7336-20bfee34d54mr84315875ad.51.1728141953851; 
 Sat, 05 Oct 2024 08:25:53 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396948dsm14351765ad.225.2024.10.05.08.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 08:25:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH 01/20] accel/tcg: Assert noreturn from write-only page for
 atomics
Date: Sat,  5 Oct 2024 08:25:32 -0700
Message-ID: <20241005152551.307923-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005152551.307923-1-richard.henderson@linaro.org>
References: <20241005152551.307923-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

There should be no "just in case"; the page is already
in the tlb, and known to be not readable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 117b516739..fd6459b695 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1852,10 +1852,9 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         /*
          * Since we don't support reads and writes to different
          * addresses, and we do have the proper page loaded for
-         * write, this shouldn't ever return.  But just in case,
-         * handle via stop-the-world.
+         * write, this shouldn't ever return.
          */
-        goto stop_the_world;
+        g_assert_not_reached();
     }
     /* Collect tlb flags for read. */
     tlb_addr |= tlbe->addr_read;
-- 
2.43.0


