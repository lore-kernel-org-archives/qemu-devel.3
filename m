Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88813E7FDEF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1fG-0006nk-Mm; Mon, 02 Feb 2026 16:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1fF-0006nU-2z
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:40:57 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1fC-0003Rm-BG
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:40:56 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so39996675e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770068452; x=1770673252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CmwtpnHdH00QO0txf+9VbhQ1oaCWpPbgxiSCRziiiqo=;
 b=vXjXei+UlCStEcIyjPHnPJTxnN32JhV/wcnCX6H364FusnLGDYOoX59gBUZk8u2Znr
 pOQddX5APeOFUKWHDJ7P+FYgFl45/hpy3HpOHGlCoWaSbvYILGgZ+8JzxwKuVp5AwJrV
 8ZTA/dbfCQKsBa3fbyBb3V49mzAgg3BzABng4n8udNtsxmnQAPoOkNDCPjiyl/3VszBr
 Cwd/2QMrnguzZnrpyrcfPU1vrcEJve9MWmF6PKEYno9CXdvpGINU24hWYIeEVXfB0HNo
 /L7lNBTZck5mpaMGsV6FX25dbdZDVitf4BQP1SjoHHodMMcse9GQ/RHQE9+pvCQLAeTZ
 YtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770068452; x=1770673252;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmwtpnHdH00QO0txf+9VbhQ1oaCWpPbgxiSCRziiiqo=;
 b=RqxyG9Ic5XMcbXEPNkVVCwKEyAsWm/lQ1xYqVR7UioUUq6V4szDGuuTbZe9I+G+qdP
 Gjsl4SmR++pY/KOEvknfnYo1PQnIXPO1KPznoTArVPBXdq8VXvX4lbUjni/FyFmSlTbo
 RdOI0to9u/1VAzAG8V7iLiHzeHom+xLvYE3y7HS5rsqPuGF4ypDNkI2+xLIrTHW8lOdF
 sEmhQHXE/hoGBgXtmOZR0vTkeKLxXYatWtnGNGlDenfvwnlwEqnWWZ1xpzZ8/WPpn5Av
 AwwjgmwnJlzk8ZB8STnoI4P7CnyKewjArEtp9XvmnFRClvwlr5Jrz2KboqhgSie1qpaL
 sQxw==
X-Gm-Message-State: AOJu0YzRG0x7EVQGtWgF2a9R1NTbhdkMBXwWyzza9UEnyguaJK8tXk0z
 pFlDIAQAZf4RYSMnBTrcXax40pxHHy7+CtPY7gzGSo/5fRvOhrG49dKW01n3zSliPE+rdhwHJAz
 8CjEipO8=
X-Gm-Gg: AZuq6aK4TE7Mt+SsG8T6iAL8Tz2pBGjTwT/QERdaez1s7o+uHD8Ubcs3GETUs7FSuO5
 8yvE4YNDOkNiMnWELIQ+O9OLV5J+QBwMNB7psgogW4DI/FlAP+C5lGwwA5ykYtRx9ID/TsqecVQ
 Kbwb8PV0Vo28yg4h6z35VwY3uEXvkg5JREFJ5N1/12n23OcORcfM1Y9LgpM0GNz8YzDiIJ+xRPA
 qCiIRKAXqbiqNJuUkY3LzMTyrSlYWVSuwOJxqQg03H7x2NNG+a5zfweNkeTu0zd03/J5HsG8QR+
 PW2SaCLh9/8lIIra5pBgvUiCU2rfzw3/h37hzm4vhvb8/AoNRbNy84RZZO28alnUgu24LjLzdev
 +PmZtOWbp1+rcSMmo5sj9oOrFSQEY3ejDy+6CDb1rnUqrSX5LB65LEY4TvfrTr/hjXX6/TBNIYH
 KY69Ca7f13e98Z63bLSZ0L+gtxUxya3npJqRMGW7CVOFc3CB1qDucLynnwmgpm
X-Received: by 2002:a05:600c:c4a3:b0:47d:885d:d2ff with SMTP id
 5b1f17b1804b1-482db49aa80mr181144405e9.29.1770068452410; 
 Mon, 02 Feb 2026 13:40:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e132303fsm47190954f8f.36.2026.02.02.13.40.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:40:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/m68k: Inline translator_ld[uw,l,q]() calls
Date: Mon,  2 Feb 2026 22:40:50 +0100
Message-ID: <20260202214050.98935-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

In preparation of removing the translator_ld[uw,l,q]() methods,
inline them for the m68k target, expanding MO_TE -> MO_BE since
this architecture is only available in big endianness.

Mechanical change using the following Coccinelle 'spatch' script:

    @@
    expression env, db, pc, do_swap;
    @@
    (
    - translator_lduw(env, db, pc)
    + translator_lduw_end(env, db, pc, MO_BE)
    |
    - translator_ldl(env, db, pc)
    + translator_ldl_end(env, db, pc, MO_BE)
    |
    - translator_ldq(env, db, pc)
    + translator_ldq_end(env, db, pc, MO_BE)
    )

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 721668634d9..a0309939012 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -347,7 +347,7 @@ static TCGv gen_ldst(DisasContext *s, int opsize, TCGv addr, TCGv val,
 static inline uint16_t read_im16(CPUM68KState *env, DisasContext *s)
 {
     uint16_t im;
-    im = translator_lduw(env, &s->base, s->pc);
+    im = translator_lduw_end(env, &s->base, s->pc, MO_BE);
     s->pc += 2;
     return im;
 }
@@ -1412,12 +1412,12 @@ static bool semihosting_test(DisasContext *s)
     if (s->pc % 4 != 0) {
         return false;
     }
-    test = translator_lduw(s->env, &s->base, s->pc - 4);
+    test = translator_lduw_end(s->env, &s->base, s->pc - 4, MO_BE);
     if (test != 0x4e71) {
         return false;
     }
     /* "... and followed by an invalid sentinel instruction movec %sp,0." */
-    test = translator_ldl(s->env, &s->base, s->pc);
+    test = translator_ldl_end(s->env, &s->base, s->pc, MO_BE);
     if (test != 0x4e7bf000) {
         return false;
     }
-- 
2.52.0


