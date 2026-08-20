Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46BCC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtmF-0007nc-M6; Wed, 19 Aug 2026 23:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtm8-0007au-9u
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:49:09 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtm6-0004Tg-OR
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:49:08 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2d58efc7356so19078255ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197745; x=1787802545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aHib+VBpVmiPANdQmekp+Cwzw4eMIzE03qptIJvCC3Q=;
 b=Cr34xoez4Q1TGKJOaLvDIMhoITg8yRpJAvgEdsAjd1uob4abOqoPM5jb3UEbrX5r0O
 6Cst8icnt8nfWWIM+JOtTLzhBU85cWf5ZapGUXWxmFkWNOgZkrAcwhcbUtpo6l+BDs18
 Ia+TAQD1VKxvfKF36ZkiCIrj39hiG4N8ctYKsO1Di8zMEyJVmmua6zDP+0VEYpGKU0fR
 IacxBwMSlQs3+t9u6bq96GLqo6eIbjvw8KRHcI9+5wSvrUT6+puRHiZalC0LpIlWwCcJ
 0QgAlozTAnBB5by2v2KEZ0x8YoJv4Zt40WHRwJ6ABteeeyaGQWS8UvCh/kHhcix3tzYF
 gH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197745; x=1787802545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aHib+VBpVmiPANdQmekp+Cwzw4eMIzE03qptIJvCC3Q=;
 b=TTg/sVHlfCwgtqwQ8E/+lB+kg1HTxr2RuUSgdh8XPjaVlYPsu/TPD86EqbWpxljnIE
 CB6uesfKVqrO1ph3ldQVAKoZllQC6l4rXnPImfaGVbAPG3g+CMrRbVspmStff3hSMqir
 AYoiQhyT9A7DYOukDNUGogKlF7g0EeSTOuB44eqU2O8RL5Af0jgYt79oafbE6nfLh8Fw
 PpA0youP9ZVgzZgLhwM0359maDwxQWapIjbxTsP+KdGOnEYZeE47ZJVJFAZfdfNwCjuS
 rAi11d9mE9GTyvh4dCTTiph3Ws/+T2H4GbWlol47ELsqXnZmXZBzkQzrrI8xQ6v5B23k
 eo6g==
X-Gm-Message-State: AFuF++lyL8ii23e9FIVsw3s7hTUdXz8NmZAAFaoltWIQWD/5jza952sE
 gV12J1MBmwB9qhc1pnU1Vd9P8vYDuukHrRf2P4H2dQgybP+Xhvz0EFTx95LZgQ==
X-Gm-Gg: AR+sD11uKbzoj6eI5jD8uxYJ9+dx/Yx6wQYfcPT/yKX3808cigOmbWwWYVD5YbQyjcy
 C7ktCqlQfkm41rF4xRAi8DCg9nYVsb/0oZXXac7gPwWs0UHsHGczI59tnz9iRzeoi73z9v1yZF9
 FSPXHZuuj35VNSWVR+FOkC8Ek6iit9TXlNDJ0F/sFy9aTPOZhFvacAvVbJzScxktWzyRG5oXgkZ
 RhsZ1UYM6u3qJTA2vaEry45q8FeLX1S2pVwfAI03zQeAwxZ9HHfVGAThayN7qqqyJa6Ra1FJuly
 WTSgaJ6jdtD6lXFk7+cItNca1DO4Km0I8f7x/0EvT1gKr9O4z+th548VgZxcGzY5kpnqvncanVr
 1j5pjqJIa55y/BdbH7wxWTy8u7w27rRKhIZOrSrLeL7387hsKgfosWf+VJ7oNn4HusyLVNj5I56
 MqMM+l9AIm4YkWCEfSppBSfgx02u4cb6hpJIofhcMf1w0H4OLtEJLoc0HmUUtaMCL/DCGbO+9TM
 7XELvQ=
X-Received: by 2002:a17:90b:5250:b0:381:9028:5945 with SMTP id
 98e67ed59e1d1-3958125375amr19117255a91.14.1787197745310; 
 Wed, 19 Aug 2026 20:49:05 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:49:04 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 91/93] target/riscv: enforce even register constraints for
 Zdinx fcvt pairs
Date: Thu, 20 Aug 2026 13:44:28 +1000
Message-ID: <20260820034430.1186695-92-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: wangyang <wangyang25@otcaix.iscas.ac.cn>

fcvt.d.h and fcvt.h.d access a 64-bit double held in a register
pair, so under Zdinx/Zhinxmin the odd-rd (fcvt.d.h) and odd-rs1
(fcvt.h.d) encodings are reserved.  Add the missing REQUIRE_EVEN
checks so those encodings raise an illegal-instruction exception
instead of retiring.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4109
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
Message-ID: <ea287909fd6043e0bbcdbfdcb0cc8063@wangyang25.otcaix.iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/insn_trans/trans_rvzfh.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
index 88711fb076..b17ef9541c 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
@@ -419,6 +419,7 @@ static bool trans_fcvt_d_h(DisasContext *ctx, arg_fcvt_d_h *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZHINXMIN(ctx);
     REQUIRE_ZDINX_OR_D(ctx);
+    REQUIRE_EVEN(ctx, a->rd);
 
     TCGv_i64 dest = dest_fpr(ctx, a->rd);
     TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
@@ -453,6 +454,7 @@ static bool trans_fcvt_h_d(DisasContext *ctx, arg_fcvt_h_d *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZHINXMIN(ctx);
     REQUIRE_ZDINX_OR_D(ctx);
+    REQUIRE_EVEN(ctx, a->rs1);
 
     TCGv_i64 dest = dest_fpr(ctx, a->rd);
     TCGv_i64 src1 = get_fpr_d(ctx, a->rs1);
-- 
2.54.0


