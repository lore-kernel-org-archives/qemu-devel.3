Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AABCCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6nc2-0005cQ-Va; Thu, 09 Oct 2025 06:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6nby-0005aq-NL
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:02 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6nbv-0007A8-CJ
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:02 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so9635455e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 03:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760004656; x=1760609456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/wiObWfXQJKQyBQgf5ArLjhzBOEGylIAwrrk4RMAGA=;
 b=ehE2GFzMXxwnctVaarbvh6OKfj5zvlqb2LTfky6iGmpEIJ+lS6eSiuNTM+BGEyBMtY
 irb/rZxAbeiN7HdSLl2cwSHBPq1tOwSQt8gCdOhExyUd/eqxPvuaBeB73q/7wHfbPoXX
 hVs9u/4gAT5y+3E+yNDWRLVt7gXVlvIYSld2dJBymW6Xe9ztcNo93xY1W3NVelIyrXqK
 u8g+vFSiO3hfuCmoz4kWFFnHn4JA03v7AYL3Ap4zNmXFuYXO8Yhmw8QrZ266M/GEufsV
 JxgulabmyKSAN5tO8JbkEcKGH7dpbnOWCJ4NQ0Xm3Bx16uLwvL3iPj6gZQ28Wg60q+Y4
 S6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760004656; x=1760609456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/wiObWfXQJKQyBQgf5ArLjhzBOEGylIAwrrk4RMAGA=;
 b=CusCwZxnEbG4oSMC5anvhjEaP8yJkLjGDr5UaiNPQX2KLPQKJMrOgU0TTnC+AmiAjS
 03Mx1v7UFpH0+YWRhYcMxN7rZw4KfIE6zJvwpe98M2cZOH+v9/va+qn0UcTcyPyi1s7v
 tVR9BspL5+8JErGcze6L51S8F6B0Tp1EL1qSNYe6m4xtUd767egVJd9IowiNm5Gfgy8Z
 pFmZKJFjHc8T5HjXkSNxLqLV69cFoPsCsjUNW4DCltgL5N96Nh9fUrhQKwVaVeDzj/fI
 SFSl2RHXrBRwFLajUQ+apDieYqGTAtn/pQyZV6D9WBlYbpvHpIB9uOBLZwU1r4EX0mb7
 cXuA==
X-Gm-Message-State: AOJu0Yw4UZREQSiX9JjOIMDO6RdiaZHQ5heszop6neROh/h8/HvtFHBz
 AGE/xHqt9un/NAWHmY57GcOHN3AZQYw1Fz5ZaoOy2muxpMYMkZLy9pNvVZJHSlRAAa9HlGMNx72
 4M8I2AzMAAg==
X-Gm-Gg: ASbGnct2nepWLU5ySWwcnNPifyfgV3fL3XoM5KG6J4bS2tfOqP9fpfM/+O7KDG0XuSV
 ZIe2x7O9JPaF+3zz6D+fMuxpsbJKv8PnemsHXIz+sd2mlAwblRC2LUM+lbD3qnQezTyViltme5M
 YXWUh/Oqrjrw3DcpKkg4wJf05pD7qBdQfemrdRbhzobrCDaTVmONlmurABi8wYowo50hvhhLZWk
 v3KgHVUvmBCIe/dN3aJlPxRzXF8bzwwlRijHYBvXDgtSt9Y+4t6KQxBKWMF4J4DEjAQvPMPaU6l
 8zuPJwNSFqXEC8TQD5USUvzrP4eD/zRhFzCk2H01J6yTgd9BJZiEJdrRbjP+v9tbBlFmVS4vXe9
 xS8EY49ifz2LQu6xHmp7NBrmjU7pQbTunt/QXdrVsYebHb634xpeqdjbWG4+qA0aE0g4gpN6xk7
 nRrMU7zZir2I2diITNkn7kArwJ
X-Google-Smtp-Source: AGHT+IG1Gmb6+h8ACY5WPSYvdJIMtyEQsuTkYVUzS+ytwJ4kp+guT5lCbHz78OkufUN3BjaZA+ZAfA==
X-Received: by 2002:a05:600c:3483:b0:46e:1b89:77e5 with SMTP id
 5b1f17b1804b1-46fa9a996cbmr47474425e9.12.1760004656118; 
 Thu, 09 Oct 2025 03:10:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf183b6dsm38370995e9.17.2025.10.09.03.10.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 03:10:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/9] target/hppa: Explode MO_TExx -> MO_TE | MO_xx
Date: Thu,  9 Oct 2025 12:10:33 +0200
Message-ID: <20251009101040.18378-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009101040.18378-1-philmd@linaro.org>
References: <20251009101040.18378-1-philmd@linaro.org>
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

Extract the implicit MO_TE definition in order to replace
it in a commits.

Mechanical change using:

  $ for n in UW UL UQ UO SW SL SQ; do \
      sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
           $(git grep -l MO_TE$n target/openrisc); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7a81cfcb887..859c6cf5f9b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1691,7 +1691,7 @@ static bool do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i32();
-    do_load_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TEUL);
+    do_load_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UL);
     save_frw_i32(rt, tmp);
 
     if (rt == 0) {
@@ -1716,7 +1716,7 @@ static bool do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-    do_load_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TEUQ);
+    do_load_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UQ);
     save_frd(rt, tmp);
 
     if (rt == 0) {
@@ -1750,7 +1750,7 @@ static bool do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_over(ctx);
 
     tmp = load_frw_i32(rt);
-    do_store_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TEUL);
+    do_store_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UL);
 
     return nullify_end(ctx);
 }
@@ -1770,7 +1770,7 @@ static bool do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_over(ctx);
 
     tmp = load_frd(rt);
-    do_store_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TEUQ);
+    do_store_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UQ);
 
     return nullify_end(ctx);
 }
-- 
2.51.0


