Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECBDCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NyN-00020H-DP; Wed, 08 Oct 2025 02:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NyK-000202-CH
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:48:24 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NyI-0005XK-OK
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:48:24 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3fc36b99e92so404292f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759906100; x=1760510900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dy6vMqEMOYz0e5w91p6NG9/e9QTxFhG8D3zAGWOAhiM=;
 b=VtWn0aIrJ8KhvQYMQcapPuV4lNwrfDIdUge8ycu2aLQ7hne14Izpb0LvwO3sDzQ4gs
 whGFCQ20oztt8d6/FNM+vJ6HJ3HZ2k058iRo1dWDlCWWdoPyyPX8Qjk35ncOoh3WEhCf
 4TtnFNlFzgU6ze+fpWtXHKtub+qqfaBrGmUJ04zLkfVXAUablRRb5w8Of1D0qJb96fj4
 d8dlXd7vy9YRmZq4u+AlQLMkSesk+kJGyhn2f5efy7nUczYVz/nWP82LDze6Pq/ZeP55
 Ppl7aOdM5h2YP8uECAINtEBM/NC0PW9M33nyYlq7ZqP1o1xoqX188sHnQGi5Y6r77/DF
 +QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759906100; x=1760510900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dy6vMqEMOYz0e5w91p6NG9/e9QTxFhG8D3zAGWOAhiM=;
 b=f75aX12/kBJWb+v0/8v/YaUo+qz8+jV9KUILmqKO7DlhEGYzcqVbmxDzNireOUN3/e
 kUh+ncPcByhU8Afez3UvfpbuwxIHFUCcRkyZuvc7USNOIJIIothUHJa7Jol/Iaj7hH/m
 Kt5yZq2HLakMJ+inMsBBd3Qxz3vPFAQP/UimzeHjt5ZsrwxyGTiFtAA26tL+jeIWogQP
 NCstjANiuvQNt4Uz1vT8MntGDrzkPKuqvXw66oWziodNxFLlVxgLiX8kxsClFEOyhOoS
 m4zLs4g2zLeUOGoULx2+UJMBJV8pH6oD/RdGNpgAleTTB33xkRs6OUStWTrp+pTZ4KFG
 tJdg==
X-Gm-Message-State: AOJu0YxfKPmGg0HWhuPF9GMWqk13XgBHTZHttFGwDqjYsURFl/MB0wt5
 CH5C4VJO17gHWI34ueEok/xN+fIhtdtPtJ74B8Yxz6QUZFRrWFavBfbSjoXv8apoFJ8K9V/zNcv
 XSPWYv1sQyA==
X-Gm-Gg: ASbGnct2+Gt3R0OUFS+vqeRvZNTjkx6bkt0qPYlp+xYdjJimFzTKqlILPRKxW7RywEG
 zaW6pRy5QEhuxFTknvO7aqebQxRU8Pwi7+ClDlcF2AIJWc5vTqCC02+eVKSMff+/zNE+eIuyIEU
 sF9H0s9xpBsy6yvod1YQBmv9QAXQn0sDL1o1koZ1lkVoEZp6m3gN/G+qkRXuAfU17WooM/hAeLu
 rMGCxQuNMP1jXbT07Q+pu9fw7cBEjxLkUe/NrP2scbu4fhlSCAxx/KvkiudfxHzlESMp9yEP0vI
 VYmrrY0M9bwZDcB38+di+DhAeZUlFpjOciwtv/uo8Abk68mLRBluNGYLMqtk+5ZKEPM9Cb2v7Zz
 eVijrEDBpqxLNkjQqxry4HU+9bPmpDTrGYppVYr4qtBM4FAt1el2a+KIzUG50okBYYS6a2y+0Qh
 QYXGYVhDI4YhDLCHA1W/f/Uw3E
X-Google-Smtp-Source: AGHT+IEuIf51ZJjEd9WQuwD4Rd7Z4RmyDpZPoN3J7GIS5tP9WoPFa/MFT9EOHhA91dwzOBRKZEB6vQ==
X-Received: by 2002:a05:6000:288f:b0:425:58d0:483a with SMTP id
 ffacd0b85a97d-425829a5a12mr4504344f8f.3.1759906100291; 
 Tue, 07 Oct 2025 23:48:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f0853sm28861163f8f.50.2025.10.07.23.48.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 23:48:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/6] target/sh4: Convert CPUSH4State::sr register to uint32_t
 type
Date: Wed,  8 Oct 2025 08:48:08 +0200
Message-ID: <20251008064814.90520-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008064814.90520-1-philmd@linaro.org>
References: <20251008064814.90520-1-philmd@linaro.org>
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

Since its introduction in commit fdf9b3e831e the %SR register
is a uint32_t type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index c41ab70dd7c..db27a693f12 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -365,14 +365,14 @@ static inline int cpu_ptel_pr (uint32_t ptel)
 #define PTEA_TC        (1 << 3)
 #define cpu_ptea_tc(ptea) (((ptea) & PTEA_TC) >> 3)
 
-static inline target_ulong cpu_read_sr(CPUSH4State *env)
+static inline uint32_t cpu_read_sr(CPUSH4State *env)
 {
     return env->sr | (env->sr_m << SR_M) |
                      (env->sr_q << SR_Q) |
                      (env->sr_t << SR_T);
 }
 
-static inline void cpu_write_sr(CPUSH4State *env, target_ulong sr)
+static inline void cpu_write_sr(CPUSH4State *env, uint32_t sr)
 {
     env->sr_m = (sr >> SR_M) & 1;
     env->sr_q = (sr >> SR_Q) & 1;
-- 
2.51.0


