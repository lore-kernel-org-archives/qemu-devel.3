Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A719C021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pZ-0002BZ-Cg; Mon, 17 Feb 2025 14:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6os-0001t1-UO
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:20 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6oo-0008H5-2u
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:17 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22104c4de96so35833855ad.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820611; x=1740425411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XZB9FMvzvLrWKeW4/rUSQyapeHEL3MGiTY/vrabN1tc=;
 b=IDfu1VjLatjsdJdGll1rOvH+GqnnvoOY16gHAXQysmJ80sn1+SdCBAzhqnfdvT/R7+
 QUYqZQhUM4MEscyqXPh9oNr4QmRzzlxIPD/6kKC9HNHGDXtrqkE3Z9MSBQ95HayOAoPv
 yyxUwujF2XFhlLvubys2msNzQ0dEen9w4nCZB+M4jZo105bJ8Z5v96Ak7J14lqcnU50j
 UWRIuqxD5x4Yhdap6e/ud54llAc/l6xH5bFZfLKv3U4BKCTmyF8ttl8dtd1CbcPlag6N
 HJT4JhSb5ybuk4oZvrsYFF5wqbM/yUO1JFo/U6W0PUTM2aMeM4vZ2z/qfS6AiLilrMui
 Fq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820611; x=1740425411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XZB9FMvzvLrWKeW4/rUSQyapeHEL3MGiTY/vrabN1tc=;
 b=FoJbsTEaUAKQcoWdDkX3TGKpabwaN+h8a1Xw46xvhTl8CeO5wY1JTpoZCFrDOmWXF/
 xveV9PFJqOQFBQZPHFlS40ZW6eTNyeZ/mei/QVqqcKMejQ9XrZpt8NkGY4bDVPgDY4sa
 +hPpvS5w0EjZRFGaCazo52H/Jmj5yCfqT9dmiWZFsYrH7506X2t/DBxUuEpZjbyF4mlS
 01hKlSl7zFHWJWd0x4oVwoigZ6UGUIEjy6rauLRe8bklnqTK99EkRIg+nAr+rRa7MpiI
 ZtERDaG9qglL2leBmP2YQHW1/pE7gNnFunyiawB4edgkT0DmJsgW+Y6UURT53V1J6loK
 QQCg==
X-Gm-Message-State: AOJu0YwM86hDAufMTFrnzNff7anhETAEVvx8hH1FzqhM1igZjzhKB48R
 UU/5V0DDWAObSNGETG4tuqYbu9HvsNFe0fpP27ZRPLz+JqN3lr+P34JdnfX9MM3vMSteGA+1zdI
 q
X-Gm-Gg: ASbGncs9A5bxrRJS0lhqbLUcNCYHrmAQ5o9qn3EZRK0Nx8Fz7F8dJznMwxrw99rTzcB
 H+RElB1cVqqx7N0JhcA5XJuMSSSKloI21XwaGIkZDcJbZtObKJ1fJ4ppzBLbIHCBTroRDNIs/GY
 6+Fy9ax4/LbRhQySgGDI9uGURrP1tKTn/lJ+XbHxGNQzlJJS6WfS39Kyc/g07bihBWtU69Mxg5n
 TWBfzYsOnqdNi06ZiRSy6/5N5n3Vm+A6+vza5zBtyW/BD/MSZ4vaKN5VyyAIUGsMNhc9I2XmIK4
 2Y+3J36zw9OPCZbYdyzT3+/qRbs+g986W2DuH1dazBPh35U=
X-Google-Smtp-Source: AGHT+IE708at6Ms5+MMAdfvLjHSYC+9M4GjaxOKQaHxfkicvo2sOasujKlwi9SkESX6k7menrWqVNg==
X-Received: by 2002:a05:6a20:a107:b0:1ed:a6c6:7206 with SMTP id
 adf61e73a8af0-1ee8cacc9b8mr21579391637.8.1739820611058; 
 Mon, 17 Feb 2025 11:30:11 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 01/27] tcg: Remove last traces of TCG_TARGET_NEED_POOL_LABELS
Date: Mon, 17 Feb 2025 11:29:42 -0800
Message-ID: <20250217193009.2873875-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

These should have been removed with the rest.  There are
a couple of hosts which can emit guest_base into the
constant pool: aarch64, mips64, ppc64, riscv64.

Fixes: a417ef835058 ("tcg: Remove TCG_TARGET_NEED_LDST_LABELS and TCG_TARGET_NEED_POOL_LABELS")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tci/tcg-target.h | 1 -
 tcg/tcg.c            | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index a9ca493d20..bd03aa1bc4 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -72,6 +72,5 @@ typedef enum {
 } TCGReg;
 
 #define HAVE_TCG_QEMU_TB_EXEC
-#define TCG_TARGET_NEED_POOL_LABELS
 
 #endif /* TCG_TARGET_H */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 43b6712286..53de13df71 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1598,21 +1598,17 @@ void tcg_prologue_init(void)
     tcg_qemu_tb_exec = (tcg_prologue_fn *)tcg_splitwx_to_rx(s->code_ptr);
 #endif
 
-#ifdef TCG_TARGET_NEED_POOL_LABELS
     s->pool_labels = NULL;
-#endif
 
     qemu_thread_jit_write();
     /* Generate the prologue.  */
     tcg_target_qemu_prologue(s);
 
-#ifdef TCG_TARGET_NEED_POOL_LABELS
     /* Allow the prologue to put e.g. guest_base into a pool entry.  */
     {
         int result = tcg_out_pool_finalize(s);
         tcg_debug_assert(result == 0);
     }
-#endif
 
     prologue_size = tcg_current_code_size(s);
     perf_report_prologue(s->code_gen_ptr, prologue_size);
-- 
2.43.0


