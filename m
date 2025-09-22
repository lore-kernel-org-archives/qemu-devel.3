Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF649CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0d67-0006j6-Sg; Mon, 22 Sep 2025 05:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0d53-0005MR-J3
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:43:37 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0d4o-0001zP-Sg
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:43:33 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3f42b54d1b9so1472286f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758534193; x=1759138993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=68wbma/YcKI1TwJYc3fIO/8B8AyrFhnJSIMXhgyet+0=;
 b=UFUxenMH5RYBLb53SomAZHn1PnotInnTEyJzibeRchh2cS603uHJm6XWS7C7yA5dGX
 ICNJ6nC0XvdNI6FnJdUWeXAVyMmjTrqiaVhQEF+27Q9aSZroLg7DNIQc5xwQB/NjqyYo
 qQ1KeQ8N8ZsWhpuxjMtck5gQ1fac3qYGHP6GK55PL6QDopaScTTFmaCQMfIi/U1Dnnw2
 JAH+G0VDR5X1MkRtD7Go6eZNhcR4THYy0fBkZbm/bjqQ1O4pRJDLSfIZVTS10kOlfzMt
 7LjFTaR7MO6v2rYXq6ggfo+TntUEl5tA8Kh0Zy4UMnrOSFfun32PZBSN/+POZGdp5Hv9
 sTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758534193; x=1759138993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=68wbma/YcKI1TwJYc3fIO/8B8AyrFhnJSIMXhgyet+0=;
 b=C/u/9K8MloUWl4azF6qTLRe8Sk7INjpD7/PTMuk6sW6/cKo2uwP3ugEzn+4Vn6Gb1O
 nIOYgIhq6HYFot/kIudpN+mT9HRw1CBferjeuwjIiprc0rJL19wDf6GigAt560K3EsM6
 HU+lJ/+yttYB1awbvL59oW6TQg9LjQgK7z/io6NqRr+AGQs/Dd6bXS4PaMq5wuwZV5CI
 WbH5hlrY35n04dYG55fouie476hoGk7VFTCqTP/wTVqvmr9j5QKIXjExYE/sPcCyf6YE
 SzG3emOzcSPOS4haesdcJphHche0vf77NVk8G93gktdkNsyGU+jVq77F3hP5aa6MjSR9
 jncA==
X-Gm-Message-State: AOJu0YyVm3+/FlIQ0XzOQh42UWCYvbXSPsoABy47ygx2rfU48CISS19a
 +Q4Xyhj970O2hQqilp/kx6TBBFP5zhtWj3p7tPtfGM2w/fqH9U9ZbuAGgopqggzEvV8=
X-Gm-Gg: ASbGncu2w3cQ5EsaUzRWSd628eBfQfm++SGZJKPeyRrVwBPL9KSHhZFcWLV9KX4efci
 VgQ2ebZU4trJtYYLM2lr0IADGUHImhzKmM7KHAyttVT6mlO/ZCnn5inC/HsKs/QIPcT8H+P/jcl
 vvFJSH7tuJIF4y85sFanWG9Ww79umIUu2zbJPCQOzSaFH+Jlk+ODPCS4sKVlOn7LJdK5399B7dg
 Q4EEn6Nw69QEN2Y6JuoBTyxKdGr0G9JrZdvRDQAo+eh2C4yKXhZZRXXdFbl62iAZEH13ZU5NBYb
 XTKeQrYio9y56C+Npub9/Uecq9dkq7kAZiyDYvka3bZcGXteXuuAeUr3rDeXmZ49MYfVfxkdlg+
 xmgvsmOzZ3kDFl50sGMO6ez0=
X-Google-Smtp-Source: AGHT+IFpjqJHRrNaIVglNlSJIofFd6QodqeBxiHyAVpa6HQccGp7WPW9KWukBOfY8HXKK2HWR8JSyA==
X-Received: by 2002:a05:6000:1843:b0:3f7:9dcf:c066 with SMTP id
 ffacd0b85a97d-3f79dcfc487mr5309325f8f.51.1758534192583; 
 Mon, 22 Sep 2025 02:43:12 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46566f72354sm193693225e9.3.2025.09.22.02.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:43:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 997ED5FA07;
 Mon, 22 Sep 2025 10:37:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 11/25] semihosting/arm-compat-semi: eradicate
 sizeof(target_ulong)
Date: Mon, 22 Sep 2025 10:36:56 +0100
Message-ID: <20250922093711.2768983-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922093711.2768983-1-alex.bennee@linaro.org>
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

No semantic change.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250822150058.18692-9-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/arm-compat-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 604a69e3646..6725dcf4ba7 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -786,7 +786,7 @@ void do_common_semihosting(CPUState *cs)
 
     case TARGET_SYS_ELAPSED:
         elapsed = get_clock() - clock_start;
-        if (sizeof(target_ulong) == 8) {
+        if (is_64bit_semihosting(env)) {
             if (SET_ARG(0, elapsed)) {
                 goto do_fault;
             }
-- 
2.47.3


