Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DC2CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6sNk-000149-68; Thu, 09 Oct 2025 11:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNd-00013k-Ma
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:33 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNX-00013H-Sq
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:33 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso5978065e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 08:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760022984; x=1760627784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMpGbvMM36NwbK8kSwDRJa9hCDWv5SxuYSTE3Zgo8Kw=;
 b=Argcqoc+I5saxD7fbpbC5e+m6lfod/qRNHoBVMtAWlU80PmJAohLhlMTuZvAy+Iqdh
 037QhANVhv1bXpswhDIo2B0jGm9P6A5I5usQlNZ7jTkLCLIOqiJJAx/Qbo/GGgo4NUWY
 ejyPP1d/I0z58GBREjlUBFRmfonCP7RlBJ/RuyUKfIHv6vp9EAhANd6JqJxaFb0j/rrC
 QGGX6oO7ZaIMaZp9ZBCctgnkNa+ZhaFJcV+bVA8WJxLpnqK9OtXErF4lnD0UVa8qJVPE
 vcLpgyj8ye6eBy9GkjMBgK+oYkl6mgOkvsO9YODOp1EvOk6ZUMXtFwjqqLsOyCz3V6LY
 /75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760022984; x=1760627784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMpGbvMM36NwbK8kSwDRJa9hCDWv5SxuYSTE3Zgo8Kw=;
 b=n50HnIJ3n908vKGJ/g/1fifNkncOir/95FhDy3tQhUjN/k3HEyDM23ZxwmC9aCOQQQ
 gpLskrEnFQS7ut30EsO+mPH4A7uiKjxFCKLzCsfIkt+tCwiCH41a2AQZRBXz9siEsZAN
 9RpOED0+m2B3zseXeCuR7r7q54+9lagLv2oZeEPDh2l5xlY1BIg8SX6otVcs3YLKEK4E
 Gi+gvG8/b6KdgBUyFJoGknesXHJx9HXHes1o3FNmr2n6a4H4pAtRopfG3C6fsN1Wq/nS
 7sDETrjtBJgLDrB4oUZQSII8cuhbU27rQLG6eHC6EfVgv0i9nYy78lA2kkmkK+pOd7cP
 q6nw==
X-Gm-Message-State: AOJu0Yzo0zEU1+GMkLrNffhEB3R1luGnL8rmWT2Drg8xcK+nUX7lxBgJ
 Fc+EuupHoybq4kkGng4E8h39jjnqkwFQafxrxjHlI5afvwki0g0X6+JzRlSQ/FIgtjog0eVQ/tL
 Ai+ruq7dEpQ==
X-Gm-Gg: ASbGncsZ224QPL5f8INWIiVPIVyQ/EdAAN25szcOdL5tBYznvR+e6p3xGAqLwAMO/UL
 /ujCIcBXygZjaEC+lr9qTnoHY6ALmmi2INgGqeYOTIZNYtptBnrxkkhjLVEhH2bZTdref+VrQyk
 cagEd+at558qq/IhwqQKhyW4ykWVElrunGxUvQBq4Bpsqdfv8qYlrnwWL9lZ6goFe7HPfiTn8rG
 g/kuRe0lESRFpk3nC8T66oPmVz6ob3JshCcgsmYTmfPCbh0PQNx4xpuSsCRHlqFnS4SOhrkK+zS
 TkzRt1PYIHHUx2NsfZU6sOByv8qp8L3sa7gYYGeZkeZcS82bNZ1Eh7MDWXLCMQelvN9yZ/LoyoA
 QVLR9g1ZBbPW16bBXwgg+CnZmjEK64UBesKC6buSk4WaYL+CtLy3joizdFjPw+4+nCFU5gVErER
 boCW74vFWrRwzmvOUwObclv0zs
X-Google-Smtp-Source: AGHT+IFrF8Ys39cN7ryQOKgOhvo/64zvhrKfa6ZlXivQPcmw5gtpBsaHmaJB2byPzXU1TcRfD0so5Q==
X-Received: by 2002:a05:600c:1d11:b0:46e:5aca:3d26 with SMTP id
 5b1f17b1804b1-46fa9aef840mr54991795e9.22.1760022984042; 
 Thu, 09 Oct 2025 08:16:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f01a0sm34971162f8f.48.2025.10.09.08.16.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 08:16:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/8] target/rx: Propagate DisasContext to generated helpers
Date: Thu,  9 Oct 2025 17:16:02 +0200
Message-ID: <20251009151607.26278-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009151607.26278-1-philmd@linaro.org>
References: <20251009151607.26278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/translate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 9a2be2107bd..f02a8cc5dc9 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -1894,7 +1894,7 @@ static bool trans_ITOF(DisasContext *ctx, arg_ITOF * a)
     return true;
 }
 
