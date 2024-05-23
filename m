Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2457C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHYE-0007Tm-U7; Thu, 23 May 2024 19:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHY7-0007Np-P8; Thu, 23 May 2024 19:08:40 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHY6-0005iN-2n; Thu, 23 May 2024 19:08:39 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f4d6b7168eso3008381b3a.2; 
 Thu, 23 May 2024 16:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505715; x=1717110515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4d7XUcJzCAh2lNbuPfDveI1FIlIsOOzA/QEZslDQGY=;
 b=Nuw/LqW5O+kzjF2yQnDhA5Fz74Ged37hGB7RcfhKDCsQGbVgRWZfuEonfcLQiTmO/3
 1K3C+uMgnZPJmmp2h5KE89U9Fw+g5slHdxtidud/CYx1BgrmNtdLXUNna5xndr6Aptgm
 Lci3jjdx3q71rypjMa7Ad4ZgFbCwPKKxGqQICOHsfSJ1CWKZC289PjUINegrLyYJgUIe
 L4Da8Wyj+iyScufHdglXl2dkShqjEx+yu9KuiR0FXLuyID6PUyqNbcpmHdSWH6KcxKcp
 0/3Hs9hmiUVIkhTZitqdrdzj42cY+YQtc4adJBx5svN+WHRzvctTF6Wk56nqtmf6iLl9
 MB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505715; x=1717110515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4d7XUcJzCAh2lNbuPfDveI1FIlIsOOzA/QEZslDQGY=;
 b=lggjHPM3PsBvk/6jCbG6PTcdIst6iENgxQl8ThwxspEdoQHHa5zrzaDD1FcFrdTRiQ
 U9fy5alGORovQdN67TMR2DvUpeUWJ2uLMJteqAzRJh2e6V9gb8Z/D5Vym5ML+9oeh/vr
 O6fqqx6ThOWt+twUnSFWLZMAZIn8KsR3yB4QdriWsGNy5nUAnJ9Qbfi8yqzuKvH3WXR2
 t3JeNOgyHYACD8A745siGuAP9oA1dSWk40hEDcAlSiUtVNzPtQQNbBnnJpK4/Msf48Lo
 JMHBEbYYfuwht4tBqnu2s6RlsqF0Dk6I3QN/6LE+6eQdtBuo0V3fXhqdQSWCVklj1HZg
 k0Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo/fLyWMWd4XOkNKU6OBMOy3q0R54IyufQ/zktidSdqrSsrn5yrNuJ+XxeoxuhHoiwnsXBbMM/yhc5mcYy5kOkJrIN
X-Gm-Message-State: AOJu0YxiNLNy2vSU9rSZp43wCvJiLFyJnomung4V2pbicPydJzcbDKyP
 PtKJkppZLmUr6obAW8AuqM0kat6fSMyrqn5Kwi7DRN+LXoIYJhpXM6UHrg==
X-Google-Smtp-Source: AGHT+IE98Yc0aXhnbr/CUOsgUawmZN3GwmXreQ9lvFTiSuRkWkcufmpc8ESqD5XqC4vT3UqZvQ8tGQ==
X-Received: by 2002:a05:6a20:96ce:b0:1af:a617:86ac with SMTP id
 adf61e73a8af0-1b212e57227mr751939637.53.1716505715572; 
 Thu, 23 May 2024 16:08:35 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/72] target/ppc: Make divw[u] handler method decodetree
 compatible.
Date: Fri, 24 May 2024 09:06:45 +1000
Message-ID: <20240523230747.45703-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Chinmay Rath <rathc@linux.ibm.com>

The handler methods for divw[u] instructions internally use Rc(ctx->opcode),
for extraction of Rc field of instructions, which poses a problem if we move
the above said instructions to decodetree, as the ctx->opcode field is not
popluated in decodetree. Hence, making it decodetree compatible, so that the
mentioned insns can be safely move to decodetree specs.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index cb10e33ceb..277d96aa94 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1737,8 +1737,9 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
     }
 }
 
-static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret, TCGv arg1,
-                                     TCGv arg2, int sign, int compute_ov)
+static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret,
+                                     TCGv arg1, TCGv arg2, bool sign,
+                                     bool compute_ov, bool compute_rc0)
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
     TCGv_i32 t1 = tcg_temp_new_i32();
@@ -1772,7 +1773,7 @@ static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret, TCGv arg1,
         tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
     }
 
-    if (unlikely(Rc(ctx->opcode) != 0)) {
+    if (unlikely(compute_rc0)) {
         gen_set_Rc0(ctx, ret);
     }
 }
@@ -1782,7 +1783,7 @@ static void glue(gen_, name)(DisasContext *ctx)                               \
 {                                                                             \
     gen_op_arith_divw(ctx, cpu_gpr[rD(ctx->opcode)],                          \
                      cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],      \
-                     sign, compute_ov);                                       \
+                     sign, compute_ov, Rc(ctx->opcode));                      \
 }
 /* divwu  divwu.  divwuo  divwuo.   */
 GEN_INT_ARITH_DIVW(divwu, 0x0E, 0, 0);
-- 
2.43.0


