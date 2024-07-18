Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EC1C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNhp-00048z-L6; Thu, 18 Jul 2024 05:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhl-0003pC-B4
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:41 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhg-0007fI-1i
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:41 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2eecb63de15so7914661fa.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721295934; x=1721900734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/7VI3SrH+zYbARBw7BAZJVT4QrnBg3//kUdSkwSc88=;
 b=lvhCLR/kr5rUecCPJAWbY3Y4wSN4I9Dw6jIxwj2mfokY4BgFH8jjMftF2q3DgNNqu8
 qXvsANQXcEhx+V3X+LL/jdxcWwdSf1L0+kEnfle45uvsaaLgghktDZtpWCa2Ztzbt066
 byJjLmlXKLu4CGIU2EEUbk++7lR87PtutAm69crsLOyO+299ChyOMgZj6W6D8oBZrJ4E
 ZtC/vlFhyFhKWX1oCnavhSaRPo9DCbukfd4irdhlYrUKHHZd0VsCN+iet7MxDD6uRETQ
 kUeMXIpwjHijsq7APK9RlAPZYuX5lDICNvYolZgxT/rkfvUZb5BnBznhYTRioiGKmPCq
 3ILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721295934; x=1721900734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/7VI3SrH+zYbARBw7BAZJVT4QrnBg3//kUdSkwSc88=;
 b=rdS6jyv1WAAehLCosg/w1PI6Nop3WZRHqpEQegge0OEYX1SXFHQlSqUS7z5XyYXQw1
 2vb+4IZmP6rm2brIxXmYThHh9DHHhmb6HcJLnqr6kwPtkutw+UbI9Gz+7nFtLuApJi5g
 jQ8Jia+GCGE5+JWedLU9y6M79qe5N1QzN51P17tybPDAUuhGaUsgnPbd7/gJ767WOLzw
 TuXMMkPvCgC8gULufcUwLLoaoNA8P5sPJACz2q7wWXnk31OKG2Uyq4LJm0Z+UF0xkcKw
 7YRckHbxjpVvoz/npOvNR9dNv9+0aI2E6b/EoiBBOUFxYmkNy6N1yHkciAmNhgsPea9w
 z0sA==
X-Gm-Message-State: AOJu0Yy0+ZWgqO4qR956TZOiSYPcHQ58fuKabg0vBRGqYESMGT1HM+yP
 n+9li2hZOGwoQIVGyFbsBb9w848Wvry5K6ytzDjZ+QnRdEA5Ed/kw7F27St/1kM=
X-Google-Smtp-Source: AGHT+IH7mkm50t7cPihnPA+Mtp7c1MaBPZ88YW30rwtZtUvq/IeLelvANvv5qyYv9a3slQ04XnZLtw==
X-Received: by 2002:a2e:9b54:0:b0:2ee:8d07:3d51 with SMTP id
 38308e7fff4ca-2ef05d73becmr12317431fa.49.1721295933810; 
 Thu, 18 Jul 2024 02:45:33 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-59b24a76f02sm8189084a12.2.2024.07.18.02.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 02:45:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 15DCD5FBD9;
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
Subject: [PATCH 11/15] target/m68k: Restrict semihosting to TCG
Date: Thu, 18 Jul 2024 10:45:19 +0100
Message-Id: <20240718094523.1198645-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718094523.1198645-1-alex.bennee@linaro.org>
References: <20240718094523.1198645-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x230.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The semihosting feature depends on TCG (due to the probe_access
API access). Although TCG is the single accelerator currently
available for the m68k target, use the Kconfig "imply" directive
which is more correct (if we were to support a different accel).

Reported-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240717105723.58965-5-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/m68k/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/Kconfig b/target/m68k/Kconfig
index 9eae71486f..23aae24ebe 100644
--- a/target/m68k/Kconfig
+++ b/target/m68k/Kconfig
@@ -1,3 +1,3 @@
 config M68K
     bool
-    select SEMIHOSTING
+    imply SEMIHOSTING if TCG
-- 
2.39.2


