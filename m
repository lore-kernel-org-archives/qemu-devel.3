Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D536C021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6e-0007lE-FA; Sat, 15 Feb 2025 19:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS68-0007bz-Kz
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:26 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS64-0006GJ-Kd
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:23 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2210d92292eso15319695ad.1
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664079; x=1740268879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qBwpUjrpRy3DP9hoK1GLQ8GO+p0lkCqNn69gucYO0P8=;
 b=K9EfYomgVr8/4ePcgVFR+b8X5M+joBL4CkDoFtH5iX4M01rcJiYZn4XQRvBa02+97I
 ZkoN8BXU/cfUGX4jhInHre5Bd3of1/8MX/EVqseu9rK1zE5K4wmoQDZD6wZ+yyGM5vbr
 3XDuirj+Xwa+5SiDRs+BebAQtAmN7LAUbHqHzf0KQA8Lb/Qoqr7yMbZDwjimzHIX80ZW
 flr7bIc/qBE2l9MUASW7zq06X9CmJuJ5fJ0Npm+3wUsaUQBqVD5NORdcjq817BmcCx3v
 s3uKHI7umvXJfZIERyku/DfNNw+cc658O9bxqqf10IoXwGYXKzIKq9t4jB4ZYisHwWnj
 Sd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664079; x=1740268879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qBwpUjrpRy3DP9hoK1GLQ8GO+p0lkCqNn69gucYO0P8=;
 b=kGYfigtaXQ2x27dPtJily7UbmDXJIyz17kbnTr+eYcqLP0kgvyemd1zxhAJaMkozKW
 0YfV6lz4E0QB2DdyO6FKtBS1IyNu6NyLPiBP7vzTTHZJ59qzW8aFiICuy1IJGJ4ALugG
 Tqq41Lwb6EzrlTYSKM5120ms7fzeAu8ihQhq9MEhdDbpRkFsXeQ8CorvqrPJDcYZRN/L
 dCa45MEX5FL63aEPWPOihFIBw4Tz+u8YWfqycl7mtkjJU+fDtEz+sVDScHiVj8oGF5BJ
 U2PA3f/sGPHfT5PCuFp2oNL39ro9Yv99o1N8Qe5PMWcS3K8+SJGyA1G6hA62mRCWopXp
 TIrA==
X-Gm-Message-State: AOJu0Yxp9yJYKeMPqOr/NT74e7uJMX8MrzvsvYCagZnMlIC+tXZsyEbr
 +rRtL9jh2g0CvQRhsscASaDqxpRqUrAQpYbPNYQBLDpzU34wyiQUpJH+tHX5cX2nv2eo+4CWsrd
 x
X-Gm-Gg: ASbGncv1ErBcS+owNzgJEq9P1oIdA/LymSHYqxjpN83NjLyoWSciIqnHQVSi/FiOVMW
 uhBfm2LgrqOkLVFXrvdfL9wTwsUTKihb8AUFsnwfKGTLfZB7aRUbKy8Dxfs5eSpt0+zXRZ2FqfV
 Clhe9EoHRjhh0ECPAf9mjDjxTVNIaPjodG+MEaLaE+yRnAKNx7DfIVoggPcevjld+Cc/XaQQfVT
 hBBv3L0rWuKwh/i7Ui3NfDUndpWIqvpne+jtKk1m4O8ZN5jMmf1g1shJVmr4/rjjKZZCrZcNc8B
 x7SDYiZML3xpUXD7MsVGCxvGAUd3kanqhCu0/l5FwOZRkPg=
X-Google-Smtp-Source: AGHT+IEOUoc5LMU46oEPyCgxEMlheytN5QZrvuScSFmU9ls2FLI/3Ezrd77ArN1lUwzz1V55VZSzrQ==
X-Received: by 2002:a17:902:f711:b0:20c:9936:f0ab with SMTP id
 d9443c01a7336-221040d6a6dmr68317785ad.47.1739664078861; 
 Sat, 15 Feb 2025 16:01:18 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/24] plugins: Fix qemu_plugin_read_memory_vaddr parameters
Date: Sat, 15 Feb 2025 16:00:54 -0800
Message-ID: <20250216000109.2606518-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

The declaration uses uint64_t for addr.

Fixes: 595cd9ce2ec ("plugins: add plugin API to read guest memory")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 plugins/api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/api.c b/plugins/api.c
index 4110cfaa23..cf8cdf076a 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -561,7 +561,7 @@ GArray *qemu_plugin_get_registers(void)
     return create_register_handles(regs);
 }
 
-bool qemu_plugin_read_memory_vaddr(vaddr addr, GByteArray *data, size_t len)
+bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
 
-- 
2.43.0


