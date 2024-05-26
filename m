Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30124C25B7C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJly-0008J7-6J; Sun, 26 May 2024 15:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlx-0008Gj-7E
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:13 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlv-0007gD-Du
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:12 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f47eb2354bso4548975ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752590; x=1717357390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tu6yQEQBR18L/HY9DIyBjoitjwBM2uyyfdz2hROsZN8=;
 b=IXHPtpeb60sX68FIHSLuel1Te04gdeihAKjjcxGKtd/S6Su3T7GJZF/rYQVuyBlnTS
 XVFmvEkuQFqpmtYPAbaHjG0W1AwN35SuWdA3El+GdCSDSrdyR4sxsxivfMt1LjU0n7DC
 GMuGhGhwVMJBkloWdGiZGTfNSJ9UEjqRY8a/dofHUTVyXoqrTEBl6SlhN19XhmaMPPEW
 hm35NO2L1hg4OijGvvWy1BUOrPC4gM1wphvI87BikKQHlM3/bT5sIl9p/FdfoCcnPmwl
 z07kd70Xblc8WAFZ3kWh2MJKHlMjH3EV7NpVezqM4HDrXAZNEoQJt1EtvVprz5wUzj++
 zy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752590; x=1717357390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tu6yQEQBR18L/HY9DIyBjoitjwBM2uyyfdz2hROsZN8=;
 b=vcWc2/KPjqNjrEp04W/ndaPIu5G7Kf0LKa1DiMmzCv1bss7EbwnFci4X1iU1KntCXC
 Y6DeISx16Y49n/XZAUdWDGCnU4tpl0J9cqwVU4WREnvj7uweZBVbvzcHbP9d+ZHQxru8
 C30J0hJsri4nl/k6MzxyLSzqDJgf27D5EmFLUfsNt7ukhwwpwmebFQVC0gTTCJTqcpv8
 WbafHSSN8Yzmt0zFASpATJ1VjfU2sXYdD46aZrVzp78Q3I9sriexju6TTMytL5BrwD12
 VGZXOqqLLhMXhbYQX19WhA5T+tmpc0412HSzVOGAznB85dnEiST4qRhPwx1H1WwBTgno
 oOYw==
X-Gm-Message-State: AOJu0Yyfg3FqCx3wegWJbKL9UzsFVZNSMMGldBvFoGomTc3N/j/HTk4Z
 amqgpaZiPWagLqRz31V0rqAYcIjnuP9cjdznCUvkuB4h3Uo+VSjUqD1FxzcxLW54paJXBFCo3Xm
 K
X-Google-Smtp-Source: AGHT+IHO94Q86cFcOw3nDIcYCco3Ar3+ZuWMZvvMvkUArVTpxdBSEA7xY1bPkMaYMKMCk0h1XzIc7Q==
X-Received: by 2002:a17:902:ce91:b0:1f4:8190:33c0 with SMTP id
 d9443c01a7336-1f48190383dmr30549555ad.11.1716752590065; 
 Sun, 26 May 2024 12:43:10 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 18/37] target/sparc: Implement FPADDS, FPSUBS
Date: Sun, 26 May 2024 12:42:35 -0700
Message-Id: <20240526194254.459395-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  9 +++++
 target/sparc/translate.c  | 82 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 70ca41a69a..b6553362eb 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -448,6 +448,15 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPSUB32s    10 ..... 110110 ..... 0 0101 0111 .....    @r_r_r
     FPSUB64     10 ..... 110110 ..... 0 0100 0110 .....    @d_d_d
 
+    FPADDS16    10 ..... 110110 ..... 0 0101 1000 .....    @d_d_d
+    FPADDS16s   10 ..... 110110 ..... 0 0101 1001 .....    @r_r_r
+    FPADDS32    10 ..... 110110 ..... 0 0101 1010 .....    @d_d_d
+    FPADDS32s   10 ..... 110110 ..... 0 0101 1011 .....    @r_r_r
+    FPSUBS16    10 ..... 110110 ..... 0 0101 1100 .....    @d_d_d
+    FPSUBS16s   10 ..... 110110 ..... 0 0101 1101 .....    @r_r_r
+    FPSUBS32    10 ..... 110110 ..... 0 0101 1110 .....    @d_d_d
+    FPSUBS32s   10 ..... 110110 ..... 0 0101 1111 .....    @r_r_r
+
     FNORd       10 ..... 110110 ..... 0 0110 0010 .....    @d_d_d
     FNORs       10 ..... 110110 ..... 0 0110 0011 .....    @r_r_r
     FANDNOTd    10 ..... 110110 ..... 0 0110 0100 .....    @d_d_d   # FANDNOT2d
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 52b9590b4b..b9e932496e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -698,6 +698,78 @@ static void gen_op_fpack32(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
 #endif
 }
 
