Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF86C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugud4-0001LR-Ab; Tue, 29 Jul 2025 20:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJR-00050d-FW
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:54 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJP-0004i1-79
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:53 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-75ce8f8a3cdso3992004b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833890; x=1754438690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x277x9XlfNKg6YalaQn5z9z1qFLWVkh1m89cfSCEzVg=;
 b=qkVovCLjc/bBuWIX3JiXCGbrDETb5mkBEjdtQds5CZJFEzo1dsCWOVdrNpEy7PoXyQ
 6f0pcJgE9wAQ3jb6F+Kvfl4tzaBsQRtpOFpZmp6M+5EKenovr7RHAd12+k9LgfEx6+tk
 q6SxCbSRxBOnu0fbcG8zL2oraDXU05suEH+gu3TgJyP/qQSd0oaM/xrJsPgx4CA1r6Xn
 GNe2iNIvonqTWjBIqRygYSUB37gihKBqS/7OJhOWzt56TIYhBDAqahVHgHtEWnblRNi4
 Rac/b5hcrLewEn9UIStLbbyDKBAjR64b4++BJEKtffVj891etewjlSQHENK3me9U6fXQ
 s0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833890; x=1754438690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x277x9XlfNKg6YalaQn5z9z1qFLWVkh1m89cfSCEzVg=;
 b=nfnxwDLLgxnUKGV3LG8wdlpGb4xs66K5sPpUkbrmurvpydSxqWsuyARxSOU+s34uKJ
 gcuiwApeN+CTDXgsW59eRComG+vpHcMrOaOABzRtVEfCbbOEOkAposCUyy5+utdBWOoM
 OAndlCpQblU0SM+Rgxc4P0lverLues8tT17HQKyGX/uOcmG2/pWhlrcn7/SpuSL7+Ocx
 ROdoEkZcHcF24k5B21hY0AiuUj/S38LJtjFqZuG3bRZT5PIJ1YvV02ISnip0DFC4I6hj
 DSgm4JV3L90wBY983BJfI+m0f1gaMERf9Tt58iwa3LlNV9xdxrFbesGoTPwLD/eLSQZD
 MagA==
X-Gm-Message-State: AOJu0YxY7/jLPLti41+gbSRzw3vwH06tHp53Cut5s1YqHtMejqybMlox
 ynIV6sJRp/28gh1WwYp3y4+B1CDC3HIvCOU/qwKeZHASMIbA1YZiNTSVITObToB1XpStueQji1J
 ae618
X-Gm-Gg: ASbGncvlxj6P2+7kX5BnhtPFEfDCAH/QeX1OCSZQmgA6EollmSyP2wiu6WTMH9xWyZg
 uA3HKOAfyzn66GYHaZNMGQUVlGqluYqyoNiewhW2C+zghs7B2RtesLtRawjanbRTWZsOOjGqAom
 GcyFC8JCZma2ogHQBPIUAOkpNsaGc6vBiQ9wHj5rQUOzOGHFPXFwqIHdEar3xQY3y2itdGdjVt9
 LmPzS0nRE4MoMuRtebuiWk43JmBytEuf6mmHgL8YJoemtktwJm+ZXpQp+zlxDvjM0T0hQQfybGV
 UdAWh0P1QpUs+Y/VuxAUYon1TqRU2nZphV5s3r36eK/U12DLQqqbZO2uPXPybixO/B4Y+CH49mP
 gidoUs8eCMd8LmBmbyy9uXHg+OR7wW4q4uCzUDPzMmCYVwEr5yehD2t8XKutrsJW6xFqNC8wcKw
 JwZMvNST3wOg==
X-Google-Smtp-Source: AGHT+IHFu5AY9ar2uCqIQvvA9LT1HyKB2hfAbx623gqO4S/KfYz0J7laLbE98mz5qy8HsAP4gbykWw==
X-Received: by 2002:a05:6a20:431b:b0:231:c237:2452 with SMTP id
 adf61e73a8af0-23dc0ea7c28mr1945410637.42.1753833889780; 
 Tue, 29 Jul 2025 17:04:49 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 73/89] linux-user: Move elf parameters to alpha/target_elf.h
Date: Tue, 29 Jul 2025 13:59:46 -1000
Message-ID: <20250730000003.599084-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 linux-user/alpha/target_elf.h | 3 +++
 linux-user/elfload.c          | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/alpha/target_elf.h b/linux-user/alpha/target_elf.h
index 52b68680ad..f9d6372c9f 100644
--- a/linux-user/alpha/target_elf.h
+++ b/linux-user/alpha/target_elf.h
@@ -8,4 +8,7 @@
 #ifndef ALPHA_TARGET_ELF_H
 #define ALPHA_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS64
+#define ELF_ARCH                EM_ALPHA
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c88fbdebb0..4294a6582e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,13 +138,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_ALPHA
-
-#define ELF_CLASS      ELFCLASS64
-#define ELF_ARCH       EM_ALPHA
-
-#endif /* TARGET_ALPHA */
-
 #ifdef TARGET_S390X
 
 #define ELF_CLASS	ELFCLASS64
-- 
2.43.0


