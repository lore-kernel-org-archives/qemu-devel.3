Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BACFC27C55
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuMC-0006A7-1J; Wed, 05 Jun 2024 13:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM9-00068w-AO
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:26 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM7-0003uI-Hy
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:25 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2bfdae7997aso47655a91.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608202; x=1718213002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6Tw07RKURuMHn62HByV4XZ15uQlAjPbwqL8CR7p8vI=;
 b=S/i9EBOKEsiUyRQ2wAmGCUaKbA1k5+4EGhS26cuIaQxq+cVofgT4vsyuHR8PxmN28W
 aP8uxfMdjQj/MOfVpy63izDkCkKRXEDiXUx6HL55l5+XgNQ5QFMvAdL55zzkQGF0k7xX
 Y779rZ1mr+RRan1o7D5gxHbZyhiMXPYfkMKUgzr0BXgLoLfOlHqcnShR/J23DBxXQMFh
 Eph1ZlPiWqhv6yO4Q+kGpDBKAZgiCBEoHu5Hg+ycQc55HG4CCqC72BigChSIr22H3C4x
 71/va4vUSJUhkR0Jf5LmBtQLJ75rSLdO+MYpjUJVlJnKRagSAJHtUkeQefcN7VZBe1ri
 SeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608202; x=1718213002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X6Tw07RKURuMHn62HByV4XZ15uQlAjPbwqL8CR7p8vI=;
 b=RnKyjBopJsejqra6gy705z8r5ENkgig1lQjpL3ds5t3pEqzQPnU3KUl1pAZtcQLFdy
 iDHrXyONfVd97YYzz5Egp8mN7MEFUG11jRAfmAr1VOlQ+TzWdyZ5DPIrYxwc7FZPR+Ih
 IV/mQ3m3cXqTXAdJ37+0XunjXuDTAx35aZgNtfrYFZ95HpXRWpjMbo9HbDFTJm0TU8HB
 +2E9phlaBAr9cdIPHQ0yPajuvb/Qhnlesa9Z3SibHF9Zh6flLyrMwSlKee6oYe07bv6R
 6kerk9YfgtzziV9gJnVSBv63jkZqXFUP4HeVSZRa9maYSd7tovwfnl4ZraJfKnVnspQP
 lSJg==
X-Gm-Message-State: AOJu0YzLNobtlBymr2gNRGyc2VjvtlBGhJRaUNC3x2AC54fZa96NDw40
 8Zigsgfjlfg7cZiYhGdGPd3OEK5wh4A+FMiF6/sMfRHKYwijp3Y514Y6NUKSJIuzt0K6Dwh083w
 M
X-Google-Smtp-Source: AGHT+IHy6GrZP0ZD3Ue7iPiQlTRFnf+qiMEF15TNQQ3WX8C12t+9FJL02Qvi19rvjxjD2m3ICKzB/w==
X-Received: by 2002:a17:90a:ab97:b0:2bd:dd7f:76a1 with SMTP id
 98e67ed59e1d1-2c27db581b1mr3298099a91.38.1717608202178; 
 Wed, 05 Jun 2024 10:23:22 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/38] target/sparc: Implement IMA extension
Date: Wed,  5 Jun 2024 10:22:44 -0700
Message-Id: <20240605172253.356302-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
 target/sparc/cpu-feature.h.inc |  1 +
 target/sparc/insns.decode      |  3 +++
 linux-user/elfload.c           |  1 +
 target/sparc/cpu.c             |  3 +++
 target/sparc/translate.c       | 24 ++++++++++++++++++++++++
 5 files changed, 32 insertions(+)

diff --git a/target/sparc/cpu-feature.h.inc b/target/sparc/cpu-feature.h.inc
index 3913fb4a54..e2e6de9144 100644
--- a/target/sparc/cpu-feature.h.inc
+++ b/target/sparc/cpu-feature.h.inc
@@ -14,3 +14,4 @@ FEATURE(POWERDOWN)
 FEATURE(CASA)
 FEATURE(FMAF)
 FEATURE(VIS3)
+FEATURE(IMA)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1d54de5367..5d85e124ed 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -525,6 +525,9 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FNMSUBd     10 ..... 110111 ..... ..... 1010 .....     @d_d_d_d
     FNMADDs     10 ..... 110111 ..... ..... 1101 .....     @r_r_r_r
     FNMADDd     10 ..... 110111 ..... ..... 1110 .....     @d_d_d_d
