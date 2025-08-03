Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACA8C87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiNic-0007Cc-Nv; Sat, 02 Aug 2025 21:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNiZ-00079A-8k
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:40:55 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNiX-0004dn-Kp
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:40:54 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e8bbb605530so3745898276.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 18:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754185248; x=1754790048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQ2NY5MNWY3DD2jQgRH4HyQ6JAhqM6IdYiy31hojvJU=;
 b=GHmXIObopVqDpqd1pmTYZwwdsqobq9/xs20wnDMyMhJMFIpUfhua1kvf6a3jQxJhO/
 GvZaSVk3PClTnpEjtO+G7uBd5rPH1LgAGNNAUILv+fXDZV0wkJGw3rq9a58R2rnFkRty
 rUOZZKf7BOcKTc73O7FtEgoUBccVukyvRdwTTzyMnW2W2ogdK8cQoiSwA/XapfNtE9nv
 W2keeDC8RgwJOIMqvAY8ozRPAMX95H9uPEdJ8LSQomC0Ab7GD9yh4hhnNq0cf98Fx6Ef
 NvwEcD+g0wvDWS+RnZyYlNyw1GfY/nqDhYrhdqXy0RVueEPcjj9QGcbqtCQz57vqc8lB
 RwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754185248; x=1754790048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dQ2NY5MNWY3DD2jQgRH4HyQ6JAhqM6IdYiy31hojvJU=;
 b=GrNrpzzd+rzmSTzGSFvGzZusl/OZyhdudKR4HTi8wPKsdi2ovvfVFX0Ax2YRRaU87N
 thz0w78Xn2crPXCr1LFt0cFQxU3UHqeVGflMgKfy4AT/8JZFCaQhIxaX9k0IM/MrrBhF
 aeOfSTvXoI4Dfshq2ONMYyLdvtgLr0Q6qm6uvVC1MrnOeqnomY7SBogTiGBs7vRUMbJ3
 BvXD3lQBaH0RQQkHeFEjvxBjZYjuXuIhp3c6yzcyCMj/u/uzJls5vGjyDo0vght85oE7
 CuiVLYwxlyCVTjoftO3EJugs5QbPtaEIivF4Y+Kq3SiO5Q1MxCpKXOyFBJgYUSUAbBUp
 O8bQ==
X-Gm-Message-State: AOJu0YwGeLmazVSfy7oqy1ZW0iwf1mdNMte5ovaHneJ9iMduCVuFxs6s
 8zTtoHxBfb1VHzYw/aXe0mS1Q1UO6B2G6QvlrIOk2O6KpVO036FygvwVnqrJlJzDs4BoQXt2vvR
 qI+uJBWY=
X-Gm-Gg: ASbGncs5jAB5SSWI6ITSxS6SVf2K1iyCAiMNtGTp16NtCVnshKSRjJyDJ/Zdo9QefEx
 vm3pGAwXIACRsgnGKx5FUBZBdIIliY+vuQ/4PIr9qqZSYXK5zB867B5FsR8EPEgYAyJq11tIK6z
 R/dor5cphAorwU3woJ2RgevgMXsE6aJr0lJGlncTjgdtabOfFfMhfffgUQBUZRFGPhNmJJ9uvfs
 bWiN/Ca+FWq3gEyrYnzLAEAHa89qRPwWOnqGW8k8a3F6Qj4Yq8gVWbdqYYgklnl1/1ux1jyZ206
 hlhYASKl4hYZS/sjW9SKFEo0DwUP+afWPmh4FAEnwPytblCLIeymsbvWOQJaCbzRghJBi72OT1m
 OzAtcwfqBhq6Hy9cZVtlL2a8z5LeDNTdIDIgyiY4BRjmYHnFmj9Gj
X-Google-Smtp-Source: AGHT+IFB6HtqIOZj0AzUuqW2/j/WgOUS2B9X7s/hgiDOnqB77UAJad9k4gGv9KpkaonHJdlh9q+m9Q==
X-Received: by 2002:a05:690c:7107:b0:71a:730:12b9 with SMTP id
 00721157ae682-71b7ef60673mr61597507b3.13.1754185248268; 
 Sat, 02 Aug 2025 18:40:48 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a6031a1sm18753227b3.86.2025.08.02.18.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 18:40:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 05/11] target/arm: Implement CTZ, CNT, ABS
Date: Sun,  3 Aug 2025 11:40:13 +1000
Message-ID: <20250803014019.416797-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250803014019.416797-1-richard.henderson@linaro.org>
References: <20250803014019.416797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 31 +++++++++++++++++++++++++++++++
 target/arm/tcg/a64.decode      |  4 ++++
 2 files changed, 35 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 64a845d5fb..0c78d4bb79 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8304,6 +8304,37 @@ static void gen_cls32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
 TRANS(CLZ, gen_rr, a->rd, a->rn, a->sf ? gen_clz64 : gen_clz32)
 TRANS(CLS, gen_rr, a->rd, a->rn, a->sf ? tcg_gen_clrsb_i64 : gen_cls32)
 
+static void gen_ctz32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    TCGv_i32 t32 = tcg_temp_new_i32();
+
+    tcg_gen_extrl_i64_i32(t32, tcg_rn);
+    tcg_gen_ctzi_i32(t32, t32, 32);
+    tcg_gen_extu_i32_i64(tcg_rd, t32);
+}
+
+static void gen_ctz64(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    tcg_gen_ctzi_i64(tcg_rd, tcg_rn, 64);
+}
+
+static void gen_cnt32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    gen_wrap2_i32(tcg_rn, tcg_rn, tcg_gen_ctpop_i32);
+}
+
+static void gen_abs32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    gen_wrap2_i32(tcg_rn, tcg_rn, tcg_gen_abs_i32);
+}
+
+TRANS_FEAT(CTZ, aa64_cssc, gen_rr, a->rd, a->rn,
+           a->sf ? gen_ctz64 : gen_ctz32)
+TRANS_FEAT(CNT, aa64_cssc, gen_rr, a->rd, a->rn,
+           a->sf ? tcg_gen_ctpop_i64 : gen_cnt32)
+TRANS_FEAT(ABS, aa64_cssc, gen_rr, a->rd, a->rn,
+           a->sf ? tcg_gen_abs_i64 : gen_abs32)
+
 static bool gen_pacaut(DisasContext *s, arg_pacaut *a, NeonGenTwo64OpEnvFn fn)
 {
     TCGv_i64 tcg_rd, tcg_rn;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index a886b3ba4c..766c610c01 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -726,6 +726,10 @@ REV64           1 10 11010110 00000 000011 ..... .....  @rr
 CLZ             . 10 11010110 00000 000100 ..... .....  @rr_sf
 CLS             . 10 11010110 00000 000101 ..... .....  @rr_sf
 
+CTZ             . 10 11010110 00000 000110 ..... .....  @rr_sf
+CNT             . 10 11010110 00000 000111 ..... .....  @rr_sf
+ABS             . 10 11010110 00000 001000 ..... .....  @rr_sf
+
 &pacaut         rd rn z
 @pacaut         . .. ........ ..... .. z:1 ... rn:5 rd:5  &pacaut
 
-- 
2.43.0