+static void gen_op_fpadds16s(TCGv_i32 d, TCGv_i32 src1, TCGv_i32 src2)
+{
+    TCGv_i32 t[2];
+
+    for (int i = 0; i < 2; i++) {
+        TCGv_i32 u = tcg_temp_new_i32();
+        TCGv_i32 v = tcg_temp_new_i32();
+
+        tcg_gen_sextract_i32(u, src1, i * 16, 16);
+        tcg_gen_sextract_i32(v, src2, i * 16, 16);
+        tcg_gen_add_i32(u, u, v);
+        tcg_gen_smax_i32(u, u, tcg_constant_i32(INT16_MIN));
+        tcg_gen_smin_i32(u, u, tcg_constant_i32(INT16_MAX));
+        t[i] = u;
+    }
+    tcg_gen_deposit_i32(d, t[0], t[1], 16, 16);
+}
+
+static void gen_op_fpsubs16s(TCGv_i32 d, TCGv_i32 src1, TCGv_i32 src2)
+{
+    TCGv_i32 t[2];
+
+    for (int i = 0; i < 2; i++) {
+        TCGv_i32 u = tcg_temp_new_i32();
+        TCGv_i32 v = tcg_temp_new_i32();
+
+        tcg_gen_sextract_i32(u, src1, i * 16, 16);
+        tcg_gen_sextract_i32(v, src2, i * 16, 16);
+        tcg_gen_sub_i32(u, u, v);
+        tcg_gen_smax_i32(u, u, tcg_constant_i32(INT16_MIN));
+        tcg_gen_smin_i32(u, u, tcg_constant_i32(INT16_MAX));
+        t[i] = u;
+    }
+    tcg_gen_deposit_i32(d, t[0], t[1], 16, 16);
+}
+
+static void gen_op_fpadds32s(TCGv_i32 d, TCGv_i32 src1, TCGv_i32 src2)
+{
+    TCGv_i32 r = tcg_temp_new_i32();
+    TCGv_i32 t = tcg_temp_new_i32();
+    TCGv_i32 v = tcg_temp_new_i32();
+    TCGv_i32 z = tcg_constant_i32(0);
+
+    tcg_gen_add_i32(r, src1, src2);
+    tcg_gen_xor_i32(t, src1, src2);
+    tcg_gen_xor_i32(v, r, src2);
+    tcg_gen_andc_i32(v, v, t);
+
+    tcg_gen_setcond_i32(TCG_COND_GE, t, r, z);
+    tcg_gen_addi_i32(t, t, INT32_MAX);
+
+    tcg_gen_movcond_i32(TCG_COND_LT, d, v, z, t, r);
+}
+
+static void gen_op_fpsubs32s(TCGv_i32 d, TCGv_i32 src1, TCGv_i32 src2)
+{
+    TCGv_i32 r = tcg_temp_new_i32();
+    TCGv_i32 t = tcg_temp_new_i32();
+    TCGv_i32 v = tcg_temp_new_i32();
+    TCGv_i32 z = tcg_constant_i32(0);
+
+    tcg_gen_sub_i32(r, src1, src2);
+    tcg_gen_xor_i32(t, src1, src2);
+    tcg_gen_xor_i32(v, r, src1);
+    tcg_gen_and_i32(v, v, t);
+
+    tcg_gen_setcond_i32(TCG_COND_GE, t, r, z);
+    tcg_gen_addi_i32(t, t, INT32_MAX);
+
+    tcg_gen_movcond_i32(TCG_COND_LT, d, v, z, t, r);
+}
+
 static void gen_op_faligndata(TCGv_i64 dst, TCGv_i64 s1, TCGv_i64 s2)
 {
 #ifdef TARGET_SPARC64
@@ -4788,6 +4860,11 @@ TRANS(FHADDs, VIS3, do_fff, a, gen_op_fhadds)
 TRANS(FHSUBs, VIS3, do_fff, a, gen_op_fhsubs)
 TRANS(FNHADDs, VIS3, do_fff, a, gen_op_fnhadds)
 
+TRANS(FPADDS16s, VIS3, do_fff, a, gen_op_fpadds16s)
+TRANS(FPSUBS16s, VIS3, do_fff, a, gen_op_fpsubs16s)
+TRANS(FPADDS32s, VIS3, do_fff, a, gen_op_fpadds32s)
+TRANS(FPSUBS32s, VIS3, do_fff, a, gen_op_fpsubs32s)
+
 static bool do_env_fff(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32))
 {
@@ -4871,6 +4948,11 @@ TRANS(FPSUB32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sub)
 TRANS(FCHKSM16, VIS3, do_gvec_ddd, a, MO_16, gen_op_fchksm16)
 TRANS(FMEAN16, VIS3, do_gvec_ddd, a, MO_16, gen_op_fmean16)
 
+TRANS(FPADDS16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_ssadd)
+TRANS(FPADDS32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_ssadd)
+TRANS(FPSUBS16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sssub)
+TRANS(FPSUBS32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sssub)
+
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
-- 
2.34.1


