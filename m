Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3C5C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHkD-00034s-73; Sat, 02 Mar 2024 00:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHk9-00033p-TA
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:05 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHk7-0007cR-M3
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:05 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-299a2456948so2260570a91.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356622; x=1709961422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dlp5CYvPYCSub/jJCvu97wQVLI30QsOi94QgEbRA200=;
 b=h12dAxCtqubTyIpMrzYp6dSpg/23UeHz0cNd868Znmp+zqeGbIohvFCpg6qvuG5QSs
 hQwrxMN4fqlIZWO4d2yMtabzPNbc2qsiIX9xHyIqWH1y1Sk9BNj5HwLTXn39/QTJFl+L
 ZCmiiMFJzZGyZtl2HdHF1cObnGuAg/u/L3ANWQ7Z+391w1pb4L1Lu1jYCk8XJ8fT4eek
 Q3s+iy5D+DEt0ywpreRWrsfFg8YNQm39E+bX2zPWj9dQ607HFDy2xePbinBuoB6DfDI5
 ZwdA5wPtMyWce5r4jBlRNhsPwdLc0wP9UNYJYbVzj7N/UDcDyZFoxULY5vbnqccHwKlF
 KHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356622; x=1709961422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dlp5CYvPYCSub/jJCvu97wQVLI30QsOi94QgEbRA200=;
 b=DINV+lKCjaUF2AqC/xfnY8Kk7y7s/d4tn4Puzno3/Di9xGaF92qU6dtC+kguozYkzp
 l8nCNWkywJm2EN6nCHGwhH0xxb0FHoeF/8kgc4VCgvWgTXDnaMqYwNXY/hltZCqCqLwh
 XZdKI4+rPD//tAX8UkbuAfSmwC0QUnURYswVcaqsy0CiK9Ialq5WsY16dR51FOgmXubb
 UKn76Cp/FHuTbTa+VqpSEwycAcoKlaK/+39CK8zbJFYUC7bvwu27OJz2zbaiWZVI4akr
 p1dPncOVkPD4KEXyilu8mJyI5gkgO4yDFq7g3dC3ow7CezWKS+upqcasY6nL7nwF0mPQ
 DJ9A==
X-Gm-Message-State: AOJu0Yy7XxLhVX43ip7Hd+GAw6W14Cv12Bw4fye1Xw8DBvCPg9IuB4QF
 R731odPunBWoyWlVTlbrukPHOcSMuWegcFKEjFD2o4M8aZX4vi2y4X7PQe9mUOsZFnk6BwQGYtp
 F
X-Google-Smtp-Source: AGHT+IHguig0Lrl83GdSY19lbMU1758x0NtMigdwOcDFke4SeHyh9MzEsNu0yQ87RmS3FCQCU6US3A==
X-Received: by 2002:a17:90a:f191:b0:29b:2a8:9a89 with SMTP id
 bv17-20020a17090af19100b0029b02a89a89mr3531879pjb.21.1709356622197; 
 Fri, 01 Mar 2024 21:17:02 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:17:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 37/41] target/sparc: Implement FPMIN, FPMAX
Date: Fri,  1 Mar 2024 19:15:57 -1000
Message-Id: <20240302051601.53649-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c  | 14 ++++++++++++++
 target/sparc/insns.decode | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5f1982cecc..8eda190233 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5053,6 +5053,20 @@ TRANS(FSRL32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_shrv)
 TRANS(FSRA16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sarv)
 TRANS(FSRA32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sarv)
 
+TRANS(FPMIN8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_smin)
+TRANS(FPMIN16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_smin)
+TRANS(FPMIN32, VIS4, do_gvec_ddd, a, MO_32, tcg_gen_gvec_smin)
+TRANS(FPMINU8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_umin)
+TRANS(FPMINU16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_umin)
+TRANS(FPMINU32, VIS4, do_gvec_ddd, a, MO_32, tcg_gen_gvec_umin)
+
+TRANS(FPMAX8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_smax)
+TRANS(FPMAX16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_smax)
+TRANS(FPMAX32, VIS4, do_gvec_ddd, a, MO_32, tcg_gen_gvec_smax)
+TRANS(FPMAXU8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_umax)
+TRANS(FPMAXU16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_umax)
+TRANS(FPMAXU32, VIS4, do_gvec_ddd, a, MO_32, tcg_gen_gvec_umax)
+
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 3ff8708304..b7b4bfe92c 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -524,6 +524,20 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPSUBUS8    10 ..... 110110 ..... 1 0101 0111 .....    @d_d_d
     FPSUBUS16   10 ..... 110110 ..... 1 0101 0011 .....    @d_d_d
 
+    FPMIN8      10 ..... 110110 ..... 1 0001 1010 .....    @d_d_d
+    FPMIN16     10 ..... 110110 ..... 1 0001 1011 .....    @d_d_d
+    FPMIN32     10 ..... 110110 ..... 1 0001 1100 .....    @d_d_d
+    FPMINU8     10 ..... 110110 ..... 1 0101 1010 .....    @d_d_d
+    FPMINU16    10 ..... 110110 ..... 1 0101 1011 .....    @d_d_d
+    FPMINU32    10 ..... 110110 ..... 1 0101 1100 .....    @d_d_d
+
+    FPMAX8      10 ..... 110110 ..... 1 0001 1101 .....    @d_d_d
+    FPMAX16     10 ..... 110110 ..... 1 0001 1110 .....    @d_d_d
+    FPMAX32     10 ..... 110110 ..... 1 0001 1111 .....    @d_d_d
+    FPMAXU8     10 ..... 110110 ..... 1 0101 1101 .....    @d_d_d
+    FPMAXU16    10 ..... 110110 ..... 1 0101 1110 .....    @d_d_d
+    FPMAXU32    10 ..... 110110 ..... 1 0101 1111 .....    @d_d_d
+
     FLCMPs      10 000 cc:2 110110 rs1:5 1 0101 0001 rs2:5
     FLCMPd      10 000 cc:2 110110 ..... 1 0101 0010 ..... \
                 rs1=%dfp_rs1 rs2=%dfp_rs2
-- 
2.34.1


