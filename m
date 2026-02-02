Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E6AE7FDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 23:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn3ci-0005cI-Eq; Mon, 02 Feb 2026 18:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3cd-0005bd-OU
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:46:24 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3cc-0004vB-BM
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:46:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so55616465e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 15:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770075980; x=1770680780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0nzZz8DG59Mf+z+m0h8r7zWQPfwbRc+kNGo82GwXbU=;
 b=kbb03zINU7fXdxVd1Wn9TQ0U+j83cXhTgYfn+nNGb0FyqFBBGOuHanJVVa5PZkbpl6
 3X0E5I4OaZMs20/fnreyuKRmBBVZ7x+cl/8c7RP45VCKLzdOPujWrzLyIo8ZVhQ07TJi
 Nz+oRqCT39eAlqtm8wFNtr+qkDEXX2BXy/HAy7gcYKBPSf3TW/vEMEpzZPlRMzWi6DLj
 2kSP1gG472da9tWRrmnEST6Ok4cSTnkArJd9Aj+h0XiIVaEx6Y0yM8dB/rDjAHG/M4ag
 Tnz0yY75ysB/IUPJyz0v+UEPgXrA8cbGJclspTD7a+crr4t2vB6DkrQkI50uCo4YWM2Z
 zQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770075980; x=1770680780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K0nzZz8DG59Mf+z+m0h8r7zWQPfwbRc+kNGo82GwXbU=;
 b=EblhikwIbmJ6bV9LAdTyCzedb1qOTnDvOlsZTZqhlBGvYh1Y2D3VsaCPUvK9o4vYP5
 /if8ydhKyQn0/iRa7Zoopq6vbCWlfd3NmHZlLvogCj8n5siU5UoT1ihaaU0UvIMn6Mv4
 RufB/2ZFyWm6HTm8nj9jmkZtOz41usSxp23iuPCUzHN+DkPzA6lNctY+xlhHcMGXOnNR
 m7ZW6aZjvWindqNWkSEZl0kB6D78VhNiTastSiMptUBTkkJovDqbeveyZCukLeyv0pSm
 zB/HXOy2bCmlEXFIilUlz1FX7hpxsbWyPSN/sPzLoShbeM8s0eCp0dTALPIVi0Q5B/hr
 6EuA==
X-Gm-Message-State: AOJu0Yy91ij4SomqNcq3SP0bvGu/XheCq6y4Vfp2HkFE33aHKwaVHPcc
 +YOZ6NlA54zUevaEqzKMK+iDQ94+zkm88sWnq4KcoQ6NK3gxpTcePzs/w4P7y619uS3IXfZRIKx
 eLxEUvYo=
X-Gm-Gg: AZuq6aJ6qPbfsQElXcUB0rnJDeNXzfXyMrMzQ+nODfhiplMOKxwDEK2E3mf/grlOykd
 HjhzCnnN7oAYCaH7ktQClztPQTiGHg0UK7th7+FRCD/4K7d8h7lgHY+bhNXJ9wzJrVeSjC9+qbD
 4Fxm4kVGwTI6/mwK72CdeNDwnduEOnuGn0XeNbYkwc3MzTeMrDvdCMiv+fxEQxrGJjTlQMnuRPX
 PyDqhtL10e+Cicbn+NeI1e7RCfx6pFtNf9n/14FeUxC+qKlNcHCXi1dVBhuqkVKOpHudN+aB9zR
 KoljFxL3iPJKeCwFNPgPPWkhYVhNvh0muYrvndgITqkIHntUkL28T1rE/ZXG9H22LTq9dNDhG2o
 uQSylUNV6ir2D2lfvYS6Rrabz+u3fIki9djIQE7evB05ZHDZxvA6mTIBXbtjPviIMk4ROVCWG4o
 aKZcct8alNDEH9FWZ00itJnXWTClpoU1IhBC5zdpzT2aDw6WqkGPv2EsWOOwnJ
X-Received: by 2002:a05:600c:8b0a:b0:477:af8d:203a with SMTP id
 5b1f17b1804b1-482db49993bmr178249945e9.27.1770075980361; 
 Mon, 02 Feb 2026 15:46:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce70sm48893214f8f.27.2026.02.02.15.46.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 15:46:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/7] target/alpha: Do not use target_ulong for trap arguments
Date: Tue,  3 Feb 2026 00:45:46 +0100
Message-ID: <20260202234550.34156-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202234550.34156-1-philmd@linaro.org>
References: <20260202234550.34156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

%mmcsr and %cause are filled with @trap_arg1 / @trap_arg2,
both declared as uint64_t in target/alpha/cpu.h:

    229     uint64_t trap_arg1;
    230     uint64_t trap_arg2;
    ...

Use uint64_t instead of target_ulong.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 126a53c829b..2dc52cc4465 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -129,7 +129,7 @@ void alpha_cpu_record_sigsegv(CPUState *cs, vaddr address,
                               bool maperr, uintptr_t retaddr)
 {
     CPUAlphaState *env = cpu_env(cs);
-    target_ulong mmcsr, cause;
+    uint64_t mmcsr, cause;
 
     /* Assuming !maperr, infer the missing protection. */
     switch (access_type) {
-- 
2.52.0


