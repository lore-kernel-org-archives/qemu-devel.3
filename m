Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C19C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuLs-0005tc-O9; Wed, 05 Jun 2024 13:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLq-0005sB-KT
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:06 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLp-0003ow-0T
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:06 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c21574d8ddso64193a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608184; x=1718212984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ox1Mr+ffZVyh0koVrB6Uya3/DLO+fh2XzFHibAEoLAU=;
 b=JCsWpff137TrmZQTURUtRYvvoIHulQqnQ0qpv0qnl/HPAT7EH87eDmBUMZzPzemP1i
 vdTWIdQGxgMrCSFPYS5Va0rFAPKPcHzzHU9o6r7qO4O7UnaxFNHHwUkBYYxC1qkmbjv3
 O9F/MmDeDuyrogO/psB+T5bhoI2aOW86x3Va0zVh8rHpEVsa93ZdSsQQkUnXYpum9D3z
 4OUDepDclzklqS3DAkAgz1TTbM3brnTcl1bh85AaD5D5dvXv3/DLeSBCNmZOvt4QzhXi
 69LxvU3Luir3vKfT2GtG0jh0pivMaN6Y5KeudK1F9EgViNahs2zTv2HygmFpZNgLhDVw
 SZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608184; x=1718212984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ox1Mr+ffZVyh0koVrB6Uya3/DLO+fh2XzFHibAEoLAU=;
 b=xVGKZkYfTA03MbByrFVP3OmRvuNpkUSNRbJdQK7wwGr+SGObyA5prd18o7SGGN2OI0
 /RUvWp6BeLviX76t9dcw4b/5cZBXxjcZBuGsToCGuKdSUZgvXpE0PmmAxfAsSFZLpfPD
 ASYKsHqytmwHfdSqyzaDaf/P8u2NT3iDspX5qqgYIxMAQ6SOMdm0raVUNcgZZN/pH0Xn
 IsQoQDfsiznAx/UB7Db/lWsDzz0gF1sgNWADF1pkAPuiDp424ljfzT/CazHGrbk+ORTX
 2aJ4h6CjJemWmCpRlPUa+ihWRjSpK+Er2uVIdijGV2p027xjnBAuA5GXayLSwEX2gOI7
 eisw==
X-Gm-Message-State: AOJu0YxzGxbssT68oQwDNtx9hwala6d7/6LPqLxTrwSRixHe6XWQG8bE
 YlxgasOFlZVAgnCYT6W8DLIE1lwqC1VEDXYeZXIrXv4iFMKU4+rrBgK7Id2u8KGZ/tr39jlnveO
 O
X-Google-Smtp-Source: AGHT+IGInA+sLN7IlzPsJsyxutp4DS9e8WadkBvFZPTjtGjejZvM+dL+7Vs/KB6YIEAgZ4PKeQdpBA==
X-Received: by 2002:a17:90a:ca04:b0:2a4:b831:5017 with SMTP id
 98e67ed59e1d1-2c27db68cf9mr3077606a91.48.1717608183685; 
 Wed, 05 Jun 2024 10:23:03 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/38] target/sparc: Use gvec for VIS1 parallel add/sub
Date: Wed,  5 Jun 2024 10:22:24 -0700
Message-Id: <20240605172253.356302-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 362e88de18..7c290293ea 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4664,6 +4664,24 @@ static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
 
 TRANS(FMUL8x16, VIS1, do_dfd, a, gen_helper_fmul8x16)
 
+static bool do_gvec_ddd(DisasContext *dc, arg_r_r_r *a, MemOp vece,
+                        void (*func)(unsigned, uint32_t, uint32_t,
+                                     uint32_t, uint32_t, uint32_t))
+{
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    func(vece, gen_offset_fpr_D(a->rd), gen_offset_fpr_D(a->rs1),
+         gen_offset_fpr_D(a->rs2), 8, 8);
+    return advance_pc(dc);
+}
+
+TRANS(FPADD16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_add)
+TRANS(FPADD32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_add)
+TRANS(FPSUB16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sub)
+TRANS(FPSUB32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sub)
+
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -4684,10 +4702,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
 TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
 TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
 
-TRANS(FPADD16, VIS1, do_ddd, a, tcg_gen_vec_add16_i64)
-TRANS(FPADD32, VIS1, do_ddd, a, tcg_gen_vec_add32_i64)
-TRANS(FPSUB16, VIS1, do_ddd, a, tcg_gen_vec_sub16_i64)
-TRANS(FPSUB32, VIS1, do_ddd, a, tcg_gen_vec_sub32_i64)
 TRANS(FNORd, VIS1, do_ddd, a, tcg_gen_nor_i64)
 TRANS(FANDNOTd, VIS1, do_ddd, a, tcg_gen_andc_i64)
 TRANS(FXORd, VIS1, do_ddd, a, tcg_gen_xor_i64)
-- 
2.34.1


