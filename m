Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A0DC3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Hu-0008B1-IN; Wed, 02 Apr 2025 17:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Hm-0007Oq-6a
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:10 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Hk-0006lb-Du
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:09 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3965c995151so115555f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627966; x=1744232766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VUBhKNJ33VGc0tAXVv72Kq3hUC0BPxTHmotqIBCHglo=;
 b=XCIXrF5BQd2mq7LOmUDFT87HyIjc9fA8sX1CMPUnjmIuT1cB1xmJPCmN6MHXJOuA3h
 XHY9xoDybD3OPJt5Q4tTlf/neyw4+KagYLN1+8ddWpVOQ4yGU6NUnfHlEpFnbDfdQLLC
 DObGcRUHmY3Sn77tqxkMPDFtV88UErXdTzscTRkkQ7HcuxefaBTYYQgJbfXU2OFJRzT6
 9CC//V53CfHyGLROGyLNNqWq5c+1kQAIWHmyOdveS9t9YOLiHfcszpMN8PfUoJvRwAJ0
 TWDaPf8H5scamm3zVurAasQNZGegkXj9a+U0oUF7e6tPG74RFm3fVubi4qywsxgB9V/5
 6EDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627966; x=1744232766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUBhKNJ33VGc0tAXVv72Kq3hUC0BPxTHmotqIBCHglo=;
 b=qX4eHetqNb90TZONYt8b4L/ycL4NDCo3llRUFv/PCm4heeRdK7SLFQAO9iav9R2pvP
 G19cNm8WQVmHqB0SzBxGLCzsg7+oMpVu7oL8vfSjGp9KyrD2Rx67jLWGvjkl/fJ+7uJ1
 46SP+TdJtUbZUHSBuyKkoJeiqYEJze2qO0BSU1vJAqsKAdvqGQF3CfIWNdT0J27zSYCv
 JT8OvZvS3AkVEVeOlCNg2ha6Ip7/Poy0dyZQGF5piqd/t3VrYD/BRdU1sJU9wjiOtoWN
 cG0R9Az/OuDquBGkOFvfQpswLl0CU+mqeevQWjIu/W02UxcwUIhX+b6+pmqOcXtee4rK
 lLRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx4HAVZIqPblv8cwbycDMU394M4AQ8oq3Hg3z+ANSGqtLuDuxkM9a6noI484Ff4SsxwxIt8EvHo5y0@nongnu.org
X-Gm-Message-State: AOJu0YzoaTvfwE3uLqGrUdaQoAubk5qJmZwPJ58TZjxy2h7XlQow1V8n
 aQGWgKed4IU9PbcM/VJFdaHtwmWno5VMGXeI4aA3ST203eRtqV6MBkTFNQO6QYaOCNg5petKK+p
 O
X-Gm-Gg: ASbGncu+CdBY+DpWX9Ac7kopKHuyLq8CjfpxfkMLQl+FuydquDc170HQawzDyBvDutZ
 NAt7wxKHlCdt9BQoX5avtXNUQLFkgBzKULOHCKki9WmI/+ZOrlbnxWhj+I9yi1xV+tu2vradilM
 v5gRD0ECrdo0XCsZFaDYMWPf5qfjo5tvugltjMWh+vM/TiyF6gcnWMKhxXs0pGB4arwiLSP3ZSq
 onUuQ9hm4qDS4/1kdUsABLdT7w2OMDieBlWeuVJQekg3ObYQDJifB4HFsUjQRSQZQ1RquzkrmQQ
 rAMXp7LiR7qgJb2hlGPJ7K74cS9SspbGU5XRXfJvcfOJZAaroMByIogAFzobdPV4gC+CJaYRW7I
 RZGhB5lisa+b2vqkM988=
X-Google-Smtp-Source: AGHT+IGQ0/vXJu2ZIFsqSUzoZN1Rk7Owuh1T5+2v3fe3C08pSMb2IybnPeRY0zvvs/Hor63MJ/jS5A==
X-Received: by 2002:a5d:588c:0:b0:38d:eb33:79c2 with SMTP id
 ffacd0b85a97d-39c297698afmr3121902f8f.32.1743627966659; 
 Wed, 02 Apr 2025 14:06:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6630a3sm18030651f8f.30.2025.04.02.14.06.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:06:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 32/43] tcg: Simplify tcg_req_mo() macro
Date: Wed,  2 Apr 2025 23:03:17 +0200
Message-ID: <20250402210328.52897-33-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Now that TCG_GUEST_DEFAULT_MO is always defined,
simplify the tcg_req_mo() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/internal-target.h | 9 +--------
 accel/tcg/tcg-all.c         | 3 ---
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 05abaeb8e0e..1a46a7c87dc 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -52,17 +52,10 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
  * memory ordering vs the host memory ordering.  A non-zero
  * result indicates that some barrier is required.
  *
- * If TCG_GUEST_DEFAULT_MO is not defined, assume that the
- * guest requires strict ordering.
- *
  * This is a macro so that it's constant even without optimization.
  */
-#ifdef TCG_GUEST_DEFAULT_MO
-# define tcg_req_mo(type) \
+#define tcg_req_mo(type) \
     ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
-#else
-# define tcg_req_mo(type) ((type) & ~TCG_TARGET_DEFAULT_MO)
-#endif
 
 /**
  * cpu_req_mo:
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 7a5b810b88c..a5a1fd6a11e 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -77,9 +77,6 @@ static bool default_mttcg_enabled(void)
         return false;
     }
 #ifdef TARGET_SUPPORTS_MTTCG
-# ifndef TCG_GUEST_DEFAULT_MO
-#  error "TARGET_SUPPORTS_MTTCG without TCG_GUEST_DEFAULT_MO"
-# endif
     return true;
 #else
     return false;
-- 
2.47.1


