Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E167C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuM1-0005xr-TQ; Wed, 05 Jun 2024 13:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM0-0005xE-MN
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:16 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLy-0003rT-BX
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:16 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-6c4f3e0e407so22133a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608193; x=1718212993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wig9V+JSk/GjardrNp7xbhIFWmF6FqSzEEMhgBWz718=;
 b=RlUB40KxwmsoovWDpV0zKzgIwH0CoQGiupV73W1EZqoLD3oJ2N59F/AYAZsRA4PX5k
 attpIEyHe5fvRmNnCBJbFQUnnQ+ZqoRpTGBOkZJ4EIyJTH39FWw2WclRrbFp4uz0yRF+
 nJ6eiXaI9v6nAPn+lMqyKbebIMTbe/Q69U1VhHY1N2vJXJELDWGy//SFQZSvFQFy0EZp
 1SgHB+jTNWvraDVplvvM9msuWFdu2Sc++pN3Xa3WhUVWbe2x6X4QQKLevvFSJe4+zJbQ
 iV/jppXvKbW6vMd0rBxQxoyZFOEwE/txpxmymdWqXTeJFzCDdRfuXRPkPYEqdYKyEQWh
 KT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608193; x=1718212993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wig9V+JSk/GjardrNp7xbhIFWmF6FqSzEEMhgBWz718=;
 b=pbyzcCnwwzvOc2Tkqs+y8oS4oymo+yEpFCDV+3PXcN7ycFU1jurl+Gc/lKapP8cvj3
 aU0WcuJlx5xSHGArjp/Ec6bIW/mRrdoNxh/XRyXZGDeA53MEky7aGQWHSe2BaG/JHAwd
 bLeqTsbNUpYAT4i9Wy9HUjW2wBoIL1TiEca04Nva2gyC2fL2I+fztMAnpZgB9w64odP1
 m0BiKr8MfMI4x80N1njljfNwsZG0TDausJqCgZFFwgOi1fNQAciEJuC5ZuZN4PdZkq0M
 xIt3wsIViyhnjDnsU4xKX2F5X8RXKazhsSyMsx7giKhKNvmD2Q2jV3Q58y4JSMKYjARw
 YtEQ==
X-Gm-Message-State: AOJu0YxxYA6bcU2ds3QrtUYrCpk67s0sgCs9DVyfsmoFXx0RJoZi2ICY
 9oletKA8eb3aIC4dmGXPdpwtYyf5HaqqlLQtuMfvpAy0CJTKefycmtHpqnsjCX2vBUpK3az0D9b
 U
X-Google-Smtp-Source: AGHT+IFB7RGNllr5tAr0eKn3gMrE+4SQFfEoCaKkUKsn4CYGOEC9AzmPXr3+DnJjU+fqiV918fMdAA==
X-Received: by 2002:a17:90b:60c:b0:2bf:9355:bfbc with SMTP id
 98e67ed59e1d1-2c27dafce71mr2839848a91.3.1717608192885; 
 Wed, 05 Jun 2024 10:23:12 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/38] target/sparc: Implement FPADDS, FPSUBS
Date: Wed,  5 Jun 2024 10:22:34 -0700
Message-Id: <20240605172253.356302-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
index 48cab59c07..7a5e8e0a9a 100644
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
@@ -4875,6 +4952,11 @@ TRANS(FPSUB32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sub)
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


