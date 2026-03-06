Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563DFF5140F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyPLQ-0003EC-Cf; Fri, 06 Mar 2026 02:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLN-0003DL-T0
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:29 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLM-0007l2-E7
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:29 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82987437624so914138b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 23:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772781087; x=1773385887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kt+rzQ1UgiE2GK7Z5HkdPPR7yZ9vyWBgUNG5GVXze5Y=;
 b=CZ9pABvZ82Ix1PsePRhZHIG60HnPfATjvP4UPXHinx7ubxJqcA+os6zJTWJGRaAZvp
 INDNrRKNf/kR5btJHto7dYDizJ2P1WoBtrH1F8LpDqmbEYOhyCUT5GgbjTTP6i+ZKwIF
 BEK/awtspo425kGlWiaQ3tvjO+y7yp4y2Q8WhFkdHNaY/CltO9bAOE5ux9u8fROHH/cU
 /f/HD2DPu9GPV4wzf8a0AP2mBpIcN3q4LboJdCfhocFB0xqft2CtSq6x6v+CPfy0FqVF
 IX4S4sASFyoB2aNVT/6+BlOLShg5EUovzH0TASCFwahaSSIbPb/9ft2dfXUAjtjQLeYT
 kPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772781087; x=1773385887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kt+rzQ1UgiE2GK7Z5HkdPPR7yZ9vyWBgUNG5GVXze5Y=;
 b=SO+AZ79pDa7YWgNl9QLY2X07YpKGFSL8HL7NTIhmwlba3UVXzn0CYdxradkkGyH0ka
 t0JyKjjehfIC7p9vAQ9OpY7VW/2pLnZWskGbKPpYBploFCHHkPvdw2fhad0hrg6aqEko
 hKL9lZk5r6/9tbVWS7akCxiXpqSEP/MLpO7pdFH/iMG78BoqQZTqAnEpOERs9vYQTQCr
 Rl81sWCHLyzkioilEwpH/DJ64I81LblfRDswHi0FnhZzimeVc1si42e5X/PeMayuuG5I
 FlK2XOWURN1Edb60USQRfTOmPSmu8cjKoj3MEO2VxLeiUcMIKKzp/krWOKvoi8BFAoPC
 vpoA==
X-Gm-Message-State: AOJu0YzZ46fTEwADylhuyecWYNABmS305DOruo5+MUsgl32iBaxIGZkw
 Ws2uS7r5ad9N2lUI2OaAf8rykXX/xm36ZikOM12v9Yfa+6DDqt+NVBa+Nbg0jJKJRM86fJtvyfD
 NDDrBD/NZ2KELMiklIZSoYebOkRfHa4tx7K1CqqENahJEZ7FoIg0vZjifZ00U8Wd2t/Aj1n7eT2
 InNX9W+0vCNBSSI2pj9NWC3aM5AN4DVewrvHqaS56+wdPp
X-Gm-Gg: ATEYQzzTkaCRM+ZJy6jnDjwgcAvTHGq0lvtmtAxCSUlstf31P33MUP8pqZYbcCFgyM0
 c6683td6bx49hQE+3fMbECM6ZCn9UNEPvD3MUh20QTp5IMD4jprBA1pJy3JHbPGBMnk97ce0c4X
 LL8NuXv5bNwRM5fIRcNYVTOJ5oK0tvc/yz6I3V9g8UINNxWnNScD2RqngDYE4WzzptxkWwtu4GI
 LV+CbuZIl+DtqN3GU0iyh9KhjI7ksuSqR9XUOWL46EMz4pz8eM27w5QcGZBk/lSbsChLIg7p59V
 O1GNry0sIxCtTzESDikAR5EXLMBDC1+LvrAV3EOywJHc4ZVEXvE1w42ao2NInXkWHoQxxKZCk2R
 aoTWBkHai3OEAldHUNxZ+vznliCkn35SInvCcbREyDgEfl7AD9cNYKU1evKsvicxUyVAptIEHbu
 wkmrpq5Rf1LkNP5biwChpIifqIej6Hvnh/gIaxuYKiU2m5uJ0Aj3znSraokli4RLoVNaJNBMNQ1
 zasFAQGX/M9P+VALXy3PASgayY=
X-Received: by 2002:a05:6a00:2ea4:b0:825:2927:3aa6 with SMTP id
 d2e1a72fcca58-829a2a12265mr1353647b3a.14.1772781086983; 
 Thu, 05 Mar 2026 23:11:26 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a4636c74sm956093b3a.12.2026.03.05.23.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 23:11:26 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v5 7/9] target/riscv: Introduce BF16 canonical NaN for Zvfbfa
 extension
Date: Fri,  6 Mar 2026 15:11:02 +0800
Message-ID: <20260306071105.3328365-8-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306071105.3328365-1-max.chou@sifive.com>
References: <20260306071105.3328365-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42e.google.com
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

According to the Zvfbfa ISA spec (v0.1), improperly NaN-boxed
f-register operands must substitute the BF16 canonical NaN instead of
the FP16 canonical NaN for some vector floating-point instructions.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++++++---------
 target/riscv/translate.c                |  8 ++++++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 4df9a40b44..03ae85796a 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2319,17 +2319,17 @@ GEN_OPIWI_NARROW_TRANS(vnclip_wi, IMM_ZX, vnclip_wx)
  */
 static void do_nanbox(DisasContext *s, TCGv_i64 out, TCGv_i64 in)
 {
-    switch (s->sew) {
-    case 1:
-        gen_check_nanbox_h(out, in);
-        break;
-    case 2:
+    if (s->sew == MO_16) {
+        if (s->altfmt) {
+            gen_check_nanbox_h_bf16(out, in);
+        } else {
+            gen_check_nanbox_h(out, in);
+        }
+    } else if (s->sew == MO_32) {
         gen_check_nanbox_s(out, in);
-        break;
-    case 3:
+    } else if (s->sew == MO_64) {
         tcg_gen_mov_i64(out, in);
-        break;
-    default:
+    } else {
         g_assert_not_reached();
     }
 }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 89d4f6fe67..d9df6a35ca 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -214,6 +214,14 @@ static void gen_check_nanbox_h(TCGv_i64 out, TCGv_i64 in)
     tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
 }
 
+static void gen_check_nanbox_h_bf16(TCGv_i64 out, TCGv_i64 in)
+{
+    TCGv_i64 t_max = tcg_constant_i64(0xffffffffffff0000ull);
+    TCGv_i64 t_nan = tcg_constant_i64(0xffffffffffff7fc0ull);
+
+    tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
+}
+
 static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
 {
     TCGv_i64 t_max = tcg_constant_i64(0xffffffff00000000ull);
-- 
2.52.0


