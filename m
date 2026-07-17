Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B85AC44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkrty-0001bK-Vt; Fri, 17 Jul 2026 19:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtu-0001Y6-4o
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:26 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrts-00070S-Gc
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:25 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so7821279a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 16:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784330603; x=1784935403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w27FmDXuFalab8HQ6vxOQFZ2EK3lrOZoQbI54mzAq/A=;
 b=mUDP58AIIi+9DdvqcfsIHB53V46mXMV/DnLiUSGK3wEH5Y15BqBtiHvGR7GwB7HHai
 vaMJHXOM9rYFyONLnf2xutqrR/AxG4iBuF+EIkYXlnHGhnPizIkZr+UZgqBBSgtB3dL1
 ghsn9V1IVZa7rE0LbPaQqDRXPKrJHp0bMKH388ykZjFDGbIaTaragPmiGkYl23ufu8pr
 Mu9kNUT1mulwI9ouRZpLTP+XEV1A+m6JJQD5bT31dPr2yOWLMyhjdizFGlfjRjCUE23z
 cNjSeu/ugWzqN0Ot5Mogs7JUf9SB40q8urU3+zoFxx0Hyqw5HcgezLYehynmPbpbePGM
 AZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330603; x=1784935403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w27FmDXuFalab8HQ6vxOQFZ2EK3lrOZoQbI54mzAq/A=;
 b=P+qnxZfQAZO4vmHPXYX+q3qRyZXUHSRre+V6zOjWmdHczTUPPWDsNNcZl/dgaEj5c3
 w+DnBGMfTMYKGaEqNNKc60/+ZnzyVGmz+Y9qAjNHIaZDTYHZgok4/vVKqtLVTLtlX/Qp
 R+6TDcBWHCExSCCkAoldIqdCUaM9Fl1+S5OFRegv6ugPRlAhpwWJ69sc05EAce5bl1gs
 /LNfa/ABaE6IK5RUvrkW6yt4v6/tbQDiaBzLROta1qUprt0PcI3/muHHDVi5deYskp97
 JnwTuaPeqazrYcZ0x8gz/g5um1iUynAQpFE/uWc8Drn9b9ziKjEoCDNbQwqEwG8K+xVK
 Z1IQ==
X-Gm-Message-State: AOJu0YxLAd/yYC9JIOSV6255pHlcDU47sLqIaxFFS0JM7i6gVaKMIC4s
 zDJbsv8SCZB/HDvmexmerZEQzK1Qx+HxxczMi+F+cQIwsLN6PGEd9vgDPiXhYZq9VEqVk38XD2u
 M+gMo
X-Gm-Gg: AfdE7ckTw9Z1Xhvr4Ub2eL53ZBW+PFa/CJBmmfzHro/GLfqX0gGKNIY49M2ADWDga/t
 2Y6/77/efS9RZ3Rt9BwpiQgvBgyuHf7YJxK7oOJreOQZREom1Li+62SGZF8g+xlV5/YM1Au36w/
 mmURx2SxhRLTa2PNRNc27tT21FgJP6VTAabwDsr1EMTcCGZcTJL5WciIaHcF9L/kbUrrSEOxZcu
 Ewx96c/1tbvLOn83cjShB25sZBvqaE44AHX7v3Bq+yxGM9nro6xfAZ5rw6rRpWEZUPlmblOu5x9
 zx5aj2nC/uwy9+/VjtvwL56D9agWp9EXuu1by9oDtYQ9MpLD2mzNXoQ+rChdFiQAOAulYlrWBdV
 sAFXOXQtXZpFGwbm5V5KOq+dnRp2qoH1AgywDqlJfhM/6Hh5tVhWWJwrRgspR8+WqpkoMkWT3DC
 kJgZ2Xcwo=
X-Received: by 2002:a17:90b:3cce:b0:37f:db06:229c with SMTP id
 98e67ed59e1d1-38e4b534228mr5178982a91.22.1784330603069; 
 Fri, 17 Jul 2026 16:23:23 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a18a47sm8186261c88.8.2026.07.17.16.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 16:23:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 11/17] target/arm: Expand dczid_bs in DisasContext
Date: Fri, 17 Jul 2026 16:22:59 -0700
Message-ID: <20260717232306.378988-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717232306.378988-1-richard.henderson@linaro.org>
References: <20260717232306.378988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Store the true blocksize, not the encoding.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     | 4 ++--
 target/arm/tcg/translate-a64.c | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index a3d03159ad..bab91eea22 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -197,14 +197,14 @@ typedef struct DisasContext {
      *  < 0, set by the current instruction.
      */
     int8_t btype;
-    /* A copy of DCZID_EL0.BS. */
-    uint8_t dcz_blocksize;
     /* A copy of cpu->gm_blocksize. */
     uint8_t gm_blocksize;
     /* True if the current insn_start has been updated. */
     bool insn_start_updated;
     /* FPMR access exception EL or 0 if enabled. */
     uint8_t fpmr_el;
+    /* An expansion of DCZID_EL0.BS. */
+    int dcz_blocksize;
     /* Offset from VNCR_EL2 when FEAT_NV2 redirects this reg to memory */
     uint32_t nv2_redirect_offset;
 } DisasContext;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1780490065..3d838a4cc1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4752,7 +4752,6 @@ static bool trans_LD_single_repl(DisasContext *s, arg_LD_single_repl *a)
 static bool trans_STZGM(DisasContext *s, arg_ldst_tag *a)
 {
     TCGv_i64 addr, clean_addr, tcg_rt;
-    int size = 4 << s->dcz_blocksize;
 
     if (!dc_isar_feature(aa64_mte, s)) {
         return false;
@@ -4777,7 +4776,7 @@ static bool trans_STZGM(DisasContext *s, arg_ldst_tag *a)
      * except the alignment happens before the access.
      */
     clean_addr = clean_data_tbi(s, addr);
-    tcg_gen_andi_i64(clean_addr, clean_addr, -size);
+    tcg_gen_andi_i64(clean_addr, clean_addr, -s->dcz_blocksize);
     gen_helper_dc_zva(tcg_env, clean_addr);
     return true;
 }
@@ -11055,7 +11054,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
     dc->features = env->features;
-    dc->dcz_blocksize = get_dczid_bs(arm_cpu);
+    dc->dcz_blocksize = 4 << get_dczid_bs(arm_cpu);
     dc->gm_blocksize = arm_cpu->gm_blocksize;
 
 #ifdef CONFIG_USER_ONLY
-- 
2.43.0


