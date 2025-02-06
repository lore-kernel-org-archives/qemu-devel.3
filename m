Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C657C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80Y-0007RS-91; Thu, 06 Feb 2025 14:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80D-0007E1-Sj
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:33 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80C-0000X1-6e
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:33 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f9c69aefdbso2645952a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871850; x=1739476650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nEPeXRYzzj0xJOq25EhVbIb2paARNmPIuoc84/gBhk=;
 b=Y4W8nso47WX2KnPd+I+AKpUCsCZRIsdnUOBb2TPs7aeduh+XiIXZJ5E3KpwdkTOOW/
 YH3ffSiQKARMuClPm0x0o3lDI+yo5B1vu7Y2pLGUv13pOwaFKpDeIYzRGb4GfvcuzjpY
 xlHoSR9zVMsW4+ivRlSIEeFtWlV9of17amSYsoFr+Ef8R2kKOSMMaahwhlywRhLHb1XX
 18vM3gx5nL4ItAYa0OB8CAl0k9dhtqVhzbamDvQFJC1O16H7wzjb/6kjV2LfW+BSPvM2
 Y39XQ7lO52K2BIaTVp3bXlc0K6qh0xUBOnlT4Jw4iYD3vCOb3Pj6gtN4Vd7EUQ6kOE3q
 uTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871850; x=1739476650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nEPeXRYzzj0xJOq25EhVbIb2paARNmPIuoc84/gBhk=;
 b=KQkBo8h0q7TQurtEvIqc2HznBfR88zi6L1mHK2Cb87q1M8OAHAXw64k+irWW4p39h9
 gCJ7Im2UFSyIMJr1eMeN7AvWLr2/6BwGzqUwAcJK1qThATQRWIoBlsjkZ70jUCTq+Pjj
 tRt2+5oCGL0cGiX1ZxcGEdh7aaB46rzUF5w2HoqHGSMo2siU1h2EKj4psNUn2/vF6L4d
 S6jWZYMlMbT/x3leyi8NMqN89GiNwlxYgC3Pdyj2WE1mqyFMwT9WJS3+9/Y8Am0k82+l
 TgvdxDTxBNtnlrxZkaitOm3kIliNNfPxcxLCcl+aZtgKx04HYv8j1B8yBNwLR+8KZu9s
 FGvA==
X-Gm-Message-State: AOJu0YxJkXOKFFd/kDMJLmJWwWDKyutewDifrpJ2LI4F125dtjuJHPXa
 kWrM5GaxgcYm77LdXbon5EhCDxbLUK0AfBAaJg/yILcSdlPCO2D1MD6y5VTtH0DfiMh7aGh73JQ
 e
X-Gm-Gg: ASbGnctVCWRm9Ghe1PADoiQA5hfr7rHa7oTLfcSO5KFW4xMLTzMDWZ+Wh/mU49ezYQP
 0By4V6F2lQ+5p4syBJSJQc6Fn+h4YIky0BzPdgPzADq5gpTEcqLxudQap93ZGHisek8DdjEt/95
 fNVvwWxf6wsf8kyf9+zU+Pg+TX1fq0SxHfnqZMyqgHmobkY7KE4tYBdp+Nir5s8Jte+rfN0ueXh
 Rot8U9wu5/nUy8818ZWLSbZuBJMTDw+YysMkI6jsYoGKqtza/SaiWMER9l0xBRoFw/un8HlHPyB
 1apWvCWMR4KWc3MShkGi/O0QHw79mD3dqP9izP1UpiQVqDQ=
X-Google-Smtp-Source: AGHT+IF1CwIAEtAGqOzqQ3GIdM5GHEMwdJzV/7ixN2W/whKX8RG6dm7O0ssaL9d117Hg/h3r8ClvEA==
X-Received: by 2002:a05:6a00:3ccb:b0:72d:8d98:c250 with SMTP id
 d2e1a72fcca58-7305d43aa90mr916967b3a.4.1738871850580; 
 Thu, 06 Feb 2025 11:57:30 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 19/61] target/arm: Rename MOVA for translate
Date: Thu,  6 Feb 2025 11:56:33 -0800
Message-ID: <20250206195715.2150758-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Prepare for more kinds of MOVA from SME2 by renaming the
existing SME1 MOVA to indicate tile to/from vector.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 12 +++++-----
 target/arm/tcg/sme.decode      | 42 +++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index bd6095ffb6..908c3e8dd6 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -151,7 +151,7 @@ static bool trans_ZERO_zt0(DisasContext *s, arg_ZERO_zt0 *a)
     return true;
 }
 
