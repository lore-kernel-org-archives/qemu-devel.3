Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B47C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt7u-0001yS-Ko; Mon, 08 Apr 2024 13:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7k-0001v4-Q0
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:47 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7h-0003c1-Po
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:40 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6eaf1005fcaso3230123b3a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598576; x=1713203376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eljbs2yNGMGPnWHJwv7NSq5kkRuO1URzZsDZcIZtS6U=;
 b=M8XoFFgl0ZUDR9CMxS9z/674CiBP8t3ibG2rq4MDi3WY0KqRMpV3sy9VgQaw2eQoAS
 rfPc3fzlrR6gM3qQ5Jmr2jBaRX293ZUKGdx2fIB2oJNiTFFHQfRfX7KfXNx9j2cdZg0b
 ELx3i53+gKplD/nhsfYty49m9FSUMJT4z3CISh1PD+4CYzKwgwDOZvmZvVcQtgoQcsZK
 c/6yrncgWwp/g3inlZdeIGu86EDW0wbgMUL0cqoMSr93ZL/j+XNPlUbxreKJatH6FjnE
 f8hFVFe89BpQmKkTe9TmuQA1jRD3neh/cZWHbZHtddZ9zLpp6+NWaa2mK3BQ6slLMEUB
 QzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598576; x=1713203376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eljbs2yNGMGPnWHJwv7NSq5kkRuO1URzZsDZcIZtS6U=;
 b=mEaBNA1ac38LTEb8Y66SpDVAuud5eguKeHz+qtN/GNn3fk/eLUTv8Gc0FVtMWmSlwz
 kUbbT0ncT4cHkspSIxzJ+OOsTvJxalSvw/xpEmZOf8KX1u+aa+SfTb+UmXItCx/50uXN
 2/DpFa8bp7LekCeqlLgToNG5TAzXsgYx2zpzK+ffAUytjoavhArAK5niVi2R/8Rv7hd+
 Hj4XQLJfQCQk8YymS4rzWvIiqgT2GCUH9BaNbc4sN+nJYy3L8RfcxuATK2AYCuu4ZmSH
 5vvgF3sa4FZUI6Gj2i0YSvozoxGU/VZ1xzQ2nnVYb79mMkNRVJdpH2WrzxU9xB1+I0V+
 a9iQ==
X-Gm-Message-State: AOJu0Yx8eG9BvFf2u4l6Ldh2dJYdaT+JDKkWg/EDXcG7ASQadEvzF32h
 j5qdrMBoRu6+3JTBRUlVO7dtGAD/2S4zA9IGV6bpEXCQCfUTE3EjQLiUDyufQ2PKJeQTS4PSWmn
 q
X-Google-Smtp-Source: AGHT+IH70IZ2zJgbCNcYWxmVj2WAl3fhBxMySO0HQaLa1HYjQAqSZBGcfH1etz9KKgg2myY0lwEteQ==
X-Received: by 2002:a05:6a21:9206:b0:1a7:56e5:b047 with SMTP id
 tl6-20020a056a21920600b001a756e5b047mr5168778pzb.28.1712598576378; 
 Mon, 08 Apr 2024 10:49:36 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 03/35] linux-user: do_setsockopt: fix SOL_ALG.ALG_SET_KEY
Date: Mon,  8 Apr 2024 07:48:57 -1000
Message-Id: <20240408174929.862917-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

From: Michael Tokarev <mjt@tls.msk.ru>

This setsockopt accepts zero-lengh optlen (current qemu implementation
does not allow this).  Also, there's no need to make a copy of the key,
it is enough to use lock_user() (which accepts zero length already).

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2197
Fixes: f31dddd2fc "linux-user: Add support for setsockopt() option SOL_ALG"
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20240331100737.2724186-2-mjt@tls.msk.ru>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3df2b94d9a..59fb3e911f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2277,18 +2277,13 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
         switch (optname) {
         case ALG_SET_KEY:
         {
-            char *alg_key = g_malloc(optlen);
-
+            char *alg_key = lock_user(VERIFY_READ, optval_addr, optlen, 1);
             if (!alg_key) {
-                return -TARGET_ENOMEM;
-            }
-            if (copy_from_user(alg_key, optval_addr, optlen)) {
-                g_free(alg_key);
                 return -TARGET_EFAULT;
             }
             ret = get_errno(setsockopt(sockfd, level, optname,
                                        alg_key, optlen));
-            g_free(alg_key);
+            unlock_user(alg_key, optval_addr, optlen);
             break;
         }
         case ALG_SET_AEAD_AUTHSIZE:
-- 
2.34.1


