Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B3FD1714C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 00:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t32Uz-0008Sx-5G; Mon, 21 Oct 2024 20:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t32Uw-0008RZ-4K
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 20:11:42 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t32Ut-0005T3-LD
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 20:11:41 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20e576dbc42so35472485ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 17:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729555898; x=1730160698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fAJQC4GqxCqaQY8NfmL5MIB0y8RcpemBGcs+K8ojeDw=;
 b=tzMd145j1dVcUiRJi2W0eXjaS32VtsfGtR7JUZPhhJvKmsDCuNeCIYc0d0BebyM2/m
 LsvgszGVPt+NJ3KnTKULsED8QYA69U+ztWiZMRbgNBQ67tfmESgEcSFhApJvgwoBIcRH
 t2fCtyUWp+YSQqIqVGnSX8E3sIJ55xGioiNEBCWytFjdyPBjRdpy+Y+Kf2jXCYJoVCbN
 X1O1o28L/yGu8G/0U5OUm0eoLcj8db+F9UcHYFWrQp3+MF7urkRQjS3Cr5yOwir98cLD
 SOEXtym8VBqR8bMZ6DYy8YfzKdWfHvPnjXTsS2nYAuCXKueUIZNlcsYRkTkfdhGJtijR
 XxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729555898; x=1730160698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fAJQC4GqxCqaQY8NfmL5MIB0y8RcpemBGcs+K8ojeDw=;
 b=Ct8wzp+C2WhA9YZabAZ8E2m6+kZbqDD4azI6jefuSKuCxXxcp2rpC+UT/a17lhmNPH
 Y4LpghZrDad73zxzOS2rBpHcn6JjBGUebOfkcUX8tKEZzl5YFeLLjzCK6rpsJkLxdI2x
 W3eD9UxNKM6i1Xw+3iEUahjDKkmu7mTgC8N3oDNn4ybloH4mhwWYd5L2LE25+h5p+/gK
 xFOCeNZfQjyNFpejSZ8osHQjF0GZ30popiflSEg3AhYVy4gfTagqjeA2liTaNOMYP3jn
 w5uyi05YJjpq0RS9QL+N9YM3ppTlAVZnJ5v5oZ0nn+Jgy73hsULS6EayAyh7CXH8lHBD
 ro6A==
X-Gm-Message-State: AOJu0Yw3legpTsCZEXyOTn0QLUT+4jNHRqqv3XN46VDpc7jivsyz0a3F
 nlKmxIetFBKAn00UrZRtzvfT3rBooCPiZDS2q7V4vyBG/ZPCeQ28HwiNRQPndVyYdGQFRap0D8p
 q
X-Google-Smtp-Source: AGHT+IEm8Xe4RM6EdMliBXpcl1DNZpiihhktZO70M+GD9EDfhvXxHijO7gluM3lHPJVITD0tgfk/sg==
X-Received: by 2002:a17:903:185:b0:205:968b:31ab with SMTP id
 d9443c01a7336-20e984eaad8mr10922635ad.58.1729555897686; 
 Mon, 21 Oct 2024 17:11:37 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0f6462sm31681145ad.272.2024.10.21.17.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 17:11:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, dbarboza@ventanamicro.com, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 02/14] disas/riscv: Fix vsetivli disassembly
Date: Mon, 21 Oct 2024 17:11:22 -0700
Message-ID: <20241022001134.828724-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022001134.828724-1-richard.henderson@linaro.org>
References: <20241022001134.828724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

The first immediate field is unsigned, whereas operand_vimm
extracts a signed value.  There is no need to mask the result
with 'u'; just print the immediate with 'i'.

Fixes: 07f4964d178 ("disas/riscv.c: rvv: Add disas support for vector instructions")
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h | 2 +-
 disas/riscv.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 16a08e4895..0d1f89ce8a 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -290,7 +290,7 @@ enum {
 #define rv_fmt_fd_vs2                 "O\t3,F"
 #define rv_fmt_vd_vm                  "O\tDm"
 #define rv_fmt_vsetvli                "O\t0,1,v"
-#define rv_fmt_vsetivli               "O\t0,u,v"
+#define rv_fmt_vsetivli               "O\t0,i,v"
 #define rv_fmt_rs1_rs2_zce_ldst       "O\t2,i(1)"
 #define rv_fmt_push_rlist             "O\tx,-i"
 #define rv_fmt_pop_rlist              "O\tx,i"
diff --git a/disas/riscv.c b/disas/riscv.c
index 5965574d87..fc0331b90b 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4808,7 +4808,7 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
         break;
     case rv_codec_vsetivli:
         dec->rd = operand_rd(inst);
-        dec->imm = operand_vimm(inst);
+        dec->imm = extract32(inst, 15, 5);
         dec->vzimm = operand_vzimm10(inst);
         break;
     case rv_codec_zcb_lb:
-- 
2.43.0


