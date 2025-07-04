Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BC5C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeMm-0003bT-Ib; Fri, 04 Jul 2025 07:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMK-0002oc-La
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:38 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMD-0003hX-6J
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:33 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-234c5b57557so8811225ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627607; x=1752232407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNwvyAn7RyjFpGw6JKkmxkBSLazntAxbNaqKwuNDhZs=;
 b=exnGgfmh9Jqj10IxRBw5cA6r3cTGbc5zUgHS1kzDWTsCZjbG4GJcbADeldZ7UXv98t
 xFzn8msDX80w0v6AolOg6mqMF4QTAjt5I5PqkWhdTs/X+vixHwxKlq3cRtbIvNS7gbUU
 y/3/5mhO21ym3GkBRZVKOhYnnUXOdMc0ac5WzgEUGCdA7iU1lspJ/Ebc0ryQ2XZ0iBw3
 K28C5AEGxp/0yuregx24do61gaczDrvnXKJDzzXws5EDIm8H3Rjrr8y3a3GaRJYRyCBK
 h7vSVRJWWNmrsipoQvIy6DmGHwLFv8R18oaQiwMUmC5/DFrIqWKdxctAlME8Rshi65X7
 +u9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627607; x=1752232407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mNwvyAn7RyjFpGw6JKkmxkBSLazntAxbNaqKwuNDhZs=;
 b=vD7pUdtUXbelY9DkEEJUpYFU0/4ahvXCFiabcx+nXkibp7AltEsHsLXmgFd8JcbHa1
 Hr9TYYQ2xBG/lFmYhJr9xyGUV5TdPgndmR/fzGBSNcFX+OQT58Ng8THdxNeyTNjExql0
 R1ojLz1ceU6LluKW9CUJLZggueZdabk5khZCtVci2u4RCiM12JxId0WoNhSFDoMWHWyr
 Q4H6VGV6UEVu7NgRqxOC6/TnPzApfqHQIbQBbl+yDsbiPCvAbr/COZus+SKSJFwdmLbN
 UwN2NKxYpLajMWrOgiNTmF3/1+5tJJlWZEnkoJhO614UAxCttL3uXa9wJ6xjT3gh6nlX
 8gEQ==
X-Gm-Message-State: AOJu0Yz62Ru4eEHisWdbF8BQaW13dc7EQ+3P/Nw4OLa9ehA/dcOtC4KS
 ykn71vnGdRqBty9zu3lgVDxC8fZTv+V3zz8W6/6i7G763wbHyG2KxTrqNTI3Aw==
X-Gm-Gg: ASbGncuAZ4x+lb5MDwFPDSa81gJvSDBJRDy8MqUMxtnDsqrlqNiU4+NILgg/rYp1wor
 DwDWuzrt5NPZhFoDStQXDxSpZkKt6B2tFLR8cc/lqe8ffkSP5t7hXIzuQYl788y0eaW6irdsq/T
 dcVhUA0F3tFrnK0PWiWRuWnhzg8bnlcOUndiFWjTF4cni4g2A5lKrptqxQlWlNHTJNujDNG2uMI
 9ETOsblFj7UDcG2kIJ5rqW5rm1ay+3WICETcP1GygTq/DFBhZyfTA3s85tVqx5zSn2OjD3iT+/F
 pBFwF6ye8HCJi2ytiIOfHwIZu2NZ20wxrfaSEVsQ3S8MT42D2Jja8xk7ydSDqvWtiosEgh32bjB
 Md2tU2isncX9KzCUK7/hEEZK/mXao+ALOIOY3of7J44W62M0S6HFeQ04U1wJ5jdegF2I=
X-Google-Smtp-Source: AGHT+IEW5b2CKsmjAVSjWYEXNqTkbTuLPAY1OLnAOcGTTCo3jn8F9o1AsUf3CcXoGg5FhCZ1ozq8WQ==
X-Received: by 2002:a17:903:1b68:b0:235:27b6:a897 with SMTP id
 d9443c01a7336-23c85e9c18fmr38752395ad.34.1751627607371; 
 Fri, 04 Jul 2025 04:13:27 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Blanchard <antonb@tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/40] target/riscv: Fix fcvt.s.bf16 NaN box checking
Date: Fri,  4 Jul 2025 21:11:46 +1000
Message-ID: <20250704111207.591994-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Anton Blanchard <antonb@tenstorrent.com>

fcvt.s.bf16 uses the FP16 check_nanbox_h() which returns an FP16
quiet NaN. Add check_nanbox_bf16() which returns a BF16 quiet NaN.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250501114253.594887-1-antonb@tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/internals.h  | 16 ++++++++++++++++
 target/riscv/fpu_helper.c |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 4570bd50be..9686bb6208 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -142,6 +142,22 @@ static inline float16 check_nanbox_h(CPURISCVState *env, uint64_t f)
     }
 }
 
+static inline float16 check_nanbox_bf16(CPURISCVState *env, uint64_t f)
+{
+    /* Disable nanbox check when enable zfinx */
+    if (env_archcpu(env)->cfg.ext_zfinx) {
+        return (uint16_t)f;
+    }
+
+    uint64_t mask = MAKE_64BIT_MASK(16, 48);
+
+    if (likely((f & mask) == mask)) {
+        return (uint16_t)f;
+    } else {
+        return 0x7FC0u; /* default qnan */
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 /* Our implementation of SysemuCPUOps::has_work */
 bool riscv_cpu_has_work(CPUState *cs);
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 706bdfa61d..af40561b31 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -755,6 +755,6 @@ uint64_t helper_fcvt_bf16_s(CPURISCVState *env, uint64_t rs1)
 
 uint64_t helper_fcvt_s_bf16(CPURISCVState *env, uint64_t rs1)
 {
-    float16 frs1 = check_nanbox_h(env, rs1);
+    float16 frs1 = check_nanbox_bf16(env, rs1);
     return nanbox_s(env, bfloat16_to_float32(frs1, &env->fp_status));
 }
-- 
2.50.0


