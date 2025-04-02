Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B77C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05IB-0001ug-ME; Wed, 02 Apr 2025 17:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Hu-0008JH-OV
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:18 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Ht-0006u9-4T
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so168508f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627976; x=1744232776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DEIV9zcZk88OsjudhO3DMZjQE510ySSdH/jatCIxbLM=;
 b=U+8nEvTdkRvHXUeejFiW/ahlXtGLgLnwkcntO0GRdW7OK8tjlpG9moZASalHHbrQc8
 1nGH2m0ZvSeeItNBML5kL1M188QiWXlXqzdu0UIgQWaFyvUv9h0bqp7uuxyr7kRs21Vi
 7C8LWOsJnw+x5jLhiunZq8I5vCAprz04Jka2IDreiRIGI3Y/l0rtD4o6Bm2ui5sbdvic
 lZkrAvfPnm+5sPColClzQtdsW5wDhKoUBp1rPBLIv1rF2fDpUXPngfhGbp1s1T6XWt1l
 2gAo7X2cNFVtSmz7yBNz2yr76YY83hri+iu+i6iE2TBmBoP+CJRoyx7jzYNK9VP3mZ7v
 bRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627976; x=1744232776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DEIV9zcZk88OsjudhO3DMZjQE510ySSdH/jatCIxbLM=;
 b=n62gr+mBHWg/5xTSPikMglvCTRrk6xmSwmLL89OmFQS8AHf38D054qjbnFxylKLvwW
 H4D9DHeYjD35wFc3rZrRkMB+QZn7NOwOxtZqlbj1HBVaVpChH3LPw4UJponL4hgzZH4r
 t4Vo8qGOpDqz46BwivThNq/xMWg4ez5eMs98+eLosarzTRIQOuS94koZWx7y6wJqEwx3
 j97mz/s0CbrTWPjse3AFUOSzkAB0S5CKG1BK4GxN5MSxdMd6VJrGT4VFZvE1hrRToliz
 CBVIG89vexpAKy2+PTLXehxOAYnZtMJqegTNMXg1jwcnCqu4BbRYvlpuORwrq5xbp6ba
 2FiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBreDxELZBqMi8s3/ect3EiiVIYN8b5bwTZkbh9uZyLSrmxBj9FFRpnRAtqwo2RrZfi4Eyoz7fuQGN@nongnu.org
X-Gm-Message-State: AOJu0Yy6Wa1R2Md15MYdGQvc4vwsxdy7s9f1D58oElgRXNYwf8HlceG/
 j7pnaR2Pfj5qEW92bkK1hJpj2Ues+mZrqcY93yxNwmfjesTvjO47jytpLibJOUWEetEW0w1g4Rp
 +
X-Gm-Gg: ASbGncsnVFU0H3E9mYUL1F1wpAO41dH2YiYhBdrwOouPvWDpfF6rqWK/W6NhdDJEoOK
 vxIBDHH2FGJ5UCqz8WsO5lHHX3HhOm0cV+OD0dPGUrll5z4jwajB8rrCuq3Y+z+0u0lf1JDDPOy
 EbFyxikltCRtLv0w9fRJMNnL3zvcf9JDduZpkw1QNXqs1sjVibPyUuc5MfdjO0w/lsKv8CcrgK5
 Z5mLP9y6qaWOjFSU18UJYeTDg4RUgfzM57Ocg34P6D3QuaJmkRJUm8tuagjcm1bXFSfa6ToAphS
 qELUi3w7C6684L4f44UXFriwOw52DIiisNnxUnMQoUTz/ulNXjKgMNZzfgzdhcjdhCzA+yuAXUb
 kdhcWqlxZr9YUJbSL/Pl+A6a659srWw==
X-Google-Smtp-Source: AGHT+IFDV1qFPljqppkR8lSFCg2BvaUgh2MYut9IUrSjYCilGv6fDq1lSXdZLEqYFD675Xp1Xc6rbw==
X-Received: by 2002:a05:6000:1889:b0:390:fb37:1bd with SMTP id
 ffacd0b85a97d-39c1211beabmr16986086f8f.46.1743627975741; 
 Wed, 02 Apr 2025 14:06:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b663623sm18153657f8f.35.2025.04.02.14.06.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:06:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 34/43] tcg: Remove use of TCG_GUEST_DEFAULT_MO in
 tb_gen_code()
Date: Wed,  2 Apr 2025 23:03:19 +0200
Message-ID: <20250402210328.52897-35-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Use TCGCPUOps::guest_default_memory_order to set TCGContext::guest_mo.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index cb1cf270888..9a9ee0502ea 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -352,7 +352,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
-    tcg_ctx->guest_mo = TCG_GUEST_DEFAULT_MO;
+    tcg_ctx->guest_mo = cpu->cc->tcg_ops->guest_default_memory_order;
 
  restart_translate:
     trace_translate_block(tb, pc, tb->tc.ptr);
-- 
2.47.1


