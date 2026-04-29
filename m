Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41490FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwra-0002NV-7d; Wed, 29 Apr 2026 00:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrY-0002EI-DS
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:28 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrW-0008R7-Ux
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:28 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so4294068a12.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438165; x=1778042965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wR/oXjKpk4leSOy7dojdHq270BtFNLUhfA6WOnCB+M=;
 b=MtnXBEspaSajpD/Dkaw/Uwb3j35iPQQVMIE9tHkT3uJpswLuTR/fFiaXPKQkRJMzhI
 o1r72wIPEPQCqT4gSOZDboB4xB5qkkHsVzJ2lPcBdKGAxvN2tiCq+ZbgsHPp0AcNeC54
 FKm7erkIGqMUsB56P6GFL8fIT5s5wmbVK3JfFIqcCJfL6s5V8GPT3/iGy+GUszUGnk9E
 pgiDqg6d8nRRyS+QnwqGyRq397M3vy6taKAT2je426xTI7A1vSpGdCVJx3Mn3IVKT2eW
 alG810JZS6e0SoNQvrNrjkIm1xAYCH+/IF4D+RwQxvArlal8Ub7qc137YMyLfRe5d3FT
 Agdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438165; x=1778042965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7wR/oXjKpk4leSOy7dojdHq270BtFNLUhfA6WOnCB+M=;
 b=nM0epxNC/bJOvS9lJoZs3fALEfcw0uwfN6gU3uPL9c3oY1PdUwjhsvw37xVlTE3TLg
 u/5pQiPfxmTq3g+UWT5vNRMabZzYqwrZCkbsoaTy4QuBegWS241Fe3F1KDHW79MQPnxp
 pDIQ/ciwGHfdOkf5Ev275MzsqIAzx3xTnHackI7Gn14d2seyCKBEq/pj9Z4oyDMb1Fn0
 ZFTW0Pvg2cQhv+ZNja1XPE1p/MfqkcgbGr1655j/uGd8vcyHCPSIdWwtq1UGM3cU76Iz
 ycLCSI2O4X6tmrlMw7NmURzipK22xOc9BBv5O4cVcikrWbVPL/W0LKgAdt2cO5Xz9X8w
 Mv7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SiaTdU+3gSI3hl1Zl5vpnVPJpKkaJ2euXVfvR06NsbUfqtlScccMJ0Cjpm+OgEHlLDs+K0knG4S2J@nongnu.org
X-Gm-Message-State: AOJu0YzIFxebhXuGl9j4YRj6suynNAp9j0IpLXqXse7raqAbGq9Z3lFe
 WCy4XcE1w7N9xDxR9U5oQkb6blpOG5UC1d2tLGN/R0DXCAwXEfnl8pVw
X-Gm-Gg: AeBDietLo2ig3/wjuRyPox4SpQcd5rkT9ZaF43z6TZGgbZOPO6yw6j0QLoPtB52SIkW
 Ub17XoYxupc3y3GJJlr5FAVL6gsJcQ+LIt4IhDMYJ14JqPDV7nb0+OEJMB8UXl49vg9NDumuGHG
 tvS8Q5WK6pN5vjYYQb8Q7kzeGjQM7Tw8pQPHxc9DQV1CtAdZjq4/nsnPdHGuJjvt6Iby8Ch9Xmh
 9dypSVmhpqZ8Aj2mXSzCYfo0EbhSEXh9N17Z5tC6/cnBldBGn27OMfQYXbPIwydvtKavyoovlEh
 3ZVg6nZoL+/Qd0v5hgeda8rENN/s0YXG+pAmw2kKqxj0O4jF2gVjNeZvpGc4eCpxo1GVq5+04JN
 FfQ7hojb8rVSFzA08+FTNk3pqaPzZ87U4YTQuKSWoD6B7YgFpthDmk06s3gzq5BTg40kfSkUIWg
 am4uXCoLEV7T+Kp6KzvMrJGswguG36CnbjQoD2Z1IyRzHcz0+ddEV+
X-Received: by 2002:a17:90b:5826:b0:35f:b46e:e329 with SMTP id
 98e67ed59e1d1-364a0ae656amr2340700a91.6.1777438165582; 
 Tue, 28 Apr 2026 21:49:25 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:49:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/51] target/riscv: Replace MO_TE by mo_endian (Zilsd
 extension)
Date: Wed, 29 Apr 2026 14:47:16 +1000
Message-ID: <20260429044752.4176397-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Replace compile-time MO_TE evaluation by runtime mo_endian()
one, which expand target endianness from DisasContext.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318103122.97244-13-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_zilsd.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/insn_trans/trans_zilsd.c.inc
index 445406cf01..f50c52f22c 100644
--- a/target/riscv/insn_trans/trans_zilsd.c.inc
+++ b/target/riscv/insn_trans/trans_zilsd.c.inc
@@ -30,7 +30,7 @@ static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
     TCGv addr = get_address(ctx, a->rs1, a->imm);
     TCGv_i64 tmp = tcg_temp_new_i64();
 
-    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TE | MO_SQ);
+    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_SQ | mo_endian(ctx));
 
     if (a->rd == 0) {
         return true;
@@ -85,7 +85,7 @@ static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
     } else {
         tcg_gen_concat_tl_i64(tmp, data_low, data_high);
     }
-    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TE | MO_SQ);
+    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_SQ | mo_endian(ctx));
 
     return true;
 }
-- 
2.53.0


