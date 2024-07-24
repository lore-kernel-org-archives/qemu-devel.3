Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C5AC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 22:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWk89-00018O-4J; Wed, 24 Jul 2024 18:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk7x-0000Ma-0o
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:29 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk7t-0006ZB-QE
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:28 -0400
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-8111f946f04so11286739f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 15:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721858784; x=1722463584;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXCw0+RJXjXO156yoRFr2t5+0iBs33zwi5q8sWmsNWs=;
 b=r6iMvlOGayIczFJ0h0RFOFJu9yyAVL9GAM1/mQY05q+fM9S5RZwHHp9dWGm5srJRCl
 PzS61jrbipx52EU0+jtZzdz9kfsk09eKQb/yJniUUNHxv1adNPG8w1CV007jk5wFZxas
 9pfmu2h9UiRctsAJ/e3G9+Xi3249TTjvhbyjl44QYeWXjIsF1QbW7UILcPidl8f/TVBY
 0TgKOlk130MKtl4WlrRiD0VqfD/q3k71cemT/Qo+8VphrbygYYZ3VYw6mm8TbTuGwyNy
 U4wvniB0GgiHzpjAHMfUj6aaWCkNkuMgBcW+QA9UvD0Y5Tqv5Jwk6YuvQQvInUf37mx7
 cgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721858784; x=1722463584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TXCw0+RJXjXO156yoRFr2t5+0iBs33zwi5q8sWmsNWs=;
 b=g09B9vMTisJoZJE8OIPx/rAB+YGtGUe7dNFVAMEEXTGF9nwPZybkSHeqWbZB4k9Q+J
 lsKR3tKoU4ZAIqwBC5uZWWKpnMYOAIWFQOxNo3AXnnfM5kwCV5jkdLM8p1EiePOqHjAx
 sU4BhOOIaELIk9mrIW7d+Q9RDHdB48QXK96osW4uvrdNcckcxmuCABkMgq7QKHkwvN33
 F3ZcBU5uE/6CI/lojAXnWx4DJ+AfM2O9JlcZtnAppOxVZYDAr8HIWz6uGkxwxaShBuYd
 FgnTdGdGkg9qL1iBTKmX2nWj6njFKlTd0BRJsuEIJgbptTJhy8X8598dvlaH7F8VsJmt
 yJ4w==
X-Gm-Message-State: AOJu0YygP9o9lL36APzJacOEQ6MTMGxQLAms2qU/HZb+HxpO+ZSJRwVk
 mqFn0JbLe5WPojvtlbpdMbyVVzLsUWoOK5+UltNkS1tPhfz9rahmxH8IxrI3mluitIFX+lY87vJ
 JiFA=
X-Google-Smtp-Source: AGHT+IEHTiwpbqD+4QcqQQHcRr8UnR+5DAk39Z3abRskK3qGqqcvkq4V33jcXjZHrYdTsXbi/J3G1g==
X-Received: by 2002:a05:6602:6c14:b0:7fe:3c5a:c7bd with SMTP id
 ca18e2360f4ac-81f7e3e2e37mr22559039f.1.1721858783843; 
 Wed, 24 Jul 2024 15:06:23 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa983f8sm10086173.47.2024.07.24.15.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 15:06:22 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/15] bsd-user:Add setup_sigframe_arch function for ARM AArch64
Date: Wed, 24 Jul 2024 16:04:39 -0600
Message-ID: <20240724220449.10398-7-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240724220449.10398-1-imp@bsdimp.com>
References: <20240724220449.10398-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The function utilizes the `get_mcontext` function to retrieve the machine
context for the current CPUARMState

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240707191128.10509-7-itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/aarch64/signal.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
index ab3bf8558ab..43c886e6036 100644
--- a/bsd-user/aarch64/signal.c
+++ b/bsd-user/aarch64/signal.c
@@ -81,3 +81,17 @@ abi_long get_mcontext(CPUARMState *regs, target_mcontext_t *mcp, int flags)
 
     return err;
 }
+
+/*
+ * Compare to arm64/arm64/exec_machdep.c sendsig()
+ * Assumes that the memory is locked if frame points to user memory.
+ */
+abi_long setup_sigframe_arch(CPUARMState *env, abi_ulong frame_addr,
+                             struct target_sigframe *frame, int flags)
+{
+    target_mcontext_t *mcp = &frame->sf_uc.uc_mcontext;
+
+    get_mcontext(env, mcp, flags);
+    return 0;
+}
+
-- 
2.45.1


