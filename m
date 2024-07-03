Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF00C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 17:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP40E-0003KN-Hf; Wed, 03 Jul 2024 13:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP406-0003IC-4n
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:42:38 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP3zz-0005L6-7d
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:42:36 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2c8e422c40cso3443709a91.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720028549; x=1720633349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnxIQkGUi2BYtKcUGzQDYlf64W/Zr3vE/ZFzoUY3DEc=;
 b=Hl9tSlaR+CSvJsvwE/cB1RTj535JwahLHOIua4/xUHMkQnI3jZyyZuP7IstoDQbPNQ
 cnoCbcNYOQwYEVKiQHvfMi7ayfwrvPJhKdjYKJGAWTtSPE1C/K6Mr55g5tHm82Lj1La8
 8U2m2vrQHeQWnBoh45Gh6xY0wdwpLoI6tmWMPYOyi8N0EL8lbOoOSzqy15r+Tc2tbn7x
 7W7UPapvVwNRVZ4D10AXgTv9aMoZsa3gA5h0MRNc4Dm/jguDa0vo4MJpUOsaIvfob9RN
 KkHQeIY9XVD+mZ5Xpbz0g1Ax9SFD4v0RYMQ6WZ+C4a35oDCWZUAAvx/R0igQIepz6027
 VMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720028549; x=1720633349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EnxIQkGUi2BYtKcUGzQDYlf64W/Zr3vE/ZFzoUY3DEc=;
 b=KTb+KWvqphYIytSaFaRXe3KMPjAqaQG0fcIcXF6QIXt9iZR/GRmvAvOjoIFexuvgjz
 3k+4n0UKl9dHXGS/j4xYrx+ha/oHvEMLCE5PYVfzpazl7RoMTk4kGQOD17MYfL+lqqod
 +aDYUMwFhETwFFB9hzcd95/FEDB4yd6zjtACA4V+C1BewAOsUjiO5eOXTisJVE7J+zd/
 xcTPwb9ikebEveH+wXACEiOl7u37PcY8aTaTx8X7znFlccQdiWKeAweTmUJqSOJvXwDb
 YdTBEpUGtgKeRpj5cYu8eCD4+20FquzyHbkO12Bo64q8yN1/1mOPFQYlec2280aFHa2I
 JjnQ==
X-Gm-Message-State: AOJu0Yyq8QFguweQU4eE0U4f+/tbS18jhW0Vv/xr+YcWHouap4Gbp0d9
 CnILIG8VVUUIHiFWcz3X3oaq2mmvzkqfp0/U2oVLlsKbEWofsgCmzwhYP/0ctt+5jDBdnbKjCZ1
 H
X-Google-Smtp-Source: AGHT+IFBQUKQglZl9IfJW3f2KwwqeOQtops/qhoSKf+KR1PSz2x5h4Gdkg9I4sw4BYCRpOc1+UWgaA==
X-Received: by 2002:a17:90b:4f8f:b0:2c8:7330:68b3 with SMTP id
 98e67ed59e1d1-2c93d767f2bmr8007980a91.39.1720028548809; 
 Wed, 03 Jul 2024 10:42:28 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7d7bsm11070030a91.47.2024.07.03.10.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 10:42:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>
Subject: [PULL 1/7] util/cpuinfo-ppc: Fix building on OpenBSD
Date: Wed,  3 Jul 2024 10:42:20 -0700
Message-Id: <20240703174226.2117169-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703174226.2117169-1-richard.henderson@linaro.org>
References: <20240703174226.2117169-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

OpenBSD does not support AT_HWCAP.

Signed-off-by: Brad Smith <brad@comstyle.com>
Message-Id: <ZnzM1T6Vo1Q0yAH-@humpty.home.comstyle.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/cpuinfo-ppc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
index b2d8893a06..47af55aa0c 100644
--- a/util/cpuinfo-ppc.c
+++ b/util/cpuinfo-ppc.c
@@ -6,11 +6,13 @@
 #include "qemu/osdep.h"
 #include "host/cpuinfo.h"
 
-#include <asm/cputable.h>
-#ifdef CONFIG_GETAUXVAL
-# include <sys/auxv.h>
-#else
-# include "elf.h"
+#ifdef CONFIG_LINUX
+# include <asm/cputable.h>
+# ifdef CONFIG_GETAUXVAL
+#  include <sys/auxv.h>
+# else
+#  include "elf.h"
+# endif
 #endif
 
 unsigned cpuinfo;
@@ -19,16 +21,17 @@ unsigned cpuinfo;
 unsigned __attribute__((constructor)) cpuinfo_init(void)
 {
     unsigned info = cpuinfo;
-    unsigned long hwcap, hwcap2;
 
     if (info) {
         return info;
     }
 
-    hwcap = qemu_getauxval(AT_HWCAP);
-    hwcap2 = qemu_getauxval(AT_HWCAP2);
     info = CPUINFO_ALWAYS;
 
+#ifdef CONFIG_LINUX
+    unsigned long hwcap = qemu_getauxval(AT_HWCAP);
+    unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
+
     /* Version numbers are monotonic, and so imply all lower versions. */
     if (hwcap2 & PPC_FEATURE2_ARCH_3_1) {
         info |= CPUINFO_V3_1 | CPUINFO_V3_0 | CPUINFO_V2_07 | CPUINFO_V2_06;
@@ -58,6 +61,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
             }
         }
     }
+#endif
 
     cpuinfo = info;
     return info;
-- 
2.34.1


