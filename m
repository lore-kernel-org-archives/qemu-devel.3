Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4615FC27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 14:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGgTo-0008Gu-6z; Mon, 10 Jun 2024 10:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgTi-0008EV-8u
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:58:34 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgTg-0004WN-NK
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:58:34 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57c76497cefso2040892a12.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718031510; x=1718636310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWQ9swtHKmaOCXCNUZVXDCsGfJqeWobhkzplnSNVd9c=;
 b=eomjwc4Mggzbg48c0kjh42Ltp0iWg0nUEywKYPo9fYL+KFljzIVjZJ+9T5HzOXAG/l
 r9JMYGXee0jKapPzsTREd+OT+zFefCKapynhnIs0QxJ7V95vOWlxb6muCnh+p1RHrcjd
 Uui6haG8968yA6HQlJHx8nyDuL0ZrfIgQ+coSg4OWWY9zCggzsZfn5ossyzCAuZiHWTT
 eJP1lbIWFA1V4SujLokQyF7c13Ukh31LCD/pUsUXJAy1soIArgGmGjCU33egS1c1B/Az
 4DLBTyQtM5z45cRAxzRK6lkDRSb+utmmSgETruCPgWRXzgqcPtAYNW5G+rxt9hZwjIdT
 I8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031510; x=1718636310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWQ9swtHKmaOCXCNUZVXDCsGfJqeWobhkzplnSNVd9c=;
 b=AO0GBlrCnWpW+g1+Z0rjOFX6ieCWJPwZHyav5/3wUeg6b0HJG9KRkCMshuB5Y1gKEy
 DpyfES/cPQVdClKkA2npph7Maz4aFjFWrlZUnrSwflPPtAojIfALghs4pjzkEF7q3V7x
 sBIfbXNiJ07rmXAWF++GJ/JCs4gNtkGbk4oG24F0mxiZuAiJJrVbe2fzFn/5/TmRn8+a
 /D1J0mDgoaR04B3PnysLxjFNpJ8pMDC7p0LmTPOoqacKXCMa1e8bk5mENxnEhzfPziYg
 ZYXAEyFmxqJ+8EzfvXWCPAjXjhDiPkuNk5pxUjOPh8hNAPGNE7QgMdzT5AAII6KlCCe0
 8TKg==
X-Gm-Message-State: AOJu0Yyjh/IXoUI823fZnggVmKDZ397ra/8cq0vsd2A/GlxBUwA6m6kE
 gDms9IqlAIhq9yiw9hxbk542FhN8jfLs4GEAIZ0rrWHSM2HKym1yoeBp+oXmbEdLJNWmefbdSQl
 t
X-Google-Smtp-Source: AGHT+IHItSRvMt7/f1/CyMEwNOb0OMLMYHgxJlBwSTMHzhWx8AXW2mpAQHyo31zA2fH7As/cnih98g==
X-Received: by 2002:a17:906:eea:b0:a68:e7df:350b with SMTP id
 a640c23a62f3a-a6cd7891b58mr633603366b.35.1718031508926; 
 Mon, 10 Jun 2024 07:58:28 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f20563a26sm123065266b.129.2024.06.10.07.58.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jun 2024 07:58:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/5] target/mips: Restrict semihosting to TCG
Date: Mon, 10 Jun 2024 16:58:05 +0200
Message-ID: <20240610145808.2267-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610145808.2267-1-philmd@linaro.org>
References: <20240610145808.2267-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

Semihosting currently uses the TCG probe_access API. To prepare for
encoding the TCG dependency in Kconfig, do not enable it unless TCG
is available.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/Kconfig b/target/mips/Kconfig
index eb19c94c7d..876048b150 100644
--- a/target/mips/Kconfig
+++ b/target/mips/Kconfig
@@ -1,6 +1,6 @@
 config MIPS
     bool
-    select SEMIHOSTING
+    imply SEMIHOSTING if TCG
 
 config MIPS64
     bool
-- 
2.41.0


