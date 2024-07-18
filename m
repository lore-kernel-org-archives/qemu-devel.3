Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FDDC3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNhs-0004QX-Oz; Thu, 18 Jul 2024 05:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNho-00041w-1F
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:44 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhi-0007h3-KU
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:43 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-58f9874aeb4so634378a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 02:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721295937; x=1721900737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cxNsjyJQ5Q7BdQvFXGuXSJi9cfIKmt9opJ8u2XLF6e8=;
 b=GeudxROcOqgIFDmRHp/5Sx034rwxaHJa5qz72b+gHtAEjfoYTsvn61i1KIwDfku5OZ
 4hv10NJ6XsTx1qB6vlZBL4KwZL+rY34BrGWTL4dHcfA8NSOzjkJ+N03CeOabePew338R
 Y950KNZ9zhQEHw7m6emGJU8qs+36NLTt3AfymHunR42l0hpXfi/GvK8iJfc+CUz/MH5O
 rDQ+SMQVpowH9UNs0eLSFQihtRM+faKNHC5mWbFaAQyWD6qZijsCML7a2xL/yAfKFb/N
 CqJWg7EI+cceq6zYchvjDu89DSCregfoOrhn8gm/9GFo9kM4Dj5nF4bwB+aoN9KCF9u4
 jDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721295937; x=1721900737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cxNsjyJQ5Q7BdQvFXGuXSJi9cfIKmt9opJ8u2XLF6e8=;
 b=ZbAGPG3XwY02mvjPV7HT72KJ0/4kvqKbUXdLw6+382W1OAyqwbHUwd7gicbApIV1QY
 V1qjNuRBEZyD/4uCRsCyeJgpGwgMZKEUwYl9svT8dMLu9Io0NwgnrjSYEbsBpEotzBxW
 8zN6GzihSggtktcudpnx3NMJvzzJD7Sl3hw4/8pz1LGbpIoItYxs4vsZzVNf1lSyzJFC
 lMekX0s5GoEYeaHrxgA6Vg3H9VW8C4mEBwyAagzZ49hz5q/Ae8RmhxIC15sUlj/a65TF
 Cfa+V91fSnMK5ao+zYmRXrzPKAg+/FbpZWN4AIkBSi5rcqM7HczcAzwheXc9+ejFUjnn
 ygAw==
X-Gm-Message-State: AOJu0YxDp6Kuyb+k+Xji9RW79wYWk+sJ9ECMltlVvc0T6iGBoIg7HTCg
 gt4C/Kk7gXGL8EbKS+svzoUk8qtTDccSSOXx+LXMfjt2fAdLcNrxjgnBASCI+1Y=
X-Google-Smtp-Source: AGHT+IFn0z+X4eO2CqQgY4I4yo8Qf+fR3pkhKWez2B0mKQoEXKLq1RKjG7B6QIFSThlsC1ReVEOFBg==
X-Received: by 2002:a50:9ec8:0:b0:57d:10c7:aa4b with SMTP id
 4fb4d7f45d1cf-5a05d0f0298mr2611954a12.30.1721295936832; 
 Thu, 18 Jul 2024 02:45:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-59b24a770dbsm8213773a12.4.2024.07.18.02.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 02:45:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 597175FDC6;
 Thu, 18 Jul 2024 10:45:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Beraldo Leal <bleal@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 14/15] target/xtensa: Restrict semihosting to TCG
Date: Thu, 18 Jul 2024 10:45:22 +0100
Message-Id: <20240718094523.1198645-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718094523.1198645-1-alex.bennee@linaro.org>
References: <20240718094523.1198645-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The semihosting feature depends on TCG (due to the probe_access
API access). Although TCG is the single accelerator currently
available for the xtensa target, use the Kconfig "imply" directive
which is more correct (if we were to support a different accel).

Reported-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240717105723.58965-8-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/xtensa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/Kconfig b/target/xtensa/Kconfig
index 5e46049262..e8c2598c4d 100644
--- a/target/xtensa/Kconfig
+++ b/target/xtensa/Kconfig
@@ -1,3 +1,3 @@
 config XTENSA
     bool
-    select SEMIHOSTING
+    imply SEMIHOSTING if TCG
-- 
2.39.2


