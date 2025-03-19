Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777C9C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutjq-00036p-Bh; Wed, 19 Mar 2025 09:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutjm-00031X-Kb
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:39 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutjk-00043G-RI
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:38 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so45642785e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 06:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742391935; x=1742996735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7leHVcf9fCZ+ZDskvBL1qGPxfR0Xmsc8quxcgvFRhU=;
 b=gwVXHqheWO+2cJs/O40M6tvlIKgayHExS7VEm7y0VKwcAdD/bImUm0puMO5oCEDEL5
 aPuvW7XFmoftAoBIKZ8ziMQALeNMIV7OU5go+iYCoJgpaIqQ5sNulCbprbrIn+ooR/1g
 TzeI2SC7vMQFERVg/DxMXewCkEojYxkdf6ITdInRevlW2vboRRJyfFR3JuHEUR5esNGO
 YLYTCg+oOsT5O9G565Wj9vjDeCHFLPM7NOFX6JX5AWpzxPiB+WF+uDIrzl+m0QUUaj6T
 Ml4qyYMg3O7ec13umpUtfIwps6etLWNBgthe7vIIc0DL7a8xixnfmeWBIDVA1Vgm2VYl
 hJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742391935; x=1742996735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7leHVcf9fCZ+ZDskvBL1qGPxfR0Xmsc8quxcgvFRhU=;
 b=Sz+1j0QzxbQV0/bpxGzq2Tellg7nl8mw3R+WOu+Dx3aNE6nK07oGq9F8Qm2WYDY1ZJ
 Q8yUbunPe4Lh75vvQGnRpT3oG2KG67+vR7lFQ4GfP1eH8oTz0rMPDcOY8Erb6E0SL9H6
 bsZUgPlK80yqXtkBcGAmyI3zqEf/Jj3/EJvFkvZdkfl71fa5nAgTBbHkV1Xan0L4/xbO
 1BHqDTLxk70cilnGp8eUlBi869kny2DCAIVSZGBy0W5yGbIsakA4/wNNA1Anjxpte1NA
 ZnKiXmK6o7dDyTSikQCXb1SgYy89ApLfjPCDqxKjCENsWfjXt4S3SCkuNMVVP8uiLc4/
 ZwkA==
X-Gm-Message-State: AOJu0YwiyFG/upWEeoMBqEV4Boi4GrCRfRwBZxvu1dhrBjoUPCfWKuYn
 RMTdyIKYwzweRDPS5mnT707mZvDf9aGbc4fRseXP84Wo6twbJzN8ZGYUxZkrRVPjuMahBNcuyS2
 U
X-Gm-Gg: ASbGncsh+jIGXP0SXnyEtVtervFDEsP6J8np1l4YD8Zx9e6x3uQfbK8O79MffH5GWw7
 YhaMvDZ5pkzSkR9AHBwJW/qZmPDZDqVcau6XuQx9ySHOC+CIJIG8HTNyo0NiWOeIt/kw05nvAmT
 uiuRllsdm4RiWD51sSomE1MDyvjLJJhlvCjDWp2rbYtejriYYYmyW5gqw72WExOolxwM2wLh+J0
 5SwBn8Ak67cVgCm+ZziK4GCWqptPFRrAtOJo83dT8xl9jePeldvnFYZncDp3Y6cHHWHPJmGyRcq
 hMayNbxmUTNsCkFwko9Zg+IsiS7Fajq/yYRK9py8IgL4U+W7d9PoIyjQNNld7YEl6W7SmfDwJ1g
 SRNnFyh8hwCl9cvY4rUQ=
X-Google-Smtp-Source: AGHT+IHowzsDlz7XDNlxI11sQH7TvyH6bYy7a2Ub3+O65e3D/nuew0Fi7ll9TsW82QdifYDaZr25tg==
X-Received: by 2002:a05:6000:1fa4:b0:391:2e0f:efce with SMTP id
 ffacd0b85a97d-399739b40a8mr2548739f8f.1.1742391934883; 
 Wed, 19 Mar 2025 06:45:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df3512sm21857199f8f.12.2025.03.19.06.45.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Mar 2025 06:45:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 05/12] tcg: Use TCGContext::insn_start_words in
 tcg_gen_insn_start()
Date: Wed, 19 Mar 2025 14:44:59 +0100
Message-ID: <20250319134507.45045-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319134507.45045-1-philmd@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

In tb_gen_code() we set TCGContext::insn_start_words to
TARGET_INSN_START_WORDS:

290 TranslationBlock *tb_gen_code(...)
293 {
...
351     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;

This definition is expanded to:

 11 # define TARGET_INSN_START_WORDS (1 + TARGET_INSN_START_EXTRA_WORDS)

Directly use the identical tcg_ctx->insn_start_words variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/tcg/tcg-op.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index e0038e70a8d..1f0d3b95304 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -25,7 +25,7 @@
 #if TARGET_INSN_START_EXTRA_WORDS == 0
 static inline void tcg_gen_insn_start(uint64_t pc)
 {
-    unsigned insn_start_words = 1;
+    unsigned insn_start_words = tcg_ctx->insn_start_words;
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
                             insn_start_words * 64 / TCG_TARGET_REG_BITS);
 
@@ -34,7 +34,7 @@ static inline void tcg_gen_insn_start(uint64_t pc)
 #elif TARGET_INSN_START_EXTRA_WORDS == 1
 static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1)
 {
-    unsigned insn_start_words = 1 + TARGET_INSN_START_EXTRA_WORDS;
+    unsigned insn_start_words = tcg_ctx->insn_start_words;
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
                             insn_start_words * 64 / TCG_TARGET_REG_BITS);
 
@@ -44,7 +44,7 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1)
 #elif TARGET_INSN_START_EXTRA_WORDS == 2
 static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2)
 {
-    unsigned insn_start_words = 1 + TARGET_INSN_START_EXTRA_WORDS;
+    unsigned insn_start_words = tcg_ctx->insn_start_words;
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
                             insn_start_words * 64 / TCG_TARGET_REG_BITS);
 
-- 
2.47.1


