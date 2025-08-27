Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B35ACA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPT7-0004pA-RE; Wed, 27 Aug 2025 19:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSp-0004Cu-5S
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:00 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSj-0004Ij-7W
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:21:58 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-771e15ce64eso333222b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336910; x=1756941710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSVqd0uuUJulTp/+1527diZnoWMaHN/H9TVCfEJDaRI=;
 b=xr5B8yZ4U9OJb1E1vmQBXlFDGUkW4rPEJcH5spjQGqxWOkZZ20h4Y+EKehmSu/5quz
 1DkamLimHKbBNyZNgkwkkOOEpYvu8wj6AUNW1nMgZBbDCyuT9HqYzE/inSyOQX0zN+oq
 W+Aq+2KRek5pdicUMK/WGloJ3oo0sI6R+gOTQ69M24d8HIFesTo5K4mjSGHdHhVrcysv
 m0k7I3JxizX5D9eIbGgo9x6AG7nnQlY2qJa4QsPxZ0D4GW9YbLrprOLtNWCuOOyWaSeI
 Ale+wK0YUch+R1gJ6Sm7t2CiAYPa0ODNYZ99IXJcefPxYvzhGxgvk0lN+6gjyHW/5EZ4
 QmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336910; x=1756941710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WSVqd0uuUJulTp/+1527diZnoWMaHN/H9TVCfEJDaRI=;
 b=dNoNRkuhx/tgpbRszcexXepBljY0gndoJCPfkR2JTOZSEqBVmC/yeS/43uxN8vgV1y
 xtvolnHAm/niyQK5myXnFvUKxgxP7qQEyu9eRXHzsOEL4xE9ze08EwJY1lXF2wOhVrri
 q0qSBE/G8jDDoe4WJ+nMan08XCHYExWXTg452Z6dmwk9sHf9w9TLyrdjugRXXljhiXZ9
 1lN7mO9pCy5BXq8DTcQw0ndH/S9j5CepJRTJijhxsAFnKyqvCWNFVKagwqe/XOqcSJ7H
 bjrZcxkIrdNU036E0wzWZksbpq3kayz319ZAixc3O45/zSeHkBeew3FEzaBtZAOuW3c/
 D6bA==
X-Gm-Message-State: AOJu0YwYznvigz5O4MGhVjqBEVqwZVBCWwuu5L0FiZsSQz/5C9Uf/mXH
 b8S5utRVDK8x6Fw4WNzgr2Wyxv+YAzxasD+xGwvbs8pOSMEfGiZgq6CD82ITG2uNI6/xYoZyTII
 vKCoTFMg=
X-Gm-Gg: ASbGnctHnG1A0HUuwbAedqt+2iXEi00jpaBqjJixwErk261z6FKd7EveZ+gRicCouAU
 EoeQ3FSA9656HMEqwSXuBOZvsiRWAT/5yxGl/E62H0p8heJYB0vMsZzp5nYNZH2bYNJZSyZ/571
 sTx5M8udhDxdIAkxC067COaTSA6cyJC1ILVW6PQYoLXS93OGzhmzHz1N6cobxodM7LazFXYbOK+
 xKBb0oENPige7A+CitLHQbpTHQwwPkriv+ttKomjMoQOsnWUfKhNwH6ku4ZhCh980uFVjhxb8wu
 hJ0xGlrQEfLrm1U7Ir1xiL/cIsxpJ4L/jZpYw+hYhuMYmzTkWDw4LC278tmGgQ2hpwD388QkqJM
 rZOSesF0wUrN5F5qn3SQ9UgM6Ig==
X-Google-Smtp-Source: AGHT+IGsu9g81Wemy2pp1RCMtXzXe3vD3RsvfOUZ9X/bGAFp8yd9AFgPzpdl9p9B2whqmq+fGDwX+g==
X-Received: by 2002:a05:6a00:2e21:b0:771:e935:9a0 with SMTP id
 d2e1a72fcca58-771e9351f1bmr17706151b3a.13.1756336910392; 
 Wed, 27 Aug 2025 16:21:50 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 28/46] linux-user/arm: Remove a.out startup remenents
Date: Thu, 28 Aug 2025 09:20:05 +1000
Message-ID: <20250827232023.50398-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

The setting of r1/r2 was removed in kernel commit acfdd4b1f7590d0
("ARM: 7791/1: a.out: remove partial a.out support"), and the
kernel commit message explains the history.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/cpu_loop.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 739e1607e3..9aeb9b0087 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -492,10 +492,6 @@ void init_main_thread(CPUState *cs, struct image_info *info)
     env->regs[15] = entry & 0xfffffffe;
     env->regs[13] = stack;
 
-    /* FIXME - what to for failure of get_user()? */
-    get_user_ual(env->regs[2], stack + 8); /* envp */
-    get_user_ual(env->regs[1], stack + 4); /* envp */
-
     /*
      * Per the SVR4 ABI, r0 contains a pointer to a function to be
      * registered with atexit.  A value of 0 means we have no such handler.
-- 
2.43.0


