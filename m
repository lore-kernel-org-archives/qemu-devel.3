Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F36CC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 20:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s84Eu-0001wD-DX; Fri, 17 May 2024 16:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s84Ee-0001nw-Vc
 for qemu-devel@nongnu.org; Fri, 17 May 2024 16:31:25 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s84EO-0006Cj-7K
 for qemu-devel@nongnu.org; Fri, 17 May 2024 16:31:22 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ecc23e6c9dso21101015ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 13:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715977866; x=1716582666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dilS1/VlB0aOH85CFJ95Vq/ccImfEsIy0ewHOFeEiMM=;
 b=VzxGKTYOC4NHf/ciS+AIVcVzTrgApQVAyx9C3YoH8NvK94RJchV/EWNjgmB0uDnwwo
 P05qeN2AqINNVxwdq/mVkXCAV9LtOfYbkFbnV9MVECBidAX0wgX+wnglrQwnLF240wnt
 fiMMj/TteaA0/ISwRLxZ6Jd5QGs1WLgrDVCiFR4wDSY8dzgBw5WrEHZBKPmCnwgIxHZk
 Webe5EpqJWx9tCWJDtm9w0VgUtFhAJm8Lo536uVBHs2v1IrRXc921ZGrWXy0Z+RLWSEm
 QLxAlPDANczF0O4/e2wPqiZ4Y/d+zV/q/w+zMhyFsWAA90m5T7lwUYr7AlPDjeWNT0+i
 kblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715977866; x=1716582666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dilS1/VlB0aOH85CFJ95Vq/ccImfEsIy0ewHOFeEiMM=;
 b=t+TfruuVfdkGRqyEUUR8diWX3DX2O65EU6Wr4rIyszIHAUhF/q8gOlYBG/+nT3ixlj
 /cf2BuB8acT9TlI/DSJjTwy8Q6stic5k5H0GLY4TxA8pCdKvnIH83PZU569JS6dF/laL
 7Ulb4RvCCD7g7owuYv+oSgKt2nvybZx3gm8A5q9bHXZ8MWezQG1ortVwGOhA+I52gJgp
 mT+IvaYVysxJndt2S/OcbQ8naX6fYWMoPaJ0Y06vITVavqMc9Vcmq71Wp2TIMS5+6ifS
 5FIevu9sG5/NpCQxN+bmLJu9PN6hNxysb4p3TBfkZA+x06VFuRkO9fK4pmPhEWmvYSzh
 tfyA==
X-Gm-Message-State: AOJu0Yw4MaWGc3VNtEm+uouBgZsdVORze1hljQPRrHyqhYvdjCOXU3uP
 ebtgYxVRvmJ/34nFrCH8k1xgU+lkLM5fVEeE5YCDWVLSbBW6+7f/jqBrzuzMxBHCOZfm/WTv/Rn
 9
X-Google-Smtp-Source: AGHT+IEZsJRQ0rqYsCtulyUhfjP0POFZyJNiUkTH2+W3sQPRmq/PmjGCSeijrjjtCGnXqsliAU8SMQ==
X-Received: by 2002:a17:90a:ad92:b0:2ad:ec71:b7e5 with SMTP id
 98e67ed59e1d1-2b6ccd76dbemr20879152a91.33.1715977866004; 
 Fri, 17 May 2024 13:31:06 -0700 (PDT)
Received: from grind.. ([177.94.42.57]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b62863a126sm17979775a91.5.2024.05.17.13.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 13:31:05 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 alex.bennee@linaro.org, akihiko.odaki@daynix.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Robin Dapp <rdapp.gcc@gmail.com>
Subject: [PATCH v2 1/1] riscv,
 gdbstub.c: fix reg_width in ricsv_gen_dynamic_vector_feature()
Date: Fri, 17 May 2024 17:30:54 -0300
Message-ID: <20240517203054.880861-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240517203054.880861-1-dbarboza@ventanamicro.com>
References: <20240517203054.880861-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 33a24910ae changed 'reg_width' to use 'vlenb', i.e. vector length
in bytes, when in this context we want 'reg_width' as the length in
bits.

Fix 'reg_width' back to the value in bits like 7cb59921c05a
("target/riscv/gdbstub.c: use 'vlenb' instead of shifting 'vlen'") set
beforehand.

While we're at it, rename 'reg_width' to 'bitsize' to provide a bit more
clarity about what the variable represents. 'bitsize' is also used in
riscv_gen_dynamic_csr_feature() with the same purpose, i.e. as an input to
gdb_feature_builder_append_reg().

Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Reported-by: Robin Dapp <rdapp.gcc@gmail.com>
Fixes: 33a24910ae ("target/riscv: Use GDBFeature for dynamic XML")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/riscv/gdbstub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index d0cc5762c2..c07df972f1 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -288,7 +288,7 @@ static GDBFeature *riscv_gen_dynamic_csr_feature(CPUState *cs, int base_reg)
 static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-    int reg_width = cpu->cfg.vlenb;
+    int bitsize = cpu->cfg.vlenb << 3;
     GDBFeatureBuilder builder;
     int i;
 
@@ -298,7 +298,7 @@ static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
 
     /* First define types and totals in a whole VL */
     for (i = 0; i < ARRAY_SIZE(vec_lanes); i++) {
-        int count = reg_width / vec_lanes[i].size;
+        int count = bitsize / vec_lanes[i].size;
         gdb_feature_builder_append_tag(
             &builder, "<vector id=\"%s\" type=\"%s\" count=\"%d\"/>",
             vec_lanes[i].id, vec_lanes[i].gdb_type, count);
@@ -316,7 +316,7 @@ static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
     /* Define vector registers */
     for (i = 0; i < 32; i++) {
         gdb_feature_builder_append_reg(&builder, g_strdup_printf("v%d", i),
-                                       reg_width, i, "riscv_vector", "vector");
+                                       bitsize, i, "riscv_vector", "vector");
     }
 
     gdb_feature_builder_end(&builder);
-- 
2.44.0