-static void rx_bsetm(TCGv mem, TCGv mask)
+static void rx_bsetm(DisasContext *ctx, TCGv mem, TCGv mask)
 {
     TCGv val;
     val = tcg_temp_new();
@@ -1903,7 +1903,7 @@ static void rx_bsetm(TCGv mem, TCGv mask)
     rx_gen_st(MO_8, val, mem);
 }
 
-static void rx_bclrm(TCGv mem, TCGv mask)
+static void rx_bclrm(DisasContext *ctx, TCGv mem, TCGv mask)
 {
     TCGv val;
     val = tcg_temp_new();
@@ -1912,7 +1912,7 @@ static void rx_bclrm(TCGv mem, TCGv mask)
     rx_gen_st(MO_8, val, mem);
 }
 
-static void rx_btstm(TCGv mem, TCGv mask)
+static void rx_btstm(DisasContext *ctx, TCGv mem, TCGv mask)
 {
     TCGv val;
     val = tcg_temp_new();
@@ -1922,7 +1922,7 @@ static void rx_btstm(TCGv mem, TCGv mask)
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_c);
 }
 
-static void rx_bnotm(TCGv mem, TCGv mask)
+static void rx_bnotm(DisasContext *ctx, TCGv mem, TCGv mask)
 {
     TCGv val;
     val = tcg_temp_new();
@@ -1931,17 +1931,17 @@ static void rx_bnotm(TCGv mem, TCGv mask)
     rx_gen_st(MO_8, val, mem);
 }
 
-static void rx_bsetr(TCGv reg, TCGv mask)
+static void rx_bsetr(DisasContext *ctx, TCGv reg, TCGv mask)
 {
     tcg_gen_or_i32(reg, reg, mask);
 }
 
-static void rx_bclrr(TCGv reg, TCGv mask)
+static void rx_bclrr(DisasContext *ctx, TCGv reg, TCGv mask)
 {
     tcg_gen_andc_i32(reg, reg, mask);
 }
 
-static inline void rx_btstr(TCGv reg, TCGv mask)
+static inline void rx_btstr(DisasContext *ctx, TCGv reg, TCGv mask)
 {
     TCGv t0;
     t0 = tcg_temp_new();
@@ -1950,7 +1950,7 @@ static inline void rx_btstr(TCGv reg, TCGv mask)
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_c);
 }
 
-static inline void rx_bnotr(TCGv reg, TCGv mask)
+static inline void rx_bnotr(DisasContext *ctx, TCGv reg, TCGv mask)
 {
     tcg_gen_xor_i32(reg, reg, mask);
 }
@@ -1963,7 +1963,7 @@ static inline void rx_bnotr(TCGv reg, TCGv mask)
         mem = tcg_temp_new();                                           \
         mask = tcg_constant_i32(1 << a->imm);                           \
         addr = rx_index_addr(ctx, mem, a->ld, MO_8, a->rs);             \
-        cat3(rx_, op, m)(addr, mask);                                   \
+        cat3(rx_, op, m)(ctx, addr, mask);                              \
         return true;                                                    \
     }                                                                   \
     static bool cat3(trans_, name, _ir)(DisasContext *ctx,              \
@@ -1971,7 +1971,7 @@ static inline void rx_bnotr(TCGv reg, TCGv mask)
     {                                                                   \
         TCGv mask;                                                      \
         mask = tcg_constant_i32(1 << a->imm);                           \
-        cat3(rx_, op, r)(cpu_regs[a->rd], mask);                        \
+        cat3(rx_, op, r)(ctx, cpu_regs[a->rd], mask);                   \
         return true;                                                    \
     }                                                                   \
     static bool cat3(trans_, name, _rr)(DisasContext *ctx,              \
@@ -1982,7 +1982,7 @@ static inline void rx_bnotr(TCGv reg, TCGv mask)
         b = tcg_temp_new();                                             \
         tcg_gen_andi_i32(b, cpu_regs[a->rs], 31);                       \
         tcg_gen_shl_i32(mask, tcg_constant_i32(1), b);                  \
-        cat3(rx_, op, r)(cpu_regs[a->rd], mask);                        \
+        cat3(rx_, op, r)(ctx, cpu_regs[a->rd], mask);                   \
         return true;                                                    \
     }                                                                   \
     static bool cat3(trans_, name, _rm)(DisasContext *ctx,              \
@@ -1995,7 +1995,7 @@ static inline void rx_bnotr(TCGv reg, TCGv mask)
         tcg_gen_shl_i32(mask, tcg_constant_i32(1), b);                  \
         mem = tcg_temp_new();                                           \
         addr = rx_index_addr(ctx, mem, a->ld, MO_8, a->rs);             \
-        cat3(rx_, op, m)(addr, mask);                                   \
+        cat3(rx_, op, m)(ctx, addr, mask);                              \
         return true;                                                    \
     }
 
-- 
2.51.0


