Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D376D3B98D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvS1-00015z-Lm; Tue, 26 Nov 2024 08:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQt-00005t-2R
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:48 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQq-0003iT-CL
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:46 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434a752140eso4727455e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732627002; x=1733231802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHGO/TiW0qdojQl+y3dtK5J0HIxG+MvCfdjbdAdzhXA=;
 b=zJW7zyMLymHpLARWAtYGlS3MAPfCwkktzBbp1t7ciIQBFi613gqHREVbOyHd/1xiul
 eYsCFS4J0OtCB9iOVootQ4EtEibS6uTy2LuxMYH5GeTtBd7qY+z6rwkHP13WSDeZXVZk
 moqxH3/TC0n1m2AaZES8iV3EIksTFQ6SSRpvF41gHMkzjiKDbN6c9m8WpGeqjcKOW8nV
 0MF+69yu9zZwb/NhqHANn32YYA2oaRyYbEpaleW6sVGZzaAZOW8GE8z6PnzD0Nelen2w
 ey1bCOlSNdEks303bGfGxKRDduay0Pcdgy3+OZZZbutu6IK8o866yUYELTbaU1vtSKmU
 uWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732627002; x=1733231802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KHGO/TiW0qdojQl+y3dtK5J0HIxG+MvCfdjbdAdzhXA=;
 b=oiO2HP3twlvnpo87Tc9JjhcnFs5YjsBS7jbpwm4NUc0Lk2rQA0KsOKlgSmxMO1ShGp
 xMK30EOIGwlegdvqtziN33L1kHoJzYY9s600yEI/R5DPITFeIaOu1DnKAjXfcSQavi7d
 2VwMnqktMPpq2TOcA3olpYEi2oql+1vp84CNNza2OXFDzlbp0zbGb2qbk4HLtSHfIO2t
 0RZRNjY2blHyHo9sWP8nFizRTjbpbKgNhHuGUQJ2wamoAwH5rB9VxNMZpM8yj672jmeu
 lvuY4QZIny4wOO1JqVahOPCtfB2UDbobDGqc67ot6Sw1oW1BjNw7zZ1L5eulH0TyGyjd
 0png==
X-Gm-Message-State: AOJu0Ywra8BSUO5FlpaBLOTrlSo7Q4EjEDVIflgSLxlIQdPsjziOHgEt
 IFdu+6sh3BecUXwDx7tndjZGLv3fCUvsOglS19V3WKrhsg5CpAR+dRoeq9WNhqZZKdaa9tfL3zq
 x
X-Gm-Gg: ASbGncs/GU8ywZ8hi52MabhiYY2FHKz4r4JhMo+4qW8lTMTQiGg7UsRvrkOIYNc0ocz
 31HX4TXcFbX0Yv8aqZ60xVgOzJx/GcFlPp2vaCTy7DnmmODyHQwTpUbC4m2I8j2UOL5SQYGFb/M
 C9mBhAPJITkB7FJuUSCz0Kn7owpbevmZaBPEw96tUGjb/6jt0tGeGwxBxKfKffXgvdrfht1ipSb
 SH1SPsat10eizQoqJ/CtrzJP5ctHME8AOaKUjsS1x1wNkLRa/lIF4YeJQMarWgesME1hcCf
X-Google-Smtp-Source: AGHT+IF4Ko5bnpfAcsXVkqH09n90r9PIw4BcSGAKiwX1mqW57x8FXH2BEjIY8y1YpDztE9Ncf8ITfw==
X-Received: by 2002:a5d:5f86:0:b0:381:f5c2:df24 with SMTP id
 ffacd0b85a97d-38260bf39a6mr12510615f8f.57.1732627002466; 
 Tue, 26 Nov 2024 05:16:42 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad6270sm13216274f8f.14.2024.11.26.05.16.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 05:16:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 09/13] target/mips: Introduce gen_move_low32_i32()
Date: Tue, 26 Nov 2024 14:15:41 +0100
Message-ID: <20241126131546.66145-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126131546.66145-1-philmd@linaro.org>
References: <20241126131546.66145-1-philmd@linaro.org>
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

Similarly to the gen_move_low32_tl() helper which sign-extract
the 32-lower bits of a target-wide TCG register, add a helper
to sign-extract from 32-bit TCG register.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h | 1 +
 target/mips/tcg/translate.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index d9faa82ff70..d5d74faad92 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -154,6 +154,7 @@ void check_cop1x(DisasContext *ctx);
 
 void gen_base_offset_addr_tl(DisasContext *ctx, TCGv addr, int base, int offset);
 void gen_move_low32_tl(TCGv ret, TCGv_i64 arg);
+void gen_move_low32_i32(TCGv_i32 ret, TCGv_i64 arg);
 void gen_move_high32_tl(TCGv ret, TCGv_i64 arg);
 void gen_load_gpr_tl(TCGv t, int reg);
 void gen_load_gpr_i32(TCGv_i32 t, int reg);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 6ac0734d1b2..80e2a8e5256 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1479,6 +1479,11 @@ void gen_move_low32_tl(TCGv ret, TCGv_i64 arg)
 #endif
 }
 
+void gen_move_low32_i32(TCGv_i32 ret, TCGv_i64 arg)
+{
+    tcg_gen_extrl_i64_i32(ret, arg);
+}
+
 /* Sign-extract the high 32-bits to a target_long.  */
 void gen_move_high32_tl(TCGv ret, TCGv_i64 arg)
 {
-- 
2.45.2


