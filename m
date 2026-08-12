Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5316CC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUX-0007IU-FC; Wed, 12 Aug 2026 18:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUU-0007Fy-N3
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:06 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUO-0000yf-OZ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:06 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cc891373e0so1797565ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573919; x=1787178719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OLr6AWVYwmvoOGhA0NVH5A+szln3Aa4bJ7XtbqeSm+E=;
 b=XOhE6XYFRjzylgIB2D9BU/GEOjIkCgJkqizZT5agjuFKw3+4+Zf9TUCdV4pvkmMqAZ
 iVuqzJqLaPy8vK5bkrwdMuTiJfHXfdnahW8DjqsGY9E+MSNWemcGa5QAD+gGT0q8eIKQ
 VyJvOVkV0vXfIM6XkYN84z0xl+I7xaDxFQloQRFVStyCeluX6ABaUJthDdyc4gWDREo6
 IOONhSyp0zjLTrSDA2+kkOeZ96pOxusAYD8lW0Cz57dqJghPX0utK7LXGNP5+h7pDpBb
 zj71S4C/jxEeIA8zIvtAD/Tmq2IH/Bhem0Y+0aMarbWEIXT9Hdo1QmZlOHK+NiydkL7e
 8VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573919; x=1787178719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OLr6AWVYwmvoOGhA0NVH5A+szln3Aa4bJ7XtbqeSm+E=;
 b=rkIAIE0dyul7FKBNNjjtglkW7IQgCDmCXpIHJ8sRTGK5G/+AO7Ubq6DNQx0nDvH7W2
 5ro/YtvWDuRw8ERJhvN8nLGAU0JvpK20GYppVi723Kw1yKre2430526lMdUn6d5E7KOm
 6EqO19ornW2g27lTOCuwh/kvaDqcyVI3siMDnmRgsacWCTpKtrMm1RZUPOqRFVe6Z885
 rtlsbxiu+Sac6hFwtHdjUQPJ1trb9sSjLEg781opcvnXV+2X2BIoEQrd0zInu6497iRg
 FUrQpX2yTw/AmRnl2CB4yyNZyp1i+oepud9ui0fM1AgYkVqbD0P+gTSS6h/G6fDgfdyC
 velQ==
X-Gm-Message-State: AOJu0Yxs3j58ZaxzGd0iKLWkhMni5U5gn1ihTZ+4VW13SCiBLeAkCOlE
 SVMr2+MTHtvVuBH8AEXGJLiUyMBV69qWzeHARkDI0M7JNqXOnuFH/ZbSKU1e4chcMMUFt16jYHJ
 jKTOC
X-Gm-Gg: AR+sD13Z8zKL7MeCcP28Py6bAclyaS+IAt6Q35LyY2kkDqtwEFgce0QAhNlksu1VKhp
 WtzFcK7wv5kGAD1BJhaT18Ttl7XuxBqylgyKGSiMCY4zB80nDrnmz2PAXnxkfhDW5lWwgQxCTsn
 TnwGxJdBhUUd/3R0mpqAZZbWp6/ekqn/mekzZNne4CFfqIuubAFrMTIXc4/DQ/9iYTO8l+0lrJl
 cxtIqK1nv0YZCiKjBuV00SFna6B+U1CQvxeDFNlT0wfhKb/05pa+apNeo4KEiqHFhoVjT974f6P
 rfm81+gK7ZoY3bkZOvNRg3n4fvxQrdW8NMzfPUjo4JiRNsTRRAhHFDJs8pC1wttacmGF7y27etw
 xtwHmaignyh9iDD71OKdSgY3Um05/tmevUdxNbyp/Ysx1BrRxtMagNa3H0SBhGNIT+rAsJZ4lWQ
 8K740dAdDrikIqC6DWzlk5ucb8pDSKzY9pzaoCiv8ADwSJVH1AxgVayQoigYUAtY8PL8jLCNqH9
 ANtMgqvwXTLJfZre4OPH/yKTdF5IfA=
X-Received: by 2002:a05:6a21:1786:b0:3c3:7a0a:18a6 with SMTP id
 adf61e73a8af0-3cc552bf248mr2535107637.18.1786573919465; 
 Wed, 12 Aug 2026 15:31:59 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:31:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 13/52] disas/riscv: Handle c.addi4spn imm != 0 during decode
Date: Wed, 12 Aug 2026 15:31:03 -0700
Message-ID: <20260812223142.349142-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 9813d75feb..8a957e6a1e 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1885,7 +1885,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1 },
     { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1 },
     { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL, rv_op_addi,
-      rv_op_addi, rv_op_addi, rvcd_imm_nz },
+      rv_op_addi, rv_op_addi },
     { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, NULL, rv_op_fld,
       rv_op_fld, 0 },
     { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, NULL, rv_op_lw, rv_op_lw,
@@ -2952,7 +2952,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
     switch ((inst >> 0) & 0b11) {
     case 0:
         switch ((inst >> 13) & 0b111) {
-        case 0: op = rv_op_c_addi4spn; break;
+        case 0:
+            if ((inst >> 5) & 0xff) {
+                op = rv_op_c_addi4spn;
+            }
+            break;
         case 1:
             if (isa == rv128) {
                 op = rv_op_c_lq;
-- 
2.43.0


