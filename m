Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA07C25B7C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJm4-00006z-SM; Sun, 26 May 2024 15:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm1-0008TX-Fn
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:17 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlz-0007jL-To
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:17 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f44b441b08so18562635ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752594; x=1717357394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ugmNTqEcbc+4V4tkmecPzyQ/Hi7IU9jDHpaQmAFPBps=;
 b=gPG6HcUiZzeY2VItFIJeJR9bzwbvgD8lExH1Tq3OiehkdZz3CY8TWy+rKRekKC1af4
 iFFAZmPSxPemi1sG3CtPW5URxnflKpZ2ivlSeNDuF7xETBlg7tybqz0p5yisjHLrvwjQ
 ZNEBBFFlihHd3n6vmYfw8cbrkAtbdquhLpDk43XuHh1i65AHt/i0gyt1NyAzKE7EbJEW
 WWZormBS8aLHZFyusEnCvGdto7pf9q6yESEW+5ku9NaZOQwZAQfjEUigM2kA91uAnrjg
 TUcMIi6nF4aP4lZxDTOWRCMaMzeEHjpSs4fOg7n2ZQ8Up3pO6s7iK/EIzfZQqYTEzuoc
 v9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752594; x=1717357394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ugmNTqEcbc+4V4tkmecPzyQ/Hi7IU9jDHpaQmAFPBps=;
 b=B/Q1Pf4VtSAb2HQEq8RRnOJ4UTB2Slzv4zp0hLeSzw8DagZu1uNpgEQuTDExdlZ0Jc
 SkWbyqdMeRznZ35I/l+bxE17v+/CefzVBM8pSu7ilYdLJBbyPWazAWs7XIk0RAlM3M1L
 ptyGK0pUUUiohmhntuwqTRQ8VQk/qHfBsvDHUFEv2fI1M6iz6xTlqm7ffDpu2f/7aRdp
 DVJRPRBvVeOPmOunFdq7MiARMyjsRvfMwOY16eivc26v6xak57FzciAnZJIUhKUQhEBR
 TqZIVp6q+Ru0vRC3R7nYi5vYoxwljc2oxi/k8/gzelixrpOV+5Ay4zYKm23APXIxsax+
 bgnw==
X-Gm-Message-State: AOJu0YzLPxSzQrJLlVaPMVhJy5JSxhzzTlX/oKLDntsI+tUt0WVfuHWa
 8slvlXTLv4fMI4zDxtkx5fc9NQWLCIXLS3ViFQ68FgK73CYqCmm3H5ERQth3ZxOvMA+la3Snzf+
 w
X-Google-Smtp-Source: AGHT+IEdoc0n0tMwiCObK2mnp6D6kNTbqLIMacC/HgwVSuHEPtK62hPqP6MxS2jhbH+wAKU/qNi1Zg==
X-Received: by 2002:a17:903:2451:b0:1f3:c58:f4ea with SMTP id
 d9443c01a7336-1f448940177mr90264325ad.32.1716752594526; 
 Sun, 26 May 2024 12:43:14 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 24/37] target/sparc: Implement PDISTN
Date: Sun, 26 May 2024 12:42:41 -0700
Message-Id: <20240526194254.459395-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index e0e9248982..09c8adca37 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -435,6 +435,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPACKFIX    10 ..... 110110 00000 0 0011 1101 .....    @r_d2
     PDIST       10 ..... 110110 ..... 0 0011 1110 .....    \
                 &r_r_r_r rd=%dfp_rd rs1=%dfp_rd rs2=%dfp_rs1 rs3=%dfp_rs2
+    PDISTN      10 ..... 110110 ..... 0 0011 1111 .....    @r_d_d
 
     FMEAN16     10 ..... 110110 ..... 0 0100 0000 .....    @d_d_d
     FCHKSM16    10 ..... 110110 ..... 0 0100 0100 .....    @d_d_d
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d8707326ff..313adcd95b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -817,6 +817,15 @@ static void gen_op_bshuffle(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
 #endif
 }
 
+static void gen_op_pdistn(TCGv dst, TCGv_i64 src1, TCGv_i64 src2)
+{
+#ifdef TARGET_SPARC64
+    gen_helper_pdist(dst, tcg_constant_i64(0), src1, src2);
+#else
+    g_assert_not_reached();
+#endif
+}
+
 static void gen_op_fmul8x16al(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
 {
     tcg_gen_ext16s_i32(src2, src2);
@@ -5066,6 +5075,8 @@ TRANS(FPCMPNE8, VIS3B, do_rdd, a, gen_helper_fcmpne8)
 TRANS(FPCMPULE8, VIS3B, do_rdd, a, gen_helper_fcmpule8)
 TRANS(FPCMPUGT8, VIS3B, do_rdd, a, gen_helper_fcmpugt8)
 
+TRANS(PDISTN, VIS3, do_rdd, a, gen_op_pdistn)
+
 static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
 {
-- 
2.34.1


