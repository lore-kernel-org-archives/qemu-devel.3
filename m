Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2C0CCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mwt-0003J5-1A; Thu, 16 Oct 2025 08:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MwP-0002Dl-6R
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:51 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MwI-0008S9-Cl
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:44 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so460470f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617111; x=1761221911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PMMYup3krEx+DcuFU9qSsd/AZ1KOJbHkK93jM3hrkaI=;
 b=lDR2uV54dzwiyLLPCKvV76Pq0HUt9BWcXIFI+LQG3w85p5GnHhrP4IzLL0TxTMscmp
 bAPFDj++mr/fstyukj/Qm3+HVPdHfTxsp0AsLxDo6yQEXQYtRsNSvXZVvaHqySmU1GMS
 F63zbKWZLgN2fc00qUrx22282kTI50ts5CYANZaqwZFTCi+O1l0x6SPvtdERWKzKDTuL
 2D6GdTAyLgw1iJB5wBXcYbkO1Wh1J7lDzBe4eKxratXRnIjJMuqFqUx1XQZDs9pPlXwk
 5cfBd9sQjA1i6CtODtS6AsWv/oT0XojI+MYlsxXIsLdykMBiyig9NYNu0E1RQM3Dt+bE
 wFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617111; x=1761221911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PMMYup3krEx+DcuFU9qSsd/AZ1KOJbHkK93jM3hrkaI=;
 b=wNPMdEvhg9/WDWBvxm2qX/xRazSvr4Zn+kpg8CtgFKciqh7/tjiWjyIb12q8oomjgA
 zO65f0rJuFOHX950t7jT4iabLDaNrOeR9p+2SDPDcO6zhFRvG8NvWrybZ56sbrvThFY0
 2T1btwPedyLG32GLwLhtzBLha4zILoKXxYONbaCYFbMmJjS9jVyIlas+QY/d6f+OcO8i
 yKwxzxBpVz+dJEJsDWY6nOPhCWVUh8K5ivO7T/kL/lxt09tD6IzzsE4yWDUm0yMg2AAb
 THYRbBv5yfaYvvsOswsIXtskcH8zU1slDoGD2+gngYMIuKte+GTfADUJuTLEr69CpcFH
 FAKg==
X-Gm-Message-State: AOJu0Yx+hHvofQH1lSMC8KrKsQikFWGjP5dBJGToqMA+WP60I/OpM3Ou
 lzroFcPx297lBGxgGIDdmFnY8PT3kt2gctgiL0H2McnUDKRS25rB32jzacmduoc7leSY1ONnczA
 XwT0XtrU=
X-Gm-Gg: ASbGncvHqjqWBS/jktD3aYzEO7hb0kG2ZlIsmXs5IC0+7N9fC1g+0uIDe2a+FRAZtgq
 JGdNOP7Bu16czENduVyZ4oricJpQN6Rx4hVAZpV7gJa5J9ehNJdJoutJbZFWG7ZnDc8taPvfBCn
 kC7ozkTiJK5kzEvPihfRRZII+ZZQhU0MZ9/3UHA9LxBXkFJ2KLVQjMAINFVYq8ncLq8GpRn5cCk
 W7NoAerFqg0UoHFpNmd06orEoKus17+dbDaGRpAQ3E7P8jkajcdUa1I8tkbH+aa+Gohkc/CE1PT
 ey03tGMlbKgiZyMQ+INONgEpSy0dYDgAk5iOLUKOO1SxFplpcW8J2cyoPD/cai84mwSK6r/V57j
 HFNHTApVCB9oDo57ogqXAKz9wWgBt0vRRRpevpV1HmAFnG2r5Sl4wTXS1KeJDOYqC5+ariJdr1n
 PFe7bqG8XYto+J8rH3pCFadY4ymxKAn+DGmRjjxho9j2aXO11yKt+u6bti6k1K/g/x
X-Google-Smtp-Source: AGHT+IGu6gVtGE19DEJ5DyzqPJNSnoRryrpq88OxpPGcQoCFNJKwP/klirSJPK1sxBm+hoTYiEnkxA==
X-Received: by 2002:a05:6000:43cc:20b0:426:f10c:c512 with SMTP id
 ffacd0b85a97d-426f10cc708mr5894570f8f.43.1760617110986; 
 Thu, 16 Oct 2025 05:18:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144239f4sm23778185e9.2.2025.10.16.05.18.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:18:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/75] target/openrisc: Inline tcg_gen_trunc_i64_tl()
Date: Thu, 16 Oct 2025 14:14:54 +0200
Message-ID: <20251016121532.14042-39-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

The OpenRISC targets are only built as 32-bit, so tcg_gen_trunc_i64_tl
expands to tcg_gen_extrl_i64_i32(). Use the latter to simplify the
next commit mechanical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010070702.51484-13-philmd@linaro.org>
---
 target/openrisc/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 3d9dfd663aa..beb4a546fd7 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -351,7 +351,7 @@ static void gen_macu(DisasContext *dc, TCGv srca, TCGv srcb)
     /* Note that overflow is only computed during addition stage.  */
     tcg_gen_add_i64(cpu_mac, cpu_mac, t1);
     tcg_gen_setcond_i64(TCG_COND_LTU, t1, cpu_mac, t1);
-    tcg_gen_trunc_i64_tl(cpu_sr_cy, t1);
+    tcg_gen_extrl_i64_i32(cpu_sr_cy, t1);
 
     gen_ove_cy(dc);
 }
@@ -392,7 +392,7 @@ static void gen_msbu(DisasContext *dc, TCGv srca, TCGv srcb)
     /* Note that overflow is only computed during subtraction stage.  */
     tcg_gen_setcond_i64(TCG_COND_LTU, t2, cpu_mac, t1);
     tcg_gen_sub_i64(cpu_mac, cpu_mac, t1);
-    tcg_gen_trunc_i64_tl(cpu_sr_cy, t2);
+    tcg_gen_extrl_i64_i32(cpu_sr_cy, t2);
 
     gen_ove_cy(dc);
 }
@@ -917,7 +917,7 @@ static bool trans_l_movhi(DisasContext *dc, arg_l_movhi *a)
 static bool trans_l_macrc(DisasContext *dc, arg_l_macrc *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_trunc_i64_tl(cpu_R(dc, a->d), cpu_mac);
+    tcg_gen_extrl_i64_i32(cpu_R(dc, a->d), cpu_mac);
     tcg_gen_movi_i64(cpu_mac, 0);
     return true;
 }
-- 
2.51.0


