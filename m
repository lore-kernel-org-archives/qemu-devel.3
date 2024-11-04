Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196E8D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7koX-00073x-Ad; Sun, 03 Nov 2024 19:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7koU-00073I-IK; Sun, 03 Nov 2024 19:19:23 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7koR-0002Ds-CE; Sun, 03 Nov 2024 19:19:21 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21116b187c4so22346915ad.3; 
 Sun, 03 Nov 2024 16:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679557; x=1731284357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=moXUYmUT2iEbA51wj0j9OUXY0sQDkte1US2SvpeeNdM=;
 b=ikN1ERi+D3pyKTkHUJhRaNO6hWoki5yGbQODK9s2W2QMnvYRd+inL6W2ZafghusuOE
 OQNcYfP/m+rgx0Tdzca8PxMpgJ8FGsgvfQziy7xBF9SgpdQVh0fNkwtY8cGp3AnLFaIh
 bE9WwnkelafO3AtG5qhMuz4sZESan/ob4TzhPktTbRE7znaGHti8ChVf8dXy2KdwkYtc
 SDNA6caP/7P2qDGIB69V9NQxxnWJ8UOuoKAD3SmY81awQ4czYU84pHW8z+bqqqEORfQF
 /UpbODx0R4JaFNt1Bisfp7yvO/CjU+a1Q2RcJehKnvrW9bAW06jmRjLkC0gVDVpkaLMx
 xeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679557; x=1731284357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=moXUYmUT2iEbA51wj0j9OUXY0sQDkte1US2SvpeeNdM=;
 b=nTArBTDn/0lrT+iB3boCcf+VrE24B2rfX3ASis6xvfZGP6dOphz8h+lDt5nix7uXto
 RULyQ6EbGBIaB6MJfDaTmkdRELK5yTpXlMQEfjLQ34EpwUiNKxbEbUYBvRcuy+ONUbAF
 cuFD+mZs7sMU0B1Fr0gTzIWbr8JlrpssRegH37/LL9iPtMA1ODMh5Cp8cudul52Dlyev
 UUorwVq/W7H12Qztf1SWLjfuwmjIxR2HCRSo1PqR/q/3jqqe3om7J2oWv3N+zw0MdBST
 q3OaA1JSahxJZ5I/iatXLzOWvBefvdYQRko/XTMQ0VV6tA3micCr1pfds7uY8KbHxm2a
 Np/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWchtbNPE1yWv2BPAUG9BYw/uJCicL5FbgjdO6UV0MrLbe3vOLTSvyuviLsQ1aNiz2lSJuAG/Fyvw==@nongnu.org,
 AJvYcCXs4Q2BbMS7/7koLFZVkOmx48zpTdd4bmFseFecEYIQaS7Sg3uh6tdAKpPy5hjTfFImxOBtxeWdz/9E+AI=@nongnu.org
X-Gm-Message-State: AOJu0Yzg5STZkPCc7ZogWRfFCkO2KdOWduSwcKZpDOJ+80NlWIwwbPYH
 HdNYqcfkk0rzLPlejMMyvjmHk50bYg7u/1DthCLGbs+RmsRxyrEc1RN8jQ==
X-Google-Smtp-Source: AGHT+IHjw3SgxGmv5hJ6XRK51Q/72mSVWi94IMEx0C1wu8AFQvlj3AeVWvK3mkFhwQoldPkcHrZ3Yw==
X-Received: by 2002:a17:903:1c7:b0:206:a87c:2864 with SMTP id
 d9443c01a7336-2111afd6ca6mr121910665ad.42.1730679555374; 
 Sun, 03 Nov 2024 16:19:15 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:19:14 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/67] target/ppc: Set ctx->opcode for decode_insn32()
Date: Mon,  4 Nov 2024 10:17:50 +1000
Message-ID: <20241104001900.682660-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

divdu (without a dot) sometimes updates cr0, even though it shouldn't.
The reason is that gen_op_arith_divd() checks Rc(ctx->opcode), which is
not initialized. This field is initialized only for instructions that
go through decode_legacy(), and not decodetree.

There already was a similar issue fixed in commit 86e6202a57b1
("target/ppc: Make divw[u] handler method decodetree compatible.").

It's not immediately clear what else may access the uninitialized
ctx->opcode, so instead of playing whack-a-mole and changing the check
to compute_rc0, simply initialize ctx->opcode.

Cc: qemu-stable@nongnu.org
Fixes: 99082815f17f ("target/ppc: Add infrastructure for prefixed insns")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 7689b2ac2e..be93777cf6 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6423,8 +6423,6 @@ static bool decode_legacy(PowerPCCPU *cpu, DisasContext *ctx, uint32_t insn)
     opc_handler_t **table, *handler;
     uint32_t inval;
 
-    ctx->opcode = insn;
-
     LOG_DISAS("translate opcode %08x (%02x %02x %02x %02x) (%s)\n",
               insn, opc1(insn), opc2(insn), opc3(insn), opc4(insn),
               ctx->le_mode ? "little" : "big");
@@ -6558,6 +6556,7 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     ctx->base.pc_next = pc += 4;
 
     if (!is_prefix_insn(ctx, insn)) {
+        ctx->opcode = insn;
         ok = (decode_insn32(ctx, insn) ||
               decode_legacy(cpu, ctx, insn));
     } else if ((pc & 63) == 0) {
-- 
2.45.2


