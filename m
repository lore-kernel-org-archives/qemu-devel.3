Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F562C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7l07-00024R-9p; Wed, 23 Apr 2025 21:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwt-0005B9-EH
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:19 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwq-0005VC-C6
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:19 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736c277331eso1610893b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456415; x=1746061215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8LpPYWP0OXO9mhIHJpVptIpUQyJvCDi5tzk8x0yv51A=;
 b=SeJm7nf+n4NgKctRLuh8sA37b3Z/UB72aZ4mcJPC5Ne/WhslEc7yeDRuJmaGoUelj9
 z4ScNwSaAxGcYmLb1ojIlr9kXdRqUCJ2SiLVeSljYia5fHvDiq7qYZU3GwjLqnVhECsX
 vX0/NtUN5tkY7viY8QnzcxOiUvLWmi+rM4tOnV4KEybFA8g8AsNyBOduyu0X95A2RLfp
 +iuOCVP4oXmhlxfVNerm5X7r67uKZdw80ffqZh/bAZxz4XEKRuxlGjOeUSgRd9UsbuEM
 uFWJPpd3dBN15hZSuglxYf+J0Yi4REpr3dpa6PjS2T/U3T0hu4DTGUCcakRwomNeVBYp
 U6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456415; x=1746061215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8LpPYWP0OXO9mhIHJpVptIpUQyJvCDi5tzk8x0yv51A=;
 b=sZZmTzbMdcA11ehGXlBba6CXSN9mu60gF8onwKzksDdysSRzcqJs9PjeZ7jJXxfc0q
 HuIE7n/JMyj/pK6zHFNhCAcDbcnMQOcIT3reN7nSMQM4oDTz4V0e3uO1i3dNB63Lhh0h
 tZ8ZApGA3CQsSvH8HVemoF8qrbRCEqlmqhAv/UkbyFGM7xuwnrl0o88ukQuukiJHqoOC
 96zpvCA2WYY7/ncI7Gtkr5pJElDsOKGx1oJ2oA8ySl8i4sAgHWhIsYUpGRXljrELAKJz
 AJde3/YtvVBhYz5L49d+TvE0PzJTFr9/vGXtI+ouoaOrq51qfRAotV9AANe6yZLESoXy
 bxmw==
X-Gm-Message-State: AOJu0YyVlyTlkHWUANR76uuhAxwV65gRVLxUKVrF043sm0BDXpG+NoSW
 lBLj+ccN5y30IrbGyEkvW3VYKz2kQgaCvy1I7B3E6Sqixt+ZLZr0fwsyxuIK5+H0tJYqzfv9JnB
 d
X-Gm-Gg: ASbGncvozLhujewzZWETVZ75MOGKMr1TeQ72u9tWjm/yKWZ/AlKLflptEPDGsAy79v0
 rv3nW6BDD5qBA8dH7qBd4jODPKDkrJ3d3t934zDeomjKTvzk/zTxh3ENrJBcX7uAQ+3k348btg8
 2NfMQmaTsMzpa+tSXTJAWK2hbF9y/ruv++rz3WVWKAY1Sm3Cqa52vkkBH9hTiacrLn8PxkyQTs5
 D1olHAgqYd/QBLqJOPslPxfvrwIjVbGM8K0Fi0dCqruphRxed+e+WWvGWuGjbIFAv18VXNbK5fh
 puZIJ2Cq3qwa/G0XwQaY4cjO1SKS3jWjF5sts8h2YS8HOEXqvSMLwgzbHp3FFt1Uqsmy4VcqPpU
 =
X-Google-Smtp-Source: AGHT+IHLiKb4D4uMC81eohYAaV996Vx4vl613Jw7IcZE4D6jF1qupAnUFtCrbHr8Sczo4kX86jpsrw==
X-Received: by 2002:a05:6a20:d48b:b0:1f3:20be:c18a with SMTP id
 adf61e73a8af0-20445eed23amr610692637.10.1745456414938; 
 Wed, 23 Apr 2025 18:00:14 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 136/148] tcg: Remove use of TCG_GUEST_DEFAULT_MO in
 tb_gen_code()
Date: Wed, 23 Apr 2025 17:49:21 -0700
Message-ID: <20250424004934.598783-137-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Use TCGCPUOps::guest_default_memory_order to set TCGContext::guest_mo.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7467255f6e..c007b9a190 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -353,7 +353,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
-    tcg_ctx->guest_mo = TCG_GUEST_DEFAULT_MO;
+    tcg_ctx->guest_mo = cpu->cc->tcg_ops->guest_default_memory_order;
 
  restart_translate:
     trace_translate_block(tb, pc, tb->tc.ptr);
-- 
2.43.0


