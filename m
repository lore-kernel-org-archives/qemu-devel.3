Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57DAC5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNc2-0007Ll-An; Mon, 24 Aug 2026 01:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaI-0004Ao-7V
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:03 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaG-0002Yq-HN
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:01 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso3589467a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550659; x=1788155459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=toVDeATvXKbZsEV6lrO/6YOhYfdtzoWUhVqQYDrEcNA=;
 b=lOamquYfd8gxJd5fjA9IpfkfbcyY8KUfw11tz2NvwbvTKFfRtXR15ShzjfHZau61PE
 P82reVlv3+SwTavN0cDNlObVrKJA1bWczDzW6LuHkcdqgg6XIyqIUrBtvajhw1sZdpKd
 /IYvh/wgastcMmH1SHshkFGFfAP2xVElIZ7uHvaBB7t4AF12jz79IDCLbBrnik7ehE2B
 2xihZNtvRJKlhPcyWEIFSQJV1LYU2e/b/nrJr3dUVUT40FZIpp/1BPy04RDRaZ/h5rfH
 Y5jXEgt2VSWdVgNMVGl684yUi4yaJcIIDn+5ZlB7DelqrqUcJ8u17BrlE91dnKBN/A43
 tQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550659; x=1788155459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=toVDeATvXKbZsEV6lrO/6YOhYfdtzoWUhVqQYDrEcNA=;
 b=giIkCMLx3BgJQz+zKbtwBzJorW00I3KfRwIBxpujHBlwNp4xY6tibDk4yPUDe1R8XR
 5pMDd0wWik+czCPlUmqHlsjt4eZ0JNeKSxZC24Ek+AzhOEnscESvO49yDZ6K6MqtXHnT
 sFOb4Szrsn/LNYOPml6EAeJhFoXQf4Bhjv3JHP3OD3SctzwBzRk6+2i1bKGB5i+M6vUz
 TLWhX/ua9DEWKVl56tm9z9uJqpFbuBW/8+EzP+olkCKMZUF4pvv9PkQ09LkJn8/XYUJW
 hQzhH8ufpQVbClc+PHr8W1XRjsd8m0LCorE5PVGMBshN83/mmDyRDEfaLdzX7ihS1Fxk
 6psQ==
X-Gm-Message-State: AFuF++mQIIy7Rj2mgbEziboEAuxI94r/5VOgjIjh9g/MiErmaj69Mdgi
 cQuJehvsBuAXznOXdtMLs+CFTVhmLfeotBFcCruvj1K9E2VO9BSf5uQHz4SVTA==
X-Gm-Gg: AR+sD13EfzY/Y/ao0zeDMduCnJuiCYy3Zo8r9YdjHPu2KNokWqB5Q/2XPuaRN6XqQCU
 W1uK7ntN5SgyQmKi4JbSlNMQzDvaKfXSu9m9WiHAtbp8mzoYDgpy+5BSVf+FhHqGle5JGtyJfap
 M4PglR89zFMSp8en9v73sS6sKbPhXrrLKjCzcosiMkr8wdgvskyF6B26PANeVszxSX29bVTBQJF
 BvlCh57KlbFit6hlyojTGBmUdqIecYeKrEAYD+IWu7AW5Vqs5C/tJqlIbD0abceaIYKtmJbIkGj
 LsQY4la2CotkJt5ZUtCPyaUWvLeF3blj48MYlXI9q7/s9Dp+IjNzFMvuMywVxnFgqG4/XA7jeSM
 kUpA5G5ASj2Ln2QhDOjtvwjoGgis1LBdSt/NpnyS9Fb9A7ZQ74zBaf/hWjIPlkiscswf1ZRtYzw
 Ko5a9Yd2xb2O9egcKM+Hi0Atly24N/dW/z+h0viv13Ul+Uiocqg92An4dq4/lO62W4iMgg15giA
 79EOQ==
X-Received: by 2002:a17:90a:e70f:b0:381:a766:efcc with SMTP id
 98e67ed59e1d1-395df3c6026mr30902862a91.14.1787550659205; 
 Sun, 23 Aug 2026 22:50:59 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:58 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 52/96] disas/riscv: Remove rvcd_imm_nz
Date: Mon, 24 Aug 2026 15:47:22 +1000
Message-ID: <20260824054806.2790041-53-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Remove rvcd_imm_nz and rv_opcode_data.decomp_data as unused.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-20-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h | 5 -----
 disas/riscv.c | 7 +------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 31bb0db86c..3909d73dd0 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -186,7 +186,6 @@ typedef struct {
     short decomp_rv32;
     short decomp_rv64;
     short decomp_rv128;
-    short decomp_data;
 } rv_opcode_data;
 
 typedef struct {
@@ -217,10 +216,6 @@ enum {
     rv_op_illegal = 0
 };
 
-enum {
-    rvcd_imm_nz = 0x1
-};
-
 /* instruction formats */
 
 #define rv_fmt_none                   "O\t"
diff --git a/disas/riscv.c b/disas/riscv.c
index ddc2f73eae..95957506bd 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5417,12 +5417,7 @@ static const rv_opcode_data *decode_inst_decompress(rv_decode *dec, rv_isa isa,
     }
 
     if (decomp_op != rv_op_illegal) {
-        if ((op->decomp_data & rvcd_imm_nz) && dec->imm == 0) {
-            dec->opcode_data = rvi_opcode_data;
-            dec->op = rv_op_illegal;
-        } else {
-            dec->op = decomp_op;
-        }
+        dec->op = decomp_op;
         op = &dec->opcode_data[decomp_op];
     }
     return op;
-- 
2.54.0


