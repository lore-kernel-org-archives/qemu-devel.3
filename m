Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F177C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZm-0004At-Gi; Tue, 18 Mar 2025 17:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueYC-0001OB-5z
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:40 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueYA-0000ri-OF
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:39 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-224100e9a5cso119674255ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333557; x=1742938357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/uK/6e74nn8Fot5LvCS7tmplWHujswrlAKxdO1vG4SM=;
 b=xa/cjMSU2Xcl+2CAfqBE+Lt7LYZWGlHNdMjmqPg+PUHoX80orjL+blAtMnkZbazkg7
 Dc2psVAg38yYMEyVQOFK3t0TVR7NPESRJC/5v9mQl7nfIjt1NWCVtxhnu4So2NOG6bXz
 aeiYl4VeII4tCyBy0YA7Qs45ZJQi3N4SHK5PShHGD2c8h8jiAL6SiRwsTnYEqgjyC7zU
 2vsku/Po2wcbiPUvqa02EjaR1CyOkXeGWHCp0q5eIa1Kt2xKn+RItrDsEKBY7OnqWxaB
 fnw02WM3NiLA/Vb10ZR1+C17NloRXyqHYx3bKR5TA4g4IKQle7XxREYke/B0LiJneugz
 3bPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333557; x=1742938357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/uK/6e74nn8Fot5LvCS7tmplWHujswrlAKxdO1vG4SM=;
 b=m+UPQN8qGKXiKsCruRChEZsgmGrZXhRQ8GkHsGQXFjDmy5AUglKwj4R46l85QSf3sO
 5pKXPlOcTPfb+3P9G8hZ3d4LgI/wBPKO5ilduRjJf85eqkwu7TvFDVC6CwoxwB7/tS0F
 4ydjMTFsz8k8UA4HAxSu2E7kRYk6esIHQTeCDS3MXOh8f9Sz32qFfHtw7z0BMOQuv+T4
 yxtlmG3N5qsR8a1LrDl1yhbVIvYDj0vlc504FJTNu3zrURgiAw/KBkDFXYridWlBnIR7
 p+2VLkCinH+4WXL3HLX0a4dsEVQPmHW0ldb3URlsSWTvar9HkWJM6PuSV0mNtHivl39/
 Yg3A==
X-Gm-Message-State: AOJu0YypNw4rJLLXDuOnWwYdXrDsNnY671NZn+O88vK9Npr4LlkhhiIG
 eiyADdNPswM+hz0dVeOmKWWw5L3mhtzks6XgWnqmrdACTO5v2NbdwsjMMar/tDI8qK1GnJAIxDb
 7
X-Gm-Gg: ASbGncvBuDwmAZu9fT1CJm2jtvp0XoA0HUibsOCpETpbbdI8lurlYDScf7fkbBt4uXX
 RJGEmf3ZqdIVlR/H6Q9zTt+bNONGYsoT1/G+fc1jgug+3EVFbBmNKMA9uRNJNGukKr5xVbehYBL
 A4dYy3FOms5MJrf2QdG0Ea3ul+JQ8D9cepDvINgaRsza7F+p0ZrdKRYbXRzLWKRoexsafEupSo3
 o8QzSzhxN/2v1vBB1HsxOJS8m/eWn3SyoRzN98oX5vc+jl/Qr17Mdm7xZQGWnaS+cKL7h7+bQZC
 W5BasYO3DonLbJ/xpjNoaJ2t85oiWOd3TjnhrDU2CT4EnRnk5xDgaEYUGCePL3nSnmDaPWbjdE0
 S
X-Google-Smtp-Source: AGHT+IGLk6kINfllSdAHKNN+UsO+luLQuBs+oLn23QxLdRJ/KNvETd/xgnOq+pyTt8OWlWfYX0+q4Q==
X-Received: by 2002:a05:6a21:7316:b0:1f5:75a9:526c with SMTP id
 adf61e73a8af0-1fbeb896816mr347704637.13.1742333557321; 
 Tue, 18 Mar 2025 14:32:37 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 38/42] include/exec: Protect icount_enabled from poisoned
 symbols
Date: Tue, 18 Mar 2025 14:32:03 -0700
Message-ID: <20250318213209.2579218-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/icount.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/exec/icount.h b/include/exec/icount.h
index 4964987ae4..7a26b40084 100644
--- a/include/exec/icount.h
+++ b/include/exec/icount.h
@@ -22,13 +22,21 @@ typedef enum {
     ICOUNT_ADAPTATIVE,
 } ICountMode;
 
-#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+#ifdef CONFIG_TCG
 extern ICountMode use_icount;
 #define icount_enabled() (use_icount)
 #else
 #define icount_enabled() ICOUNT_DISABLED
 #endif
 
+/* Protect the CONFIG_USER_ONLY test vs poisoning. */
+#if defined(COMPILING_PER_TARGET) || defined(COMPILING_SYSTEM_VS_USER)
+# ifdef CONFIG_USER_ONLY
+#  undef  icount_enabled
+#  define icount_enabled() ICOUNT_DISABLED
+# endif
+#endif
+
 /*
  * Update the icount with the executed instructions. Called by
  * cpus-tcg vCPU thread so the main-loop can see time has moved forward.
-- 
2.43.0


