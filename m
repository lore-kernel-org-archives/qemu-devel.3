Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAE0CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 07:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v77Ej-00028x-1v; Fri, 10 Oct 2025 03:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77Eb-00021u-Ey
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:08:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77EU-000818-3W
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:08:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso9515705e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 00:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760080081; x=1760684881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vS8HXyJHSXQcuzNI3sZRrJF0hK2dW0GVHTdSkTtKx4=;
 b=HR/vUm5xrryMFm0Tyg2MzrxyB14SKiVNilydm5c9EzTiecwwsRtDHmPbmNwkdVIKX7
 Tb8rwpP7l+nYHnXCk5fWa+/WAn6aHn6Yqe57p6FSycrgrERTFW+YUtpubN/PI9CFmGVD
 Znt1eMSSFOt2tpWArzmiTOJx1E3c1z4M6zbXwia8sc/6N1Jck0wvyQmeohIIeCTkOyXC
 DVkHR0cbuddeEUtlV3tsIBKUaTAHhNYm46wgsykbozZbEzeA2RXJktOGX1Fhzwe+QjR0
 /wmxUtaQdLL+2FK/zxMmYK0M5mqHMMl8O13vaZZt2VbRfceIDp+e14FqDLM7NKCPKbhb
 Rk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760080081; x=1760684881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0vS8HXyJHSXQcuzNI3sZRrJF0hK2dW0GVHTdSkTtKx4=;
 b=RcLfeBMnIL8pWeFM1c9KUIrfGDLTfbLgONbeMJRzaWsajoLYlcxdQqEDBMNWF2A2tc
 O7Tabx202wCWuKI6tDSWNAXmdh9lYzIkopJd6skib2sYHW4pGAe/d2rqKRl9bAxHHLfZ
 WQ8xbbewdCOGlqZSJXHtbIoVSN656fg1ZxJGoRrqpxv48U/VXBDQg4d8K1Y7xLFEn2+7
 DnydCq1jyti7WtYmEJ26yVW4pgrg/1LOkHi7EmSKgEIWq+pylprVJUEnw7r7nY3CJRjh
 QtlukD1ToxJvdFMvufGhwQRdti1ye7HZO6gcPBomND/GQrL50ekUZE8dfvSQYUU0ujRU
 PNSw==
X-Gm-Message-State: AOJu0YwsjAuBJrDOkB55f/DF4b41SRzrLE91LwYZbN9XNTBcyiEJem1r
 5FZBwrIUCVNwpR5QZSVNJajCsODc1kIXuHM5zhEA+gLXrkPhKEoDJLdl4tJHZs39SDmyo9YESCx
 sWxDIO+/lpw==
X-Gm-Gg: ASbGnctCw44BDy+bNCz69mo6UVFTbA39P5Ql6OOT42BqvHZpak57znkT18wXwVTzjkJ
 S4kWuQf4opx11k7eiPCqnFjdGGRKgSTC6Cwxqquw5dx1FHCoIFZtRDKVpvyGas5I9fGzk2wHlx8
 Iz1fxETM6CobFBoSDRYU0O8pbk3r5i8VgWot3dbWtydCit2CFRPWkKic7SfomkR85X7jCph16G9
 qp5rXD81BQHmY+rQpcytn7klD9syo1JytjYxMUaSoKALi9u0HCLhz754+kP6enXwM4h0Kj4fhKH
 c+79BlkORC12urmVaS9k0dCjLRJT6VlCAVCk132TNC2Zgzc+iH6BVksJmkcrIty5fEETyQlamRN
 FOadf/yWm6Jw2+2bggIk4wGKndOGx/mm6wkr/QfmNJly9glSOmde6/n6FC+UzZRebEk/jJ91SWV
 x9oi1JyhamXzLhtca6gJukvn8rFFoPTv1mD+k=
X-Google-Smtp-Source: AGHT+IHh9Jae/GALYkz3uEeop2ryJe5kfy2ItFJ1GYEW7ptDpY1JX1MWXx+hk4kg5mtNbpfVjjB/pg==
X-Received: by 2002:a05:600c:1395:b0:46e:27fb:17f0 with SMTP id
 5b1f17b1804b1-46fa9aa204cmr71881635e9.9.1760080081038; 
 Fri, 10 Oct 2025 00:08:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482b99fsm33623005e9.3.2025.10.10.00.08.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 00:08:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 12/13] target/openrisc: Inline tcg_gen_trunc_i64_tl()
Date: Fri, 10 Oct 2025 09:07:00 +0200
Message-ID: <20251010070702.51484-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010070702.51484-1-philmd@linaro.org>
References: <20251010070702.51484-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
---
 target/openrisc/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index a626ffaf25b..f33b9632d67 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -350,7 +350,7 @@ static void gen_macu(DisasContext *dc, TCGv srca, TCGv srcb)
     /* Note that overflow is only computed during addition stage.  */
     tcg_gen_add_i64(cpu_mac, cpu_mac, t1);
     tcg_gen_setcond_i64(TCG_COND_LTU, t1, cpu_mac, t1);
-    tcg_gen_trunc_i64_tl(cpu_sr_cy, t1);
+    tcg_gen_extrl_i64_i32(cpu_sr_cy, t1);
 
     gen_ove_cy(dc);
 }
@@ -391,7 +391,7 @@ static void gen_msbu(DisasContext *dc, TCGv srca, TCGv srcb)
     /* Note that overflow is only computed during subtraction stage.  */
     tcg_gen_setcond_i64(TCG_COND_LTU, t2, cpu_mac, t1);
     tcg_gen_sub_i64(cpu_mac, cpu_mac, t1);
-    tcg_gen_trunc_i64_tl(cpu_sr_cy, t2);
+    tcg_gen_extrl_i64_i32(cpu_sr_cy, t2);
 
     gen_ove_cy(dc);
 }
@@ -914,7 +914,7 @@ static bool trans_l_movhi(DisasContext *dc, arg_l_movhi *a)
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


