Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20272C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQvT-0001Dd-GR; Tue, 04 Jun 2024 05:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvQ-00018G-TI
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:52 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvP-0002Gu-AX
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35e4d6f7c5cso2923564f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495069; x=1718099869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZ3BsgSsDpVAMiUE0ZHS//M9sgcI8U2Pt7eSzUE/3vA=;
 b=gwZLW4ZYcfY0bgwBnD2xOM09lHUAw93F9FnFgr6LEsV7kze+sX/B0ZL4EpwgXD03Ad
 UMzB0y7GFTzKeZO53HeNudYyGSfMUMj3ATb2QjAmIHE1H+LTlR6vtD1pGrRwUW6s4afC
 PHdhuqmwq5R/GRq0xuw+20f+fAVj3n/VhSJG8sfMFZdNUV9+pA3h1K04nM5ezYmG+3FZ
 KZ+KO4KmujOzdSrK+wXQnDb0sMIAm9aCyuaPllc6OBL9VPYe7IHJLyyBzDZAtd8Wh2+p
 j5Vsti7W5kFVq+ALi5vDJCTDUom6/EyeCj+pjRso9zWkSHWSXvibg80YEVJcUvzCCXmm
 zb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495069; x=1718099869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xZ3BsgSsDpVAMiUE0ZHS//M9sgcI8U2Pt7eSzUE/3vA=;
 b=YaBGt84qPOfZ1/sUCeVLkPZ2sMry069SAuQtD5rpSeY83YTEJU+pHB3ODycZX0wWD4
 D4AlMZues84UGwsWqxcHUcJUnA24pcBdJvg7FpLlb1eVTNPGHAMMb4D571Lnki6HE0og
 HTfpvfPGUhK7AK9MnevVJ36cjtxlmqTghKtmLm26e6JTXQ0j75JKiO4kZxyQbsq9f7Aj
 zaxHaHcNxWwMopc5rKKuroWZ/YRqjJdJxlfK/2z7a0GeffTnHjjrW4cyKRPlxr4NFcNe
 Za1Vi9X1+ss6DwXI5Kqhyn0sS7A9lZBis0msvLL6VOogm/zzbnFDKItV8uRrvRkFHG3i
 wycA==
X-Gm-Message-State: AOJu0Yx1SGwi9Qly9xoxdXfococv9gqMHmAk7zJWiUYZAvRqxzYRWPLo
 GDkEG1NlaKKeFzNgtaMWCqVA2YH/KltVdow40o2sgY7cDt07x906UBDa+O2+9Bz80kKHjAz80NK
 c
X-Google-Smtp-Source: AGHT+IGjzaumT/kpOGRm5EuVd3DXmuuCEwaPu7dIKF+VdsyNyTkig7dkZAqwGLIGbVEm5FgqE6Jh3Q==
X-Received: by 2002:a5d:4647:0:b0:359:b737:68d9 with SMTP id
 ffacd0b85a97d-35e0f25a5c3mr8371812f8f.12.1717495069692; 
 Tue, 04 Jun 2024 02:57:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04da182sm10991675f8f.54.2024.06.04.02.57.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:57:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/32] plugins: remove special casing for cpu->realized
Date: Tue,  4 Jun 2024 11:55:54 +0200
Message-ID: <20240604095609.12285-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Alex Bennée <alex.bennee@linaro.org>

Now the condition variable is initialised early on we don't need to go
through hoops to avoid calling async_run_on_cpu.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20240530194250.1801701-5-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 plugins/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/plugins/core.c b/plugins/core.c
index 0726bc7f25..badede28cf 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -65,11 +65,7 @@ static void plugin_cpu_update__locked(gpointer k, gpointer v, gpointer udata)
     CPUState *cpu = container_of(k, CPUState, cpu_index);
     run_on_cpu_data mask = RUN_ON_CPU_HOST_ULONG(*plugin.mask);
 
-    if (DEVICE(cpu)->realized) {
-        async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
-    } else {
-        plugin_cpu_update__async(cpu, mask);
-    }
+    async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
 }
 
 void plugin_unregister_cb__locked(struct qemu_plugin_ctx *ctx,
-- 
2.41.0


