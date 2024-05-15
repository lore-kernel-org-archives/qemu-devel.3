Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93D0C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79RY-00043H-Sc; Wed, 15 May 2024 03:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79RW-00040j-2J
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:52:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79RU-0001XY-Ct
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:52:53 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41ffad242c8so34398895e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759570; x=1716364370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1bT30jWis5RNXLNoiGpiK9Xlgt7r4X1awl1+hpB8zY=;
 b=yplCe7JbWnPJdsuOFXOMEIsGxXnjFM4+QOd7/LCe9ijMU9qIpkA3FUTQHMCQW+j33y
 aSo7GTP9ffAoWeyn9AuxGnoSjS6XdI4QR8m8b9zREiMXCN/F6IMmExcEot6Q8Fd6Vl0e
 by9RK+5poqpcja7O3fLwfzTulW4A+qK1+UlHdSVfAGSrz46KMm9ZiX4uUurtM0ya5561
 HtJpFK8MW3zBOYUNd+U0W+fnaptGzfn0vrJ76xewqQCsrF7KenrQcHQby4nDgdpZzPHr
 UReCLrP+1wVzK1k/Mz+BQ+h0fTJ4O76IUdhY9ZFU9GAfzXJoxIysoNcfJ78LLOJvvPXp
 AE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759570; x=1716364370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B1bT30jWis5RNXLNoiGpiK9Xlgt7r4X1awl1+hpB8zY=;
 b=V/lwgEIrSRrF4fM+u+yvJ0S9XGCrPghcA8N5nfh5EnYy0MoDHbIixRB0i9Kj8Dbi4P
 gat7eKyhlId7xXbTVzkxDbbP/HGkAEhS+YthQcGLALleYAKYmLN33mKgjrq90GHPTu9D
 pe7Z6SKEvvXe2hCvDVmAlvmTnhDOil9LWgYODhomiLQs7VPh4YZlmuvllatU+l5+AaMt
 VQ79fE1UfMl4Rh0uHc0Omh8s610pevQjZP82O5SokftPVZdew6fvEG71k5c0xn9fRME5
 lrb9N6wER5Y3G6CVHh50UPHiMnSoKyF+RVzTu6lQJqC8Et1aOHgP4MV36Qyo3L/ZS3qo
 OC6Q==
X-Gm-Message-State: AOJu0YwExiwmqZXGAOD6XfbH3QFIIR5boenju++h+nghbHTFmkb17OO7
 zL+9vml1rl5JIUy5eCrgYmfngNvnYmKpWzVmQuYliziltN1/GQHBnuGa9TSrYH4egPUuYlNol5T
 +p6c=
X-Google-Smtp-Source: AGHT+IH7tcxYZB5nzEFXg+irH+sl2SY9hRnIfUaQLVlQkfpgvzKVy1aLJKwDo1JJGOB89FT/y+1sfw==
X-Received: by 2002:a05:600c:5490:b0:420:1aba:5030 with SMTP id
 5b1f17b1804b1-4201aba51c4mr53125065e9.41.1715759569803; 
 Wed, 15 May 2024 00:52:49 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:52:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/34] accel/tcg: Hide in_same_page outside of a
 target-specific context
Date: Wed, 15 May 2024 09:52:15 +0200
Message-Id: <20240515075247.68024-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

While there are other methods that could be used to replace
TARGET_PAGE_MASK, the function is not really required outside
the context of target-specific translation.

This makes the header usable by target independent code.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 51489c181c..212362f5a0 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -232,6 +232,7 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
  */
 void translator_fake_ldb(uint8_t insn8, vaddr pc);
 
+#ifdef COMPILING_PER_TARGET
 /*
  * Return whether addr is on the same page as where disassembly started.
  * Translators can use this to enforce the rule that only single-insn
@@ -241,5 +242,6 @@ static inline bool is_same_page(const DisasContextBase *db, vaddr addr)
 {
     return ((addr ^ db->pc_first) & TARGET_PAGE_MASK) == 0;
 }
+#endif
 
 #endif /* EXEC__TRANSLATOR_H */
-- 
2.34.1


