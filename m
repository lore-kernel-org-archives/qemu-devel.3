Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC767C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNhu-0004WH-0A; Thu, 18 Jul 2024 05:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhp-000494-J7
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:45 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhj-0007hc-Ip
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:45 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a77b550128dso59651966b.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 02:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721295938; x=1721900738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNz+AOYp7KBdTk9g+6bf31v47vR5RhTCmRUMfVqRcT0=;
 b=xtUkIWCzeGHZr4PM7SOHaNSGuSMm5/q2BMPb4lJcdt7rmInQTJTg0oVJQeMxwZOuQx
 r7OZprzCBk+tPPJchsoYM2INZ1hdIe3siKNT4tzh2dqcN5ub5Qtr5gliXkzcQwa1aBjl
 GS6q93xzLjDuGOCNColST48dD/vnCuOyt9ytwZnKYUgZ8L7xr6NHWlTlzZSb/7VjFLSi
 XA2CFSVppVlVHHpXK2PUKEl4njD2vojd4oKaXNZedCahhUA8IXFkXj9kaJGYx1+Zs/Iv
 2D/GMcmgERRiH7AXrSnuW6PSC3ZFYisGyR9y9siAZHQ28XUHSP0DGYJBj5atGk5O0sJx
 VYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721295938; x=1721900738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNz+AOYp7KBdTk9g+6bf31v47vR5RhTCmRUMfVqRcT0=;
 b=RHi88y/FE6zy2wDBUO3rL++ZhdriFSRM2/gpaw8ty6xJTuQkwLokkjmmNXdOwDr9jv
 RaqGo3F6CQOzhGNdqKwcvqFocKKdTYH4ktYvyUQO3bN9BaG5iCCTwWIrfQqfq+X0AXxS
 l7knR5jVypQnWWkJwTru+nYAmaczTdI4JhOig2jaMH2PxpLI/wT8yvQSqz2onVL+ztsd
 tug+b4Nvze1VlR5pEFXgXeIsFZt/SfF2mVjMBDVQ/ilvWeFU+jcyYBNaCnw9F0xOiwlR
 ZTJo6tLlvcuJDQIuPP1ZWj6hjCWJqLUpNyeSPk78a63yb1hSGzMcG9vJZ0kGHZ/Jm9F5
 Szpg==
X-Gm-Message-State: AOJu0Yzq5vP2B6VmTjqhYk/0/XveIlPC4HVgAnLwlPBh5tgVxrIwVC57
 j4Vuyz0QVlMWjVglOCET1GILRcyVygH0bnEQwLU5sUrKEgHgHo6wF6URq5PgzE8=
X-Google-Smtp-Source: AGHT+IFxJn99jT+7A93/GH5Ylxwy9gBFz6JvOE7+0ukSbPdld+xkmNDiM856MPKdse8cDajmF2ty9Q==
X-Received: by 2002:a17:907:da3:b0:a6f:bf5d:b365 with SMTP id
 a640c23a62f3a-a7a012f6e5emr432518266b.33.1721295937667; 
 Thu, 18 Jul 2024 02:45:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc7f1e20sm536964166b.116.2024.07.18.02.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 02:45:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 453315FD74;
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
Subject: [PATCH 13/15] target/riscv: Restrict semihosting to TCG
Date: Thu, 18 Jul 2024 10:45:21 +0100
Message-Id: <20240718094523.1198645-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718094523.1198645-1-alex.bennee@linaro.org>
References: <20240718094523.1198645-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Semihosting currently uses the TCG probe_access API. To prepare for
encoding the TCG dependency in Kconfig, do not enable it unless TCG
is available.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240717105723.58965-7-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/riscv/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
index 5f30df22f2..c332616d36 100644
--- a/target/riscv/Kconfig
+++ b/target/riscv/Kconfig
@@ -1,9 +1,9 @@
 config RISCV32
     bool
-    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
+    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
     select DEVICE_TREE # needed by boot.c
 
 config RISCV64
     bool
-    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
+    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
     select DEVICE_TREE # needed by boot.c
-- 
2.39.2


