Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DF1C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8d-000082-P5; Wed, 15 May 2024 05:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8M-0006mX-S5
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8J-0001iX-FL
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:14 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41fd5dc0480so41349565e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766070; x=1716370870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRr5iMjk/iKTg9QSCtlcsOfq6KzG2dbDyArDFZKIcHE=;
 b=jJII4ey5Zgp0cDz/aZfSlQ60Y5GWhPlntRUmO7F2G+xRYFY+ZYY5cEM9rv5LaracjP
 zgXv5VnsexSA2hnUrMbM/F6TkDlUwID6hlp0GuaCgneUMTWqM5cpeja7BnOcgbyD+cwl
 cAsJ+w4N0ND0/9aa9+bu2SJkdJEjIP+SwhtGViS4WqWSf9tiv4FSSnZk3MC8ci+6k70i
 sSpj6kS2BbWUgJa+NHpqrbaBmILXmSdJ1v/IrP/RmvWA3a7ONA2D3NHN3v30LipJMuIE
 BGyZbDhqf7FgnOgfWXorYYAUBQQyfRMR7hhFv9x9tP3XxUijlvHhEn7bw7UkBnl0SVzQ
 46mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766070; x=1716370870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRr5iMjk/iKTg9QSCtlcsOfq6KzG2dbDyArDFZKIcHE=;
 b=V5vZWwHRK31LsMQYzbxWHw9E9nzYEO3jwf1FcrLIFDjBtY4/DgAmPLdCJsEo7YGYjZ
 iJ/xNEMEBo9OnVNV1FMYxeMR6AYr3kxFVsm+HYsbyDa9ppTulPbiFA+FfLI6Uw5vvoJI
 iKm7Kqg07yTZnjBRNTJaRA4TVYPqFNW6D2jyDSflkadAcKlrja2f7FGP0KXdO7xKYFi8
 lKV4U2goBAwCG37d3my7LUUlwCFH7U+PmYXhKh4absXHyiP7N8evf+bvknqPbLYzEoRL
 fGcDuVBq8rXvnsKg4c7K7n0Hmyr0/ahNu1GcmRUJLdaSi3bPutYM38h67kjHuHw40VZU
 K2ag==
X-Gm-Message-State: AOJu0Yy6ORpdGDqAp+694jBGpxdMmeoLxysLhTUh26BmEKTiROA1K+Qu
 zoHTygd8pYWoGoXloRB4FNwmhwLEQHEF6P1nv+cc7uchjOWZaAPzKf6A4rhiyFyS8npUe605/9b
 MlmE=
X-Google-Smtp-Source: AGHT+IHM7MJdy1liCgrBrsMA7QXKB2sCU72FwsuwOjguxL7PBEw6niYAGMyjl28mOf+I+FazoSXzXg==
X-Received: by 2002:a05:600c:4744:b0:41a:b30e:42a3 with SMTP id
 5b1f17b1804b1-41fead6ce54mr115167935e9.37.1715766070003; 
 Wed, 15 May 2024 02:41:10 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/43] target/hppa: Split PSW X and B into their own field
Date: Wed, 15 May 2024 11:40:35 +0200
Message-Id: <20240515094043.82850-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

Generally, both of these bits are cleared at the end of each
instruction.  By separating these, we will be able to clear
both with a single insn, instead of 2 or 3.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h    | 3 ++-
 target/hppa/helper.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 1232a4cef2..f247ad56d7 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -208,7 +208,8 @@ typedef struct CPUArchState {
     uint64_t fr[32];
     uint64_t sr[8];          /* stored shifted into place for gva */
 
-    target_ulong psw;        /* All psw bits except the following:  */
+    uint32_t psw;            /* All psw bits except the following:  */
+    uint32_t psw_xb;         /* X and B, in their normal positions */
     target_ulong psw_n;      /* boolean */
     target_long psw_v;       /* in most significant bit */
 
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 7d22c248fb..b79ddd8184 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -54,7 +54,7 @@ target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
 
     psw |= env->psw_n * PSW_N;
     psw |= (env->psw_v < 0) * PSW_V;
-    psw |= env->psw;
+    psw |= env->psw | env->psw_xb;
 
     return psw;
 }
@@ -76,8 +76,8 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
     }
     psw &= ~reserved;
 
-    env->psw = psw & (uint32_t)~(PSW_N | PSW_V | PSW_CB);
-
+    env->psw = psw & (uint32_t)~(PSW_B | PSW_N | PSW_V | PSW_X | PSW_CB);
+    env->psw_xb = psw & (PSW_X | PSW_B);
     env->psw_n = (psw / PSW_N) & 1;
     env->psw_v = -((psw / PSW_V) & 1);
 
-- 
2.34.1


