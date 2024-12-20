Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF26E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfiw-0004xx-Q4; Fri, 20 Dec 2024 11:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfio-0004E3-Ow
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:27 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfim-0008G3-VR
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:26 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so20361705e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711563; x=1735316363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTnP7W1HHgWlHkzHTS5eKEzWTB30JoAnW3KCxi8Ygk0=;
 b=SFAJY2dJ193hCqmXrjKcbGSuHq4EsZ+CDKa1hCVNr5mdGw2DJGt/0Mleby+5XfBuhx
 0/7/Aww/9N+CXyvDef+Pij125cISa2HDHhtQkkExuZSNfYNBUckMDmHTWXw59rWXlTBT
 iHUd463dSWCdpjxAfd0ppHn2R3814IVt+pqmkK/3fX3zBc2J10H4h9XViJPCnDCzxyQx
 s7DmmhWGqYAmKabnqSXWDmqlsJUQ4dGfzWBihuBHa2GTFsYjY/kMZNiUKz5bqrDqBUxR
 EHhjuJ4/Z7LeOzM3Ns1aJXIReBS6nVIuwYntT10Z03ZcH/MhmcgN6rHIEDNymjNA8n3H
 Ea1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711563; x=1735316363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTnP7W1HHgWlHkzHTS5eKEzWTB30JoAnW3KCxi8Ygk0=;
 b=DHQqO8OHrlMDqUiGCB5t2aJCWQu84IAhsecNeLnddiVE9bJF9qqKuVeg1tc4buPLfR
 8GJh/0I+ktUKQgxzwJY6mhXCs8luWmR7XSYwPGILVhLBuqoE7pX2qVGnef7Nsw8vLz75
 p2uLHgnjRAtYhAb9z9fBeuwZ0xZshY/Esu51tEn3Bpr+UJYekv2lqQQbV07L3OOacH2s
 6+hHRliAe1mdiLvToutgTQVwzomej+O62Y6iBmTmrMTUHYIB/SJ62APgg1+mBzbCDi6J
 ekEjtTKyadiJYeQz/7qbVCTfX4FyKYKgwx5mlGVVU0GxEVxqeyw1J0/uoPtEpUDUQx6m
 R3CQ==
X-Gm-Message-State: AOJu0Yxg9HvgmePCkWfT4eIizjB1hwy043GN+phiE7DbcBH5dY18BwBL
 usmid0VKrq3HiCiSXeRPJCLyEyKgdXlg5DRKf25rYhDpxE++fa17hPrWJRxoYwCb4FmaQ4PVprx
 X
X-Gm-Gg: ASbGncuZ3AA2MA2zMd5Pc388cLN00B3o/7Lq4HdiX7It0+2vzZrvROcBt1aOkH6XZwv
 +k75TBCTxo96m4I966JUVO9YLYet0OYdn4zUzc/3V2nWVx1ye4xkYWLsWey0IxJZ5o0/ud0t7HU
 KHnkSl7nFVlxrFKAuKl+o/ZM1e6PVP2aqOypfmvF3KjSIi+UyDdLa1tRxkQ7syH5QCeqDOUhJhy
 tVHnm0WgHjpGEoq9TnTP/kcdD27wpLuS0RyUjKFDojqPlE62e0u8Pgo1fI7FgZPjiAnL2UAV6w=
X-Google-Smtp-Source: AGHT+IEgoWjMSzkgex3mOJ8UcETNM2Y+tPsLzvqBt876JWjdEWxRzQKCvDzBDBT9ifH2at5uDvsJKA==
X-Received: by 2002:a05:600c:1388:b0:434:9c60:95a3 with SMTP id
 5b1f17b1804b1-43668642725mr29683925e9.11.1734711562944; 
 Fri, 20 Dec 2024 08:19:22 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c493sm49155225e9.28.2024.12.20.08.19.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:19:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 46/59] exec/translation-block: Include missing 'qemu/atomic.h'
 header
Date: Fri, 20 Dec 2024 17:15:37 +0100
Message-ID: <20241220161551.89317-47-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

When moving tb_cflags() in commit 88d4b5138a8 ("tcg: Make
tb_cflags() usable from target-agnostic code") we forgot to
include "qemu/atomic.h", which declares qatomic_read().
Explicitly include it now to avoid issue when refactoring
unrelated headers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20241217141326.98947-2-philmd@linaro.org>
---
 include/exec/translation-block.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index b99afb00779..81299b7bdb5 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -7,6 +7,7 @@
 #ifndef EXEC_TRANSLATION_BLOCK_H
 #define EXEC_TRANSLATION_BLOCK_H
 
+#include "qemu/atomic.h"
 #include "qemu/thread.h"
 #include "exec/cpu-common.h"
 #include "exec/vaddr.h"
-- 
2.47.1


