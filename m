Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3FDD68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcIj-0005Lq-8v; Thu, 14 Nov 2024 11:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcID-00050r-Sb
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:05 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI5-0002Fw-7B
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:54 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e5a0177531so675744a91.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600111; x=1732204911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZzUqo5EQVmmILWK3/HrkYlBd4Dl5eFiN4ejkIAqPzrI=;
 b=arhER/1wqg1QpTgXVPn0NDZBKZSxaiE1pt8lAv5E7XFewOz2gWk0P6b7bEQAdFDxiM
 yCBjAEnGRjMSHd58arzyUHefPL0LZuFMRNOITl7t5OpYkJPk81ckp2+ChlXbEqC7+4D0
 Gkjh3oGFwOYk/jIIJM8tmOLKatsn0/eOzlz0HJgNieuQjzJJKZcLfzVurpXmCtPi+jPj
 MCpw6xTw75ivUW7ezfF81R1nUwsjnIeBMvI3P4nMfdfOjC+/7EjnTB4n4m29C/ia/JId
 YaNvXJRCiscZzy5Y8FbeDvgQvN2U9cr3nRvn8o2ZHH/N1bp2Yv3FlP3omIvmvINaAumJ
 Eelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600111; x=1732204911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZzUqo5EQVmmILWK3/HrkYlBd4Dl5eFiN4ejkIAqPzrI=;
 b=a8UCiL/vjeFnHvDRidBZSB9ApfhtRq/Q82v2FeoL4lbWrFj8VsDxGH2JZKQvAeB6YF
 94UWwfJDUlxivMVcOioc9DKbA+68yNmtiXi03POiv+7mIkGRbEFGJtA6z6+JmnuXGkcu
 6s8Wj6gnZTYIbW8psX+57dxMKsChg0Iub0IsUiJ0iBYaRlXXV9fVw0/YSZetFJDzCLWD
 1pIHqzNVV97XrIjP/vcC7LC4ePOoJWKZL3waHtk3W47FCj07MkqS9rzklaVSUWFnZPKJ
 /38s27DIZNIDUTk1pfaVS3NIg+gzmCzKLJ5qB78ONQBnb5X/x8G5AGBJMK7LZbtMDqLW
 2Q6Q==
X-Gm-Message-State: AOJu0Yzow/j0oLzGsY0bAConhPJw4X9UQdU4Q95MDhbDJ64kqXhzO8lx
 D5TmM8+a8Q3y3oA+G8Zs7ahwTaTV/1cCk8q5D6hW+b5h8l8gjGJpfNDDEoPGu5DcvSr7FUt2WWO
 O
X-Google-Smtp-Source: AGHT+IEC8cVZjuJs8fTcgyRwOAB4vOr7dnWsxczMYwi3IO/oI4UAakxoV9jKUiEFGz7BQpnwwUHAUw==
X-Received: by 2002:a17:90b:1a92:b0:2d8:82a2:b093 with SMTP id
 98e67ed59e1d1-2e9b1720e9dmr31250421a91.13.1731600111017; 
 Thu, 14 Nov 2024 08:01:51 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 22/54] accel/tcg: Call cpu_ld*_code_mmu from cpu_ld*_code
Date: Thu, 14 Nov 2024 08:00:58 -0800
Message-ID: <20241114160131.48616-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Ensure a common entry point for all code lookups.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a4c69bcbf1..c975dd2322 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2924,28 +2924,28 @@ uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
     MemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(cs, true));
-    return do_ld1_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
+    return cpu_ldb_code_mmu(env, addr, oi, 0);
 }
 
 uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
     MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(cs, true));
-    return do_ld2_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
+    return cpu_ldw_code_mmu(env, addr, oi, 0);
 }
 
 uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
     MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(cs, true));
-    return do_ld4_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
+    return cpu_ldl_code_mmu(env, addr, oi, 0);
 }
 
 uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
     MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
-    return do_ld8_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
+    return cpu_ldq_code_mmu(env, addr, oi, 0);
 }
 
 uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
-- 
2.43.0