+
+    FPMADDX     10 ..... 110111 ..... ..... 0000 .....     @d_d_d_d
+    FPMADDXHI   10 ..... 110111 ..... ..... 0100 .....     @d_d_d_d
   ]
   NCP           10 ----- 110111 ----- --------- -----      # v8 CPop2
 }
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index cb79580431..0d4dc1f6d1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1005,6 +1005,7 @@ static uint32_t get_elf_hwcap(void)
     r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
     r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
     r |= features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
+    r |= features & CPU_FEATURE_IMA ? HWCAP_SPARC_IMA : 0;
 #endif
 
     return r;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 8ea977b49f..88da5254e8 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -551,6 +551,7 @@ static const char * const feature_name[] = {
     [CPU_FEATURE_BIT_VIS2] = "vis2",
     [CPU_FEATURE_BIT_FMAF] = "fmaf",
     [CPU_FEATURE_BIT_VIS3] = "vis3",
+    [CPU_FEATURE_BIT_IMA] = "ima",
 #else
     [CPU_FEATURE_BIT_MUL] = "mul",
     [CPU_FEATURE_BIT_DIV] = "div",
@@ -883,6 +884,8 @@ static Property sparc_cpu_properties[] = {
                     CPU_FEATURE_BIT_FMAF, false),
     DEFINE_PROP_BIT("vis3",     SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_VIS3, false),
+    DEFINE_PROP_BIT("ima",      SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_IMA, false),
 #else
     DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_MUL, false),
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 971e7dae80..640406570d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -589,6 +589,26 @@ static void gen_op_umulxhi(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_mulu2_tl(discard, dst, src1, src2);
 }
 
+static void gen_op_fpmaddx(TCGv_i64 dst, TCGv_i64 src1,
+                           TCGv_i64 src2, TCGv_i64 src3)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_mul_i64(t, src1, src2);
+    tcg_gen_add_i64(dst, src3, t);
+}
+
+static void gen_op_fpmaddxhi(TCGv_i64 dst, TCGv_i64 src1,
+                             TCGv_i64 src2, TCGv_i64 src3)
+{
+    TCGv_i64 l = tcg_temp_new_i64();
+    TCGv_i64 h = tcg_temp_new_i64();
+    TCGv_i64 z = tcg_constant_i64(0);
+
+    tcg_gen_mulu2_i64(l, h, src1, src2);
+    tcg_gen_add2_i64(l, dst, l, h, src3, z);
+}
+
 static void gen_op_sdiv(TCGv dst, TCGv src1, TCGv src2)
 {
 #ifdef TARGET_SPARC64
@@ -2405,6 +2425,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_FMAF(C)    ((C)->def->features & CPU_FEATURE_FMAF)
 # define avail_GL(C)      ((C)->def->features & CPU_FEATURE_GL)
 # define avail_HYPV(C)    ((C)->def->features & CPU_FEATURE_HYPV)
+# define avail_IMA(C)     ((C)->def->features & CPU_FEATURE_IMA)
 # define avail_VIS1(C)    ((C)->def->features & CPU_FEATURE_VIS1)
 # define avail_VIS2(C)    ((C)->def->features & CPU_FEATURE_VIS2)
 # define avail_VIS3(C)    ((C)->def->features & CPU_FEATURE_VIS3)
@@ -2420,6 +2441,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_FMAF(C)    false
 # define avail_GL(C)      false
 # define avail_HYPV(C)    false
+# define avail_IMA(C)     false
 # define avail_VIS1(C)    false
 # define avail_VIS2(C)    false
 # define avail_VIS3(C)    false
@@ -5202,6 +5224,8 @@ TRANS(FMADDd, FMAF, do_dddd, a, gen_op_fmaddd)
 TRANS(FMSUBd, FMAF, do_dddd, a, gen_op_fmsubd)
 TRANS(FNMSUBd, FMAF, do_dddd, a, gen_op_fnmsubd)
 TRANS(FNMADDd, FMAF, do_dddd, a, gen_op_fnmaddd)
+TRANS(FPMADDX, IMA, do_dddd, a, gen_op_fpmaddx)
+TRANS(FPMADDXHI, IMA, do_dddd, a, gen_op_fpmaddxhi)
 
 static bool do_env_qqq(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i128, TCGv_env, TCGv_i128, TCGv_i128))
-- 
2.34.1


