Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDD7CA101F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuRE2-0003Id-Hy; Fri, 05 Sep 2025 03:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuRDq-0003AD-S5
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:51:03 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuRDj-0008Rp-O7
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:51:02 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45cb659e858so14281045e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 00:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757058652; x=1757663452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/NzJ2bgCdwbYumw+RjHPeb+xKv2XqzVqFCtxzAa+WI=;
 b=F9WbLL8gPt1/ymcE9uSGUUlY8CY7+K3mSJ8ni5r4rWLqvrYmz1EuMnSu+cWrK4Aohn
 nLmHzV2luCBlncssxADelghaJ7G/ysfajGb73NFRFlFAxbmk+Xdp0fA5+AovqPbyvwjy
 cYSivKlygAri4zzwDvlzAsaDAEk/K9lX4tL4+N07KKjMPsoFJ4Rzwlu3gYtUWxFREk1v
 CsUPhk0WH57DsVTKmrwpCn7KVn3xTKcd8VdfhsH5mrmUIhNKKSQsSoz8gyCBuyYxNxi0
 q9k0w7jzkr83QssMDQ5mpPUHa4Scg/X19iMVZhAsZ0fO6etzOtVf7JW8H8HzyaVFnqIW
 cTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757058652; x=1757663452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/NzJ2bgCdwbYumw+RjHPeb+xKv2XqzVqFCtxzAa+WI=;
 b=jG9ZeBQoZNW/8o8jXEj+0UQMYKHeEPIHSAUX56/x7G9ot60sbn6/tCzFBzLkOryZhq
 lEqJcFVrqP3rt/1nw7oG/5AMC7gw7yJhpLdK2Ro1Fx+1UeCjkGfQra74moQSN1+6Tcih
 dGTVqCB+ldNZbFdCsDUFLI0FyjwIzJ0DUVyhy6T0P3waPskpimJRZlq0aecI0zpdWgpJ
 7Vnw4awdENw9vNrwR9l0emYemtDqtI5hIT7egHJzR0jKboFeeM+cWkVzLRbpVa7h+7rr
 R5l3Prp+2MyGyKZ3NnpAbnUoPZCEJq80t6DYrR4xauHbfAYhWTsZe9QzoCB56YwmdsQB
 YghA==
X-Gm-Message-State: AOJu0YzhyjNSNEmA+NKVui5Q5H2wqZflfZn+09zVu1vNCb57AE22ubHr
 z3142m2zht+svBJDuJNGMwxvMURYrsyIqq36MQCAIz/femzFMAHXtST/onCzTfHxB+yqGYCUKyB
 icbxLFds=
X-Gm-Gg: ASbGncts9PuWXKzjIVH1X4DQWeWw/8MzfevZ1l+EDSNwR7ticBG0ozZBOPvroolJqi3
 sQwAHdWOUstf1QF4JGocpmJgchnaU5p10oDzXtKxxcRfBRoWi9YUzb+UB6p8SMEeSkcZ5Y54K8V
 hhljtxuso6X2839zka6tlj/+FDx+DYswXWCRj8zbdCJ0dR3CFmbxbEDoZUVolVtKEng3uWbYmMZ
 V3092czAFBnwcLSDBcdWtw5h7KhocrsS3XbY/DK86JV4hz5MsEieZxP7HCbRKsJMNCc9vUTb48N
 wHuxumkwvbq/TMoePT0NJuMT19BUaNXw5+dnE1fK6/n6mNQBfbdO3uvKqfRN3TDfmqJvaeoCU+j
 tuJ6JMmlz4MoU1Xq5ccR7TseurSZc1oM+U+PdfzZN5M2GKw==
X-Google-Smtp-Source: AGHT+IEyMzR728QiLRjdRt61RPDhpM2giL5db66GL4rjRrjYBuZbKj1hYu8Nz2FA/sJFq7oGtJc4Gg==
X-Received: by 2002:a05:600c:3596:b0:45d:da20:1ee9 with SMTP id
 5b1f17b1804b1-45dda2020efmr8085695e9.30.1757058652380; 
 Fri, 05 Sep 2025 00:50:52 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b98e77231sm143760715e9.12.2025.09.05.00.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 00:50:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/6] tcg/arm: Fix tgen_deposit
Date: Fri,  5 Sep 2025 09:50:42 +0200
Message-ID: <20250905075048.100496-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905075048.100496-1-richard.henderson@linaro.org>
References: <20250905075048.100496-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

When converting from tcg_out_deposit, the arguments were not
shuffled properly.

Cc: qemu-stable@nongnu.org
Fixes: cf4905c03135f1181e8 ("tcg: Convert deposit to TCGOutOpDeposit")
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.c.inc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 836894b16a..338c57b061 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -975,7 +975,8 @@ static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
                          TCGReg a2, unsigned ofs, unsigned len)
 {
     /* bfi/bfc */
-    tcg_out32(s, 0x07c00010 | (COND_AL << 28) | (a0 << 12) | a1
+    tcg_debug_assert(a0 == a1);
+    tcg_out32(s, 0x07c00010 | (COND_AL << 28) | (a0 << 12) | a2
               | (ofs << 7) | ((ofs + len - 1) << 16));
 }
 
-- 
2.43.0


