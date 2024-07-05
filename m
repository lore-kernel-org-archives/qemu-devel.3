Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EBEC3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPebk-0001Bd-Hy; Fri, 05 Jul 2024 04:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPebL-0000wh-OI
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:33 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeb8-0004BD-V2
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:30 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a77b550128dso175010166b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720169233; x=1720774033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/lQrpNj9Yq6e2VZHJs41tWCzx2SCmT2FMLZDJQM+poI=;
 b=oG37dxXwk5vuKP2tLldFZ9w8iLZuAJguF4DWl50z1X3THqTvWmmOALLGKJ/Tny1rFf
 YOCFG3gnuqkZkIPPNuAlzTOJge2Wi/3BfNX58z/e8J6jujulDgJQ7tfy0I2NhXfCOos+
 F9Vb2zLCUpj48qNDUOzRi7TMdlz7reTD67QAXYLvygqF8ZUrrS8QjKZhygm5Hd2V8e54
 PdHQ3kvzS2UPG1U3/Uzh1uXDSIxUI0rvAeB6ksCCc1avY92fJ9JG8Shb+dG696CJ0otm
 lzqfInk3wKqXDxh4yC5XWDLnjC76q058U2xquuq4zP8P0MRhJ5Fi3YUBaPF34guA3o7C
 OhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720169233; x=1720774033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/lQrpNj9Yq6e2VZHJs41tWCzx2SCmT2FMLZDJQM+poI=;
 b=PDdudxiWN8AFX5OVXLli9zhW+pOv9jgZDoA9u3nHGYqL1aLHENo0jn6HuwpkQlwQzX
 aMhh9RVej3MlX/dvwf0fcuuqV74mPx2N7XotqtqIxchs5TFinSbrtr0dTlubm/jIChUb
 iJqGA1DFMENNQRKJ0ehamId+98wY7Le6Mf1+zKP+QMEogdZoVQEGbrQEImY/sI8xy6SE
 /qbETqWLCHsAJoeKFCAk7nCl5m/bvHnL8eO3591axTGQlzGpi5FZjbzzxZ8EXEOk4Cbt
 IBnqQMZVXd8RmKo77hpiDc8fieyU3bc2Za3tAhTcc09Wz+0gYriVzPTKx0ndtjiUE43N
 2CXQ==
X-Gm-Message-State: AOJu0YxYHJAJ0QGgQurlLESGcSt1yBvqyfbE0mfsiNBgR7QTop8WrvUm
 koGg72rAdVdUvhI+f4H3hO6PodXAY+3jBTeqPQide5FMuOJjRMwoVRvr62dXELg=
X-Google-Smtp-Source: AGHT+IGdDQdvYQW/Eg4YM6ALwJo3mPLl9gsHQOQNAU81B1D6gECjzwAQ0okTX93dgHhOUQSazOC6Tg==
X-Received: by 2002:a17:907:6e8d:b0:a68:b73d:30d0 with SMTP id
 a640c23a62f3a-a77ba45577emr318787266b.6.1720169233321; 
 Fri, 05 Jul 2024 01:47:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72b19d9b62sm630605866b.130.2024.07.05.01.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:47:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 21A4A6214B;
 Fri,  5 Jul 2024 09:40:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 25/40] plugins/lockstep: mention the one-insn-per-tb option
Date: Fri,  5 Jul 2024 09:40:32 +0100
Message-Id: <20240705084047.857176-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

This really helps with lockstep although its super slow on big jobs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/lockstep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 761bcdf363..353bf12dfb 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -14,7 +14,8 @@
  * particular run may execute the exact same sequence of blocks. An
  * asynchronous event (for example X11 graphics update) may cause a
  * block to end early and a new partial block to start. This means
- * serial only test cases are a better bet. -d nochain may also help.
+ * serial only test cases are a better bet. -d nochain may also help
+ * as well as -accel tcg,one-insn-per-tb=on
  *
  * This code is not thread safe!
  *
-- 
2.39.2


