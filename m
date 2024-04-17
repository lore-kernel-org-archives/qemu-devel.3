Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35361C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA1E-0007bT-Ly; Wed, 17 Apr 2024 14:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA1C-0007b1-P0
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:28:26 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA1B-0003HI-9h
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:28:26 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d29aad15a5so790921fa.3
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378501; x=1713983301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RapDlHBEy1nkY/csZneQutCtWvQO/OhX6r5FqrgGfGI=;
 b=BeB7WEhgMT63InPKdIB+cyAfuBT9ZoSfvT4aGG5cw8grYe1tJk1u9QQZawwvplhwsT
 4OdBDma6kD4m+nKxS5Lvry1jkLYVBnbTQuF2HaFRQPyWEuMuCopnK8dDGoU+K5cIu0m6
 GNjFxPqj6RqvMsYFJCPQF4wCUMTzzxk1PtxXCE1WpByVqpsbnRb/od0p3Ue/UW8gno7r
 sR2BNuNO7pOmWEdTCO0/gdt1whDru39oZAuIK9guEAVugWIq/sAFvu2otzm+45s8zVga
 O424sRgH9L6v77cik27fBvs3xiuq5rjn4ensCyLUT3ufLiqPjihNqLNpRgV9jbfh34/W
 sv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378501; x=1713983301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RapDlHBEy1nkY/csZneQutCtWvQO/OhX6r5FqrgGfGI=;
 b=PP8xcePvuE5tKc6n5ZC1jI40KuLIZE2/GENsZjTeInX8ZBkmxjpM7FrZjJiz/Ah0Vc
 UUOx3a6hVZPwbxrtSw8AIoBCWsleJQ1gjiT6vOqhWJvhw6EnBPviarVCtt8cHKic4Qdp
 QmI+Iyby+HJI3vS1fMmy51F6o9eHx8P6r+20rBM6ZJw+nmC2/189cOgs08Y+p6rRjlBl
 1IMmdEtkFjAayw2G7Kkq1S1mRkQHrgQiTypzJHo9FI0a7CFbTZfYds/oeNfgnFoI9QmR
 7+i19eqT9p8kQnewf7uQNBe4zWzv0YGTbCxPyN6iBmW4D+0mrjS+cuRm68V5w+Xn8mHX
 x59Q==
X-Gm-Message-State: AOJu0Ywsk6B2sKPKKPU+X0T2Q6dIVXDlARvPCKFAKE2okWC/0lMIjTFj
 pwHqsgRUxTTwgjN26BN4vLLqwxprrkqOHImLs5J+s2Ba1fNYtj3pFI2sw82ojU2ConzxC5LcBQM
 o
X-Google-Smtp-Source: AGHT+IEOXdJyI6oCBi3ITaECBdbQlFJjibxmjQHggKVV2wIdOwGvJvfS7IiWMQODhxaPIQfAXC2+0A==
X-Received: by 2002:a2e:3518:0:b0:2d3:4b73:7b40 with SMTP id
 z24-20020a2e3518000000b002d34b737b40mr64709ljz.17.1713378501376; 
 Wed, 17 Apr 2024 11:28:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 fc20-20020a05600c525400b00418d7ae027asm436001wmb.28.2024.04.17.11.28.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:28:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/21] hw/core: Remove check on NEED_CPU_H in tcg-cpu-ops.h
Date: Wed, 17 Apr 2024 20:27:47 +0200
Message-ID: <20240417182806.69446-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

Commit fd3f7d24d4 ("include/hw/core: Remove i386 conditional
on fake_user_interrupt") remove the need to check on NEED_CPU_H.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240322161439.6448-3-philmd@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index bf8ff8e3ee..dc1f16a977 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -49,7 +49,6 @@ struct TCGCPUOps {
     /** @debug_excp_handler: Callback for handling debug exceptions */
     void (*debug_excp_handler)(CPUState *cpu);
 
-#ifdef NEED_CPU_H
 #ifdef CONFIG_USER_ONLY
     /**
      * @fake_user_interrupt: Callback for 'fake exception' handling.
@@ -174,8 +173,6 @@ struct TCGCPUOps {
      */
     bool (*need_replay_interrupt)(int interrupt_request);
 #endif /* !CONFIG_USER_ONLY */
-#endif /* NEED_CPU_H */
-
 };
 
 #if defined(CONFIG_USER_ONLY)
-- 
2.41.0


