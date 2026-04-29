Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F5BFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwr8-0001DU-VV; Wed, 29 Apr 2026 00:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwr6-0001CT-Ot
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:00 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwr4-0008KP-Bg
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:00 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so74150895ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438137; x=1778042937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JuREkh5J91b+6stvcbVPwJjRjRION1tVvSChwlaKA7c=;
 b=qkegiynvMoTzzmOb/YN28GIhhlfqY+FBTOyaFrPcit8RMrzlMztWpNVqFWRmg8AFf4
 xI8zGRcsI6EFLjbus4kEgrTtRV473GUXnUymJddHogFM4V/gn+WOU283ORFVi7T9ATDc
 SIh5Hr2tcmVjLlUoKh3fOx3oGxlG15GiDSNPvIz1eOxvC8Yak+RQKrzuK8AX/tc/F9vD
 I3jMgTbSMst/1CjA3RYD1+Tzk0hYRR6DDzX4ZwDeUxTDrhngiZimUDfFayKBpbad2YRp
 WNXkYodyOTkX0v/9Xo8+1Tk+0EQLuqsmia5wlER7cLJKFG6Qd1gplSWvMPE9wWJrHA7B
 FcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438137; x=1778042937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JuREkh5J91b+6stvcbVPwJjRjRION1tVvSChwlaKA7c=;
 b=XoSIXTG5f8GpCZDst/lChqrHI7dmQ2u1U7qW4EihRnQPYIyIBCK2EfYZfOPZ8HW8pL
 P/wAYIsh9rfXkDIwAW18lP+xvfVeI6TTDXAvMPuhdzrATN+lShhj+ImG7SVhhRS2Itwq
 p/JNOY+enLBcnSXaFAQ1Yz6SkxSgbwa+MOg6hq3SCnssHg/EhI6KzgPjiZS9/GXMsbaZ
 VFIfjVZpbzmV/TgMxpBRZsMamipT31uNr8EKZXwnjvTJDKsogPHe1g86l0JKGu1NxG7B
 p8M87MMPbqF21Z3uqYdI8T/GXWVLXoisGYfaYaj4c5kJWfZhzejlzUdqs40K55V4TjMC
 WLqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ku+6UuQvvkrzL9foVLszO/ICiWkWrtVCEH3Evsd6iq6eMFjN/JhFQFFdb/HL6u01J+WXwycoIzr5W@nongnu.org
X-Gm-Message-State: AOJu0YyOQJ/X9TxWBDnClAT8jVixIdpkXS0G4BECV2qjQdoPzA+d0Opy
 CQb05zYyX1Asnz8li4OuO+BW/CZIEE4xwKPLVv9AdsSfoddxQ9K9mqHx
X-Gm-Gg: AeBDiet+cVRTveKFGZoDmbqkjY3nN3O+csYrU9QoPLS7y8EFKSh8+VpE2qu0rVRSZhq
 1/yx9P8ByFZ8Cb8T+/h547j5rC+rl3JrH8yqv5w/LhrwcONTRj9G2YhrUslWgZlx2eGWXlGDlXN
 I0q35xWutbCKWl9pLUI6Jt6F8ggWEYhjWkZbGJaKhisW76vJcU8rvxWT2U8FU+OpeNWyI8L8c/A
 qa6b4/QgaX6jG2IH2ULV8qaz/7kqau355jn+zBf6a/gdhcQ1lnBYOkij57OHP7R2b7Tfm73JpeJ
 7Ajpi2f6ACj1Fq7YM7IME/p6TSIXei0IoKqXfgBsVowxIuWD9vq7sHcXFszkqtHtqx6ek9PWDT7
 YmUptqfuUHvWdOWicMsw1uEWr5bO1qPl3Lz7uK67UbKPp743Lqk/yR0sn3DfUrB7/ic42E+SZnU
 WTmqC8h3sDr2dSp1YiDyCuv1/iOLBPHmJh6tXM8TybvNbjpo2DgHcy9V8AEyQ09zo=
X-Received: by 2002:a17:903:1b07:b0:2b4:5c20:ec7 with SMTP id
 d9443c01a7336-2b97c4ca086mr56632805ad.41.1777438136978; 
 Tue, 28 Apr 2026 21:48:56 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:48:56 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/51] target/riscv: Conceal MO_ALIGN|MO_TE within load_acquire
 / store_release
Date: Wed, 29 Apr 2026 14:47:10 +1000
Message-ID: <20260429044752.4176397-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

All callers of gen_load_acquire() and gen_store_release() set both
the MO_ALIGN|MO_TE flags. Set them once in each callee.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318103122.97244-7-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvzalasr.c.inc | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/insn_trans/trans_rvzalasr.c.inc
index 525f01ca34..2b1f73f650 100644
--- a/target/riscv/insn_trans/trans_rvzalasr.c.inc
+++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
@@ -29,6 +29,7 @@ static bool gen_load_acquire(DisasContext *ctx, arg_lb_aqrl *a, MemOp memop)
         return false;
     }
 
+    memop |= MO_ALIGN | MO_TE;
     memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
 
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
@@ -43,26 +44,26 @@ static bool gen_load_acquire(DisasContext *ctx, arg_lb_aqrl *a, MemOp memop)
 static bool trans_lb_aqrl(DisasContext *ctx, arg_lb_aqrl *a)
 {
     REQUIRE_ZALASR(ctx);
-    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_SB));
+    return gen_load_acquire(ctx, a, MO_SB);
 }
 
 static bool trans_lh_aqrl(DisasContext *ctx, arg_lh_aqrl *a)
 {
     REQUIRE_ZALASR(ctx);
-    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TE | MO_SW));
+    return gen_load_acquire(ctx, a, MO_SW);
 }
 
 static bool trans_lw_aqrl(DisasContext *ctx, arg_lw_aqrl *a)
 {
     REQUIRE_ZALASR(ctx);
-    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
+    return gen_load_acquire(ctx, a, MO_SL);
 }
 
 static bool trans_ld_aqrl(DisasContext *ctx, arg_ld_aqrl *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_ZALASR(ctx);
-    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TE | MO_UQ));
+    return gen_load_acquire(ctx, a, MO_UQ);
 }
 
 static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
@@ -78,6 +79,7 @@ static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
         return false;
     }
 
+    memop |= MO_ALIGN | MO_TE;
     memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
 
     /* Add a memory barrier implied by RL (mandatory) and AQ (optional) */
@@ -90,24 +92,24 @@ static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
 static bool trans_sb_aqrl(DisasContext *ctx, arg_sb_aqrl *a)
 {
     REQUIRE_ZALASR(ctx);
-    return gen_store_release(ctx, a, (MO_ALIGN | MO_SB));
+    return gen_store_release(ctx, a, MO_SB);
 }
 
 static bool trans_sh_aqrl(DisasContext *ctx, arg_sh_aqrl *a)
 {
     REQUIRE_ZALASR(ctx);
-    return gen_store_release(ctx, a, (MO_ALIGN | MO_TE | MO_SW));
+    return gen_store_release(ctx, a, MO_SW);
 }
 
 static bool trans_sw_aqrl(DisasContext *ctx, arg_sw_aqrl *a)
 {
     REQUIRE_ZALASR(ctx);
-    return gen_store_release(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
+    return gen_store_release(ctx, a, MO_SL);
 }
 
 static bool trans_sd_aqrl(DisasContext *ctx, arg_sd_aqrl *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_ZALASR(ctx);
-    return gen_store_release(ctx, a, (MO_ALIGN | MO_TE | MO_UQ));
+    return gen_store_release(ctx, a, MO_UQ);
 }
-- 
2.53.0


