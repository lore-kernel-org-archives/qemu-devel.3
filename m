Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53F1C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 17:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP406-0003ID-7x; Wed, 03 Jul 2024 13:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP404-0003HP-5K
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:42:36 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP400-0005LA-1c
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:42:33 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2c95ca60719so1562168a91.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720028550; x=1720633350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALTg/zUrt2COBtOO9DjvL7voDCkhzi+Pxaozp6yG5io=;
 b=xmUappTTKZm8G+lh50X3tnBvBcxjvdydd+YDoNyAZk+HL1hLf4vdVongUkbOijGj0v
 PnaWefXdbgzbGG70wStJHuuFYFhL2eQyFqGXJ1HC7il28cyGFQd8rr+NCyEYzybELTb5
 IbA9J/yGZD7A35sC19B5m09d56UK+0VTtIhpoSoLEV9dhHWxVJGCLlo/Y05s/RBQwuNl
 YBxkYxXHo7zWW2UsQ+kRuh2WJiAb+nyOJwB08Fv+M+Tf7Wvzzgv9GwGlrLbYkWyWve1J
 CCu0biYa3BGOc9vt754VuZxiDJBKtP2HlZHACaOj6qOzjYkhPmzZ2hsDfah5KMU1LBuO
 sfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720028550; x=1720633350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALTg/zUrt2COBtOO9DjvL7voDCkhzi+Pxaozp6yG5io=;
 b=k6l1ZzwVMZJRMrF1V/ErpmaXW0OMBAYEf2aEo8ns/KSyYRRYzbf1L5oRlmWmcegDAI
 21iY/bThWkMmANpfKD7KdfftGn1sjsCroVSyHzbdT96h2BEt9ApSu+sXG9o6Z9XHFDtx
 hprYZy8DxSe9MDjEtfDh3EVvta9KO56a8AbB/sqndqz/U0gbeNytEl9pTl6QkapIR0R2
 olXxK4fqpivj1PxzCMipQQlKFp9DJTtM58yixWV/nN3FxbKC6+C7Jd4+CjoLIh4BkvEa
 lpTuocTgFjz6kTjVQpSollNKlPQnr262yOQhIv/MFphIq+XZbrceh9tF4Dfd2FzvwcR9
 A62Q==
X-Gm-Message-State: AOJu0YwyWs5L0pRcBQ1PJNkvDAlJwgTVFrSB6rTqUzlFBmUqeNcgEnFk
 IDdcGJs0lta4a+zLAfm87kfXMlw+fl0u0PYTvBlYp5sVnIWpULOV/NTJG51rKVj8yVlZikbziFT
 f
X-Google-Smtp-Source: AGHT+IGwJ2JngaZxP1W/zPzC0JLHlUwJqnYwegYbPLBN105iCnpAF5DlTD6tjBvuowQBDDqCHsb07w==
X-Received: by 2002:a17:90b:202:b0:2c9:754d:2cb7 with SMTP id
 98e67ed59e1d1-2c9754d2d0dmr1906021a91.33.1720028549707; 
 Wed, 03 Jul 2024 10:42:29 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7d7bsm11070030a91.47.2024.07.03.10.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 10:42:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>
Subject: [PULL 2/7] util/cpuinfo-ppc: Add FreeBSD support
Date: Wed,  3 Jul 2024 10:42:21 -0700
Message-Id: <20240703174226.2117169-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703174226.2117169-1-richard.henderson@linaro.org>
References: <20240703174226.2117169-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

From: Brad Smith <brad@comstyle.com>

Signed-off-by: Brad Smith <brad@comstyle.com>
Message-Id: <Zn9cJ3puWr5lIgsg@humpty.home.comstyle.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/cpuinfo-ppc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
index 47af55aa0c..1304f9aa80 100644
--- a/util/cpuinfo-ppc.c
+++ b/util/cpuinfo-ppc.c
@@ -14,6 +14,13 @@
 #  include "elf.h"
 # endif
 #endif
+#ifdef __FreeBSD__
+# include <machine/cpu.h>
+# ifndef PPC_FEATURE2_ARCH_3_1
+#  define PPC_FEATURE2_ARCH_3_1   0
+# endif
+# define PPC_FEATURE2_VEC_CRYPTO  PPC_FEATURE2_HAS_VEC_CRYPTO
+#endif
 
 unsigned cpuinfo;
 
@@ -28,7 +35,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 
     info = CPUINFO_ALWAYS;
 
-#ifdef CONFIG_LINUX
+#if defined(CONFIG_LINUX) || defined(__FreeBSD__)
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
     unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
 
-- 
2.34.1