-static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
+static bool do_mova_tile(DisasContext *s, arg_mova_p *a, bool to_vec)
 {
     static gen_helper_gvec_4 * const h_fns[5] = {
         gen_helper_sve_sel_zpzz_b, gen_helper_sve_sel_zpzz_h,
@@ -173,9 +173,6 @@ static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
     TCGv_i32 t_desc;
     int svl;
 
-    if (!dc_isar_feature(aa64_sme, s)) {
-        return false;
-    }
     if (!sme_smza_enabled_check(s)) {
         return true;
     }
@@ -189,14 +186,14 @@ static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
 
     if (a->v) {
         /* Vertical slice -- use sme mova helpers. */
-        if (a->to_vec) {
+        if (to_vec) {
             zc_fns[a->esz](t_zr, t_za, t_pg, t_desc);
         } else {
             cz_fns[a->esz](t_za, t_zr, t_pg, t_desc);
         }
     } else {
         /* Horizontal slice -- reuse sve sel helpers. */
-        if (a->to_vec) {
+        if (to_vec) {
             h_fns[a->esz](t_zr, t_za, t_zr, t_pg, t_desc);
         } else {
             h_fns[a->esz](t_za, t_zr, t_za, t_pg, t_desc);
@@ -205,6 +202,9 @@ static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
     return true;
 }
 
+TRANS_FEAT(MOVA_tz, aa64_sme, do_mova_tile, a, false)
+TRANS_FEAT(MOVA_zt, aa64_sme, do_mova_tile, a, true)
+
 static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
                     void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index efe369e079..459b96805f 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -27,29 +27,29 @@ ZERO_zt0        11000000 01 001 00000000000 00000001
 ### SME Move into/from Array
 
 %mova_rs        13:2 !function=plus_12
-&mova           esz rs pg zr za off v:bool to_vec:bool
+&mova_p         esz rs pg zr za off v:bool
 
-MOVA            11000000 00 00000 0 v:1 .. pg:3 zr:5 0 off:4  \
-                &mova to_vec=0 rs=%mova_rs esz=0 za=0
-MOVA            11000000 01 00000 0 v:1 .. pg:3 zr:5 0 za:1 off:3  \
-                &mova to_vec=0 rs=%mova_rs esz=1
-MOVA            11000000 10 00000 0 v:1 .. pg:3 zr:5 0 za:2 off:2  \
-                &mova to_vec=0 rs=%mova_rs esz=2
-MOVA            11000000 11 00000 0 v:1 .. pg:3 zr:5 0 za:3 off:1  \
-                &mova to_vec=0 rs=%mova_rs esz=3
-MOVA            11000000 11 00000 1 v:1 .. pg:3 zr:5 0 za:4  \
-                &mova to_vec=0 rs=%mova_rs esz=4 off=0
+MOVA_tz         11000000 00 00000 0 v:1 .. pg:3 zr:5 0 off:4  \
+                &mova_p rs=%mova_rs esz=0 za=0
+MOVA_tz         11000000 01 00000 0 v:1 .. pg:3 zr:5 0 za:1 off:3  \
+                &mova_p rs=%mova_rs esz=1
+MOVA_tz         11000000 10 00000 0 v:1 .. pg:3 zr:5 0 za:2 off:2  \
+                &mova_p rs=%mova_rs esz=2
+MOVA_tz         11000000 11 00000 0 v:1 .. pg:3 zr:5 0 za:3 off:1  \
+                &mova_p rs=%mova_rs esz=3
+MOVA_tz         11000000 11 00000 1 v:1 .. pg:3 zr:5 0 za:4  \
+                &mova_p rs=%mova_rs esz=4 off=0
 
-MOVA            11000000 00 00001 0 v:1 .. pg:3 0 off:4      zr:5  \
-                &mova to_vec=1 rs=%mova_rs esz=0 za=0
-MOVA            11000000 01 00001 0 v:1 .. pg:3 0 za:1 off:3 zr:5  \
-                &mova to_vec=1 rs=%mova_rs esz=1
-MOVA            11000000 10 00001 0 v:1 .. pg:3 0 za:2 off:2 zr:5  \
-                &mova to_vec=1 rs=%mova_rs esz=2
-MOVA            11000000 11 00001 0 v:1 .. pg:3 0 za:3 off:1 zr:5  \
-                &mova to_vec=1 rs=%mova_rs esz=3
-MOVA            11000000 11 00001 1 v:1 .. pg:3 0 za:4       zr:5  \
-                &mova to_vec=1 rs=%mova_rs esz=4 off=0
+MOVA_zt         11000000 00 00001 0 v:1 .. pg:3 0 off:4      zr:5  \
+                &mova_p rs=%mova_rs esz=0 za=0
+MOVA_zt         11000000 01 00001 0 v:1 .. pg:3 0 za:1 off:3 zr:5  \
+                &mova_p rs=%mova_rs esz=1
+MOVA_zt         11000000 10 00001 0 v:1 .. pg:3 0 za:2 off:2 zr:5  \
+                &mova_p rs=%mova_rs esz=2
+MOVA_zt         11000000 11 00001 0 v:1 .. pg:3 0 za:3 off:1 zr:5  \
+                &mova_p rs=%mova_rs esz=3
+MOVA_zt         11000000 11 00001 1 v:1 .. pg:3 0 za:4       zr:5  \
+                &mova_p rs=%mova_rs esz=4 off=0
 
 ### SME Move into/from ZT0
 
-- 
2.43.0


