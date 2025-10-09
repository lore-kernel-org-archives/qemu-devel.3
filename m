Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93390CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 08:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lry-0004l2-9C; Thu, 09 Oct 2025 04:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lrw-0004dW-65
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lrt-00086i-KJ
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:23 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e4473d7f6so3916715e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 01:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759997959; x=1760602759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bMijNpkW9Cbxoe8EeCnNCW3yaWU/MfuirlwyBX6LmoQ=;
 b=zM05X64xvviIjjQYtd/MP1a8HVxislvwfeFkpVn/lOPWPKdRFYJQ1ubcL+ik0m3DND
 edlgazKLUjdQqVwqQVUoVGmFMYk4mnIyhz1yROg+tMfxzoFxXQyQD3Uwofo9rT8otSyb
 FMcYnA997XFLQ/fPvMGQ7FDGSr0HfjCnxMqG1QDDgEGxOs2vN9iYlC81GuErHW52tFoo
 QD0biav71aMq34/QlsYKi2dhW7gEAy6VPsiycEoZxqDuKzRkNGPGtlB+VVrddXgeMg7j
 DQPtmpVekhH5ZARniJ7nw9fHeszhwSTVLjM5gvBBIXOZzNRgBNFG+Dq9H9rtUv6YQeYN
 UTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759997959; x=1760602759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bMijNpkW9Cbxoe8EeCnNCW3yaWU/MfuirlwyBX6LmoQ=;
 b=ZcOiVGgvszuxNxq28fyXcO0ICHv475Zn4HuUHe5eA+OlqHv8xWC6dlmj5EDizB4nCY
 +SLq+8pysmZTxTJ//KdPQ3G0dTIk01m8a/SP0/le6GMDmx9VI5YBUjkbrnXA5qDa0hMv
 QUvouwvWcPXg/ik+NCIIYep6h7Jy/o0tltVZFCsSfOXsZYokxHknPqNS9fg1x+mcO7Uw
 IH4SLVmlAWGZpobTENyHmADeXx+3PuugdpQ2kdKqgwZLio9gikiUiwrxhegfF2G1jhZK
 TAwkGTD0W2lfyCHZxt+Sjp3zSRCgDU2RuHce1sfOedtYPYuwiJDK2+VG3sdK0zlFMjOt
 Wbiw==
X-Gm-Message-State: AOJu0Yw/T4GUO9mScFnTk1IVCwv+SzNVbTq66kkhJaOpfXriS0EMrNN2
 ouuAyevEF+HFsF6d/13JKYL1j4of0BpcgEJ32NQMl5UsoPkU5efhpgM6rOfIgmH02ogz7Tm1/9I
 sEmYJp9tt9A==
X-Gm-Gg: ASbGncuLu2c5q53Cog4AoWHzwSvUk4yLiFir2/q6wxNNjwL821a4jH2PvC3eR92Hd2s
 etmi4WgWere0LaEy7Zt0DXu/+NyQSaxIL60RI5vt1O5ZqM+gCUQhULNleKguZ2G5VG6zUwQ1emQ
 /cXNc6PSNGLxjuwRhXb1zo1tfFbsyALUoCij5/mODV/Jjmn2Y68Zbi5fy5TIHfTBcPeCYqzGxEP
 zj5syEnB+Qf4egk0FrKqQzRS1o0UsnaB/6IbX/50i6ions6z3BvpLO8WzEf1jAi/VvdeSn3CGJf
 1glmREpjx4sLVSYgHSOgyQaj5M1lecDut9fUh3fCLUkGHLqWJ+2q9eLnVgdo5bbMB4kDRjjCxpt
 9U3KioilMJ3JallZfq4SB4zALgLd6LogVt6FUZjZzHMqDqLaojlZvx74hYlYKb13l38Ea6HCcS9
 FOkCia/RDck4Zu8RPbTTRIH2YX
X-Google-Smtp-Source: AGHT+IHBz8E7foyG/BgE2ldTW+Iol0hGquJn6s5xTF9dnLse86vx9bHXm7ynGs66i0yOHLt5oFMjPA==
X-Received: by 2002:a05:6000:604:b0:424:2275:63b4 with SMTP id
 ffacd0b85a97d-4266e8e4cd7mr4335841f8f.61.1759997959215; 
 Thu, 09 Oct 2025 01:19:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d6fb41sm71836505e9.17.2025.10.09.01.19.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 01:19:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/10] target/openrisc: Replace MO_TE -> MO_BE
Date: Thu,  9 Oct 2025 10:18:55 +0200
Message-ID: <20251009081903.13426-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009081903.13426-1-philmd@linaro.org>
References: <20251009081903.13426-1-philmd@linaro.org>
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

We only build the OpenRISC targets using big endianness order:

  $ git grep TARGET_BIG_ENDIAN configs/targets/or1k-*
  configs/targets/or1k-linux-user.mak:2:TARGET_BIG_ENDIAN=y
  configs/targets/or1k-softmmu.mak:2:TARGET_BIG_ENDIAN=y

Therefore the MO_TE definition always expands to MO_BE. Use the
latter to simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index df0ebcd3138..4ece2547614 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -647,7 +647,7 @@ static bool trans_l_lwa(DisasContext *dc, arg_load *a)
     check_r0_write(dc, a->d);
     ea = tcg_temp_new();
     tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
-    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TE | MO_UL);
+    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_BE | MO_UL);
     tcg_gen_mov_tl(cpu_lock_addr, ea);
     tcg_gen_mov_tl(cpu_lock_value, cpu_R(dc, a->d));
     return true;
@@ -665,13 +665,13 @@ static void do_load(DisasContext *dc, arg_load *a, MemOp mop)
 
 static bool trans_l_lwz(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TE | MO_UL);
+    do_load(dc, a, MO_BE | MO_UL);
     return true;
 }
 
 static bool trans_l_lws(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TE | MO_SL);
+    do_load(dc, a, MO_BE | MO_SL);
     return true;
 }
 
@@ -689,13 +689,13 @@ static bool trans_l_lbs(DisasContext *dc, arg_load *a)
 
 static bool trans_l_lhz(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TE | MO_UW);
+    do_load(dc, a, MO_BE | MO_UW);
     return true;
 }
 
 static bool trans_l_lhs(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TE | MO_SW);
+    do_load(dc, a, MO_BE | MO_SW);
     return true;
 }
 
@@ -713,7 +713,7 @@ static bool trans_l_swa(DisasContext *dc, arg_store *a)
 
     val = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(val, cpu_lock_addr, cpu_lock_value,
-                              cpu_R(dc, a->b), dc->mem_idx, MO_TE | MO_UL);
+                              cpu_R(dc, a->b), dc->mem_idx, MO_BE | MO_UL);
     tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, val, cpu_lock_value);
 
     tcg_gen_br(lab_done);
@@ -735,7 +735,7 @@ static void do_store(DisasContext *dc, arg_store *a, MemOp mop)
 
 static bool trans_l_sw(DisasContext *dc, arg_store *a)
 {
-    do_store(dc, a, MO_TE | MO_UL);
+    do_store(dc, a, MO_BE | MO_UL);
     return true;
 }
 
@@ -747,7 +747,7 @@ static bool trans_l_sb(DisasContext *dc, arg_store *a)
 
 static bool trans_l_sh(DisasContext *dc, arg_store *a)
 {
-    do_store(dc, a, MO_TE | MO_UW);
+    do_store(dc, a, MO_BE | MO_UW);
     return true;
 }
 
-- 
2.51.0


