Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FE3C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MLu-00069G-6x; Fri, 04 Sep 2026 01:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLs-0005yl-2T
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:36 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLq-0001HV-Bf
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:35 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-855d2bfae95so2126584b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499231; x=1789104031; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U2gzxt29hmF7py02xyODfXCxQuA84E6Fa93KLTQJGW0=;
 b=ESI1UoroOFjrWr0E9YOEes33IKyZ5zbiAgyy5p2O/PSn6Sb77o+xFFprnYLW+39N6+
 aL4836mejjyblmGhWJgtaKD+kybR6F1P/NA6EKKlodsB6gQBJZma2Q9QgvLkutg1CFbp
 ntXrtQWBs/24Jq+pAPApFc+VMpRYa+rV6NQMaC2fhMk+XZ5lgPqR50e5ZwE2v7Wau7tH
 LrL6z/YZBraDbh/r8BonUZ2IpH+fRaagUDAbwcLX9XdN8tGIgii5L/RZwzImMGdFSGCb
 GUQ4TH3rCd2uIjKve3XKp37Og/8E5ZzNazNlTEzSv919XPTrc04kiKiqIGBP4NfH287A
 5gDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499231; x=1789104031;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U2gzxt29hmF7py02xyODfXCxQuA84E6Fa93KLTQJGW0=;
 b=ApcJik02ElK6lEAc8eRA6f+DYPfdWEt527Jvz/KU9Zqi7vV+V+WC2n4pmdL5jP90UR
 jcvjDyOK+MrFjVVhoWlBSpyhkg8cQdA6tQ+b2whAHCjxDARvxwRpeaUA025O8yJwkIUR
 /wirVKEWjYdIPTa8wZddqyKnyO45v7NVrlZajY2D3AC5PA9HpMomSg5w5hDExWytCmzT
 Dq8pZZH/V+LwwOFS1BMzfTnRS8GWoKzSJEGksKnkMfGjBLTl+/RjnQQ0TRhisYTDxwG+
 JjPoy3tcUIXzABdV07jIn1cUsOTsKbOBY2sG4ZraEzqBnBEoJ/x/SSFt0A0xShFVYmeH
 r0Ug==
X-Gm-Message-State: AFuF++mGrGcjqHbMqPa5t8gQessco29igISf7sxNsa45fej0cvxBA4uO
 nxOkfCcZLjn3MVxCYaBxMw5cFFdgS4dI5AR8ZEA7B/P/n4rCWWVLM/1hXYUNgA==
X-Gm-Gg: AYBFou1Iz/LXBR52mf2JxJWIUa6UZKOXgKH5rUiGLD/8MsVQP4LL0b3d5yVrbRVO9Mj
 Zm9Y4HNVBg34fuQig5eRh16wyE/nW4xypkbUlz+FoaMuzpo88U49wNrDnAbMlWRegF0PqCR/EiF
 8Iy+pISx1xXxkU3hOxYzUx5Su8EZhHCaMY7w/IeXQa22vB1nnSd5vVWp4ngGpGR0t9RGlf8K7e4
 aFSiHoGvM5fHPlDTI4SNP/0qtAZeBoX6tNIy5MOKCywKyXG6aVo6moOydy9EXYxjsdO6HU4+46O
 MS+hVXPmGEwBQnvrCZJ8RUUbo0JQ56W9pVKl85Sjr4q5W0nD/u5NQMqu3sjmByMAC44ZaMmPQm4
 qzb5r7Jg5TwzO47gFQSTjdUQfpmoFZ0YZdSz9XCKBYZwxslsQ568klNdALDzNbNk289vmsyO7vc
 vesCoJBTXiSn1d77AObomfVUr5AXREkF7avpQO3YyznDQ/FklyWxhurn/QGiNdrBWxfKXcsXgDh
 rM9UpLUfvL1LkkUnF4=
X-Received: by 2002:a05:6a21:e082:b0:3d3:aed2:6f21 with SMTP id
 adf61e73a8af0-3da2160e09fmr9665869637.21.1788499231275; 
 Thu, 03 Sep 2026 22:20:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:30 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Julien Thillard <julien.thillard@univ-grenoble-alpes.fr>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/47] disas/riscv.c: Correct dasm for cbo and lq
Date: Fri,  4 Sep 2026 15:19:08 +1000
Message-ID: <20260904051943.799041-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

Lq shares the cmo opcode space, but the cbos must have rd = 0.
Now ensure that they are matched only in that case.
This implies that lq can be recognized as such only when rd != 0.
Update the decoder file accordingly.

Fixes: 9273cda722 ("disas/riscv.c: add 'cbo' insns to disassembler")
Reported-by: Julien Thillard <julien.thillard@univ-grenoble-alpes.fr>
Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260825100922.387919-2-frederic.petrot@univ-grenoble-alpes.fr>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn32.decode |  2 ++
 disas/riscv.c              | 20 +++++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 21272fdb50..aa02dae3c9 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -216,6 +216,8 @@ ldu      ............   ..... 111 ..... 0000011 @i
   ]
 
   # *** RVI128 lq ***
+  # *** Catches an lq with rd = 0, which we disallow
+  illegal  ------------   ----- 010 00000 0001111
   lq       ............   ..... 010 ..... 0001111 @i
 }
 sq       ............   ..... 100 ..... 0100011 @s
diff --git a/disas/riscv.c b/disas/riscv.c
index b8099cbdf8..e85dbac035 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1281,22 +1281,24 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 2:
                /*
                 * 'lq' shares the "(...) 010 ..... 0001111" opcode space
-                * with 'cbo' insns.  Check the next 5 bits to select
-                * what we want:
+                * with 'cbo' insns.
                 *
                 * cbo_inval  0000000 00000 ..... 010 00000 0001111
                 * cbo_clean  0000000 00001 ..... 010 00000 0001111
                 * cbo_flush  0000000 00010 ..... 010 00000 0001111
                 * cbo_zero   0000000 00100 ..... 010 00000 0001111
                 *
-                * Anything that doesn't match these will default to 'lq'.
+                * lq matches when rd != 0
                 */
-               switch ((inst >> 17) & 0b11111) {
-               case 0: return &op_cbo_inval;
-               case 1: return &op_cbo_clean;
-               case 2: return &op_cbo_flush;
-               case 4: return &op_cbo_zero;
-               default: return &op_lq;
+               if ((inst >> 7) & 0b11111) {
+                   return &op_lq;
+               } else {
+                   switch (inst >> 20) {
+                   case 0: return &op_cbo_inval;
+                   case 1: return &op_cbo_clean;
+                   case 2: return &op_cbo_flush;
+                   case 4: return &op_cbo_zero;
+                   }
                }
             }
             break;
-- 
2.55.0


