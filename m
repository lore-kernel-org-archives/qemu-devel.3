Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4915C021A0
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6g-0007lh-80; Sat, 15 Feb 2025 19:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6L-0007fY-SD
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:37 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6J-0006Ia-Ne
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:37 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22104c4de96so13180635ad.3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664088; x=1740268888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTaMzI9FdSjOEy3avv6lC58JclZ0untngvN22ozinnk=;
 b=C7k+ZEMtD77st99VvjknqIosfWQdrY6gw/sKLr7pC8A8BmmWXwxUnfFVNbRyOc17u7
 Nm+g9271ZKDxIBAqi6crQpS1+6Lbk2qZ9C1DYw6MeGxHEqTQMHxXGg8KA0aB/V3EkxdL
 SQJ9HTMy8SfRzVP/qKCHKcHLv2EXX5YgQYinlBjNiTkH5A5KG47VXo60HMfONCOODqoN
 M+hUsWdqiO/pUpXSYv/985ha6E2PgHabVSWFlHEhlTlE+j0nDB1TGMNzVMuE3rHxOwEp
 vJXeVP4fK+hxZECr4WIHz8JZ/k1rtCov5b7lSOnRC3HqWZU5fzzueExUACcS7C+h+TpM
 issg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664088; x=1740268888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LTaMzI9FdSjOEy3avv6lC58JclZ0untngvN22ozinnk=;
 b=Bh2WIxEbhEq1MT7ZNCSEfRR3+4P7i+4hZQPcb+SCGONAFHNY1sFVKl9fK4IAvrikDM
 jkldnW0sY9+4vElUinV9T/lTW415Xf57sU9vcRt8CO3ILgVDSH4YftdDt0zEiP5wrcmo
 NNv8CTR8bBEnHRnBRX/g4RG+TnQaD+jd7+0TIwrYK5yMCnxi1zsnaYoKCM1knydelqKG
 +yMwLiLFSppVoSl2gi4oqQGkvbNzSHmP6P3TFUmzT1e02DmLX9AzLvf5mY9VYAHLDuFG
 T7PJUP3uqqyAQevvPllEbeMqdVOu3j4bLgFnstsH7oZ7/1d14Djeqj3cBy40UqZ5CagK
 X+FA==
X-Gm-Message-State: AOJu0YyrVdjiQ9Bk0UB0xxhKfAOF6RgDIE+bX+nt+qU2Su94xNHujtXG
 iS7tvC7Ux8sYgsD/2c9Z/c9U1asXD7v6yMpL1O7kxMMNqR7YSKhfV4T8/rSDFW4hFwSe7G36T4M
 1
X-Gm-Gg: ASbGncv9FPShNzPsyqG+YGQkiDUl/wK7xKSPZN7RkW7Gl7t5SLj1FzlJAFg/ygsEQD2
 s0h25mNEgrRsTf4O1meXK8CVmyIQH5k7fzab4Wv/AVgDQ4UDMxtrUTQ/3wwOzdKap29bXq9KTLu
 AdsaVlwK+/Tf0kfHaiRcDyH0G0fZlXdFpl21RBI+bj1PwSH7YV2F7uEfU+FE72U2mQGUcn+hDry
 0+FQW5oa/FmWneCI2+o4ZSW7LLM0KwvacIB4Sn3ECoiOTaxBwgUWpAFZQjn5befSU7a9OIEffja
 nPlpS4mknFHT5i+u5gRx9HA54ABMGf3sN337b1gxuWEGGwA=
X-Google-Smtp-Source: AGHT+IFAiwLRRkRRwH2knV7PICEmFluXiYjMVEqsncPrAUsxxdJ0Jh/8ihhHyYOCYvyce+aV0IXqhw==
X-Received: by 2002:a17:903:2341:b0:215:19ae:77bf with SMTP id
 d9443c01a7336-22104048152mr71532635ad.19.1739664088297; 
 Sat, 15 Feb 2025 16:01:28 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mikael Szreder <git@miszr.win>
Subject: [PULL 23/24] target/sparc: Fix gdbstub incorrectly handling registers
 f32-f62
Date: Sat, 15 Feb 2025 16:01:07 -0800
Message-ID: <20250216000109.2606518-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

From: Mikael Szreder <git@miszr.win>

The gdbstub implementation for the Sparc architecture would
incorrectly calculate the the floating point register offset.
This resulted in, for example, registers f32 and f34 to point to
the same value.

The issue was caused by the confusion between even register numbers
and even register indexes. For example, the register index of f32 is 64
and f34 is 65.

Fixes: 30038fd81808 ("target-sparc: Change fpr representation to doubles.")
Signed-off-by: Mikael Szreder <git@miszr.win>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250214070343.11501-1-git@miszr.win>
---
 target/sparc/gdbstub.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index ec0036e9ef..134617fb23 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -79,8 +79,13 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         }
     }
     if (n < 80) {
-        /* f32-f62 (double width, even numbers only) */
-        return gdb_get_reg64(mem_buf, env->fpr[(n - 32) / 2].ll);
+        /* f32-f62 (16 double width registers, even register numbers only)
+         * n == 64: f32 : env->fpr[16]
+         * n == 65: f34 : env->fpr[17]
+         * etc...
+         * n == 79: f62 : env->fpr[31]
+         */
+        return gdb_get_reg64(mem_buf, env->fpr[(n - 64) + 16].ll);
     }
     switch (n) {
     case 80:
@@ -173,8 +178,13 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         }
         return 4;
     } else if (n < 80) {
-        /* f32-f62 (double width, even numbers only) */
-        env->fpr[(n - 32) / 2].ll = tmp;
+        /* f32-f62 (16 double width registers, even register numbers only)
+         * n == 64: f32 : env->fpr[16]
+         * n == 65: f34 : env->fpr[17]
+         * etc...
+         * n == 79: f62 : env->fpr[31]
+         */
+        env->fpr[(n - 64) + 16].ll = tmp;
     } else {
         switch (n) {
         case 80:
-- 
2.43.0


