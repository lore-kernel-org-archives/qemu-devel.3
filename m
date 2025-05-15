Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD165C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVoO-0006NR-CQ; Thu, 15 May 2025 06:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnc-0005NJ-DV
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnV-0008Fl-9d
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso7149225e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304800; x=1747909600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M4wis+oyI42kUUV62F9CkVaRrtKVkEpqI4xQo+H0IZg=;
 b=tnHJQNA1GFqHW6c5plNcxqIZGLgppruWW5wt+JWdI95RrebGnV24LGqrw4PY87Fl7z
 i87J0O0iwfzNZkmarl3U6sDqmx803CVBqpoD/XO1bp2BAQKW0Kl+B3CTvDIJqMHs0Bd8
 2FC46hSsiWfFbv4tHDvxGzmHNUBr/FATwvQQYkv84p0irFTasw14cgdGELAfNrZwnzlu
 V2K09ZSl6Y3Spo+VQwm6lmMKoRJA/R+Aj9Gy1o2v/qYEIoNXK+d54J5vtSm2wRHbA0iR
 6HV7nF4EVb6R7N4iCoUSLg11syN0AAn/wNf6pLCuczjRMYnDHKkcDppLKEPlzm5f7c/r
 jN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304800; x=1747909600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M4wis+oyI42kUUV62F9CkVaRrtKVkEpqI4xQo+H0IZg=;
 b=l7Yfl350sf/63PHKn/cIciPtW7K8RPKv7n8oSpCHXuT3cvShKuy9nryY83YdGFwLEO
 1EiohXrNKfy5fAS94NUsebzKmuJyIhWD/PFgz/POQI6pNRj5b7/m238kkMleXH/NIPgR
 oRTfEigujAY/sROOIXvWfDBlh37GtQyGGs7crHwhwqODMuIr4woUC6mD27tRUICM/TB6
 +wfidRfc7NRXRTjc88dpdnmXutNOWs5dqtk7dnBAkb+jAUJyzgejxC28P/k49MNY4rwg
 I6R+xTmVqMJQ8nyKcFFWgp0xLstSTQDxwdybs+CFzJ5gTjPQnAeZAL9RbaGqTeROXf0m
 hp7g==
X-Gm-Message-State: AOJu0Yz9Nr874oY0wSHhZnM6OYHUdGbABtD2gPO45aTlpaV25yuYTJ2u
 +ncNSDnjen1I/esqf2AIUQEtcWXgIencCml4g9pjVXIampJNHQQjbTwQ6S4A0MFgD7XfgN6n6/5
 anJE=
X-Gm-Gg: ASbGnctMjpuozQgcQzmRFAKNdLZDBNIYqj7geMLjg16JTuU/EXw5oXCvvje/gzZNL1V
 Hi5jBotlb2IbdOcf958/bqkH5jRDqRon3c6aM412a16qcG7kbwKi5Hys7oK9c+wTAX+jA5U1saH
 LS9fPyiWkW1pM5d1Xz4/Enzev60NTRa8FyZemH2TVuSbDr9urrLwkgvPWwhNzpyB60OJ+rk+WuI
 EIQoj4lycsxA2KjywWtFlsckUCv8nZmyjwRDuxYdohQq6642qe5kc34UL7oVP8gZ+32/g+k/jZa
 dIUsgA8HFahkadrH7iH3+VnGmGVSdZ8ZeGqZgYFz42CIHc1dhW7fHwUOLQ==
X-Google-Smtp-Source: AGHT+IG3Vj/Ca8Oyuo/RAc7izkJhAKUzIiMozfQh21LGed+zkzi0rFkSu0v9Kdnq6DxkYHJqpTFjPQ==
X-Received: by 2002:a05:600c:4e09:b0:43d:1b74:e89a with SMTP id
 5b1f17b1804b1-442f96e8949mr19607585e9.9.1747304799641; 
 Thu, 15 May 2025 03:26:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/58] target/arm/ptw: replace TARGET_AARCH64 by
 CONFIG_ATOMIC64 from arm_casq_ptw
Date: Thu, 15 May 2025 11:25:28 +0100
Message-ID: <20250515102546.2149601-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This function needs 64 bit compare exchange, so we hide implementation
for hosts not supporting it (some 32 bit target, which don't run 64 bit
guests anyway).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-31-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 68ec3f5e755..44170d831cc 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -737,7 +737,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
                              uint64_t new_val, S1Translate *ptw,
                              ARMMMUFaultInfo *fi)
 {
-#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
+#if defined(CONFIG_ATOMIC64) && defined(CONFIG_TCG)
     uint64_t cur_val;
     void *host = ptw->out_host;
 
-- 
2.43.0


