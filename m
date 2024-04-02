Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C05CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrf4Y-0000tF-IY; Tue, 02 Apr 2024 10:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf4W-0000ru-FB
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:08 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf4T-0007kJ-3i
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4148c6132b4so34604685e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712067903; x=1712672703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBDHfu1WWwUZX0nO+1GdOpxUbxXBz6m2k2jhIHnZ7lw=;
 b=FC32CwpQHzC0Nynp1HeXvJGICZ0KibfLDnEKf4H09QTjps8uDomnjvVW/e1GCK+/Ht
 agBr3RxNQAarPv0wys3yAjf8AJ9oCXESQ57lwQxE9thWuvJjPpl1GI1LVwWHgNEt3gpl
 649ex7LqjWzafD2G42Nn3NOjJgxaLzsS6EEwnGdpylET7ZYg9BvAMQQ25S+47WXsi47/
 3BtSpC8y6G0gRAZIt1eaazUi0U+CHjkmvcSHa+9PC5hbdwFh9VjI4u+OILC17LOXEKMH
 Y8Zzh05gO3Sm1gB3xGKcZK1gL257VYhhGLlnKMNo2nkspWJL/a9DNixq6W+JUtl14pp9
 JyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712067903; x=1712672703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBDHfu1WWwUZX0nO+1GdOpxUbxXBz6m2k2jhIHnZ7lw=;
 b=UrKs4hpWi2yMS41LWJKI5sfJDM1tRrxjvsvA8QBiDBtY+hmoG8C+QH/rh9HlaZ8EED
 QhHZMOUoio9qaj7hwPQaymlf0NErSQZ7jk9xMis9W5FsJSZSjDlYbBsToNw0ilyaLFXt
 FW4C4h3k9FLix+MPxLgYbjIArdwfXMxcy+3YqsTZByEqpy0y4sy4NMJwVbRZe8Gb3EXo
 0GQQAO0gtWPbM/uaeu4HwOY2l6OzPxRXjqfpYZ3CQhoJ2rPhaYWFtcNa1EmdNYEtHZ0z
 xt4vlGh6g67xlHcSOHoaVhIeldwYBsTofkkCigyn/tWnoUfzh5U2sd/JBOG3zxdWbvLJ
 J1tw==
X-Gm-Message-State: AOJu0YzrzfsBvzLjMcJmUa7ZL9s6aNOM+a+dfRoI7gTdeNWj1i0icYOl
 oStwJPAdB8x4EQQGIiuZlN+jUkCr6qFw4FzqgCu2Clja7c3WffBM4Y8C8/qZBGaAHLkqpOG3+UJ
 3Aj4=
X-Google-Smtp-Source: AGHT+IFpk8y897vy3GKRfLVLbASH/dGJmNFBcUt+XZFp/SrU6uy80VtaD+l+UcRvZXxo8gJhJBoamg==
X-Received: by 2002:a05:600c:3b29:b0:413:4299:ec9f with SMTP id
 m41-20020a05600c3b2900b004134299ec9fmr11034767wms.5.1712067902875; 
 Tue, 02 Apr 2024 07:25:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 fs11-20020a05600c3f8b00b004146dd6bfe2sm18023274wmb.47.2024.04.02.07.25.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 07:25:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PULL 04/15] target/ppc: Rename init_excp_4xx_softmmu() ->
 init_excp_4xx()
Date: Tue,  2 Apr 2024 16:24:19 +0200
Message-ID: <20240402142431.70700-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402142431.70700-1-philmd@linaro.org>
References: <20240402142431.70700-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Unify with other init_excp_FOO() in the same file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20240313213339.82071-5-philmd@linaro.org>
---
 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 22fdea093b..6241de62ce 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -1642,7 +1642,7 @@ static void register_8xx_sprs(CPUPPCState *env)
 
 /*****************************************************************************/
 /* Exception vectors models                                                  */
-static void init_excp_4xx_softmmu(CPUPPCState *env)
+static void init_excp_4xx(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_CRITICAL] = 0x00000100;
@@ -2120,7 +2120,7 @@ static void init_proc_405(CPUPPCState *env)
     env->id_tlbs = 0;
     env->tlb_type = TLB_EMB;
 #endif
-    init_excp_4xx_softmmu(env);
+    init_excp_4xx(env);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
     /* Allocate hardware IRQ controller */
-- 
2.41.0


